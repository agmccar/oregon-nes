; Memory addresses
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
CONTROLLER1 = $4016

; Controller buttons
KEY_A       = %10000000
KEY_B       = %01000000
KEY_SELECT  = %00100000
KEY_START   = %00010000
KEY_UP      = %00001000
KEY_DOWN    = %00000100
KEY_LEFT    = %00000010
KEY_RIGHT   = %00000001

; Tile indices of text characters
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
_O_ = 105
_P_ = 94
_Q_ = 95
_R_ = 96
_S_ = 97
_T_ = 98
_U_ = 99
_V_ = 100
_W_ = 101
_X_ = 102
_Y_ = 103
_Z_ = 104
_0_ = 105
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
_LU = 124 ; left/up corner
_LD = 125 ; left/down corner
_RU = 126 ; right/up corner
_RD = 127 ; right/down corner
_LB = 144 ; lb
_MI = 145 ; mi
_DL = 146 ; $
_00 = 147 ; .00
_AL = 148 ; < (arrow left)
_AR = 149 ; > (arrow right)
_UL = 150 ; __ (underline)
_AP = 151 ; ' (apostrophe)
_AU = 152 ; ^ (arrow up)
_AD = 153 ; v (arrow down)

; Length (in characters) of HUD elements
TEXT_MENU_LEN       = 7   ; main menu options
TEXT_PACE_LEN       = 9
TEXT_WEATHER_LEN    = 8   ; per line. total is 8 + (8*weatherTextLineCount)
TEXT_TEMP_LEN       = 4
TEXT_RATIONS_LEN    = 10
TEXT_HEALTH_LEN     = 6
TEXT_FOOD_LEN       = 4
TEXT_TRAVELED_LEN   = 4
TEXT_DATE_LEN       = 12
TEXT_SUPPLIES_LEN   = 7
TEXT_AFFLICTION_LEN = 10
TEXT_OCCUPATION_LEN = 11
TEXT_DIARY_LINE_LEN = 30
TEXT_PERSON_LEN     = 4   ; person name
TEXT_KEYBOARD_LEN   = 11  ; per line
TEXT_STORENAME_LEN  = 12

; Game states
GAMESTATE_TITLE     = 0 ; title screen
GAMESTATE_NEWGAME   = 1 ; set party member names, select occupation
GAMESTATE_STORE     = 2 ; general store interface
GAMESTATE_LANDMARK  = 3 ; at a landmark/town/river/etc
GAMESTATE_MAP       = 4 ; looking at the map
GAMESTATE_TRAVELING = 5 ; main game state - traveling the trail
;GAMESTATE_DECISION  = ?

; Menu states
MENU_NONE               = 0 ; all menus closed
MENU_NEWGAME_TYPING     = 1 ; new game name input 
MENU_NEWGAME_OCCUPATION = 2 ; new game occupation selection menu 
MENU_STORE_ITEM1        = 3 ; 1 digit general store item selection
MENU_STORE_ITEM2        = 4 ; 2 digit general store item selection
MENU_STORE_ITEM4        = 5 ; 4 digit general store item selection

; Locations (landmarks)
; %00000000
;  ||||++++ identifier(index)
;  |||+---- river y/n
;  ||+----- store y/n
;  ++------ unused
LOC_INDEPENDENCE        = %00100000 ; Independence, MO

; Cost
; %00000000
;  |+++++++ number (0-127)
;  +------- unit- 0:dollars, 1:cents 
COST_OXEN       = 20
COST_CLOTHES    = 10
COST_BULLETS    = $81
COST_PARTS      = 10
COST_FOOD_LB    = $82