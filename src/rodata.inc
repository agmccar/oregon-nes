.SEGMENT "RODATA"

palette:
    ; background palette data
    .byte $21, $25, $19, $30 ; Sky, Pink, Trees, White
    .byte $21, $19, $29, $30 ; Sky, Trees, Grass, White
    .byte $21, $06, $29, $30 ; Sky, Brown, Grass, White
    .byte $21, $16, $0F, $30 ; Sky, Red, Black, White (HUD)
    ; sprite palette data
    .byte $21, $00, $10, $30 ; Sky, Grey, LGrey, White
    .byte $21, $29, $29, $29 ; Sky,Grass,Grass,Grass
    .byte $21, $00, $10, $30 ;
    .byte $21, $00, $10, $30 ;

terrain:
    .byte $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00
    .byte $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00

    .byte $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00
    .byte $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00
    
    .byte $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $01,$02,$03,$00
    .byte $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $01,$02,$03,$00
    
    .byte $04,$05,$06,$07, $08,$09,$0A,$0B, $0C,$0D,$0E,$0F, $10,$11,$12,$13
    .byte $04,$05,$06,$07, $08,$09,$0A,$0B, $0C,$0D,$0E,$0F, $10,$11,$12,$13


    .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20
    .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20

    .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20
    .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20

    .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20
    .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20

    .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20
    .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20 
    ;^--- BG, wagon/oxen zone

hud1:
    ;v--- HUD
    .byte _HR,_HR,_HR,_HR, _HR,_HR,_HR,_HR, _HR,_HR,_HR,_HR, _HR,_HR,_HR,_HR 
    .byte _HR,_HR,_HR,_HR, _HR,_HR,_HR,_HR, _HR,_HR,_HR,_HR, _HR,_HR,_HR,_HR

    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,_S_,_E_, _P_,___,_2_,_9_, _CM,___,_1_,_8_, _4_,_8_,___,___
    
    .byte ___,_H_,_E_,_A_, _L_,_T_,_H_,_CL, ___,___,_P_,_O_, _O_,_R_,___,_VR 
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___

    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___
    
    ; AAAA
    .byte ___,_F_,_O_,_O_, _D_,_CL,___,___, ___,_4_,_5_,_0_, ___,_LB,___,_VR 
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___

    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___
    
    .byte ___,_T_,_R_,_A_, _V_,_E_,_L_,_E_, _D_,_CL,___,___, ___,___,___,_VR 
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___

    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___
    
hud2:
    .byte ___,___,___,___, ___,___,___,___, _1_,_0_,_9_,_4_, ___,_MI,___,_VR 
    .byte ___,_W_,_E_,_A_, _T_,_H_,_E_,_R_, ___,___,_T_,_E_, _M_,_P_,___,___

    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___
    
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,_VR 
    .byte ___,_W_,_E_,_A_, _T_,_H_,_E_,_R_, ___,___,___,___, ___,___,___,___

    .byte _HR,_HR,_HR,_HR, _HR,_HR,_HR,_HR, _HR,_HR,_HR,_HR, _HR,_HR,_HR,_HR
    .byte _HR,_HR,_HR,_HR, _HR,_HR,_HR,_HR, _HR,_HR,_HR,_HR, _HR,_HR,_HR,_HR
    

    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___ 
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___

    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___
    
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___ 
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___

    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___
    
hud3:
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___ 
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___

    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___
    
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___ 
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___

    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___
    

    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___ 
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___

    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,___
    
    ; .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20
    ; .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$30, $31,$32,$33,$34

    ; .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20
    ; .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$35, $36,$37,$38,$39

    ; .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$20
    ; .byte $20,$20,$20,$20, $20,$20,$20,$20, $20,$20,$20,$3A, $3B,$3D,$3F,$41

;-----------------------------------------------------------
hudMenu:
    .byte _HR,_HR,_HR,_HR, _HR,_HR,_HR,_HR, _HR,_HR,_HR,_HR, _HR,_HR,_HR,_HR
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,_M_, _A_,_P_,___,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,_S_, _T_,_A_,_T_,_U_, _S_,___,___,___, ___,___,___,_VR
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,_R_, _A_,_T_,_I_,_O_, _N_,_S_,___,___, ___,___,___,_VR
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,_T_, _R_,_A_,_D_,_E_, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,_T_, _A_,_L_,_K_,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,_R_, _E_,_S_,_T_,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,_P_, _A_,_C_,_E_,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,_H_, _U_,_N_,_T_,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,_O_, _P_,_T_,_I_,_O_, _N_,_S_,___,___, ___,___,___,_VR
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,_VR
    .byte ___,___,___,___, ___,___,___,___, ___,___,___,___, ___,___,___,_VR
    ;------Menu
    ;MAP
    ;ちず
    ;STATUS
    ;ステータス
    ;RATIONS
    ;しょくりょう
    ;TRADE
    ;トレード
    ;TALK
    ;はなす
    ;REST
    ;やすみ
    ;PACE
    ;そくど
    ;HUNT
    ;ハント
    ;OPTIONS
    ;オプション


;-----------------------------------------------------------
temperatureText:
    .byte _C_,_O_,_L_,_D_
    .byte _C_,_O_,_O_,_L_
    .byte _F_,_A_,_I_,_R_
    .byte _W_,_A_,_R_,_M_
    .byte _H_,_O_,_T_,_EX


weatherTextLineCount:
    ; 0 = one line; 1 = two lines.
    .byte %01000000
    ;      |||||||+ FOGGY
    ;      ||||||+- BLIZZARD
    ;      |||||+-- SNOWING
    ;      ||||+--- DOWNPOUR
    ;      |||+---- RAINY
    ;      ||+----- CLOUDY
    ;      |+------ PARTLY CLOUDY
    ;      +------- CLEAR
    .byte %11100000
    ;      |||||||+ unused
    ;      ||||||+- unused
    ;      |||||+-- unused
    ;      ||||+--- unused
    ;      |||+---- unused
    ;      ||+----- HAIL STORM
    ;      |+------ THUNDER STORM
    ;      +------- DUST STORM
weatherText:
    .byte ___,_C_,_L_,_E_,_A_,_R_,___,___
    ;かいせい　晴

    .byte ___,_P_,_A_,_R_,_T_,_L_,_Y_,___
    .byte ___,_C_,_L_,_O_,_U_,_D_,_Y_,___
    ;うすぐもり　雲 (ドンドン?)

    .byte ___,_C_,_L_,_O_,_U_,_D_,_Y_,___
    ;くもり　雲

    .byte ___,_R_,_A_,_I_,_N_,_Y_,___,___
    ;あめ　雨

    .byte _D_,_O_,_W_,_N_,_P_,_O_,_U_,_R_
    ;どしゃぶり

    .byte ___,_S_,_N_,_O_,_W_,_I_,_N_,_G_
    ;ゆき

    .byte _B_,_L_,_I_,_Z_,_Z_,_A_,_R_,_D_
    ;ブリザード

    .byte ___,_F_,_O_,_G_,_G_,_Y_,___,___
    ;フォグ


    .byte ___,_D_,_U_,_S_,_T_,___,___,___
    .byte ___,_S_,_T_,_O_,_R_,_M_,___,___
    ;さじんあらし

    .byte ___,_T_,_H_,_U_,_N_,_D_,_E_,_R_
    .byte ___,_S_,_T_,_O_,_R_,_M_,___,___
    ;らいう

    .byte ___,_H_,_A_,_I_,_L_,___,___,___
    .byte ___,_S_,_T_,_O_,_R_,_M_,___,___
    ;ひょうのあらし
    ;11
    .byte ___,___,___,___,___,___,___,___
    ;
    ;12
    .byte ___,___,___,___,___,___,___,___
    ;
    ;13
    .byte ___,___,___,___,___,___,___,___
    ;
    ;14
    .byte ___,___,___,___,___,___,___,___
    ;
    ;15
    .byte ___,___,___,___,___,___,___,___


paceText:
    .byte _S_,_T_,_E_,_A_,_D_,_Y_,___,___,___
    .byte _S_,_T_,_R_,_E_,_N_,_U_,_O_,_U_,_S_
    .byte _G_,_R_,_U_,_E_,_L_,_I_,_N_,_G_,___

rationsText:
    .byte _F_,_I_,_L_,_L_,_I_,_N_,_G_,___,___,___
    .byte _M_,_E_,_A_,_G_,_E_,_R_,___,___,___,___
    .byte _B_,_A_,_R_,_E_,___,_B_,_O_,_N_,_E_,_S_

suppliesText:
    .byte _O_,_X_,_E_,_N_,___,___,___
    .byte _C_,_L_,_O_,_T_,_H_,_E_,_S_
    .byte _B_,_U_,_L_,_L_,_E_,_T_,_S_
    .byte _W_,_H_,_E_,_E_,_L_,_S_,___
    .byte _A_,_X_,_L_,_E_,_S_,___,___
    .byte _T_,_O_,_N_,_G_,_U_,_E_,_S_
    .byte _F_,_O_,_O_,_D_,___,_LB,___

healthText:
    ; GOOD
    ; FAIR
    ; POOR
    ; VERY POOR
    ; DECEASED
    ; FEVER
    ; DYSENTERY
    ; MEASLES
    ; SNAKE BITE
    ; EXHAUSTION
    ; TYPHOID
    ; CHOLERA

; -------Diary messages

; YOU STARTED DOWN THE TRAIL 
;  WITH xx OXEN, xx SETS OF
;  CLOTHING, xxxx BULLETS,
;  x WHEELS, x AXLES, x TONGUES,
;  xxxx l OF FOOD, AND $xxxx.00.


; > MAP
; > STATUS
; > RATIONS
; YOU CHANGED YOUR RATIONS TO 
;  xxxxxxxxxx.
; > TRADE
; YOU BOUGHT xxxxxxxxxxxxx 
;  AT THE STORE.
; > TALK
; > REST
; YOU DECIDE TO REST FOR x DAYS.
; > PACE
; YOU DECIDE TO CHANGE THE PACE
;  TO xxxxxxxxx.
; > HUNT
; YOU DECIDE TO HUNT.
; YOU BROUGHT BACK xxxl OF FOOD
;  AND USED xx BULLETS.
; IF YOU CONTINUE TO HUNT HERE,
;  GAME WILL BECOME SCARCE.
; HUNTING IS NOT ALLOWED HERE,
;  THERE ARE TOO MANY PEOPLE.
; > OPTIONS


; > ATTEMPT TO FORD THE RIVER
; > CAULK THE WAGON AND FLOAT
; YOU CAULK YOUR WAGON AND
;  FLOAT ACROSS.
; > TAKE FERRY FOR $5.00
; YOU CHOSE TO TAKE A FERRY
;  ACROSS THE RIVER.
; > HIRE AN INDIAN TO HELP FOR
;    xxxxxxxxxxxxxxxx
; YOU CHOSE TO HAVE AN INDIAN
;  GUIDE HELP YOU CROSS.

; YOU MADE IT SAFELY ACROSS
;  THE RIVER.


; A THIEF STOLE xxxxxxxxxxxxxxxx
;  FROM YOUR WAGON.
; YOU TOOK THE WRONG TRAIL.
; NO GRASS FOR THE OXEN.
; NO WATER.
; BAD WATER.
; xxxx GOT LOST.
; AN OX IS SICK.
; AN OX DIED.
; THE TRAIL IS IMPASSABLE.
; HEAVY FOG.
; YOU HAD A xxxxxx BREAK BUT
;  WERE ABLE TO FIX IT.
; ROUGH TRAIL.
; YOU FIND SOME WILD FRUIT.
; YOU FOUND xxxxxxxxxxxxxxxxxxxx
;  IN AN ABANDONED WAGON.

; THE TRAIL DIVIDES HERE. WHICH
;  WAY DO YOU WANT TO GO?

; xxxx WAS BITTEN BY A SNAKE.
; xxxx DIED OF A SNAKEBITE.
; xxxx HAS A FEVER.
; xxxx DIED OF A FEVER.
; xxxx HAS THE MEASLES.
; xxxx DIED OF THE MEASLES.
; xxxx IS SUFFERING FROM
;  EXHAUSTION.
; xxxx DIED FROM EXHAUSTION.
; xxxx IS SICK WITH
;  TYPHOID FEVER.
; xxxx DIED OF TYPHOID FEVER.
; xxxx HAS CHOLERA.
; xxxx DIED OF CHOLERA.

; xxxx IS WELL AGAIN.


; YOU HAVE REACHED
;  THE KANSAS RIVER CROSSING.
; YOU HAVE REACHED FORT KEARNEY.
; YOU HAVE REACHED CHIMNEY ROCK.
; YOU HAVE REACHED FORT LARAMIE.
; YOU HAVE REACHED
;  INDEPENDENCE ROCK.
; YOU HAVE REACHED SOUTH PASS.
; >
; >
; YOU DECIDE TO TAKE THE TRAIL
;  TO FORT BRIDGER.
; YOU HAVE REACHED FORT BRIDGER.
; YOU HAVE REACHED
;  THE GREEN RIVER CROSSING.
; YOU HAVE REACHED SODA SPRINGS.
; YOU HAVE REACHED
;  THE SNAKE RIVER CROSSING.
; YOU HAVE REACHED FORT BOISE.
; YOU HAVE REACHED GRANDE RONDE
;  IN THE BLUE MOUNTAINS.
; > HEAD TO FORT WALLA WALLA TO
;    BUY SUPPLIES
; > TAKE THE SHORTCUT TO
;    THE DALLES
; YOU DECIDE TO TAKE THE TRAIL
;  TO THE DALLES.
; YOU HAVE REACHED THE DALLES.
; > TAKE THE BARLOW TOLL ROAD
; YOU DECIDE TO TAKE THE TRAIL
;  TO THE BARLOW TOLL ROAD.
; > RAFT DOWN THE RIVER








;-----------------------------------------------------------
bgAttribute:
    .byte %00000000,%00000000
    .byte %00000000,%00000000
    .byte %00000000,%00000000
    .byte %00000000,%00000000

    .byte %10101010,%10101010
    .byte %10101010,%10101010
    .byte %10101010,%10101010
    .byte %10101010,%10101010 ;^----- terrain/wagon


    .byte %11111111,%11111111 ;v----- HUD
    .byte %11111111,%11111111
    .byte %11111111,%11111111
    .byte %11111111,%11111111

    .byte %11111111,%11111111
    .byte %11111111,%11111111
    .byte %11111111,%11111111
    .byte %11111111,%11111111


    .byte %11111111,%11111111
    .byte %11111111,%11111111
    .byte %11111111,%11111111
    .byte %11111111,%11111111

    .byte %11111111,%11111111
    .byte %11111111,%11111111
    .byte %11111111,%11111111
    .byte %11111111,%11111111


    .byte %11111111,%11111111
    .byte %11111111,%11111111
    .byte %11111111,%11111111
    .byte %11111111,%11111111

    .byte %11111111,%11111111
    .byte %11111111,%11111111
    .byte %11111111,%11111111
    .byte %11111111,%11111111

;-----------------------------------------------------------



;-----------------------------------------------------------
; 76543210  OAM Attributes
; ||||||||
; ||||||++- Palette (4 to 7) of sprite
; |||+++--- Unimplemented (read 0)
; ||+------ Priority (0: in front of background; 1: behind background)
; |+------- Flip sprite horizontally
; +-------- Flip sprite vertically

oxenSprites:
    ; +Y, tile index, attributes, +X
    .byte $1F, $20, $00, $B8 ;$A0 ; tile 0   0 1
    .byte $1F, $21, $00, $C0 ;$A8 ; tile 1   2 3 4 5
    .byte $27, $22, $00, $B8 ;$A0 ; tile 2   6 7 8 9
    .byte $27, $23, $00, $C0 ;$A8 ; tile 3
    .byte $27, $24, $00, $C8 ;$B0 ; tile 4
    .byte $27, $29, $00, $D0 ;$B8 ; tile 5
    .byte $2F, $2B, $00, $B8 ;$A0 ; tile 6
    .byte $2F, $2F, $00, $C0 ;$A8 ; tile 7
    .byte $2F, $34, $00, $C8 ;$B0 ; tile 8
    .byte $2F, $39, $00, $D0 ;$B8 ; tile 9

oxenAnimation:
    ; how much to increment each tile
    ; 76543210
    ; |||||||+- frame 0(unused)
    ; ||||||+-- frame 1
    ; |||||+--- frame 2
    ; ||||+---- frame 3
    ; |||+----- frame 4
    ; ||+------ increment cumulatively y/n
    ; ++------- unused
    .byte %00100000 ; tile 0: 20,20,20,20,20
    .byte %00100000 ; tile 1: 21,21,21,21,21
    .byte %00100000 ; tile 2: 22,22,22,22,22
    .byte %00100000 ; tile 3: 23,23,23,23,23
    .byte %00111110 ; tile 4: 24,25,26,27,28
    .byte %00110000 ; tile 5: 29,29,29,29,2A ! todo %00000010
    .byte %00110110 ; tile 6: 2C,2D,2E,2E,2F
    .byte %00111110 ; tile 7: 30,31,32,33,34
    .byte %00111110 ; tile 8: 35,36,37,38,39
    .byte %00111110 ; tile 9: 3A,3B,3C,3D,3E

wagonSprites:
    ; +Y, tile index, attributes, +X
    .byte $1F, $3E, $00, $D8 ; tile 0   0 1 2 3
    .byte $1F, $3F, $00, $E0 ; tile 1   4 5 6 7
    .byte $1F, $40, $00, $E8 ; tile 2   8 9 A B
    .byte $1F, $41, $00, $F0 ; tile 3
    .byte $27, $42, $00, $D8 ; tile 4
    .byte $27, $43, $00, $E0 ; tile 5 (2 frame animation)
    .byte $27, $45, $00, $E8 ; tile 6 (2 frame animation)
    .byte $27, $47, $00, $F0 ; tile 7 (2 frame animation)
    .byte $2F, $49, $00, $D8 ; tile 8 (2 frame animation)
    .byte $2F, $4B, $00, $E0 ; tile 9 (2 frame animation)
    .byte $2F, $4D, $00, $E8 ; tile A (2 frame animation)
    .byte $2F, $4F, $00, $F0 ; tile B (2 frame animation)
