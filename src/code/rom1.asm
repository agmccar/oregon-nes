
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
    CMP #EVENT_LOOK_AROUND
    BNE :+
    JMP LookAround
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
    LookAround:
        LDX #0
        :
        LDA eventLookAroundText, X ; "Would you like to"
        STA popupTextLine1, X
        INX
        CPX #17
        BNE :-
        LDY #0
        :
        LDA eventLookAroundText, X  ; "look around? <YES>"
        STA popupTextLine2, Y
        INX
        INY
        CPY #12
        BNE :-
        LDA #___
        STA popupTextLine2, Y
        LDA #MENU_TEXTPOPUP_YN
        STA menuOpen
        JMP Done
    LoadLandmark:
        LDA #MENU_NONE
        STA menuOpen
        INC location ; increment landmark (todo handle trail divide)
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
        LDX #1
        LDY #0
        :
        LDA eventThunderstormText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventThunderstormText
        BNE :-
        LDX #1
        LDY #0
        :
        LDA eventLoseDaysText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY eventLoseDaysText
        BNE :-
        LDA #_PD
        STA popupTextLine2, Y
        LDA #MENU_TEXTPOPUP
        STA menuOpen
        JMP Done
    Blizzard:
        LDX #1
        LDY #0
        :
        LDA eventBlizzardText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventBlizzardText
        BNE :-
        LDX #1
        LDY #0
        :
        LDA eventLoseDaysText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY eventLoseDaysText
        BNE :-
        LDA #_PD
        STA popupTextLine2, Y
        LDA #MENU_TEXTPOPUP
        STA menuOpen
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
        LDA wagonRest
        BNE :+
        JMP :+++
        :
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
        LDA wagonRest
        BEQ :++
        LDA #_PD
        STA popupTextLine1, Y
        LDA wagonRest
        BNE :+
        JMP :+++
        :
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
    InjuredPerson: ; TODO DRY
        JSR RandomNumberGenerator ; select a random person
        AND #%00000111
        CMP #5 ; limit roll to 0-4 
        BCS InjuredPerson
        TAX ; check if they are alive, already sick, or dead
        LDA personHealth, X
        AND #%11111000
        CMP #%11111000
        BEQ InjuredPerson ; already dead: roll again
        CMP #1
        BCC :+ ; alive and healthy: become injured
        LDA #%11111000 ; currently sick: die
        STA personHealth, X
        JMP @writeName
        :
        JSR RandomNumberGenerator
        LDA #%11110111 ; broken limb for 30 days
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
        BNE @BrokenLimb
        LDX #57 ; index of "DIED" minus 1
        LDA #4
        STA helper2
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
        JMP @writeIllness
        @BrokenLimb:
        LDA #_A_
        STA popupTextLine1, Y
        INY
        LDA #___
        STA popupTextLine1, Y
        INY
        LDX #10 ; index of "BROKEN"
        :
        LDA eventInjuryText, X
        STA popupTextLine1, Y
        INY
        INX
        CPX #16 ; index of "ARM"
        BNE :-
        LDA #19 ; index of "LEG"
        STA helper
        TYA
        PHA
        JSR RandomNumberGenerator
        AND #1
        BNE :+
        INC helper
        INC helper
        INC helper
        INX
        INX
        INX
        :
        PLA
        TAY
        LDA #___
        STA popupTextLine1, Y
        INY
        :
        LDA eventInjuryText, X
        STA popupTextLine1, Y
        INY
        INX
        CPX helper
        BNE :-
        @writeIllness:
        LDA #_PD
        STA popupTextLine1, Y
        LDA #MENU_TEXTPOPUP
        STA menuOpen
        JMP Done
    SnakeBite: ; TODO DRY
        JSR RandomNumberGenerator ; select a random person
        AND #%00000111
        CMP #5 ; limit roll to 0-4 
        BCS SnakeBite
        TAX ; check if they are alive, already sick, or dead
        LDA personHealth, X
        AND #%11111000
        CMP #%11111000
        BEQ SnakeBite ; already dead: roll again
        CMP #1
        BCC :+ ; alive and healthy: become injured
        LDA #%11111000 ; currently sick: die
        STA personHealth, X
        JMP @writeName
        :
        JSR RandomNumberGenerator
        LDA #%01010111 ; snake bite for 10? days (not specified in Bouchard book)
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
        BNE @BrokenLimb
        LDX #57 ; index of "DIED" minus 1
        LDA #4
        STA helper2
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
        JMP @writeIllness
        @BrokenLimb:
        LDA #_A_
        STA popupTextLine1, Y
        INY
        LDA #___
        STA popupTextLine1, Y
        INY
        LDX #0 ; index of "SNAKE BITE"
        :
        LDA eventInjuryText, X
        STA popupTextLine1, Y
        INY
        INX
        CPX #10
        BNE :-
        @writeIllness:
        LDA #_PD
        STA popupTextLine1, Y
        LDA #MENU_TEXTPOPUP
        STA menuOpen
        JMP Done
    LoseTrail:
        LDX #1
        LDY #0
        :
        LDA eventLoseTrailText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventLoseTrailText
        BNE :-
        LDY #0
        LDX #1
        :
        LDA eventLoseDaysText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY eventLoseDaysText
        BNE :-
        TYA
        PHA
        DEY ; replace 1 day with X day(s)
        DEY
        DEY
        DEY
        DEY
        CLC
        LDA wagonRest
        ADC #_0_
        STA popupTextLine2, Y
        PLA
        TAY
        LDA wagonRest
        CMP #1
        BEQ :+
        LDA #_S_
        STA popupTextLine2, Y
        INY
        :
        LDA #_PD
        STA popupTextLine2, Y
        LDA #MENU_TEXTPOPUP
        STA menuOpen
        JMP Done
    WrongTrail:
        LDX #1
        LDY #0
        :
        LDA eventWrongTrailText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventWrongTrailText
        BNE :-
        LDY #0
        LDX #1
        :
        LDA eventLoseDaysText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY eventLoseDaysText
        BNE :-
        TYA
        PHA
        DEY ; replace 1 day with X day(s)
        DEY
        DEY
        DEY
        DEY
        CLC
        LDA wagonRest
        ADC #_0_
        STA popupTextLine2, Y
        PLA
        TAY
        LDA wagonRest
        CMP #1
        BEQ :+
        LDA #_S_
        STA popupTextLine2, Y
        INY
        :
        LDA #_PD
        STA popupTextLine2, Y
        LDA #MENU_TEXTPOPUP
        STA menuOpen
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
        LDX #1
        LDY #0
        :
        LDA eventImpassibleTrailText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventImpassibleTrailText
        BNE :-
        LDY #0
        LDX #1
        :
        LDA eventLoseDaysText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY eventLoseDaysText
        BNE :-
        TYA
        PHA
        DEY ; replace 1 day with X day(s)
        DEY
        DEY
        DEY
        DEY
        CLC
        LDA wagonRest
        ADC #_0_
        STA popupTextLine2, Y
        PLA
        TAY
        LDA wagonRest
        CMP #1
        BEQ :+
        LDA #_S_
        STA popupTextLine2, Y
        INY
        :
        LDA #_PD
        STA popupTextLine2, Y
        LDA #MENU_TEXTPOPUP
        STA menuOpen
        JMP Done
    WildFruit:
        LDX #1
        LDY #0
        :
        LDA eventWildFruitText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventWildFruitText
        BNE :-
        LDA #MENU_TEXTPOPUP
        STA menuOpen
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
    Illness: ; TODO DRY
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
    LDA menuOpen
    CMP #MENU_NONE
    BEQ Elapse
    CMP #MENU_MAINMENU
    BNE Done
    LDA wagonRest
    BEQ Done
    Elapse:
    JSR UpdateWeather
    JSR UpdateSupplies
    JSR UpdateHealth
    JSR UpdateDistance
    JSR RandomEvent
    JSR IncrementDate
    Done:
    RTS
.endproc

.proc RestOneDay
    LDA menuOpen
    CMP #MENU_NONE
    BEQ Rest
    CMP #MENU_MAINMENU
    BNE Done
    Rest:
    LDA wagonRest
    BEQ Done
    DEC wagonRest
    Done:
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
    LDA wagonRest ; no distance if resting
    BEQ :+
    JMP Done
    :
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
    LDA #EVENT_LOOK_AROUND
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
    Done:
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

.macro BufferStart_ len, addrHi, addrLo
    LDX len
    JSR StartBufferWrite
    LDA len
    JSR WriteByteToBuffer
    LDA addrHi
    JSR WriteByteToBuffer
    LDA addrLo
    JSR WriteByteToBuffer
.endmacro

.proc DrawTextBox
    ; X: addrHi
    ; Y: addrLo
    ; A: number of middle lines (ie not counting top/bot rows)
    PHA
    STX pointer
    STY pointer+1
    JSR BufferDrawTextBoxTopRow
    JSR PointerToNextLine
    PLA
    TAX
    :
    JSR BufferDrawTextBoxMiddleRow
    JSR PointerToNextLine
    DEX
    BNE :-
    JSR BufferDrawTextBoxBottomRow
    RTS
.endproc

.proc BufferClearTitle
    BufferStart_ #6, #$23, #$e1 ; clear attr
        LDA #$ff
        LDX #6
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite

    LDX #14 ; clear 14 rows of tiles
    LDA #$21
    STA pointer+1
    LDA #$40
    STA pointer
    Line:
    TXA
    PHA
    BufferStart_ #$20, pointer+1, pointer
        LDX #0
        LDA #___
        :
        JSR WriteByteToBuffer
        INX
        CPX #$20
        BNE :-
    JSR EndBufferWrite
    CLC
    LDA pointer
    ADC #$20
    STA pointer
    LDA pointer+1
    ADC #0
    STA pointer+1
    PLA
    TAX
    DEX
    BNE Line
    RTS
.endproc

.proc BufferDrawTitleLearn
    JSR BufferClearTitle
    LDA menuCursor
    ASL
    TAX
    LDA learnPointer, X
    STA pointer
    INX
    LDA learnPointer, X
    STA pointer+1
    LDA #$21
    STA bufferHelper
    LDA #$64
    STA bufferHelper+1
    JSR BufferDrawText

    LDA menuCursor
    CMP #5 ; "Adjust your monitor" page
    BEQ :+
    JMP Done
    :
    BufferStart_ #TEXT_POPUP_LINE_LEN, #$22, #$a4
        LDX #0 ; colors text
        :
        LDA titleColorsText, X
        JSR WriteByteToBuffer
        INX
        CPX #TEXT_POPUP_LINE_LEN
        BNE :-
    JSR EndBufferWrite
    
    LDA #$22 ; color squares
    STA pointer
    LDA #$04
    STA pointer+1
    LDX #4
    ColorSquares:
    TXA
    PHA
    BufferStart_ #24, pointer, pointer+1
        LDX #4
        LDA #TILE_LIGHT_SQ
        STA helper
        @sq:
        TXA
        PHA
        LDA #0
        JSR WriteByteToBuffer
        LDX #4
        :
        LDA helper
        JSR WriteByteToBuffer
        DEX
        BNE :-
        LDA #0
        JSR WriteByteToBuffer
        PLA
        TAX
        CPX #4
        BCS :+
        LDA #TILE_DARK_SQ
        STA helper
        :
        DEX
        BNE @sq
    JSR EndBufferWrite
    JSR PointerToNextLine
    PLA
    TAX
    DEX
    BNE ColorSquares
    
    BufferStart_ #6, #$23, #$e1 ; colorsquare attributes 
        LDA #0
        JSR WriteByteToBuffer
        LDA #%10001000
        JSR WriteByteToBuffer
        LDA #$aa
        JSR WriteByteToBuffer
        JSR WriteByteToBuffer
        LDA #%00100010
        JSR WriteByteToBuffer
        LDA #0
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    Done:
    JSR BufferDrawPressStart
    RTS
.endproc

.proc BufferDrawTitleSound
    JSR BufferClearTitle
    
    LDA soundPointer
    STA pointer
    LDA soundPointer+1
    STA pointer+1
    LDA #$21
    STA bufferHelper
    LDA #$A4
    STA bufferHelper+1
    JSR BufferDrawText

    LDA soundPointer+2
    STA pointer
    LDA soundPointer+3
    STA pointer+1
    LDA #$22
    STA bufferHelper
    LDA #$04
    STA bufferHelper+1
    JSR BufferDrawText

    BIT gameSettings
    BPL :+
    JMP Done
    :
    BufferStart_ #4, #$21, #$cb
    LDA #_O_
    JSR WriteByteToBuffer
    LDA #_N_
    JSR WriteByteToBuffer
    LDA #_PD
    JSR WriteByteToBuffer
    LDA #___
    JSR WriteByteToBuffer
    JSR EndBufferWrite
    Done:
    LDA gameSettings
    EOR #$80
    STA gameSettings
    JSR BufferDrawPressStart
    RTS
.endproc

.proc BufferDrawTopTen
    LDX #18 ; draw "The Oregon Top Ten"
    JSR StartBufferWrite
        LDA #18
        JSR WriteByteToBuffer
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$87
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA topTenHeaderText, X
        JSR WriteByteToBuffer
        INX
        CPX #18
        BNE :-
    JSR EndBufferWrite

    LDX #5 ; draw column headers
    JSR StartBufferWrite
        LDA #5
        JSR WriteByteToBuffer
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$c4
        JSR WriteByteToBuffer
        LDA #TILE_COL_HEADER ; vert line
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA topTenColumnText, X
        JSR WriteByteToBuffer
        INX
        CPX #4
        BNE :-
    JSR EndBufferWrite
    LDX #7
    JSR StartBufferWrite
        LDA #7
        JSR WriteByteToBuffer
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$cc
        JSR WriteByteToBuffer
        LDA #TILE_COL_HEADER ; vert line
        JSR WriteByteToBuffer
        LDX #4
        :
        LDA topTenColumnText, X
        JSR WriteByteToBuffer
        INX
        CPX #10
        BNE :-
    JSR EndBufferWrite
    LDX #7
    JSR StartBufferWrite
        LDA #7
        JSR WriteByteToBuffer
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$d4
        JSR WriteByteToBuffer
        LDA #TILE_COL_HEADER ; vert line
        JSR WriteByteToBuffer
        LDX #10
        :
        LDA topTenColumnText, X
        JSR WriteByteToBuffer
        INX
        CPX #16
        BNE :-
    JSR EndBufferWrite
    LDX #6
    JSR StartBufferWrite
        LDA #6
        JSR WriteByteToBuffer
        LDA #$23
        JSR WriteByteToBuffer
        LDA #$c9
        JSR WriteByteToBuffer
        LDA #%01011111
        LDX #6
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite



    LDA #0 ; draw 10 rows: name/points/rating
    STA helper ; index of row data in oregonTopTen
    LDA #8
    STA helper+1 ; end of Top Ten name data
    LDA #$21
    STA pointer ; screen location of row
    LDA #$03
    STA pointer+1
    LDX #10 ; number of rows
    NextRow:
    TXA
    PHA
    LDX #27
    JSR StartBufferWrite
        LDA #27
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDX helper
        :
        LDA oregonTopTen, X
        JSR WriteByteToBuffer ; write name
        INX
        CPX helper+1
        BNE :-
        LDA #___ ; two spaces
        JSR WriteByteToBuffer
        JSR WriteByteToBuffer
        LDA oregonTopTen, X ; stash this row's score
        STA counter+1
        INX
        LDA oregonTopTen, X
        STA counter
        INX ; stash index of next row data
        STX helper
        CLC
        LDA helper+1
        ADC #10 ; stash index of end of next row's name data
        STA helper+1
        LDX #cartHelperDigit
        LDY #counter
        JSR SetDigitFromValue
        LDX #0
        :
        LDA cartHelperDigit, X
        CMP #_UL
        BNE :+
        LDA #___
        :
        JSR WriteByteToBuffer ; score (decimal characters)
        INX
        CPX #4
        BNE :--
        LDA #___ ; two spaces
        JSR WriteByteToBuffer
        JSR WriteByteToBuffer
        LDA counter+1
        CMP topTenRating ; Good enough for "Trail Guide"?
        BCC Adventurer
        BNE :+
        LDA counter
        CMP topTenRating+1
        BCC Adventurer
        :
        LDX #2 ; index of "Trail Guide"
        LDA #2+11
        STA helper2
        JMP Rating
        Adventurer:
        LDA counter+1
        CMP topTenRating+13 ; index of "Adventurer" score high byte
        BCC Greenhorn
        BNE :+
        LDA counter
        CMP topTenRating+14
        BCC Greenhorn
        :
        LDX #15 ; index of "Adventurer"
        LDA #15+11
        STA helper2
        JMP Rating
        Greenhorn:
        LDX #28 ; index of "Greenhorn"
        LDA #28+11
        STA helper2
        Rating:
        LDA topTenRating, X
        JSR WriteByteToBuffer
        INX
        CPX helper2
        BNE Rating
    JSR EndBufferWrite
    JSR PointerToNextLine
    PLA
    TAX
    DEX
    BEQ :+
    JMP NextRow
    :
    LDX #0
    LDA #___
    :
    STA popupTextLine1, X
    STA popupTextLine2, X
    INX
    CPX #TEXT_POPUP_LINE_LEN
    BNE :-
    LDX #0
    :
    LDA topTenQuestionText, X
    STA popupTextLine1, X
    INX
    CPX #21 ; len("Would you like to see")
    BNE :-
    LDY #0
    :
    LDA topTenQuestionText, X
    STA popupTextLine2, Y
    INX
    INY
    CPX #19+21 ;  +len("how pts are earned?")
    BNE :-


    JSR BufferDrawTextBox
    RTS
.endproc

.proc LoadBgNewGame
    JSR ClearScreen
    JSR ClearAttributes

    LDA menuOpen
    CMP #MENU_NEWGAME_OCCUPATION
    BNE :+
    JMP Occupation
    :
    CMP #MENU_NEWGAME_OCC_HELP
    BNE :+
    JMP OccupationHelp
    :
    CMP #MENU_NEWGAME_NAMEPARTY
    BNE :+
    JMP NameParty
    :
    CMP #MENU_NEWGAME_STARTDATE
    BNE :+
    JMP StartDate
    :
    CMP #MENU_NEWGAME_DATE_HELP
    BNE :+
    JMP DateHelp
    :
    RTS
    Occupation:
        JSR StartBulkDrawing
        JSR DrawAdornments
        JSR DoneBulkDrawing
        LDX #0 ; newgameSelectOccupationText
        LDA #$20
        STA bufferHelper
        LDA #$c4
        STA bufferHelper+1
        :
        LDA newgamePointer,X
        STA pointer
        INX
        LDA newgamePointer,X
        STA pointer+1
        INX
        JSR BufferDrawText
        CPX #2
        BNE :+
        CLC
        LDA bufferHelper+1
        ADC #2
        STA bufferHelper+1
        :
        LDA #$60
        STA helper
        CPX #6
        BCC :+
        LDA #$40
        STA helper
        :
        CLC
        LDA bufferHelper+1
        ADC helper
        STA bufferHelper+1
        LDA bufferHelper
        ADC #0
        STA bufferHelper
        CPX #10
        BNE :---
        RTS
    OccupationHelp:
        JSR StartBulkDrawing
        JSR DrawAdornments
        JSR DoneBulkDrawing
        LDX #10 ; newgameOccupationHelpText1
        LDA #$20
        STA bufferHelper
        LDA #$c4
        STA bufferHelper+1
        :
        LDA newgamePointer,X
        STA pointer
        INX
        LDA newgamePointer,X
        STA pointer+1
        INX
        JSR BufferDrawText
        CLC
        LDA bufferHelper+1
        ADC #$40
        STA bufferHelper+1
        LDA bufferHelper
        ADC #0
        STA bufferHelper
        CPX #14
        BNE :-
        JSR BufferDrawPressStart
        RTS
    NameParty:
        JSR StartBulkDrawing
        JSR DrawNamePartyImage
        JSR DrawMenuKeyboard
        JSR DoneBulkDrawing
        BufferStart_ #29, #$22, #$02
        LDX #0
        :
        LDA newgameNamePartyWhatText, X
        JSR WriteByteToBuffer
        INX
        CPX #29
        BNE :-
        JSR EndBufferWrite

        BufferStart_ #13, #$22, #$22
        LDX #0
        :
        LDA newgameNamePartyPersonText, X
        JSR WriteByteToBuffer
        INX
        CPX #13
        BNE :-



        
        JSR EndBufferWrite
        
        BufferStart_ #TEXT_NAME_LEN, #$22, #$37
        LDX #8
        LDA #_UL
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
        JSR EndBufferWrite
        RTS
    StartDate:
        JSR StartBulkDrawing
        JSR DrawAdornments
        JSR LoadTextCHR
        JSR DoneBulkDrawing

        LDA newgamePointer+16 ; "It is 1848. Your jumping off place ..."
        STA pointer
        LDA newgamePointer+17
        STA pointer+1
        LDA #$20
        STA bufferHelper
        LDA #$c4
        STA bufferHelper+1
        JSR BufferDrawText
        
        LDA #$21 ; Month selection list
        STA pointer
        LDA #$c6
        STA pointer+1
        LDX #0
        STX counter
        STX counter+1
        :
        TXA
        PHA
        LDX counter
        LDA startingDateText, X
        STA helper
        INC counter
        CLC
        LDA counter+1
        ADC helper
        STA counter+1
        INC counter+1
        BufferStart_ helper, pointer, pointer+1
            LDX counter
            :
            LDA startingDateText, X
            JSR WriteByteToBuffer
            INX
            CPX counter+1
            BNE :-
            STX counter
        JSR EndBufferWrite
        JSR PointerToNextLine
        PLA
        TAX
        INX
        CPX #6 ; number of options
        BNE :--

        ; "What is your choice?"
        BufferStart_ #20, #$22, #$c4
            LDX #0
            :
            LDA whatIsYourChoiceText+10, X
            JSR WriteByteToBuffer
            INX
            CPX #20
            BNE :-
        JSR EndBufferWrite


        RTS
    DateHelp:
        JSR StartBulkDrawing
        JSR DrawAdornments
        JSR DoneBulkDrawing

        LDA newgamePointer+18 ; SelectMonthAdvice1 
        STA pointer
        LDA newgamePointer+19 ; "You attend a public meeting ..."
        STA pointer+1
        LDA #$20
        STA bufferHelper
        LDA #$c4
        STA bufferHelper+1
        JSR BufferDrawText

        LDA newgamePointer+20 ; SelectMonthAdvice2 
        STA pointer
        LDA newgamePointer+21 ; "You attend a public meeting ..."
        STA pointer+1
        LDA #$21
        STA bufferHelper
        LDA #$84
        STA bufferHelper+1
        JSR BufferDrawText
        JSR BufferDrawPressStart
        RTS
.endproc

.proc LoadBgStore
    JSR ClearScreen
    JSR ClearAttributes         ; default palette
    JSR StartBulkDrawing
    LDA location
    CMP #$FF
    BEQ :++
    LDX #$FF                    ; calculate address of store name text
    LDY #$FF
    :
    INX
    LDA landmarkAttr, X
    BPL :-
    INY
    LDA landmarkAttr, X
    CMP location
    BEQ :+
    JMP :-
    :
    StoreName:
        LDA #0
        STA cartDollars
        STA cartDollars+1
        LDY #0
        LDA PPUSTATUS           ; write store name
        LDA #$20
        STA PPUADDR
        LDA #$64
        STA PPUADDR
        :
        LDA storeNameText, X
        STA PPUDATA
        INX
        INY
        CPY #TEXT_STORENAME_LEN
        BNE :-
        LDX #0                  ; write " GENERAL STORE"
        LDA #___
        STA PPUDATA
        :
        LDA generalStoreText, X
        STA PPUDATA
        INX
        CPX #13
        BNE :-
    ColumnHeaders:
        LDY #0
        LDA PPUSTATUS           ; write column headers
        LDA #$20
        STA PPUADDR
        LDA #$C4
        STA PPUADDR
        LDX #0
        :
        LDA storeColumnHeaderText, X
        STA PPUDATA
        INX
        CPX #4
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        :
        LDA storeColumnHeaderText, X
        STA PPUDATA
        INX
        CPX #8
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        STA PPUDATA
        STA PPUDATA
        STA PPUDATA
        :
        LDA storeColumnHeaderText, X
        STA PPUDATA
        INX
        CPX #12
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        :
        LDA storeColumnHeaderText, X
        STA PPUDATA
        INX
        CPX #16
        BNE :-
    Oxen:
        LDA PPUSTATUS           ; write oxen row
        LDA #$21
        STA PPUADDR
        LDA #$04
        STA PPUADDR
        LDA #_UL
        STA PPUDATA
        STA PPUDATA
        LDA cartOxenDigit+2     ; number in Buy column
        CMP #_0_
        BNE :+
        LDA #_UL
        :
        STA PPUDATA
        LDA cartOxenDigit+3
        STA PPUDATA
        LDA #___
        STA PPUDATA
        STA PPUDATA             ; the word "OXEN"
        LDY #0
        LDX #0                  
        :
        LDA suppliesText, X
        STA PPUDATA
        INX
        INY
        CPY #TEXT_SUPPLIES_LEN
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        
        ; LDA location            ; calculate price each
        ; AND #$0F
        LDA #COST_OXEN
        JSR DrawShopEach        ; number in Each column
        LDA #___
        STA PPUDATA
        STA PPUDATA
        LDX #cartOxen
        LDA #COST_OXEN
        JSR DrawShopCost        ; number in Cost column
    Clothes:
        LDA PPUSTATUS           ; write clothes row
        LDA #$21
        STA PPUADDR
        LDA #$44
        STA PPUADDR
        LDA #_UL
        STA PPUDATA
        STA PPUDATA
        LDA cartClothingDigit+2 ; number in Buy column
        CMP #_0_
        BNE :+
        LDA #_UL
        :
        STA PPUDATA
        LDA cartClothingDigit+3
        STA PPUDATA
        LDA #___
        STA PPUDATA
        STA PPUDATA             ; the word "CLOTHES"
        LDY #0
        LDX #7
        :
        LDA suppliesText, X
        STA PPUDATA
        INX
        INY
        CPY #TEXT_SUPPLIES_LEN
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        
        ; LDA location            ; calculate price each
        ; AND #$0F
        LDA #COST_CLOTHES

        JSR DrawShopEach        ; number in Each column
        LDA #___
        STA PPUDATA
        STA PPUDATA
        LDX #cartClothing
        LDA #COST_CLOTHES
        JSR DrawShopCost        ; number in Cost column
    Bullets:
        LDA PPUSTATUS           ; write bullets row
        LDA #$21
        STA PPUADDR
        LDA #$84
        STA PPUADDR
        LDA cartBulletsDigit    ; number in Buy column
        CMP #_0_
        BNE :+
        LDA #_UL
        :
        STA PPUDATA
        LDA cartBulletsDigit+1
        CMP #_0_
        BNE :++
        LDA cartBulletsDigit
        CMP #_0_
        BNE :+
        LDA #_UL
        JMP :++
        :
        LDA #_0_
        :
        STA PPUDATA
        LDA cartBulletsDigit+2
        STA PPUDATA
        LDA cartBulletsDigit+3
        STA PPUDATA
        LDA #___
        STA PPUDATA
        STA PPUDATA             ; the word "bullets"
        LDY #0
        LDX #14
        :
        LDA suppliesText, X
        STA PPUDATA
        INX
        INY
        CPY #TEXT_SUPPLIES_LEN
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        
        ; LDA location            ; calculate price each
        ; AND #$0F
        LDA #COST_BULLETS

        JSR DrawShopEach        ; number in Each column
        LDA #___
        STA PPUDATA
        STA PPUDATA
        LDX #cartBullets
        LDA #COST_BULLETS
        JSR DrawShopCost        ; number in Cost column
    Wheels:
        LDA PPUSTATUS           ; write Wheels row
        LDA #$21
        STA PPUADDR
        LDA #$C4
        STA PPUADDR
        LDA #_UL
        STA PPUDATA
        STA PPUDATA
        STA PPUDATA
        LDA cartSpareParts      ; number in Buy column
        AND #%00000011
        TAY
        LDX #_1_
        DEX
        CPY #0
        BNE :+
        LDA #_0_
        STA PPUDATA
        JMP :++
        :
        INX
        DEY
        CPY #0
        BNE :-
        STX PPUDATA
        :
        LDA #___
        STA PPUDATA
        STA PPUDATA             ; the word "Wheels"
        LDY #0
        LDX #21
        :
        LDA suppliesText, X
        STA PPUDATA
        INX
        INY
        CPY #TEXT_SUPPLIES_LEN
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        
        ; LDA location            ; calculate price each
        ; AND #$0F
        LDA #COST_PARTS

        JSR DrawShopEach        ; number in Each column
        LDA #___
        STA PPUDATA
        STA PPUDATA
        LDA cartSpareParts      ; number in Cost column
        AND #%00000011
        STA helper2
        LDX #helper2
        LDA #COST_PARTS
        JSR DrawShopCost
    Axles:
        LDA PPUSTATUS           ; write Axles row
        LDA #$22
        STA PPUADDR
        LDA #$04
        STA PPUADDR
        LDA #_UL
        STA PPUDATA
        STA PPUDATA
        STA PPUDATA
        LDA cartSpareParts      ; number in Buy column
        LSR
        LSR
        AND #%00000011
        TAY
        LDX #_1_
        DEX
        CPY #0
        BNE :+
        LDA #_0_
        STA PPUDATA
        JMP :++
        :
        INX
        DEY
        CPY #0
        BNE :-
        STX PPUDATA
        :
        LDA #___
        STA PPUDATA
        STA PPUDATA             ; the word "Axles"
        LDY #0
        LDX #28
        :
        LDA suppliesText, X
        STA PPUDATA
        INX
        INY
        CPY #TEXT_SUPPLIES_LEN
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        
        ; LDA location            ; calculate price each
        ; AND #$0F
        LDA #COST_PARTS

        JSR DrawShopEach        ; number in Each column
        LDA #___
        STA PPUDATA
        STA PPUDATA
        LDA cartSpareParts      ; number in Cost column
        LSR
        LSR
        AND #%00000011
        STA helper2
        LDX #helper2
        LDA #COST_PARTS
        JSR DrawShopCost
    Tongues:
        LDA PPUSTATUS           ; write Tongues row
        LDA #$22
        STA PPUADDR
        LDA #$44
        STA PPUADDR
        LDA #_UL
        STA PPUDATA
        STA PPUDATA
        STA PPUDATA
        LDA cartSpareParts      ; number in Buy column
        LSR
        LSR
        LSR
        LSR
        AND #%00000011
        TAY
        LDX #_1_
        DEX
        CPY #0
        BNE :+
        LDA #_0_
        STA PPUDATA
        JMP :++
        :
        INX
        DEY
        CPY #0
        BNE :-
        STX PPUDATA
        :
        LDA #___
        STA PPUDATA
        STA PPUDATA             ; the word "Tongues"
        LDY #0
        LDX #35
        :
        LDA suppliesText, X
        STA PPUDATA
        INX
        INY
        CPY #TEXT_SUPPLIES_LEN
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        
        ; LDA location            ; calculate price each
        ; AND #$0F
        LDA #COST_PARTS

        JSR DrawShopEach        ; number in Each column
        LDA #___
        STA PPUDATA
        STA PPUDATA
        LDA cartSpareParts      ; number in Cost column
        LSR
        LSR
        LSR
        LSR
        AND #%00000011
        STA helper2
        LDX #helper2
        LDA #COST_PARTS
        JSR DrawShopCost
    Food:
        LDA PPUSTATUS           ; write Food row
        LDA #$22
        STA PPUADDR
        LDA #$84
        STA PPUADDR
        LDA cartFoodLbsDigit    ; number in Buy column
        CMP #_0_
        BNE :+
        LDA #_UL
        :
        STA PPUDATA
        LDA cartFoodLbsDigit+1
        CMP #_0_
        BNE :++
        LDA cartFoodLbsDigit
        CMP #_0_
        BNE :+
        LDA #_UL
        JMP :++
        :
        LDA #_0_
        :
        STA PPUDATA
        LDA cartFoodLbsDigit+2
        STA PPUDATA
        LDA cartFoodLbsDigit+3
        STA PPUDATA
        LDA #___
        STA PPUDATA
        STA PPUDATA             ; the word "Food"
        LDY #0
        LDX #42
        :
        LDA suppliesText, X
        STA PPUDATA
        INX
        INY
        CPY #TEXT_SUPPLIES_LEN
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        
        ; LDA location            ; calculate price each
        ; AND #$0F
        LDA #COST_FOOD_LB

        JSR DrawShopEach        ; number in Each column
        LDA #___
        STA PPUDATA
        STA PPUDATA
        LDX #cartFoodLbs
        LDA #COST_FOOD_LB
        JSR DrawShopCost
    Total:
        LDA PPUSTATUS           ; write Total:
        LDA #$22
        STA PPUADDR
        LDA #$EE
        STA PPUADDR
        LDX #0
        :
        LDA storeTotalText, X
        STA PPUDATA
        INX
        CPX #9
        BNE :-
        LDA #___
        STA PPUDATA
        JSR DrawShopTotal
    YouHave:
        LDA PPUSTATUS           ; write You Have: 
        LDA #$23
        STA PPUADDR
        LDA #$6E
        STA PPUADDR
        LDX #9
        :
        LDA storeTotalText, X
        STA PPUDATA
        INX
        CPX #18
        BNE :-
        LDA #___
        STA PPUDATA
        LDA #_DL
        STA PPUDATA
        LDA dollarsDigit
        STA PPUDATA
        LDA dollarsDigit+1
        STA PPUDATA
        LDA dollarsDigit+2
        STA PPUDATA
        LDA dollarsDigit+3
        STA PPUDATA
        LDA #_00
        STA PPUDATA
    Done:
    JSR DoneBulkDrawing
    RTS
.endproc

.proc PressedDoneNextName
    LDA #0
    STA nameCursor
    STA keyboardKey
    LDA #6
    STA fingerX
    LDA #21
    STA fingerY
    INC menuCursor
    LDA menuCursor
    CMP #5 ; Done with all people in party?
    BEQ :+
    JSR BufferDrawNextNamePrompt
    JSR HighlightKeyboardKey
    RTS
    :
    LDA #$22 ; clear screen tiles
    STA pointer
    LDA #$00
    STA pointer+1
    LDX #4*3
    :
    TXA
    PHA
    BufferStart_ #$20, pointer, pointer+1
    LDA #0
    LDX #$20
    :
    JSR WriteByteToBuffer
    DEX
    BNE :-
    JSR EndBufferWrite
    JSR PointerToNextLine
    PLA
    TAX
    DEX
    BNE :--

    BufferStart_ #3*8, #$23, #$e0
    LDA #$ff ; clear attr
    LDX #3*8
    :
    JSR WriteByteToBuffer
    DEX
    BNE :-
    JSR EndBufferWrite

    LDA #$22 ; draw party member names
    STA pointer
    LDA #$44
    STA pointer+1
    LDA #TEXT_NAME_LEN
    STA helper+1
    LDX #0
    STX helper
    :
    TXA
    PHA
    BufferStart_ #TEXT_NAME_LEN+3, pointer, pointer+1
        PLA
        TAX
        CLC
        ADC #_1_
        JSR WriteByteToBuffer
        TXA
        PHA
        LDA #_PD
        JSR WriteByteToBuffer
        LDA #___
        JSR WriteByteToBuffer
        LDX helper
        :
        LDA personName, X
        JSR WriteByteToBuffer
        INX
        INC helper
        CPX helper+1
        BNE :-
    JSR EndBufferWrite
    CLC
    LDA helper+1
    ADC #TEXT_NAME_LEN
    STA helper+1
    JSR PointerToNextLine
    PLA
    TAX
    INX
    CPX #5
    BNE :--

    BufferStart_ #24, #$23, #$22
    LDX #0
    : ; "Are these names correct?"
    LDA newgameNamePartyCorrectText, X
    JSR WriteByteToBuffer
    INX
    CPX #24
    BNE :-
    JSR EndBufferWrite

    LDA #0
    STA fingerLastLastY
    STA fingerLastY
    LDX #28 ; y/n
    STX fingerX
    LDY #25
    STY fingerY
    LDA #_Y_
    JSR WriteTileToBuffer
    LDA #%00011111
    STA fingerAttr
    JSR DrawFinger
    LDA #MENU_NEWGAME_NAMESCORRECT
    STA menuOpen
    LDA #1
    STA menuCursor

    RTS
.endproc

.proc GamepadNewGame
    LDA buttons1
    CMP buttons1Last
    BNE :+
    RTS
    :
    LDA buttons1Last 
    BEQ CheckA
    RTS
    CheckA:
        LDA #KEY_A
        BIT buttons1
        BNE :+
        JMP CheckB
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_NAMEPARTY
        BNE :+
        JMP @menuNameParty
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_NAMESCORRECT
        BNE :+
        JMP @menuNamesCorrect
        :
        RTS
        @menuNameParty:
            LDA keyboardKey ; Done?
            CMP #KEYBOARD_DONE
            BNE :+
            JSR PressedDoneNextName
            RTS
            :
            JSR NameKeyHelper
            LDA nameCursor
            CMP #TEXT_NAME_LEN
            BNE :+
            DEC nameCursor
            DEY
            :
            LDX keyboardKey
            LDA keyboard, X
            STA personName, Y
            STA helper+1
            INC nameCursor
            LDA nameCursor
            CMP #TEXT_NAME_LEN
            BNE :+
            LDA #KEYBOARD_DONE ; jump to "DONE" key
            STA keyboardKey
            LDA #22
            STA fingerX
            LDA #25
            STA fingerY
            JSR NameKeyHelper
            DEY
            LDA personName, Y
            STA helper+1
            :
            CLC ; tilex from left
            LDA nameCursor
            ADC #22
            TAX
            LDA helper+1 ; tile index to draw
            LDY #17 ; tiles from top
            JSR WriteTileToBuffer
            JSR HighlightKeyboardKey
            RTS
        @menuNamesCorrect:
            LDA menuCursor
            BEQ :+
            JSR IncrementDate
            JSR SetOpeningBalance
            LDA #MENU_NEWGAME_GOINGBACK
            STA menuOpen
            RTS
            :
            ; "N"
            RTS
    CheckB:
        LDA #KEY_B
        BIT buttons1
        BNE :+
        JMP CheckStart
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_NAMEPARTY
        BNE :+
        JMP @menuNameParty
        :
        RTS
        @menuNameParty:
            DEC nameCursor
            JSR NameKeyHelper
            LDA nameCursor
            CMP #TEXT_NAME_LEN-1
            BEQ :+
            INY
            LDA #___
            STA personName, Y
            DEY
            :
            LDA nameCursor
            BMI :+
            LDA #___
            STA personName, Y
            :
            CLC ; tilex from left
            LDA nameCursor
            ADC #23
            CMP #22
            BEQ :+
            TAX
            LDA #_UL ; tile index to draw
            LDY #17 ; tiles from top
            JSR WriteTileToBuffer
            :
            BIT nameCursor
            BPL :+
            INC nameCursor
            :
            RTS
    CheckStart:
        LDA #KEY_START
        BIT buttons1
        BNE :+
        JMP CheckSelect
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_OCCUPATION
        BNE :+
        JMP @menuOccupation
        :
        CMP #MENU_NEWGAME_OCC_HELP
        BNE :+
        LDA #MENU_NEWGAME_OCCUPATION
        STA menuOpen
        RTS
        :
        CMP #MENU_NEWGAME_NAMEPARTY
        BNE :++
        LDA keyboardKey
        CMP #KEYBOARD_DONE
        BNE :+
        JSR PressedDoneNextName
        RTS
        :
        LDA #KEYBOARD_DONE ; jump to "Done"
        STA keyboardKey
        LDA #22
        STA fingerX
        LDA #25
        STA fingerY
        JSR HighlightKeyboardKey
        RTS
        :
        CMP #MENU_NEWGAME_NAMESCORRECT
        BNE :++
        LDA menuCursor
        BEQ :+
        JSR IncrementDate
        JSR SetOpeningBalance
        LDA #MENU_NEWGAME_GOINGBACK
        STA menuOpen
        RTS
        :
        ; TODO "N" selected 
        RTS
        :
        CMP #MENU_NEWGAME_STARTDATE
        BNE :++
        LDA fingerY
        SEC
        SBC #14
        CMP #5
        BEQ :+
        CLC
        ADC #3
        STA dateMonth
        LDA #MENU_NEWGAME_BEFORELEAVING1
        STA menuOpen
        RTS
        :
        LDA #MENU_NEWGAME_DATE_HELP
        STA menuOpen
        RTS
        :
        CMP #MENU_NEWGAME_DATE_HELP
        BNE :+
        LDA #MENU_NEWGAME_STARTDATE
        STA menuOpen
        RTS
        :
        CMP #MENU_NEWGAME_BEFORELEAVING1
        BNE :+
        LDA #MENU_NEWGAME_BEFORELEAVING2
        STA menuOpen
        RTS
        :
        CMP #MENU_NEWGAME_BEFORELEAVING2
        BNE :+
        LDA #MENU_NEWGAME_MATT
        STA menuOpen
        LDA #0
        STA menuCursor
        RTS
        :
        CMP #MENU_NEWGAME_MATT
        BNE :+
        INC menuCursor
        JSR LoadBgMatt
        :
        RTS
        @menuOccupation:
            LDA #MENU_NEWGAME_NAMEPARTY
            STA menuOpen
            LDA fingerY
            CMP #10 ; "Be a banker from Boston"
            BNE :+
            LDA occupationAttribute
            STA occupation
            RTS
            :
            CMP #13 ; "Be a carpenter from Ohio"
            BNE :+
            LDA occupationAttribute+1
            STA occupation
            RTS
            :
            CMP #16 ; "Be a farmer from Illinois"
            BNE :+
            LDA occupationAttribute+2
            STA occupation
            RTS
            :
            CMP #19 ; "Find out the differences between these choices"
            BNE :+
            LDA #MENU_NEWGAME_OCC_HELP
            STA menuOpen
            RTS
            :
            RTS
    CheckSelect:
        LDA #KEY_SELECT
        BIT buttons1
        BNE :+
        JMP CheckDown
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_OCCUPATION
        BNE :+
        JMP @menuOccupation
        :
        RTS
        @menuOccupation:
            LDX fingerY
            INX
            INX
            INX
            CPX #22 ; check if fingerY is past bottom of menu
            BNE :+
            LDX #10 ; wrap to top of menu
            :
            STX fingerY
            RTS
    CheckDown:
        LDA #KEY_DOWN
        BIT buttons1
        BNE :+ ; hack
        JMP CheckUp
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_OCCUPATION
        BNE :+
        JMP @menuOccupation
        :
        CMP #MENU_NEWGAME_NAMEPARTY
        BNE :+
        JMP @menuNameParty
        :
        CMP #MENU_NEWGAME_STARTDATE
        BNE :+
        JMP @menuStartDate
        :
        RTS
        @menuOccupation:
            LDX fingerY
            INX
            INX
            INX
            CPX #22 ; check if fingerY is past bottom of menu
            BNE :+
            LDX #10 ; wrap to top of menu
            :
            STX fingerY
            RTS
        @menuNameParty:
            LDX fingerY
            INX
            INX
            LDA keyboardKey
            CLC
            ADC #TEXT_KEYBOARD_LEN
            STA helper
            CPX #27 ; check if fingerY is past bottom of screen
            BEQ @wrapFingerD
            LDA fingerX
            CMP #22 ; check if fingerX is in "DONE" columns
            BCC @moveFingerD
            CPX #25 ; check if fingerY is in 2nd row
            BNE @moveFingerD
            LDA #22
            STA fingerX
            LDA #KEYBOARD_DONE
            STA helper
            JMP @moveFingerD
            @wrapFingerD:
            LDX #21 ; wrap to top row
            LDA keyboardKey
            SEC
            SBC #TEXT_KEYBOARD_LEN*2
            STA helper
            @moveFingerD:
            STX fingerY
            LDA helper
            STA keyboardKey
            JSR HighlightKeyboardKey
            RTS
        @menuStartDate:
            LDX fingerY
            INX
            CPX #20
            BNE :+
            LDX #14 ; wrap to top
            :
            STX fingerY
            RTS
    CheckUp:
        LDA #KEY_UP
        BIT buttons1
        BNE :+
        JMP CheckLeft
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_OCCUPATION
        BNE :+
        JMP @menuOccupation
        :
        CMP #MENU_NEWGAME_NAMEPARTY
        BNE :+
        JMP @menuNameParty
        :
        CMP #MENU_NEWGAME_STARTDATE
        BNE :+
        JMP @menuStartDate
        :
        RTS
        @menuOccupation:
            LDX fingerY
            DEX
            DEX
            DEX
            CPX #7 ; check if fingerY is past top of menu
            BNE :+
            LDX #19 ; wrap to bottom of menu
            :
            STX fingerY
            RTS
        @menuNameParty:
            LDX fingerY
            DEX
            DEX
            LDA keyboardKey
            SEC
            SBC #TEXT_KEYBOARD_LEN
            STA helper
            CPX #19 ; check if fingerY is past top of keyboard
            BNE @moveFingerU
            LDA fingerX
            CMP #22 ; check if we are in last 2 columns
            BCC @wrapFingerU
            LDA #22
            STA fingerX ; wrap to the "DONE" key
            LDA #KEYBOARD_DONE
            STA helper
            LDX #25 ; wrap to bottom of keyboard
            JMP @moveFingerU
            @wrapFingerU:
            LDX #25 ; wrap to bottom of keyboard
            LDA keyboardKey
            CLC
            ADC #TEXT_KEYBOARD_LEN*2
            STA helper
            @moveFingerU:
            STX fingerY
            LDA helper
            STA keyboardKey
            JSR HighlightKeyboardKey
            RTS
        @menuStartDate:
            LDX fingerY
            DEX
            CPX #13
            BNE :+
            LDX #19 ; wrap to bottom
            :
            STX fingerY
            RTS
    CheckLeft:
        LDA #KEY_LEFT
        BIT buttons1
        BNE :+
        JMP CheckRight
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_NAMEPARTY
        BNE :+
        JMP @menuNameParty
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_NAMESCORRECT
        BNE :+
        JMP @menuNamesCorrect
        :
        RTS
        @menuNameParty:
            LDX fingerX
            DEX
            DEX
            DEC keyboardKey
            LDA keyboardKey
            STA helper
            CPX #4  ; check if we need to wrap around
            BNE :+
            LDX #24 ; wrap around
            LDA keyboardKey
            CLC
            ADC #TEXT_KEYBOARD_LEN
            STA helper
            LDA fingerY
            CMP #25 ; check if we need to wrap to the "DONE" keyboard button
            BNE :+
            LDX #22 ; wrap around to "DONE" keyboard button
            LDA #TEXT_KEYBOARD_LEN*3-2
            STA helper
            :
            STX fingerX
            LDA helper
            STA keyboardKey
            JSR HighlightKeyboardKey
            RTS
        @menuNamesCorrect:
            JSR ToggleYN
            RTS
    CheckRight:
        LDA #KEY_RIGHT
        BIT buttons1
        BNE :+
        RTS
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_NAMEPARTY
        BNE :+
        JMP @menuNameParty
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_NAMESCORRECT
        BNE :+
        JMP @menuNamesCorrect
        :
        RTS
        @menuNameParty:
            LDX fingerX
            INX
            INX
            INC keyboardKey
            LDA keyboardKey
            STA helper
            LDA fingerY
            CMP #25 ; check if we are on bottom row
            BNE @wrapFingerNormallyR
            CPX #24 ; check if we need to wrap around the "DONE" key
            BEQ @wrapFingerR
            @wrapFingerNormallyR:
            CPX #26 ; check if we need to wrap around normally
            BNE @moveFingerR
            DEC helper
            @wrapFingerR:
            LDX #6  ; wrap around
            LDA helper
            SEC
            SBC #TEXT_KEYBOARD_LEN-1
            STA helper
            @moveFingerR:
            STX fingerX
            LDA helper
            STA keyboardKey
            JSR HighlightKeyboardKey
            RTS
        @menuNamesCorrect:
            JSR ToggleYN
            RTS
.endproc

.proc NameKeyHelper
    PHA
    LDA menuCursor
    ASL
    ASL
    ASL
    CLC
    ADC nameCursor
    TAY
    PLA
    RTS
.endproc

.proc BufferDrawNextNamePrompt
    BufferStart_ #$20, #$22, #$22
        LDX #$20
        LDA #0
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite
    BufferStart_ #3, #$22, #$22
        LDX #0
        LDY menuCursor
        DEY
        :
        CPY #0
        BEQ :+
        INX
        INX
        INX
        DEY
        JMP :-
        :
        TYA
        PHA
        LDA newgameNewPartyNthText, X
        JSR WriteByteToBuffer
        PLA
        TAY
        INX
        INY
        CPY #3
        BNE :-
    JSR EndBufferWrite
    BufferStart_ #13, #$22, #$22+4
        LDX #13
        :
        LDA newgameNamePartyPersonText, X
        JSR WriteByteToBuffer
        INX
        CPX #26
        BNE :-
    JSR EndBufferWrite
    BufferStart_ #TEXT_NAME_LEN, #$22, #$37
        LDX #TEXT_NAME_LEN
        LDA #_UL
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite


    RTS
.endproc

.proc BufferDrawIntroTextBox
    BufferStart_ #8, #$23, #$f0
        LDA #$ff
        LDX #8
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite

    LDA menuOpen
    CMP #MENU_NEWGAME_GOINGBACK
    BEQ :+
    JMP BeforeLeaving1
    :
    LDX #$22 ; text box
    LDY #$02
    LDA #2
    JSR DrawTextBox
    LDA newgamePointer+14 ; newgameGoingBackText 
    STA pointer
    LDA newgamePointer+15 ; "Going back to 1848..."
    STA pointer+1
    LDA #$22
    STA bufferHelper
    LDA #$25
    STA bufferHelper+1
    JSR BufferDrawText
    BufferStart_ #3, #$22, #$37
        LDA #_PD
        LDX #3
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite
    BufferStart_ #8, #$23, #$e0 ; attributes
        LDA #%11001110
        JSR WriteByteToBuffer
        LDA #$ff
        LDX #6
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
        LDA #%00110011
        JSR WriteByteToBuffer
    JSR EndBufferWrite
    RTS
    BeforeLeaving1:
    CMP #MENU_NEWGAME_BEFORELEAVING1
    BEQ :+
    JMP BeforeLeaving2
    :
    BufferStart_ #24, #$23, #$d8 ; attributes
        LDX #3
        :
        TXA
        PHA
        LDA #%11001110
        JSR WriteByteToBuffer
        LDA #$ff
        LDX #6
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
        LDA #%00110011
        JSR WriteByteToBuffer
        PLA
        TAX
        DEX
        BNE :--
    JSR EndBufferWrite
    LDX #$21 ; text box
    LDY #$82
    LDA #9
    JSR DrawTextBox
    LDA newgamePointer+22 ; newgameBeforeLeavingText1
    STA pointer
    LDA newgamePointer+23 ; "Before leaving Independence..."
    STA pointer+1
    LDA #$21
    STA bufferHelper
    LDA #$c4
    STA bufferHelper+1
    JSR BufferDrawText
    BufferStart_ #5, #$22, #$37
        LDA #_DL
        JSR WriteByteToBuffer
        LDX #0
        STX helper
        :
        LDA dollarsDigit, X
        CPX #0
        BNE :+
        CMP #_0_
        BNE :+
        INX
        JMP :-
        :
        JSR WriteByteToBuffer
        INX
        INC helper
        CPX #4
        BNE :--
        LDA helper
        CMP #3
        BNE :+
        LDA #_00
        JSR WriteByteToBuffer
        :
    JSR EndBufferWrite
    JSR BufferDrawPressStart
    RTS
    BeforeLeaving2:
    CMP #MENU_NEWGAME_BEFORELEAVING2
    BEQ :+
    RTS
    :
    BufferStart_ #16, #$23, #$e0 ; attributes
        LDA #%11001110
        JSR WriteByteToBuffer
        LDX #6
        LDA #$ff
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
        LDA #%00110011
        JSR WriteByteToBuffer
        LDX #8
        LDA #$ff
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite
    LDX #$22 ; text box
    LDY #$02
    LDA #5
    JSR DrawTextBox
    LDA newgamePointer+24 ; newgameBeforeLeavingText2
    STA pointer
    LDA newgamePointer+25 ; "You can buy whatever you need..."
    STA pointer+1
    LDA #$22
    STA bufferHelper
    LDA #$44
    STA bufferHelper+1
    JSR BufferDrawText
    JSR BufferDrawPressStart
    RTS
.endproc
