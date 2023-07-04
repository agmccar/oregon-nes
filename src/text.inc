;-------------------------------------------------------------------------------
.SEGMENT "RODATA"

titleText:
    .byte _T_,_H_,_E_,___,_O_,_R_,_E_,_G_,_O_,_N_,___,_T_,_R_,_A_,_I_,_L_,___

titleOptions:
    .byte _P_,_R_,_E_,_S_,_S_,___,___,_S_,_T_,_A_,_R_,_T_

newGameText:
    .byte _L_,_E_,_A_,_D_,_E_,_R_,_CL
    .byte _O_,_C_,_C_,_U_,_P_,_A_,_T_,_I_,_O_,_N_,_CL
    .byte _O_,_T_,_H_,_E_,_R_,___,_P_,_A_,_R_,_T_,_Y_,___,_M_,_E_,_M_,_B_,_E_,_R_,_S_,_CL

keyboard:
    .byte _A_,_B_,_C_,_D_,_E_,_F_,_G_,_H_,_7_,_8_,_9_
    .byte _I_,_J_,_K_,_L_,_M_,_N_,_O_,_P_,_4_,_5_,_6_
    .byte _Q_,_R_,_S_,_T_,_U_,_V_,_W_,_X_,_1_,_2_,_3_
    .byte _Y_,_Z_,_CL,_CM,_PD,_EX,_QU,___
    .byte _D_,_O_,_N_,_E_

hudMenu:
    .byte _M_,_A_,_P_,___,___,___,___ ;ちず
    .byte _S_,_T_,_A_,_T_,_U_,_S_,___ ;ステータス
    .byte _R_,_A_,_T_,_I_,_O_,_N_,_S_ ;しょくりょう
    .byte _T_,_R_,_A_,_D_,_E_,___,___ ;トレード
    .byte _T_,_A_,_L_,_K_,___,___,___ ;はなす
    .byte _R_,_E_,_S_,_T_,___,___,___ ;やすみ
    .byte _P_,_A_,_C_,_E_,___,___,___ ;そくど
    .byte _H_,_U_,_N_,_T_,___,___,___ ;ハント
    .byte _O_,_P_,_T_,_I_,_O_,_N_,_S_ ;オプション
    

temperatureText:          ;(Attribute)
    .byte _I_,_C_,_Y_,_EX ; $0,$8
    .byte _C_,_O_,_L_,_D_ ; $1,$9 
    .byte _C_,_O_,_O_,_L_ ; $2,$A HAIL STORM, SNOWING, BLIZZARD
    .byte _F_,_A_,_I_,_R_ ; $3,$B RAINY, THUNDER STORM, VERY RAINY
    .byte _F_,_A_,_I_,_R_ ; $4,$C CLOUDY, PARTLY CLOUDY, FOGGY
    .byte _W_,_A_,_R_,_M_ ; $5,$D CLEAR, DUST STORM
    .byte _H_,_O_,_T_,___ ; $6,$E 
    .byte _H_,_O_,_T_,_EX ; $7,$F 


weatherAttributes:
    ; %0000 ($0-$F)
    ;  |||+ Fine- 0:cooler, 1:warmer
    ;  ||+- Coarse- 0:colder, 1:hotter
    ;  |+-- VCoarse- 0:cold, 1:hot
    ;  +--- Text- 0:text is one line, 1:two lines.
    .byte $5C ; CLEAR, PARTLY CLOUDY
    .byte $43 ; CLOUDY, RAINY
    .byte $B2 ; VERY RAINY, SNOWING
    .byte $24 ; BLIZZARD, FOGGY
    .byte $DB ; DUST STORM, THUNDER STORM
    .byte $A0 ; HAIL STORM, unused
    .byte $00 ; unused, unused
    .byte $00 ; unused, unused

weatherText:
    .byte ___,_C_,_L_,_E_,_A_,_R_,___,___ ;かいせい　晴
    .byte ___,_P_,_A_,_R_,_T_,_L_,_Y_,___ ;うすぐもり　雲 (ときどき?)
    .byte ___,_C_,_L_,_O_,_U_,_D_,_Y_,___
    .byte ___,_C_,_L_,_O_,_U_,_D_,_Y_,___ ;くもり　雲
    .byte ___,_R_,_A_,_I_,_N_,_Y_,___,___ ;あめ　雨
    .byte ___,_V_,_E_,_R_,_Y_,___,___,___ ; どしゃぶり
    .byte ___,_R_,_A_,_I_,_N_,_Y_,___,___ ; 
    .byte ___,_S_,_N_,_O_,_W_,_I_,_N_,_G_ ;ゆき
    .byte _B_,_L_,_I_,_Z_,_Z_,_A_,_R_,_D_ ;ブリザード
    .byte ___,_F_,_O_,_G_,_G_,_Y_,___,___ ;フォグ
    .byte ___,_D_,_U_,_S_,_T_,___,___,___ ;さじんあらし
    .byte ___,_S_,_T_,_O_,_R_,_M_,___,___ 
    .byte ___,_T_,_H_,_U_,_N_,_D_,_E_,_R_ ;らいう
    .byte ___,_S_,_T_,_O_,_R_,_M_,___,___ 
    .byte ___,_H_,_A_,_I_,_L_,___,___,___ ;ひょうのあらし
    .byte ___,_S_,_T_,_O_,_R_,_M_,___,___ 
    .byte ___,___,___,___,___,___,___,___ ; unused
    .byte ___,___,___,___,___,___,___,___ ; unused
    .byte ___,___,___,___,___,___,___,___ ; unused
    .byte ___,___,___,___,___,___,___,___ ; unused
    .byte ___,___,___,___,___,___,___,___ ; unused

;weatherGraphics----todo



paceText:
    .byte _S_,_T_,_E_,_A_,_D_,_Y_,___,___,___
    .byte _S_,_T_,_R_,_E_,_N_,_U_,_O_,_U_,_S_
    .byte _G_,_R_,_U_,_E_,_L_,_I_,_N_,_G_,___

rationsText:
    .byte _F_,_I_,_L_,_L_,_I_,_N_,_G_,___,___,___
        ; 3 lb food per person per day
    .byte _M_,_E_,_A_,_G_,_E_,_R_,___,___,___,___
        ; 2 lb food per person per day
    .byte _B_,_A_,_R_,_E_,___,_B_,_O_,_N_,_E_,_S_
        ; 1 lb food per person per day

suppliesText:
    .byte _O_,_X_,_E_,_N_,___,___,___
    .byte _C_,_L_,_O_,_T_,_H_,_E_,_S_
    .byte _B_,_U_,_L_,_L_,_E_,_T_,_S_
    .byte _W_,_H_,_E_,_E_,_L_,_S_,___
    .byte _A_,_X_,_L_,_E_,_S_,___,___
    .byte _T_,_O_,_N_,_G_,_U_,_E_,_S_
    .byte _LB,___,_F_,_O_,_O_,_D_,___
    .byte _DL,_0_,_0_,_0_,_0_,_PD,_00

healthText:
    .byte ___,___,_G_,_O_,_O_,_D_
    .byte ___,___,_F_,_A_,_I_,_R_
    .byte ___,___,_P_,_O_,_O_,_R_
    .byte _V_,_PD,_P_,_O_,_O_,_R_

defaultPersonNames:
    .byte ___,___,___,___
    .byte _E_,_M_,_M_,_A_
    .byte _B_,_E_,_T_,_H_
    .byte _J_,_E_,_D_,___
    .byte _Z_,_E_,_K_,_E_

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


