; Memory addresses
ZEROSPRITE      = $0200
TRAILSPRITES    = ZEROSPRITE+4 ; TODO: don't hardcode OAM addresses: https://www.nesdev.org/wiki/Don%27t_hardcode_OAM_addresses
; OXENSPRITES     = ZEROSPRITE+4
; WAGONSPRITES    = OXENSPRITES+40
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

_LB = 128+64 ; lb
_MI = 129+64 ; mi
_DL = 130+64 ; $
_00 = 131+64 ; .00
_AL = 132+64 ; < (arrow left)
_AR = 133+64 ; > (arrow right)
_UL = 134+64 ; __ (underline)
_AP = 135+64 ; ' (apostrophe)
_AU = 136+64 ; ^ (arrow up)
_AD = 137+64 ; v (arrow down)
; _3U = 138+64 ; ┬
; _3D = 139+64 ; ┴
; _3L = 140+64 ; ├
; _3R = 141+64 ; ┤
_HY = $ca ; -
_QT = $cb ; "
_SC = $cc ; ;
_EL = $cd ; …
_OP = $ce ; (
_CP = $cf ; )
 
; other tiles
TILE_GRASS = $ff
TILE_DARK_SQ = $1c ; dark square if "adornment" is loaded into pattern B
TILE_LIGHT_SQ = $1d ; light square "
TILE_COL_HEADER = $48 ; hack to improve some column headers' readability

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
TEXT_KEYBOARD_LEN   = 10  ; per line
TEXT_STORENAME_LEN  = 12
TEXT_STARTDATE_LEN  = 6
TEXT_NAME_LEN       = 8

; keyboardKey "Done" button index
KEYBOARD_DONE = (TEXT_KEYBOARD_LEN*3)-2

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
MENU_TITLE_LEARN        = 16 ; "Learn about the trail" menu
MENU_TITLE_TOPTEN       = 17 ; The Oregon Top Ten
MENU_TITLE_SOUND        = 18 ; Sound option screen
MENU_NEWGAME_TYPING     = 1 ; new game name input 
MENU_NEWGAME_OCCUPATION = 2 ; new game occupation selection 
MENU_NEWGAME_OCC_HELP   = 19 ; new game occupation explanation screen
MENU_NEWGAME_NAMEPARTY  = 20 ; new game name party screen
MENU_NEWGAME_NAMESCORRECT = 21 ; "Are these names correct?"
MENU_NEWGAME_STARTDATE  = 3 ; new game starting month selection
MENU_NEWGAME_GOINGBACK  = 24 ; "Going back to 1848..."
MENU_NEWGAME_DATE_HELP  = 22 ; "Ask for advice" on starting month selection
MENU_NEWGAME_MATT_INTRO = 23
MENU_NEWGAME_BEFORELEAVING1 = 25 ; "Before leaving..."
MENU_NEWGAME_BEFORELEAVING2 = 26 ; "You can buy whatever you need..."
MENU_STORE_ITEM1        = 4 ; 1 digit general store item selection
MENU_STORE_ITEM2        = 5 ; 2 digit general store item selection
MENU_STORE_ITEM4        = 6 ; 4 digit general store item selection
MENU_MAINMENU           = 7 ; main "Map, Status, Rations.." menu
MENU_SUPPLIES           = 8 ; looking at current list of supplies
MENU_PACE               = 9 ; changing wagon pace
MENU_RATIONS            = 10 ; changing rations
MENU_REST               = 11 ; selecting how many days to rest
MENU_TEXTPOPUP          = 12 ; a text popup is visible
MENU_MAP                = 13 ; looking at the map
MENU_TALK               = 14 ; talking to a person, press start
MENU_TEXTPOPUP_YN       = 15 ; text pop up with Yes or No options

OPT_CONTINUE    = 0
OPT_SUPPLIES    = 1
OPT_MAP         = 2
OPT_PACE        = 3
OPT_RATIONS     = 4
OPT_REST        = 5
OPT_TRADE       = 6
OPT_HUNT        = 7
OPT_TALK        = 8

; Location indices
LOC_INDEPENDENCE        = 0
LOC_KANSASRIVER         = 1
LOC_BIGBLUERIVER        = 2
LOC_FORTKEARNEY         = 3
LOC_CHIMNEYROCK         = 4
LOC_FORTLARAMIE         = 5
LOC_INDEPENDENCEROCK    = 6
LOC_SOUTHPASS           = 7
LOC_FORTBRIDGER         = 8
LOC_GREENRIVER          = 9
LOC_SODASPRINGS         = 10
LOC_FORTHALL            = 11
LOC_SNAKERIVER          = 12
LOC_FORTBOISE           = 13
LOC_BLUEMOUNTAINS       = 14
LOC_FORTWALLAWALLA      = 15
LOC_THEDALLES           = 16
LOC_WILLAMETTE          = 17

SHORTCUT_DISTANCE = 125 ; miles. South Pass to Green River and Blue Mountains to The Dalles

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
EVENT_NONE              = 0
EVENT_NEXT_LANDMARK     = 1 ; "It is xxx miles to yyyy"
EVENT_REACHED_LANDMARK  = 2 ; "you have reached yyyy"
EVENT_LOOK_AROUND       = 27 ; "Would you like to look around"
EVENT_LOAD_LANDMARK     = 26 ; change game state
EVENT_INDIAN_FOOD       = 3
EVENT_THUNDERSTORM      = 4
EVENT_BLIZZARD          = 5
EVENT_HEAVY_FOG         = 6
EVENT_HAIL_STORM        = 7
EVENT_INJURED_OX        = 8
EVENT_INJURED_PERSON    = 9
EVENT_SNAKE_BITE        = 10
EVENT_LOSE_TRAIL        = 11
EVENT_WRONG_TRAIL       = 12
EVENT_ROUGH_TRAIL       = 13
EVENT_IMPASSIBLE_TRAIL  = 14
EVENT_WILD_FRUIT        = 15
EVENT_FIRE_WAGON        = 16
EVENT_LOST_PERSON       = 17
EVENT_OX_WANDERS_OFF    = 18
EVENT_ABANDONED_WAGON   = 19
EVENT_THIEF             = 20
EVENT_BAD_WATER         = 21
EVENT_LITTLE_WATER      = 22
EVENT_INADEQUATE_GRASS  = 23
EVENT_ILLNESS           = 24
EVENT_BROKEN_PART       = 25

; weatherText index
WEATHER_VERY_COLD = 0
WEATHER_COLD = 1
WEATHER_COOL = 2
WEATHER_WARM = 3
WEATHER_HOT = 4
WEATHER_VERY_HOT = 5
WEATHER_RAINY = 6
WEATHER_VERY_RAINY = 7
WEATHER_SNOWY = 8
WEATHER_VERY_SNOWY = 9

; Colors
C_BLACK = $0F
C_WHITE = $30
C_PINK = $24
C_ORANGE = $26
C_GREY = $00
C_BLUE = $21
C_GREEN = $2A
C_LGREY = $10
C_MONO = $0B

; talk text 
LITERAL_CHAR = $d0 ; see data/compressed/text/dictionary.asm
