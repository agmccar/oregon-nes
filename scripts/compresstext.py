import pprint as pp
import textwrap
import re

TEXTLINE_TILES = 4*6
PUNCT = {".":1,",":2,"!":3,"?":4}
SUBSTR_LEN = 2
LITERAL_CHAR = 210
SPECIAL_CHAR = {
    "'": LITERAL_CHAR+26,
    "-": LITERAL_CHAR+27,
    '"': LITERAL_CHAR+28,
    ';': LITERAL_CHAR+29,
    ':': LITERAL_CHAR+30,
    '.': LITERAL_CHAR+31,
    ',': LITERAL_CHAR+32,
    '0': LITERAL_CHAR+33,
    '1': LITERAL_CHAR+34,
    '2': LITERAL_CHAR+35,
    '4': LITERAL_CHAR+36,
    '6': LITERAL_CHAR+37,
    '7': LITERAL_CHAR+38,
}

def verify_seg_headers(segments,seg_headers):
    segs = []
    for sh in seg_headers:
        h = sh.split(',')
        text = h.pop()
        seg = ""
        p = {v: k for k, v in PUNCT.items()}[int(h.pop(0)[2:],16)]
        h = [int(i,16) for i in ''.join(h).replace('$','')]
        ix = 0
        for i in h:
            seg += text[ix:ix+i]+" "
            ix += i
        seg = seg.strip()
        seg += p
        segs.append(seg)
    if segs != segments:
        print(segs)
        print(segments)
        raise Exception("Bad segment headers")
    return True

def verify_quote_bytes(qbytes, qraw, substr_dict):
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

with open('../src/data/talk.txt') as f:
    text = ''.join(f.readlines())

location = {}
text = text.split("##")[1:]

for section in text:
    a = section.split('\n\n')
    loc = a.pop(0).strip()
    location[loc] = []
    for n in range(len(a)):
        if not len(a[n].strip()):
            continue
        speaker_raw = a[n].split(' tells you:\n')[0].strip()
        quote_raw = a[n].split(' tells you:\n')[1].replace("\n"," ").strip()[1:-1]
        location[loc].append({
            'speaker_raw': speaker_raw,
            'speaker_wrap': textwrap.wrap(speaker_raw+" tells you:", width=TEXTLINE_TILES),
            # 'speaker_chunks': [speaker_raw[i:i+2] for i in range(0,len(speaker_raw),2)],
            'quote_raw': quote_raw,
            'quote_wrap': textwrap.wrap('"'+quote_raw+'"', width=TEXTLINE_TILES),
            # 'quote_chunks': [quote_raw[i:i+2] for i in range(0,len(quote_raw),2)]
        })

all_words = {}
for loc in location:
    for i in location[loc]:
        words = i['speaker_raw'].split(' ') + i['quote_raw'].split(' ')
        for w in words:
            w = re.sub("[!?,\.]$", "", w).upper()
            if w in all_words:
                all_words[w] += 1
            else:
                all_words[w] = 1

with open('../src/data/talk_tmp.txt','w') as f:
    for loc in location:
        for i in range(3):
            f.write(location[loc][i]['speaker_raw'].upper()+'\n')
            f.write(location[loc][i]['quote_raw'].upper()+'\n')

mass_text = ""
for loc in location:
    for i in range(3):
        raw = location[loc][i]['quote_raw']+' '
        raw = raw.replace('! ','!#')
        raw = raw.replace('? ','?#')
        raw = raw.replace(', ',',#')
        raw = raw.replace('. ','.#')
        segments = raw.split('#')[:-1]
        seg_headers = []
        for s in segments:
            h = []
            h.append(f"{hex(PUNCT[s[-1]])[2:]}")
            s = s[:-1]
            wlen = [len(i) for i in s.split(' ')]
            wlen = ''.join([hex(i)[2:] for i in wlen])
            wlen = [wlen[i:i+2] for i in range(0,len(wlen),2)]
            if len(wlen[-1]) == 1:
                wlen[-1] = wlen[-1]+"0"
            for w in wlen:
                h.append(f"${hex(int(w,16))[2:]}")
            h.append(''.join(s.split(' ')).upper())
            mass_text += h[-1]
            h[0] = f"${hex(len(h[1:])-1)[2:]}"+h[0]
            seg_headers.append(",".join(h))
        location[loc][i]['quote_segments'] = [s.upper() for s in segments]
        location[loc][i]['quote_seg_headers'] = seg_headers
        verify_seg_headers(location[loc][i]['quote_segments'],location[loc][i]['quote_seg_headers'])

substr_dict = {}
m = mass_text
for i in range(1,256):
    # print(m)
    # print(substr_dict)
    # print(f"Text length {len(m)}")
    c = most_common_substring([x for x in m.split('$') if len(x)>=2])
    substr_dict[i] = c
    if len(c):
        m = m.replace(c,'$')
# print(m)
# print(substr_dict)
# print(f"Text length {len(m)}")
# input("")
substr_dict = {k:v for k,v in substr_dict.items() if len(v)}

loners = []
for loc in location:
    for i in range(3):
        qbytes = []
        shs = location[loc][i]['quote_seg_headers']
        location[loc][i]['quote_seg_headers'] = [','.join(j.split(',')[:-1]) for j in location[loc][i]['quote_seg_headers']]
        seg_bytes = []
        for sh in shs:
            text = sh.split(',')[-1]
            qbytes += sh.split(',')[:-1]
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
                        # if f"${hex(SPECIAL_CHAR[j])[2:]}" == "$f8":
                        #     input(j)
                        #     input(text)
                    loners.append(j)
                else:
                    t.append(j)
            text = ','.join(t)
            qbytes += t
            seg_bytes.append(text)
        location[loc][i]['quote_seg_bytes'] = seg_bytes
        location[loc][i]['quote_bytes'] = ','.join(qbytes)
        # try:
        verify_quote_bytes(location[loc][i]['quote_bytes'], location[loc][i]['quote_raw'].upper(), substr_dict)
        # except:
        #     pp.pprint(location[loc][i])
        #     print(location[loc][i]['quote_bytes'])
        #     print(location[loc][i]['quote_raw'].upper())
        #     raise Exception

# pp.pprint(location)
# print({i for i in loners})
# print(max([max([len(j['speaker_raw']) for j in location[i]]) for i in location]))

# print([[len(j['quote_wrap']) for j in location[i]] for i in location])

# print(substrings)
# print(len(substrings))
# print(sum([i[1] for i in substrings]))

SPECIAL_CHAR = {
    "'": "_AP",
    "-": "_HY",
    '"': "_QU",
    ';': "_SC",
    ':': "_CL",
    '.': "_PD",
    ',': "_CM",
}
bytes_before = 0
bytes_after = 0
s = [0 for i in range(256)]
for i in substr_dict:
    s[i] = [j for j in substr_dict[i]]
    k = []
    for j in s[i]:
        if j in SPECIAL_CHAR:
            k.append(SPECIAL_CHAR[j])
        else:
            k.append(f"_{j}_")
    s[i] = ",".join(k)
s = [i for i in s if i != 0]
with open('../src/data/talk.asm','w') as f:
    f.write(f"; First header byte:\n")
    f.write(f"; %00000000\n")
    f.write(f";  ||||++++ Type of punctiation- '.':1, ',':2, '!':3, '?':4\n")
    f.write(f";  ++++---- Remaining length of header\n")
    f.write(f"\n; (2nd - nth) header bytes:\n; Every nibble is the length of a word.\n")
    f.write(f"; %00000000, %00000000,...\n")
    f.write(f";  ++++--------------- Length of first word\n")
    f.write(f";      ++++----------- Length of 2nd word\n")
    f.write(f";             ++++---- Length of 3rd word\n")
    f.write(f";                 ++++ Length of 4th word, etc.\n\n")
    f.write(f"; Data segment bytes:\n; $00      : Unused\n")
    f.write(f"; $01 - ${hex(LITERAL_CHAR)[2:]}: Dictionary\n")
    f.write(f"; ${hex(LITERAL_CHAR+1)[2:]} - ${hex(LITERAL_CHAR+26)[2:]}: Literal A-Z\n")
    f.write(f"; ${hex(LITERAL_CHAR+26+1)[2:]} - ${hex(LITERAL_CHAR+26+len(SPECIAL_CHAR))[2:]}: Literal special chars: {str([i for i in SPECIAL_CHAR])}\n")
    f.write(f"; ${hex(LITERAL_CHAR+26+len(SPECIAL_CHAR)+1)[2:]} - $ff: Unused\n")
    f.write(f"\n")
    f.write(f"talkDictionary:\n")
    f.write(f"    ; range: $01 - $d1\n")
    for i in s:
        f.write(f"    .byte {i}\n")
    f.write("\n")
    for loc in location:
        for i in range(3):
            l = loc.replace(" ","").replace("Crossing","")
            f.write(f"talk{l}{i+1}:\n")
            w = textwrap.wrap(location[loc][i]['quote_bytes'].replace(',',', '),width=70)
            for j in w:
                j = j.replace(' ','')
                if j[-1] == ',':
                    j = j[:-1]
                # else:
                #     j = j + ",$00"
                f.write(f"    .byte {j}\n")
            f.write("\n")
            bytes_before += len(location[loc][i]['quote_raw'])
            bytes_after += len(location[loc][i]['quote_bytes'].split(','))
bytes_after += len(substr_dict)*2
print(f"Text bytes: {bytes_before}\nCompressed: {bytes_after}\nSaved: {bytes_before-bytes_after} ({100*(bytes_before-bytes_after)/bytes_before:2.0f}%)")

#print(substr_dict)
# Word length byte - halve the space taken by spaces
# %00000000
#  ||||++++ word length
#  ++++---- another word length
# reserved: %0000: no word
# reserved: %1111: new segment 
# $fb: segment ending in period
# $fc: segment ending in comma
# $fd: segment ending in exclamation mark
# $fe: segment ending in question mark

# 220-245: literal a-z
# 246: literal '