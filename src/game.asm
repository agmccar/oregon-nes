.include "constants.asm"
.include "header.asm"
.include "macros.asm"

.segment "VECTORS"
    .addr nmi, reset, irq
    
.segment "ZEROPAGE"
    .include "zeropage.asm"

.segment "BSS"
    .include "vars.asm"

.segment "ROM0"
    .include "data/compressed/image/adornment.asm"
    .include "data/compressed/image/map.asm"
    .include "data/compressed/image/matt.asm"
    .include "data/compressed/image/nameparty.asm"
    .include "data/compressed/image/rivercrossing.asm"
    .include "data/compressed/image/suppliesTiles.asm"
    .include "data/compressed/image/textTiles.asm"
    .include "data/compressed/image/titleLogo.asm"
    .include "data/raw/image/supplies.asm" ; todo compress
    .include "data/raw/backgrounds.asm"
    .include "data/raw/sprites.asm"
    .include "data/raw/climate.asm"

    .include "code/title.asm"
    .include "data/compressed/text/learn.asm"
    .include "data/compressed/text/sound.asm"
    .include "data/compressed/text/top10.asm"


.segment "ROM1"
    .include "code/newgame.asm"
    .include "data/compressed/text/newgame.asm"
    .include "code/store.asm"
    .include "code/traveling.asm"
    .include "code/landmark.asm"

.segment "ROM2"
    .include "data/compressed/image/landmarkA.asm"
    .include "data/compressed/text/talkA.asm"

.segment "ROM3"
    .include "data/compressed/image/landmarkB.asm"
    .include "data/compressed/text/talkB.asm"

.segment "ROM4"
    .include "data/compressed/image/landmarkC.asm"
    .include "data/compressed/text/talkC.asm"

.segment "ROM5"
    .include "data/compressed/image/landmarkD.asm"
    .include "data/compressed/text/talkD.asm"

.segment "ROM6"
    .include "data/compressed/image/landmarkE.asm"
    .include "data/compressed/text/talkE.asm"

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

resetSentinalKey:
    .byte _O_,_R_,_E_,_G_,_O_,_N_

.proc reset
    SEI
    CLD
    LDX #$FF
    TXS
    INX
    STX PPUCTRL
    STX PPUMASK
    STX DMCFREQ
    : ; vblankwait
    BIT PPUSTATUS
    BPL :-
    LDX #0 ; Check for reset sentinal in memory
    LDY #0
    :
    LDA resetSentinal, Y
    CMP resetSentinalKey, Y
    BNE :+
    INY
    CPY #6
    BNE :-
    LDX #1
    :
    TXA
    TAY
    LDX #0 ; clear memory
    :
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
    CPX #MEM_PRESERVED
    BCS :+
    CPY #1
    BNE :+ ; don't clear preserved memory if sentinal is set
    JMP :++
    :
    STA $0300, X
    :
    INX
    BNE :---
    TYA
    PHA
    LDY #0 ; load sentinal value into memory
    :
    LDA resetSentinalKey, Y
    STA resetSentinal, Y
    INY
    CPY #6
    BNE :-
    PLA
    TAY
    LDA #%10000000 ; default gameSettings
    STA gameSettings
    CPY #1 ; set default high scores if this is a hard reset
    BEQ :++
    LDX #0
    :
    LDA topTenDefault, X
    STA oregonTopTen, X
    INX
    CPX #100 ; len of topTenDefault data in entirety
    BNE :-
    : ; vblankwait
    BIT PPUSTATUS
    BPL :-

    JSR ClearScreen
    LDA #%10010000      ; enable NMI, sprites use first pattern table
    STA softPPUCTRL
    STA PPUCTRL

    JSR InitStateTitle
    JMP main
.endproc

.proc main
    JSR ReadController1
    LDA buttons1
    STA buttons1Last    ; Remember last controller inputs
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

.include "code/shared.asm"
.include "data/meta.asm"
.include "data/raw/palettes.asm"
.include "data/raw/text/text.asm"
.include "data/compressed/text/dictionary.asm"
.include "data/compressed/text/talkPointer.asm"
