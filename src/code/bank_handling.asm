
.proc CopyCHRTiles ; copy both chr tables from ROM bank to CHR RAM
    ; @param pointer: chr binary
    LDY #0
    STY PPUMASK
    STY PPUADDR
    STY PPUADDR
    LDX #$20
    :
    LDA (pointer), Y
    STA PPUDATA
    INY
    BNE :-
    INC pointer+1
    DEX
    BNE :-
    RTS
.endproc

.proc CopyCHRPatternB
    ; @param pointer
    LDY #0
    STY PPUMASK
    LDY #$10
    STY PPUADDR
    LDY #$00
    STY PPUADDR
    LDX #$0D
    :
    LDA (pointer), Y
    STA PPUDATA
    INY
    BNE :-
    INC pointer+1
    DEX
    BNE :-
    RTS
.endproc
