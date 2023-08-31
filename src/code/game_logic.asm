
.proc CheckGameState
    LDA lastGameState
    CMP gameState
    BNE :+
    JSR UpdateGame
    JMP Done
    :
    JSR ClearScreen
    LDA gameState
    STA lastGameState
    CMP #GAMESTATE_TITLE
    BNE :+
    JSR InitStateTitle
    JMP Done
    :
    CMP #GAMESTATE_TRAVELING
    BNE :+ 
    JSR InitStateTraveling
    JMP Done
    :
    CMP #GAMESTATE_NEWGAME
    BNE :+ 
    JSR InitStateNewGame
    JMP Done
    :
    CMP #GAMESTATE_STORE
    BNE :+ 
    JSR InitStateStore
    JMP Done
    :
    CMP #GAMESTATE_LANDMARK
    BNE :+ 
    JSR InitStateLandmark
    JMP Done
    :
    CMP #GAMESTATE_MAP
    BNE :+
    JSR InitStateMap
    JMP Done
    :
    Done:
    RTS
.endproc

.proc UpdateGame
    LDA menuOpen
    CMP menuOpenLast
    BEQ :+
    JSR NewMenuOpened
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
    JSR ControllerTraveling
    JMP Done
    :
    CMP #GAMESTATE_TITLE
    BNE :+
    JSR ControllerTitle
    JMP Done
    :
    CMP #GAMESTATE_NEWGAME
    BNE :+
    JSR ControllerNewGame
    JMP Done
    :
    CMP #GAMESTATE_STORE
    BNE :+
    JSR ControllerStore
    JMP Done
    :
    CMP #GAMESTATE_LANDMARK
    BNE :+
    JSR ControllerLandmark
    JMP Done
    :
    CMP #GAMESTATE_MAP
    BNE :+
    JSR ControllerMap
    JMP Done
    :
    Done:
    LDA buttons1
    STA buttons1Last    ; Remember last controller inputs
    RTS
.endproc

.proc NewMenuOpened
    ; A-register should contain menuOpen.
    CMP #MENU_NONE      ; which menu was just opened?
    BNE :+
    JMP None
    :
    CMP #MENU_TITLE_LEARN
    BNE :+
    JMP TitleLearn
    :
    CMP #MENU_TITLE_TOPTEN
    BNE :+
    JMP TitleTopTen
    :
    CMP #MENU_NEWGAME_TYPING
    BNE :+
    JMP NewGameTyping
    :
    CMP #MENU_NEWGAME_OCCUPATION
    BNE :+
    JMP NewGameOccupation
    :
    CMP #MENU_NEWGAME_STARTDATE
    BNE :+
    JMP NewGameStartDate
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
    JMP MainMenu
    :
    CMP #MENU_SUPPLIES
    BNE :+
    JMP Supplies
    :
    CMP #MENU_PACE
    BNE :+
    JMP Pace
    :
    CMP #MENU_RATIONS
    BNE :+
    JMP Rations
    :
    CMP #MENU_REST
    BNE :+
    JMP Rest
    :
    CMP #MENU_TALK
    BNE :+
    JMP Talk
    :
    CMP #MENU_TEXTPOPUP
    BNE :+
    JMP TextPopup
    :
    CMP #MENU_TEXTPOPUP_YN
    BNE :+
    JMP TextPopupYN
    :
    CMP #MENU_MAP
    BNE :+
    JMP Map
    :
    JMP Done
    None:
        LDA #0
        STA fingerLastLastX
        STA fingerLastLastY ; clear LastLast pos since we are NOT in a submenu.
        LDA gameState
        CMP #GAMESTATE_TITLE
        BNE :+
        JSR InitStateTitle
        JMP Done
        :
        CMP #GAMESTATE_NEWGAME
        BNE :+
        LDA #%00001100      ; both fingers visible, normal, pointing right
        STA fingerAttr
        JSR LoadBgNewGame
        JMP Done
        :
        CMP #GAMESTATE_STORE
        BNE :+
        LDA #%00001100      ; both fingers visible, normal, pointing right
        STA fingerAttr
        JSR RedrawFinger
        JSR LoadBgStore
        JMP Done
        :
        CMP #GAMESTATE_LANDMARK
        BNE :+
        LDA #%00000000      ; neither finger visible
        STA fingerAttr
        JSR LoadBgLandmark
        JMP Done
        :
        CMP #GAMESTATE_TRAVELING
        BNE :+
        LDA #%00000000      ; neither finger visible
        STA fingerAttr
        LDA menuOpenLast
        CMP #MENU_TEXTPOPUP
        BEQ :+
        JSR LoadBgTraveling
        JMP Done
        :
        JMP Done
    TitleLearn:
        LDA #0 ;no fingers visible
        STA fingerAttr
        STA menuCursor ; use menuCursor to denote page number (0-6)
        JSR BufferDrawTitleLearn
        JMP Done
    TitleTopTen:
        LDA #%00010101 ; "<>" finger visible
        STA fingerAttr
        LDA #26
        STA fingerX
        LDA #22
        STA fingerY
        LDA #0 ; Y/N (default N)
        STA menuCursor
        JSR ClearScreen
        JSR BufferDrawTopTen
        LDX fingerX
        LDY fingerY
        LDA #_N_
        JSR WriteTileToBuffer
        JMP Done
    NewGameTyping:
        LDA #%00001100      ; both fingers visible, pointing right
        STA fingerAttr
        LDA #0              ; default key to 'A'
        STA keyboardKey
        JSR DrawMenuKeyboard
        LDX #5
        LDY #18
        JSR MoveFingerToSubmenu
        JMP Done
    NewGameOccupation:
        LDA #%00000100      ; only main finger visible, pointing right
        STA fingerAttr
        JSR DrawOccupationMenu
        LDX #15
        LDY #7
        JSR MoveFingerToSubmenu
        JMP Done
    NewGameStartDate:
        LDA #%00000100      ; only main finger visible
        STA fingerAttr
        JSR DrawStartDateSubmenu
        LDX #6
        LDY #21
        JSR MoveFingerToSubmenu
        JMP Done
    StoreSubmenu:
        LDA #%00011100      ; both fingers visible, main finger "up/down" arrows
        STA fingerAttr
        JSR DrawStoreSubmenu
        PLA
        TAX
        LDY fingerY
        JSR MoveFingerToSubmenu
        JMP Done
    MainMenu:
        LDA #%00000100      ; only finger visible, pointing right
        STA fingerAttr
        JSR UpdatePalette ; <- TODO refactor 
        JSR LoadBgTraveling
        JSR RedrawFinger
        JMP Done
    Supplies:
        LDA #0 ;no fingers visible
        STA fingerAttr
        JSR LoadBgSupplies
        JMP Done
    Pace:
        LDA #%00010100      ; only finger visible, up/down arrow
        STA fingerAttr
        LDX #12
        LDY #17
        JSR MoveFingerToSubmenu
        JSR DrawPaceSubmenu
        JSR RedrawFinger
        JMP Done
    Rations:
        LDA #%00010100      ; only finger visible, up/down arrow
        STA fingerAttr
        LDX #15
        LDY #19
        JSR MoveFingerToSubmenu
        JSR DrawRationsSubmenu
        JSR RedrawFinger
        JMP Done
    Rest:
        LDA #1
        STA wagonRest
        LDA #%00010100      ; only finger visible, up/down arrow
        STA fingerAttr
        LDX #15
        LDY #21
        JSR MoveFingerToSubmenu
        JSR DrawRestSubmenu
        JSR RedrawFinger
        JMP Done
    TextPopupYN:
    TextPopup:
        JSR BufferDrawTextPopup
        JMP Done
        ; JSR BufferDrawTextPopup
        ; JMP Done
    Map:
        LDA #0      ; no finger visible
        STA fingerAttr
        JSR MoveFingerToSubmenu
        JSR RedrawFinger
        JSR LoadBgMap
        ;JSR DrawTrailSprites
        JMP Done
    Talk:
        LDA #0 ;no fingers visible
        STA fingerAttr
        JSR LoadBgTalk
        JMP Done

    Done:
    LDA menuOpen
    STA menuOpenLast    ; reset last menu open
    LDA #0
    STA frameCounter    ; reset framecounter
    RTS
.endproc

.proc Every60Frames
    LDA gameState ; only on main traveling screen
    CMP #GAMESTATE_TRAVELING
    BEQ :+
    JMP Done
    :
    LDA frameCounter
    CMP #60
    BNE :+
    JMP sec1
    :
    CMP #120
    BNE :+
    JMP sec2
    :
    AND #$07
    CMP #0
    BNE :+
    JMP animate
    :
    JMP Done
    animate:
        LDA wagonRest
        BEQ :+
        JMP :+++
        :
        LDA oxenFrame
        BPL :+
        JMP Done
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
        JMP Done
    sec1:
        ; 1st second: move wagon
        LDA oxenFrame
        AND #%01111111
        STA oxenFrame
        INC frameCounter
        JMP Done
    sec2:
        ; 2nd second: pause, update counters, roll for event
        LDA #%10000000
        STA oxenFrame
        JSR ElapseDay
        JSR BufferDrawMainMenuHUDValues
        JSR RestOneDay
        JSR BufferDrawTravelingHUDValues
        LDA #0
        STA frameCounter
        JMP Done
    Done:
    RTS
.endproc
