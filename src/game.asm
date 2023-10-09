.include "constants.asm"
.include "header.asm"

.segment "VECTORS"
    .addr nmi, reset, irq
    
.segment "ZEROPAGE"
    .include "zeropage.asm"

.segment "BSS"
    .include "vars.asm"

.segment "ROM0"
    .include "tiles.asm" ; TODO deprecate
    .include "data/raw/text/top10default.asm"
    .include "data/compressed/image/suppliesTiles.asm"
    .include "data/compressed/image/textTiles.asm"
    .include "data/raw/image/suppliesImage.asm"
    .include "data/compressed/image/namepartyImage.asm"

.segment "ROM1"
    .include "code/rom1.asm"
    .include "code/random_event.asm"
    .include "data/raw/palettes.asm"
    .include "data/raw/backgrounds.asm"
    .include "data/raw/sprites.asm"
    .include "data/raw/climate.asm"
    ;.include "data/raw/rivers.asm"
    .include "data/raw/text/text.asm"
    .include "data/compressed/text/learn.asm"
    .include "data/compressed/text/sound.asm"
    .include "data/compressed/text/top10.asm"
    .include "data/compressed/text/newgame.asm"

.segment "ROM2"
    .include "data/compressed/image/landmarkImageA.asm"
    .include "data/compressed/text/talkA.asm"

.segment "ROM3"
    .include "data/compressed/image/landmarkImageB.asm"
    .include "data/compressed/text/talkB.asm"

.segment "ROM4"
    .include "data/compressed/image/landmarkImageC.asm"
    .include "data/compressed/text/talkC.asm"

.segment "ROM5"
    .include "data/compressed/image/landmarkImageD.asm"
    .include "data/compressed/text/talkD.asm"

.segment "ROM6"
    .include "data/compressed/image/landmarkImageE.asm"
    .include "data/compressed/text/talkE.asm"
    .include "data/compressed/image/mapImage.asm" ; TODO move to bank 0?
    .include "data/raw/image/adornmentImage.asm" ; TODO move to bank 0?
    .include "data/raw/image/titleLogoImage.asm" ; TODO move to bank 0?

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
    
    LDY #0              ; Preserve "Oregon Top Ten" data.
    LDA $0300           ; Look for "OREGON" in memory - if it is found,
    CMP #_O_            ; then this is most likely a "warm" reset.
    BNE :+
    LDA $0301
    CMP #_R_
    BNE :+
    LDA $0302
    CMP #_E_
    BNE :+
    LDA $0303
    CMP #_G_
    BNE :+
    LDA $0304
    CMP #_O_
    BNE :+
    LDA $0305
    CMP #_N_
    BNE :+
    LDY #1
    :                   ; clear memory
    LDA #$00
    STA $0000, X
    STA $0100, X
    STA $0400, X
    STA $0500, X
    STA $0600, X
    STA $0700, X
    LDA #$FE
    STA $0200, X
    LDA #$00
    CPX #107 ; total bytes reserved in vars.asm, above "this line"
    BCS :+
    CPY #1
    BNE :+
    JMP :++
    :
    STA $0300, X
    :
    INX
    BNE :---
    LDA #_O_ ; load sentinal value into memory
    STA $0300
    LDA #_R_
    STA $0301
    LDA #_E_
    STA $0302
    LDA #_G_
    STA $0303
    LDA #_O_
    STA $0304
    LDA #_N_
    STA $0305
    LDA #%10000000 ; default gameSettings
    STA $0306
    CPY #1 ; set default high scores if this is a hard reset
    BEQ :+
    JSR SetDefaultTopTen
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
.include "data/compressed/text/dictionary.asm"
.include "data/compressed/text/talkPointer.asm"