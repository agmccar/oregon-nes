
.proc LoadTrailSprites
    LDY #0
    LDX #0
    :
    LDA trailSprites, X
    STA TRAILSPRITES, X
    INX
    INY
    CPY #4
    BNE :-
    LDA #0
    TAY
    STA OAMADDR ; tell PPU to prepare for transfer to OAM starting at byte zero
    LDA #$02
    STA OAMDMA ; tell PPU to initiate transfer of 256 bytes $0200-$02ff into OAM
    :                   ; vblankwait again
    BIT PPUSTATUS
    BPL :-
    CPX #33*4
    BNE :--

    ; LDA #0
    ; STA PPUADDR
    ; STA PPUADDR
    RTS
.endproc
