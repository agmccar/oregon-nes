
.proc RandomEvent
    ; Each day, the random event engine goes through each of the random events
    ; to determine if that event will occur on that day, based on the current
    ; probability. However, if one of the events does indeed occur, then the
    ; random event engine halts. As a result, no more than one random event 
    ; occurs in a single day.
    JSR RandomNumberGenerator
    STA helper
    
    RTS
.endproc

.proc REIndianFood
    ; Indians help find food
    ; If you are completely out of food, then there is a 5% chance each day
    ; that local Indians will give you 30 pounds of food.
    RTS
.endproc

    ; Severe thunderstorm
    ; The probability is based on the average precipitation for your current
    ; location and current month.

    ; Severe blizzard
    ; 15% chance each day in which the temperature is either cold or very cold.

    ; Heavy fog
    ; After Fort Hall, a 6% chance each day, except when the temperature is
    ; very hot. 50% chance of losing a day's travel.

    ; Hail storm
    ; Before Fort Hall, 6% chance each day in which the temperature is very hot.

    ; Injured or dead ox
    ; 2% each day on the prairie; 3.5% chance each day in the mountains. If all
    ; oxen are healthy, then one becomes injured; otherwise, the sick ox dies.

    ; Injured party member (broken arm or leg)
    ; 2% chance each day on the prairie; 3.5% chance each day in the mountains.
    ; The person who gets injured is chosen randomly.

    ; Snake bite
    ; 0.7% chance each day.

    ; Lose trail
    ; 2% chance each day.

    ; Wrong trail
    ; 1% chance each day.

    ; Rough trail
    ; In mountains only; 2.5% chance each day.

    ; Impassible trail
    ; In mountains only; 2.5% chance each day.

    ; Finding wild fruit
    ; May to September only; 4% chance each day. The food supply is increased
    ; by 20 pounds.

    ; Fire in the wagon
    ; 2% chance each day. Some supplies are lost.

    ; Lost party member
    ; 1% chance each day; lose up to 5 days.

    ; Ox wanders off
    ; 1% chance each day; lose up to 3 days.

    ; Finding an abandoned wagon
    ; 2% chance each day. Some supplies are gained.

    ; Thief comes during the night
    ; 2% chance each day. Some supplies are lost.

    ; Bad water
    ; 10% chance each day in which the accumulated rainfall is below 0.1 inch.

    ; Very little water
    ; 20% chance each day in which the accumulated rainfall is below 0.1 inch.

    ; Inadequate grass
    ; 20% chance each day in which the accumulated rainfall is below 0.1 inch.

    ; Illness
    ; 0% to 40% chance each day, depending upon the health of the party. The
    ; person and the disease are chosen randomly. 