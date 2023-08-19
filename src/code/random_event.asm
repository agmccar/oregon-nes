
.proc RandomEvent
    ; Each day, the random event engine goes through each of the random events
    ; to determine if that event will occur on that day, based on the current
    ; probability. However, if one of the events does indeed occur, then the
    ; random event engine halts. As a result, no more than one random event 
    ; occurs in a single day.
    LDA wagonRest ; no random event if resting? TODO confirm
    BEQ :+
    JMP Done
    :
    LDA #0
    STA helper ; flag to halt the random event engine: 1 is done

    JSR REIndianFood
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REThunderstorm
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REBlizzard
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REHeavyFog
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REHailStorm
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REInjuredOx
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REInjuredPerson
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR RESnakeBite
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR RELoseTrail
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REWrongTrail
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR RERoughTrail
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REImpassibleTrail
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REWildFruit
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REFireWagon
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR RELostPerson
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REOxWandersOff
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REAbandonedWagon
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REThief
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REBadWater
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR RELittleWater
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REInadequateGrass
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REIllness
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REBrokenPart
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    Done:
    RTS
.endproc

.proc RollRNG
    ; @return A - RNG roll result, 0-200
    :
    JSR RandomNumberGenerator
    CMP #200 ; discard rolls >= 200. Roll is then 0%-100% with 0.5% increments  
    BCS :-
    RTS
.endproc

.proc REIndianFood
    ; Indians help find food
    ; "If you are completely out of food, then there is a 5% chance each day
    ; that local Indians will give you 30 pounds of food."
    LDA foodLbs+1
    CMP #0
    BNE Done
    LDA foodLbs
    CMP #0
    BEQ :+
    JMP Done
    :
    JSR RollRNG
    CMP #5*2
    BCC :+
    JMP Done
    :
    CLC
    LDA foodLbs
    ADC #30
    STA foodLbs
    LDA foodLbs+1
    ADC #0
    STA foodLbs+1
    LDX #foodLbsDigit
    LDY #foodLbs
    JSR SetDigitFromValue
    LDA #EVENT_INDIAN_FOOD
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REThunderstorm
    ; Severe thunderstorm
    ; "The probability is based on the average precipitation for your current
    ; location and current month."
    ; lets say 10% if it's currently rainy, 25% if it's currently very rainy
    LDA weather
    CMP #WEATHER_RAINY
    BNE :+
    JSR RollRNG
    CMP #10*2
    BCC AlmostDone
    JMP Done
    :
    CMP #WEATHER_VERY_RAINY
    BNE Done
    JSR RollRNG
    CMP #25*2
    BCC AlmostDone
    JMP Done
    AlmostDone:
    INC wagonRest ; lose 1 day
    LDA #EVENT_THUNDERSTORM
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REBlizzard
    ; Severe blizzard
    ; "15% chance each day in which the temperature is either cold or very cold."
    LDA weather
    CMP #WEATHER_COLD
    BEQ :+
    CMP #WEATHER_VERY_COLD
    BEQ :+
    JMP Done
    :
    JSR RollRNG
    CMP #15*2
    BCC :+
    JMP Done
    :
    INC wagonRest ; lose 1 day
    LDA #EVENT_BLIZZARD
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REHeavyFog
    ; Heavy fog
    ; "After Fort Hall, a 6% chance each day, except when the temperature is
    ; very hot. 50% chance of losing a day's travel."
    LDA location
    CMP #LOC_FORTHALL
    BCC Done
    LDA weather
    CMP #WEATHER_VERY_HOT
    BEQ Done
    JSR RollRNG
    CMP #6*2
    BCS Done
    JSR RandomNumberGenerator
    AND #1
    BNE :+
    INC wagonRest ; 50% chance to lose 1 day
    :
    LDA #EVENT_HEAVY_FOG
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REHailStorm
    ; Hail storm
    ; "Before Fort Hall, 6% chance each day in which the temperature is very hot.""
    ; +50% chance of losing a day's travel
    LDA location
    CMP #LOC_FORTHALL
    BCS Done
    LDA weather
    CMP #WEATHER_VERY_HOT
    BNE Done
    JSR RollRNG
    CMP #6*2
    BCS Done
    JSR RandomNumberGenerator
    AND #1
    BNE :+
    INC wagonRest ; 50% chance to lose 1 day
    :
    LDA #EVENT_HAIL_STORM
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REInjuredOx
    ; Injured or dead ox
    ; 2% each day on the prairie; 3.5% chance each day in the mountains. If all
    ; oxen are healthy, then one becomes injured; otherwise, the sick ox dies.
    CLC
    LDA oxenHeadcount
    ADC oxenHealth
    BEQ Done
    LDA #4
    STA helper+1
    JSR CheckMountainousTerrain
    BEQ :+
    LDA #7
    STA helper+1
    :
    JSR RollRNG
    CMP helper+1
    BCC :+
    JMP Done
    :
    LDA oxenHealth
    BEQ :+
    DEC oxenHeadcount ; sick ox dies
    DEC oxenHealth
    JMP :++
    :
    INC oxenHealth ; ox becomes injured
    :
    LDA #EVENT_INJURED_OX
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REInjuredPerson
    ; Injured party member (broken arm or leg)
    ; 2% chance each day on the prairie; 3.5% chance each day in the mountains.
    ; The person who gets injured is chosen randomly.
    JSR CheckMountainousTerrain
    BEQ :+
    JSR RollRNG ; mountains
    CMP #7
    BCC AlmostDone
    JMP Done
    :
    JSR RollRNG ; prairie
    CMP #2*2
    BCC AlmostDone
    JMP Done
    AlmostDone:
    ; CLC
    ; LDA wagonHealth
    ; ADC #20
    ; STA wagonHealth ; no mention of wagon health from Bouchard
    LDA #EVENT_INJURED_PERSON
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc RESnakeBite
    ; Snake bite
    ; 0.7% chance each day in the original game.
    ; 0.75% chance is close enough
    ; Assume same behavior as broken limb. No word from Bouchard on this.
    JSR RandomNumberGenerator
    AND #1 ; 50%
    BCS Done
    JSR RollRNG
    CMP #3 ; 50% of 1.5% = 0.75%
    BCS Done
    LDA #EVENT_SNAKE_BITE
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc RELoseTrail
    ; Lose trail
    ; 2% chance each day.
    JSR RollRNG
    CMP #2*2
    BCC :+
    JMP Done
    :

    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REWrongTrail
    ; Wrong trail
    ; 1% chance each day.
    JSR RollRNG
    CMP #1*2
    BCC :+
    JMP Done
    :

    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc RERoughTrail
    ; Rough trail
    ; In mountains only; 2.5% chance each day.
    JSR CheckMountainousTerrain
    CMP #0
    BEQ Done
    JSR RollRNG
    CMP #5
    BCC :+
    JMP Done
    :
    CLC
    LDA wagonHealth
    ADC #10
    STA wagonHealth
    LDA #EVENT_ROUGH_TRAIL
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REImpassibleTrail
    ; Impassible trail
    ; In mountains only; 2.5% chance each day.
    JSR RollRNG
    CMP #5
    BCC :+
    JMP Done
    :

    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REWildFruit
    ; Finding wild fruit
    ; May to September only; 4% chance each day. The food supply is increased
    ; by 20 pounds.
    JSR RollRNG
    CMP #4*2
    BCC :+
    JMP Done
    :

    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REFireWagon
    ; Fire in the wagon
    ; 2% chance each day. Some supplies are lost.
    JSR RollRNG
    CMP #2*2
    BCC :+
    JMP Done
    :

    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc RELostPerson
    ; Lost party member
    ; 1% chance each day; lose up to 5 days.
    JSR RollRNG
    CMP #1*2
    BCC :+
    JMP Done
    :

    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REOxWandersOff
    ; Ox wanders off
    ; 1% chance each day; lose up to 3 days.
    JSR RollRNG
    CMP #1*2
    BCC :+
    JMP Done
    :

    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REAbandonedWagon
    ; Finding an abandoned wagon
    ; 2% chance each day. Some supplies are gained.
    JSR RollRNG
    CMP #2*2
    BCC :+
    JMP Done
    :

    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REThief
    ; Thief comes during the night
    ; 2% chance each day. Some supplies are lost.
    JSR RollRNG
    CMP #2*2
    BCC :+
    JMP Done
    :

    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REBadWater
    ; Bad water
    ; 10% chance each day in which the accumulated rainfall is below 0.1 inch.
    LDA accumulatedRain
    CMP #1
    BCS Done
    JSR RollRNG
    CMP #10*2
    BCS Done
    LDA wagonHealth
    ADC #20
    STA wagonHealth
    LDA #EVENT_BAD_WATER
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc RELittleWater
    ; Very little water
    ; 20% chance each day in which the accumulated rainfall is below 0.1 inch.
    LDA accumulatedRain
    CMP #1
    BCS Done
    JSR RollRNG
    CMP #20*2
    BCS Done
    CLC
    LDA wagonHealth
    ADC #10
    STA wagonHealth
    LDA #EVENT_LITTLE_WATER
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REInadequateGrass
    ; Inadequate grass
    ; 20% chance each day in which the accumulated rainfall is below 0.1 inch.
    LDA accumulatedRain
    CMP #1
    BCS Done
    JSR RollRNG
    CMP #20*2
    BCS Done
    ; Inadequate Grass event effect does nothing?
    LDA #EVENT_INADEQUATE_GRASS
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REIllness
    ; Illness
    ; 0% to 40% chance each day, depending upon the health of the party. The
    ;   person and the disease are chosen randomly.
    ; Add 20 to wagonHealth when the disease first strikes.
    ; Trick: When an ill person gets another illness they 
    ;   simply die of their existing illness.

    ; Calculate illness chance: ((health * 128) / 175) out of 256 
    LDA wagonHealth
    STA helper2
    LDA #0
    STA helper2+1
    CLC
    LDX #7
    : ; ((health * 128)
    ROL helper2
    ROL helper2+1
    DEX
    BNE :-
    LDA #0
    STA cartHelperDigit
    SEC
    : ; / 175)
    LDA helper2
    SBC #175
    STA helper2
    LDA helper2+1
    SBC #0
    STA helper2+1
    INC cartHelperDigit
    BCS :-
    JSR RollRNG ; out of 256 
    CMP cartHelperDigit
    BCC :+
    JMP Done
    :
    CLC
    LDA wagonHealth
    ADC #20
    STA wagonHealth
    LDA #EVENT_ILLNESS
    JSR QueueEvent
    LDA #1
    STA helper
    Done: 
    RTS
.endproc

.proc REBrokenPart
    ; Broken wagon part
    ; ?% per day (not in Bouchard's book)
    ; lets go with 2% per day, same as wagon fire
    JSR RollRNG
    CMP #2*2
    BCC :+
    JMP Done
    :

    LDA #1
    STA helper
    Done:
    RTS
.endproc
