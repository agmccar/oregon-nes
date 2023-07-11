#!/bin/bash

#ca65 src/game.asm
#ca65 src/reset.asm
rm map.txt
ca65 src/game.asm -g -o game.o --verbose
ld65 -o game.nes -m map.txt -C memory.cfg game.o --dbgfile game.dbg -Ln game.labels.txt
