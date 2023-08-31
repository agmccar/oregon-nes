
.proc ControllerTitle
    LDA buttons1
    CMP buttons1Last
    BNE CheckA
    JMP Done
    CheckA:
        LDA #KEY_A
        BIT buttons1
        BNE :+
        JMP CheckStart
        :
        JMP Done
    CheckStart:
        LDA #KEY_START
        BIT buttons1
        BNE :+
        JMP CheckSelect
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_TITLE_LEARN
        BNE :+
        JMP @menuTitleLearn
        :
        CMP #MENU_TITLE_TOPTEN
        BNE :+
        JMP @menuTitleTopTen
        :
        JMP Done
        @menuNone:
            LDA fingerY
            CMP #13 ; Travel the trail
            BNE :+
            LDA #GAMESTATE_NEWGAME
            STA gameState
            JMP Done
            :
            CMP #15 ; Learn about the trail
            BNE :+
            LDA #MENU_TITLE_LEARN
            STA menuOpen
            :
            CMP #17 ; See the Oregon Top Ten
            BNE :+
            LDA #MENU_TITLE_TOPTEN
            STA menuOpen
            :
            CMP #19 ; Turn sound [off|on]
            BNE :+

            :
            JMP Done
        @menuTitleLearn:
            INC menuCursor
            LDA menuCursor
            CMP #7
            BEQ :+
            JSR BufferDrawTitleLearn
            JMP Done
            :
            LDA #0
            STA menuCursor
            LDA #MENU_NONE
            STA menuOpen
            JMP Done
        @menuTitleTopTen:
            LDA #MENU_NONE
            STA menuOpen
            JMP Done
    CheckSelect:
        LDA #KEY_SELECT
        BIT buttons1
        BNE :+
        JMP CheckDown
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_TITLE_LEARN
        BNE :+
        JMP @menuTitleLearn
        :
        JMP Done
        @menuNone:
            JMP MainMoveDown ; hack
        @menuTitleLearn:
            LDA menuCursor
            CMP #5 ; "adjust colors" screen
            BNE :+
            LDA #1 ; easter egg, switch color mode
            EOR gameSettings
            STA gameSettings
            JSR UpdatePalette
            ; JSR BufferDrawTitleLearn
            :
            JMP Done
    CheckDown:
        LDA #KEY_DOWN
        BIT buttons1
        BNE MainMoveDown ; hack
        JMP CheckUp
        MainMoveDown:
        LDX fingerY
        INX
        INX
        CPX #21 ; check if fingerY is past bottom of menu
        BNE :+
        LDX #13 ; wrap to top of menu
        :
        STX fingerY
        JMP Done
    CheckUp:
        LDA #KEY_UP
        BIT buttons1
        BNE :+
        JMP CheckLeft
        :
        LDX fingerY
        DEX
        DEX
        CPX #11 ; check if fingerY is past top of menu
        BNE :+
        LDX #19 ; wrap to bottom of menu
        :
        STX fingerY
        JMP Done
    CheckLeft:
        LDA #KEY_LEFT
        BIT buttons1
        BNE :+
        JMP CheckRight
        :
        LDA menuOpen
        CMP #MENU_TITLE_TOPTEN
        BEQ :+
        JMP Done
        :
        JSR ToggleYN
        JMP Done
    CheckRight:
        LDA #KEY_RIGHT
        BIT buttons1
        BNE :+
        JMP Done
        :
        LDA menuOpen
        CMP #MENU_TITLE_TOPTEN
        BEQ :+
        JMP Done
        :
        JSR ToggleYN
        JMP Done
    Done:
    RTS
.endproc

; .proc ControllerNewGame -> rom1

.proc ControllerStore
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
        CMP #MENU_STORE_ITEM1
        BNE :+
        JMP @menuItem1
        :
        CMP #MENU_STORE_ITEM2
        BNE :+
        JMP @menuItem2
        :
        CMP #MENU_STORE_ITEM4
        BNE :+
        JMP @menuItem4
        :
        JMP CheckB
        @menuNone:
            LDA fingerY     ; 'Oxen' selected
            CMP #8
            BNE :+
            LDA #MENU_STORE_ITEM2
            STA menuOpen
            JMP Done
            :
            CMP #10         ; 'Clothes' selected
            BNE :+
            LDA #MENU_STORE_ITEM2
            STA menuOpen
            JMP Done
            :
            CMP #12         ; 'Bullets' selected
            BNE :+
            LDA #MENU_STORE_ITEM4
            STA menuOpen
            JMP Done
            :
            CMP #14         ; 'Wheels' selected
            BNE :+
            LDA #MENU_STORE_ITEM1
            STA menuOpen
            JMP Done
            :
            CMP #16         ; 'Axles' selected
            BNE :+
            LDA #MENU_STORE_ITEM1
            STA menuOpen
            JMP Done
            :
            CMP #18         ; 'Tongues' selected
            BNE :+
            LDA #MENU_STORE_ITEM1
            STA menuOpen
            JMP Done
            :
            CMP #20         ; 'lb Food' selected
            BNE :+
            LDA #MENU_STORE_ITEM4
            STA menuOpen
            JMP Done
            :
            JMP Done
        @menuItem1:
        @menuItem2:
        @menuItem4:
            JSR CloseSubmenu
            JMP Done

    CheckB:
        LDA #KEY_B
        BIT buttons1
        BNE :+
        JMP CheckStart
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_STORE_ITEM1
        BNE :+
        JMP @menuItem1
        :
        CMP #MENU_STORE_ITEM2
        BNE :+
        JMP @menuItem2
        :
        CMP #MENU_STORE_ITEM4
        BNE :+
        JMP @menuItem4
        :
        JMP CheckStart
        @menuNone:
            JMP Done
        @menuItem1:
        @menuItem2:
        @menuItem4:
            JSR CloseSubmenu
            JMP Done

    CheckStart:
        LDA #KEY_START
        BIT buttons1
        BNE :+
        JMP CheckLeft
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_STORE_ITEM1
        BNE :+
        JMP @menuItem1
        :
        CMP #MENU_STORE_ITEM2
        BNE :+
        JMP @menuItem2
        :
        CMP #MENU_STORE_ITEM4
        BNE :+
        JMP @menuItem4
        :
        JMP CheckLeft
        @menuNone:
            JSR ValidateCart
            CMP #1
            BEQ :+
            JMP Done
            :
            JSR DoStorePurchase
            LDA #GAMESTATE_LANDMARK
            STA gameState
            JMP Done
        @menuItem1:
        @menuItem2:
        @menuItem4:
        JMP Done

    CheckLeft:
        LDA #KEY_LEFT
        BIT buttons1
        BNE :+
        JMP CheckRight
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_STORE_ITEM1
        BNE :+
        JMP @menuItem1
        :
        CMP #MENU_STORE_ITEM2
        BNE :+
        JMP @menuItem2
        :
        CMP #MENU_STORE_ITEM4
        BNE :+
        JMP @menuItem4
        :
        JMP CheckRight
        @menuNone:
        @menuItem1:
            JMP Done
        @menuItem2:
            LDX fingerX
            DEX
            CPX #5      ; check if finger is too far left
            BNE :+
            LDX #7     ; wrap around to right
            :
            STX fingerX
            JMP Done
        @menuItem4:
            LDX fingerX
            DEX
            CPX #3      ; check if finger is too far left
            BNE :+
            LDX #6     ; wrap around to right
            :
            STX fingerX
            JMP Done
        JMP Done

    CheckRight:
        LDA #KEY_RIGHT
        BIT buttons1
        BNE :+
        JMP CheckUp
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_STORE_ITEM1
        BNE :+
        JMP @menuItem1
        :
        CMP #MENU_STORE_ITEM2
        BNE :+
        JMP @menuItem2
        :
        CMP #MENU_STORE_ITEM4
        BNE :+
        JMP @menuItem4
        :
        JMP CheckUp
        @menuNone:
        @menuItem1:
            JMP Done
        @menuItem2:
            LDX fingerX
            INX
            CPX #8      ; check if finger is too far right
            BNE :+
            LDX #6     ; wrap around to left
            :
            STX fingerX
            JMP Done
        @menuItem4:
            LDX fingerX
            INX
            CPX #7      ; check if finger is too far right
            BNE :+
            LDX #4     ; wrap around to left
            :
            STX fingerX
            JMP Done
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
        CMP #MENU_STORE_ITEM1
        BNE :+
        JMP @menuItem1
        :
        CMP #MENU_STORE_ITEM2
        BNE :+
        JMP @menuItem2
        :
        CMP #MENU_STORE_ITEM4
        BNE :+
        JMP @menuItem4
        :
        JMP CheckDown
        @menuNone:
            LDX fingerY
            DEX
            DEX
            CPX #6      ; check if finger is past top of list
            BNE :+
            LDX #20     ; wrap around to bottom
            :
            STX fingerY
            JMP Done
        @menuItem1:
            LDA fingerY
            CMP #14
            BNE :+
            LDA cartSpareParts ; wheels
            AND #%00000011
            TAY
            INY
            TYA
            AND #%00000011
            TAX
            LDA #%11111100
            AND cartSpareParts
            STA cartSpareParts
            TXA
            ORA cartSpareParts
            STA cartSpareParts
            LDA decimalDigits, X
            LDX fingerX
            LDY fingerY
            JSR WriteTileToBuffer
            JMP Done
            :
            CMP #16
            BNE :+
            LDA cartSpareParts ; Axles
            AND #%00001100
            LSR
            LSR
            TAY
            INY
            TYA
            AND #%00000011
            TAX
            CLC
            ROL
            ROL
            LDA #%11110011
            AND cartSpareParts
            STA cartSpareParts
            TXA
            CLC
            ROL
            ROL
            ORA cartSpareParts
            STA cartSpareParts
            LDA decimalDigits, X
            LDX fingerX
            LDY fingerY
            JSR WriteTileToBuffer
            JMP Done
            :
            CMP #18
            BNE :+
            LDA cartSpareParts ; Tongues
            AND #%00110000
            LSR
            LSR
            LSR
            LSR
            TAY
            INY
            TYA
            AND #%00000011
            TAX
            CLC
            ROL
            ROL
            ROL
            ROL
            LDA #%11001111
            AND cartSpareParts
            STA cartSpareParts
            TXA
            CLC
            ROL
            ROL
            ROL
            ROL
            ORA cartSpareParts
            STA cartSpareParts
            LDA decimalDigits, X
            LDX fingerX
            LDY fingerY
            JSR WriteTileToBuffer
            :
            JMP Done
        @menuItem2:
            LDA fingerY
            CMP #8
            BNE :+
            LDX #COST_OXEN
            STX cost
            LDX #cartOxenDigit
            JSR IncreaseDigit
            LDX #cartOxenDigit
            LDY #COST_OXEN
            STY cost
            LDY #cartOxen
            JSR SetCartFromDigit
            JMP Done
            :
            CMP #10
            BNE :+
            LDX #COST_CLOTHES
            STX cost
            LDX #cartClothingDigit
            JSR IncreaseDigit
            LDX #cartClothingDigit
            LDY #COST_CLOTHES
            STY cost
            LDY #cartClothing
            JSR SetCartFromDigit
            :
            JMP Done
        @menuItem4:
            LDA fingerY
            CMP #12
            BNE :+
            LDX #COST_BULLETS
            STX cost
            LDX #cartBulletsDigit
            JSR IncreaseDigit
            LDX #cartBulletsDigit
            LDY #COST_BULLETS
            STY cost
            LDY #cartBullets
            JSR SetCartFromDigit
            JMP Done
            :
            CMP #20
            BNE :+
            LDX #COST_FOOD_LB
            STX cost
            LDX #cartFoodLbsDigit
            JSR IncreaseDigit
            LDX #cartFoodLbsDigit
            LDY #COST_FOOD_LB
            STY cost
            LDY #cartFoodLbs
            JSR SetCartFromDigit
            :
            JMP Done
    CheckDown:
        LDA #KEY_DOWN
        BIT buttons1
        BNE :+
        JMP Done
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_STORE_ITEM1
        BNE :+
        JMP @menuItem1
        :
        CMP #MENU_STORE_ITEM2
        BNE :+
        JMP @menuItem2
        :
        CMP #MENU_STORE_ITEM4
        BNE :+
        JMP @menuItem4
        :
        JMP Done
        @menuNone:
            LDX fingerY
            INX
            INX
            CPX #22     ; check if finger is past bottom of list
            BNE :+
            LDX #8      ; wrap around to top
            :
            STX fingerY
            JMP Done
        @menuItem1:
            LDA fingerY
            CMP #14
            BNE :+
            LDA cartSpareParts ; wheels
            AND #%00000011
            TAY
            DEY
            TYA
            AND #%00000011
            TAX
            LDA #%11111100
            AND cartSpareParts
            STA cartSpareParts
            TXA
            ORA cartSpareParts
            STA cartSpareParts
            LDA decimalDigits, X
            LDX fingerX
            LDY fingerY
            JSR WriteTileToBuffer
            JMP Done
            :
            CMP #16
            BNE :+
            LDA cartSpareParts ; Axles
            AND #%00001100
            LSR
            LSR
            TAY
            DEY
            TYA
            AND #%00000011
            TAX
            CLC
            ROL
            ROL
            LDA #%11110011
            AND cartSpareParts
            STA cartSpareParts
            TXA
            CLC
            ROL
            ROL
            ORA cartSpareParts
            STA cartSpareParts
            LDA decimalDigits, X
            LDX fingerX
            LDY fingerY
            JSR WriteTileToBuffer
            JMP Done
            :
            CMP #18
            BNE :+
            LDA cartSpareParts ; Tongues
            AND #%00110000
            LSR
            LSR
            LSR
            LSR
            TAY
            DEY
            TYA
            AND #%00000011
            TAX
            CLC
            ROL
            ROL
            ROL
            ROL
            LDA #%11001111
            AND cartSpareParts
            STA cartSpareParts
            TXA
            CLC
            ROL
            ROL
            ROL
            ROL
            ORA cartSpareParts
            STA cartSpareParts
            LDA decimalDigits, X
            LDX fingerX
            LDY fingerY
            JSR WriteTileToBuffer
            :
            JMP Done
        @menuItem2:
            LDA fingerY
            CMP #8
            BNE :+
            LDX #COST_OXEN
            STX cost
            LDX #cartOxenDigit
            JSR DecreaseDigit
            LDX #cartOxenDigit
            LDY #COST_OXEN
            STY cost
            LDY #cartOxen
            JSR SetCartFromDigit
            JMP Done
            :
            CMP #10
            BNE :+
            LDX #COST_CLOTHES
            STX cost
            LDX #cartClothingDigit
            JSR DecreaseDigit
            LDX #cartClothingDigit
            LDY #COST_CLOTHES
            STY cost
            LDY #cartClothing
            JSR SetCartFromDigit
            :
            JMP Done
        @menuItem4:
            LDA fingerY
            CMP #12
            BNE :+
            LDX #COST_BULLETS
            STX cost
            LDX #cartBulletsDigit
            JSR DecreaseDigit
            LDX #cartBulletsDigit
            LDY #COST_BULLETS
            STY cost
            LDY #cartBullets
            JSR SetCartFromDigit
            JMP Done
            :
            CMP #20
            BNE :+
            LDX #COST_FOOD_LB
            STX cost
            LDX #cartFoodLbsDigit
            JSR DecreaseDigit
            LDX #cartFoodLbsDigit
            LDY #COST_FOOD_LB
            STY cost
            LDY #cartFoodLbs
            JSR SetCartFromDigit
            :
            JMP Done
    Done:
    RTS
.endproc

.proc ControllerLandmark
    LDA buttons1
    CMP buttons1Last
    BNE CheckStart
    JMP Done
    CheckStart:
        LDA #KEY_START
        BIT buttons1
        BNE :+
        JMP Done
        :
        LDA #GAMESTATE_TRAVELING
        STA gameState
    Done:
    RTS
.endproc

.proc ControllerTraveling
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

.proc ControllerMap
    RTS
.endproc
