
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
        LDY #0
        :
        LDA textLineHelper, Y
        STA popupTextLine2, Y
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
        LDY #0
        :
        LDA textLineHelper, Y
        STA popupTextLine2, Y
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
        LDX #1
        LDY #0
        :
        LDA eventHeavyFogText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventHeavyFogText
        BNE :-
        LDA wagonRest
        BEQ :++
        LDA #_PD
        STA popupTextLine1, Y
        LDY #0
        LDX #1
        :
        LDA eventLoseDaysText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY eventLoseDaysText
        BNE :-
        LDA #_PD
        STA popupTextLine2, Y
        :
        LDA #MENU_TEXTPOPUP
        STA menuOpen
        JMP Done
    HailStorm:
        LDX #1
        LDY #0
        :
        LDA eventHailStormText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventHailStormText
        BNE :-
        LDA #MENU_TEXTPOPUP
        STA menuOpen
        JMP Done
    InjuredOx:
        LDX #1
        LDY #0
        :
        LDA eventInjuredOxText, X ; "ONE OF THE OXEN"
        STA popupTextLine1, Y
        INX
        INY
        CPY eventInjuredOxText
        BNE :-
        LDA oxenHealth
        BEQ :++
        LDX #16 ;"IS INJURED"
        INX
        LDY #0
        :
        LDA eventInjuredOxText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY #11
        BNE :-
        JMP :++++
        :
        LDX #1
        LDY #0
        :
        LDA eventIllnessText, X ; "HAS DIED"
        STA popupTextLine2, Y
        INX
        INY
        CPY #4
        BNE :-
        LDX #58 ; index of "DIED"
        :
        LDA eventIllnessText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY #8
        BNE :-
        LDA #_PD
        STA popupTextLine2, Y
        :
        LDA #MENU_TEXTPOPUP
        STA menuOpen
        JMP Done
    InjuredPerson:
         ; TODO should count as an illness in death roll
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
        LDA eventRoughTrailText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventRoughTrailText
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
        LDX #1
        LDY #0
        :
        LDA eventInadequateGrassText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventInadequateGrassText
        BNE :-
        LDA #MENU_TEXTPOPUP
        STA menuOpen
        JMP Done
    Illness:
        JSR RandomNumberGenerator ; select a random person
        AND #%00000111
        CMP #5 ; limit roll to 0-4 
        BCS Illness
        TAX ; check if they are alive, already sick, or dead
        LDA personHealth, X
        AND #%11111000
        CMP #%11111000
        BEQ Illness ; already dead: roll again
        CMP #1
        BCC :+ ; alive and healthy: become sick
        LDA #%11111000 ; currently sick: die
        STA personHealth, X
        JMP @writeName
        :
        JSR RandomNumberGenerator
        AND #%00000111
        CMP #6 ; limit roll to 0-5
        BCS :-
        STA helper
        INC helper ; roll is now 1-6 (disease ID)
        LDA #%01010000 ; sick for 10 days
        ORA helper
        STA personHealth, X
        @writeName:
        STX helper ; ID of person who gets illness
        LDA #0
        STA helper+1
        LDX #0
        :
        CPX helper
        BEQ :+
        INX
        CLC
        LDA helper+1
        ADC #TEXT_PERSON_LEN
        STA helper+1
        JMP :-
        :
        LDX helper+1
        LDY #0 ; "{person name}"
        LDA #0
        STA helper2
        :
        LDA personName, X
        STA popupTextLine1, Y
        INX
        INY
        INC helper2
        LDA helper2
        CMP #TEXT_PERSON_LEN
        BNE :-
        LDX #0 ; " HAS "
        :
        LDA eventIllnessText, X
        STA popupTextLine1, Y
        INX
        INY
        CPX #5
        BNE :-
        LDX helper ; "{illness name}"
        LDA personHealth, X 
        CMP #%11111000
        BNE :+
        LDX #57 ; index of "DIED" minus 1
        LDA #4
        STA helper2
        JMP @writeIllness
        :
        AND #%00000111
        STA helper ; ID of illness (1-6)
        LDA #5
        STA helper+1 ; index of beginning of text segment
        TYA
        PHA
        LDY #1
        :
        LDX helper+1
        LDA eventIllnessText, X
        STA helper2 ; length of text segment
        CPY helper
        BEQ :+
        CLC
        LDA helper+1
        ADC eventIllnessText, X
        STA helper+1
        INC helper+1
        INY
        JMP :-
        :
        PLA
        TAY
        LDX helper+1
        @writeIllness:
        LDA #0
        STA helper ; counter
        :
        INX
        LDA eventIllnessText, X
        STA popupTextLine1, Y
        INY
        INC helper
        LDA helper
        CMP helper2
        BNE :-
        ; TODO word wrap for great justice
        LDA #_PD ; "."
        STA popupTextLine1, Y
        LDA #MENU_TEXTPOPUP
        STA menuOpen
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
    JSR UpdateWeather
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

    ; decrement remaining days of illness
    LDX #0
    :
    LDA personHealth, X
    AND #%11111000
    CMP #%11111000
    BEQ :+
    SEC
    LDA personHealth, X
    SBC #%00001000
    BCC :+
    STA personHealth, X
    AND #%11111000
    BNE :+
    LDA #0
    STA personHealth, X
    :
    INX
    CPX #5
    BNE :--

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
    ; TODO:  Each sick party member: 10% decrease in speed
    ; TODO: Snow on the ground: up to 100% loss of speed at 30" of snow
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
    LDA #0 ; mpd > remaining miles ; TODO: >=, not >
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

.proc UpdateWeather
    ; clobbers A, helper, helper+1, helper2, pointer
    JSR RandomNumberGenerator ; 50% chance to generate new weather
    CMP #$80
    BCS :+
    JMP MeltSnow
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
    DEC helper2
    TAX
    DEX
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
    JMP MeltSnow ; Not precipitating
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
    LDA #8
    STA helper2
    JMP MeltSnow
    : ; 70% chance for "light" precipitation
    LDA #2
    STA helper2
    MeltSnow: ; Melt snow and/or disappear/evaporate rain
    LDA #0 ; subtract 10% of accumulated rainfall
    STA helper
    LDA accumulatedRain
    STA helper+1
    SEC
    :
    LDA helper+1
    SBC #10
    STA helper+1
    INC helper
    BCS :-
    SEC
    LDA accumulatedRain
    SBC helper
    BCS :+
    LDA #0
    :
    STA accumulatedRain
    LDA weather ; subtract from accumulated snowfall
    CMP #WEATHER_WARM
    BCS :++
    LDA #0 ; is very cold, cold, or cool; subtract 3% snowfall
    STA helper
    LDA accumulatedSnow
    STA helper+1
    SEC
    :
    LDA helper+1
    SBC #33
    STA helper+1
    INC helper
    BCS :-
    SEC
    LDA accumulatedSnow
    SBC helper
    STA accumulatedSnow
    BCS AccumulateRainfall
    LDA #0
    STA accumulatedSnow
    JMP AccumulateRainfall
    : ; it is warm+ or precipitating
    CMP #WEATHER_SNOWY
    BCS AccumulateRainfall ; it is snowing; do not subtract from snowfall
    SEC ; it is not cold nor snowing; melt 5" of snow to 0.5" of water
    LDA accumulatedSnow
    SBC #5*8
    STA accumulatedSnow
    BCS :+
    LDA #0
    STA accumulatedSnow
    JMP AccumulateRainfall
    :
    LDA accumulatedRain
    ADC #5
    STA accumulatedRain
    AccumulateRainfall:
    LDA weather
    CMP #WEATHER_RAINY
    BCS :+
    JMP Done
    :
    CMP #WEATHER_SNOWY
    BCS :+++
    CMP #WEATHER_VERY_RAINY
    BCS :+
    LDA #2 ; 0.1" increments (+0.2" light rain)
    STA helper2
    JMP :++
    :
    LDA #8 ; 0.1" increments (+0.8" heavy rain)
    STA helper2
    :
    CLC ; it is raining; accumulate rain instead of snow
    LDA accumulatedRain
    ADC helper2 ; 0.1" increments (+0.8" heavy rain or +0.2" light rain)
    STA accumulatedRain
    JMP Done
    :
    CMP #WEATHER_VERY_SNOWY
    BCS :+
    LDA #2*8 ; 0.125" increments (+2.0" light snow)
    STA helper2
    JMP :++
    :
    LDA #8*8 ; 0.125" increments (+8.0" heavy snow)
    STA helper2
    :
    CLC ; it is snowing; accumulate snow instead of rain
    LDA accumulatedSnow
    ADC helper2
    STA accumulatedSnow
    Done:
    RTS
.endproc

.proc BufferDrawTalkText
    LDA location ; get memory location of compressed talk text
    ASL
    CLC
    ADC talkOption
    ADC talkOption
    TAX
    LDA talkPointer, X
    STA pointer
    INX
    LDA talkPointer, X
    STA pointer+1
    
    LDY #0 ; decompress and draw talk text
    Segment:
    LDA (pointer), Y ; read first header byte
    AND #$0f
    STA helper ; punctuation type
    LDA (pointer), Y
    LSR
    LSR
    LSR
    LSR
    STA helper+1 ; remaining header length
    INY
    LDX #0 ; read word length header bytes
    STX helper2 ; talkTextBuffer index
    :
    TXA
    PHA
    LDA (pointer), Y
    LSR
    LSR
    LSR
    LSR
    LDX helper2
    STA talkTextBuffer, X ; stash word lengths
    INC helper2
    INX
    LDA (pointer), Y
    AND #$0f
    STA talkTextBuffer, X
    INC helper2
    PLA
    TAX
    INY
    INX
    CPX helper+1
    BNE :-
    LDX #0 ; begin decompress segment payload
    Word:
    LDA talkTextBuffer, X
    STA helper+1 ; character length of next word
    TXA
    PHA
    LDX #0
    :
    LDA (pointer), Y
    CMP #210
    BCC :+
    ; literal character
    :
    ; dictionary lookup




    INC talkOption ; increment talkOption
    LDA talkOption
    CMP #3
    BNE Done
    LDA #0
    STA talkOption
    Done:
    RTS
.endproc
