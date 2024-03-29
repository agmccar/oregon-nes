import pprint as pp
import textwrap
import re
import argparse

TEXTLINE_TILES = 4*6
PUNCT = {
    " ": 0, # "tells you:"
    "@": 1, # actually a comma
    ".": 2,
    "!": 3,
    "?": 4,
    "$": 5, # EOL / no punct
}
SUBSTR_LEN = 2
SPECIAL_CHAR = {
    "'": 26,
    "-": 27,
    '"': 28,
    ';': 29,
    ':': 30,
    '.': 31,
    '@': 32, # actually a comma
    '0': 33,
    '1': 34,
    '2': 35,
    '3': 36,
    '4': 37,
    '5': 38,
    '6': 39,
    '7': 40,
    '8': 41,
    '9': 42,
    '…': 43,
    '(': 44,
    ')': 45,
    '%': 46, # actually dollar sign
}

LITERAL_CHAR = 0xff-len(SPECIAL_CHAR)-26
for i in SPECIAL_CHAR:
    SPECIAL_CHAR[i] += LITERAL_CHAR
# LITERAL_CHAR = $d0 ; see src/constants.asm

SPECIAL_CHAR_ASM = {
    "'": "_AP",
    "-": "_HY",
    '"': "_QT",
    ';': "_SC",
    ':': "_CL",
    '.': "_PD",
    '@': "_CM", # actually a comma
    '…': "_EL",
    '(': "_OP",
    ')': "_CP",
    '%': "_DL", # actually dollar sign
}
HLENS = []

def verify_segment_header(segment, header):
    # segment example:
    #   "SOME FOLKS SEEM TO THINK THAT TWO 
    #    OXEN ARE ENOUGH TO GET THEM TO OREGON!"
    # header example:
    #   "$83,$45,$42,$54,$34,$36,$23,$42,$60"
    HLENS.append(header)
    header = header.split(',')
    hbyte = [i for i in header.pop(0).replace("$","")]
    hlen = int(hbyte[0], 16)
    punct = {v: k for k, v in PUNCT.items()}[int(hbyte[1], 16)]
    if len(header) != hlen:
        e = f"Header length ({len(header)}) does not match expected ({hlen})"
        e += f" (hbyte: {hbyte}; Header: {header}; Segment: {segment})"
        raise Exception(e)
    if punct != segment[-1]:
        e = f"Header punctuation ({punct}) does not match expected ({segment[-1]})"
        raise Exception(e)
    wlen = [int(i,16) for i in ''.join(header).replace('$','')]
    if wlen[-1] == 0:
        wlen = wlen[:-1]
    seglen = sum(wlen)+len(wlen)
    if seglen != len(segment):
        raise Exception(f"Bad headers: Reconstructed segment length ({seglen}) does not match original segment length ({len(segment)})")

def verify_segment(qraw, qbytes, substr_dict):
    debug = []
    try:
        debug.append(f"Dict: {str(substr_dict)}")
        debug.append(f"Expected: {qraw}")
        debug.append(f"Bytes: {str(qbytes)}")
        decoded = ""
        qbytes = qbytes.split(',')
        while len(qbytes):
            header = qbytes.pop(0)
            debug.append(f"Segment header: {header}")
            #debug.append(f"Remaining bytes: {qbytes}")
            hlen = int(header.replace('$','')[0],16)
            debug.append(f"Segment header length: {hlen}")
            punct = {v: k for k, v in PUNCT.items()}[int(header.replace('$','')[1],16)]
            debug.append(f"Punctuation: {punct}")
            wordlens = []
            for i in range(hlen):
                hbyte = qbytes.pop(0).replace('$','')
                wordlens.append(int(hbyte[0],16))
                wordlens.append(int(hbyte[1],16))
            if wordlens[-1] == 0:
                wordlens = wordlens[:-1]
            debug.append(f"Word lengths in this segment: {str(wordlens)}")
            save = ""
            while len(wordlens):
                wordlen = wordlens.pop(0)
                debug.append(f"Parsing word with length {wordlen}. ")
                usedbytes = []
                decoded += save
                word = save
                wordlen -= len(save)
                save = ""
                while wordlen > 0:
                    symbol = qbytes.pop(0)
                    usedbyte = symbol
                    symbol = int(symbol.replace('$',''),16)
                    if symbol in substr_dict:
                        wordlen -= 2
                        if wordlen < 0:
                            a = substr_dict[symbol][0]
                            decoded += a
                            word += a
                            save = substr_dict[symbol][1]
                        else:
                            a = substr_dict[symbol]
                            decoded += a
                            word += a
                            save = ""
                        usedbyte += f" ({substr_dict[symbol]})"
                    else:
                        wordlen -= 1
                        save = ""
                        if symbol in {v: k for k, v in SPECIAL_CHAR.items()}:
                            a = {v: k for k, v in SPECIAL_CHAR.items()}[symbol]
                            decoded += a
                            word += a
                            usedbyte += f" ({a})"
                        else:
                            a = chr(symbol-LITERAL_CHAR+ord('A'))
                            decoded += a
                            word += a
                            usedbyte += f" ({a})"
                    usedbytes.append(usedbyte)
                debug.append(f"Got word: {word}\t| Used bytes: {str(usedbytes)}\t| Saved: {save}")
                decoded += " "
            decoded = decoded[:-1]
            decoded += punct + " "
            debug.append(f"Decoded so far: {decoded}")
            #input()
        decoded = decoded[:-1]
    except:
        print('\n'.join(debug))
        raise Exception

    if decoded != qraw:
        print(f"[{decoded}]")
        print(f"[{qraw}]")
        raise Exception("Bad compression")
    return True

def most_common_substring(s):
    substrings = []
    for j in s:
        for i in range(len(j) - SUBSTR_LEN + 1):
            substrings.append(j[i:i+SUBSTR_LEN])
    a = {}
    for i in substrings:
        if i in a:
            a[i] += 1
        else:
            a[i] = 1
    try:
        if sorted(a.items(), key=lambda item: item[1], reverse=True)[0][1] > 1:
            return sorted(a.items(), key=lambda item: item[1], reverse=True)[0][0]
    except:
        pass
    return ''

def parse_raw_text(filename):
    with open(filename) as f:
        text = ''.join(f.readlines())
    talk_data = {}
    text = text.split("##")[1:]
    for section in text:
        # remove comments
        section = '\n'.join([line.strip() for line in section.split('\n') if not line.startswith('#')])
        a = section.split('\n\n')
        loc = a.pop(0).strip()
        if len(''.join([i.strip() for i in a])):
            talk_data[loc] = []
            for n in range(len(a)):
                if not len(a[n].strip()):
                    continue
                if 'talk' in filename:
                    speaker_raw = a[n].split(' tells you:\n')[0].strip()
                    quote_raw = a[n].split(' tells you:\n')[1].replace("\n"," ").strip()[1:-1]
                else:
                    speaker_raw = ''
                    quote_raw = a[n].replace("\n"," ").strip()
                talk_data[loc].append({
                    'speaker_raw': speaker_raw,
                    #'speaker_wrap': textwrap.wrap(speaker_raw+" tells you:", width=TEXTLINE_TILES),
                    'quote_raw': quote_raw,
                    #'quote_wrap': textwrap.wrap('"'+quote_raw+'"', width=TEXTLINE_TILES),
                })
    # pp.pprint(talk_data)
    # input()
    return talk_data

def compress_segment(segment, substr_dict):
    # Header bytes, list of "$XX" hex strings
    header_bytes = []

    # Punctuation nibble (first half of first header byte)
    header_bytes.append(f"{hex(PUNCT[segment[-1]])[2:]}")
    s = segment[:-1]

    # Word length header bytes
    wlen = [len(i) for i in s.split(' ')]
    wlen = ''.join([hex(i)[2:] for i in wlen])
    wlen = [wlen[i:i+2] for i in range(0,len(wlen),2)]
    if len(wlen[-1]) == 1:
        wlen[-1] = wlen[-1]+"0"
    for w in wlen:
        header_bytes.append(f"${hex(int(w,16))[2:]}")
         # todo Last one needs to be +1 to include punct (if not '$' EOL)?

    # Header length nibble (second half of first header byte)
    header_bytes[0] = f"${hex(len(header_bytes[1:]))[2:]}"+header_bytes[0]
    if len(hex(len(header_bytes[1:]))[2:]) > 1:
        raise Exception(f"Too many header bytes in segment: {segment}")

    # Verify header bytes
    header = ','.join(header_bytes)
    verify_segment_header(segment, header)
    
    # Compressed payload bytes, list of "$XX" hex strings
    data_bytes = []
    text = squish_segment(segment)
    for k in substr_dict:
        text = text.replace(substr_dict[k], f",${hex(k)[2:].rjust(2,'0')},")
    text = text.split(',')
    text = [j for j in text if len(j)]
    t = []
    for j in text:
        if '$' not in j:
            j = [k for k in j]
            t += j
        else:
            t.append(j)
    text = t
    t = []
    for j in text:
        if len(j) == 1:
            if j not in SPECIAL_CHAR:
                t.append(f"${hex(LITERAL_CHAR + ord(j) - ord('A'))[2:]}")
            else:
                t.append(f"${hex(SPECIAL_CHAR[j])[2:]}")
        else:
            t.append(j)
    data_bytes += t

    # Verify entire segment
    bytes_full = ",".join(header_bytes + data_bytes)
    verify_segment(segment, bytes_full, substr_dict)

    return bytes_full

def squish_segment(segment):
    # try:
    segment = segment[:-1] if segment[-1] in PUNCT else segment
    # except:
    #     print(segment)
    #     exit()
    return ''.join(segment.split(' ')).upper()

def speaker_segment(text):
    text += ' '
    return text.replace(',','@').upper()

def text_to_segments(text):
    segments = text.replace(',','@').upper()+' '
    for p in PUNCT:
        segments = segments.replace(f"{p} ",f"{p}#")
    return segments.split('#')[:-1]

def create_substr_dict(mass_text):
    substr_dict = {}
    for c in SPECIAL_CHAR:
        mass_text = mass_text.replace(c, '🐂')
    for i in range(1, LITERAL_CHAR):
        c = most_common_substring([x for x in mass_text.split('🐂') if len(x)>=2])
        substr_dict[i] = c
        if len(c):
            mass_text = mass_text.replace(c,'🐂')
    return {k:v for k,v in substr_dict.items() if len(v)}

def write_asm(filename, substr_dict, data=None, labelPrefix=None, pointer=False, writeData=True):
    bytes_before = 0
    bytes_after = 0
    s = [0 for i in range(256)]
    for i in substr_dict:
        s[i] = [j for j in substr_dict[i]]
        k = []
        for j in s[i]:
            if j in SPECIAL_CHAR_ASM:
                k.append(SPECIAL_CHAR_ASM[j])
            else:
                k.append(f"_{j}_")
        s[i] = ",".join(k)
    s = [i for i in s if i != 0]
    with open(filename,'w') as f:
        f.write(f"; First header byte:\n")
        f.write(f"; %00000000\n")
        p = {k.replace('@',','):v for k,v in PUNCT.items()}
        f.write(f";  ||||++++ Type of punctiation- {p}\n")
        f.write(f";  ++++---- Remaining length of header\n")
        f.write(f"\n; (2nd - nth) header bytes:\n; Every nibble is the length of a word.\n")
        f.write(f"; %00000000, %00000000,...\n")
        f.write(f";  ++++--------------- Length of first word\n")
        f.write(f";      ++++----------- Length of 2nd word\n")
        f.write(f";             ++++---- Length of 3rd word\n")
        f.write(f";                 ++++ Length of 4th word, etc.\n\n")
        f.write(f"; Data segment bytes:\n; $00      : End of entire section\n")
        f.write(f"; $01 - ${hex(LITERAL_CHAR-1)[2:]}: Dictionary\n")
        f.write(f"; ${hex(LITERAL_CHAR)[2:]} - ${hex(LITERAL_CHAR+26-1)[2:]}: Literal A-Z\n")
        f.write(f"; ${hex(LITERAL_CHAR+26)[2:]} - ${hex(LITERAL_CHAR+26+len(SPECIAL_CHAR)-1)[2:]}: Literal {''.join([i.replace('@',',') for i in SPECIAL_CHAR])}\n")
        f.write(f"; $ff: Unused\n")
        f.write(f"\n")
        if data == None:
            f.write(f"talkSpecialChar:\n")
            sc = [i for i in SPECIAL_CHAR]
            for i in range(len(sc)):
                if sc[i] in SPECIAL_CHAR_ASM:
                    sc[i] = SPECIAL_CHAR_ASM[sc[i]]
                else:
                    sc[i] = f"_{sc[i].replace('@',',')}_"
            f.write(f"    .byte {','.join(sc)}\n\n")
            f.write(f"talkTellsYou:\n")
            f.write(f"    .byte {','.join(['_'+i+'_' for i in 'TELLS_YOU'])},_CL\n\n")
            f.write(f"talkDictionary:\n")
            for i in s:
                f.write(f"    .byte {i}\n")
            f.write("\n")
            bytes_after += len(substr_dict)*2
        else:
            labels = []
            if labelPrefix:
                prefix = labelPrefix
            else:
                prefix = filename.split('/')[-1].split('.')[0]
            for loc in data:
                len_i = 3 if 'talk' in filename else 1
                for i in range(len_i):
                    label = f"{prefix}{loc.replace(' ','').replace('Crossing','')}"
                    if len_i>1:
                        label += f"{i+1}"
                    labels.append(label)
                    if writeData:
                        f.write(f"{label}:\n")
                        f.write(f"    ; {len(data[loc][i]['bytes'].split(','))} bytes\n")
                        #w = textwrap.wrap(data[loc][i]['bytes'].replace(',',', '),width=70)
                        w = data[loc][i]['quote_byte_segments']
                        for j in w:
                            j = j.replace(' ','')
                            if j[-1] == ',':
                                j = j[:-1]
                            f.write(f"    .byte {j}\n")
                        f.write("\n")
                        bytes_before += len(data[loc][i]['quote_raw'])+len(data[loc][i]['speaker_raw'])
                        bytes_after += len(data[loc][i]['bytes'].split(','))
            if pointer:
                f.write(f"{prefix}Pointer:\n")
                for label in labels:
                    f.write(f"    .byte <{label},>{label}\n")
    if bytes_before:
        0
        # if verbose: print(f"Text\n* bytes to pack: {bytes_before}")
        # if verbose: print(f"* Compressed size: {bytes_after}")
        # if verbose: print(f"* Saved {bytes_before-bytes_after} bytes (~{(bytes_before-bytes_after)/1024:.0f}K, {100*(bytes_before-bytes_after)/bytes_before:.0f}%)")

def main(args):
    verbose = args.verbose
    # DRY: Do Repeat Yourself!
    mass_text = ""

    talk_data = parse_raw_text('src/data/raw/text/talk.txt')
    for loc in talk_data:
        for i in range(len(talk_data[loc])):
            segments = text_to_segments(talk_data[loc][i]['quote_raw'])
            talk_data[loc][i]['quote_segments'] = segments
            for segment in segments:
                mass_text += squish_segment(segment)

    learn_data = parse_raw_text('src/data/raw/text/learn.txt')
    for loc in learn_data:
        for i in range(len(learn_data[loc])):
            segments = text_to_segments(learn_data[loc][i]['quote_raw'])
            learn_data[loc][i]['quote_segments'] = segments
            for segment in segments:
                mass_text += squish_segment(segment)

    top10_data = parse_raw_text('src/data/raw/text/top10.txt')
    for loc in top10_data:
        for i in range(len(top10_data[loc])):
            segments = text_to_segments(top10_data[loc][i]['quote_raw'])
            top10_data[loc][i]['quote_segments'] = segments
            for segment in segments:
                mass_text += squish_segment(segment)

    sound_data = parse_raw_text('src/data/raw/text/sound.txt')
    for loc in sound_data:
        for i in range(len(sound_data[loc])):
            segments = text_to_segments(sound_data[loc][i]['quote_raw'])
            sound_data[loc][i]['quote_segments'] = segments
            for segment in segments:
                mass_text += squish_segment(segment)

    newgame_data = parse_raw_text('src/data/raw/text/newgame.txt')
    for loc in newgame_data:
        for i in range(len(newgame_data[loc])):
            segments = text_to_segments(newgame_data[loc][i]['quote_raw'])
            newgame_data[loc][i]['quote_segments'] = segments
            for segment in segments:
                mass_text += squish_segment(segment)

    traveling_data = parse_raw_text('src/data/raw/text/traveling.txt')
    for loc in traveling_data:
        for i in range(len(traveling_data[loc])):
            segments = text_to_segments(traveling_data[loc][i]['quote_raw'])
            traveling_data[loc][i]['quote_segments'] = segments
            for segment in segments:
                mass_text += squish_segment(segment)

    river_data = parse_raw_text('src/data/raw/text/river.txt')
    for loc in river_data:
        for i in range(len(river_data[loc])):
            segments = text_to_segments(river_data[loc][i]['quote_raw'])
            river_data[loc][i]['quote_segments'] = segments
            for segment in segments:
                mass_text += squish_segment(segment)

    substr_dict = create_substr_dict(mass_text)
    write_asm('src/data/compressed/text/dictionary.asm',substr_dict)

    # 'talk' text
    for loc in talk_data:
        for i in range(len(talk_data[loc])):
            b = []
            segments = [speaker_segment(talk_data[loc][i]['speaker_raw'])]
            segments += text_to_segments(talk_data[loc][i]['quote_raw'])
            talk_data[loc][i]['quote_byte_segments'] = []
            for segment in segments:
                if args.verbose:
                    print(f"Compressing segment: {segment}")
                bs = compress_segment(segment, substr_dict)
                talk_data[loc][i]['quote_byte_segments'].append(bs)
                b.append(bs)
            talk_data[loc][i]['quote_byte_segments'].append("$00") # end of section
            b.append("$00") 
            talk_data[loc][i]['bytes'] = ",".join(b)
    write_asm('src/data/compressed/text/talkPointer.asm', substr_dict, data=talk_data, pointer=True, writeData=False, labelPrefix="talk")
    talk_dataA = {i:talk_data[i] for i in [j for j in talk_data][:5]}
    talk_dataB = {i:talk_data[i] for i in [j for j in talk_data][5:10]}
    talk_dataC = {i:talk_data[i] for i in [j for j in talk_data][10:15]}
    talk_dataD = {i:talk_data[i] for i in [j for j in talk_data][15:]}
    # talk_dataE = {i:talk_data[i] for i in [j for j in talk_data][16:]}
    write_asm('src/data/compressed/text/talkA.asm', substr_dict, data=talk_dataA, labelPrefix="talk")
    write_asm('src/data/compressed/text/talkB.asm', substr_dict, data=talk_dataB, labelPrefix="talk")
    write_asm('src/data/compressed/text/talkC.asm', substr_dict, data=talk_dataC, labelPrefix="talk")
    write_asm('src/data/compressed/text/talkD.asm', substr_dict, data=talk_dataD, labelPrefix="talk")
    #write_asm('src/data/compressed/text/talkE.asm', substr_dict, data=talk_dataE, labelPrefix="talk")

    # 'learn' text
    for page in learn_data:
        for i in range(len(learn_data[page])):
            b = []
            segments = text_to_segments(learn_data[page][i]['quote_raw'])
            learn_data[page][i]['quote_byte_segments'] = []
            for segment in segments:
                if args.verbose:
                    print(f"Compressing segment: {segment}")
                bs = compress_segment(segment, substr_dict)
                learn_data[page][i]['quote_byte_segments'].append(bs)
                b.append(bs)
            learn_data[page][i]['quote_byte_segments'].append("$00") # end of section
            b.append("$00") 
            learn_data[page][i]['bytes'] = ",".join(b)
    write_asm('src/data/compressed/text/learn.asm', substr_dict, data=learn_data, pointer=True)

    # 'top10' text
    for page in top10_data:
        for i in range(len(top10_data[page])):
            b = []
            segments = text_to_segments(top10_data[page][i]['quote_raw'])
            top10_data[page][i]['quote_byte_segments'] = []
            for segment in segments:
                if args.verbose:
                    print(f"Compressing segment: {segment}")
                bs = compress_segment(segment, substr_dict)
                top10_data[page][i]['quote_byte_segments'].append(bs)
                b.append(bs)
            top10_data[page][i]['quote_byte_segments'].append("$00") # end of section
            b.append("$00") 
            top10_data[page][i]['bytes'] = ",".join(b)
    write_asm('src/data/compressed/text/top10.asm', substr_dict, data=top10_data, pointer=True)

    # 'sound' text
    for page in sound_data:
        for i in range(len(sound_data[page])):
            b = []
            segments = text_to_segments(sound_data[page][i]['quote_raw'])
            sound_data[page][i]['quote_byte_segments'] = []
            for segment in segments:
                if args.verbose:
                    print(f"Compressing segment: {segment}")
                bs = compress_segment(segment, substr_dict)
                sound_data[page][i]['quote_byte_segments'].append(bs)
                b.append(bs)
            sound_data[page][i]['quote_byte_segments'].append("$00") # end of section
            b.append("$00") 
            sound_data[page][i]['bytes'] = ",".join(b)
    write_asm('src/data/compressed/text/sound.asm', substr_dict, data=sound_data, pointer=True)

    # 'newgame' text
    for page in newgame_data:
        for i in range(len(newgame_data[page])):
            b = []
            segments = text_to_segments(newgame_data[page][i]['quote_raw'])
            newgame_data[page][i]['quote_byte_segments'] = []
            for segment in segments:
                if args.verbose:
                    print(f"Compressing segment: {segment}")
                bs = compress_segment(segment, substr_dict)
                newgame_data[page][i]['quote_byte_segments'].append(bs)
                b.append(bs)
            newgame_data[page][i]['quote_byte_segments'].append("$00") # end of section
            b.append("$00") 
            newgame_data[page][i]['bytes'] = ",".join(b)
    write_asm('src/data/compressed/text/newgame.asm', substr_dict, data=newgame_data, pointer=True)

    # 'traveling' text
    for page in traveling_data:
        for i in range(len(traveling_data[page])):
            b = []
            segments = text_to_segments(traveling_data[page][i]['quote_raw'])
            traveling_data[page][i]['quote_byte_segments'] = []
            for segment in segments:
                if args.verbose:
                    print(f"Compressing segment: {segment}")
                bs = compress_segment(segment, substr_dict)
                traveling_data[page][i]['quote_byte_segments'].append(bs)
                b.append(bs)
            traveling_data[page][i]['quote_byte_segments'].append("$00") # end of section
            b.append("$00") 
            traveling_data[page][i]['bytes'] = ",".join(b)
    write_asm('src/data/compressed/text/traveling.asm', substr_dict, data=traveling_data, pointer=True)

    # 'river' text
    for page in river_data:
        for i in range(len(river_data[page])):
            b = []
            segments = text_to_segments(river_data[page][i]['quote_raw'])
            river_data[page][i]['quote_byte_segments'] = []
            for segment in segments:
                if args.verbose:
                    print(f"Compressing segment: {segment}")
                bs = compress_segment(segment, substr_dict)
                river_data[page][i]['quote_byte_segments'].append(bs)
                b.append(bs)
            river_data[page][i]['quote_byte_segments'].append("$00") # end of section
            b.append("$00") 
            river_data[page][i]['bytes'] = ",".join(b)
    write_asm('src/data/compressed/text/river.asm', substr_dict, data=river_data, pointer=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-v",
        "--verbose",
        dest="verbose",
        help="increase output verbosity",
        action="store_true"
    )
    args = parser.parse_args()
    try:
        main(args)
    except KeyboardInterrupt:
        print("\nOkay then.")
        exit()