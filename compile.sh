#!/bin/bash

#ca65 src/game.asm
#ca65 src/reset.asm
rm map.txt
#ca65 src/rom1.asm -g -o rom1.o --verbose

#python3 scripts/packbits.py -v
python3 scripts/compresstext.py #-v

for chr in src/data/raw/chr/*; do
    chr=$(basename $chr)
    scripts/tokumaru-1.3.0/tokumaru -e -16 src/data/raw/chr/$chr src/data/compressed/chr/$chr > /dev/null
done

ca65 src/code/decompress.s -g -o decompress.o --verbose
ca65 src/game.asm -g -o game.o --verbose
ld65 -o game.nes -m map.txt -C memory.cfg game.o decompress.o --dbgfile game.dbg -Ln game.labels.txt
#echo "Compile OK"
