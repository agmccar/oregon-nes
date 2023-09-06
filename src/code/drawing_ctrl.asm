.proc StartBulkDrawing
    LDA #%00000000      ; turn off screen
    STA softPPUMASK
    ; STA PPUMASK
    :                   ; wait for vblank
    BIT PPUSTATUS
    BPL :-
    LDA #0
    STA PPUMASK
    RTS
.endproc

.proc DoneBulkDrawing
    LDA #0              ; reset scroll position
    STA PPUSCROLL
    STA PPUSCROLL
    LDA #%00011110 
    STA softPPUMASK     ; turn on screen
    :                   ; wait for vblank
    BIT PPUSTATUS
    BPL :-
    RTS
.endproc

.proc ClearScreen
    JSR StartBulkDrawing
    LDX #0 ; clear sprites
    LDA #$FE
    :
    STA $0200, X
    INX
    BNE :-
    LDA #0
    STA OAMADDR ; tell PPU to prepare for transfer to OAM starting at byte zero
    LDA #$02
    STA OAMDMA ; tell PPU to initiate transfer of 256 bytes $0200-$02ff into OAM

    LDA PPUSTATUS       ; clear first screen tiles
    LDA #$20
    STA PPUADDR
    LDA #$00
    STA PPUADDR         ; $2000
    LDA #0
    TAX
    TAY
    @clear2000:
    :
    STA PPUDATA
    INX
    CPX #32
    BNE :-
    LDX #0
    INY
    CPY #30
    BNE @clear2000
    LDA PPUSTATUS       ; clear second screen tiles
    LDA #$23
    STA PPUADDR
    LDA #$00
    STA PPUADDR         ; $2300
    LDA #0
    TAX
    TAY
    @clear2300:
    :
    STA PPUDATA
    INX
    CPX #32
    BNE :-
    LDX #0
    INY
    CPY #30
    BNE @clear2300
    LDA PPUSTATUS       ; clear first screen attr table
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR         ; $23C0
    LDA #0
    TAX
    TAY
    @attributeLoop:
    :
    LDA #$FF
    STA PPUDATA
    INX
    CPX #$40
    BNE :-
    LDX #0
    LDA PPUSTATUS       ; clear second screen attr table
    LDA #$27
    STA PPUADDR
    LDA #$C0
    STA PPUADDR         ; $27C0
    INY
    CPY #2
    BNE @attributeLoop
    JSR DoneBulkDrawing
    RTS
.endproc

.proc ClearAttributes
    JSR StartBulkDrawing
    LDA PPUSTATUS
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR
    LDA #$ff
    LDX #$C0
    :
    STA PPUDATA
    INX
    CPX #0
    BNE :-
    JSR DoneBulkDrawing
    RTS
.endproc
