.include "constants.inc"
.include "header.inc"
;-------------------------------------------------------------------------------
.segment "VECTORS"
    .addr nmi, reset, irq
    
;-------------------------------------------------------------------------------
.segment "ZEROPAGE"
.include "zeropage.inc"

;-------------------------------------------------------------------------------
.segment "BSS"
.include "vars.inc"

;-------------------------------------------------------------------------------
.segment "ROM0"
.include "tiles.asm"

;-------------------------------------------------------------------------------
.segment "ROM1"
.include "text.inc"
.include "diarytext.inc"
.include "palettes.inc"
.include "backgrounds.inc"
.include "sprites.inc"
.include "rom1.asm"

;-------------------------------------------------------------------------------
.segment "ROM2"
.include "textJP.inc"

;-------------------------------------------------------------------------------
.segment "ROM3"

;-------------------------------------------------------------------------------
.segment "ROM4"

;-------------------------------------------------------------------------------
.segment "ROM5"

;-------------------------------------------------------------------------------
.segment "ROM6"

;-------------------------------------------------------------------------------
.segment "RODATA" ; ROM7

banktable:              ; Write to this table to switch banks.
    .byte $00, $01, $02, $03, $04, $05, $06
    .byte $07, $08, $09, $0A, $0B, $0C, $0D, $0E


;-------------------------------------------------------------------------------
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
    STY tilesBank
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
    INC frameCounter
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
.include "code/game_controller.inc" ; controller = gamepad
.include "code/sprites.inc"