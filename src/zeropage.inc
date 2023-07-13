; Engine
currentBank:        .res 1
tilesBank:          .res 1
pointer:            .res 2
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
buttons1:           .res 1  ; Controller 1 input
buttons1Last:       .res 1

; Graphics ---------------------------------------------------------------------

oxenFrame:      .res 1 ; frame 0=$01; 1=$02; 2=$04, 3=$08, 4=$10 (a hack)

; HUD --------------------------------------------------------------------------

keyboardKey:        .res 1 ; keyboard key (letter/symbol) currently selected
nameCursor:         .res 1
occupationCursor:   .res 1
traveledMi:         .res 2
traveledDigit:      .res 4
menuOpenLast:       .res 1
menuOpen:           .res 1 ; see: constants.inc -> Menu states

; %00000000
;  |||||||+ status HUD visible
;  ||||||+- diary HUD visible
;  |||||+-- map HUD visible
;  +++++--- unused 
hudOpen:            .res 1

; traveling state, press select: switch between AB, CA, CB
; location state, press select: switch between A, B, C
; A:conditions, B:console/log, C:Map

fingerX:            .res 1 ; (tiles from top left)
fingerY:            .res 1 ; (tiles from top left)
fingerLastX:        .res 1 ; last pos for graphics refresh
fingerLastY:        .res 1 ;
fingerLastLastX:    .res 1 ; previous last pos (for submenus)
fingerLastLastY:    .res 1 ;

; %00000000 fingerAttr
;  |||||||+ Main finger direction- 0:R, 1:L
;  ||||||+- "Old" finger direction- 0:R, 1:L
;  |||||+-- Main finger visible- 0:no, 1:yes
;  ||||+--- "Old" finger visible- 0:no, 1:yes
;  |||+---- type- 0:normal finger 1:"up/down" arrows
;  +++----- unused
fingerAttr:         .res 1

; decimal digits text

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
;  ||||++-- Health- 00: Good, 01: Fair, 10: Poor, 11: V.Poor
;  ++++---- Rest- 0-15 days remaining
wagonStatus:    .res 1

; %00000000 wagonSettings
;  ||||||++ Pace- 00:unused, 01:steady, 10:strenuous, 11:grueling
;  ||||++-- Rations- 00:unused, 01:bare bones, 10:meager, 11:filling
;  |||+---- Rest- 0:not resting, 1:resting
;  +++----- unused
wagonSettings:  .res 1 

; Supplies ---------------------------------------------------------------------

dollars:        .res 2  ; dollars in inventory
foodLbs:        .res 2  ; lbs of food in inventory
clothing:       .res 2  ; sets of clothing in inventory
bullets:        .res 2  ; bullets in inventory
oxenHeadcount:  .res 2  ; oxen in inventory
cartDollars:    .res 2  ; dollar cost of entire shopping cart
cartFoodLbs:    .res 1  ; x10 lbs of food in shopping cart
cartClothing:   .res 1  ; sets of clothing in shopping cart
cartBullets:    .res 1  ; x10 bullets in shopping cart
cartOxen:       .res 1  ; oxen in shopping cart
cost:           .res 2  ; helper for calculating cost
costhelper:     .res 2

; %00000000
;  ||||||++ wagon wheels
;  ||||++-- wagon axles
;  ||++---- wagon tongues
;  ++------ unused
spareParts:     .res 1  ; spare parts in inventory
cartSpareParts: .res 1  ; spare parts in shopping cart



; Party ------------------------------------------------------------------------

occupation:    .res 1   ;
personName:    .res 20  ; 4 each * 5 people
personStatus:  .res 5   ; 1 each * 5 
    ; $00: GOOD
    ; $01: 
    ; .byte _F_,_E_,_V_,_E_,_R_,___,___,___,___,___
    ; .byte _D_,_Y_,_S_,_E_,_N_,_T_,_E_,_R_,_Y_,___
    ; .byte _M_,_E_,_A_,_S_,_L_,_E_,_S_,___,___,___
    ; .byte _S_,_N_,_A_,_K_,_E_,___,_B_,_I_,_T_,_E_
    ; .byte _E_,_X_,_H_,_A_,_U_,_S_,_T_,_E_,_D_,___
    ; .byte _T_,_Y_,_P_,_H_,_O_,_I_,_D_,___,___,___
    ; .byte _C_,_H_,_O_,_L_,_E_,_R_,_A_,___,___,___
    ; .byte _B_,_R_,_O_,_K_,_E_,_N_,___,_A_,_R_,_M_
    ; .byte _B_,_R_,_O_,_K_,_E_,_N_,___,_L_,_E_,_G_
    ; .byte _G_,_O_,_O_,_D_,___,___,___,___,___,___
    ; .byte _F_,_A_,_I_,_R_,___,___,___,___,___,___
    ; .byte _P_,_O_,_O_,_R_,___,___,___,___,___,___
    ; .byte _V_,_E_,_R_,_Y_,___,_P_,_O_,_O_,_R_,___
    ; .byte _D_,_E_,_C_,_E_,_A_,_S_,_E_,_D_,___,___

; Conditions -------------------------------------------------------------------

; %00000000
;  |||||+++ current (calculated/generated) temperature
;  |||||        000:COLD  001:COLD  010:COOL  011:FAIR 
;  |||||        100:FAIR  101:WARM  110:HOT   111:HOT! 
;  ||||+--- unused
;  ++++---- current weather type
;               0000:CLEAR        0001:PARTLY CLOUDY
;               0010:CLOUDY       0011:RAINY
;               0100:VERY RAINY   0101:SNOWING
;               0110:BLIZZARD     0111:FOGGY
;               1000:DUST STORM   1001:THUNDER STORM
;               1010:HAIL STORM   1011:unused
;               1100:unused       1101:unused
;               1110:unused       1111:unused
weather:        .res 1

dateYear:       .res 1 ; years since 1848
dateMonth:      .res 1
dateDay:        .res 1
location:       .res 1 ; see: constants.inc -> Locations

;-------------------------------------------------------------------------------
; remaining: $75