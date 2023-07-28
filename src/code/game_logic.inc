
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

.proc NewMenuOpened
    ; A-register should contain menuOpen.
    CMP #MENU_NONE      ; which menu was just opened?
    BNE :+
    JMP None
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
    CMP #MENU_TEXTPOPUP
    BNE :+
    JMP TextPopup
    :
    JMP Done
    None:
        LDA #0
        STA fingerLastLastX
        STA fingerLastLastY ; clear LastLast pos since we are NOT in a submenu.
        LDA gameState
        CMP #GAMESTATE_NEWGAME
        BNE :+
        LDA #%00001100      ; both fingers visible, normal, pointing right
        STA fingerAttr
        JSR LoadBgNewGame
        :
        CMP #GAMESTATE_STORE
        BNE :+
        LDA #%00001100      ; both fingers visible, normal, pointing right
        STA fingerAttr
        JSR RedrawFinger
        JSR LoadBgStore
        :
        CMP #GAMESTATE_LANDMARK
        BNE :+
        LDA #%00000000      ; neither finger visible
        STA fingerAttr
        JSR LoadBgLandmark
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
        LDA #%00010100      ; only finger visible, up/down arrow
        STA fingerAttr
        LDX #15
        LDY #21
        JSR MoveFingerToSubmenu
        JSR DrawRestSubmenu
        JSR RedrawFinger
        JMP Done
    TextPopup:

        JSR BufferDrawTextPopup
        JMP Done
    Done:
    LDA menuOpen
    STA menuOpenLast    ; reset last menu open
    LDA #0
    STA frameCounter    ; reset framecounter
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

.proc Every60Frames
    LDA gameState ; only on main traveling screen
    CMP #GAMESTATE_TRAVELING
    BNE :+
    LDA menuOpen
    CMP #MENU_NONE
    BNE :+
    JMP :++
    :
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
        ; JSR BufferClearTravelingHUDValues
        JSR BufferDrawTravelingHUDValues
        LDA #0
        STA frameCounter
        JMP Done
    Done:
    RTS
.endproc

.proc ProcessEventQueue
    LDA eventQueue ; proceed only if an event is queued
    CMP #EVENT_NONE
    BNE :+
    JMP Done
    :
    TAY ; stash event ID in Y register
    LDA eventQueue+1    ; shift all queued events and decrement pointer 
    STA eventQueue
    LDA eventQueue+2
    STA eventQueue+1
    LDA eventQueue+3
    STA eventQueue+2
    LDA #EVENT_NONE
    STA eventQueue+3
    DEC eventQueuePointer
    TYA                ; unstash event ID
    CMP #EVENT_NEXT_LANDMARK  ; switch/case event id
    BNE :+
    JMP NextLandmark
    :
    CMP #EVENT_INDIAN_FOOD
    BNE :+
    JMP IndianFood
    :
    JMP Done
    NextLandmark:
        LDX #0
        :
        LDA nextLandmarkText, X ; "it is "
        STA popupTextLine1, X
        INX
        CPX #6
        BNE :-
        LDY #1
        :
        LDA nextDigit, Y
        STA popupTextLine1, X
        INX
        INY
        CPX #9
        BNE :-
        :
        LDA nextLandmarkText, X ; " miles to "
        STA popupTextLine1, X
        INX
        CPX #18
        BNE :-
        LDX location ; "{location title}."
        INX
        JSR GetLandmarkText
        LDX helper
        LDY #0
        :
        LDA locationNameText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY helper2
        BNE :-
        LDA #_PD
        STA popupTextLine2, Y
        LDA #MENU_TEXTPOPUP
        STA menuOpen
        JMP Done
    IndianFood:
        LDX #1
        LDY #0
        :
        LDA eventIndianFoodText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventIndianFoodText
        BNE :-
        LDA #MENU_TEXTPOPUP
        STA menuOpen
        JMP Done



    Done:
    RTS
.endproc

.proc QueueEvent
    ; A: event id to add to queue
    ; clobbers X register
    LDX eventQueuePointer
    STA eventQueue, X
    INC eventQueuePointer
    RTS
.endproc

.proc ElapseDay
    JSR GenerateWeather
    JSR RandomEvent
    JSR IncrementDate
    RTS
.endproc

.proc GenerateWeather
    ; clobbers A, helper, helper+1, helper2
    JSR RandomNumberGenerator ; 50% chance to generate new weather
    CMP #$80
    BCS :+
    JMP Done
    :
    LDA location    ; get current location index
    AND #%00011111
    CMP #3
    BCS :+
    LDA #0  ; Zone 1: Independence to Fort Kearney
    JMP Generate
    :
    CMP #5
    BCS :+
    LDA #12 ; Zone 2: Fort Kearney to Fort Laramie
    JMP Generate
    :
    CMP #6
    BCS :+
    LDA #24 ; Zone 3: Fort Laramie to Independence Rock
    JMP Generate
    :
    CMP #11
    BCS :+
    LDA #36 ; Zone 4: Independence Rock to Fort Hall
    JMP Generate
    :
    CMP #16
    BCS :+
    LDA #48 ; Zone 5: Fort Hall to The Dalles
    JMP Generate
    :
    LDA #60 ; Zone 6: The Dalles to Willamette Valley
    Generate:
    CLC
    ADC dateMonth
    STA helper2 ; table index
    TAX
    LDA temperatureTable, X
    STA helper ; this month's mean temp
    :
    JSR RandomNumberGenerator ; add (-20,20) degrees Fahrenheit
    CMP #160+1
    BCS :- ; 0 to 160
    LSR ; 0 to 80
    LSR ; 0 to 40
    CMP #20
    BCS :+
    STA helper+1 ; -0 to -20
    SEC
    LDA helper
    SBC helper+1 ; this month's mean temp minus [0 to 20]
    JMP Temperature
    : ; 20 to 40
    SEC ; +0 to +20
    SBC #20
    STA helper+1
    CLC
    LDA helper
    ADC helper+1 ; this month's mean temp plus [0 to 20]
    Temperature:
    CMP #10
    BCS :+
    LDA #0 ; very cold
    JMP Rainfall
    :
    CMP #30
    BCS :+
    LDA #1 ; cold
    JMP Rainfall
    :
    CMP #50
    BCS :+
    LDA #2 ; cool
    JMP Rainfall
    :
    CMP #70
    BCS :+
    LDA #3 ; warm
    JMP Rainfall
    :
    CMP #90
    BCS :+
    LDA #4 ; hot
    JMP Rainfall
    :
    LDA #5 ; very hot
    Rainfall:
    STA weather
    JSR RandomNumberGenerator
    LDX helper2
    CMP rainfallTable, X ; Precipitation chance
    BCC :+
    JMP Done ; Not precipitating
    :
    LDA weather ; Precipitating
    CMP #2 ; if weather is cold/very cold, snow instead of rain
    BCS :+
    LDA #WEATHER_SNOWY
    STA weather
    JMP HeavyRainfall
    :
    LDA #WEATHER_RAINY
    STA weather
    HeavyRainfall:
    :
    JSR RandomNumberGenerator
    CMP #250 ; 0 to 250
    BCS :-
    CMP #75 ; 30% chance for "heavy" precipitation
    BCS :+
    INC weather
    JMP Done
    : ; 70% chance for "light" precipitation
    Done:
    ; LDA rainfallTable
    RTS
.endproc
