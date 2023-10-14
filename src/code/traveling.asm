
.proc LoadBgTraveling
    JSR ClearScreen
    JSR ClearAttributes ; default palette
    SBD
    LDA menuOpen
    CMP #MENU_MAINMENU
    BNE :+
    JMP @menuMain
    :
    CMP #MENU_NONE
    BNE :+
    JMP @menuNone
    :
    @menuMain:
        JSR DrawHUDMainMenu
        LDA #$20    ; weather text
        STA pointer
        LDA #$EC
        STA pointer+1
        JSR BufferDrawWeatherText
        LDA #$21    ; Health text
        STA pointer
        LDA #$2C
        STA pointer+1
        JSR BufferDrawHealthText
        JMP Done
    @menuNone:
        LDA PPUSTATUS
        LDA #$23
        STA PPUADDR
        LDA #$C8
        STA PPUADDR
        LDX #24
        LDA #%10101010
        :
        STA PPUDATA
        DEX
        BNE :-
        LDA PPUSTATUS
        LDA #$20
        STA PPUADDR
        LDX #0 ; temp- draw horizon
        LDA location
        CMP #LOC_FORTLARAMIE
        BCS :++
        LDA #$80
        STA PPUADDR
        :
        LDA bgPlains, X
        STA PPUDATA
        INX
        CPX #$40
        BNE :-
        JMP :+++
        :
        LDA #$60
        STA PPUADDR
        :
        LDA bgMountains, X
        STA PPUDATA
        INX
        CPX #$60
        BNE :-
        :
        LDA PPUSTATUS
        LDA #$21
        STA PPUADDR
        LDA #$40
        STA PPUADDR
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
    



        JMP Done
    Done:
    EBD
    RTS
.endproc

.proc DrawHUDMainMenu
    LDA PPUSTATUS   ; set color palette (attribute table)
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR
    LDA #%11111111
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #8
    BNE :-
    LDA #%01111111
    STA PPUDATA
    LDA #%01011111
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #6
    BNE :-
    LDA #%11011111
    STA PPUDATA
    LDA #%11110111
    STA PPUDATA
    LDA #%11110101
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #6
    BNE :-
    LDA #%11111101
    STA PPUDATA
    LDA #%11111111
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #8*5
    BNE :-
    LDX #0  ; draw landmark text
    LDY #1
    JSR SetPpuAddrPointerFromXY
    JSR DrawLandmarkTitle

    LDX #0  ; draw health and weather box
    LDY #6
    JSR SetPpuAddrPointerFromXY
    LDA PPUSTATUS
    LDA pointer
    STA PPUADDR
    LDA pointer+1
    STA PPUADDR 
    LDX #0 ; blank row
    LDA #___
    :
    STA PPUDATA
    INX
    CPX #35
    BNE :-
    LDX #0 ; "WEATHER:"
    :
    LDA hudMenuStatusText, X
    STA PPUDATA
    INX
    CPX #8
    BNE :-
    LDX #0 ; blank row
    LDA #___
    :
    STA PPUDATA
    INX
    CPX #57
    BNE :-
    LDX #8 ; "HEALTH:"
    :
    LDA hudMenuStatusText, X
    STA PPUDATA
    INX
    CPX #15
    BNE :-
    LDX #0 ; blank row
    LDA #___
    :
    STA PPUDATA
    INX
    CPX #20
    BNE :-
    LDA #0 ; start menu loop
    STA helper
    LDX #6
    LDY #11
    JSR SetPpuAddrPointerFromXY
    LDX #0
    MenuLoop:
    LDA PPUSTATUS ; start menu option line
    LDA pointer
    STA PPUADDR
    LDA pointer+1
    STA PPUADDR
    :
    LDA hudMenu, X
    STA PPUDATA
    INX
    INC helper
    LDA helper
    CMP #TEXT_MAINMENU_LEN
    BNE :-
    LDA #0
    STA helper
    TXA
    PHA
    LDX #6
    INY
    INY
    JSR SetPpuAddrPointerFromXY
    PLA
    TAX
    CPY #29
    BNE MenuLoop
    RTS
.endproc

.proc LoadBgMap
    JSR ClearScreen
    JSR ClearAttributes
    SBD
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
    LDA currentBank
    PHA
    LDY #BANK_DATA ; get image data
    JSR bankswitch_y
    LDA #<mapTiles 
    STA pointer
    LDA #>mapTiles
    STA pointer+1
    LDA #<mapImage
    STA helper2
    LDA #>mapImage
    STA helper2+1
    JSR CopyCHRPatternB
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

    LDA helper2 ; set attribute table
    STA pointer
    LDA helper2+1
    STA pointer+1
    LDA #$00
    STA counter
    LDA #$03
    STA counter+1
    LDA PPUSTATUS
    LDA #$20
    STA PPUADDR
    LDA #$40
    STA PPUADDR
    JSR UnpackData

    PLA
    TAY
    JSR bankswitch_y
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
    LDA #<suppliesTilesMeta
    STA pointer
    LDA #>suppliesTilesMeta
    STA pointer+1
    JSR UnpackTilesMeta


    LDA currentBank
    PHA
    LDY #BANK_DATA
    JSR bankswitch_y
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
    PLA
    TAY
    JSR bankswitch_y

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
    JMP Done
    :
    LDA buttons1
    CMP buttons1Last
    BNE CheckA
    JMP Done
    CheckA:
        LDA #KEY_A
        BIT buttons1
        BNE :+
        JMP CheckB
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_MAINMENU
        BNE :+
        JMP @menuMain
        :
        CMP #MENU_MAP
        BNE :+
        JMP @menuMap
        :
        CMP #MENU_PACE
        BNE :+
        JMP @menuPace
        :
        CMP #MENU_RATIONS
        BNE :+
        JMP @menuRations
        :
        CMP #MENU_REST
        BNE :+
        JMP @menuRest
        :
        CMP #MENU_TALK
        BNE :+
        JMP @menuTalk
        :
        CMP #MENU_TEXTPOPUP
        BNE :+
        JMP @menuTextPopup
        :
        CMP #MENU_TEXTPOPUP_YN
        BNE :+
        JMP @menuTextPopupYN
        :
        JMP Done
        @menuTextPopup:
            JSR CloseTextPopup
            LDA #MENU_NONE
            STA menuOpen
            JMP Done
        @menuTextPopupYN:
            JSR CloseTextPopup
            LDA #MENU_NONE
            STA menuOpen
            LDA #EVENT_LOAD_LANDMARK ; if yes selected
            JSR QueueEvent
            JMP Done
            
        @menuNone:
            ; LDA #MENU_TEXTPOPUP
            ; STA menuOpen ; testing popup window
            LDA #MENU_MAINMENU
            STA menuOpen
            LDA #0
            STA menuCursor
            JMP Done
        @menuMain:
            LDA menuCursor
            CMP #OPT_CONTINUE
            BNE :+
            LDA #MENU_NONE
            STA menuOpen
            JMP Done
            :
            CMP #OPT_SUPPLIES
            BNE :+
            LDA #MENU_SUPPLIES
            STA menuOpen
            JMP Done
            :
            CMP #OPT_MAP
            BNE :+
            LDA #MENU_MAP
            STA menuOpen
            JMP Done
            :
            CMP #OPT_PACE
            BNE :+
            LDA #MENU_PACE
            STA menuOpen
            JMP Done
            :
            CMP #OPT_RATIONS
            BNE :+
            LDA #MENU_RATIONS
            STA menuOpen
            JMP Done
            :
            CMP #OPT_REST
            BNE :+
            LDA #MENU_REST
            STA menuOpen
            JMP Done
            :
            CMP #OPT_TALK
            BNE :+
            LDA #MENU_TALK
            STA menuOpen
            JMP Done
            :
            JMP Done
        @menuMap:
        @menuPace:
        @menuRations:
        @menuRest:
            JSR CloseSubmenu
        @menuTalk:
            LDA #MENU_MAINMENU
            STA menuOpen
            JMP Done
        ; @menuOther:
        ; JSR CloseSubmenu...
    CheckB:
    CheckSelect:
        LDA #KEY_SELECT
        BIT buttons1
        BNE :+
        JMP CheckStart
        :
        JMP Done
    CheckStart:
        LDA #KEY_START
        BIT buttons1
        BNE :+
        JMP CheckUp
        :
        LDA menuOpen
        CMP #MENU_SUPPLIES
        BNE :+
        JMP @menuSupplies
        :
        JMP Done
        @menuSupplies:
            LDA #MENU_MAINMENU
            STA menuOpen
            JMP Done
    CheckUp:
        LDA #KEY_UP
        BIT buttons1
        BNE :+
        JMP CheckDown
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_MAINMENU
        BNE :+
        JMP @menuMain
        :
        CMP #MENU_PACE
        BNE :+
        JMP @menuPace
        :
        CMP #MENU_RATIONS
        BNE :+
        JMP @menuRations
        :
        CMP #MENU_REST
        BNE :+
        JMP @menuRest
        :
        JMP Done
        @menuNone:
        @menuMain:
            DEC menuCursor
            LDX fingerY
            DEX
            DEX
            CPX #9 ; check if fingerY is past top of menu
            BNE :+
            LDX #27 ; wrap to bottom of menu
            LDA #8
            STA menuCursor
            :
            STX fingerY
            JMP Done
        @menuPace:
            LDA wagonSettings
            AND #%00000011
            STA helper
            LDA #%11111100
            AND wagonSettings
            STA wagonSettings
            INC helper
            LDA helper
            AND #%00000011
            CMP #0
            BNE :+
            LDA #1
            :
            ORA wagonSettings
            STA wagonSettings
            JSR DrawPaceSubmenu
            JSR RedrawFinger
            JMP Done
        @menuRations:
            LDA wagonSettings
            AND #%00001100
            LSR
            LSR
            STA helper
            LDA #%11110011
            AND wagonSettings
            STA wagonSettings
            INC helper
            LDA helper
            AND #%00000011
            CMP #0
            BNE :+
            LDA #1
            :
            CLC
            ROL
            ROL
            ORA wagonSettings
            STA wagonSettings
            JSR DrawRationsSubmenu
            JSR RedrawFinger
            JMP Done
        @menuRest:
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
            JSR WriteTileToBuffer
            JSR DrawRestSubmenu
            JSR RedrawFinger
            JMP Done
    CheckDown:
        LDA #KEY_DOWN
        BIT buttons1
        BNE :+
        JMP CheckLeft
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_MAINMENU
        BNE :+
        JMP @menuMain
        :
        CMP #MENU_PACE
        BNE :+
        JMP @menuPace
        :
        CMP #MENU_RATIONS
        BNE :+
        JMP @menuRations
        :
        CMP #MENU_REST
        BNE :+
        JMP @menuRest
        :
        JMP Done
        @menuNone:
        @menuMain:
            INC menuCursor
            LDX fingerY
            INX
            INX
            CPX #29 ; check if fingerY is past bottom of menu
            BNE :+
            LDX #11 ; wrap to top of menu
            LDA #0
            STA menuCursor
            :
            STX fingerY
            JMP Done
        @menuPace:
            LDA wagonSettings
            AND #%00000011
            STA helper
            LDA #%11111100
            AND wagonSettings
            STA wagonSettings
            DEC helper
            LDA helper
            AND #%00000011
            CMP #0
            BNE :+
            LDA #3
            :
            ORA wagonSettings
            STA wagonSettings
            JSR DrawPaceSubmenu
            JSR RedrawFinger
            JMP Done
        @menuRations:
            LDA wagonSettings
            AND #%00001100
            LSR
            LSR
            STA helper
            LDA #%11110011
            AND wagonSettings
            STA wagonSettings
            DEC helper
            LDA helper
            AND #%00000011
            CMP #0
            BNE :+
            LDA #3
            :
            CLC
            ROL
            ROL
            ORA wagonSettings
            STA wagonSettings
            JSR DrawRationsSubmenu
            JSR RedrawFinger
            JMP Done
        @menuRest:
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
            JSR WriteTileToBuffer
            JSR DrawRestSubmenu
            JSR RedrawFinger
            JMP Done
    CheckLeft:
    CheckRight:
    Done:
    RTS
.endproc

.proc GamepadMap
    RTS
.endproc

.proc DrawPaceSubmenu
    LDX #4 ; top row of menu
    LDY #15
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
    LDY #16
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #4
    LDY #17
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #4
    LDY #18
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #22  ; vertical bars (right)
    LDY #16
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #22
    LDY #17
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #22
    LDY #18
    LDA #_VR
    JSR WriteTileToBuffer

    LDX #4 ; bottom row of menu
    LDY #19
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

    LDX #6  ; "PACE: xxxxxxxxx"
    LDY #17
    JSR SetPpuAddrPointerFromXY
    SBW #15, pointer, pointer+1
        LDX #15
        :
        LDA hudMenuStatusText, X
        WBB
        INX
        CPX #20
        BNE :-
        LDA #___
        WBB
        LDX #0
        LDY #0
        STY helper+1
        LDA wagonSettings
        AND #%00000011
        STA helper
        DEC helper
        :
        CPY helper
        BNE :+
        JMP :++
        :
        INX
        INC helper+1
        LDA helper+1
        CMP #TEXT_PACE_LEN
        BNE :-
        LDA #0
        STA helper+1
        INY
        JMP :--
        :
        LDA paceText, X
        WBB
        INX
        INC helper+1
        LDA helper+1
        CMP #TEXT_PACE_LEN
        BNE :-
    EBW

    RTS
.endproc

.proc DrawRationsSubmenu
    LDX #4 ; top row of menu
    LDY #17
    JSR SetPpuAddrPointerFromXY
    SBW #23, pointer, pointer+1
        LDA #_RD
        WBB
        LDA #_HR
        LDX #0
        :
        WBB
        INX
        CPX #21
        BNE :-
        LDA #_LD
        WBB
    EBW

    LDX #4  ; vertical bars (left)
    LDY #18
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #4
    LDY #19
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #4
    LDY #20
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #26  ; vertical bars (right)
    LDY #18
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #26
    LDY #19
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #26
    LDY #20
    LDA #_VR
    JSR WriteTileToBuffer

    LDX #4 ; bottom row of menu
    LDY #21
    JSR SetPpuAddrPointerFromXY
    SBW #23, pointer, pointer+1
        LDA #_RU
        WBB
        LDA #_HR
        LDX #0
        :
        WBB
        INX
        CPX #21
        BNE :-
        LDA #_LU
        WBB
    EBW

    LDX #6  ; "RATIONS: xxxxxxxxxx"
    LDY #19
    JSR SetPpuAddrPointerFromXY
    SBW 19, pointer, pointer+1
        LDX #20
        :
        LDA hudMenuStatusText, X
        WBB
        INX
        CPX #28
        BNE :-
        LDA #___
        WBB
        LDX #0
        LDY #0
        STY helper+1
        LDA wagonSettings
        AND #%00001100
        LSR
        LSR
        STA helper
        DEC helper
        :
        CPY helper
        BNE :+
        JMP :++
        :
        INX
        INC helper+1
        LDA helper+1
        CMP #TEXT_RATIONS_LEN
        BNE :-
        LDA #0
        STA helper+1
        INY
        JMP :--
        :
        LDA rationsText, X
        WBB
        INX
        INC helper+1
        LDA helper+1
        CMP #TEXT_RATIONS_LEN
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
    JSR WriteTileToBuffer
    LDX #4
    LDY #21
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #4
    LDY #22
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #22  ; vertical bars (right)
    LDY #20
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #22
    LDY #21
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #22
    LDY #22
    LDA #_VR
    JSR WriteTileToBuffer

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

    LDA currentBank
    PHA
    LDY #BANK_DATA ; get image data
    JSR bankswitch_y

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
    
    PLA
    TAY
    JSR bankswitch_y

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

.proc BufferDrawMainMenuHUDValues
    LDA menuOpen
    CMP #MENU_MAINMENU
    BNE Done
    LDA wagonRest
    BEQ Done
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
    LDA #$2C
    STA pointer+1
    JSR BufferDrawHealthText
    Done:
    RTS 
.endproc

.proc BufferDrawTravelingHUDValues
    LDA menuOpen
    CMP #MENU_NONE
    BEQ :+
    JMP Done
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
    Done:
    RTS
.endproc

.proc BufferClearTravelingHUDValue
    SBW #12, pointer, pointer+1
        LDX #12
        LDA #___
        :
        WBB
        DEX
        BNE :-
    EBW
    :                   ; vblankwait for aesthetic reasons
    BIT PPUSTATUS
    BPL :-
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
    :                   ; vblankwait for aesthetic reasons
    BIT PPUSTATUS
    BPL :-
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
    :                   ; vblankwait for aesthetic reasons
    BIT PPUSTATUS
    BPL :-
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
    :                   ; vblankwait for aesthetic reasons
    BIT PPUSTATUS
    BPL :-
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

.proc BufferDrawTalkText
    LDA location ; get memory location of compressed talk text
    ASL
    CLC
    ADC talkOption
    ADC talkOption
    TAX
    LDA talkPointer, X
    STA pointer
    INX
    LDA talkPointer, X
    STA pointer+1
    LDA #$20 ; PPU address - start at top left
    STA bufferHelper
    LDA #$E4
    STA bufferHelper+1

    LDA currentBank
    PHA
    LDA location ; bankswitch to get text data
    LSR
    LSR
    CLC
    ADC #2
    TAY
    JSR bankswitch_y

    JSR BufferDrawText
    PLA
    TAY
    JSR bankswitch_y

    INC talkOption ; increment talkOption
    LDA talkOption
    CMP #3
    BNE :+
    LDA #0
    STA talkOption
    :
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

; Random events ----------------------------------------------------------------

.proc RandomEvent
    ; Each day, the random event engine goes through each of the random events
    ; to determine if that event will occur on that day, based on the current
    ; probability. However, if one of the events does indeed occur, then the
    ; random event engine halts. As a result, no more than one random event 
    ; occurs in a single day.
    LDA wagonRest ; no random event if resting? TODO confirm
    BEQ :+
    JMP Done
    :
    LDA #0
    STA helper ; flag to halt the random event engine: 1 is done

    JSR REIndianFood
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REThunderstorm
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REBlizzard
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REHeavyFog
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REHailStorm
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REInjuredOx
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REInjuredPerson
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR RESnakeBite
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR RELoseTrail
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REWrongTrail
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR RERoughTrail
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REImpassibleTrail
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REWildFruit
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REFireWagon
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR RELostPerson
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REOxWandersOff
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REAbandonedWagon
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REThief
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REBadWater
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR RELittleWater
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REInadequateGrass
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REIllness
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    JSR REBrokenPart
    LDA helper
    CMP #1
    BNE :+
    JMP Done
    :
    Done:
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
    INC wagonRest ; lose 1 day
    LDA #EVENT_THUNDERSTORM
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
    INC wagonRest ; lose 1 day
    LDA #EVENT_BLIZZARD
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
    JSR RandomNumberGenerator
    AND #1
    BNE :+
    INC wagonRest ; 50% chance to lose 1 day
    :
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
    JSR RandomNumberGenerator
    AND #1
    BNE :+
    INC wagonRest ; 50% chance to lose 1 day
    :
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
    JSR RandomNumberGenerator
    AND #7
    TAX
    INX
    :
    INC wagonRest
    DEX
    BNE :-
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
    JSR RandomNumberGenerator
    AND #7
    TAX
    INX
    :
    INC wagonRest
    DEX
    BNE :-
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
    JSR RandomNumberGenerator
    AND #7
    TAX
    INX
    :
    INC wagonRest
    DEX
    BNE :-
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

    LDA #1
    STA helper
    Done:
    RTS
.endproc
