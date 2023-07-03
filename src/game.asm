.include "constants.inc"
.include "header.inc"
.include "palettes.inc"
.include "backgrounds.inc"
.include "sprites.inc"
.include "text.inc"
.include "zeropage.inc"
.include "diarytext.inc"
.include "vars.inc"

;-------------------------------------------------------------------------------
.segment "CHARS"
    .incbin "../graphics/tiles.chr"

;-------------------------------------------------------------------------------
.segment "VECTORS"
    .addr nmi, reset, irq

;-------------------------------------------------------------------------------
.segment "CODE"
;--------------------------------------

.proc irq
    RTI
.endproc

;--------------------------------------

.proc reset
    SEI
    CLD
    LDX #$FF
    TXS
    INX
    STX PPUCTRL
    STX PPUMASK
    STX DMCFREQ


    JSR LoadPalette
    JSR LoadBackground
    ;JSR InitHUD
    JSR LoadBackgroundAttribute
    JSR InitOxenSprite
    JSR InitWagonSprite

    ; zero sprite
    LDA #$37         ; Y
    STA ZEROSPRITE
    LDA _O_          ; tile index
    STA ZEROSPRITE+1
    LDA #%00000001   ; attr
    STA ZEROSPRITE+2
    LDA #$F0         ; X
    STA ZEROSPRITE+3

vblankwait1:
    BIT PPUSTATUS
    BPL vblankwait1

clearmemory:
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
    BNE clearmemory

vblankwait2:
    BIT PPUSTATUS
    BPL vblankwait2

    LDA #%10010000 ; turn on NMIs, sprites use first pattern table
    STA PPUCTRL

    LDA #%00011110 ; turn on screen
    STA PPUMASK

    JMP main

.endproc

;--------------------------------------

.proc main
forever:
    JMP forever
.endproc

;--------------------------------------

.proc nmi
    JSR InitPPU
    JSR ReadController1
    JSR UpdateSprites
    JSR UpdateScreen
    INC frameCounter
    RTI
.endproc

;--------------------------------------

;--SUBROUTINES------------------------------------------------------------------

;;;;;; Preserve all registers template
; .proc my_subroutine
;   PHP
;   PHA
;   TXA
;   PHA
;   TYA
;   PHA
;   ; your actual subroutine code here
;   PLA
;   TAY
;   PLA
;   TAX
;   PLA
;   PLP
;   RTS
; .endproc

;--------------------------------------
.proc InitPPU
    LDA #$00
    STA OAMADDR ; tell PPU to prepare for transfer to OAM starting at byte zero
    LDA #$02
    STA OAMDMA ; tell PPU to initiate transfer of 256 bytes $0200-$02ff into OAM

    LDA #0
    STA PPUADDR
    STA PPUADDR

    LDA #%10010000 ;enable NMI, sprites from Pattern 0, background from Pattern 1
    STA PPUCTRL
    LDA #%00011110 ; enable sprites, enable background
    STA PPUMASK

    LDA #0
    STA PPUADDR
    STA PPUADDR ; clean up ppu address registers
    RTS
.endproc

;--------------------------------------
.proc UpdateScreen
    LDX globalScroll
    DEX
    STX PPUSCROLL ; horizontal scroll (globalScroll - 1)
    LDA #0
    STA PPUSCROLL ; vertical scroll (0)
    STX globalScroll ; update globalScroll
; CheckSprite0Hit:
;     LDA PPUSTATUS
;     AND #%01000000
;     BNE @hit
;     ; don't freeze scrolling.
;     LDA globalScroll
;     STA PPUSCROLL ;horizontal
;     LDA #0
;     STA PPUSCROLL ;vertical
;     JMP @noHit
; @hit:
;     ; freeze scrolling.
;     LDA #0
;     STA PPUSCROLL ;horizontal
;     STA PPUSCROLL ;vertical
; @noHit:
;     RTS
CheckSprite0Hit: ; t. @cuttercross
    LDA #%11000000  ;; We'll bit test for both sprite0 flag and vBlank flag at the same time 
                    ;; [Safety measure to prevent a full lockup scenario on sprite0 miss]
@sprite0Poll1:
    BIT PPUSTATUS
    BNE @sprite0Poll1    ;; Ensure that sprite0 + vBlank flag are clear before proceeding
@sprite0Poll2:
    BIT PPUSTATUS 
    BEQ @sprite0Poll2    ;; Wait for sprite0 flag to be set
    ;; Freeze scroll for status bar
    LDA #0
    STA PPUSCROLL 
    STA PPUSCROLL
    RTS
.endproc

;--------------------------------------
.proc ReadController1
    PHP
    PHA
    TXA
    PHA
    TYA
    PHA
    LDA #$01
    STA $4016
    LDA #$00
    STA $4016
    LDX #$08
@loop:
    LDA $4016
    LSR A
    ROL buttons1
    DEX
    BNE @loop
    PLA
    TAY
    PLA
    TAX
    PLA
    PLP
    RTS
.endproc

;--------------------------------------
LoadPalette:
    LDA PPUSTATUS

    LDA #$3F
    STA PPUADDR
    LDA #$00
    STA PPUADDR ; $3F00

    LDX #0
@loop:
    LDA palette, X
    STA PPUDATA
    INX
    CPX #32
    BNE @loop
    RTS

;--------------------------------------
LoadBackground:
    LDA PPUSTATUS
    LDA #$20
    STA PPUADDR
    LDA #$00
    STA PPUADDR ; $2000

    LDX #0
    LDY #0
@repeatLoop:
    INY
@loop:
    LDA terrain, X
    STA PPUDATA
    INX
    CPX #$00
    BNE @loop
    LDA #$24
    STA PPUADDR
    LDA #$00
    STA PPUADDR ; $2400
    LDX #0
    CPY #2
    BNE @repeatLoop

    LDA #$21
    STA PPUADDR
    LDA #$00
    STA PPUADDR ; $2100
    LDX #0
@loop2:
    LDA hud1, X
    STA PPUDATA
    INX
    CPX #$00
    BNE @loop2

@loop3:
    LDA hud2, X
    STA PPUDATA
    INX
    CPX #$00
    BNE @loop3

@loop4:
    LDA hud3, X
    STA PPUDATA
    INX
    CPX #$C0
    BNE @loop4

    RTS

;--------------------------------------
LoadBackgroundAttribute:
    LDA PPUSTATUS
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR ; $23C0 (first screen attribute table)

    LDX #0
    LDY #0
@repeatLoop:
    INY
@loop:
    LDA bgAttribute, X
    STA PPUDATA
    INX
    CPX #$40
    BNE @loop

    LDX #0
    LDA PPUSTATUS ; load second screen attr table
    LDA #$27
    STA PPUADDR
    LDA #$C0
    STA PPUADDR ; $27C0 (attribute table)
    CPY #2
    BNE @repeatLoop ; 2nd screen

    RTS

;--------------------------------------
UpdateSprites:
    LDA frameCounter
    CLC
    ROL
    CMP #$80
    BNE @skipOxenUpdate
    LDA frameCounter
    JSR UpdateOxenSprite
    LDA #$00
@skipOxenUpdate:
    LDA frameCounter
    CLC
    ROL
    CMP #$00
    BNE @skipWagonUpdate
    JSR UpdateWagonSprite
@skipWagonUpdate:
    RTS

;--------------------------------------
InitOxenSprite:
    LDX #0
@loop:
    LDA oxenSprites, X
    STA OXENSPRITES, X
    INX
    CPX #40
    BNE @loop
    RTS

;--------------------------------------
UpdateOxenSprite:
    LDA oxenFrame
    CMP #1
    BNE @update
    JSR InitOxenSprite
@update:
    LDX #1 ; start on tile index
    LDY #0
    STY helper ; use the stack!!!
@animLoop:
    LDA oxenAnimation, Y
    AND oxenFrame
    CMP #0
    BEQ @skipTileIncrement
    LDA #1
    STA helper
@skipTileIncrement:
    LDA OXENSPRITES, X
    CLC
    ADC helper
    STA OXENSPRITES, X
    INX
    INX
    INX
    INX
    INY
    LDA #0
    STA helper
    CPX #41
    BNE @animLoop

; clear helper
    LDA #0
    STA helper

; increment frame
    CLC
    LDA oxenFrame
    ROL
    STA helper
    AND #%00011111
    CMP #0
    BNE @animDone
    LDA #$01 ; reset animation
    STA helper
@animDone:
    LDA helper
    STA oxenFrame

    RTS

;--------------------------------------
InitWagonSprite:
    LDX #0
@loop:
    LDA wagonSprites, X
    STA WAGONSPRITES, X
    INX
    CPX #48
    BNE @loop
    RTS

;--------------------------------------
UpdateWagonSprite:
    LDA frameCounter
    CMP #$80
    BNE @update
    JSR InitWagonSprite
    JMP @done
@update:
    LDX #1 ; start on tile index
    LDY #0
@animLoop:
    LDA WAGONSPRITES, X
    PHA
    CPY #5
    BMI @skipTile
    PLA
    CLC
    ADC #1
    PHA
@skipTile:
    PLA
    STA WAGONSPRITES, X
    INX
    INX
    INX
    INX
    INY
    CPX #49
    BNE @animLoop
@done:
    RTS

;--------------------------------------
; UpdateHello:

;     LDA hello_Y
;     STA $200
;     LDA #7 ; tile 7 'H'
;     STA $201
;     LDA #0
;     STA $202
;     LDA hello_X
;     STA $203

;     LDA hello_Y
;     STA $204
;     LDA #4 ; tile 4 'E'
;     STA $205
;     LDA #0
;     STA $206
;     LDA hello_X
;     CLC
;     ADC #8
;     STA $207

;     LDA hello_Y
;     STA $208
;     LDA #11 ; tile 11 'L'
;     STA $209
;     LDA #0
;     STA $20A
;     LDA hello_X
;     CLC
;     ADC #16
;     STA $20B

;     LDA hello_Y
;     STA $20C
;     LDA #11 ; tile 11 'L'
;     STA $20D
;     LDA #0
;     STA $20E
;     LDA hello_X
;     CLC
;     ADC #24
;     STA $20F

;     LDA hello_Y
;     STA $210
;     LDA #%1110 ; tile 'O'
;     STA $211
;     LDA #0
;     STA $212
;     LDA hello_X
;     CLC
;     ADC #32
;     STA $213

;     RTS

;--------------------------------------
; LoadNametable:
;     LDA PPUSTATUS
;     LDA #$20
;     STA PPUADDR
;     LDA #$00
;     STA PPUADDR
;     LDX #$00
;     LDX #$00
; OutsideLoop:

; InsideLoop:

;     LDA (pointer), Y
;     STA PPUDATA
;     INY
;     CPY #0
;     BNE InsideLoop

;     INC pointer+1
;     INX
;     CPX #4
;     BNE OutsideLoop

;     RTS