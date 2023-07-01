.INCLUDE "objvars.inc"

;--------------------------------------
.SEGMENT "CHARS"
    .INCBIN "tiles.chr"

;--------------------------------------
.SEGMENT "HEADER"
    .BYTE "NES", $1A
    .BYTE $01
    .BYTE $01
    .BYTE %00000001 ; type of mapper - last bit specifies mirroring
    .BYTE $0, $0, $0, $0, $0, $0

;--------------------------------------
.SEGMENT "VECTORS"
    .WORD nmi, reset, 0 ;irq=0

;--------------------------------------
.SEGMENT "RODATA"

palette:
    ; background palette data
    .byte $21, $25, $19, $30 ; Sky, Pink, Trees, White
    .byte $21, $19, $29, $30 ; Sky, Trees, Grass, White
    .byte $21, $06, $29, $30 ; Sky, Brown, Grass, White
    .byte $21, $00, $10, $30 ;
    ; sprite palette data
    .byte $21, $00, $10, $30 ; Black, Grey, LGrey, White
    .byte $21, $00, $10, $30 ; 
    .byte $21, $00, $10, $30 ;
    .byte $21, $00, $10, $30 ;

terrain:
    .byte $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00
    .byte $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00

    .byte $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00
    .byte $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00
    
    .byte $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $01,$02,$03,$00
    .byte $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $01,$02,$03,$00
    
    .byte $04,$05,$06,$07, $08,$09,$0A,$0B, $0C,$0D,$0E,$0F, $10,$11,$12,$13
    .byte $04,$05,$06,$07, $08,$09,$0A,$0B, $0C,$0D,$0E,$0F, $10,$11,$12,$13

    .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20
    .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20

    .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20
    .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20

    .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20
    .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20

    .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20
    .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20
    
    ; .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20
    ; .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$30, $31,$32,$33,$34

    ; .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20
    ; .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$35, $36,$37,$38,$39

    ; .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20
    ; .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$3A, $3B,$3D,$3F,$41

bgAttribute:
    .byte %00000000,%00000000
    .byte %00000000,%00000000
    .byte %00000000,%00000000
    .byte %00000000,%00000000
    .byte %10101010,%10101010
    .byte %10101010,%10101010
    .byte %10101010,%10101010
    .byte %10101010,%10101010

;-----------------------------------------------------------
; 76543210  OAM Attributes
; ||||||||
; ||||||++- Palette (4 to 7) of sprite
; |||+++--- Unimplemented (read 0)
; ||+------ Priority (0: in front of background; 1: behind background)
; |+------- Flip sprite horizontally
; +-------- Flip sprite vertically

oxenSprites:
    ; +Y, tile index, attributes, +X
    .byte $27, $20, $00, $B8 ;$A0 ; tile 0   0 1
    .byte $27, $21, $00, $C0 ;$A8 ; tile 1   2 3 4 5
    .byte $2F, $22, $00, $B8 ;$A0 ; tile 2   6 7 8 9
    .byte $2F, $23, $00, $C0 ;$A8 ; tile 3
    .byte $2F, $24, $00, $C8 ;$B0 ; tile 4
    .byte $2F, $29, $00, $D0 ;$B8 ; tile 5
    .byte $37, $2B, $00, $B8 ;$A0 ; tile 6
    .byte $37, $2F, $00, $C0 ;$A8 ; tile 7
    .byte $37, $34, $00, $C8 ;$B0 ; tile 8
    .byte $37, $39, $00, $D0 ;$B8 ; tile 9

oxenAnimation:
    ; how much to increment each tile
    ; 76543210
    ; |||||||+- frame 0(unused)
    ; ||||||+-- frame 1
    ; |||||+--- frame 2
    ; ||||+---- frame 3
    ; |||+----- frame 4
    ; ||+------ increment cumulatively y/n
    ; ++------- unused
    .byte %00100000 ; tile 0: 20,20,20,20,20
    .byte %00100000 ; tile 1: 21,21,21,21,21
    .byte %00100000 ; tile 2: 22,22,22,22,22
    .byte %00100000 ; tile 3: 23,23,23,23,23
    .byte %00111110 ; tile 4: 24,25,26,27,28
    .byte %00110000 ; tile 5: 29,29,29,29,2A ! todo %00000010
    .byte %00110110 ; tile 6: 2C,2D,2E,2E,2F
    .byte %00111110 ; tile 7: 30,31,32,33,34
    .byte %00111110 ; tile 8: 35,36,37,38,39
    .byte %00111110 ; tile 9: 3A,3B,3C,3D,3E

wagonSprites:
    ; +Y, tile index, attributes, +X
    .byte $27, $3E, $00, $D8 ; tile 0   0 1 2 3
    .byte $27, $3F, $00, $E0 ; tile 1   4 5 6 7
    .byte $27, $40, $00, $E8 ; tile 2   8 9 A B
    .byte $27, $41, $00, $F0 ; tile 3
    .byte $2F, $42, $00, $D8 ; tile 4
    .byte $2F, $43, $00, $E0 ; tile 5 (2 frame animation)
    .byte $2F, $45, $00, $E8 ; tile 6 (2 frame animation)
    .byte $2F, $47, $00, $F0 ; tile 7 (2 frame animation)
    .byte $37, $49, $00, $D8 ; tile 8 (2 frame animation)
    .byte $37, $4B, $00, $E0 ; tile 9 (2 frame animation)
    .byte $37, $4D, $00, $E8 ; tile A (2 frame animation)
    .byte $37, $4F, $00, $F0 ; tile B (2 frame animation)

;--------------------------------------
.SEGMENT "ZEROPAGE"

pointer: .RES 2
helper: .RES 1
frameCounter: .RES 1
globalScroll: .RES 1

;--------------------------------------
.SEGMENT "BSS"

oxenFrame: .RES 1 ; frame 0=$01; 1=$02; 2=$04, 3=$08, 4=$10
oxenPace: .RES 1 
; todo ^ oxenAttributes: res 1 ; cram more into 1 byte ?

;hello_X: .RES 1

; Constants
;DUDE = $0200

;--------------------------------------
.SEGMENT "CODE"

reset:
    SEI
    CLD
    LDX #$FF
    TXS
    INX
    STX $2000 ; PpuControl_2000
    STX $2001 ; PpuMask_2001
    STX $4010 ; DmcFreq_4010

    ; initialize variables
    LDA #$10
    STA oxenPace
    LDA #$00
    STA globalScroll

    JSR LoadPalette
    JSR LoadBackground
    JSR LoadBackgroundAttribute
    JSR InitOxenSprite
    JSR InitWagonSprite

vblankwait1:
    BIT PPUSTATUS ; PpuStatus_2002
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
    BIT PPUSTATUS ; PpuStatus_2002
    BPL vblankwait2

    LDA #%10010000
    STA $2000 ; PpuControl_2000

    LDA #%00011110
    STA $2001

loadpalettes:
    LDA PPUSTATUS
    LDA #$3F
    STA PPUADDR
    LDA #$00
    STA PPUADDR

forever:
    JMP forever

;-------------------------------------------------------------------------------

nmi:
    LDA #$00
    STA $2003 ; OamAddr_2003
    LDA #$02
    STA $4014 ; SpriteDma_4014

    ;JSR UpdateHello

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
    JSR IncrementFrameCounter


    LDA #0
    STA PPUADDR
    STA PPUADDR

    LDA #%10010000;enable NMI, sprites from Pattern 0, background from Pattern 1
    STA $2000 ; PpuControl_2000
    LDA #%00011110 ; enable sprites, enable background
    STA $2001 ; PpuMask_2001

    LDA #$00
    STA $2006
    STA $2006 ; clean up ppu address registers

    LDX globalScroll
    DEX
    STX PPUSCROLL ; horizontal scroll (globalScroll - 1)
    STA PPUSCROLL ; vertical scroll (0)
    STX globalScroll ; update globalScroll
    

    RTI

;--SUBROUTINES------------------------------------------------------------------

IncrementFrameCounter:
    LDA frameCounter
    CLC
    ADC #$08
    STA frameCounter
    RTS

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
    CPX #$10
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