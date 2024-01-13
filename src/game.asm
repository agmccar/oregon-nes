.include "constants.asm"
.include "header.asm"
.include "macros.asm"
.include "charmap.asm"

.segment "VECTORS"
    .addr nmi, reset, irq
    
.segment "ZEROPAGE"
    .include "zeropage.asm"

.segment "DECOMPRESS"
    .import DecompressTokumaru

.segment "BSS"
    .include "vars.asm"

.segment "ROM0"
    ; shared
    .include "data/compressed/image/adornment.asm"

    ; new game, matt's general store
    .include "data/compressed/image/map.asm"
    .include "data/compressed/image/matt.asm"
    .include "data/compressed/image/nameparty.asm"
    .include "data/compressed/image/suppliesTiles.asm"
    .include "data/compressed/image/textTiles.asm"
    .include "data/compressed/image/titleLogo.asm"
    .include "data/compressed/image/supplies.asm"
    .include "data/raw/climate.asm"

    ; title screen
    .include "code/title.asm"
    .include "data/compressed/text/learn.asm"
    .include "data/compressed/text/sound.asm"
    .include "data/compressed/text/top10.asm"

.segment "ROM1"
    ; new game, matt's general store
    .include "code/newgame.asm"
    .include "code/matt.asm"
    .include "data/compressed/text/newgame.asm"
    .include "code/store.asm"

    ; hunting
    .include "data/raw/hunting.asm"
    .include "data/compressed/image/hunting.asm"

.segment "ROM2"
    ; landmark
    .include "data/compressed/image/landmarkA.asm"
    .include "data/compressed/text/talkA.asm"

.segment "ROM3"
    ; landmark
    .include "data/compressed/image/landmarkB.asm"
    .include "data/compressed/text/talkB.asm"

.segment "ROM4"
    ; landmark
    .include "data/compressed/image/landmarkC.asm"
    .include "data/compressed/text/talkC.asm"

.segment "ROM5"
    ; landmark
    .include "data/compressed/image/landmarkD.asm"
    .include "data/compressed/text/talkD.asm"

.segment "ROM6"

    ; traveling
    .include "data/compressed/image/wagon.asm"
    .include "data/compressed/image/horizonPlains.asm"
    .include "data/compressed/image/horizonMountains.asm"
    .include "data/compressed/text/traveling.asm"
    .include "data/raw/backgrounds.asm" ; wagon animation
    .include "data/raw/image/suppliesRaw.asm" ; todo compress
    .include "data/raw/sprites.asm"
    .include "code/traveling.asm"
    ; random events
    .include "data/raw/randomevents.asm"
    .include "data/compressed/image/randomevents.asm"

    ; landmark
    .include "code/landmark.asm"

    ; river crossing
    .include "code/river.asm"
    .include "data/compressed/image/riverTiles.asm"
    .include "data/compressed/text/river.asm"
    .include "data/raw/image/river.asm"

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


IdentifySystem:
	; Enable NMI temporarily
	lda #$80
    sta softPPUCTRL
	sta PPUCTRL
	sta WhichSystem
	ldx #0
	ldy #0
	lda NMIcounter
    :
    	cmp NMIcounter
	beq :-
	lda NMIcounter
    @wait:
	; Each iteration takes 11 cycles.
	; NTSC NES: 29780 cycles or 2707 = $A93 iterations
	; PAL NES:  33247 cycles or 3022 = $BCE iterations
	; Dendy:    35464 cycles or 3224 = $C98 iterations
	; so we can divide by $100 (rounding down), subtract ten,
	; and end up with 0=ntsc, 1=pal, 2=dendy, 3=unknown
	inx
	Jne :+
	iny
    :
    	cmp NMIcounter
	Jeq @wait
	tya
	sec
	sbc #10
	cmp #3
	bcc :+
	lda #3
    :
    	sta WhichSystem
	; Disable NMI again
	lda #0
    sta softPPUCTRL
	sta PPUCTRL
	rts

.proc reset
    SEI
    CLD
    LDX #$FF
    TXS
    INX
    STX softPPUCTRL
    STX PPUCTRL
    STX softPPUMASK
    STX PPUMASK
    STX DMCFREQ
    : ; vblankwait
    BIT PPUSTATUS
    BPL :-
	jsr IdentifySystem ; tokumaru
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

    ; lda #$10 ; barf some data into chrrom
    ; sta PPUADDR
    ; lda #$00
    ; sta PPUADDR
    ; ldy #0
    ; ldx #16
    ; :
    ; sty PPUDATA
    ; dey
    ; bne :-
    ; dex
    ; bne :-

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
    inc NMIcounter
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