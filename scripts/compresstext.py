import pprint as pp
import textwrap
import re
import argparse

TEXTLINE_TILES = 4*6
PUNCT = {
    " ": 0,
    "@": 1, # actually a comma
    ".": 2,
    "!": 3,
    "?": 4
}
SUBSTR_LEN = 2
LITERAL_CHAR = 210
SPECIAL_CHAR = {
    "'": LITERAL_CHAR+26,
    "-": LITERAL_CHAR+27,
    '"': LITERAL_CHAR+28,
    ';': LITERAL_CHAR+29,
    ':': LITERAL_CHAR+30,
    '.': LITERAL_CHAR+31,
    '@': LITERAL_CHAR+32, # actually a comma
    '0': LITERAL_CHAR+33,
    '1': LITERAL_CHAR+34,
    '2': LITERAL_CHAR+35,
    '4': LITERAL_CHAR+36,
    '6': LITERAL_CHAR+37,
    '7': LITERAL_CHAR+38,
    '…': LITERAL_CHAR+39,
    '(': LITERAL_CHAR+40,
    ')': LITERAL_CHAR+41,
}
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
    ')': "_CP"
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
        section = '\n'.join([line for line in section.split('\n') if not line.startswith('#')])
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

    # Header length nibble (second half of first header byte)
    header_bytes[0] = f"${hex(len(header_bytes[1:]))[2:]}"+header_bytes[0]

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
    segment = segment[:-1] if segment[-1] in PUNCT else segment
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
        mass_text = mass_text.replace(c, '$')
    for i in range(1, LITERAL_CHAR):
        c = most_common_substring([x for x in mass_text.split('$') if len(x)>=2])
        substr_dict[i] = c
        if len(c):
            mass_text = mass_text.replace(c,'$')
    return {k:v for k,v in substr_dict.items() if len(v)}

def write_asm(filename, substr_dict, data=None):
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
        f.write(f"; ${hex(LITERAL_CHAR+26)[2:]} - ${hex(LITERAL_CHAR+26+len(SPECIAL_CHAR_ASM)-1)[2:]}: Literal special chars: {str([i.replace('@',',') for i in SPECIAL_CHAR_ASM])}\n")
        f.write(f"; ${hex(LITERAL_CHAR+26+len(SPECIAL_CHAR_ASM))[2:]} - $ff: Unused\n")
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
            f.write(f"    ; range: $01 - $d1\n")
            for i in s:
                f.write(f"    .byte {i}\n")
            f.write("\n")
            bytes_after += len(substr_dict)*2
        else:
            labels = []
            prefix = filename.split('/')[-1].split('.')[0]
            for loc in data:
                len_i = 3 if 'talk' in filename else 1
                for i in range(len_i):
                    label = f"{prefix}{loc.replace(' ','').replace('Crossing','')}"
                    if len_i>1:
                        label += f"{i+1}"
                    labels.append(label)
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
            f.write(f"{prefix}Pointer:\n")
            for label in labels:
                f.write(f"    .byte <{label},>{label}\n")
    if bytes_before:
        print(f"Text\n* bytes to pack: {bytes_before}")
        print(f"* Compressed size: {bytes_after}")
        print(f"* Saved {bytes_before-bytes_after} bytes (~{(bytes_before-bytes_after)/1024:.0f}K, {100*(bytes_before-bytes_after)/bytes_before:.0f}%)")

def main(args):
    verbose = args.verbose
    talk_data = parse_raw_text('src/data/raw/text/talk.txt')
    learn_data = parse_raw_text('src/data/raw/text/learn.txt')
    mass_text = ""
    for loc in talk_data:
        for i in range(len(talk_data[loc])):
            segments = text_to_segments(talk_data[loc][i]['quote_raw'])
            talk_data[loc][i]['quote_segments'] = segments
            for segment in segments:
                mass_text += squish_segment(segment)
    
    for loc in learn_data:
        for i in range(len(learn_data[loc])):
            segments = text_to_segments(learn_data[loc][i]['quote_raw'])
            learn_data[loc][i]['quote_segments'] = segments
            for segment in segments:
                mass_text += squish_segment(segment)

    substr_dict = create_substr_dict(mass_text)
    write_asm('src/data/compressed/text/dictionary.asm',substr_dict)

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
    write_asm('src/data/compressed/text/talk.asm', substr_dict, data=talk_data)

    for page in learn_data:
        #pp.pprint(learn_data)
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
    #pp.pprint(learn_data)
    #input()
    write_asm('src/data/compressed/text/learn.asm', substr_dict, data=learn_data)

    #print(HLENS[HLENS.index(max([i for i in HLENS]))])

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-v",
        "--verbose",
        help="increase output verbosity",
        action="store_true"
    )
    args = parser.parse_args()
    main(args)