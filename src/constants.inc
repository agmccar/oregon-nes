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
___ = $FF
_A_ = $D0
_B_ = $D1
_C_ = $D2
_D_ = $D3
_E_ = $D4
_F_ = $D5
_G_ = $D6
_H_ = $D7
_I_ = $D8
_J_ = $D9
_K_ = $DA
_L_ = $DB
_M_ = $DC
_N_ = $DD
_O_ = $E9
_P_ = $DE
_Q_ = $DF
_R_ = $E0
_S_ = $E1
_T_ = $E2
_U_ = $E3
_V_ = $E4
_W_ = $E5
_X_ = $E6
_Y_ = $E7
_Z_ = $E8
_0_ = $E9
_1_ = $EA
_2_ = $EB
_3_ = $EC
_4_ = $ED
_5_ = $EE
_6_ = $EF
_7_ = $F0
_8_ = $F1
_9_ = $F2
_CL = $F3 ; :
_CM = $F4 ; ,
_PD = $F5 ; .
_EX = $F6 ; !
_QU = $F7 ; ?
_PR = $F8 ; hand pointing right
;_PL = 121 ; hand pointing left
_HR = $F9 ; horiz line
_VR = $FA ; vertical line
_LU = $FB ; left/up corner
_LD = $FC ; left/down corner
_RU = $FD ; right/up corner
_RD = $FE ; right/down corner

_LB = 128 ; lb
_MI = 129 ; mi
_DL = 130 ; $
_00 = 131 ; .00
_AL = 132 ; < (arrow left)
_AR = 133 ; > (arrow right)
_UL = 134 ; __ (underline)
_AP = 135 ; ' (apostrophe)
_AU = 136 ; ^ (arrow up)
_AD = 137 ; v (arrow down)
_3U = 138 ; ┬
_3D = 139 ; ┴
_3L = 140 ; ├
_3R = 141 ; ┤
 
; JP tile characters
__WO = $50
_LTU = $51
_LYA = $52
_LYU = $53
_LYO = $54
___A = $55
___I = $56
___U = $57
___E = $58
___O = $59
__KA = $5A
__KI = $5B
__KU = $5C
__KE = $5D
__KO = $5E
__SA = $5F
_SHI = $A0
__SU = $A1
__SE = $A2
__SO = $A3
__TA = $A4
_CHI = $A5
_TSU = $A6
__TE = $A7
__TO = $A8
__NA = $A9
__NI = $AA
__NU = $AB
__NE = $AC
__NO = $AD
__HA = $AE
__HI = $AF
__HU = $B0
__HE = $B1
__HO = $B2
__MA = $B3
__MI = $B4
__MU = $B5
__ME = $B6
__MO = $B7
__YA = $B8
__YU = $B9
__YO = $BA
__RA = $BB
__RI = $BC
__RU = $BD
__RE = $BE
__RO = $BF
__WA = $C0
__NN = $C1
_LAk = $C2
_LIk = $C3
__PD = $C4 ; jp period
_LEk = $C5
_LOk = $C6
_LTUk = $C7
_LYAk = $C8
_LYUk = $C9
_LYOk = $CA
__DT = $CB ; dakuten
_HDT = $CC ; handakuten
_DSH = $CD ; dash
_DDT = $CE ; dot dot
__Ak = $CF ; begin katakana
__Ik = $D0
__Uk = $D1
__Ek = $D2
__Ok = $D3
_KAk = $D4
_KIk = $D5
_KUk = $D6
_KEk = $D7
_KOk = $D8
_SAk = $D9
_SIk = $DA
_SUk = $DB
_SEk = $DC
_SOk = $DD
_TAk = $DE
_TIk = $DF
_TUk = $E0
_TEk = $E1
_TOk = $E2
_NAk = $E3
_NIk = $E4
_NUk = $E5
_NEk = $E6
_NOk = $E7
_HAk = $E8
_HIk = $E9
_HUk = $EA
_HEk = $EB
_HOk = $EC
_MAk = $ED
_MIk = $EE
_MUk = $EF
_MEk = $F0
_MOk = $F1
_YAk = $F2
_YUk = $F3
_YOk = $F4
_RAk = $F5
_RIk = $F6
_RUk = $F7
_REk = $F8
_ROk = $F9
_WAk = $FA
_NNk = $FB
_DOT = $FC ; ・

; other tiles
TILE_GRASS = $ff

; Length (in characters) of HUD elements
TEXT_MAINMENU_LEN   = 19  ; main menu options
TEXT_PACE_LEN       = 9
TEXT_WEATHER_LEN    = 10
TEXT_TEMP_LEN       = 4
TEXT_RATIONS_LEN    = 10
TEXT_HEALTH_LEN     = 9
TEXT_FOOD_LEN       = 4
TEXT_TRAVELED_LEN   = 4
TEXT_DATE_LEN       = 12
TEXT_SUPPLIES_LEN   = 7
TEXT_AFFLICTION_LEN = 10
TEXT_OCCUPATION_LEN = 11
TEXT_POPUP_LINE_LEN = 24
TEXT_PERSON_LEN     = 4   ; person name
TEXT_KEYBOARD_LEN   = 11  ; per line
TEXT_STORENAME_LEN  = 12
TEXT_STARTDATE_LEN  = 6

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
MENU_NEWGAME_OCCUPATION = 2 ; new game occupation selection 
MENU_NEWGAME_STARTDATE  = 3 ; new game starting month selection
MENU_STORE_ITEM1        = 4 ; 1 digit general store item selection
MENU_STORE_ITEM2        = 5 ; 2 digit general store item selection
MENU_STORE_ITEM4        = 6 ; 4 digit general store item selection
MENU_MAINMENU           = 7 ; main "Map, Status, Rations.." menu
MENU_SUPPLIES           = 8
MENU_PACE               = 9
MENU_RATIONS            = 10
MENU_REST               = 11
MENU_TEXTPOPUP          = 12

OPT_CONTINUE    = 0
OPT_SUPPLIES    = 1
OPT_MAP         = 2
OPT_PACE        = 3
OPT_RATIONS     = 4
OPT_REST        = 5
OPT_TRADE       = 6
OPT_HUNT        = 7
OPT_TALK        = 8

; Locations (landmarks)
; %00000000
;  |||+++++ identifier(index)
;  ||+----- trail divides(?) unused for now
;  |+------ river y/n
;  +------- store y/n
LOC_INDEPENDENCE        = %10000000 ; Independence, MO
LOC_KANSASRIVER         = %01000001 ; KANSAS RIVER CROSSING
LOC_BIGBLUERIVER        = %01000010 ; BIG BLUE RIVER CROSSING
LOC_FORTKEARNEY         = %10000011 ; FORT KEARNEY
LOC_CHIMNEYROCK         = %00000100 ; CHIMNEY ROCK
LOC_FORTLARAMIE         = %10000101 ; FORT LARAMIE
LOC_INDEPENDENCEROCK    = %00000110 ; INDEPENDENCE ROCK
LOC_SOUTHPASS           = %00000111 ; SOUTH PASS
LOC_FORTBRIDGER         = %10001000 ; FORT BRIDGER
LOC_GREENRIVER          = %01001001 ; GREEN RIVER CROSSING
LOC_SODASPRINGS         = %00001010 ; SODA SPRINGS
LOC_FORTHALL            = %10001011 ; FORT HALL
LOC_SNAKERIVER          = %01001100 ; SNAKE RIVER CROSSING
LOC_FORTBOISE           = %10001101 ; FORT BOISE
LOC_BLUEMOUNTAINS       = %00001110 ; BLUE MOUNTAINS
LOC_FORTWALLAWALLA      = %10001111 ; FORT WALLA WALLA
LOC_THEDALLES           = %00010000 ; THE DALLES
LOC_WILLAMETTE          = %00010001 ; WILLAMETTE VALLEY

; Cost
; %00000000
;  |+++++++ number (0-127)
;  +------- unit- 0:dollars, 1:cents 
COST_OXEN       = 20
COST_CLOTHES    = 10
COST_BULLETS    = $81
COST_PARTS      = 10
COST_FOOD_LB    = $82

; Events (stuff happens/text pops up)
EVENT_NONE = 0
EVENT_NEXT_LANDMARK = 1 ; "It is xxx miles to yyyy" popup