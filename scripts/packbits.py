import os
import pprint as pp
import argparse
import traceback

MAX_RUN_LENGTH = 63

def dec2hexasm(a):
    # if abs(a) > 255:
    #     raise Exception("int too large to convert to byte")
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
    #input(a)
    a = [int(i[1:],16) for i in a.split(',')]
    #input(a)
    run, runs = [], []
    dupe = None
    for i in range(len(a) - 1):
        if a[i] == a[i+1]:
            if dupe == None and len(run):
                runs.append(run)
                run = []
            dupe = a[i]
            run.append(dupe)
        else:
            if dupe != None:
                dupe = None
                run.append(a[i])
                runs.append(run)
                run = []
            else:
                run.append(a[i])
    if dupe:
        run.append(dupe)
    else:
        run.append(a[-1])
    runs.append(run)
    #input("\n"+str(runs))
    run2, runs2 = [], []
    for run in runs:
        if len(run) > 1:
            if run[0] == run[1]:
                runs2.append(run)
                continue
            inc = None
            for i in range(len(run)-1):
                if run[i] == run[i+1]-1:
                    if inc == None and len(run2):
                        runs2.append(run2)
                        run2 = []
                    inc = run[i]
                    run2.append(inc)
                else:
                    if inc != None:
                        inc = None
                        run2.append(run[i])
                        runs2.append(run2)
                        run2 = []
                    else:
                        run2.append(run[i])
            if inc:
                run2.append(inc+1)
            else:
                run2.append(run[-1])
            runs2.append(run2)
            run2 = []
        else:
            runs2.append(run)
    #input("\n"+str(runs2))
    splits = []
    n = MAX_RUN_LENGTH
    for run in runs2:
        split = [run[i * n:(i + 1) * n] for i in range((len(run) + n - 1) // n )]
        splits += split
    #input("\n"+str(splits))
    segments = []
    for run in splits:
        if len(run) > 1:
            if run[0] == run[1]:
                segments.append([[2,len(run)], dec2hexasm(run[0])])
            elif run[0] == run[1]-1:
                segments.append([[1,len(run)], dec2hexasm(run[0])])
            else:
                segments.append([[0,len(run)]] + [dec2hexasm(i) for i in run])
        else:
            segments.append([[0,len(run)]] + [dec2hexasm(i) for i in run])
    #input("\n"+str(segments))
    final = []
    for segment in segments:
        final.append(",".join([dec2hexasm(segment[0][0]*(2**6)+segment[0][1])]+segment[1:]))
    #input("\n"+str(final))
    return ",".join(final)

# a = '$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$02,$03,$04,$09,$a0,$1f,$32,$ff,$ff,$ff,$ff,$02,$02,$03'
# a += ","+",".join([dec2hexasm(i) for i in range(150)])
# pack(a)

#Saved 24785 bytes (~24K, 21%)


def pack2(a):
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

    # def addsegment(segment, segments):
    #     if len(segment) > MAX_RUN_LENGTH:
    #         input(f"Splitting long run with length {len(segment)} [{segment[0]}]")
    #         batch, batches = [], []
    #         i = 0
    #         while len(segment) > 0:
    #             batch.append(segment.pop(0))
    #             i += 1
    #             if i == MAX_RUN_LENGTH:
    #                 batches.append(batch)
    #                 i = 0
    #                 batch = []
    #         batches.append(batch)
    #         for batch in batches:
    #             segments.append([dec2hexasm(len(batch))] + batch)
    #     else:
    #         segments.append([dec2hexasm(len(segment))] + segment)
    #     return segments
    
    def split_long_segments(segments):
        final = []
        n = MAX_RUN_LENGTH
        for segment in segments:
            if len(segment) == 2: # repeated run
                if len(segment[0]) >= len("$xxx"):
                    x = int(segment[0][1:],16)-128
                    while x > MAX_RUN_LENGTH:
                        final.append([dec2hexasm(-MAX_RUN_LENGTH), segment[1]])
                        x -= MAX_RUN_LENGTH
                    if x>0:
                        final.append([dec2hexasm(-x), segment[1]])
                else:
                    final.append(segment)
            else: # long run of singles
                if int(segment[0][1:],16) > MAX_RUN_LENGTH:
                    segment = segment[1:]
                    subsegments = [segment[i * n:(i + 1) * n] for i in range((len(segment) + n - 1) // n )]
                    for subsegment in subsegments:
                        final.append([dec2hexasm(len(subsegment))] + subsegment)
                else:
                    final.append(segment)
        #if len(segments) != len(final):

            # print("#######")
            # print("Segments:", segments)
            # print("#######")
            # print("Final:", final)
            # print("#######")
        return final
    # r = []
    # for run in runs:
    #     while len(run) > MAX_RUN_LENGTH:
    #         r.append(run[:MAX_RUN_LENGTH])
    #         run = run[MAX_RUN_LENGTH:]
    #     if len(run):
    #         r.append(run)
    # runs = r

    # pp.pprint(runs)
    # input()
    for run in runs:
        if len(run) <= 2:
            for i in run:
                segment.append(i)
        else:
            if len(segment):
                segments.append([dec2hexasm(len(segment))] + segment)
            segments.append([dec2hexasm(-len(run)), run[0]])
            segment = []
    if len(segment):
        segments.append([dec2hexasm(len(segment))] + segment)
    segments = split_long_segments(segments)
    return ','.join([','.join(segment) for segment in segments])

def verify(a, b, verbose):
    debug = ""
    if 'incbin' in a:
        return True
    c = []
    header = 0
    b = b.split(',')
    a = a.split(',')
    i = 0
    if verbose: print(f"Verifying segment, unpacked bytes: {len(a)}, Packed bytes: {len(b)}", end='')
    # if len(b) > len(a)+1:
    #     if verbose:
    #         print('...Failed')
    #         print(f"\nWARN:\nUnpacked bytes: {a}")
    #         print(f"\nPacked bytes: {b}\n")
    #         print('-'*10)
    #         raise Exception("Bad compression")
    while len(c) < len(a):
        try:
            debug += f"New segment header: {b[i]}\n"
            header = int(b[i][1:],16)
        except:
            if verbose: print(f"i: {i}\nlen(a): {len(a)}\nlen(b): {len(b)}\nlen(c): {len(c)}")
            if verbose: print(header)
        i += 1
        if header & 0xc0 == 0x80:
            debug += f"Segment is a run of {header & 0x3f} * {b[i]}\n"
            for j in range(header & 0x3f):
                c.append(b[i])
            i += 1
        elif header & 0xc0 == 0x00:
            debug += f"Segment is {header & 0x3f} different bytes\n"
            for j in range(header & 0x3f):
                c.append(b[i])
                i += 1
        elif header & 0xc0 == 0x40:
            debug += f"Segment is an incrementing run of {header & 0x3f} bytes starting with {b[i]}\n"
            for j in range(header & 0x3f):
                #debug += f"{dec2hexasm(int(b[i][1:],16)+j)}\n"
                c.append(dec2hexasm(int(b[i][1:],16)+j))
            i += 1
        debug += f"Done with that segment. Unpacked {len(c)} bytes so far.\n"
        if a[:len(c)] != c:
            if verbose: print("\nTo unpack:",len(b))
            if verbose: print("Original:",len(a[:len(c)]),a[:len(c)])
            if verbose: print(f"Unpacked: {len(c)}",c)
            if verbose: 
                print("Debug:")
                print(debug)
            raise Exception("Bad compression")

    if a != c:
        if verbose: print('...Failed')
        raise Exception("Bad compression")
    else:
        if verbose: print('...OK')
        return True

def aaaaa(a,asm_data,filename,asm_label,verbose):

    if 0 and "landmark" in filename and ("Image" in asm_label or "Attr" in asm_label):
        #input(f"{filename}: {asm_label}\n{[int(i[1:],16) for i in a.split(',')]}")
        with open(f"src/data/raw/bin/{asm_label}.bin", "wb") as bf:
            bf.write(bytes([int(i[1:],16) for i in a.split(',')]))

        asm_data[filename][asm_label] = b = f".incbin \"../bin/{asm_label}.bin\""
    else:
        asm_data[filename][asm_label] = b = pack(a)
        verify(a, b, verbose)
    return b

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
            if verbose: print(f"- {filename} -")
            lines = f.readlines()
            if "TODO compress" not in ''.join(lines):
                text = '\n'.join([line.split(';')[0] for line in lines]).split(':')
                # if verbose: print(f"{filename} labels: {len(text)}")
                asm_label = text[0].strip()
                for label in text[1:-1]:
                    i = label.split('\n')
                    a = parse(i[:-1])
                    b = aaaaa(a,asm_data,filename,asm_label,verbose)
                    if 'incbin' not in b:
                        original_size[asm_label] = len(a.split(','))
                        packed_size[asm_label] = len(b.split(','))
                    asm_label = i[-1]
                a = parse(text[-1].split('\n'))
                b = aaaaa(a,asm_data,filename,asm_label,verbose)
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
                    if verbose: print(f"Compressed {filename}\n")
            else:
                if verbose: print(f"Skipped {filename}\n")
    chr_filenames = []
    for filename in chr_filenames:
        with open(f"{filename}", 'rb') as f:
            if verbose: print(f"- {filename} -")
            try:
                a = ','.join([dec2hexasm(int(i,16)) for i in f.readlines()[0].hex(',').split(',')])
                a1 = a
                # input(f"Original data: {a}")
                original_size[filename] = len(a.split(','))
                b = pack(a)
                # input(f"Packed data: {a}")
                vvv = verify(a, b, verbose)
                a = b
                packed_size[filename] = len(a.split(','))
                a = a.replace(',','').replace('$','')
                with open(f"{filename.replace('raw/','compressed/')}", 'wb') as f:
                    f.write(bytearray.fromhex(a))
                    if verbose: print(f"Compressed {filename}\n")
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

# Image/CHR
# * bytes to pack: 117440
# * Compressed size: 92655
# * Skipped size: 0
# * Saved 24785 bytes (~24K, 21%)

# Image/CHR
# * bytes to pack: 117440
# * Compressed size: 84804
# * Skipped size: 14592
# * Saved 18044 bytes (~18K, 15%)
