titleText:
    .byte _T_,_H_,_E_,___,_O_,_R_,_E_,_G_,_O_,_N_,___,_T_,_R_,_A_,_I_,_L_,___

titleOptions:
    .byte _P_,_R_,_E_,_S_,_S_,___,___,_S_,_T_,_A_,_R_,_T_

pressStartText:
    .byte ___,___,___,___,_P_,_R_,_E_,_S_,_S_,___,_S_,_T_,_A_,_R_,_T_,___,_T_,_O_,___,_C_,_O_,_N_,_T_,_I_,_N_,_U_,_E_,___,___,___,___,___
sizeUpSituationText:
    .byte _P_,_R_,_E_,_S_,_S_,___,_A_,___,_T_,_O_,___,_S_,_I_,_Z_,_E_,___,_U_,_P_,___,_T_,_H_,_E_,___,_S_,_I_,_T_,_U_,_A_,_T_,_I_,_O_,_N_

nextLandmarkText: ; len:18
    .byte _I_,_T_,___,_I_,_S_,___,0,0,0,___,_M_,_I_,_L_,_E_,_S_,___,_T_,_O_

; Locations (landmarks)
; %00000000
;  |||+++++ location id (index)
;  ||+----- trail divides(?) unused for now
;  |+------ river y/n
;  +------- store y/n
landmarkAttr:
    .byte %10000000 ; Independence, MO
    .byte %01000001 ; KANSAS RIVER CROSSING
    .byte %01000010 ; BIG BLUE RIVER CROSSING
    .byte %10000011 ; FORT KEARNEY
    .byte %00000100 ; CHIMNEY ROCK
    .byte %10000101 ; FORT LARAMIE
    .byte %00000110 ; INDEPENDENCE ROCK
    .byte %00000111 ; SOUTH PASS
    .byte %10001000 ; FORT BRIDGER
    .byte %01001001 ; GREEN RIVER CROSSING
    .byte %00001010 ; SODA SPRINGS
    .byte %10001011 ; FORT HALL
    .byte %01001100 ; SNAKE RIVER CROSSING
    .byte %10001101 ; FORT BOISE
    .byte %00001110 ; BLUE MOUNTAINS
    .byte %10001111 ; FORT WALLA WALLA
    .byte %00010000 ; THE DALLES
    .byte %00010001 ; WILLAMETTE VALLEY

; Distances
nextLandmarkDistance:
    ; steady: 20 mi/day
    ; strenuous: 30 mi/day
    ; grueling: 40 mi/day
    .byte 102   ; Independence to Kansas River
    .byte 83    ; Kansas River to Big Blue River
    .byte 119   ; Big Blue River to Fort Kearney
    .byte 250   ; Fort Kearney to Chimney Rock
    .byte 86    ; Chimney Rock to Fort Laramie
    ; steady: 12 mi/day- (10 +/-2)
    ; strenuous: 18 mi/day
    ; grueling: 24 mi/day
    .byte 190   ; Fort Laramie to Independence Rock
    .byte 102   ; Independence Rock to South Pass
    .byte 57    ; South Pass to Fort Bridger
    .byte 162   ; Fort Bridger to Green River
    .byte 125  ; South Pass to Green River
    .byte 144   ; Green River to Soda Springs
    .byte 57    ; Soda Springs to Fort Hall
    .byte 182   ; Fort Hall to Snake River
    .byte 114   ; Snake River to Fort Boise
    .byte 160   ; Fort Boise to Blue Mountains
    .byte 55    ; Blue Mountains to Fort Walla Walla
    .byte 120   ; Fort Walla Walla to The Dalles
    .byte 125   ; Blue Mountains to The Dalles
    .byte 100   ; The Dalles to WIllamette Valley (toll road)

newGameText:
    .byte _L_,_E_,_A_,_D_,_E_,_R_,_CL
    .byte _O_,_C_,_C_,_U_,_P_,_A_,_T_,_I_,_O_,_N_,_CL
    .byte _O_,_T_,_H_,_E_,_R_,___,_P_,_A_,_R_,_T_,_Y_,___,_M_,_E_,_M_,_B_,_E_,_R_,_S_,_CL
    .byte _S_,_T_,_A_,_R_,_T_,_I_,_N_,_G_,___,_D_,_A_,_T_,_E_,_CL

monthText:
    .byte _J_,_A_,_N_
    .byte _F_,_E_,_B_
    .byte _M_,_A_,_R_
    .byte _A_,_P_,_R_
    .byte _M_,_A_,_Y_
    .byte _J_,_U_,_N_
    .byte _J_,_U_,_L_
    .byte _A_,_U_,_G_
    .byte _S_,_E_,_P_
    .byte _O_,_C_,_T_
    .byte _N_,_O_,_V_
    .byte _D_,_E_,_C_

hudText:
    .byte _D_,_A_,_T_,_E_ ; 0-4
    .byte _W_,_E_,_A_,_T_,_H_,_E_,_R_ ; 4-11
    .byte _H_,_E_,_A_,_L_,_T_,_H_ ; 11-17
    .byte _F_,_O_,_O_,_D_ ; 17-21
    .byte _N_,_E_,_X_,_T_,___,_L_,_A_,_N_,_D_,_M_,_A_,_R_,_K_ ; 21-34
    .byte _M_,_I_,_L_,_E_,_S_,___,_T_,_R_,_A_,_V_,_E_,_L_,_E_,_D_ ; 34-48

hudMenuStatusText:
    .byte _W_,_E_,_A_,_T_,_H_,_E_,_R_,_CL ;0-8
    .byte _H_,_E_,_A_,_L_,_T_,_H_,_CL ;8-15
    .byte _P_,_A_,_C_,_E_,_CL ;15-20
    .byte _R_,_A_,_T_,_I_,_O_,_N_,_S_,_CL ;20-28
    .byte _Y_,_O_,_U_,_R_,___,_S_,_U_,_P_,_P_,_L_,_I_,_E_,_S_ ;28-41
    .byte _P_,_O_,_U_,_N_,_D_,_S_ ;41-47
    .byte _M_,_I_,_L_,_E_,_S_ ;47-52

startingDateText:
    .byte _M_,_A_,_R_,_C_,_H_,___
    .byte _J_,_U_,_N_,_E_,___,___
    .byte _A_,_P_,_R_,_I_,_L_,___
    .byte _J_,_U_,_L_,_Y_,___,___
    .byte _M_,_A_,_Y_,___,___,___
    .byte _A_,_U_,_G_,_U_,_S_,_T_

keyboard:
    .byte _A_,_B_,_C_,_D_,_E_,_F_,_G_,_H_,_7_,_8_,_9_
    .byte _I_,_J_,_K_,_L_,_M_,_N_,_O_,_P_,_4_,_5_,_6_
    .byte _Q_,_R_,_S_,_T_,_U_,_V_,_W_,_X_,_1_,_2_,_3_
    .byte _Y_,_Z_,_CL,_CM,_PD,_EX,_QU,___,___,___,___
keyboardDone:
    .byte _D_,_O_,_N_,_E_

decimalDigits:
    .byte _0_,_1_,_2_,_3_,_4_,_5_,_6_,_7_,_8_,_9_

hudMenu:
    .byte _C_,_O_,_N_,_T_,_I_,_N_,_U_,_E_,___,_O_,_N_,___,_T_,_R_,_A_,_I_,_L_,___,___
    .byte _C_,_H_,_E_,_C_,_K_,___,_S_,_U_,_P_,_P_,_L_,_I_,_E_,_S_,___,___,___,___,___
    .byte _L_,_O_,_O_,_K_,___,_A_,_T_,___,_M_,_A_,_P_,___,___,___,___,___,___,___,___
    .byte _C_,_H_,_A_,_N_,_G_,_E_,___,_P_,_A_,_C_,_E_,___,___,___,___,___,___,___,___
    .byte _C_,_H_,_A_,_N_,_G_,_E_,___,_F_,_O_,_O_,_D_,___,_R_,_A_,_T_,_I_,_O_,_N_,_S_
    .byte _S_,_T_,_O_,_P_,___,_T_,_O_,___,_R_,_E_,_S_,_T_,___,___,___,___,___,___,___
    .byte _A_,_T_,_T_,_E_,_M_,_P_,_T_,___,_T_,_O_,___,_T_,_R_,_A_,_D_,_E_,___,___,___
    .byte _H_,_U_,_N_,_T_,___,_F_,_O_,_R_,___,_F_,_O_,_O_,_D_,___,___,___,___,___,___
    .byte _T_,_A_,_L_,_K_,___,_T_,_O_,___,_P_,_E_,_O_,_P_,_L_,_E_,___,___,___,___,___
    .byte _B_,_U_,_Y_,___,_S_,_U_,_P_,_P_,_L_,_I_,_E_,_S_,___,___,___,___,___,___,___

weatherText:
    .byte _V_,_E_,_R_,_Y_,___,_C_,_O_,_L_,_D_,___ ; < 10 °F
    .byte _C_,_O_,_L_,_D_,___,___,___,___,___,___ ; 10 - 30 °F 
    .byte _C_,_O_,_O_,_L_,___,___,___,___,___,___ ; 30 - 50 °F
    .byte _W_,_A_,_R_,_M_,___,___,___,___,___,___ ; 50 - 70 °F
    .byte _H_,_O_,_T_,___,___,___,___,___,___,___ ; 70 - 90 °F
    .byte _V_,_E_,_R_,_Y_,___,_H_,_O_,_T_,___,___ ; > 90 °F
    .byte _R_,_A_,_I_,_N_,_Y_,___,___,___,___,___ ; 0.2", 70% chance
    .byte _V_,_E_,_R_,_Y_,___,_R_,_A_,_I_,_N_,_Y_ ; 0.8", 30% chance
    .byte _S_,_N_,_O_,_W_,_Y_,___,___,___,___,___ ; 2", 70% chance
    .byte _V_,_E_,_R_,_Y_,___,_S_,_N_,_O_,_W_,_Y_ ; 8", 30% chance

restText:
    .byte _R_,_E_,_S_,_T_,___,_F_,_O_,_R_,___
    .byte ___,_D_,_A_,_Y_,_S_

paceText:
    .byte _S_,_T_,_E_,_A_,_D_,_Y_,___,___,___
    .byte _S_,_T_,_R_,_E_,_N_,_U_,_O_,_U_,_S_
    .byte _G_,_R_,_U_,_E_,_L_,_I_,_N_,_G_,___

rationsText:
    .byte _B_,_A_,_R_,_E_,___,_B_,_O_,_N_,_E_,_S_
        ; 1 lb food per person per day
    .byte _M_,_E_,_A_,_G_,_E_,_R_,___,___,___,___
        ; 2 lb food per person per day
    .byte _F_,_I_,_L_,_L_,_I_,_N_,_G_,___,___,___
        ; 3 lb food per person per day

suppliesText:
    .byte _O_,_X_,_E_,_N_,___,___,___
    .byte _C_,_L_,_O_,_T_,_H_,_E_,_S_
    .byte _B_,_U_,_L_,_L_,_E_,_T_,_S_
    .byte _W_,_H_,_E_,_E_,_L_,_S_,___
    .byte _A_,_X_,_L_,_E_,_S_,___,___
    .byte _T_,_O_,_N_,_G_,_U_,_E_,_S_
    .byte _LB,___,_F_,_O_,_O_,_D_,___
    .byte _C_,_A_,_S_,_H_,___,___,___

healthText:
    .byte _G_,_O_,_O_,_D_,___,___,___,___,___
    .byte _F_,_A_,_I_,_R_,___,___,___,___,___
    .byte _P_,_O_,_O_,_R_,___,___,___,___,___
    .byte _V_,_E_,_R_,_Y_,___,_P_,_O_,_O_,_R_

defaultPersonNames:
    .byte ___,___,___,___
    .byte _P_,_H_,_I_,_L_
    .byte _C_,_H_,_A_,_R_;,_O_,_L_,_Y_,_N_
    .byte _J_,_O_,_H_,_N_
    .byte _S_,_H_,_I_,_R_;,_L_,_E_,_Y_

personStatusText:
    .byte _F_,_E_,_V_,_E_,_R_,___,___,___,___,___
    .byte _D_,_Y_,_S_,_E_,_N_,_T_,_E_,_R_,_Y_,___
    .byte _M_,_E_,_A_,_S_,_L_,_E_,_S_,___,___,___
    .byte _S_,_N_,_A_,_K_,_E_,___,_B_,_I_,_T_,_E_
    .byte _E_,_X_,_H_,_A_,_U_,_S_,_T_,_E_,_D_,___
    .byte _T_,_Y_,_P_,_H_,_O_,_I_,_D_,___,___,___
    .byte _C_,_H_,_O_,_L_,_E_,_R_,_A_,___,___,___
    .byte _B_,_R_,_O_,_K_,_E_,_N_,___,_A_,_R_,_M_
    .byte _B_,_R_,_O_,_K_,_E_,_N_,___,_L_,_E_,_G_
    .byte _G_,_O_,_O_,_D_,___,___,___,___,___,___
    .byte _F_,_A_,_I_,_R_,___,___,___,___,___,___
    .byte _P_,_O_,_O_,_R_,___,___,___,___,___,___
    .byte _V_,_E_,_R_,_Y_,___,_P_,_O_,_O_,_R_,___
    .byte _D_,_E_,_C_,_E_,_A_,_S_,_E_,_D_,___,___
    ;.byte ___,___,___,___,___,___,___,___,___,___
    ;.byte ___,___,___,___,___,___,___,___,___,___
    ;.byte ___,___,___,___,___,___,___,___,___,___

personStatusAttribute:
    ; %0000
    ;  |+++ unused
    ;  +--- diaryAffliction line count
    ;       0:text is one line  1:two lines
    ;        
    .byte %00000000 ; FEVER, DYSENTERY
    .byte %00000000 ; MEASLES, SNAKE BITE
    .byte %10001000 ; EXHAUSTION, TYPHOID
    .byte %00000000 ; CHOLERA, BROKEN ARM
    .byte %00000000 ; BROKEN LEG, GOOD
    .byte %00000000 ; FAIR, POOR
    .byte %00000000 ; VERY POOR, DECEASED

occupationText:
    .byte _B_,_A_,_N_,_K_,_E_,_R_,___,___,___,___,___
    .byte _D_,_O_,_C_,_T_,_O_,_R_,___,___,___,___,___
    .byte _M_,_E_,_R_,_C_,_H_,_A_,_N_,_T_,___,___,___
    .byte _B_,_L_,_A_,_C_,_K_,_S_,_M_,_I_,_T_,_H_,___
    .byte _C_,_A_,_R_,_P_,_E_,_N_,_T_,_E_,_R_,___,___
    .byte _S_,_A_,_D_,_D_,_L_,_E_,_M_,_A_,_K_,_E_,_R_
    .byte _F_,_A_,_R_,_M_,_E_,_R_,___,___,___,___,___
    .byte _T_,_E_,_A_,_C_,_H_,_E_,_R_,___,___,___,___

occupationAttribute:
    ; %00000000
    ;  |||||+++ Bonus multiplier (000:x0.0, 001:x0.5, 010:x1.0, ..., 111:x3.5)
    ;  ||||+--- Oxen are less likely to get sick and die
    ;  |||+---- Sick or injured people are less likely to die
    ;  ||+----- More likely to repair broken wagon parts
    ;  ++------ Starting cash (00:$400, 01:$800, 10:$1200, 11:$1600)
    .byte %11000000 ; BANKER
    .byte %10010000 ; DOCTOR
    .byte %10000011 ; MERCHANT
    .byte %01100100 ; BLACKSMITH
    .byte %01100100 ; CARPENTER
    .byte %01000101 ; SADDLEMAKER
    .byte %00001110 ; FARMER
    .byte %00000111 ; TEACHER

riverAttribute:
    ; %00000000
    ;  |||||+++ Depth?
    ;  ||+++--- Width?
    ;  |+------ Indian guide available (3 sets of clothes)
    ;  +------- Ferry available ($5)
    ; Caulk and Ford are always an option.
    .byte %10000000 ; Kansas River 
        ; Widths (ft): 603,
        ; Depths (ft): 1.0,
    .byte %00000000 ; Big Blue River
        ; Widths (ft): 220,
        ; Depths (ft): 1.0,
    .byte %10000000 ; Green River
        ; Widths (ft): 
        ; Depths (ft): 
    .byte %01000000 ; Snake River
        ; Widths (ft): 
        ; Depths (ft): 

generalStoreText:
    .byte _G_,_E_,_N_,_E_,_R_,_A_,_L_,___,_S_,_T_,_O_,_R_,_E_
storeColumnHeaderText:
    .byte _B_,_U_,_Y_,___
    .byte _I_,_T_,_E_,_M_
    .byte _E_,_A_,_C_,_H_
    .byte _C_,_O_,_S_,_T_
storeTotalText:
    .byte ___,___,___,_T_,_O_,_T_,_A_,_L_,_CL
    .byte _Y_,_O_,_U_,___,_H_,_A_,_V_,_E_,_CL
storeNameText:
    .byte ___,___,___,___,___,___,_M_,_A_,_T_,_T_,_AP,_S_
    .byte _F_,_O_,_R_,_T_,___,_K_,_E_,_A_,_R_,_N_,_E_,_Y_
    .byte _F_,_O_,_R_,_T_,___,_L_,_A_,_R_,_A_,_M_,_I_,_E_
    .byte _F_,_O_,_R_,_T_,___,_B_,_R_,_I_,_D_,_G_,_E_,_R_
    .byte _F_,_O_,_R_,_T_,___,_H_,_A_,_L_,_L_,___,___,___
    .byte _F_,_O_,_R_,_T_,___,_B_,_O_,_I_,_S_,_E_,___,___
    .byte _W_,_A_,_L_,_L_,_A_,___,_W_,_A_,_L_,_L_,_A_,___

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



locationNameText:
    .byte 22,_I_,_N_,_D_,_E_,_P_,_E_,_N_,_D_,_E_,_N_,_C_,_E_,_CM,___,_M_,_I_,_S_,_S_,_O_,_U_,_R_,_I_
    .byte 21,_K_,_A_,_N_,_S_,_A_,_S_,___,_R_,_I_,_V_,_E_,_R_,___,_C_,_R_,_O_,_S_,_S_,_I_,_N_,_G_
    .byte 23,_B_,_I_,_G_,___,_B_,_L_,_U_,_E_,___,_R_,_I_,_V_,_E_,_R_,___,_C_,_R_,_O_,_S_,_S_,_I_,_N_,_G_
    .byte 12,_F_,_O_,_R_,_T_,___,_K_,_E_,_A_,_R_,_N_,_E_,_Y_
    .byte 12,_C_,_H_,_I_,_M_,_N_,_E_,_Y_,___,_R_,_O_,_C_,_K_
    .byte 12,_F_,_O_,_R_,_T_,___,_L_,_A_,_R_,_A_,_M_,_I_,_E_
    .byte 17,_I_,_N_,_D_,_E_,_P_,_E_,_N_,_D_,_E_,_N_,_C_,_E_,___,_R_,_O_,_C_,_K_
    .byte 10,_S_,_O_,_U_,_T_,_H_,___,_P_,_A_,_S_,_S_
    .byte 12,_F_,_O_,_R_,_T_,___,_B_,_R_,_I_,_D_,_G_,_E_,_R_
    .byte 20,_G_,_R_,_E_,_E_,_N_,___,_R_,_I_,_V_,_E_,_R_,___,_C_,_R_,_O_,_S_,_S_,_I_,_N_,_G_
    .byte 12,_S_,_O_,_D_,_A_,___,_S_,_P_,_R_,_I_,_N_,_G_,_S_
    .byte 9,_F_,_O_,_R_,_T_,___,_H_,_A_,_L_,_L_
    .byte 20,_S_,_N_,_A_,_K_,_E_,___,_R_,_I_,_V_,_E_,_R_,___,_C_,_R_,_O_,_S_,_S_,_I_,_N_,_G_
    .byte 10,_F_,_O_,_R_,_T_,___,_B_,_O_,_I_,_S_,_E_
    .byte 12,_G_,_R_,_A_,_N_,_D_,_E_,___,_R_,_O_,_N_,_D_,_E_
    .byte 16,_F_,_O_,_R_,_T_,___,_W_,_A_,_L_,_L_,_A_,___,_W_,_A_,_L_,_L_,_A_
    .byte 10,_T_,_H_,_E_,___,_D_,_A_,_L_,_L_,_E_,_S_
    .byte 0

eventIndianFoodText:
    .byte 23,_I_,_N_,_D_,_I_,_A_,_N_,_S_,___,_H_,_E_,_L_,_P_,___,_F_,_I_,_N_,_D_,___,_F_,_O_,_O_,_D_,_PD

eventThunderstorm:
    .byte 20,_S_,_E_,_V_,_E_,_R_,_E_,___,_T_,_H_,_U_,_N_,_D_,_E_,_R_,_S_,_T_,_O_,_R_,_M_,_PD
    .byte 11,_L_,_O_,_S_,_E_,___,_1_,___,_D_,_A_,_Y_,_PD