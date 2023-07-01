#!/bin/bash

ca65 src/game.s -g -o game.o --verbose
ld65 -o game.nes -C src/memory.cfg game.o --dbgfile game.dbg -Ln game.labels.txt
