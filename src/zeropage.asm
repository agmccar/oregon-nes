; Engine -----------------------------------------------------------------------

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


; Graphics ---------------------------------------------------------------------

; %00000000
;  ||||||++ animation frame
;  |+++++-- unused
;  +------- stopped- 1:stopped 0:moving
oxenFrame:          .res 1 



; HUD --------------------------------------------------------------------------

keyboardKey:        .res 1 ; keyboard key (letter/symbol) currently selected
nameCursor:         .res 1
menuCursor:         .res 1
nextMi:             .res 2
nextDigit:          .res 4
traveledMi:         .res 2 ; Prairie <950 mi, Mountainous terrain >=950 miles
traveledDigit:      .res 4
menuOpenLast:       .res 1
menuOpen:           .res 1 ; see: constants.asm -> Menu states

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

dollarsDigit:       .res 4 ; dollars in inventory
foodLbsDigit:       .res 4 ; lbs of food in inventory
clothingDigit:      .res 4 ; sets of clothing in inventory
bulletsDigit:       .res 4 ; bullets in inventory
oxenDigit:          .res 4 ; oxen in inventory
cartDollarsDigit:   .res 4 ; dollar cost of shopping cart
cartFoodLbsDigit:   .res 4 ; lbs of food in shopping cart
cartClothingDigit:  .res 4 ; sets of clothing in shopping cart
cartBulletsDigit:   .res 4 ; bullets in shopping cart
cartOxenDigit:      .res 4 ; oxen in shopping cart
cartHelperDigit:    .res 4 ; shameless hack


; Wagon ------------------------------------------------------------------------

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

; %00000000 wagonSettings
;  ||||||++ Pace- 00:unused, 01:steady, 10:strenuous, 11:grueling
;  ||||++-- Rations- 00:unused, 01:bare bones, 10:meager, 11:filling
;  ++++---- unused
wagonSettings:      .res 1 
wagonRest:          .res 1 ; days of rest/delay remaining. 


; Supplies ---------------------------------------------------------------------

dollars:            .res 2  ; dollars in inventory
foodLbs:            .res 2  ; lbs of food in inventory
clothing:           .res 2  ; sets of clothing in inventory
bullets:            .res 2  ; bullets in inventory
oxenHeadcount:      .res 2  ; oxen in inventory
cartDollars:        .res 2  ; dollar cost of entire shopping cart
cartFoodLbs:        .res 1  ; x10 lbs of food in shopping cart
cartClothing:       .res 1  ; sets of clothing in shopping cart TODO: Must allow more than 19 sets of clothing in cart!
cartBullets:        .res 1  ; x10 bullets in shopping cart
cartOxen:           .res 1  ; oxen in shopping cart
cost:               .res 2  ; helper for calculating cost
costhelper:         .res 2

; %00000000
;  ||||||++ wagon wheels
;  ||||++-- wagon axles
;  ||++---- wagon tongues
;  ++------ unused
spareParts:         .res 1  ; spare parts in inventory
cartSpareParts:     .res 1  ; spare parts in shopping cart


; Party ------------------------------------------------------------------------

occupation:         .res 1   ;

; %00000000
;  |||||+++ Illness- 0:none,    1:exhaustion, 2:typhoid, 3:cholera,
;  |||||             4:measles, 5:dysentery,  6:fever,   7:broken limb
;  +++++--- Remaining days of affliction- 0 to 30 (31: infinite; ie, deceased.)
personHealth:       .res 5   ; 1 each * 5 


; Conditions -------------------------------------------------------------------

talkOption:         .res 1 ; which "Talk to people" text to display
weather:            .res 1 ; see text.asm -> weatherText
dateYear:           .res 1 ; years since 1848
dateMonth:          .res 1
dateDay:            .res 1
accumulatedRain:    .res 1 ; 0.100 inch increments - max 25.6"
accumulatedSnow:    .res 1 ; 0.125 inch increments - max 32"

; Locations (landmarks)
; see: constants.asm -> Locations
; %00000000
;  |||+++++ identifier(index)
;  ||+----- trail divides(?) unused for now
;  |+------ river y/n
;  +------- store y/n
location:           .res 1


;-------------------------------------------------------------------------------
; remaining: $66