;Poop := $412

ZEROSPRITE      = $0200
OXENSPRITES     = ZEROSPRITE+4
WAGONSPRITES    = OXENSPRITES+40

PPUCTRL     = $2000
PPUMASK     = $2001
PPUSTATUS   = $2002
PPUSCROLL   = $2005
PPUADDR     = $2006
PPUDATA     = $2007

OAMADDR     = $2003
OAMDMA      = $4014

DMCFREQ     = $4010

KEY_A       = %10000000
KEY_B       = %01000000
KEY_SELECT  = %00100000
KEY_START   = %00010000
KEY_UP      = %00001000
KEY_DOWN    = %00000100
KEY_LEFT    = %00000010
KEY_RIGHT   = %00000001

___ = 32
_A_ = 80
_B_ = 81
_C_ = 82
_D_ = 83
_E_ = 84
_F_ = 85
_G_ = 86
_H_ = 87
_I_ = 88
_J_ = 89
_K_ = 90
_L_ = 91
_M_ = 92
_N_ = 93
_O_ = 94
_P_ = 95
_Q_ = 96
_R_ = 97
_S_ = 98
_T_ = 99
_U_ = 100
_V_ = 101
_W_ = 102
_X_ = 103
_Y_ = 104
_Z_ = 105
_0_ = 94
_1_ = 106
_2_ = 107
_3_ = 108
_4_ = 109
_5_ = 110
_6_ = 111
_7_ = 112
_8_ = 113
_9_ = 114
_CL = 115 ; :
_CM = 116 ; ,
_PD = 117 ; .
_EX = 118 ; !
_QU = 119 ; ?
_PR = 120 ; hand pointing right
_PL = 121 ; hand pointing left
_HR = 122 ; horiz line
_VR = 123 ; vertical line
_LB = 144 ; lb
_MI = 145 ; mi

;------Text stuff
TEXT_PACE_LEN = 9
TEXT_WEATHER_LEN = 8 ; per line. total is 8 + (8*weatherTextLineCount)
TEXT_TEMP_LEN = 4 
TEXT_RATIONS_LEN = 10



;; BG index is relative 
DATE_BG_IDX  = 50 ; hud1
; JAN
; FEB
; MAR
; APR
; MAY
; JUN
; JUL
; AUG
; SEP
; OCT
; NOV
; DEC

; 2019年 2月 17日


;


