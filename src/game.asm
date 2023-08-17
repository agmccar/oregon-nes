.include "constants.asm"
.include "header.asm"

.segment "VECTORS"
    .addr nmi, reset, irq
    
.segment "ZEROPAGE"
    .include "zeropage.asm"

.segment "BSS"
    .include "vars.asm"

.segment "ROM0"
    .include "tiles.asm"

.segment "ROM1"
    .include "data/text.asm"
    .include "data/palettes.asm"
    .include "data/backgrounds.asm"
    .include "data/sprites.asm"
    .include "data/rom1.asm"
    .include "data/climate.asm"
    .include "code/random_event.asm"
    .include "data/talk.asm"

.segment "ROM2"
    .include "data/landmarkImageA.asm"

.segment "ROM3"
    .include "data/landmarkImageB.asm"

.segment "ROM4"
    .include "data/landmarkImageC.asm"

.segment "ROM5"
    .include "data/landmarkImageD.asm"

.segment "ROM6"
    .include "data/landmarkImageE.asm"
    .include "data/mapImage.asm"
    .include "data/suppliesImage.asm"
    .include "data/raw/adornmentImage.asm"

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
.include "code/bank_handling.asm"

.include "code/drawing_ctrl.asm"
.include "code/drawing.asm"
.include "code/drawing_helpers.asm"
.include "code/drawing_loadbg.asm"
.include "code/drawing_sprites.asm"
.include "code/buffer_ctrl.asm"
.include "code/buffer_drawing.asm"

.include "code/game_logic.asm"
.include "code/game_helpers.asm"
.include "code/game_init_state.asm"
.include "code/game_gamepad.asm"