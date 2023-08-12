import os
import pprint as pp

def dec2hexasm(a):
    if abs(a) > 255:
        raise Exception("int too large to convert to byte")
    if a < 0:
        a = 80 + abs(a)
    return f"${hex(a)[2:].rjust(2,'0')}"

def parse(a):
    b = [i.strip() for i in a]
    b = ''.join(b)
    if 'incbin' in b:
        return b
    b = b.split('.byte')
    b = [j.strip() for j in b if len(j.strip())]
    b = ','.join(b)
    b = b.replace(' ','')
    b = b.split(',')
    c = []
    for i in b:
        if '$' in i:
            d,e = i[1:], 16
        elif '%' in i:
            d,e = i[1:], 2
        else:
            d,e = i, 10
        c.append(dec2hexasm(int(d, e)))
    b = ','.join(c)
    return b

def pack(a):
    if 'incbin' in a:
        return a
    b = []
    a = a.split(',')
    repeat = 0
    literal = 0
    c = []
    for i in range(len(a) - 1):
        if a[i] == a[i+1]:
            repeat += 1
            if literal:
                c.append(literal)
            literal = 0
        else:
            if repeat > 1:
                c.append(-(repeat+1))
                if repeat+1 > 127:
                    raise Exception(f"{repeat+1} repetitions is too many")
            else:
                literal += 1
            b.append(a[i])
            repeat = 0
    # b = [','.join(b), c]
    d = []
    for i in c:
        d.append(dec2hexasm(i))
        if i >= 0:
            for j in range(i):
                d.append(b.pop(0))
        else:
            d.append(b.pop(0))
    b = ','.join(d)

    return b

def main():
    asm_filenames = []
    chr_filenames = []
    for filename in os.listdir('src/data/raw'):
        if '.asm' in filename:
            asm_filenames.append('src/data/raw/'+filename)
    for filename in os.listdir('src/data/tilesets/raw'):
        if '.chr' in filename:
            chr_filenames.append('src/data/tilesets/raw/'+filename)
    # print(asm_filenames)
    asm_data = {filename:{} for filename in asm_filenames}
    # pp.pprint(asm_data)
    original_size = {}
    packed_size = {}
    for filename in asm_filenames:
        with open(f"{filename}", 'r') as f:
            text = '\n'.join([line.split(';')[0] for line in f.readlines()]).split(':')
            # print(f"{filename} labels: {len(text)}")
            asm_label = text[0].strip()
            for label in text[1:-1]:
                i = label.split('\n')
                a = parse(i[:-1])
                asm_data[filename][asm_label] = b = pack(a)
                if 'incbin' not in b:
                    original_size[asm_label] = len(a.split(','))
                    packed_size[asm_label] = len(b.split(','))
                asm_label = i[-1]
            a = parse(text[-1].split('\n'))
            asm_data[filename][asm_label] = b = pack(a)
            if 'incbin' not in b:
                original_size[asm_label] = len(a.split(','))
                packed_size[asm_label] = len(b.split(','))
            with open(f"{filename.replace('raw/','')}", 'w') as f:
                for label in asm_data[filename]:
                    f.write(f"{label}:\n")
                    if 'incbin' not in asm_data[filename][label]:
                        f.write(f"\t.byte {asm_data[filename][label]}\n")
                    else:
                        f.write(f"\t{asm_data[filename][label]}\n")
    for filename in chr_filenames:
        with open(f"{filename}", 'rb') as f:
            a = ','.join([dec2hexasm(int(i,16)) for i in f.readlines()[0].hex(',').split(',')])
            original_size[filename] = len(a.split(','))
            a = pack(a)
            packed_size[filename] = len(a.split(','))
            a = a.replace(',','').replace('$','')
            with open(f"{filename.replace('raw/','')}", 'wb') as f:
                f.write(bytearray.fromhex(a))
    # pp.pprint(asm_data,indent=4)
    # pp.pprint(original_size, indent=4)
    # pp.pprint(packed_size, indent=4)
    o = sum([original_size[i] for i in original_size])
    p = sum([packed_size[i] for i in packed_size])
    print(f"Bytes to pack: {o}")
    print(f"Compressed size: {p}")
    print(f"Saved {o-p} bytes (~{(o-p)/1024:.0f}K, {100*(o-p)/o:.0f}%)")
    return asm_data

if __name__ == "__main__":
    main()