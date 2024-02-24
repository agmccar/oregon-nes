
; .%%%%%%..%%..%%...%%%%...%%%%%%..%%..%%..%%%%%%.
; .%%......%%%.%%..%%........%%....%%%.%%..%%.....
; .%%%%....%%.%%%..%%.%%%....%%....%%.%%%..%%%%...
; .%%......%%..%%..%%..%%....%%....%%..%%..%%.....
; .%%%%%%..%%..%%...%%%%...%%%%%%..%%..%%..%%%%%%.
; ................................................
currentBank:        .res 1
pointer:            .res 2
counter:            .res 2
sprite0hit:         .res 1
helper:             .res 2
helper2:            .res 2
frameCounter:       .res 1
globalScroll:       .res 1
lastGameState:      .res 1 
gameState:          .res 1 
bgLoaded:           .res 1
bufferLoading:      .res 1
bufferPointer:      .res 1
softPPUCTRL:        .res 1
softPPUMASK:        .res 1
softPPUSCROLL:      .res 2
buttons1:           .res 1 ; Controller 1 input
buttons1Last:       .res 1
seed:               .res 2 ; PRNG seed
bufferHelper:       .res 4

; .%%%%%%...%%%%...%%..%%..%%..%%..%%...%%...%%%%...%%%%%...%%..%%.
; ...%%....%%..%%..%%.%%...%%..%%..%%%.%%%..%%..%%..%%..%%..%%..%%.
; ...%%....%%..%%..%%%%....%%..%%..%%.%.%%..%%%%%%..%%%%%...%%..%%.
; ...%%....%%..%%..%%.%%...%%..%%..%%...%%..%%..%%..%%..%%..%%..%%.
; ...%%.....%%%%...%%..%%...%%%%...%%...%%..%%..%%..%%..%%...%%%%..
; .................................................................
.exportzp SourcePtr
SourcePtr:   .res 2
NMIcounter:  .res 1
WhichSystem: .res 1
DummyByte:   .res 1

Byte1:       .res 1
Byte2:       .res 1

; ..%%%%...%%%%%....%%%%...%%%%%...%%..%%..%%%%%%...%%%%....%%%%..
; .%%......%%..%%..%%..%%..%%..%%..%%..%%....%%....%%..%%..%%.....
; .%%.%%%..%%%%%...%%%%%%..%%%%%...%%%%%%....%%....%%.......%%%%..
; .%%..%%..%%..%%..%%..%%..%%......%%..%%....%%....%%..%%......%%.
; ..%%%%...%%..%%..%%..%%..%%......%%..%%..%%%%%%...%%%%....%%%%..
; ................................................................
; %00000000
;  ||||||++ animation frame
;  |+++++-- unused
;  +------- stopped- 1:stopped 0:moving
oxenFrame:          .res 1 


; .%%..%%..%%..%%..%%%%%..
; .%%..%%..%%..%%..%%..%%.
; .%%%%%%..%%..%%..%%..%%.
; .%%..%%..%%..%%..%%..%%.
; .%%..%%...%%%%...%%%%%..
; ........................
keyboardKey:        .res 1 ; keyboard key (letter/symbol) currently selected
nameCursor:         .res 1
menuCursor:         .res 1
nextMi:             .res 2
nextDigit:          .res 4
traveledMi:         .res 2 ; Prairie <950 mi, Mountainous terrain >=950 miles
traveledDigit:      .res 4
menuOpenLast:       .res 1
menuOpen:           .res 1 ; see: constants.asm -> Menu states

; .%%%%%%..%%%%%%..%%..%%...%%%%...%%%%%%..%%%%%..
; .%%........%%....%%%.%%..%%......%%......%%..%%.
; .%%%%......%%....%%.%%%..%%.%%%..%%%%....%%%%%..
; .%%........%%....%%..%%..%%..%%..%%......%%..%%.
; .%%......%%%%%%..%%..%%...%%%%...%%%%%%..%%..%%.
; ................................................
; %00000000 fingerAttr
;  |||||||+ Main finger direction- 0:R, 1:L
;  ||||||+- "Old" finger direction- 0:R, 1:L
;  |||||+-- Main finger visible- 0:no, 1:yes
;  ||||+--- "Old" finger visible- 0:no, 1:yes
;  |||+---- type- 0:normal finger, 1: arrows (if 'R': up/down, 'L':left/right)
;  ||+----- keyboard key- 0:no, 1:yes
;  ++------ unused
fingerAttr:         .res 1
fingerX:            .res 1 ; (tiles from top left)
fingerY:            .res 1 ; (tiles from top left)
fingerLastX:        .res 1 ; last pos for graphics refresh
fingerLastY:        .res 1 ;
fingerLastLastX:    .res 1 ; previous last pos (for submenus)
fingerLastLastY:    .res 1 ;


; .%%...%%...%%%%....%%%%....%%%%...%%..%%.
; .%%...%%..%%..%%..%%......%%..%%..%%%.%%.
; .%%.%.%%..%%%%%%..%%.%%%..%%..%%..%%.%%%.
; .%%%%%%%..%%..%%..%%..%%..%%..%%..%%..%%.
; ..%%.%%...%%..%%...%%%%....%%%%...%%..%%.
; .........................................
; %00000000 wagonStatus
;  |||||||+ Speed- 0:stopped, 1:moving
;  ||||||+- Trail- 0:at landmark, 1:on the trail 
;  ||||++-- unused
;  ++++---- Rest- 0-15 days remaining
wagonStatus:        .res 1 ; TODO: deprecate

; 0-34: good health
; 35-69: fair health
; 70-104: poor health
; 105-139: very poor health
; 140+: remaining party members all die within a few days
wagonHealth:        .res 1
oxenHealth:         .res 1 ; 0: all healthy, 1: sick or injured ox ; TODO don't waste an entire byte for a bool?

; On each day that there is no food, or that clothing is inadequate,
; add 0.8 to the freeze/starve factor.
; On each day that there is neither any freezing or starving,
; divide the freeze/starve factor by 2.
; Add the freeze/starve factor to the daily general health value.
; Stored as a multiple of 0.2 (eg 0.8 is stored as 4)
wagonFreezeStarve:  .res 1

wagonPace:          .res 1 ; Pace- 1:steady, 2:strenuous, 3:grueling
wagonRations:       .res 1 ; Rations- 1:bare bones, 2:meager, 3:filling
wagonRest:          .res 1 ; days of rest/delay remaining. 


; ..%%%%...%%..%%..%%%%%...%%%%%...%%......%%%%%%..%%%%%%...%%%%..
; .%%......%%..%%..%%..%%..%%..%%..%%........%%....%%......%%.....
; ..%%%%...%%..%%..%%%%%...%%%%%...%%........%%....%%%%.....%%%%..
; .....%%..%%..%%..%%......%%......%%........%%....%%..........%%.
; ..%%%%....%%%%...%%......%%......%%%%%%..%%%%%%..%%%%%%...%%%%..
; ................................................................
oxenHeadcount:      .res 2  ; oxen in inventory
foodLbs:            .res 2  ; lbs of food in inventory
clothing:           .res 2  ; sets of clothing in inventory
bullets:            .res 2  ; bullets in inventory

; spare parts in inventory
; %00000000 
;  ||||||++ wagon wheels
;  ||||++-- wagon axles
;  ||++---- wagon tongues
;  ++------ unused
spareParts:         .res 1
dollars:            .res 2  ; dollars in inventory
cents:              .res 1

oxenDigit:          .res 4 ; oxen in inventory
foodLbsDigit:       .res 4 ; lbs of food in inventory
clothingDigit:      .res 4 ; sets of clothing in inventory
bulletsDigit:       .res 4 ; bullets in inventory
dollarsDigit:       .res 4 ; dollars in inventory
centsDigit:         .res 2 

; ..%%%%...%%..%%...%%%%...%%%%%...%%%%%...%%%%%%..%%..%%...%%%%..
; .%%......%%..%%..%%..%%..%%..%%..%%..%%....%%....%%%.%%..%%.....
; ..%%%%...%%%%%%..%%..%%..%%%%%...%%%%%.....%%....%%.%%%..%%.%%%.
; .....%%..%%..%%..%%..%%..%%......%%........%%....%%..%%..%%..%%.
; ..%%%%...%%..%%...%%%%...%%......%%......%%%%%%..%%..%%...%%%%..
; ................................................................
cartOxen:           .res 2  ; oxen in shopping cart (yokes at matt's store)
cartFoodLbs:        .res 2  ; lbs of food in shopping cart
cartClothing:       .res 2  ; sets of clothing in shopping cart
cartBullets:        .res 2  ; bullets in shopping cart

; spare parts in shopping cart
; %00000000
;  ||||||++ wagon wheels
;  ||||++-- wagon axles
;  ||++---- wagon tongues
;  ++------ unused
cartSpareParts:     .res 2
cartItem: .res 2
cartTotalDollars:   .res 2  ; dollar cost of entire shopping cart
cartTotalCents:     .res 1
cartSubtotalDollars: .res 2
cartSubtotalCents:   .res 1

; decimal digits
cartOxenCostDigit:  .res 6
cartFoodLbsCostDigit:  .res 6
cartClothingCostDigit:  .res 6
cartBulletsCostDigit:  .res 6
cartSparePartsCostDigit:  .res 6
cartDollarsDigit:   .res 6
cartSubtotalDigit: .res 6
cartHelperDigit:    .res 6
cartItemDigit: .res 4 
costBase:           .res 1 ; cost in cents per lb of food
costCursor: .res 1 ; 0: 1000s place, 1: 100s place, 2: 10s place, 3: 1s place
; how much to add to cart subtotal if "up" button pressed
cursorDollarsValue: .res 1
cursorCentsValue:   .res 1


; .%%%%%....%%%%...%%%%%...%%%%%%..%%..%%.
; .%%..%%..%%..%%..%%..%%....%%.....%%%%..
; .%%%%%...%%%%%%..%%%%%.....%%......%%...
; .%%......%%..%%..%%..%%....%%......%%...
; .%%......%%..%%..%%..%%....%%......%%...
; ........................................
occupation:         .res 1   ;

; %00000000
;  |||||+++ Illness- 0:none,    1:exhaustion, 2:typhoid, 3:cholera,
;  |||||             4:measles, 5:dysentery,  6:fever,   7:broken limb
;  +++++--- Remaining days of affliction- 0 to 30 (31: infinite; ie, deceased.)
personHealth:       .res 5   ; 1 each * 5 


; ..%%%%....%%%%...%%..%%..%%%%%...%%%%%%..%%%%%%..%%%%%%...%%%%...%%..%%.
; .%%..%%..%%..%%..%%%.%%..%%..%%....%%......%%......%%....%%..%%..%%%.%%.
; .%%......%%..%%..%%.%%%..%%..%%....%%......%%......%%....%%..%%..%%.%%%.
; .%%..%%..%%..%%..%%..%%..%%..%%....%%......%%......%%....%%..%%..%%..%%.
; ..%%%%....%%%%...%%..%%..%%%%%...%%%%%%....%%....%%%%%%...%%%%...%%..%%.
; ........................................................................

talkOption:         .res 1 ; which "Talk to people" text to display
weather:            .res 1 ; see text.asm -> weatherText
dateYear:           .res 1 ; years since 1848
dateMonth:          .res 1
dateDay:            .res 1
accumulatedRain:    .res 1 ; 0.100 inch increments - max 25.5"
accumulatedSnow:    .res 1 ; 0.125 inch increments - max 31.875"

; Location (landmark)
; see: constants.asm -> Location indices
location:           .res 1
wagonAtLandmark:    .res 1 ; 0:wagon is on the trail, 1:wagon is at a location
nextRiver:          .res 1

; River conditions
; 0.100 feet increments - max 25.5'
; values are added to base river conditions (riverAttribute)
riverWidth:         .res 2 ; baseWidth + (3 * accumulatedRain / 2)
riverDepth:         .res 2 ; baseDepth + (2 * accumulatedRain)

riverWidthDigit:    .res 4
riverDepthDigit:    .res 4
riverSwiftness:     .res 1 ; ?

; remaining: $65