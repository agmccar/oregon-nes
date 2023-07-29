
.proc RandomEvent
    ; Each day, the random event engine goes through each of the random events
    ; to determine if that event will occur on that day, based on the current
    ; probability. However, if one of the events does indeed occur, then the
    ; random event engine halts. As a result, no more than one random event 
    ; occurs in a single day.
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
    ; If you are completely out of food, then there is a 5% chance each day
    ; that local Indians will give you 30 pounds of food.
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
    ; The probability is based on the average precipitation for your current
    ; location and current month.
    JSR RollRNG
    CMP #0 ; TODO
    BCC :+
    JMP Done
    :

    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REBlizzard
    ; Severe blizzard
    ; 15% chance each day in which the temperature is either cold or very cold.
    JSR RollRNG
    CMP #15*2
    BCC :+
    JMP Done
    :

    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REHeavyFog
    ; Heavy fog
    ; After Fort Hall, a 6% chance each day, except when the temperature is
    ; very hot. 50% chance of losing a day's travel.
    JSR RollRNG
    CMP #6*2
    BCC :+
    JMP Done
    :

    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REHailStorm
    ; Hail storm
    ; Before Fort Hall, 6% chance each day in which the temperature is very hot.
    JSR RollRNG
    CMP #6*2
    BCC :+
    JMP Done
    :

    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REInjuredOx
    ; Injured or dead ox
    ; 2% each day on the prairie; 3.5% chance each day in the mountains. If all
    ; oxen are healthy, then one becomes injured; otherwise, the sick ox dies.
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

.proc REInjuredPerson
    ; Injured party member (broken arm or leg)
    ; 2% chance each day on the prairie; 3.5% chance each day in the mountains.
    ; The person who gets injured is chosen randomly.
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

.proc RESnakeBite
    ; Snake bite
    ; 0.7% chance each day in the original game.
    ; 0.5% chance is close enough
    JSR RollRNG
    CMP #1
    BCC :+
    JMP Done
    :

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
    JSR RollRNG
    CMP #10*2
    BCC :+
    JMP Done
    :

    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc RELittleWater
    ; Very little water
    ; 20% chance each day in which the accumulated rainfall is below 0.1 inch.
    JSR RollRNG
    CMP #20*2
    BCC :+
    JMP Done
    :

    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REInadequateGrass
    ; Inadequate grass
    ; 20% chance each day in which the accumulated rainfall is below 0.1 inch.
    JSR RollRNG
    CMP #20*2
    BCC :+
    JMP Done
    :

    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REIllness
    ; Illness
    ; 0% to 40% chance each day, depending upon the health of the party. The
    ; person and the disease are chosen randomly.
    JSR RollRNG
    CMP #0 ; TODO
    BCC :+
    JMP Done
    :

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
