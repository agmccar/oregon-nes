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

    vblankwait:
        BIT PPUSTATUS
        BPL vblankwait

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


    ; initialize zeropage and vars variables
        ; Default 0: 
        ; pointer, sprite0hit, helper, frameCounter, globalScroll, gameState,
        ; oxenFrame, wagonStatus, traveledMi, traveledDigit, menuOpen,
        ; buttons1, dollars, foodLbs, foodDigit, clothingSets, bullets,
        ; spareParts, oxenHeadcount, dateYear, dateMonth, dateDay,
        ; personStatus
        LDA #%00001101
        STA wagonSettings
        LDA #%00000100
        STA weather
        
        ; set default person names
        LDX #0
    defaultPersonNameLoop:
        LDA defaultPersonNames, X
        STA personName, X
        INX
        CPX #20
        BNE defaultPersonNameLoop

    ; Initialize game state
        ;JSR InitStateTitle
        LDA #$FF
        STA lastGameState

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
    LDA #$00
    STA OAMADDR ; tell PPU to prepare for transfer to OAM starting at byte zero
    LDA #$02
    STA OAMDMA ; tell PPU to initiate transfer of 256 bytes $0200-$02ff into OAM

    LDA #0
    STA PPUADDR
    STA PPUADDR


    JSR ReadController1
    JSR CheckGameState
    JSR UpdateScreen
    JSR UpdateSprites
    INC frameCounter

    ; LDA #%10010000 ;enable NMI, sprites from Pattern 0, background from Pattern 1
    ; STA PPUCTRL
    ; LDA #%00011110 ; enable sprites, enable background
    ; STA PPUMASK

    ; LDA #0
    ; STA PPUADDR
    ; STA PPUADDR ; clean up ppu address registers
    
    RTI
.endproc

;--------------------------------------

;--SUBROUTINES------------------------------------------------------------------

.proc CheckGameState
    LDA lastGameState
    CMP gameState
    BEQ Done ; No state change: goto Done

    ; State changed:
    LDA #%00010000      ; disable NMI, sprites from Pattern 0, background from Pattern 1
    STA PPUCTRL
    LDA #%00000000      ; disable sprites, disable background
    STA PPUMASK
    STA bgLoaded        ; reload background
    LDA gameState   
    STA lastGameState   ; update lastGameState

    CheckStateTitle:
        CMP #GAMESTATE_TITLE
        BNE CheckStateTraveling
        JSR InitStateTitle
        JMP Done

    CheckStateTraveling:
        CMP #GAMESTATE_TRAVELING
        BNE CheckStateNewGame
        JSR InitStateTraveling
        JMP Done

    CheckStateNewGame:
        CMP #GAMESTATE_NEWGAME
        BNE CheckStateStore
        JSR InitStateNewGame
        JMP Done

    CheckStateStore:
        CMP #GAMESTATE_STORE
        BNE CheckStateStartDate
        JSR InitStateStore
        JMP Done

    CheckStateStartDate:
        CMP #GAMESTATE_STARTDATE
        BNE CheckStateLandmark
        JSR InitStateStartDate
        JMP Done

    CheckStateLandmark:
        CMP #GAMESTATE_LANDMARK
        BNE CheckStateMap
        JSR InitStateLandmark
        JMP Done

    CheckStateMap:
        CMP #GAMESTATE_MAP
        BNE Done
        JSR InitStateMap
        JMP Done

    Done:
        LDA #%10010000 ;enable NMI, sprites from Pattern 0, background from Pattern 1
        STA PPUCTRL
        LDA #%00011110 ; enable sprites, enable background
        STA PPUMASK
    RTS
.endproc

;--------------------------------------

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
.proc UpdateScreen

    ; LDA #%00010000      ; disable NMI, sprites from Pattern 0, background from Pattern 1
    ; STA PPUCTRL
    ; LDA #%00000000      ; disable sprites, disable background
    ; STA PPUMASK
    ; lda #$00
    ; sta $2006        ; clean up PPU address registers
    ; sta $2006

    LDA gameState

    CMP #GAMESTATE_TITLE
    BEQ Title

    CMP #GAMESTATE_TRAVELING
    BEQ Traveling

    CMP #GAMESTATE_NEWGAME
    BEQ NewGame

    CMP #GAMESTATE_STORE
    BEQ Store

    CMP #GAMESTATE_STARTDATE
    BEQ StartDate

    CMP #GAMESTATE_LANDMARK
    BEQ Landmark

    CMP #GAMESTATE_MAP
    BEQ Map

    Title:
        JMP Done
        
    NewGame:
        JMP Done
        
    Store:
        JMP Done
        
    StartDate:
        JMP Done
        
    Landmark:
        JMP Done
        
    Map:
        JMP Done

    Traveling:
        LDX globalScroll
        DEX
        STX PPUSCROLL ; horizontal scroll (globalScroll - 1)
        LDA #0
        STA PPUSCROLL ; vertical scroll (0)
        STX globalScroll ; update globalScroll
    ; CheckSprite0Hit: ; t. @cuttercross
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
        JMP Done

    Done:
    LDA #1
    STA bgLoaded
    RTS
.endproc

;--------------------------------------
.proc InitStateTitle

    JSR LoadPalette
    
    LoadBackground:
        LDA PPUSTATUS
        LDA #$20
        STA PPUADDR
        LDA #$00
        STA PPUADDR 

        LDX #0
        LDY #0
    @repeatLoop:
        INY
    @loop:
        LDA #___
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
        LDA #___
        CPX #8 ; 25% across screen
        BCC @skipTitleText2
        CPX #24; 75% across screen
        BCS @skipTitleText2

        TXA
        STA helper
        SBC #7
        TAX
        LDA titleText, X
        TAX
        LDA helper
        STX helper
        TAX
        LDA helper

    @skipTitleText2:
        STA PPUDATA
        INX
        CPX #$00
        BNE @loop2

    @loop3:
        LDA #___
        CPX #10 ; >25% across screen
        BCC @skipTitleText3
        CPX #22; <75% across screen
        BCS @skipTitleText3

        TXA
        STA helper
        SBC #9
        TAX
        LDA titleOptions, X
        TAX
        LDA helper
        STX helper
        TAX
        LDA helper

    @skipTitleText3:
        STA PPUDATA
        INX
        CPX #$00
        BNE @loop3

    @loop4:
        LDA #___
        STA PPUDATA
        INX
        CPX #$C0
        BNE @loop4

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
        LDA #$FF
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

    LDA #1
    STA bgLoaded
    RTS
.endproc

;--------------------------------------
.proc InitStateNewGame

    ; sprite: hand pointing right..or not
    ; LDA #48
    ; STA ZEROSPRITE+4 ; +y
    ; LDA #_PR
    ; STA ZEROSPRITE+5 ; tile index (Wrong pattern table..)
    ; LDA #0
    ; STA ZEROSPRITE+6 ; oam attributes
    ; LDA #40
    ; STA ZEROSPRITE+7 ; +x

    JSR LoadPalette
    
    LoadBackground:
        LDA PPUSTATUS
        LDA #$20
        STA PPUADDR
        LDA #$00
        STA PPUADDR 
        
        LDX #0
    @blank1:
        LDA #___
        STA PPUDATA
        INX
        CPX #$85
        BNE @blank1

        LDX #0
    @textLeader:
        LDA newGameText, X
        STA PPUDATA
        INX
        CPX #7
        BNE @textLeader

        LDX #0
    @blank2:
        LDA #___
        STA PPUDATA
        INX
        CPX #3
        BNE @blank2

        LDX #7
    @textOccupation:
        LDA newGameText, X
        STA PPUDATA
        INX
        CPX #18
        BNE @textOccupation

        LDX #0
    @blank3:
        LDA #___
        STA PPUDATA
        INX
        CPX #$AB
        BNE @blank3

        LDX #18
    @textOtherPartyMembers:
        LDA newGameText, X
        STA PPUDATA
        INX
        CPX #38
        BNE @textOtherPartyMembers

        LDX #0
    @blank4:
        LDA #___
        STA PPUDATA
        INX
        CPX #$27
        BNE @blank4

    ; fill the rest blank
        LDX #0
    @fill:
        LDA #___
        STA PPUDATA
        STA PPUDATA
        STA PPUDATA
        INX
        CPX #$C0
        BNE @fill

    ; initialize cursor: (5x,6y) tiles from top left, facing R
    LDA #5
    STA fingerX
    LDA #6
    STA fingerY
    LDA #0
    STA fingerAttr
    LDA PPUSTATUS
    LDA #$20
    STA PPUADDR
    LDA #$C5
    STA PPUADDR 
    LDA #_PR
    STA PPUDATA

    ; draw blanks/underlines 
    
    LDA PPUSTATUS ; leader name
    LDA #$20
    STA PPUADDR
    LDA #$C7
    STA PPUADDR
    LDA #_UL
    LDX #0
    @underline1:
        STA PPUDATA
        INX
        CPX #4
        BNE @underline1 
    
    LDA PPUSTATUS ; occupation
    LDA #$20
    STA PPUADDR
    LDA #$D0
    STA PPUADDR
    LDA #_UL
    LDX #0
    @underline2:
        STA PPUDATA
        INX
        CPX #11
        BNE @underline2 
    
    LDA PPUSTATUS ; party member 2
    LDA #$21
    STA PPUADDR
    LDA #$87
    STA PPUADDR
    LDA #_UL
    LDX #0
    @underline3:
        STA PPUDATA
        INX
        CPX #4
        BNE @underline3
    
    LDA PPUSTATUS ; party member 3
    LDA #$21
    STA PPUADDR
    LDA #$91
    STA PPUADDR
    LDA #_UL
    LDX #0
    @underline4:
        STA PPUDATA
        INX
        CPX #4
        BNE @underline4
    
    LDA PPUSTATUS ; party member 4
    LDA #$21
    STA PPUADDR
    LDA #$C7
    STA PPUADDR
    LDA #_UL
    LDX #0
    @underline5:
        STA PPUDATA
        INX
        CPX #4
        BNE @underline5
    
    LDA PPUSTATUS ; party member 5
    LDA #$21
    STA PPUADDR
    LDA #$D1
    STA PPUADDR
    LDA #_UL
    LDX #0
    @underline6:
        STA PPUDATA
        INX
        CPX #4
        BNE @underline6

    ;;;;;;;;;;;;;;;;
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
        LDA #$FF
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

        LDA #1
        STA bgLoaded
    RTS
.endproc

;--------------------------------------
.proc InitStateStore
    RTS
.endproc

;--------------------------------------
.proc InitStateStartDate
    RTS
.endproc

;--------------------------------------
.proc InitStateLandmark
    RTS
.endproc

;--------------------------------------
.proc InitStateMap
    RTS
.endproc

;--------------------------------------
.proc InitStateTraveling
    ; zero sprite
    LDA #$37         ; Y
    STA ZEROSPRITE
    LDA #0          ; tile index
    STA ZEROSPRITE+1
    LDA #%00000001   ; attr
    STA ZEROSPRITE+2
    LDA #$F0         ; X
    STA ZEROSPRITE+3
        
    JSR LoadPalette

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

        JSR InitOxenSprite
        JSR InitWagonSprite
    RTS
.endproc

;--------------------------------------
.proc ReadController1
    ; preserve registers
    PHP
    PHA
    TXA
    PHA
    TYA
    PHA
    ; read inputs
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

        LDA gameState

        CMP #GAMESTATE_TRAVELING
        BEQ Traveling

        CMP #GAMESTATE_TITLE
        BEQ Title

        CMP #GAMESTATE_NEWGAME
        BEQ NewGame

        CMP #GAMESTATE_STORE
        BEQ Store

        CMP #GAMESTATE_STARTDATE
        BEQ StartDate

        CMP #GAMESTATE_LANDMARK
        BEQ Landmark

        CMP #GAMESTATE_MAP
        BEQ Map

    Title:
        LDA #KEY_START
        BIT buttons1
        BEQ @skip
        LDA #GAMESTATE_NEWGAME
        STA gameState
    @skip:
        JMP Done
        
    NewGame:
        JMP Done
        
    Store:
        JMP Done
        
    StartDate:
        JMP Done
        
    Landmark:
        JMP Done
        
    Map:
        JMP Done

    Traveling:
        JMP Done

    Done:
        ; preserve registers
        PLA
        TAY
        PLA
        TAX
        PLA
        PLP
    RTS
.endproc

;--------------------------------------
.proc LoadPalette
    LDA PPUSTATUS

    LDA #$3F
    STA PPUADDR
    LDA #$00
    STA PPUADDR ; $3F00

    LDX #0
    loop:
        LDA palette, X
        STA PPUDATA
        INX
        CPX #32
        BNE loop
    RTS
.endproc

;--------------------------------------
.proc UpdateSprites
    LDA gameState

    CMP #GAMESTATE_TRAVELING
    BEQ Traveling

    CMP #GAMESTATE_TITLE
    BEQ Title

    CMP #GAMESTATE_NEWGAME
    BEQ NewGame

    CMP #GAMESTATE_STORE
    BEQ Store

    CMP #GAMESTATE_STARTDATE
    BEQ StartDate

    CMP #GAMESTATE_LANDMARK
    BEQ Landmark

    CMP #GAMESTATE_MAP
    BEQ Map

    Title:
        JMP Done
        
    NewGame:
        JMP Done
        
    Store:
        JMP Done
        
    StartDate:
        JMP Done
        
    Landmark:
        JMP Done
        
    Map:
        JMP Done

    Traveling:
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
        JMP Done

    Done:
    RTS
.endproc

;--------------------------------------
.proc InitOxenSprite
    LDX #0
    @loop:
        LDA oxenSprites, X
        STA OXENSPRITES, X
        INX
        CPX #40
        BNE @loop
    RTS
.endproc

;--------------------------------------
.proc UpdateOxenSprite
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
.endproc

;--------------------------------------
.proc InitWagonSprite
    LDX #0
    @loop:
        LDA wagonSprites, X
        STA WAGONSPRITES, X
        INX
        CPX #48
        BNE @loop
    RTS
.endproc

;--------------------------------------
.proc UpdateWagonSprite
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
.endproc

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