
.proc LoadBgTraveling
    JSR ClearScreen
    JSR ClearAttributes ; default palette
    SBD
    LoadCHR #<textTilesMeta, #>textTilesMeta
    LDA menuOpen
    CMP #MENU_MAINMENU
    BNE :+
        JSR DrawHUDMainMenu
        JMP Done
    :
    CMP #MENU_NONE
    BNE :+
    JMP @menuNone
    :
    @menuNone:
        LoadCHR #<wagonTilesMeta, #>wagonTilesMeta
        LDA location
        CMP #LOC_FORTLARAMIE
        BCS :+
        LoadCHR #<horizonPlainsTilesMeta, #>horizonPlainsTilesMeta
        LoadImage #<horizonPlainsImageMeta, #>horizonPlainsImageMeta
        JMP :++
        :
        LoadCHR #<horizonMountainsTilesMeta, #>horizonMountainsTilesMeta
        LoadImage #<horizonMountainsImageMeta, #>horizonMountainsImageMeta
        :
        PPU #$23, #$c8
        LDX #24
        LDA #%10101010
        :
        STA PPUDATA
        DEX
        BNE :-
        PPU #$21, #$40
        LDX #0 ; draw ground
        LDA #TILE_GRASS
        :
        STA PPUDATA
        INX
        BNE :-
        JSR BufferDrawTravelingAttr
        JSR BufferDrawSizeUpSituation
        JSR BufferDrawTravelingHUD
        JSR BufferDrawTravelingHUDValues
        JSR BufferDrawPressStart
        JSR BufferDrawWagon
    Done:
    EBD
    RTS
.endproc

.proc DrawHUDMainMenu
    LDX #0  ; draw landmark text
    LDY #2
    JSR SetPpuAddrPointerFromXY
    JSR DrawLandmarkTitle

    PPU #$23, #$c8 ; attributes
    LDA #$7f
    STA PPUDATA
    LDA #$5f
    LDX #6
    :
    STA PPUDATA
    DEX
    BNE :-
    LDA #$df
    STA PPUDATA
    LDA #$77
    STA PPUDATA
    LDA #$55
    LDX #6
    :
    STA PPUDATA
    DEX
    BNE :-
    LDA #$dd
    STA PPUDATA

    PPU #$20, #$c0 ; white box
    LDA #___
    LDX #$20*6
    :
    STA PPUDATA
    DEX
    BNE :-
    
    PPU #$20, #$e3 ; "Weather:"
    LDX #0 
    :
    LDA hudMenuStatusText, X
    STA PPUDATA
    INX
    CPX #8
    BNE :-
    PPU #$21, #$04 ; "Health:"
    :
    LDA hudMenuStatusText, X
    STA PPUDATA
    INX
    CPX #15
    BNE :-
    PPU #$21, #$26 ; "Pace:"
    :
    LDA hudMenuStatusText, X
    STA PPUDATA
    INX
    CPX #20
    BNE :-
    PPU #$21, #$43 ; "Rations:"
    :
    LDA hudMenuStatusText, X
    STA PPUDATA
    INX
    CPX #28
    BNE :-
    JSR UpdateMainMenuHUDValues

    PPU #$21, #$a2 ; "You may:"
    LDX #1
    :
    LDA whatIsYourChoiceText, X
    STA PPUDATA
    INX
    CPX #9
    BNE :-

    ; Continue on trail
    BDrawText travelingPointer+34, travelingPointer+35, #$22, #$06
    ; Check supplies
    BDrawText travelingPointer+36, travelingPointer+37, #$22, #$26
    ; Look at map
    BDrawText travelingPointer+38, travelingPointer+39, #$22, #$46
    ; Change pace
    BDrawText travelingPointer, travelingPointer+1, #$22, #$66
    ; Change food rations
    BDrawText travelingPointer+20, travelingPointer+21, #$22, #$86
    ; Stop to rest
    BDrawText travelingPointer+30, travelingPointer+31, #$22, #$a6
    ; Attempt to trade
    BDrawText travelingPointer+40, travelingPointer+41, #$22, #$c6
    LDA wagonAtLandmark
    BEQ :+
    ; Talk to people
    BDrawText travelingPointer+44, travelingPointer+45, #$22, #$e6
    LDX location
    LDA landmarkAttr, X
    BPL :++
    ; Buy supplies
    BDrawText travelingPointer+46, travelingPointer+47, #$23, #$06
    JMP :++
    :
    ; Hunt for food
    BDrawText travelingPointer+42, travelingPointer+43, #$22, #$e6
    :

    PPU #$23, #$62 ; "What is your choice?"
    LDX #10
    :
    LDA whatIsYourChoiceText, X
    STA PPUDATA
    INX
    CPX #30
    BNE :-

    RTS
.endproc

.proc LoadBgMap
    JSR ClearScreen
    JSR ClearAttributes
    SBD
    
    LoadCHR #<trailSpritesTilesMeta, #>trailSpritesTilesMeta
    LoadCHR #<mapTilesMeta, #>mapTilesMeta
    LoadImage #<mapImageMeta, #>mapImageMeta
    
    LDA PPUSTATUS ; map palette
    LDA #$3F
    STA PPUADDR
    LDA #$00
    STA PPUADDR
    LDX #0
    :
    LDA gameSettings
    AND #1
    BNE :+
    LDA mapPalette, X
    JMP :++
    :
    LDA mapPaletteMono, X
    :
    STA PPUDATA
    INX
    CPX #$20
    BNE :---

    LDA PPUSTATUS ; draw letterbox (top)
    LDA #$20
    STA PPUADDR
    LDA #$00
    STA PPUADDR
    LDX #$40
    LDA #___
    :
    STA PPUDATA
    DEX
    BNE :-
    LDA PPUSTATUS ; draw letterbox (bottom)
    LDA #$23
    STA PPUADDR
    LDA #$40
    STA PPUADDR
    LDX #0
    LDA #___
    :
    STA PPUDATA
    INX
    CPX #$80
    BNE :-
    LDA PPUSTATUS ; attribute table
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR
    LDA #$05
    LDX #8
    :
    STA PPUDATA
    DEX
    BNE :-
    LDA #$00
    LDX #5*8
    :
    STA PPUDATA
    DEX
    BNE :-
    LDA #$50
    LDX #8
    :
    STA PPUDATA
    DEX
    BNE :-
    LDA #$55
    LDX #8
    :
    STA PPUDATA
    DEX
    BNE :-

    ; LDA helper2 ; set attribute table
    ; STA pointer
    ; LDA helper2+1
    ; STA pointer+1
    ; LDA #$00
    ; STA counter
    ; LDA #$03
    ; STA counter+1
    ; LDA PPUSTATUS
    ; LDA #$20
    ; STA PPUADDR
    ; LDA #$40
    ; STA PPUADDR
    ; JSR UnpackData
    
    EBD
    JSR BufferDrawMapTitle
    JSR LoadTrailSprites
    JSR BufferDrawPressStart
    RTS
.endproc

.proc LoadBgTalk
    JSR ClearScreen
    JSR ClearAttributes
    SBD
    JSR DrawAdornments
    EBD
    JSR BufferDrawTalkText
    JSR BufferDrawPressStart
    RTS
.endproc

.proc LoadBgSupplies
    JSR ClearScreen
    JSR ClearAttributes ; default palette
    SBD
    LDX #16
    LDY #2
    JSR SetPpuAddrPointerFromXY
    LDA PPUSTATUS
    LDA pointer
    STA PPUADDR
    LDA pointer+1
    STA PPUADDR
    LDX #28
    :
    LDA hudMenuStatusText, X
    STA PPUDATA
    INX
    CPX #41
    BNE :-

    ; tile chr
    ; LoadCHR #<suppliesTilesMeta, #>suppliesTilesMeta
    LoadCHR #<suppliesFoodTilesMeta, #>suppliesFoodTilesMeta
    LoadCHR #<suppliesPartsTilesMeta, #>suppliesPartsTilesMeta
    LoadCHR #<suppliesOxenTilesMeta, #>suppliesOxenTilesMeta
    LoadCHR #<suppliesClothesTilesMeta, #>suppliesClothesTilesMeta
    LoadCHR #<suppliesBulletsTilesMeta, #>suppliesBulletsTilesMeta

    LDA PPUSTATUS ; attributes
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR
    LDX #0
    :
    LDA suppliesAttr, X
    STA PPUDATA
    INX
    CPX #7*8
    BNE :-

    EBD
    JSR BufferDrawSupplies
    JSR BufferDrawPressStart
    RTS
.endproc

.proc GamepadTraveling
    LDA menuOpen
    CMP #MENU_MAINMENU
    BEQ :+
    CMP #MENU_NONE
    BEQ :+
    JMP :++
    :
    LDA wagonRest ; wait until no longer resting
    BEQ :+
    RTS
    :
    LDA buttons1
    CMP buttons1Last
    BNE CheckA
    RTS
    CheckA:
        LDA #KEY_A
        BIT buttons1
        BNE :+
        JMP CheckB
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
            ; LDA #MENU_TEXTPOPUP
            ; STA menuOpen ; testing popup window
            LDA #MENU_MAINMENU
            STA menuOpen
            LDA #0
            STA menuCursor
            RTS
        :
        CMP #MENU_MAINMENU
        BNE :+
        JMP @menuMain
        :
        CMP #MENU_MAP
        BNE :+
            JSR CloseSubmenu
            LDA #MENU_MAINMENU
            STA menuOpen
            RTS
        :
        CMP #MENU_PACE
        BNE :++
            LDA menuCursor
            BNE :+
            LDA #MENU_PACE_HELP
            STA menuOpen
            LDA #4
            STA menuCursor
            RTS
            :
            LDA menuCursor
            STA wagonPace
            LDA #3
            STA menuCursor
            LDA #19
            STA fingerY
            LDA #MENU_MAINMENU
            STA menuOpen
            RTS
        :
        CMP #MENU_RATIONS
        BNE :+
            LDA menuCursor
            STA wagonRations
            LDA #4
            STA menuCursor
            LDA #20
            STA fingerY
            LDA #MENU_MAINMENU
            STA menuOpen
            RTS
        :
        CMP #MENU_REST
        BNE :+
            JSR CloseSubmenu
            LDA #MENU_MAINMENU
            STA menuOpen
            RTS
        :
        CMP #MENU_TALK
        BNE :+
            LDA #MENU_MAINMENU
            STA menuOpen
            RTS
        :
        CMP #MENU_TEXTPOPUP
        BNE :+
            JSR CloseTextPopup
            LDA #MENU_NONE
            STA menuOpen
            RTS
        :
        CMP #MENU_TEXTPOPUP_YN
        BNE :+
            JSR CloseTextPopup
            LDA #MENU_NONE
            STA menuOpen
            LDA #EVENT_LOAD_LANDMARK ; if yes selected
            JSR QueueEvent
            RTS
        :
        CMP #MENU_PACE_HELP
        BNE :++
            LDA menuCursor
            CMP #4
            BNE :+
            INC menuCursor
            JSR LoadBgPaceHelp
            RTS
            :
            LDA #MENU_PACE
            STA menuOpen
            RTS 
        :
        RTS
        @menuMain:
            LDA menuCursor
            CMP #OPT_CONTINUE
            BNE :+
            LDA #MENU_NONE
            STA menuOpen
            RTS
            :
            CMP #OPT_SUPPLIES
            BNE :+
            LDA #MENU_SUPPLIES
            STA menuOpen
            RTS
            :
            CMP #OPT_MAP
            BNE :+
            LDA #MENU_MAP
            STA menuOpen
            RTS
            :
            CMP #OPT_PACE
            BNE :+
            LDA #MENU_PACE
            STA menuOpen
            RTS
            :
            CMP #OPT_RATIONS
            BNE :+
            LDA #MENU_RATIONS
            STA menuOpen
            RTS
            :
            CMP #OPT_REST
            BNE :+
            LDA #MENU_REST
            STA menuOpen
            RTS
            :
            CMP #OPT_TALK
            BNE :+
            LDA #MENU_TALK
            STA menuOpen
            RTS
            :
            RTS
        ; @menuOther:
        ; JSR CloseSubmenu...
    CheckB:
    CheckSelect:
        LDA #KEY_SELECT
        BIT buttons1
        BNE :+
        JMP CheckStart
        :
        RTS
    CheckStart:
        LDA #KEY_START
        BIT buttons1
        BNE :+
        JMP CheckUp
        :
        LDA menuOpen
        CMP #MENU_SUPPLIES
        BNE :+
        LDA #MENU_MAINMENU
        STA menuOpen
        RTS
        :
        RTS
    CheckUp:
        LDA #KEY_UP
        BIT buttons1
        BNE :+
        JMP CheckDown
        :
        LDA menuOpen
        CMP #MENU_MAINMENU
        BNE :++
            DEC menuCursor
            LDX fingerY
            DEX
            CPX #15 ; check if fingerY is past top of menu
            BNE :+
            LDX #24 ; wrap to bottom of menu
            LDA #8
            STA menuCursor
            :
            STX fingerY
            RTS
        :
        CMP #MENU_PACE
        BNE :+++
            DEC menuCursor
            LDX fingerY
            DEX
            DEX
            CPX #17
            BNE :+
            LDA #3
            STA menuCursor
            JMP :++
            :
            CPX #11 ; check if fingerY is past top of menu
            BNE :+
            LDX #19 ; wrap to bottom of menu
            LDA #0
            STA menuCursor
            :
            STX fingerY
            RTS
        :
        CMP #MENU_RATIONS
        BNE :++
            INC menuCursor
            LDX fingerY
            DEX
            DEX
            DEX
            CPX #11 ; check if fingerY is past top of menu
            BNE :+
            LDX #20 ; wrap to bottom of menu
            LDA #RATIONS_BARE_BONES
            STA menuCursor
            :
            STX fingerY
            RTS
        :
        CMP #MENU_REST
        BNE :++
            INC wagonRest
            LDA wagonRest
            CMP #10
            BNE :+
            LDA #1
            STA wagonRest
            :
            LDA wagonRest
            CLC
            ADC #_0_
            LDX fingerX
            LDY fingerY
            WTB
            JSR DrawRestSubmenu
            JSR RedrawFinger
            RTS
        :
        RTS
    CheckDown:
        LDA #KEY_DOWN
        BIT buttons1
        BNE :+
        JMP CheckLeft
        :
        LDA menuOpen
        CMP #MENU_MAINMENU
        BNE :++
            INC menuCursor
            LDX fingerY
            INX
            CPX #25 ; check if fingerY is past bottom of menu
            BNE :+
            LDX #16 ; wrap to top of menu
            LDA #0
            STA menuCursor
            :
            STX fingerY
            RTS
        :
        CMP #MENU_PACE
        BNE :+++
            INC menuCursor
            LDX fingerY
            INX
            INX
            CPX #19
            BNE :+
            LDA #0
            STA menuCursor
            JMP :++
            :
            CPX #21 ; check if fingerY is past bottom of menu
            BNE :+
            LDX #13 ; wrap to top of menu
            LDA #1
            STA menuCursor
            :
            STX fingerY
            RTS
        :
        CMP #MENU_RATIONS
        BNE :++
            DEC menuCursor
            LDX fingerY
            INX
            INX
            INX
            CPX #23 ; check if fingerY is past bottom of menu
            BNE :+
            LDX #14 ; wrap to top of menu
            LDA #RATIONS_FILLING
            STA menuCursor
            :
            STX fingerY
            RTS
        :
        CMP #MENU_REST
        BNE :++
            DEC wagonRest
            LDA wagonRest
            BNE :+
            LDA #9
            STA wagonRest
            :
            LDA wagonRest
            CLC
            ADC #_0_
            LDX fingerX
            LDY fingerY
            WTB
            JSR DrawRestSubmenu
            JSR RedrawFinger
            RTS
        :
        RTS
    CheckLeft:
    CheckRight:
    RTS
.endproc

.proc GamepadMap
    RTS
.endproc

.proc LoadBgPaceHelp
    JSR ClearScreen
    JSR ClearAttributes
    LDA menuCursor
    CMP #4
    BNE :+
    BDrawText travelingPointer+14, travelingPointer+15, #$20, #$84
    BDrawText travelingPointer+16, travelingPointer+17, #$21, #$44
    JMP :++
    :
    BDrawText travelingPointer+18, travelingPointer+19, #$20, #$84
    :
    JSR BufferDrawPressStart
    RTS
.endproc

.proc LoadBgPace
    JSR ClearScreen
    JSR ClearAttributes
    SBD
    JSR DrawAdornments
    EBD

    ; Change pace
    BDrawText travelingPointer+0, travelingPointer+1, #$20, #$ca
    ; (currently "$pace")
    BDrawText travelingPointer+2, travelingPointer+3, #$20, #$e5
    LDA wagonPace
    CMP #1
    BNE :+
    LDA #9 ; strlen('"steady")')
    LDY #TEXT_PACE_LEN*0 ; paceText index 
    JMP :+++
    :
    CMP #2
    BNE :+
    LDA #12 ; strlen('"strenuous")')
    LDY #TEXT_PACE_LEN*1 ; paceText index 
    JMP :++
    :
    CMP #3
    BNE :+
    LDA #11 ; strlen('"grueling")')
    LDY #TEXT_PACE_LEN*2 ; paceText index 
    :
    STA helper
    STY helper2
    SBW helper, #$20, #$f0
        LDA #_QT
        WBB
        LDX helper
        DEX
        DEX
        DEX
        :
        LDY helper2
        LDA paceText, Y
        WBB
        INC helper2
        DEX
        BNE :-
        LDA #_QT
        WBB
        LDA #_CP
        WBB
    EBW
    
    ; The pace at which you travel can change. Your choices are:
    BDrawText travelingPointer+4, travelingPointer+5, #$21, #$24

    ; a steady pace
    ; a strenuous pace
    ; a grueling pace
    ; find out what these different paces mean
    LDX #6
    LDA #$21
    STA bufferHelper
    LDA #$a6
    STA bufferHelper+1
    :
    LDA travelingPointer, X
    STA pointer
    INX
    LDA travelingPointer, X
    STA pointer+1
    JSR BufferDrawText
    JSR BufferHelperNextLine
    JSR BufferHelperNextLine
    INX
    CPX #14
    BNE :-

    ; What is your choice?
    SBW #20, #$22, #$C4
        LDX #10
        :
        LDA whatIsYourChoiceText, X
        WBB
        INX
        CPX #30
        BNE :-
    EBW
    RTS
.endproc

.proc LoadBgRations
    JSR ClearScreen
    JSR ClearAttributes
    SBD
    JSR DrawAdornments
    EBD

    ; Change food rations
    BDrawText travelingPointer+20, travelingPointer+21, #$20, #$c6
    ; (currently "$rations")
    BDrawText travelingPointer+2, travelingPointer+3, #$20, #$e5
    LDA wagonRations
    CMP #3
    BNE :+
    LDA #10 ; strlen('"filling")')
    LDY #TEXT_RATIONS_LEN*2 ; rationsText index 
    JMP :+++
    :
    CMP #2
    BNE :+
    LDA #9 ; strlen('"meager")')
    LDY #TEXT_RATIONS_LEN*1 ; rationsText index 
    JMP :++
    :
    CMP #1
    BNE :+
    LDA #13 ; strlen('"bare bones")')
    LDY #TEXT_RATIONS_LEN*0 ; rationsText index 
    :
    STA helper
    STY helper2
    SBW helper, #$20, #$f0
        LDA #_QT
        WBB
        LDX helper
        DEX
        DEX
        DEX
        :
        LDY helper2
        LDA rationsText, Y
        WBB
        INC helper2
        DEX
        BNE :-
        LDA #_QT
        WBB
        LDA #_CP
        WBB
    EBW
    
    ; The amount of food the people in your party eat each day can change. These amounts are:
    BDrawText travelingPointer+22, travelingPointer+23, #$21, #$24

    ; filling - meals are large and generous.
    ; meager - meals are small, but adequate.
    ; bare bones - meals are very small; everyone stays hungry.
    LDX #24
    LDA #$21
    STA bufferHelper
    LDA #$c6
    STA bufferHelper+1
    :
    LDA travelingPointer, X
    STA pointer
    INX
    LDA travelingPointer, X
    STA pointer+1
    JSR BufferDrawText
    JSR BufferHelperNextLine
    JSR BufferHelperNextLine
    INX
    CPX #30
    BNE :-

    ; What is your choice?
    SBW #20, #$23, #$04
        LDX #10
        :
        LDA whatIsYourChoiceText, X
        WBB
        INX
        CPX #30
        BNE :-
    EBW

    RTS
.endproc

.proc DrawRestSubmenu
    LDX #4 ; top row of menu
    LDY #19
    JSR SetPpuAddrPointerFromXY
    SBW #19, pointer, pointer+1
        LDA #_RD
        WBB
        LDA #_HR
        LDX #0
        :
        WBB
        INX
        CPX #17
        BNE :-
        LDA #_LD
        WBB
    EBW

    LDX #4  ; vertical bars (left)
    LDY #20
    LDA #_VR
    WTB
    LDX #4
    LDY #21
    LDA #_VR
    WTB
    LDX #4
    LDY #22
    LDA #_VR
    WTB
    LDX #22  ; vertical bars (right)
    LDY #20
    LDA #_VR
    WTB
    LDX #22
    LDY #21
    LDA #_VR
    WTB
    LDX #22
    LDY #22
    LDA #_VR
    WTB

    LDX #4 ; bottom row of menu
    LDY #23
    JSR SetPpuAddrPointerFromXY
    SBW #19, pointer, pointer+1
        LDA #_RU
        WBB
        LDA #_HR
        LDX #0
        :
        WBB
        INX
        CPX #17
        BNE :-
        LDA #_LU
        WBB
    EBW

    LDX #6  ; "REST FOR x DAYS"
    LDY #21
    JSR SetPpuAddrPointerFromXY
    SBW #15, pointer, pointer+1
        LDX #0
        :
        LDA restText, X
        WBB
        INX
        CPX #9
        BNE :-
        LDA wagonRest
        TAX
        LDA decimalDigits, X
        WBB
        LDX #9
        :
        LDA restText, X
        WBB
        INX
        CPX #14
        BNE :-
    EBW

    RTS
.endproc

.proc BufferDrawSupplies

    JSR SetPaletteSupplies

    LDA #5
    STA counter
    LDX #0
    STX helper
    :
    INC helper
    INC helper
    LDA suppliesImageFood, X
    STA pointer
    INX
    LDA suppliesImageFood, X
    STA pointer+1
    INX
    :
    TXA
    PHA
    LDA suppliesImageFood, X
    TAX
    JSR StartBufferWrite
        PLA
        TAX
        LDA suppliesImageFood, X
        WBB
        CLC
        LDA helper
        ADC #2
        ADC suppliesImageFood, X
        STA helper
        INX
        CLC
        LDA suppliesImageFood, X
        ADC pointer+1
        STA pointer+1
        LDA pointer
        WBB
        LDA pointer+1
        WBB
        SEC
        LDA pointer+1
        SBC suppliesImageFood, X
        STA pointer+1
        JSR PointerToNextLine
        INX
        :
        LDA suppliesImageFood, X
        WBB
        INX
        CPX helper
        BNE :-
    EBW
    LDA suppliesImageFood, X
    BNE :--
    INC helper
    INX
    DEC counter
    BNE :---

    SetDigit #oxenDigit, #oxenHeadcount
    SBW #12, #$20, #$B0 ; oxenDigit
        LDX #0
        :
        LDA suppliesText, X
        WBB
        INX
        CPX #TEXT_SUPPLIES_LEN
        BNE :-
        LDA #___
        WBB
        LDX #0
        :
        LDA oxenDigit, X
        CMP #_UL
        BNE :+
        LDA #___
        :
        WBB
        INX
        CPX #4
        BNE :--
    EBW

    SetDigit #clothingDigit, #clothing
    SBW #12, #$20, #$F0 ; clothingDigit
        LDX #TEXT_SUPPLIES_LEN
        :
        LDA suppliesText, X
        WBB
        INX
        CPX #TEXT_SUPPLIES_LEN*2
        BNE :-
        LDA #___
        WBB
        LDX #0
        :
        LDA clothingDigit, X
        CMP #_UL
        BNE :+
        LDA #___
        :
        WBB
        INX
        CPX #4
        BNE :--
    EBW

    SetDigit #bulletsDigit, #bullets
    SBW #12, #$21, #$30 ; bulletsDigit
        LDX #TEXT_SUPPLIES_LEN*2
        :
        LDA suppliesText, X
        WBB
        INX
        CPX #TEXT_SUPPLIES_LEN*3
        BNE :-
        LDA #___
        WBB
        LDX #0
        :
        LDA bulletsDigit, X
        CMP #_UL
        BNE :+
        LDA #___
        :
        WBB
        INX
        CPX #4
        BNE :--
    EBW

    SBW #12, #$21, #$70 ; wagon wheels
        LDX #TEXT_SUPPLIES_LEN*3
        :
        LDA suppliesText, X
        WBB
        INX
        CPX #TEXT_SUPPLIES_LEN*4
        BNE :-
        LDA #___
        WBB
        WBB
        WBB
        WBB
        LDA spareParts
        AND #%00000011
        CLC
        ADC #_0_
        WBB
    EBW

    SBW #12, #$21, #$b0 ; wagon axles
        LDX #TEXT_SUPPLIES_LEN*4
        :
        LDA suppliesText, X
        WBB
        INX
        CPX #TEXT_SUPPLIES_LEN*5
        BNE :-
        LDA #___
        WBB
        WBB
        WBB
        WBB
        LDA spareParts
        AND #%00001100
        LSR
        LSR
        CLC
        ADC #_0_
        WBB
    EBW

    SBW #12, #$21, #$F0 ; wagon tongues
        LDX #TEXT_SUPPLIES_LEN*5
        :
        LDA suppliesText, X
        WBB
        INX
        CPX #TEXT_SUPPLIES_LEN*6
        BNE :-
        LDA #___
        WBB
        WBB
        WBB
        WBB
        LDA spareParts
        AND #%00110000
        LSR
        LSR
        LSR
        LSR
        CLC
        ADC #_0_
        WBB
    EBW

    SetDigit #foodLbsDigit, #foodLbs
    SBW #12, #$22, #$30 ; foodLbsDigit
        LDX #TEXT_SUPPLIES_LEN*6
        INX
        INX
        :
        LDA suppliesText, X
        WBB
        INX
        CPX #TEXT_SUPPLIES_LEN*7
        BNE :-
        LDA #___
        WBB
        LDX #0
        :
        LDA foodLbsDigit, X
        CMP #_UL
        BNE :+
        LDA #___
        :
        WBB
        INX
        CPX #4
        BNE :--
        LDA #___
        WBB
        LDA #_LB
        WBB
    EBW

    SetDigit #dollarsDigit, #dollars
    SBW #12, #$22, #$70 ; dollars
        LDA #_C_
        WBB
        LDA #_A_
        WBB
        LDA #_S_
        WBB
        LDA #_H_
        WBB
        LDA #___
        WBB
        LDA #___
        WBB
        LDA #_DL
        WBB
        LDX #0
        :
        LDA dollarsDigit, X
        WBB
        INX
        CPX #4
        BNE :-
        LDA #_00
        WBB
    EBW
    RTS
.endproc

.proc BufferDrawSizeUpSituation
    SBW #$20, #$22, #$00
        LDA #___
        LDX #0
        :
        WBB
        INX
        CPX #$20
        BNE :-
    EBW
    SBW #$20, #$22, #$20
        LDX #0
        :
        LDA sizeUpSituationText, X
        WBB
        INX
        CPX #$20
        BNE :-
    EBW

    SBW #8, #$23, #$E0
        LDA #$5f
        LDX #0
        :
        WBB
        INX
        CPX #8
        BNE :-
    EBW
    RTS
.endproc

.proc BufferDrawMapTitle
    SBW #3, #$23, #$C4 ; attributes
        LDA #$a5
        LDX #3
        :
        WBB
        DEX
        BNE :-
    EBW
    SBW #4, #$23, #$CC
        LDA #$0a
        LDX #4
        :
        WBB
        DEX
        BNE :-
    EBW
    
    SBW #10, #$20, #$71 ; "MAP OF THE"
        LDX #0
        :
        LDA mapTitleText, X
        WBB
        INX
        CPX #10
        BNE :-
    EBW
    SBW #12, #$20, #$92 ; "OREGON TRAIL"
        LDX #0+10
        :
        LDA mapTitleText, X
        WBB
        INX
        CPX #12+10
        BNE :-
    EBW
    RTS
.endproc

.proc CloseTextPopup

    LDA #0
    STA helper
    LDA #$40
    STA helper+1
    :
    SBW #$20, #$21, helper+1
        LDA #TILE_GRASS
        LDX #0
        :
        WBB
        INX
        CPX #$20
        BNE :-
    EBW
    INC helper
    LDA helper+1
    CLC
    ADC #$20
    STA helper+1
    LDA helper
    CMP #6
    BNE :--

    SBW #16, #$23, #$D0 ; attributes
        LDX #8
        LDA #$a0
        :
        WBB
        DEX
        BNE :-
        LDX #8
        LDA #$aa
        :
        WBB
        DEX
        BNE :-
    EBW

    JSR ClearPopupText

    LDA #$23 ; erase "Press Start to continue"
    STA pointer
    LDA #$60
    STA pointer+1
    SBW #$20, pointer, pointer+1
        LDA #___
        LDX #0
        :
        WBB
        INX
        CPX #$20
        BNE :-
    EBW
    JSR BufferDrawSizeUpSituation ; draw "Press A to size up the situation"
    RTS
.endproc

.proc BufferDrawTravelingHUD
    LDA #0
    STA helper
    LDA #$22
    STA pointer+1
    LDA #$40
    STA pointer
    :
    SBW #$20, pointer+1, pointer
        LDA #___
        LDX #0
        :
        WBB
        INX
        CPX #$20
        BNE :-
    EBW
    CLC
    LDA pointer
    ADC #$20
    STA pointer
    LDA pointer+1
    ADC #$0
    STA pointer+1
    INC helper
    LDA helper
    CMP #8
    BNE :--

    SBW #8, #$23, #$E0
        LDA #%01011111
        LDX #0
        :
        WBB
        INX
        CPX #8
        BNE :-
    EBW

    SBW #8, #$23, #$E8
        LDA #%01010101
        LDX #0
        :
        WBB
        INX
        CPX #8
        BNE :-
    EBW

    SBW #8, #$23, #$F0
        LDA #%11110101
        LDX #0
        :
        WBB
        INX
        CPX #8
        BNE :-
    EBW

    SBW #6, #$22, #$6B ; draw Date:
        LDX #0
        :
        LDA hudText, X
        WBB
        INX
        CPX #4
        BNE :-
        LDA #_CL
        WBB
        LDA #___
        WBB
    EBW

    SBW #9, #$22, #$88 ; draw Weather:
        LDX #4
        :
        LDA hudText, X
        WBB
        INX
        CPX #11
        BNE :-
        LDA #_CL
        WBB
        LDA #___
        WBB
    EBW

    SBW #8, #$22, #$A9 ; draw Health:
        LDX #11
        :
        LDA hudText, X
        WBB
        INX
        CPX #17
        BNE :-
        LDA #_CL
        WBB
        LDA #___
        WBB
    EBW

    SBW #6, #$22, #$CB ; draw Food:
        LDX #17
        :
        LDA hudText, X
        WBB
        INX
        CPX #21
        BNE :-
        LDA #_CL
        WBB
        LDA #___
        WBB
    EBW

    SBW #15, #$22, #$E2 ; draw Next Landmark:
        LDX #21
        :
        LDA hudText, X
        WBB
        INX
        CPX #34
        BNE :-
        LDA #_CL
        WBB
        LDA #___
        WBB
    EBW

    SBW #16, #$23, #$01 ; draw Miles traveled:
        LDX #34
        :
        LDA hudText, X
        WBB
        INX
        CPX #48
        BNE :-
        LDA #_CL
        WBB
        LDA #___
        WBB
    EBW

    RTS
.endproc

.proc UpdateMainMenuHUDValues
    LDA #$20 ; draw date
    STA pointer
    LDA #$8A
    STA pointer+1
    JSR BufferDrawDateText
    LDA #$20 ; draw weather
    STA pointer
    LDA #$EC
    STA pointer+1
    JSR BufferDrawWeatherText
    LDA #$21 ; draw health
    STA pointer
    LDA #$0C
    STA pointer+1
    JSR BufferDrawHealthText
    LDA #$21 ; draw pace
    STA pointer
    LDA #$2C
    STA pointer+1
    JSR BufferDrawPaceText
    LDA #$21 ; draw rations
    STA pointer
    LDA #$4C
    STA pointer+1
    JSR BufferDrawRationsText
    RTS
.endproc

.proc BufferDrawMainMenuHUDValues
    LDA menuOpen
    CMP #MENU_MAINMENU
    BNE :+
    LDA wagonRest
    BEQ :+
    JSR UpdateMainMenuHUDValues
    :
    RTS 
.endproc

.proc BufferDrawRationsText
    ; @param pointer: nametable location
    JSR BufferClearTravelingHUDValue
    SBW #TEXT_RATIONS_LEN, pointer, pointer+1
        LDX wagonRations
        DEX
        LDA #0
        STA counter
        LDA #TEXT_RATIONS_LEN
        STA counter+1
        :
        CPX #0
        BEQ :+
        CLC
        LDA counter
        ADC #TEXT_RATIONS_LEN
        STA counter
        CLC
        LDA counter+1
        ADC #TEXT_RATIONS_LEN
        STA counter+1 
        DEX
        JMP :-
        :
        LDX counter
        :
        LDA rationsText, X
        WBB
        INX
        CPX counter+1
        BNE :-
    EBW
    ; :                   ; vblankwait for aesthetic reasons
    ; BIT PPUSTATUS
    ; BPL :-
    RTS
.endproc

.proc BufferDrawPaceText
    ; @param pointer: nametable location
    JSR BufferClearTravelingHUDValue
    SBW #TEXT_PACE_LEN, pointer, pointer+1
        LDX wagonPace
        DEX
        LDA #0
        STA counter
        LDA #TEXT_PACE_LEN
        STA counter+1
        :
        CPX #0
        BEQ :+
        CLC
        LDA counter
        ADC #TEXT_PACE_LEN
        STA counter
        CLC
        LDA counter+1
        ADC #TEXT_PACE_LEN
        STA counter+1 
        DEX
        JMP :-
        :
        LDX counter
        :
        LDA paceText, X
        WBB
        INX
        CPX counter+1
        BNE :-
    EBW
    ; :                   ; vblankwait for aesthetic reasons
    ; BIT PPUSTATUS
    ; BPL :-
    RTS
.endproc

.proc BufferDrawTravelingHUDValues
    LDA menuOpen
    CMP #MENU_NONE
    BEQ :+
    RTS
    :
    LDA #$22 ; draw date
    STA pointer
    LDA #$70
    STA pointer+1
    JSR BufferDrawDateText
    LDA #$22 ; draw weather
    STA pointer
    LDA #$90
    STA pointer+1
    JSR BufferDrawWeatherText
    LDA #$22 ; draw health
    STA pointer
    LDA #$B0
    STA pointer+1
    JSR BufferDrawHealthText
    LDA #$22 ; draw food
    STA pointer
    LDA #$D0
    STA pointer+1
    JSR BufferDrawFoodText
    LDA #$22 ; draw next landmark miles
    STA pointer
    LDA #$F0
    STA pointer+1
    JSR BufferDrawNextText
    LDA #$23 ; draw miles traveled
    STA pointer
    LDA #$10
    STA pointer+1
    JSR BufferDrawTraveledText
    RTS
.endproc

.proc BufferDrawFoodText
    ; @param pointer: nametable location
    JSR BufferClearTravelingHUDValue
    SBW #11, pointer, pointer+1 ; "XXXX_POUNDS"
        LDX #0
        :
        LDA foodLbsDigit, X
        WBB
        INX
        CPX #4
        BNE :-
        LDA #___
        WBB
        LDX #41
        :
        LDA hudMenuStatusText, X
        WBB
        INX
        CPX #47
        BNE :-
    EBW
    ; :                   ; vblankwait for aesthetic reasons
    ; BIT PPUSTATUS
    ; BPL :-
    RTS
.endproc

.proc BufferDrawNextText
    ; @param pointer: nametable location
    JSR BufferClearTravelingHUDValue
    SBW #9, pointer, pointer+1 ; "XXX_MILES"
        LDX #1
        :
        LDA nextDigit, X
        WBB
        INX
        CPX #4
        BNE :-
        LDA #___
        WBB
        LDX #47
        :
        LDA hudMenuStatusText, X
        WBB
        INX
        CPX #52
        BNE :-
    EBW
    ; :                   ; vblankwait for aesthetic reasons
    ; BIT PPUSTATUS
    ; BPL :-
    RTS
.endproc

.proc BufferDrawTraveledText
    ; @param pointer: nametable location
    JSR BufferClearTravelingHUDValue
    SBW #10, pointer, pointer+1 ; "XXXX_MILES"
        LDX #0
        :
        LDA traveledDigit, X
        WBB
        INX
        CPX #4
        BNE :-
        LDA #___
        WBB
        LDX #47
        :
        LDA hudMenuStatusText, X
        WBB
        INX
        CPX #52
        BNE :-
    EBW
    ; :                   ; vblankwait for aesthetic reasons
    ; BIT PPUSTATUS
    ; BPL :-
    RTS
.endproc

.proc BufferDrawWagon
    LDA menuOpen
    CMP #MENU_NONE
    BEQ :+
    JMP Done
    :
    SBW #7, #$20, #$D8
        LDX #0
        :
        LDA bgWagonTop, X
        WBB
        INX
        CPX #7
        BNE :-
    EBW

    SBW #7, #$20, #$F8
        LDX #7
        :
        LDA bgWagonTop, X
        WBB
        INX
        CPX #14
        BNE :-
    EBW

    LDX #0
    LDY oxenFrame
    :
    CPY #0
    BEQ :+
    TXA
    CLC
    ADC #18
    TAX
    DEY
    JMP :-
    :
    STX helper

    SBW #9, #$21, #$15
        LDX helper
        LDA #0
        STA helper+1
        :
        LDA bgWagonAnim, X
        WBB
        INX
        INC helper+1
        LDA helper+1
        CMP #9
        BNE :-
        STX helper
    EBW

    SBW #9, #$21, #$35
        LDX helper
        LDA #0
        STA helper+1
        :
        LDA bgWagonAnim, X
        WBB
        INX
        INC helper+1
        LDA helper+1
        CMP #9
        BNE :-
    EBW
    Done:
    RTS
.endproc

.proc BufferDrawTravelingAttr
    SBW #24, #$23, #$C8
        LDA location
        CMP #LOC_FORTLARAMIE
        BCS :++
        LDA #$0a
        LDX #8
        :
        WBB
        DEX
        BNE :-
        JMP :+++
        :
        LDA #$00
        LDX #8
        :
        WBB
        DEX
        BNE :-
        :
        LDA #$a0
        LDX #8
        :
        WBB
        DEX
        BNE :-
        LDA #$aa
        LDX #8
        :
        WBB
        DEX
        BNE :-
    EBW
    RTS
.endproc

.proc LoadTrailSprites
    LDX #39*4 ; map legend
    :
    LDA trailSprites, X
    STA TRAILSPRITES, X
    INX
    CPX #63*4
    BNE :-
    LDY location ; trail line
    LDA landmarkTrailSprite, Y
    STA helper
    LDY #0
    LDX #0
    :
    LDA trailSprites, X
    STA TRAILSPRITES, X
    INX
    INY
    CPY #4
    BNE :-
    LDA #0
    TAY
    STA OAMADDR ; tell PPU to prepare for transfer to OAM starting at byte zero
    LDA #$02
    STA OAMDMA ; tell PPU to initiate transfer of 256 bytes $0200-$02ff into OAM
    :                   ; vblankwait again
    BIT PPUSTATUS
    BPL :-
    CPX helper
    BNE :--

    ; LDA #0
    ; STA PPUADDR
    ; STA PPUADDR
    RTS
.endproc

.proc DrawLandmarkTitle
    ; pointer: ppuaddr 
    LDA PPUSTATUS   ; set footer bar location
    LDA pointer
    STA PPUADDR
    LDA pointer+1
    STA PPUADDR
    JSR DrawBlankLine   ; start footer bar
    LDX location
    JSR GetLandmarkText
    LDA #32 ; draw landmark text line
    SEC
    SBC helper2
    LSR
    STA helper2+1
    LDX #0
    LDA #___
    :
    STA PPUDATA
    INX
    CPX helper2+1
    BNE :-
    LDY #0
    :
    LDA textLineHelper, Y
    STA PPUDATA
    INY
    CPY helper2
    BNE :-
    LDA #32
    SEC
    SBC helper2
    SBC helper2+1
    TAX
    LDA #___
    :
    CPX #0
    BNE :+
    JMP :++
    :
    STA PPUDATA
    DEX
    JMP :--
    :
    LDX #0          ; draw date text line
    LDA #___
    :
    STA PPUDATA
    INX
    CPX #10
    BNE :-
    JSR DrawDateText
    LDA #___
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #10
    BNE :-
    JSR DrawBlankLine   ; blank line
    RTS
.endproc

; Random events ----------------------------------------------------------------

.proc RandomEvent
    ; Each day, the random event engine goes through each of the random events
    ; to determine if that event will occur on that day, based on the current
    ; probability. However, if one of the events does indeed occur, then the
    ; random event engine halts. As a result, no more than one random event 
    ; occurs in a single day.
    LDA wagonRest ; no random event if resting? TODO confirm
    BEQ :+
    RTS
    :
    LDA #0
    STA helper ; flag to halt the random event engine: 1 is done

    JSR REIndianFood
    LDA helper
    BEQ :+
    RTS
    :
    JSR REThunderstorm
    LDA helper
    BEQ :+
    RTS
    :
    JSR REBlizzard
    LDA helper
    BEQ :+
    RTS
    :
    JSR REHeavyFog
    LDA helper
    BEQ :+
    RTS
    :
    JSR REHailStorm
    LDA helper
    BEQ :+
    RTS
    :
    JSR REInjuredOx
    LDA helper
    BEQ :+
    RTS
    :
    JSR REInjuredPerson
    LDA helper
    BEQ :+
    RTS
    :
    JSR RESnakeBite
    LDA helper
    BEQ :+
    RTS
    :
    JSR RELoseTrail
    LDA helper
    BEQ :+
    RTS
    :
    JSR REWrongTrail
    LDA helper
    BEQ :+
    RTS
    :
    JSR RERoughTrail
    LDA helper
    BEQ :+
    RTS
    :
    JSR REImpassibleTrail
    LDA helper
    BEQ :+
    RTS
    :
    JSR REWildFruit
    LDA helper
    BEQ :+
    RTS
    :
    JSR REFireWagon
    LDA helper
    BEQ :+
    RTS
    :
    JSR RELostPerson
    LDA helper
    BEQ :+
    RTS
    :
    JSR REOxWandersOff
    LDA helper
    BEQ :+
    RTS
    :
    JSR REAbandonedWagon
    LDA helper
    BEQ :+
    RTS
    :
    JSR REThief
    LDA helper
    BEQ :+
    RTS
    :
    JSR REBadWater
    LDA helper
    BEQ :+
    RTS
    :
    JSR RELittleWater
    LDA helper
    BEQ :+
    RTS
    :
    JSR REInadequateGrass
    LDA helper
    BEQ :+
    RTS
    :
    JSR REIllness
    LDA helper
    BEQ :+
    RTS
    :
    JSR REBrokenPart
    RTS
.endproc

.proc RollRNG
    ; @return A - RNG roll result, 0-200
    :
    JSR RandomNumberGenerator
    CMP #200 ; discard rolls >= 200. Roll is then 0%-100% with 0.5% increments  
    BCS :-
    RTS
.endproc

.proc REIndianFood
    ; Indians help find food
    ; "If you are completely out of food, then there is a 5% chance each day
    ; that local Indians will give you 30 pounds of food."
    LDA foodLbs+1
    CMP #0
    BNE Done
    LDA foodLbs
    CMP #0
    BEQ :+
    JMP Done
    :
    JSR RollRNG
    CMP #5*2
    BCC :+
    JMP Done
    :
    CLC
    LDA foodLbs
    ADC #30
    STA foodLbs
    LDA foodLbs+1
    ADC #0
    STA foodLbs+1
    LDX #foodLbsDigit
    LDY #foodLbs
    JSR SetDigitFromValue
    LDA #EVENT_INDIAN_FOOD
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REThunderstorm
    ; Severe thunderstorm
    ; "The probability is based on the average precipitation for your current
    ; location and current month."
    ; lets say 10% if it's currently rainy, 25% if it's currently very rainy
    LDA weather
    CMP #WEATHER_RAINY
    BNE :+
    JSR RollRNG
    CMP #10*2
    BCC AlmostDone
    JMP Done
    :
    CMP #WEATHER_VERY_RAINY
    BNE Done
    JSR RollRNG
    CMP #25*2
    BCC AlmostDone
    JMP Done
    AlmostDone:
    LDA #EVENT_THUNDERSTORM
    JSR QueueEvent
    LDA #EVENT_CLEAR_THUNDERSTORM
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REBlizzard
    ; Severe blizzard
    ; "15% chance each day in which the temperature is either cold or very cold."
    LDA weather
    CMP #WEATHER_COLD
    BEQ :+
    CMP #WEATHER_VERY_COLD
    BEQ :+
    JMP Done
    :
    JSR RollRNG
    CMP #15*2
    BCC :+
    JMP Done
    :
    LDA #EVENT_BLIZZARD
    JSR QueueEvent
    LDA #EVENT_CLEAR_BLIZZARD
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REHeavyFog
    ; Heavy fog
    ; "After Fort Hall, a 6% chance each day, except when the temperature is
    ; very hot. 50% chance of losing a day's travel."
    LDA location
    CMP #LOC_FORTHALL
    BCC Done
    LDA weather
    CMP #WEATHER_VERY_HOT
    BEQ Done
    JSR RollRNG
    CMP #6*2
    BCS Done
    LDA #EVENT_HEAVY_FOG
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REHailStorm
    ; Hail storm
    ; "Before Fort Hall, 6% chance each day in which the temperature is very hot.""
    ; +50% chance of losing a day's travel
    LDA location
    CMP #LOC_FORTHALL
    BCS Done
    LDA weather
    CMP #WEATHER_VERY_HOT
    BNE Done
    JSR RollRNG
    CMP #6*2
    BCS Done
    LDA #EVENT_HAIL_STORM
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REInjuredOx
    ; Injured or dead ox
    ; 2% each day on the prairie; 3.5% chance each day in the mountains. If all
    ; oxen are healthy, then one becomes injured; otherwise, the sick ox dies.
    CLC
    LDA oxenHeadcount
    ADC oxenHealth
    BEQ Done
    LDA #4
    STA helper+1
    JSR CheckMountainousTerrain
    BEQ :+
    LDA #7
    STA helper+1
    :
    JSR RollRNG
    CMP helper+1
    BCC :+
    JMP Done
    :
    LDA oxenHealth
    BEQ :+
    DEC oxenHeadcount ; sick ox dies
    DEC oxenHealth
    JMP :++
    :
    INC oxenHealth ; ox becomes injured
    :
    LDA #EVENT_INJURED_OX
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REInjuredPerson
    ; Injured party member (broken arm or leg)
    ; 2% chance each day on the prairie; 3.5% chance each day in the mountains.
    ; The person who gets injured is chosen randomly.
    JSR CheckMountainousTerrain
    BEQ :+
    JSR RollRNG ; mountains
    CMP #7
    BCC AlmostDone
    JMP Done
    :
    JSR RollRNG ; prairie
    CMP #2*2
    BCC AlmostDone
    JMP Done
    AlmostDone:
    ; CLC
    ; LDA wagonHealth
    ; ADC #20
    ; STA wagonHealth ; no mention of wagon health from Bouchard
    LDA #EVENT_INJURED_PERSON
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc RESnakeBite
    ; Snake bite
    ; 0.7% chance each day in the original game.
    ; 0.75% chance is close enough
    ; Assume same behavior as broken limb. No word from Bouchard on this.
    JSR RandomNumberGenerator
    AND #1 ; 50%
    BCS Done
    JSR RollRNG
    CMP #3 ; 50% of 1.5% = 0.75%
    BCS Done
    LDA #EVENT_SNAKE_BITE
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc RELoseTrail
    ; Lose trail
    ; "2% chance each day."
    ; lose 1-8 days?
    JSR RollRNG
    CMP #2*2
    BCC :+
    JMP Done
    :
    LDA #EVENT_LOSE_TRAIL
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REWrongTrail
    ; Wrong trail
    ; "1% chance each day."
    ; lose 1-8 days?
    JSR RollRNG
    CMP #1*2
    BCC :+
    JMP Done
    :
    LDA #EVENT_WRONG_TRAIL
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc RERoughTrail
    ; Rough trail
    ; In mountains only; 2.5% chance each day.
    JSR CheckMountainousTerrain
    CMP #0
    BEQ Done
    JSR RollRNG
    CMP #5
    BCC :+
    JMP Done
    :
    CLC
    LDA wagonHealth
    ADC #10
    STA wagonHealth
    LDA #EVENT_ROUGH_TRAIL
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REImpassibleTrail
    ; Impassible trail
    ; In mountains only; 2.5% chance each day.
    ; lose 1-8 days?
    JSR RollRNG
    CMP #5
    BCC :+
    JMP Done
    :
    LDA #EVENT_IMPASSIBLE_TRAIL
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REWildFruit
    ; Finding wild fruit
    ; "May to September only; 4% chance each day. The food supply is increased
    ; by 20 pounds."
    LDA dateMonth
    CMP #5
    BCC Done
    CMP #10
    BCS Done
    JSR RollRNG
    CMP #4*2
    BCC :+
    JMP Done
    :
    CLC
    LDA foodLbs
    ADC #20
    STA foodLbs
    LDA foodLbs+1
    ADC #0
    STA foodLbs+1
    BCC :+
    LDA #$d0
    STA foodLbs
    LDA #$07
    STA foodLbs+1 ; max 2000 lb
    :
    LDA #EVENT_WILD_FRUIT
    JSR QueueEvent
    LDA #EVENT_CLEAR_WILD_FRUIT
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REFireWagon
    ; Fire in the wagon
    ; 2% chance each day. Some supplies are lost.
    JSR RollRNG
    CMP #2*2
    BCC :+
    JMP Done
    :
    LDA #EVENT_FIRE_WAGON
    JSR QueueEvent
    LDA #EVENT_CLEAR_FIRE_WAGON
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc RELostPerson
    ; Lost party member
    ; 1% chance each day; lose up to 5 days.
    JSR RollRNG
    CMP #1*2
    BCC :+
    JMP Done
    :
    LDA #EVENT_LOST_PERSON
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REOxWandersOff
    ; Ox wanders off
    ; 1% chance each day; lose up to 3 days.
    JSR RollRNG
    CMP #1*2
    BCC :+
    JMP Done
    :
    LDA #EVENT_OX_WANDERS_OFF
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REAbandonedWagon
    ; Finding an abandoned wagon
    ; 2% chance each day. Some supplies are gained.
    JSR RollRNG
    CMP #2*2
    BCC :+
    JMP Done
    :
    LDA #EVENT_ABANDONED_WAGON
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REThief
    ; Thief comes during the night
    ; 2% chance each day. Some supplies are lost.
    JSR RollRNG
    CMP #2*2
    BCC :+
    JMP Done
    :
    LDA #EVENT_THIEF
    JSR QueueEvent
    LDA #EVENT_CLEAR_THIEF
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REBadWater
    ; Bad water
    ; 10% chance each day in which the accumulated rainfall is below 0.1 inch.
    LDA accumulatedRain
    CMP #1
    BCS Done
    JSR RollRNG
    CMP #10*2
    BCS Done
    LDA wagonHealth
    ADC #20
    STA wagonHealth
    LDA #EVENT_BAD_WATER
    JSR QueueEvent
    LDA #EVENT_CLEAR_TEXT
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc RELittleWater
    ; Very little water
    ; 20% chance each day in which the accumulated rainfall is below 0.1 inch.
    LDA accumulatedRain
    CMP #1
    BCS Done
    JSR RollRNG
    CMP #20*2
    BCS Done
    CLC
    LDA wagonHealth
    ADC #10
    STA wagonHealth
    LDA #EVENT_LITTLE_WATER
    JSR QueueEvent
    LDA #EVENT_CLEAR_TEXT
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REInadequateGrass
    ; Inadequate grass
    ; 20% chance each day in which the accumulated rainfall is below 0.1 inch.
    LDA accumulatedRain
    CMP #1
    BCS Done
    JSR RollRNG
    CMP #20*2
    BCS Done
    ; Inadequate Grass event effect does nothing?
    LDA #EVENT_INADEQUATE_GRASS
    JSR QueueEvent
    LDA #EVENT_CLEAR_TEXT
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc

.proc REIllness
    ; Illness
    ; 0% to 40% chance each day, depending upon the health of the party. The
    ;   person and the disease are chosen randomly.
    ; Add 20 to wagonHealth when the disease first strikes.
    ; Trick: When an ill person gets another illness they 
    ;   simply die of their existing illness.

    ; Calculate illness chance: ((health * 128) / 175) out of 256 
    LDA wagonHealth
    STA helper2
    LDA #0
    STA helper2+1
    CLC
    LDX #7
    : ; ((health * 128)
    ROL helper2
    ROL helper2+1
    DEX
    BNE :-
    LDA #0
    STA cartHelperDigit
    SEC
    : ; / 175)
    LDA helper2
    SBC #175
    STA helper2
    LDA helper2+1
    SBC #0
    STA helper2+1
    INC cartHelperDigit
    BCS :-
    JSR RollRNG ; out of 256 
    CMP cartHelperDigit
    BCC :+
    JMP Done
    :
    CLC
    LDA wagonHealth
    ADC #20
    STA wagonHealth
    LDA #EVENT_ILLNESS
    JSR QueueEvent
    LDA #1
    STA helper
    Done: 
    RTS
.endproc

.proc REBrokenPart
    ; Broken wagon part
    ; ?% per day (not in Bouchard's book)
    ; lets go with 2% per day, same as wagon fire
    JSR RollRNG
    CMP #2*2
    BCC :+
    JMP Done
    :
    LDA #EVENT_BROKEN_PART
    JSR QueueEvent
    LDA #EVENT_CLEAR_BROKEN_PART
    JSR QueueEvent
    LDA #1
    STA helper
    Done:
    RTS
.endproc
