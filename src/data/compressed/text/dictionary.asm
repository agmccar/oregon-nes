; First header byte:
; %00000000
;  ||||++++ Type of punctiation- {' ': 0, ',': 1, '.': 2, '!': 3, '?': 4}
;  ++++---- Remaining length of header

; (2nd - nth) header bytes:
; Every nibble is the length of a word.
; %00000000, %00000000,...
;  ++++--------------- Length of first word
;      ++++----------- Length of 2nd word
;             ++++---- Length of 3rd word
;                 ++++ Length of 4th word, etc.

; Data segment bytes:
; $00      : End of entire section
; $01 - $d1: Dictionary
; $d2 - $eb: Literal A-Z
; $ec - $f5: Literal special chars: ["'", '-', '"', ';', ':', '.', ',', '…', '(', ')']
; $f6 - $ff: Unused

talkSpecialChar:
    .byte _AP,_HY,_QT,_SC,_CL,_PD,_CM,_0_,_1_,_2_,_4_,_6_,_7_,_EL,_OP,_CP

talkTellsYou:
    .byte _T_,_E_,_L_,_L_,_S_,___,_Y_,_O_,_U_,_CL

talkDictionary:
    ; range: $01 - $d1
    .byte _T_,_H_
    .byte _E_,_R_
    .byte _I_,_N_
    .byte _A_,_N_
    .byte _O_,_U_
    .byte _E_,_S_
    .byte _O_,_R_
    .byte _T_,_O_
    .byte _O_,_N_
    .byte _E_,_A_
    .byte _L_,_L_
    .byte _E_,_N_
    .byte _E_,_D_
    .byte _A_,_R_
    .byte _E_,_M_
    .byte _I_,_S_
    .byte _E_,_T_
    .byte _W_,_A_
    .byte _S_,_T_
    .byte _I_,_T_
    .byte _R_,_O_
    .byte _E_,_C_
    .byte _I_,_V_
    .byte _O_,_F_
    .byte _R_,_A_
    .byte _E_,_P_
    .byte _W_,_I_
    .byte _S_,_S_
    .byte _T_,_A_
    .byte _G_,_H_
    .byte _E_,_L_
    .byte _E_,_Y_
    .byte _E_,_G_
    .byte _I_,_L_
    .byte _A_,_T_
    .byte _C_,_H_
    .byte _W_,_H_
    .byte _E_,_F_
    .byte _N_,_O_
    .byte _A_,_L_
    .byte _A_,_M_
    .byte _W_,_E_
    .byte _B_,_U_
    .byte _O_,_O_
    .byte _I_,_M_
    .byte _D_,_I_
    .byte _A_,_Y_
    .byte _P_,_L_
    .byte _O_,_L_
    .byte _C_,_K_
    .byte _T_,_S_
    .byte _H_,_A_
    .byte _O_,_M_
    .byte _E_,_V_
    .byte _U_,_N_
    .byte _O_,_W_
    .byte _I_,_F_
    .byte _U_,_S_
    .byte _G_,_A_
    .byte _I_,_R_
    .byte _I_,_D_
    .byte _R_,_Y_
    .byte _M_,_Y_
    .byte _A_,_K_
    .byte _E_,_B_
    .byte _S_,_H_
    .byte _U_,_P_
    .byte _A_,_S_
    .byte _E_,_W_
    .byte _O_,_V_
    .byte _A_,_B_
    .byte _R_,_E_
    .byte _F_,_F_
    .byte _D_,_S_
    .byte _A_,_C_
    .byte _T_,_Y_
    .byte _B_,_Y_
    .byte _D_,_R_
    .byte _I_,_C_
    .byte _R_,_N_
    .byte _O_,_S_
    .byte _A_,_F_
    .byte _L_,_O_
    .byte _A_,_D_
    .byte _S_,_I_
    .byte _K_,_E_
    .byte _S_,_F_
    .byte _B_,_L_
    .byte _P_,_E_
    .byte _D_,_F_
    .byte _G_,_S_
    .byte _U_,_L_
    .byte _G_,_E_
    .byte _S_,_M_
    .byte _T_,_L_
    .byte _R_,_I_
    .byte _T_,_I_
    .byte _D_,_L_
    .byte _D_,_H_
    .byte _U_,_R_
    .byte _U_,_M_
    .byte _T_,_B_
    .byte _L_,_D_
    .byte _T_,_G_
    .byte _C_,_E_
    .byte _P_,_R_
    .byte _W_,_N_
    .byte _E_,_X_
    .byte _D_,_E_
    .byte _T_,_R_
    .byte _V_,_E_
    .byte _D_,_O_
    .byte _T_,_M_
    .byte _N_,_I_
    .byte _V_,_A_
    .byte _S_,_B_
    .byte _J_,_U_
    .byte _T_,_W_
    .byte _E_,_I_
    .byte _D_,_Y_
    .byte _T_,_F_
    .byte _T_,_C_
    .byte _D_,_A_
    .byte _Y_,_F_
    .byte _E_,_H_
    .byte _S_,_N_
    .byte _S_,_L_
    .byte _G_,_D_
    .byte _S_,_O_
    .byte _G_,_U_
    .byte _C_,_A_
    .byte _O_,_T_
    .byte _R_,_S_
    .byte _M_,_I_
    .byte _A_,_V_
    .byte _O_,_P_
    .byte _E_,_O_
    .byte _S_,_P_
    .byte _E_,_E_
    .byte _N_,_D_
    .byte _P_,_A_
    .byte _F_,_A_
    .byte _D_,_W_
    .byte _I_,_G_
    .byte _F_,_I_
    .byte _B_,_I_
    .byte _Y_,_M_
    .byte _F_,_U_
    .byte _F_,_R_
    .byte _H_,_O_
    .byte _T_,_T_
    .byte _B_,_O_
    .byte _L_,_I_
    .byte _D_,_M_
    .byte _Q_,_U_
    .byte _A_,_W_
    .byte _Y_,_D_
    .byte _O_,_H_
    .byte _S_,_G_
    .byte _L_,_A_
    .byte _P_,_I_
    .byte _E_,_J_
    .byte _M_,_S_
    .byte _D_,_B_
    .byte _M_,_O_
    .byte _X_,_I_
    .byte _L_,_Y_
    .byte _K_,_I_
    .byte _D_,_D_
    .byte _S_,_W_
    .byte _R_,_H_
    .byte _U_,_T_
    .byte _K_,_S_
    .byte _O_,_D_
    .byte _R_,_D_
    .byte _F_,_T_
    .byte _D_,_U_
    .byte _D_,_C_
    .byte _G_,_T_
    .byte _P_,_T_
    .byte _T_,_U_
    .byte _M_,_P_
    .byte _M_,_U_
    .byte _S_,_A_
    .byte _T_,_P_
    .byte _T_,_K_
    .byte _M_,_F_
    .byte _B_,_E_
    .byte _I_,_H_
    .byte _R_,_T_
    .byte _Y_,_S_
    .byte _S_,_E_
    .byte _E_,_K_
    .byte _K_,_F_
    .byte _P_,_P_
    .byte _T_,_N_
    .byte _B_,_A_
    .byte _J_,_O_
    .byte _M_,_L_
    .byte _Y_,_H_
    .byte _B_,_R_
    .byte _M_,_A_
    .byte _D_,_N_
    .byte _G_,_F_
    .byte _Y_,_C_
    .byte _K_,_H_
    .byte _M_,_R_
    .byte _S_,_R_
    .byte _T_,_E_

