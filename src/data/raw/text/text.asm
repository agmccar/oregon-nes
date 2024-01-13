
; Default names and scores (high byte first) on the Oregon Top Ten
; size must match allocated vars.asm->oregonTopTen
topTenDefault:
    .byte "S.Meek  ",$1d,$e2
    .byte "Hastings",$16,$3e
    .byte "Sublette",$10,$2a
    .byte "C.Hines ",$0b,$81
    .byte "E.Meeker",$08,$04
    .byte "W.Vaughn",$05,$79
    .byte "Bartlett",$03,$a9
    .byte "Wiggins ",$02,$67
    .byte "C.Hopper",$01,$8c
    .byte "E.White ",$00,$fa

titleOptionsText:
    .byte 16,"Travel the trail"
    .byte 21,"Learn about the trail"
    .byte 22,"See the Oregon Top Ten"
    .byte 11,"Turn sound ", "off", "on"

titleColorsText:
    .byte "Orange Green", " Blue Violet"

whatIsYourChoiceText:
    .byte 8,"You may:"
    .byte 20,"What is your choice?"

pressStartText:
    .byte "    Press START to continue     "
sizeUpSituationText:
    .byte "Press A to size up the situation"

nextLandmarkText: ; len:18
    .byte "It is 000 miles to"

reachedLandmarkText: ; len 17
    .byte "You have reached "

mapTitleText:
    .byte "Map of the", "Oregon Trail"

monthText:
    .byte "Jan", "Feb", "Mar", "Apr"
    .byte "May", "Jun", "Jul", "Aug"
    .byte "Sep", "Oct", "Nov", "Dec"

hudText:
    .byte "Date", "Weather", "Health", "Food"
    .byte "Next landmark", "Miles traveled"

hudMenuStatusText:
    .byte "Weather:", "Health:", "Pace:", "Rations:"
    .byte "Your Supplies", "pounds", "miles"

startingDateText:
    .byte 5,"March"
    .byte 5,"April"
    .byte 3,"May"
    .byte 4,"June"
    .byte 4,"July"
    .byte 14,"Ask for advice"

keyboard:
    .byte "QWERTYUIOP"
    .byte "ASDFGHJKL."
    .byte "ZXCVBNM_  "

keyboardDone:
    .byte "Done"

decimalDigits:
    .byte "0123456789"

weatherText:
    .byte "very cold " ; < 10 °F
    .byte "cold      " ; 10 - 30 °F 
    .byte "cool      " ; 30 - 50 °F
    .byte "warm      " ; 50 - 70 °F
    .byte "hot       " ; 70 - 90 °F
    .byte "very hot  " ; > 90 °F
    .byte "rainy     " ; 0.2", 70% chance
    .byte "very rainy" ; 0.8", 30% chance
    .byte "snowy     " ; 2", 70% chance
    .byte "very snowy" ; 8", 30% chance

restText: ; TODO
    .byte _R_,_E_,_S_,_T_,___,_F_,_O_,_R_,___
    .byte ___,_D_,_A_,_Y_,_S_

paceText:
    .byte "steady   "
    .byte "strenuous"
    .byte "grueling "
    .byte "pace"

rationsText:
    .byte "bare bones" ; 1 lb food per person per day
    .byte "meager    " ; 2 lb food per person per day
    .byte "filling   " ; 3 lb food per person per day

suppliesText:
    .byte "oxen   "
    .byte "clothes"
    .byte "bullets"
    .byte "wheels "
    .byte "axles  "
    .byte "tongues"
    .byte "# food "
    .byte "cash   "

mattSuppliesText:
    .byte 4,"oxen"
    .byte 4,"food"
    .byte 8,"clothing"
    .byte 10,"ammunition"
    .byte 11,"spare parts"
    .byte "- $10% each"

mattBillSoFar:
    .byte "Bill so far:"

healthText:
    .byte "good     "
    .byte "fair     "
    .byte "poor     "
    .byte "very poor"

; defaultPersonNames:
;     .byte 6,_P_,_H_,_I_,_L_,_I_,_P_
;     .byte 8,_C_,_H_,_A_,_R_,_O_,_L_,_Y_,_N_
;     .byte 4,_J_,_O_,_H_,_N_
;     .byte 7,_S_,_H_,_I_,_R_,_L_,_E_,_Y_

newgameNamePartyWhatText:
    .byte "What is the first name of the"

newgameNewPartyNthText:
    .byte "2nd", "3rd", "4th", "5th"

newgameNamePartyPersonText:
    .byte "wagon leader?"
    .byte "party member?"

newgameNamePartyCorrectText:
    .byte "Are these names correct?"

newgameNamePartyChangeText:
    .byte "Change which name?"

; occupationAttribute
; %00000000 
;  |||||+++ Bonus multiplier (000:x0.0, 001:x0.5, 010:x1.0, ..., 111:x3.5)
;  ||+++--- Unused
;  ++------ Starting cash (00:$400, 01:$800, 10:$1200, 11:$1600)
occupationAttribute:
    .byte %11000000 ; BANKER
    .byte %01000100 ; CARPENTER
    .byte %00000110 ; FARMER

; riverAttribute
; %00000000, $00
;  ||||||||   ++ Minimum width (*4 = ft, eg 150*4 = 600ft) 
;  ||++++++----- Minimum depth (0-63 ft)
;  |+----------- Indian guide available (3 sets of clothes)
;  +------------ Ferry available ($5)
; Caulk and Ford are always an option.
riverAttribute:
    .byte %10000001, 150 ; Kansas River
    .byte %00000001, 55  ; Big Blue River
    .byte %10010100, 100 ; Green River
    .byte %01000110, 250 ; Snake River

storeTotalText:
    .byte "Total bill:"
    .byte "You have:"

; independencePrices:
;     $20.00   ; Oxen
;     $10.00   ; Sets of Clothing
;     $2.00    ; Boxes of Bullets (20/box)
;     $10.00   ; Wagon Wheels
;     $10.00   ; Wagon Axles
;     $10.00   ; Wagon Tongues
;     $0.20    ; Pounds of Food

; fortKearneyPrices:
;     $25.00   ; Oxen
;     $12.50   ; Sets of Clothing
;     $2.50    ; Boxes of Bullets (20/box)
;     $12.50   ; Wagon Wheels
;     $12.50   ; Wagon Axles
;     $12.50   ; Wagon Tongues
;     $.25     ; Pounds of Food

; fortLaramiePrices:
;     $30      ; Oxen
;     $15      ; Sets of Clothing
;     $3       ; Boxes of Bullets (20/box)
;     $15      ; Wagon Wheels
;     $15      ; Wagon Axles
;     $15      ; Wagon Tongues
;     $.30     ; Pounds of Food

; fortHallPrices:
;     $40      ; Oxen
;     $20      ; Sets of Clothing
;     $4       ; Boxes of Bullets (20/box)
;     $20      ; Wagon Wheels
;     $20      ; Wagon Axles
;     $20      ; Wagon Tongues
;     $.40     ; Pounds of Food

; fortBoisePrices:
;     $45      ; Oxen
;     $22.50   ; Sets of Clothing
;     $4.50    ; Boxes of Bullets (20/box)
;     $22.50   ; Wagon Wheels
;     $22.50   ; Wagon Axles
;     $22.50   ; Wagon Tongues
;     $.45     ; Pounds of Food

; fortWallaWallaPrices:

;-----------------------------------------------------------


; Locations (landmarks)
; %00000000
;  |||||||+----- trail divides(?) unused for now
;  ||+++++------ unused
;  |+----------- river- y/n
;  +------------ store (fort)- y/n
landmarkAttr:
    .byte %10000000 ; Independence, MO
    .byte %01000000 ; KANSAS RIVER CROSSING
    .byte %01000000 ; BIG BLUE RIVER CROSSING
    .byte %10000000 ; FORT KEARNEY
    .byte %00000000 ; CHIMNEY ROCK
    .byte %10000000 ; FORT LARAMIE
    .byte %00000000 ; INDEPENDENCE ROCK
    .byte %00000000 ; SOUTH PASS
    .byte %10000000 ; FORT BRIDGER
    .byte %01000000 ; GREEN RIVER CROSSING
    .byte %00000000 ; SODA SPRINGS
    .byte %10000000 ; FORT HALL
    .byte %01000000 ; SNAKE RIVER CROSSING
    .byte %10000000 ; FORT BOISE
    .byte %00000000 ; BLUE MOUNTAINS
    .byte %10000000 ; FORT WALLA WALLA
    .byte %00000000 ; THE DALLES
    .byte %00000000 ; WILLAMETTE VALLEY

; Byte index of sprite (see sprites.asm->trailSprites)
landmarkTrailSprite:
    .byte 6*4 ; Independence, MO
    .byte 8*4 ; KANSAS RIVER CROSSING
    .byte 9*4 ; BIG BLUE RIVER CROSSING
    .byte 12*4 ; FORT KEARNEY
    .byte 14*4 ; CHIMNEY ROCK
    .byte 17*4 ; FORT LARAMIE
    .byte 20*4 ; INDEPENDENCE ROCK
    .byte 22*4 ; SOUTH PASS
    .byte 23*4 ; FORT BRIDGER
    .byte 23*4 ; GREEN RIVER CROSSING ; TODO Shortcut
    .byte 25*4 ; SODA SPRINGS
    .byte 27*4 ; FORT HALL
    .byte 29*4 ; SNAKE RIVER CROSSING
    .byte 32*4 ; FORT BOISE
    .byte 34*4 ; BLUE MOUNTAINS
    .byte 36*4 ; FORT WALLA WALLA
    .byte 38*4 ; THE DALLES ; TODO shortcut
    .byte 39*4 ; WILLAMETTE VALLEY

; Distances
nextLandmarkDistance:
    .byte 102   ; Independence to Kansas River
    .byte 83    ; Kansas River to Big Blue River
    .byte 119   ; Big Blue River to Fort Kearney
    .byte 250   ; Fort Kearney to Chimney Rock
    .byte 86    ; Chimney Rock to Fort Laramie
    .byte 190   ; Fort Laramie to Independence Rock
    .byte 102   ; Independence Rock to South Pass
    ;.byte 125    ; South Pass to Fort Bridger ; TODO trail divides
    .byte 57    ; South Pass to Green River
    .byte 162   ; Fort Bridger to Soda Springs
    .byte 144   ; Green River to Soda Springs
    .byte 57    ; Soda Springs to Fort Hall
    .byte 182   ; Fort Hall to Snake River
    .byte 114   ; Snake River to Fort Boise
    .byte 160   ; Fort Boise to Blue Mountains
    .byte 55    ; Blue Mountains to Fort Walla Walla
    ;.byte 125    ; Blue Mountains to The Dalles ; TODO trail divides
    .byte 120   ; Fort Walla Walla to The Dalles
    .byte 100   ; The Dalles to WIllamette Valley (toll road)

locationPrefix:
    .byte "Fort "
    .byte " River Crossing"

locationNameText:
    .byte 12,"Independence"
    .byte 6,"Kansas"
    .byte 8,"Big Blue"
    .byte 7,"Kearney"
    .byte 12,"Chimney Rock"
    .byte 7,"Laramie"
    .byte 17,"Independence Rock"
    .byte 10,"South Pass"
    .byte 7,"Bridger"
    .byte 5,"Green"
    .byte 12,"Soda Springs"
    .byte 4,"Hall"
    .byte 5,"Snake"
    .byte 5,"Boise"
    .byte 18,"The Blue Mountains"
    .byte 11,"Walla Walla"
    .byte 10,"The Dalles"
    .byte 17,"Willamette Valley"
    .byte 0

eventIndianFoodText:
    .byte 23,"Indians help find food."

eventThunderstormText:
    .byte 20,"Severe thunderstorm." ; Lose 1 day

eventBlizzardText:
    .byte 16,"Severe blizzard." ; Lose 1 day

eventWrongTrailText:
    .byte 12,"Wrong trail." ; 1 5

eventLoseTrailText:
    .byte 11,"Lose trail." ; 2 4

eventHailStormText:
    .byte 11,"Hail storm."

eventHeavyFogText:
    .byte 9,"Heavy fog"

eventLoseDaysText:
    .byte 10,"Lose 1 day"

eventBadWaterText:
    .byte 9,"Bad water"

eventInadequateGrassText:
    .byte 16,"Inadequate grass"

eventLittleWaterText:
    .byte 17,"Very little water"

eventRoughTrailText:
    .byte 11,"Rough trail"

eventIllnessText:
    .byte " has "
    .byte 10,"exhaustion"
    .byte 7,"typhoid"
    .byte 7,"cholera"
    .byte 7,"measles"
    .byte 9,"dysentery"
    .byte 7,"a fever"
    .byte "died"

eventOxWandersOffText:
    .byte 15,"Ox wanders off."

eventInjuredOxText:
    .byte 15,"One of the oxen"
    .byte 11,"is injured."

eventInjuryText:
    .byte "snake bite"
    .byte "broken", "arm", "leg"

eventLookAroundText:
    .byte "Would you like to look around?"

; eventThiefText:
;     .byte A THIEF COMES DURING THE NIGHT AND STEALS 

eventWildFruitText:
    .byte 16,"Find wild fruit."

; eventAbandonedWagonText:
; YOU FIND AN ABANDONED WAGON 
; WITH THE FOLLOWING:
; , BUT IT IS EMPTY.

; eventLostPersonText:
; X IS LOST. LOSE X DAYS.

eventImpassibleTrailText:
    .byte 17,"Impassible trail." ; LOSE X DAYS.

; Minimum score (high byte first) and rating
; TODO confirm score values 
topTenRating:
    .byte $1b,$58,"Trail guide"
    .byte $0b,$b8,"Adventurer "
    .byte $00,$00,"Greenhorn  "

topTenHeaderText:
    .byte "The Oregon Top Ten"

topTenColumnText:
    .byte "Name", "Points", "Rating"

topTenQuestionText:
    .byte "Would you like to see how pts are earned?"

topTenHelpText:
    .byte "On Arriving In Oregon"
    .byte "Health of", "Resources of", "Party"
    .byte "Points per", "Person", "Item  "

topTenResourcesText:
    .byte "wagon", "ox", "spare wagon part", "set of clothing"
    .byte "bullets", "food", "cash"

topTenResourcesEachText:
    .byte "each"

; Health of Party   Points per Person
; good              500
; fair              400
; poor              300
; very poor         200

; Resources of Party      Points per Item
; wagons                  50
; ox                      4
; spare wagon part        2
; set of clothing         2
; bullets (each 50)       1
; food (each 25 pounds)   1
; cash (each 5 dollars)   1