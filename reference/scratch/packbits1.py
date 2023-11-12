import os
import pprint as pp
import argparse

def dec2hexasm(a):
    if abs(a) > 255:
        raise Exception("int too large to convert to byte")
    if a < 0:
        a = 128 + abs(a)
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
    a = a.split(',')
    run, runs = [], []
    for i in range(len(a) - 1):
        if a[i] == a[i+1]:
            run.append(a[i])
        else:
            run.append(a[i])
            runs.append(run)
            run = []
    if a[-2] == a[-1]:
        run.append(a[-1])
    else:
        run = [a[-1]]
    runs.append(run)
    if ','.join(a) != ','.join([','.join(run) for run in runs]):
        print(','.join(a))
        print(runs)
        raise Exception("Bad compression")
    segment, segments = [], []
    def addsegment(segment, segments):
        if len(segment) >= 128:
            batch, batches = [], []
            i = 0
            while len(segment) > 0:
                batch.append(segment.pop(0))
                i += 1
                if i == 127:
                    batches.append(batch)
                    i = 0
                    batch = []
            batches.append(batch)
            for batch in batches:
                segments.append([dec2hexasm(len(batch))] + batch)
        else:
            segments.append([dec2hexasm(len(segment))] + segment)
        return segments

    for run in runs:
        if len(run) <= 2:
            for i in run:
                segment.append(i)
        else:
            if len(segment):
                segments = addsegment(segment, segments)
            segments.append([dec2hexasm(-len(run)), run[0]])
            segment = []
    if len(segment):
        segments = addsegment(segment, segments)
    return ','.join([','.join(segment) for segment in segments])

def verify(a, b, verbose):
    if 'incbin' in a:
        return True
    c = []
    header = 0
    b = b.split(',')
    a = a.split(',')
    i = 0
    if verbose: print(f"Verifying segment, unpacked bytes: {len(a)}, Packed bytes: {len(b)}", end='')
    if len(b) > len(a):
        if verbose: print(f"unpacked bytes: {a}")
        #input(f"Packed bytes: {b}")
    while len(c) < len(a):
        try:
            header = int(b[i].replace('$',''),16)
        except:
            if verbose: print(f"i: {i}\nlen(a): {len(a)}\nlen(b): {len(b)}\nlen(c): {len(c)}")
            if verbose: print(header)
        i += 1
        if header > 128:
            header -= 128
            for j in range(header):
                c.append(b[i])
            i += 1
        else:
            for j in range(header):
                c.append(b[i])
                i += 1
        if a[:len(c)] != c:
            if verbose: print("Original:",a[:len(c)])
            if verbose: print(f"Unpacked: {c}")
            raise Exception("Bad compression")
    if a != c:
        if verbose: print('...Failed')
        raise Exception("Bad compression")
    else:
        if verbose: print('...OK')
        return True

def main(args):
    verbose = args.verbose
    asm_filenames = []
    chr_filenames = []
    for filename in os.listdir('src/data/raw/image'):
        asm_filenames.append('src/data/raw/image/'+filename)
    for filename in os.listdir('src/data/raw/chr'):
        chr_filenames.append('src/data/raw/chr/'+filename)
    # if verbose: print(asm_filenames)
    asm_data = {filename:{} for filename in asm_filenames}
    # pp.pprint(asm_data)
    original_size = {}
    packed_size = {}
    skipped_size = {}
    for filename in asm_filenames:
        with open(f"{filename}", 'r') as f:
            lines = f.readlines()
            if "TODO compress" not in ''.join(lines):
                text = '\n'.join([line.split(';')[0] for line in lines]).split(':')
                # if verbose: print(f"{filename} labels: {len(text)}")
                asm_label = text[0].strip()
                for label in text[1:-1]:
                    i = label.split('\n')
                    a = parse(i[:-1])
                    asm_data[filename][asm_label] = b = pack(a)
                    verify(a, b, verbose)
                    if 'incbin' not in b:
                        original_size[asm_label] = len(a.split(','))
                        packed_size[asm_label] = len(b.split(','))
                    asm_label = i[-1]
                a = parse(text[-1].split('\n'))
                asm_data[filename][asm_label] = b = pack(a)
                verify(a, b, verbose)
                if 'incbin' not in b:
                    original_size[asm_label] = len(a.split(','))
                    packed_size[asm_label] = len(b.split(','))
                with open(f"{filename.replace('raw/','compressed/')}", 'w') as f:
                    for label in asm_data[filename]:
                        f.write(f"{label}:\n")
                        if 'incbin' not in asm_data[filename][label]:
                            f.write(f"\t.byte {asm_data[filename][label]}\n")
                        else:
                            f.write(f"\t{asm_data[filename][label]}\n")
                    if verbose: print(f"Compressed {filename}")
            else:
                if verbose: print(f"Skipped {filename}")
    for filename in chr_filenames:
        with open(f"{filename}", 'rb') as f:
            a = ""
            try:
                a = ','.join([dec2hexasm(int(i,16)) for i in f.readlines()[0].hex(',').split(',')])
                # input(f"Original data: {a}")
                original_size[filename] = len(a.split(','))
                b = pack(a)
                # input(f"Packed data: {a}")
                verify(a, b, verbose)
                a = b
                packed_size[filename] = len(a.split(','))
                a = a.replace(',','').replace('$','')
                with open(f"{filename.replace('raw/','compressed/')}", 'wb') as f:
                    f.write(bytearray.fromhex(a))
                    if verbose: print(f"Compressed {filename}")
            except:
                if filename in original_size:
                    skipped_size[filename] = original_size[filename]
                if verbose: print(f"WARN: Skipped {filename}")
    # pp.pprint(asm_data,indent=4)
    # pp.pprint(original_size, indent=4)
    # pp.pprint(packed_size, indent=4)
    o = sum([original_size[i] for i in original_size])
    p = sum([packed_size[i] for i in packed_size])
    s = sum([skipped_size[i] for i in skipped_size])
    if verbose: print(f"Image/CHR\n* bytes to pack: {o}")
    if verbose: print(f"* Compressed size: {p}")
    if verbose: print(f"* Skipped size: {s}")
    if verbose: print(f"* Saved {(o-p)-s} bytes (~{((o-p)-s)/1024:.0f}K, {100*((o-p)-s)/o:.0f}%)")
    return asm_data

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