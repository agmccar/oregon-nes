.include "constants.inc"
.include "header.inc"

.segment "VECTORS"
    .addr nmi, reset, irq
    
.segment "ZEROPAGE"
    .include "zeropage.inc"

.segment "BSS"
    .include "vars.inc"

.segment "ROM0"
    .include "tiles.inc"

.segment "ROM1"
    .include "data/text.inc"
    .include "data/diarytext.inc"
    .include "data/palettes.inc"
    .include "data/backgrounds.inc"
    .include "data/sprites.inc"
    .include "data/rom1.inc"

.segment "ROM2"
    .include "data/textJP.inc"

.segment "ROM3"
    .include "data/titleCHR.inc"

.segment "ROM4"
    .include "data/landmarkImageA.inc"

;.segment "ROM5"
    ;.include "data/landmarkImageB.inc"

;.segment "ROM6"
    ;.include "data/landmarkImageC.inc"

.segment "RODATA" ; ROM7
    banktable:              ; Write to this table to switch banks.
        .byte $00, $01, $02, $03, $04, $05, $06
        .byte $07, $08, $09, $0A, $0B, $0C, $0D, $0E

.segment "CODE"

bankswitch_y:
    sty currentBank       ; save the current bank in RAM so the NMI handler can restore it
bankswitch_nosave:
    lda banktable, y      ; read a byte from the banktable
    sta banktable, y      ; and write it back, switching banks 
    rts

.proc irq
    RTI
.endproc

.proc reset
    SEI
    CLD
    LDX #$FF
    TXS
    INX
    STX PPUCTRL
    STX PPUMASK
    STX DMCFREQ
    :                   ; vblankwait
    BIT PPUSTATUS
    BPL :-
    :                   ; clear memory
    LDA #$00
    STA $0000, X
    STA $0100, X
    STA $0300, X
    STA $0400, X
    STA $0500, X
    STA $0600, X
    STA $0700, X
    LDA #$FE
    STA $0200, X
    INX
    BNE :-
    :                   ; vblankwait again
    BIT PPUSTATUS
    BPL :-
    LDY #0
    JSR bankswitch_y
    LDA #<tiles_chr
    STA pointer
    LDA #>tiles_chr
    STA pointer+1
    JSR CopyCHRTiles
    LDY #1
    JSR bankswitch_y
    JSR ClearScreen
    LDA #%10010000      ; enable NMI, sprites use first pattern table
    STA softPPUCTRL
    STA PPUCTRL
    JSR InitStateTitle
    JMP main
.endproc

.proc main
    JSR ReadController1
    JSR CheckGameState
    JMP main
.endproc

.proc nmi
    PHP
    PHA
    TXA
    PHA
    TYA
    PHA
    LDA softPPUCTRL
    STA PPUCTRL
    LDA softPPUMASK
    STA PPUMASK
    JSR ProcessNametableBuffer
    LDA bufferLoading
    CMP #0
    BNE :+
    INC frameCounter
    :
    PLA
    TAY
    PLA
    TAX
    PLA
    PLP
    RTI
.endproc

; Code includes -----------------------
.include "code/bank_handling.inc"

.include "code/drawing_ctrl.inc"
.include "code/drawing.inc"
.include "code/drawing_helpers.inc"
.include "code/drawing_loadbg.inc"
.include "code/buffer_ctrl.inc"
.include "code/buffer_drawing.inc"

.include "code/game_logic.inc"
.include "code/game_helpers.inc"
.include "code/game_init_state.inc"
.include "code/game_gamepad.inc"
.include "code/sprites.inc"