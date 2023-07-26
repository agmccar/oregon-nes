
; .proc SwitchLang
;     LDA tilesBank   ; ROM0 bank0:ENG, bank1:JP
;     BNE :+
;     LDY #0
;     JSR bankswitch_y
;     LDA #<tiles_chr
;     STA pointer
;     LDA #>tiles_chr
;     STA pointer+1
;     LDA #0
;     STA tilesBank
;     JMP :++
;     :
;     LDY #0
;     JSR bankswitch_y
;     LDA #<tilesJP_chr
;     STA pointer
;     LDA #>tilesJP_chr
;     STA pointer+1
;     LDA #1
;     STA tilesBank
;     :
;     JSR CopyCHRTiles
;     LDY #1
;     JSR bankswitch_y
;     RTS
; .endproc

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
    LDY #0
    STY PPUMASK
    LDY #$10
    STY PPUADDR
    LDY #$00
    STY PPUADDR
    LDX #$10
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
