
.proc CheckGameState
    LDA lastGameState
    CMP gameState
    BNE :+
    JSR UpdateGame
    RTS
    :
    JSR ClearScreen
    LDA gameState
    STA lastGameState
    CMP #GAMESTATE_TITLE
    BNE :+
    JSR InitStateTitle
    RTS
    :
    CMP #GAMESTATE_TRAVELING
    BNE :+ 
    JSR InitStateTraveling
    RTS
    :
    CMP #GAMESTATE_NEWGAME
    BNE :+ 
    JSR InitStateNewGame
    RTS
    :
    CMP #GAMESTATE_STORE
    BNE :+ 
    JSR InitStateStore
    RTS
    :
    CMP #GAMESTATE_LANDMARK
    BNE :+ 
    JSR InitStateLandmark
    RTS
    :
    CMP #GAMESTATE_MAP
    BNE :+
    JSR InitStateMap
    RTS
    :
    RTS
.endproc

.proc UpdateGame
    LDA menuOpen
    CMP menuOpenLast
    BEQ :+
    JSR NewMenuOpened
    LDA menuOpen
    STA menuOpenLast    ; reset last menu open
    LDA #0
    STA frameCounter    ; reset framecounter
    JMP Done
    :
    LDA gameState
    CMP #GAMESTATE_TITLE
    BNE :+
    ; scramble the PRNG seed while we are on the title screen.
    JSR RandomNumberGenerator
    STA helper
    JSR RandomNumberGenerator
    STA helper+1
    LDA helper
    STA seed
    LDA helper+1
    STA seed+1
    JMP Done
    :
    CMP #GAMESTATE_TRAVELING
    BNE :+ 
    JMP Traveling
    :
    CMP #GAMESTATE_NEWGAME
    BNE :+ 
    JMP Done
    :
    CMP #GAMESTATE_STORE
    BNE :+ 
    JMP Done
    :
    CMP #GAMESTATE_LANDMARK
    BNE :+ 
    JMP Done
    :
    CMP #GAMESTATE_MAP
    BNE :+
    JMP Done
    :
    JMP Done
    Traveling:
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JSR ProcessEventQueue
        :
        JMP Done
    Done:
    JSR Every60Frames
    JSR DrawFinger
    RTS
.endproc

.proc UpdateBg ; deprecated

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
    RTS
.endproc

.proc ReadController1
    LDA #$01    ; read inputs
    STA $4016
    LDA #$00
    STA $4016
    LDX #$08
    :
    LDA $4016
    LSR A
    ROL buttons1
    DEX
    BNE :-
    LDA gameState
    CMP #GAMESTATE_TRAVELING
    BNE :+
    JSR GamepadTraveling
    JMP Done
    :
    CMP #GAMESTATE_TITLE
    BNE :+
    JSR GamepadTitle
    JMP Done
    :
    CMP #GAMESTATE_NEWGAME
    BNE :+
    JSR GamepadNewGame
    JMP Done
    :
    CMP #GAMESTATE_STORE
    BNE :+
    JSR GamepadStore
    JMP Done
    :
    CMP #GAMESTATE_LANDMARK
    BNE :+
    JSR GamepadLandmark
    JMP Done
    :
    CMP #GAMESTATE_MAP
    BNE :+
    JSR GamepadMap
    JMP Done
    :
    Done:
    LDA buttons1
    STA buttons1Last    ; Remember last controller inputs
    RTS
.endproc

.proc NewMenuOpened
    PHA
    LDA #0
    STA fingerAttr
    PLA
    ; A-register should contain menuOpen.
    CMP #MENU_NONE      ; which menu was just opened?
    BNE :+
    JMP None
    :
    CMP #MENU_TITLE_LEARN
    BNE :+
    STA menuCursor ; use menuCursor to denote page number (0-6)
    JSR BufferDrawTitleLearn
    RTS
    :
    CMP #MENU_TITLE_TOPTEN
    BNE :+
    LDA #%00010101 ; "<>" finger visible
    STA fingerAttr
    LDA #26
    STA fingerX
    LDA #22
    STA fingerY
    LDA #0 ; Y/N (default N)
    STA menuCursor
    STA fingerLastY
    JSR ClearScreen
    JSR BufferDrawTopTen
    LDX fingerX
    LDY fingerY
    LDA #_N_
    JSR WriteTileToBuffer
    RTS
    :
    CMP #MENU_TITLE_SOUND
    BNE :+
    JSR BufferDrawTitleSound
    RTS
    :
    CMP #MENU_NEWGAME_TYPING
    BNE :+
    LDA #%00001100      ; both fingers visible, pointing right
    STA fingerAttr
    LDA #0              ; default key to 'A'
    STA keyboardKey
    JSR DrawMenuKeyboard
    LDX #5
    LDY #18
    JSR MoveFingerToSubmenu
    RTS
    :
    CMP #MENU_NEWGAME_OCCUPATION
    BNE :+
    LDA #%00000100      ; only main finger visible, pointing right
    STA fingerAttr
    LDA #4
    STA fingerX
    LDA #10
    STA fingerY
    JSR LoadBgNewGame
    ; JSR RedrawFinger
    ; JSR DrawOccupationMenu
    ; LDX #15
    ; LDY #7
    ; JSR MoveFingerToSubmenu
    RTS
    :
    CMP #MENU_NEWGAME_OCC_HELP
    BNE :+
    JSR LoadBgNewGame
    RTS
    :
    CMP #MENU_NEWGAME_NAMEPARTY
    BNE :+
    LDA #%00100000      ; keyboard key
    STA fingerAttr
    LDA #6
    STA fingerX
    LDA #21
    STA fingerY
    JSR LoadBgNewGame
    LDA #30
    STA frameCounter
    JSR HighlightKeyboardKey
    RTS
    :
    CMP #MENU_NEWGAME_STARTDATE
    BNE :+
    LDA #%00000100      ; only main finger visible, pointing right
    STA fingerAttr
    ; JSR DrawStartDateSubmenu
    LDA #0
    STA fingerLastLastX
    STA fingerLastLastY
    STA fingerLastX
    STA fingerLastY
    LDA #4
    STA fingerX
    LDA #14
    STA fingerY
    JSR LoadBgNewGame
    RTS
    :
    CMP #MENU_STORE_ITEM1
    BNE :+
    LDA #7
    PHA
    JMP StoreSubmenu
    :
    CMP #MENU_STORE_ITEM2
    BNE :+
    LDA #7
    PHA
    JMP StoreSubmenu
    :
    CMP #MENU_STORE_ITEM4
    BNE :+
    LDA #6
    PHA
    JMP StoreSubmenu
    :
    CMP #MENU_MAINMENU
    BNE :+
    LDA #%00000100      ; only finger visible, pointing right
    STA fingerAttr
    JSR UpdatePalette ; <- TODO refactor 
    JSR LoadBgTraveling
    JSR RedrawFinger
    RTS
    :
    CMP #MENU_SUPPLIES
    BNE :+
    JSR LoadBgSupplies
    RTS
    :
    CMP #MENU_PACE
    BNE :+
    LDA #%00010100      ; only finger visible, up/down arrow
    STA fingerAttr
    LDX #12
    LDY #17
    JSR MoveFingerToSubmenu
    JSR DrawPaceSubmenu
    JSR RedrawFinger
    RTS
    :
    CMP #MENU_RATIONS
    BNE :+
    LDA #%00010100      ; only finger visible, up/down arrow
    STA fingerAttr
    LDX #15
    LDY #19
    JSR MoveFingerToSubmenu
    JSR DrawRationsSubmenu
    JSR RedrawFinger
    RTS
    :
    CMP #MENU_REST
    BNE :+
    LDA #1
    STA wagonRest
    LDA #%00010100      ; only finger visible, up/down arrow
    STA fingerAttr
    LDX #15
    LDY #21
    JSR MoveFingerToSubmenu
    JSR DrawRestSubmenu
    JSR RedrawFinger
    RTS
    :
    CMP #MENU_TALK
    BNE :+
    JSR LoadBgTalk
    RTS
    :
    CMP #MENU_TEXTPOPUP
    BNE :+
    JSR BufferDrawTextPopup
    RTS
    :
    CMP #MENU_TEXTPOPUP_YN
    BNE :+
    JSR BufferDrawTextPopup
    RTS
    :
    CMP #MENU_MAP
    BNE :+
    JSR MoveFingerToSubmenu
    JSR RedrawFinger
    JSR LoadBgMap
    RTS
    :
    CMP #MENU_NEWGAME_DATE_HELP
    BNE :+
    JSR LoadBgNewGame
    RTS
    :
    CMP #MENU_NEWGAME_GOINGBACK
    BNE :+
    LDA #0
    STA frameCounter
    STA menuCursor
    JSR LoadBgIndependence
    RTS
    :
    CMP #MENU_NEWGAME_BEFORELEAVING1
    BNE :+
    JSR LoadBgIndependence
    RTS
    :
    CMP #MENU_NEWGAME_BEFORELEAVING2
    BNE :+
    JSR LoadBgIndependence
    RTS
    :
    CMP #MENU_NEWGAME_MATT
    BNE :+
    JSR LoadBgMatt
    RTS
    :
    RTS
    None:
        LDA #0
        STA fingerLastLastX
        STA fingerLastLastY ; clear LastLast pos since we are NOT in a submenu.
        LDA gameState
        CMP #GAMESTATE_TITLE
        BNE :+
        JSR InitStateTitle
        RTS
        ; :
        ; CMP #GAMESTATE_NEWGAME
        ; BNE :+
        ; LDA #%00001100      ; both fingers visible, normal, pointing right
        ; STA fingerAttr
        ; JSR LoadBgNewGame
        ; RTS
        :
        CMP #GAMESTATE_STORE
        BNE :+
        LDA #%00001100      ; both fingers visible, normal, pointing right
        STA fingerAttr
        JSR RedrawFinger
        JSR LoadBgStore
        RTS
        :
        CMP #GAMESTATE_LANDMARK
        BNE :+
        LDA #%00000000      ; neither finger visible
        STA fingerAttr
        JSR LoadBgLandmark
        RTS
        :
        CMP #GAMESTATE_TRAVELING
        BNE :+
        LDA #%00000000      ; neither finger visible
        STA fingerAttr
        LDA menuOpenLast
        CMP #MENU_TEXTPOPUP
        BEQ :+
        JSR LoadBgTraveling
        RTS
        :
        RTS
    StoreSubmenu:
        LDA #%00011100      ; both fingers visible, main finger "up/down" arrows
        STA fingerAttr
        JSR DrawStoreSubmenu
        PLA
        TAX
        LDY fingerY
        JSR MoveFingerToSubmenu
        RTS
.endproc

.proc Every60Frames
    LDA gameState ; only on main traveling screen
    CMP #GAMESTATE_TRAVELING
    BEQ Traveling
    CMP #GAMESTATE_NEWGAME
    BNE :+
    JMP NewGame
    :
    RTS
    Traveling:
        LDA frameCounter
        CMP #60
        BNE :+
        JMP @sec1
        :
        CMP #120
        BNE :+
        JMP @sec2
        :
        AND #$07
        CMP #0
        BNE :+
        JMP @animate
        :
        RTS
        @animate:
            LDA wagonRest
            BEQ :+
            JMP :+++
            :
            LDA oxenFrame
            BPL :+
            RTS
            :
            JSR BufferDrawWagon
            INC oxenFrame
            LDA oxenFrame
            CMP #3
            BNE :+
            LDA #0
            STA oxenFrame
            :
            INC frameCounter
            RTS
        @sec1:
            ; 1st second: move wagon
            LDA oxenFrame
            AND #%01111111
            STA oxenFrame
            INC frameCounter
            RTS
        @sec2:
            ; 2nd second: pause, update counters, roll for event
            LDA #%10000000
            STA oxenFrame
            JSR ElapseDay
            JSR BufferDrawMainMenuHUDValues
            JSR RestOneDay
            JSR BufferDrawTravelingHUDValues
            LDA #0
            STA frameCounter
            RTS
    NewGame:
        LDA menuOpen
        CMP #MENU_NEWGAME_NAMEPARTY
        BNE :+
        JMP NameParty
        :
        CMP #MENU_NEWGAME_GOINGBACK
        BNE :+
        JMP GoingBack
        :
        RTS
        NameParty:
        LDA frameCounter ; blink cursor
        CMP #30
        BNE :+
        JMP @sec1
        :
        CMP #60
        BNE :+
        JMP @sec2
        :
        RTS
        @sec1: 
            ; BufferStart #2, #$3f, #$06
            ; LDA #C_GREY
            ; JSR WriteByteToBuffer
            ; LDA #C_WHITE
            ; JSR WriteByteToBuffer
            ; JSR EndBufferWrite
            ; INC frameCounter
            RTS
        @sec2:
            ; BufferStart #2, #$3f, #$06
            ; LDA #C_WHITE
            ; JSR WriteByteToBuffer
            ; LDA #C_GREY
            ; JSR WriteByteToBuffer
            ; JSR EndBufferWrite
            ; LDA #0
            ; STA frameCounter
            RTS
        GoingBack:
        LDA frameCounter ; blink cursor
        CMP #60
        BNE :+
        JMP @sec1
        :
        RTS
        @sec1: 
            INC menuCursor
            LDA #0
            STA frameCounter
            LDA menuCursor
            CMP #3
            BNE :+
            LDA #MENU_NEWGAME_STARTDATE
            STA menuOpen
            :
            RTS
        RTS
.endproc
