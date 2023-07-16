
.proc SwitchLang
    LDA tilesBank   ; ROM0 bank0:ENG, bank1:JP
    BNE :+
    LDY #0
    JSR bankswitch_y
    LDA #<tiles_chr
    STA pointer
    LDA #>tiles_chr
    STA pointer+1
    LDA #0
    STA tilesBank
    JMP :++
    :
    LDY #0
    JSR bankswitch_y
    LDA #<tilesJP_chr
    STA pointer
    LDA #>tilesJP_chr
    STA pointer+1
    LDA #1
    STA tilesBank
    :
    JSR CopyCHRTiles
    LDY #1
    JSR bankswitch_y
    RTS
.endproc

.proc CopyCHRTiles ; copy chr tiles from ROM bank to CHR RAM
    LDY #0
    STY PPUMASK
    STY PPUADDR
    STY PPUADDR
    LDX #32
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
