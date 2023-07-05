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
    PHA
    TXA
    PHA
    TYA
    PHA

    JSR UpdateSprites
    JSR ReadController1
    JSR CheckGameState
    JSR UpdateBg
    
    LDA buttons1
    STA buttons1Last    ; Remember last controller inputs
    LDA menuOpen
    STA menuOpenLast    ; Remember last menu open

    INC frameCounter
    
    PLA
    TAY
    PLA
    TAX
    PLA
    RTI
.endproc

;--------------------------------------

;--SUBROUTINES------------------------------------------------------------------

.proc CheckGameState
    LDA lastGameState
    CMP gameState
    BNE @StateChanged
    JMP Done

    @StateChanged:
    LDA #0
    STA bgLoaded        ; bg needs reload
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
.proc UpdateBg

    CheckIfFingerMoved:
        LDA fingerX
        CMP fingerLastX
        BNE @fingerMoved
        LDA fingerY
        CMP fingerLastY
        BNE @fingerMoved
        JMP CheckForNewMenu
        @fingerMoved:
            LDA #0
            STA bgLoaded

    CheckForNewMenu:
        LDA menuOpen
        CMP menuOpenLast
        BEQ CheckState
        JSR NewMenuOpened
        JMP Done

    CheckState:
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
        LDA bgLoaded
        CMP #0
        BNE @TitleBgDone
        JSR LoadBgTitle
        @TitleBgDone:
        JMP Done
        
    NewGame:
        LDA bgLoaded
        CMP #0
        BNE @newGameBgDone
        JSR LoadBgNewGame
        LDA menuOpen
        CMP #MENU_NEWGAME_TYPING
        BNE @newGameBgDone
        JSR LoadMenuKeyboard
        @newGameBgDone:
        JSR LoadFinger
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

.proc LoadFinger
    JSR PausePPU
    LDX fingerX
    LDY fingerY
    CPX fingerLastX
    BNE @reloadFinger
    CPY fingerLastY
    BNE @reloadFinger
    JMP Done
    @reloadFinger:
        LDX fingerLastX
        LDY fingerLastY
        JSR SetPpuAddrPointerFromXY
        LDA PPUSTATUS
        LDA pointer
        STA PPUADDR
        LDA pointer+1
        STA PPUADDR
        LDA #___
        STA PPUDATA ; Place blank at old finger position

        LDX fingerLastLastX
        LDY fingerLastLastY ; are we in a submenu?
        CPX #0
        BNE @submenuReloadFinger
        CPY #0
        BNE @submenuReloadFinger
        JMP @placeFinger
        @submenuReloadFinger:
        JSR SetPpuAddrPointerFromXY
        LDA PPUSTATUS
        LDA pointer
        STA PPUADDR
        LDA pointer+1
        STA PPUADDR
        LDA #_PR
        STA PPUDATA ; Place finger at 1st menu finger position
        
        @placeFinger:
        LDX fingerX
        LDY fingerY
        JSR SetPpuAddrPointerFromXY
        LDA PPUSTATUS
        LDA pointer
        STA PPUADDR
        LDA pointer+1
        STA PPUADDR
        LDA #_PR
        STA PPUDATA ; Place new finger on screen
        
        LDA fingerX
        STA fingerLastX
        LDA fingerY
        STA fingerLastY
        
    Done:
    JSR UnpausePPU
    RTS
.endproc

.proc NewMenuOpened
    ; A-register should contain menuOpen.
    STA menuOpenLast

    WhichMenu: ; which menu was just opened?
        CMP #MENU_NONE
        BEQ None

        CMP #MENU_NEWGAME_TYPING
        BEQ NewGameTyping

        CMP #MENU_NEWGAME_OCCUPATION
        BEQ NewGameOccupation
        
    None:
        LDA #0
        STA fingerLastLastX
        STA fingerLastLastY ; clear LastLast pos since we are NOT in a submenu.
        JMP Done
    NewGameTyping:
        LDA fingerX
        STA fingerLastLastX
        LDA fingerY
        STA fingerLastLastY ; Set LastLast pos since we are in a submenu.
        LDA #5
        STA fingerX
        STA fingerLastX
        LDA #18
        STA fingerY         ; move finger to keyboard 'A'
        LDA #0
        STA fingerLastY     ; hack to redraw finger
        STA keyboardKey     ; default key to 'A'
        JMP Done
    NewGameOccupation:
        JMP Done
    Done:
    RTS
.endproc

.proc LoadMenuKeyboard
    JSR PausePPU
    KBLine0:
        LDA #$22 ; Line 0  top border
        STA PPUADDR
        LDA #$04
        STA PPUADDR
        LDA #_RD ;corner
        STA PPUDATA
        LDA #_HR ;horiz line
        LDX #0 ;loop 23 times
        @topBorderLine:
            STA PPUDATA
            INX
            CPX #23
            BNE @topBorderLine
        LDA #_LD ;corner
        STA PPUDATA

    KBLine1:
        LDA #$22 ; Line 1 blank
        STA PPUADDR
        LDA #$24
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLine2:
        LDA #$22 ; Line 2 A-9
        STA PPUADDR
        LDA #$44
        STA PPUADDR
        LDA #_VR ;vert line
        STA PPUDATA
        LDA #___
        LDX #0 ;loop 23 times
        @letters1:
            TXA
            AND #%00000001
            BEQ @skipLetter1
            TXA
            LSR
            TAY
            LDA keyboard, Y
            JMP @letter1
            @skipLetter1:
                LDA #___
            @letter1:
            STA PPUDATA
            INX
            CPX #23
            BNE @letters1
        LDA #_VR ;vert line
        STA PPUDATA

    KBLine3:
        LDA #$22 ; Line 3 blank
        STA PPUADDR
        LDA #$64
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLine4:
        LDA #$22 ; Line 4 I-6
        STA PPUADDR
        LDA #$84
        STA PPUADDR
        LDA #_VR ;vert line
        STA PPUDATA
        LDX #0 ;loop 23 times
        @letters2:
            TXA
            AND #%00000001
            BEQ @skipLetter2
            TXA
            LSR
            CLC
            ADC #11
            TAY
            LDA keyboard, Y
            JMP @letter2
            @skipLetter2:
                LDA #___
            @letter2:
            STA PPUDATA
            INX
            CPX #23
            BNE @letters2
        LDA #_VR ;vert line
        STA PPUDATA

    KBLine5:
        LDA #$22 ; Line 5 blank
        STA PPUADDR
        LDA #$A4
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLine6:
        LDA #$22 ; Line 6 Q-3
        STA PPUADDR
        LDA #$C4
        STA PPUADDR
        LDA #_VR ;vert line
        STA PPUDATA
        LDX #0 ;loop 23 times
        @letters3:
            TXA
            AND #%00000001
            BEQ @skipLetter3
            TXA
            LSR
            CLC
            ADC #22
            TAY
            LDA keyboard, Y
            JMP @letter3
            @skipLetter3:
                LDA #___
            @letter3:
            STA PPUDATA
            INX
            CPX #23
            BNE @letters3
        LDA #_VR ;vert line
        STA PPUDATA

    KBLine7:
        LDA #$22 ; Line 7 blank
        STA PPUADDR
        LDA #$E4
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLine8:
        LDA #$23 ; Line 8 Y-?
        STA PPUADDR
        LDA #$04
        STA PPUADDR
        LDA #_VR ;vert line
        STA PPUDATA
        LDX #0 ;loop 23 times
        @letters4:
            TXA
            AND #%00000001
            BEQ @skipLetter4
            TXA
            LSR
            CLC
            ADC #33
            TAY
            LDA keyboard, Y
            JMP @letter4
            @skipLetter4:
                LDA #___
            @letter4:
            STA PPUDATA
            INX
            CPX #23
            BNE @letters4
        LDA #_VR ;vert line
        STA PPUDATA

        LDA #$23 ; Line 8 "DONE"
        STA PPUADDR
        LDA #$16
        STA PPUADDR
        LDX #0 ;loop 4 times
        @letterDone:
            LDA keyboardDone, X
            STA PPUDATA
            INX
            CPX #4
            BNE @letterDone

    KBLine9:
        LDA #$23 ; Line 9 blank
        STA PPUADDR
        LDA #$24
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLineA:
        LDA #$23 ; Line 10  bottom border
        STA PPUADDR
        LDA #$44
        STA PPUADDR
        LDA #_RU ;corner
        STA PPUDATA
        LDA #_HR ;horiz line
        LDX #0 ;loop 23 times
        @bottomBorderLine:
            STA PPUDATA
            INX
            CPX #23
            BNE @bottomBorderLine
        LDA #_LU ;corner
        STA PPUDATA

    JSR UnpausePPU
    RTS
.endproc

.proc CloseKeyboard
    LDA fingerLastLastX
    STA fingerX
    LDA fingerLastLastY
    STA fingerY
    LDA #0
    STA fingerLastLastX
    STA fingerLastLastY
    LDA #MENU_NONE
    STA menuOpen
    RTS
.endproc

.proc DrawMenuKeyboardBlankLine
    ; PPUADDR must be set
    LDA #_VR ;vert line
    STA PPUDATA
    LDA #___
    LDX #0 ;loop 23 times
    @blank1:
        STA PPUDATA
        INX
        CPX #23
        BNE @blank1
    LDA #_VR ;vert line
    STA PPUDATA
    RTS
.endproc

.proc PausePPU
    LDA #%00010000      ; disable NMI, sprites from Pattern 0, background from Pattern 1
    STA PPUCTRL
    LDA #%00000000      ; disable sprites, disable background
    STA PPUMASK
    RTS
.endproc

.proc UnpausePPU
    LDA #%10010000 ;enable NMI, sprites from Pattern 0, background from Pattern 1
    STA PPUCTRL
    LDA #%00011110 ; enable sprites, enable background
    STA PPUMASK
    LDA #0
    STA PPUADDR
    STA PPUADDR ; clean up ppu address registers
    RTS
.endproc

.proc SetPpuAddrPointerFromXY
    ; X,Y registers must already be set!
    LDA #0 ; clear pointer
    STA pointer
    STA pointer+1
    TYA 
    CLC
    ROL 
    ROL 
    ROL
    TAY
    TXA 
    CLC
    ROL 
    ROL 
    ROL
    TAX
    LDA #%00001000 ;base value for $2000 (change lower 2 bits for other NTs)
    STA pointer
    TYA
    AND #%11111000
    ASL
    ROL pointer
    ASL
    ROL pointer
    STA pointer+1
    TXA
    LSR
    LSR
    LSR
    ORA pointer+1
    STA pointer+1
    RTS
.endproc

;--------------------------------------
.proc InitStateTitle
    RTS
.endproc

.proc InitStateNewGame
    ; initialize cursor: (5x,6y) tiles from top left, facing R
    LDA #0
    STA fingerLastX
    STA fingerLastY
    STA fingerAttr
    LDA #5
    STA fingerX
    LDA #6
    STA fingerY
    RTS
.endproc

.proc InitStateStore

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
        CPX #0
        BNE @blank1

        LDX #0
        @blank2:
        LDA #___
        STA PPUDATA
        INX
        CPX #0
        BNE @blank2

        LDX #0
        @blank3:
        LDA #___
        STA PPUDATA
        INX
        CPX #0
        BNE @blank3

        LDX #0
        @blank4:
        LDA #___
        STA PPUDATA
        INX
        CPX #$C0
        BNE @blank4
    RTS
.endproc

.proc InitStateStartDate
    RTS
.endproc

.proc InitStateLandmark
    RTS
.endproc

.proc InitStateMap
    RTS
.endproc

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
.proc LoadBgTitle
    JSR PausePPU
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

    Done:
    LDA #1
    STA bgLoaded
    JSR UnpausePPU
    RTS
.endproc

.proc LoadBgNewGame
    JSR PausePPU
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

    ; draw names/occupation (or blanks if not set) 
    DrawNames:
        LDA PPUSTATUS ; leader name
        LDA #$20
        STA PPUADDR
        LDA #$C7
        STA PPUADDR
        LDX #0
        @underline1:
            LDA personName, X
            CMP #___
            BNE @store0
            LDA #_UL
            @store0:
            STA PPUDATA
            INX
            CPX #4
            BNE @underline1 
    
        LDA PPUSTATUS ; occupation
        LDA #$20
        STA PPUADDR
        LDA #$D0
        STA PPUADDR
        LDX #0
        LDY #0
        LDA occupation
        STA helper
        @occTextLoop:
            LDA helper
            CMP #0
            BEQ @underline2
            DEC helper
            @occTextLoop2:
                INX 
                INY
                CPY #TEXT_OCCUPATION_LEN
                BNE @occTextLoop2
            LDY #0
            JMP @occTextLoop
        @underline2:
            LDA occupationText, X
            CMP #___
            BNE @storeOcc
            LDA #_UL
            @storeOcc:
            STA PPUDATA
            INX
            CPX #11
            BNE @underline2 
    
        LDA PPUSTATUS ; party member 1
        LDA #$21
        STA PPUADDR
        LDA #$87
        STA PPUADDR
        LDX #0
        @underline3:
            LDA personName+4, X
            CMP #___
            BNE @store1
            LDA #_UL
            @store1:
            STA PPUDATA
            INX
            CPX #4
            BNE @underline3
        
        LDA PPUSTATUS ; party member 2
        LDA #$21
        STA PPUADDR
        LDA #$91
        STA PPUADDR
        LDX #0
        @underline4:
            LDA personName+8, X
            CMP #___
            BNE @store2
            LDA #_UL
            @store2:
            STA PPUDATA
            INX
            CPX #4
            BNE @underline4
    
        LDA PPUSTATUS ; party member 3
        LDA #$21
        STA PPUADDR
        LDA #$C7
        STA PPUADDR
        LDX #0
        @underline5:
            LDA personName+12, X
            CMP #___
            BNE @store3
            LDA #_UL
            @store3:
            STA PPUDATA
            INX
            CPX #4
            BNE @underline5
        
        LDA PPUSTATUS ; party member 4
        LDA #$21
        STA PPUADDR
        LDA #$D1
        STA PPUADDR
        LDX #0
        @underline6:
            LDA personName+16, X
            CMP #___
            BNE @store4
            LDA #_UL
            @store4:
            STA PPUDATA
            INX
            CPX #4
            BNE @underline6

    ;;;;;;;;
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

    Done:
    LDA #1
    STA bgLoaded
    JSR UnpausePPU
    RTS
.endproc

.proc LoadBgStore
    JSR PausePPU
    Done:
    LDA #1
    STA bgLoaded
    JSR UnpausePPU
    RTS
.endproc

.proc LoadBgStartDate
    JSR PausePPU
    Done:
    LDA #1
    STA bgLoaded
    JSR UnpausePPU
    RTS
.endproc

.proc LoadBgLandmark
    JSR PausePPU
    Done:
    LDA #1
    STA bgLoaded
    JSR UnpausePPU
    RTS
.endproc

.proc LoadBgMap
    JSR PausePPU
    Done:
    LDA #1
    STA bgLoaded
    JSR UnpausePPU
    RTS
.endproc

.proc LoadBgTraveling
    JSR PausePPU
    Done:
    LDA #1
    STA bgLoaded
    JSR UnpausePPU
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
        BNE @skip1
        JSR ControllerTraveling
        JMP Done

        @skip1:
        CMP #GAMESTATE_TITLE
        BNE @skip2
        JSR ControllerTitle
        JMP Done

        @skip2:
        CMP #GAMESTATE_NEWGAME
        BNE @skip3
        JSR ControllerNewGame
        JMP Done

        @skip3:
        CMP #GAMESTATE_STORE
        BNE @skip4
        JSR ControllerStore
        JMP Done

        @skip4:
        CMP #GAMESTATE_STARTDATE
        BNE @skip5
        JSR ControllerStartDate
        JMP Done

        @skip5:
        CMP #GAMESTATE_LANDMARK
        BNE @skip6
        JSR ControllerLandmark
        JMP Done

        @skip6:
        CMP #GAMESTATE_MAP
        BNE @skip7
        JSR ControllerMap
        JMP Done

        @skip7:
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

.proc ControllerTitle
    LDA #KEY_START
    BIT buttons1
    BEQ @skip
    LDA #GAMESTATE_NEWGAME
    STA gameState
    @skip:
    RTS
.endproc
        
.proc ControllerNewGame
    ; LDA bgLoaded
    ; CMP #1
    ; BEQ CheckA
    ; JMP Done ; skip controller checking if bg is not loaded
    LDA buttons1
    CMP buttons1Last
    BNE CheckA
    JMP Done

    ; A button
    CheckA:
        LDX #0
        LDA #KEY_A
        BIT buttons1
        BNE @checkMenuA_None
        JMP @skipA
        @checkMenuA_None:
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkMenuA_Typing
            JMP @checkLeaderA
        @checkMenuA_Typing:
            CMP #MENU_NEWGAME_TYPING
            BNE @skipA
            JMP @checkTypingA
        @skipA:
            JMP CheckB
        @checkLeaderA:
            LDA fingerX ; check finger coords for "Leader" selection
            CMP #5
            BNE @checkOccupationA
            LDA fingerY 
            CMP #6
            BNE @checkOccupationA
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkOccupationA
            LDA #MENU_NEWGAME_TYPING
            STA menuOpen
            LDA #0
            STA nameCursor
            STX bgLoaded
            JMP Done
        @checkOccupationA:
            LDA fingerX ; check finger coords for "Occupation" selection
            CMP #14
            BNE @checkPerson1A
            LDA fingerY 
            CMP #6
            BNE @checkPerson1A
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson1A
            LDA #MENU_NEWGAME_OCCUPATION
            STA menuOpen
            STX bgLoaded
            JMP Done
        @checkPerson1A:
            LDA fingerX ; check finger coords for "Person1" selection
            CMP #5
            BNE @checkPerson2A
            LDA fingerY 
            CMP #12
            BNE @checkPerson2A
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson2A
            LDA #MENU_NEWGAME_TYPING
            STA menuOpen
            LDA #4
            STA nameCursor
            STX bgLoaded
            JMP Done
        @checkPerson2A:
            LDA fingerX ; check finger coords for "Person2" selection
            CMP #5
            BNE @checkPerson3A
            LDA fingerY 
            CMP #14
            BNE @checkPerson3A
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson3A
            LDA #MENU_NEWGAME_TYPING
            STA menuOpen
            LDA #8
            STA nameCursor
            STX bgLoaded
            JMP Done
        @checkPerson3A:
            LDA fingerX ; check finger coords for "Person3" selection
            CMP #15
            BNE @checkPerson4A
            LDA fingerY 
            CMP #12
            BNE @checkPerson4A
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson4A
            LDA #MENU_NEWGAME_TYPING
            STA menuOpen
            LDA #12
            STA nameCursor
            STX bgLoaded
            JMP Done
        @checkPerson4A:
            LDA fingerX ; check finger coords for "Person4" selection
            CMP #15
            BNE CheckB
            LDA fingerY 
            CMP #14
            BNE CheckB
            LDA menuOpen
            CMP #MENU_NONE
            BNE CheckB
            LDA #MENU_NEWGAME_TYPING
            STA menuOpen
            LDA #16
            STA nameCursor
            STX bgLoaded
            JMP Done
        @checkTypingA:
            LDA fingerX
            CMP #21
            BNE @stillTypingA
            LDA fingerY
            CMP #24
            BNE @stillTypingA
            JSR CloseKeyboard
            JMP Done
            @stillTypingA:
            LDX keyboardKey
            LDA keyboard, X
            LDY nameCursor
            STA personName,Y
            INC nameCursor
            LDA nameCursor
            AND #%00000011
            BNE @reloadA
            DEC nameCursor
            LDA #21
            STA fingerX
            LDA #24
            STA fingerY
            @reloadA:
            LDA #0
            STA bgLoaded
            JMP Done

    ; B button
    CheckB:
        LDX #0
        LDA #KEY_B
        BIT buttons1
        BNE @checkMenuB_None
        JMP @skipB
        @checkMenuB_None:
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkMenuB_Typing
            JMP @checkLeaderB
        @checkMenuB_Typing:
            CMP #MENU_NEWGAME_TYPING
            BNE @skipB
            JMP @checkTypingB
        @skipB:
            JMP CheckStart
        @checkLeaderB:
            JMP Done
        @checkTypingB:
            JMP Done

    ; Start button
    CheckStart:
        LDX #0
        LDA #KEY_START
        BIT buttons1
        BNE @checkMenuStart_None
        JMP @skipStart
        @checkMenuStart_None:
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkMenuStart_Typing
            JMP @checkLeaderStart
        @checkMenuStart_Typing:
            CMP #MENU_NEWGAME_TYPING
            BNE @skipStart
            JMP @checkTypingStart
        @skipStart:
            JMP CheckLeft
        @checkLeaderStart:
            LDA #GAMESTATE_STORE
            STA gameState
            JMP Done
        @checkTypingStart:
            LDA #21
            CMP fingerX
            BNE @stillTypingStart
            LDA #24
            CMP fingerY
            BNE @stillTypingStart
            ; "DONE" key pressed. close keyboard
            JSR CloseKeyboard
            JMP Done
            @stillTypingStart:
                ; jump to the "DONE" key
                LDA #21
                STA fingerX
                LDA #24
                STA fingerY
            JMP Done

    ; Left button
    CheckLeft:
        LDX #0
        LDA #KEY_LEFT
        BIT buttons1
        BNE @checkMenuL_None
        JMP @skipL
        @checkMenuL_None:
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkMenuL_Typing
            JMP @checkLeaderL
        @checkMenuL_Typing:
            CMP #MENU_NEWGAME_TYPING
            BNE @skipL
            JMP @checkTypingL
        @skipL:
            JMP CheckRight
        @checkLeaderL:
            LDA fingerX ; check finger coords for "Leader" selection
            CMP #5
            BNE @checkOccupationL
            LDA fingerY 
            CMP #6
            BNE @checkOccupationL
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkOccupationL
            LDA #14
            STA fingerX ; move finger to "Occupation"
            STX bgLoaded
            JMP Done
        @checkOccupationL:
            LDA fingerX ; check finger coords for "Occupation" selection
            CMP #14
            BNE @checkPerson1L
            LDA fingerY 
            CMP #6
            BNE @checkPerson1L
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson1L
            LDA #5
            STA fingerX ; move finger to "Leader"
            STX bgLoaded
            JMP Done
        @checkPerson1L:
            LDA fingerX ; check finger coords for "Person1" selection
            CMP #5
            BNE @checkPerson2L
            LDA fingerY 
            CMP #12
            BNE @checkPerson2L
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson2L
            LDA #15
            STA fingerX ; move finger to "Person3"
            STX bgLoaded
            JMP Done
        @checkPerson2L:
            LDA fingerX ; check finger coords for "Person2" selection
            CMP #5
            BNE @checkPerson3L
            LDA fingerY 
            CMP #14
            BNE @checkPerson3L
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson3L
            LDA #15
            STA fingerX ; move finger to "Person4"
            STX bgLoaded
            JMP Done
        @checkPerson3L:
            LDA fingerX ; check finger coords for "Person3" selection
            CMP #15
            BNE @checkPerson4L
            LDA fingerY 
            CMP #12
            BNE @checkPerson4L
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson4L
            LDA #5
            STA fingerX ; move finger to "Person1"
            STX bgLoaded
            JMP Done
        @checkPerson4L:
            LDA fingerX ; check finger coords for "Person4" selection
            CMP #15
            BNE CheckRight
            LDA fingerY 
            CMP #14
            BNE CheckRight
            LDA menuOpen
            CMP #MENU_NONE
            BNE CheckRight
            LDA #5
            STA fingerX ; move finger to "Person2"
            STX bgLoaded
            JMP Done
        @checkTypingL:
            LDX fingerX
            DEX
            DEX
            DEC keyboardKey
            LDA keyboardKey
            STA helper
            CPX #3  ; check if we need to wrap around
            BNE @moveFingerL
            LDX #25 ; wrap around
            LDA keyboardKey
            CLC
            ADC #TEXT_KEYBOARD_LEN
            STA helper
            LDA fingerY
            CMP #24 ; check if we need to wrap to the "DONE" keyboard button
            BNE @moveFingerL
            LDX #21 ; wrap around to "DONE" keyboard button
            LDA #41
            STA helper
            @moveFingerL:
            STX fingerX
            LDA helper
            STA keyboardKey
            JMP Done
    ; Right button
    CheckRight:
        LDX #0
        LDA #KEY_RIGHT
        BIT buttons1
        BNE @checkMenuR_None
        JMP @skipR
        @checkMenuR_None:
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkMenuR_Typing
            JMP @checkLeaderR
        @checkMenuR_Typing:
            CMP #MENU_NEWGAME_TYPING
            BNE @skipR
            JMP @checkTypingR
        @skipR:
            JMP CheckUp
        @checkLeaderR:
            LDA fingerX ; check finger coords for "Leader" selection
            CMP #5
            BNE @checkOccupationR
            LDA fingerY 
            CMP #6
            BNE @checkOccupationR
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkOccupationR
            LDA #14
            STA fingerX ; move finger to "Occupation"
            STX bgLoaded
            JMP Done
        @checkOccupationR:
            LDA fingerX ; check finger coords for "Occupation" selection
            CMP #14
            BNE @checkPerson1R
            LDA fingerY 
            CMP #6
            BNE @checkPerson1R
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson1R
            LDA #5
            STA fingerX ; move finger to "Leader"
            STX bgLoaded
            JMP Done
        @checkPerson1R:
            LDA fingerX ; check finger coords for "Person1" selection
            CMP #5
            BNE @checkPerson2R
            LDA fingerY 
            CMP #12
            BNE @checkPerson2R
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson2R
            LDA #15
            STA fingerX ; move finger to "Person3"
            STX bgLoaded
            JMP Done
        @checkPerson2R:
            LDA fingerX ; check finger coords for "Person2" selection
            CMP #5
            BNE @checkPerson3R
            LDA fingerY 
            CMP #14
            BNE @checkPerson3R
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson3R
            LDA #15
            STA fingerX ; move finger to "Person4"
            STX bgLoaded
            JMP Done
        @checkPerson3R:
            LDA fingerX ; check finger coords for "Person3" selection
            CMP #15
            BNE @checkPerson4R
            LDA fingerY 
            CMP #12
            BNE @checkPerson4R
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson4R
            LDA #5
            STA fingerX ; move finger to "Person1"
            STX bgLoaded
            JMP Done
        @checkPerson4R:
            LDA fingerX ; check finger coords for "Person4" selection
            CMP #15
            BNE CheckUp
            LDA fingerY 
            CMP #14
            BNE CheckUp
            LDA menuOpen
            CMP #MENU_NONE
            BNE CheckUp
            LDA #5
            STA fingerX ; move finger to "Person2"
            STX bgLoaded
            JMP Done
        @checkTypingR:
            LDX fingerX
            INX
            INX
            INC keyboardKey
            LDA keyboardKey
            STA helper
            LDA fingerY
            CMP #24 ; check if we are on bottom row
            BNE @wrapFingerNormallyR
            CPX #23 ; check if we need to wrap around the "DONE" key
            BEQ @wrapFingerR
            @wrapFingerNormallyR:
            CPX #27 ; check if we need to wrap around normally
            BNE @moveFingerR
            LDA helper
            SEC
            SBC #2
            STA helper
            @wrapFingerR:
            LDX #5  ; wrap around
            LDA helper
            SEC
            SBC #9
            STA helper
            @moveFingerR:
            STX fingerX
            LDA helper
            STA keyboardKey
            JMP Done
    ; Up button
    CheckUp:
        LDX #0
        LDA #KEY_UP
        BIT buttons1
        BNE @checkMenuU_None
        JMP @skipU
        @checkMenuU_None:
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkMenuU_Typing
            JMP @checkLeaderU
        @checkMenuU_Typing:
            CMP #MENU_NEWGAME_TYPING
            BNE @skipU
            JMP @checkTypingU
        @skipU:
            JMP CheckDown
        @checkLeaderU:
            LDA fingerX ; check finger coords for "Leader" selection
            CMP #5
            BNE @checkOccupationU
            LDA fingerY 
            CMP #6
            BNE @checkOccupationU
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkOccupationU
            LDA #14
            STA fingerY ; move finger to "Person2"
            STX bgLoaded
            JMP Done
            ;
        @checkOccupationU:
            LDA fingerX ; check finger coords for "Occupation" selection
            CMP #14
            BNE @checkPerson1U
            LDA fingerY 
            CMP #6
            BNE @checkPerson1U
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson1U
            LDA #15
            STA fingerX
            LDA #14
            STA fingerY ; move finger to "Person4"
            STX bgLoaded
            JMP Done
            ;
        @checkPerson1U:
            LDA fingerX ; check finger coords for "Person1" selection
            CMP #5
            BNE @checkPerson2U
            LDA fingerY 
            CMP #12
            BNE @checkPerson2U
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson2U
            LDA #6
            STA fingerY ; move finger to "Leader"
            STX bgLoaded
            JMP Done
            ;
        @checkPerson2U:
            LDA fingerX ; check finger coords for "Person2" selection
            CMP #5
            BNE @checkPerson3U
            LDA fingerY 
            CMP #14
            BNE @checkPerson3U
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson3U
            LDA #12
            STA fingerY ; move finger to "Person1"
            STX bgLoaded
            JMP Done
            ;
        @checkPerson3U:
            LDA fingerX ; check finger coords for "Person3" selection
            CMP #15
            BNE @checkPerson4U
            LDA fingerY 
            CMP #12
            BNE @checkPerson4U
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson4U
            LDA #14
            STA fingerX
            LDA #6
            STA fingerY ; move finger to "Occupation"
            STX bgLoaded
            JMP Done
            ;
        @checkPerson4U:
            LDA fingerX ; check finger coords for "Person4" selection
            CMP #15
            BNE CheckDown
            LDA fingerY 
            CMP #14
            BNE CheckDown
            LDA menuOpen
            CMP #MENU_NONE
            BNE CheckDown
            LDA #12
            STA fingerY ; move finger to "Person3"
            STX bgLoaded
            JMP Done
            ;
        @checkTypingU:
            LDX fingerY
            DEX
            DEX
            LDA keyboardKey
            SEC
            SBC #TEXT_KEYBOARD_LEN
            STA helper
            CPX #16 ; check if fingerY is past top of screen
            BNE @moveFingerU
            LDA fingerX
            CMP #23 ; check if we are in last 2 columns
            BCC @wrapFingerU
            LDA #21
            STA fingerX ; wrap to the "DONE" key
            LDA #41
            STA helper
            LDX #24 ; wrap to bottom of keyboard
            JMP @moveFingerU
            @wrapFingerU:
            LDX #24 ; wrap to bottom of keyboard
            LDA keyboardKey
            CLC
            ADC #33
            STA helper
            @moveFingerU:
            STX fingerY
            LDA helper
            STA keyboardKey
            JMP Done
    ; Down button
    CheckDown:
        LDX #0
        LDA #KEY_DOWN
        BIT buttons1
        BNE @checkMenuD_None
        JMP @skipD
        @checkMenuD_None:
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkMenuD_Typing
            JMP @checkLeaderD
        @checkMenuD_Typing:
            CMP #MENU_NEWGAME_TYPING
            BNE @skipD
            JMP @checkTypingD
        @skipD:
            JMP Done
        @checkLeaderD:
            LDA fingerX ; check finger coords for "Leader" selection
            CMP #5
            BNE @checkOccupationD
            LDA fingerY 
            CMP #6
            BNE @checkOccupationD
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkOccupationD
            LDA #12
            STA fingerY ; move finger to "Person1"
            STX bgLoaded
            JMP Done
            ;
        @checkOccupationD:
            LDA fingerX ; check finger coords for "Occupation" selection
            CMP #14
            BNE @checkPerson1D
            LDA fingerY 
            CMP #6
            BNE @checkPerson1D
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson1D
            LDA #15
            STA fingerX
            LDA #12
            STA fingerY ; move finger to "Person3"
            STX bgLoaded
            JMP Done
            ;
        @checkPerson1D:
            LDA fingerX ; check finger coords for "Person1" selection
            CMP #5
            BNE @checkPerson2D
            LDA fingerY 
            CMP #12
            BNE @checkPerson2D
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson2D
            LDA #14
            STA fingerY ; move finger to "Person2"
            STX bgLoaded
            JMP Done
            ;
        @checkPerson2D:
            LDA fingerX ; check finger coords for "Person2" selection
            CMP #5
            BNE @checkPerson3D
            LDA fingerY 
            CMP #14
            BNE @checkPerson3D
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson3D
            LDA #6
            STA fingerY ; move finger to "Leader"
            STX bgLoaded
            JMP Done
            ;
        @checkPerson3D:
            LDA fingerX ; check finger coords for "Person3" selection
            CMP #15
            BNE @checkPerson4D
            LDA fingerY 
            CMP #12
            BNE @checkPerson4D
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson4D
            LDA #14
            STA fingerY ; move finger to "Person4"
            STX bgLoaded
            JMP Done
            ;
        @checkPerson4D:
            LDA fingerX ; check finger coords for "Person4" selection
            CMP #15
            BNE Done
            LDA fingerY 
            CMP #14
            BNE Done
            LDA menuOpen
            CMP #MENU_NONE
            BNE Done
            LDA #14
            STA fingerX
            LDA #6
            STA fingerY ; move finger to "Occupation"
            STX bgLoaded
            JMP Done
            ;
        @checkTypingD:
            LDX fingerY
            INX
            INX
            LDA keyboardKey
            CLC
            ADC #11
            STA helper
            CPX #26 ; check if fingerY is past bottom of screen
            BEQ @wrapFingerD
            LDA fingerX
            CMP #23 ; check if fingerX is in "DONE" columns
            BCC @moveFingerD
            CPX #24 ; check if fingerY is in 3rd row
            BNE @moveFingerD
            LDA #21
            STA fingerX
            LDA #41
            STA helper
            JMP @moveFingerD
            @wrapFingerD:
            LDX #18 ; wrap to top of screen
            LDA keyboardKey
            SEC
            SBC #33
            STA helper
            @moveFingerD:
            STX fingerY
            LDA helper
            STA keyboardKey
            JMP Done
    Done:
    RTS
.endproc
        
.proc ControllerStore
    RTS
.endproc
        
.proc ControllerStartDate
    RTS
.endproc
        
.proc ControllerLandmark
    RTS
.endproc
        
.proc ControllerMap
    RTS
.endproc

.proc ControllerTraveling
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

.proc UpdateSprites
    LDA #$00
    STA OAMADDR ; tell PPU to prepare for transfer to OAM starting at byte zero
    LDA #$02
    STA OAMDMA ; tell PPU to initiate transfer of 256 bytes $0200-$02ff into OAM

    LDA #0
    STA PPUADDR
    STA PPUADDR

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