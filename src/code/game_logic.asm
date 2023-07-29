
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

; .proc NewMenuOpened
; moved to rom1.asm as a test...

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
    CMP #EVENT_REACHED_LANDMARK
    BNE :+
    JMP ReachedLandmark
    :
    CMP #EVENT_LOAD_LANDMARK
    BNE :+
    JMP LoadLandmark
    :
    CMP #EVENT_INDIAN_FOOD
    BNE :+
    JMP IndianFood
    :
    CMP #EVENT_THUNDERSTORM
    BNE :+
    JMP Thunderstorm
    :
    CMP #EVENT_BLIZZARD
    BNE :+
    JMP Blizzard
    :
    CMP #EVENT_HEAVY_FOG
    BNE :+
    JMP HeavyFog
    :
    CMP #EVENT_HAIL_STORM
    BNE :+
    JMP HailStorm
    :
    CMP #EVENT_INJURED_OX
    BNE :+
    JMP InjuredOx
    :
    CMP #EVENT_INJURED_PERSON
    BNE :+
    JMP InjuredPerson
    :
    CMP #EVENT_SNAKE_BITE
    BNE :+
    JMP SnakeBite
    :
    CMP #EVENT_LOSE_TRAIL
    BNE :+
    JMP LoseTrail
    :
    CMP #EVENT_WRONG_TRAIL
    BNE :+
    JMP WrongTrail
    :
    CMP #EVENT_ROUGH_TRAIL
    BNE :+
    JMP RoughTrail
    :
    CMP #EVENT_IMPASSIBLE_TRAIL
    BNE :+
    JMP ImpassibleTrail
    :
    CMP #EVENT_WILD_FRUIT
    BNE :+
    JMP WildFruit
    :
    CMP #EVENT_FIRE_WAGON
    BNE :+
    JMP FireWagon
    :
    CMP #EVENT_LOST_PERSON
    BNE :+
    JMP LostPerson
    :
    CMP #EVENT_OX_WANDERS_OFF
    BNE :+
    JMP OxWandersOff
    :
    CMP #EVENT_ABANDONED_WAGON
    BNE :+
    JMP AbandonedWagon
    :
    CMP #EVENT_THIEF
    BNE :+
    JMP Thief
    :
    CMP #EVENT_BAD_WATER
    BNE :+
    JMP BadWater
    :
    CMP #EVENT_LITTLE_WATER
    BNE :+
    JMP LittleWater
    :
    CMP #EVENT_INADEQUATE_GRASS
    BNE :+
    JMP InadequateGrass
    :
    CMP #EVENT_ILLNESS
    BNE :+
    JMP Illness
    :
    CMP #EVENT_BROKEN_PART
    BNE :+
    JMP BrokenPart
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
    ReachedLandmark:
        LDX #0
        :
        LDA reachedLandmarkText, X ; "you have reached"
        STA popupTextLine1, X
        INX
        CPX #17
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
    LoadLandmark:
        LDA #MENU_NONE
        STA menuOpen
        LDA #GAMESTATE_LANDMARK
        STA gameState
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
    Thunderstorm:
        JMP Done
    Blizzard:
        JMP Done
    HeavyFog:
        JMP Done
    HailStorm:
        JMP Done
    InjuredOx:
        JMP Done
    InjuredPerson:
        JMP Done
    SnakeBite:
        JMP Done
    LoseTrail:
        JMP Done
    WrongTrail:
        JMP Done
    RoughTrail:
        LDX #1
        LDY #0
        :
        LDA eventRoughTrail, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventRoughTrail
        BNE :-
        LDA #MENU_TEXTPOPUP
        STA menuOpen
        JMP Done
    ImpassibleTrail:
        JMP Done
    WildFruit:
        JMP Done
    FireWagon:
        JMP Done
    LostPerson:
        JMP Done
    OxWandersOff:
        JMP Done
    AbandonedWagon:
        JMP Done
    Thief:
        JMP Done
    BadWater:
        LDX #1
        LDY #0
        :
        LDA eventBadWaterText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventBadWaterText
        BNE :-
        LDA #MENU_TEXTPOPUP
        STA menuOpen
        JMP Done
    LittleWater:
        LDX #1
        LDY #0
        :
        LDA eventLittleWaterText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventLittleWaterText
        BNE :-
        LDA #MENU_TEXTPOPUP
        STA menuOpen
        JMP Done
    InadequateGrass:
        JMP Done
    Illness:
        JMP Done
    BrokenPart:
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
    JSR UpdateSupplies
    JSR UpdateHealth
    JSR UpdateDistance
    JSR RandomEvent
    JSR IncrementDate
    RTS
.endproc

.proc UpdateSupplies
    ; eat food
    JSR CountAlivePeople
    STA helper
    LDA wagonSettings
    AND #%00001100
    LSR
    LSR
    TAX
    :
    SEC
    LDA foodLbs
    SBC helper
    STA foodLbs
    LDA foodLbs+1
    SBC #0
    STA foodLbs+1
    BCC :+
    DEX
    BNE :-
    JMP Done
    :
    LDA #0
    STA foodLbs
    STA foodLbs+1
    Done:
    LDX #foodLbsDigit
    LDY #foodLbs
    JSR SetDigitFromValue
    RTS
.endproc

.proc UpdateHealth
    ; 0-34: good health
    ; 35-69: fair health
    ; 70-104: poor health
    ; 105-139: very poor health
    ; 140+: remaining party members all die within a few days
    LDA #0
    STA helper2+1 ; 0:fine, 1:freezing or starving 
    
    ; Natural recovery process (decrement by 10%)
    LDA wagonHealth
    STA helper
    LDA #0
    STA helper+1
    :
    SEC
    LDA helper
    SBC #10
    BCC :+
    STA helper
    INC helper+1
    JMP :-
    :
    SEC
    LDA wagonHealth
    SBC helper+1
    STA wagonHealth

    ; Weather
    LDA weather
    @veryCold:
        ; add 0 if 4 or more sets of clothing per person
        ; add 4 if 0 sets of clothing per person
        ; apply a sliding scale if between 0 and 4 sets of clothing per person
        CMP #WEATHER_COLD
        BCS @cold
        JSR CountAlivePeople
        STA helper2
        LDA clothing ; divide clothing by alive person count
        STA helper
        LDA #4
        STA helper+1 ; health loss: starts at 4 
        :
        SEC
        LDA helper ; clothing
        SBC helper2 ; alive person count
        BCC :+
        STA helper
        DEC helper+1 ; -1 health loss for each set of clothing
        BEQ :+
        JMP :-
        :
        CLC
        LDA wagonHealth 
        ADC helper+1 ; add health loss to wagonHealth
        STA wagonHealth
        LDA helper+1
        CMP #0
        BEQ :+
        CLC
        LDA wagonFreezeStarve ; freeze factor: add 0.8 (4 * 0.2)
        ADC #4
        STA wagonFreezeStarve
        LDA #1
        STA helper2+1
        :
        JMP Rations
    @cold:
        ; add 0 if 2 or more sets of clothing per person
        ; add 2 if 0 sets of clothing per person
        ; apply a sliding scale if between 0 and 2 sets of clothing per person
        CMP #WEATHER_COOL
        BCS @cool
        JSR CountAlivePeople
        STA helper2
        LDA clothing ; divide clothing by alive person count
        STA helper
        LDA #2
        STA helper+1 ; health loss: starts at 2 
        :
        SEC
        LDA helper ; clothing
        SBC helper2 ; alive person count
        BCC :+
        STA helper
        DEC helper+1 ; -1 health loss for each set of clothing
        BEQ :+
        JMP :-
        :
        CLC
        LDA wagonHealth 
        ADC helper+1 ; add health loss to wagonHealth
        STA wagonHealth
        LDA helper+1
        CMP #0
        BEQ :+
        CLC
        LDA wagonFreezeStarve ; freeze factor: add 0.8 (4 * 0.2)
        ADC #4
        STA wagonFreezeStarve
        LDA #1
        STA helper2+1
        :
        JMP Rations
    @cool:
        ; add 0; the best weather for traveling
        CMP #WEATHER_WARM
        BCS @warm
        JMP Rations
    @warm:
        ; add 0; the best weather for traveling
        CMP #WEATHER_HOT
        BCS @hot
        JMP Rations
    @hot:
        ; add 1
        CMP #WEATHER_VERY_HOT
        BCS @veryHot
        INC wagonHealth
        JMP Rations
    @veryHot:
        ; add 2
        CMP #WEATHER_RAINY
        BCS @rainy
        INC wagonHealth
        INC wagonHealth
        JMP Rations
    @rainy:
    
    Rations:
    ; Food rations
    LDA foodLbs+1
    CMP #0
    BNE :+
    LDA foodLbs
    CMP #0
    BNE :+
    CLC ; starving: 6
    LDA wagonHealth
    ADC #6
    STA wagonHealth
    CLC
    LDA wagonFreezeStarve ; starve factor: add 0.8 (4 * 0.2)
    ADC #4
    STA wagonFreezeStarve
    LDA #1
    STA helper2+1
    JMP FreezeStarve
    :
    LDA wagonSettings
    AND #%00001100
    LSR
    LSR
    CMP #2
    BCS :+
    CLC ; bare bones rations: 4
    LDA wagonHealth
    ADC #4
    STA wagonHealth
    JMP FreezeStarve
    :
    CMP #3
    BCS :+
    CLC ; meager rations: 2
    LDA wagonHealth
    ADC #2
    STA wagonHealth
    JMP FreezeStarve
    : ; filling rations: 0
    
    ; Freeze/starve factor
    FreezeStarve:
    LDA helper2+1
    BNE :+
    LDA wagonFreezeStarve
    LSR
    STA wagonFreezeStarve ; divide by 2 if neither freezing nor starving
    JMP Pace
    :
    LDA wagonFreezeStarve
    STA helper ; wagonFreezeStarve divided by 5
    LDA #0
    STA helper+1
    LDX #0
    :
    SEC
    LDA helper
    SBC #5
    STA helper
    LDA helper+1
    SBC #0
    STA helper+1
    BCC :+
    INX
    JMP :-
    :
    CLC
    LDA wagonHealth
    STX helper
    ADC helper
    STA wagonHealth

    Pace:
    LDA wagonSettings
    AND #%00010000
    BEQ :+
    JMP Illness ; resting
    :
    AND #%00000011
    CLC
    ROL
    ADC wagonHealth
    STA wagonHealth

    Illness:
    ; For each sick or injured person, add 1
    LDX #0
    STA helper
    :
    LDA personHealth, X
    AND #%00000111
    BEQ :+
    INC wagonHealth
    :
    INX
    CPX #5
    BNE :--

    Done:
    RTS
.endproc

.proc UpdateDistance
    ; standard speed: 20 miles per day
    ; maximum speed is 40mpd, at full health, 4+ oxen, in prairie terrain
    LDA #80 ; x0.25 mpd = 20 mpd standard
    STA helper
    LDA #0
    STA helper+1
    ; Pace
    LDA wagonSettings
    AND #%00000011
    TAX
    DEX
    :
    CPX #0
    BEQ :+
    CLC
    LDA helper
    ADC #40 ; strenuous: +10mpd, grueling: +20 mpd
    STA helper
    DEX
    JMP :-
    :
    ; Mountainous terrain: x0.5
    JSR CheckMountainousTerrain
    CMP #1
    BNE :+
    LDA helper
    LSR
    STA helper
    :
    ; Oxen: x(number of healthy oxen)/4
    ; sick or injured ox counts as 1/2 of a healthy ox
    LDA oxenHeadcount
    CLC
    ROL ; x2 so we can count half-ox 
    SEC
    SBC oxenHealth
    CMP #8
    BCS Travel ; skip if 4+ healthy oxen
    ; helper *= A / #8
    TAX ; x: oxencount*2
    LDA helper
    STA cartHelperDigit ; hack, stash mpd
    CPX #0
    BNE :+
    LDA #0 ; no oxen!
    STA helper
    JMP Travel
    : ; multiply mpd by oxencount*2
    CLC
    LDA helper
    ADC cartHelperDigit
    STA helper
    LDA helper+1
    ADC #0
    STA helper+1
    DEX
    BNE :-
    ; divide by 8
    LSR helper+1
    ROR helper
    LSR helper+1
    ROR helper
    LSR helper+1
    ROR helper
    Travel:
    LSR helper ; convert from 0.25x mpd to 1x mpd (divide by 4)
    LSR helper 
    SEC ; subtract from distance to next landmark
    LDA nextMi
    STA helper+1 ; stash remaining miles in case it is less than our mpd
    SBC helper
    STA nextMi
    LDA nextMi+1
    SBC #0
    STA nextMi+1
    BCS :+
    LDA #0 ; mpd > remaining miles
    STA nextMi ; we're at the landmark: clear nextMi
    STA nextMi+1
    LDA #EVENT_REACHED_LANDMARK
    JSR QueueEvent
    LDA #EVENT_LOAD_LANDMARK
    JSR QueueEvent
    LDA helper+1 ; unstash remaining miles
    STA helper ; replace mpd with remaining miles (ie stop at the landmark) 
    :
    CLC ; add mpd to total distance traveled
    LDA traveledMi
    ADC helper
    STA traveledMi
    LDA traveledMi+1
    ADC #0
    STA traveledMi+1

    LDX #traveledDigit
    LDY #traveledMi
    JSR SetDigitFromValue
    LDX #nextDigit
    LDY #nextMi
    JSR SetDigitFromValue

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
    RTS
.endproc