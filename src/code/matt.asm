
.proc LoadBgMatt
    LDA menuOpen
    CMP #MENU_MATT_INTRO1 ; "Hello, I'm Matt" page 1
    BNE :+
        JSR ClearScreen
        JSR ClearAttributes
        JSR SetPaletteSupplies
        SBD
        LoadCHR #<mattTilesMeta, #>mattTilesMeta
        LoadImage #<mattImageMeta, #>mattImageMeta
        EBD
        BDrawText newgamePointer+26, newgamePointer+27, #$20, #$84
        BDrawText newgamePointer+28, newgamePointer+29, #$21, #$68
        BDrawText newgamePointer+30, newgamePointer+31, #$21, #$c8
        JSR BufferDrawPressStart
        RTS
    :
    CMP #MENU_MATT_INTRO2 ; "Hello, I'm Matt" page 2
    BNE :+
        BDrawBlankBox #$21, #$68, #24, #5
        BDrawText newgamePointer+32, newgamePointer+33, #$21, #$68
        BDrawText newgamePointer+34, newgamePointer+35, #$21, #$c8
        BDrawText newgamePointer+36, newgamePointer+37, #$22, #$28
        JSR BufferDrawPressStart
        RTS
    :
    CMP #MENU_NONE ; Main general store menu
    BNE :++
        LDA menuCursor
        BNE :+
            LDA #MENU_MATT_OXEN
            STA menuCursor
            BDrawBlankBox #$20, #$84, #23, #4 ; initial drawing
            LDY #3 ; green line
            JSR BufferDrawGreenLine
            BDrawText newgamePointer+38, newgamePointer+39, #$20, #$88
        :
        JMP GenStore
    :
    CMP #MENU_MATT_OXEN
    BNE :+
        LDA #40
        STA cursorDollarsValue
        LDA #0
        STA cursorCentsValue
        STA cartOxen
        STA cartOxen+1
        SetDigit #cartOxenCostDigit, #cartOxen
        LDX #11
        JMP Explain
    :
    CMP #MENU_MATT_FOOD
    BNE :+
        LDA #0
        STA cursorDollarsValue
        STA cartFoodLbs
        STA cartFoodLbs+1
        SetDigit #cartFoodLbsCostDigit, #cartFoodLbs
        LDA #20
        STA cursorCentsValue
        LDX #14
        JMP Explain
    :
    CMP #MENU_MATT_CLOTHING
    BNE :+
        LDA #10
        STA cursorDollarsValue
        LDA #0
        STA cursorCentsValue
        STA cartClothing
        STA cartClothing+1
        SetDigit #cartClothingCostDigit, #cartClothing
        LDX #12
        JMP Explain
    :
    CMP #MENU_MATT_AMMO
    BNE :+
        LDA #2
        STA cursorDollarsValue
        LDA #0
        STA cursorCentsValue
        STA cartBullets
        STA cartBullets+1
        SetDigit #cartBulletsCostDigit, #cartBullets
        LDX #12
        JMP Explain
    :
    CMP #MENU_MATT_WHEELS
    BNE :+
        LDA #10
        STA cursorDollarsValue
        LDA #0
        STA cursorCentsValue
        STA cartSpareParts
        STA cartSpareParts+1
        STA cartItem
        STA cartItem+1
        SetDigit #cartSparePartsCostDigit, #cartSpareParts
        LDX #11
        JMP Explain
    :
    CMP #MENU_MATT_AXLES
    BNE :+
        LDA #0
        STA cartItem
        STA cartItem+1
        PHA
        JMP HowManyWagonX
    :
    CMP #MENU_MATT_TONGUES
    BNE :+
        LDA #0
        STA cartItem
        STA cartItem+1
        PHA
        JMP HowManyWagonX
    :
    CMP #MENU_MATT_GOODLUCK
    BNE :+
        JMP GoodLuck
    :
    RTS

    GenStore:
        LDa #0 ; zero out cart subtotal
        STA cartSubtotalDollars
        STA cartSubtotalDollars+1
        STA cartSubtotalCents
        STA cartItem
        STA cartItem+1
        LDA #3
        STA costCursor
        SetDigit #cartSubtotalDigit, #cartSubtotalDollars
        SetDigit #cartItemDigit, #cartSubtotalDollars

        ; erase to the right of Matt
        BDrawBlankBox #$20, #$c8, #24, #21
        BDrawBlankBox #$23, #$64, #24, #1
        LDA #$ca
        STA bufferHelper
        LDX #6
        :
        TXA
        PHA
        SBW #6, #$23, bufferHelper ; attributes
            LDX #6
            LDA #$ff
            :
            WBB
            DEX
            BNE :-
        EBW
        CLC
        LDA bufferHelper
        ADC #8
        STA bufferHelper
        PLA
        TAX
        DEX
        BNE :--

        BDrawDateText #$20, #$f2
        SBW #6, #$23, #$d2 ; green line
            LDX #6 ; attributes
            LDA #$fa
            :
            WBB
            DEX
            BNE :-
        EBW
        LDY #8
        JSR BufferDrawGreenLine

        LDA #$21 ; Draw item menu
        STA bufferHelper
        LDA #$4b
        STA bufferHelper+1
        LDX #5 ; number of menu options
        LDA #0
        STA counter ; beginning of word index
        LDA mattSuppliesText
        STA helper ; length of word
        STA counter+1 ; end of word index
        :
        TXA
        PHA
        SBW helper, bufferHelper, bufferHelper+1
            INC counter+1
            INC counter
            LDX counter
            :
            LDA mattSuppliesText, X
            WBB
            INX
            CPX counter+1
            BNE :-
            LDA mattSuppliesText, X
            STA helper
            STX counter
            CLC
            LDA counter+1
            ADC mattSuppliesText, X
            STA counter+1
        EBW
        JSR BufferHelperNextLine
        PLA
        TAX
        DEX
        BNE :--

        ; Draw item costs
        BDrawDollarAmount #$21, #$57, #cartOxenCostDigit
        BDrawDollarAmount #$21, #$77, #cartFoodLbsCostDigit
        BDrawDollarAmount #$21, #$97, #cartClothingCostDigit
        BDrawDollarAmount #$21, #$b7, #cartBulletsCostDigit
        BDrawDollarAmount #$21, #$d7, #cartSparePartsCostDigit

        SBW #6, #$23, #$e2 ; green line
            LDX #6 ; attributes
            LDA #$fa
            :
            WBB
            DEX
            BNE :-
        EBW
        LDY #16
        JSR BufferDrawGreenLine
        
        SBW #11, #$22, #$4b ; "Total bill:"
            LDX #0
            :
            LDA storeTotalText, X
            WBB
            INX
            CPX #11
            BNE :-
        EBW
        JSR CalculateCartTotal ; calculate total bill
        BDrawDollarAmount #$22, #$57, #cartDollarsDigit

        SBW #9, #$22, #$ad ; "You have:"
            LDX #11
            :
            LDA storeTotalText, X
            WBB
            INX
            CPX #20
            BNE :-
        EBW
        BDrawDollarAmount #$22, #$b7, #dollarsDigit
        
        ; newgameMattWhichItem: "Which item would you like to buy?"
        BDrawText newgamePointer+40, newgamePointer+41, #$22, #$e8

        ; newgameMattPressStart: "Press start to leave"
        BDrawText newgamePointer+42, newgamePointer+43, #$23, #$48

        RTS
    Explain:
        TXA
        PHA
        SBW #6, #$23, #$d2 ; erase to the right of Matt
            LDX #6 ; attributes
            LDA #$ff
            :
            WBB
            DEX
            BNE :-
        EBW
        SBW #6, #$23, #$e2
            LDX #6 ; attributes
            LDA #$ff
            :
            WBB
            DEX
            BNE :-
        EBW
        BDrawBlankBox #$20, #$c8, #24, #21

        SBW #6, #$23, #$ca ; green line
            LDX #6 ; attributes
            LDA #$af
            :
            WBB
            DEX
            BNE :-
        EBW
        LDY #6
        JSR BufferDrawGreenLine
        SBD
        LDA #5 ; text box width
        STA cartSpareParts+1 ; hack
        LDA menuOpen ; Image
        CMP #MENU_MATT_OXEN
        BNE :+
            LoadCHR #<suppliesOxenTilesMeta, #>suppliesOxenTilesMeta
            LoadImage #<suppliesMattOxenImageMeta, #>suppliesMattOxenImageMeta
            JMP Image
        :
        CMP #MENU_MATT_FOOD
        BNE :+
            LoadCHR #<suppliesFoodTilesMeta, #>suppliesFoodTilesMeta
            LoadImage #<suppliesMattFoodImageMeta, #>suppliesMattFoodImageMeta
            LDA #10 ; text box width
            STA cartSpareParts+1 ; hack
            JMP Image
        :
        CMP #MENU_MATT_CLOTHING
        BNE :+
            LoadCHR #<suppliesClothesTilesMeta, #>suppliesClothesTilesMeta
            LoadImage #<suppliesMattClothesImageMeta, #>suppliesMattClothesImageMeta
            LDA #6 ; text box width
            STA cartSpareParts+1 ; hack
            JMP Image
        :
        CMP #MENU_MATT_AMMO
        BNE :+
            LoadCHR #<suppliesBulletsTilesMeta, #>suppliesBulletsTilesMeta
            LoadImage #<suppliesMattBulletsImageMeta, #>suppliesMattBulletsImageMeta
            LDA #6 ; text box width
            STA cartSpareParts+1 ; hack
            JMP Image
        :
        CMP #MENU_MATT_WHEELS
        BNE :+
            LoadCHR #<suppliesPartsTilesMeta, #>suppliesPartsTilesMeta
            LoadImage #<suppliesMattPartsImageMeta, #>suppliesMattPartsImageMeta
            JMP Image
        :
        EBD
        RTS
    Image:
        EBD
        SEC ; Matt's thoughts on the item
        LDA menuOpen
        SBC #MENU_MATT_OXEN
        ASL
        ADC #44
        TAX
        LDA newgamePointer, X
        STA helper
        INX
        LDA newgamePointer, X
        STA helper+1
        BDrawText helper, helper+1, #$21, #$08
        
        JSR BufferHelperNextLine
        JSR BufferHelperNextLine

        LDA menuOpen
        CMP #MENU_MATT_WHEELS ; spare parts?
        BEQ :+
        ; "How many do you want?"
        BDrawText newgamePointer+54, newgamePointer+55, bufferHelper, bufferHelper+1
        JMP Footer
        :
        LDA #21 ; suppliesText index
        STA counter
        LDA #28
        STA counter+1
        LDX #3
        CLC
        LDA bufferHelper+1
        ADC #2
        STA bufferHelper+1
        :
        TXA
        PHA
        SBW #7+1+11, bufferHelper, bufferHelper+1
            LDX counter
            :
            LDA suppliesText, X
            WBB
            INX
            CPX counter+1
            BNE :-
            LDA #___
            WBB
            LDX #42 ; index of "- $10.00 each"
            :
            LDA mattSuppliesText, X
            WBB
            INX
            CPX #42+11
            BNE :-
        EBW
        JSR BufferHelperNextLine
        CLC
        LDA counter
        ADC #7
        STA counter
        LDA counter+1
        ADC #7
        STA counter+1
        PLA
        TAX
        DEX
        BNE :---
        CLC
        LDA bufferHelper+1
        ADC #$1e
        STA bufferHelper+1
        LDA bufferHelper
        ADC #0
        STA bufferHelper
        ; "How many wagon ___?"
        BDrawText newgamePointer+56, newgamePointer+57, bufferHelper, bufferHelper+1
    HowManyWagonX:
        LDA #_0_
        STA cartItemDigit+3
        SEC
        LDA menuOpen
        SBC #MENU_MATT_WHEELS
        TAX
        LDA #7*3
        :
        CPX #0
        BEQ :+
        CLC
        ADC #7
        DEX
        JMP :-
        :
        CLC
        STA counter
        ADC #7
        STA counter+1
        SBW #7, #$22, #$37
            LDX counter
            :
            LDA suppliesText, X
            WBB
            INX
            CPX counter+1
            BNE :-
        EBW
        LDX #30
        LDA menuOpen
        CMP #MENU_MATT_WHEELS
        BNE :+
            DEX
            JMP :++
        :
        CMP #MENU_MATT_AXLES
        BNE :+
            DEX
            DEX
        :
        LDY #17
        LDA #_QU
        WTB

    Footer:
        ; SBW #8, #$22, #$89 ; box for number input
        BDrawTextBox #$22, #$89, cartSpareParts+1, #3

        SBW #12, #$23, #$48 ; "Bill so far:"
            LDX #0
            :
            LDA mattBillSoFar, X
            WBB
            INX
            CPX #12
            BNE :-
        EBW
        JSR CalculateCartTotal
        SBW #6, #$23, #$55 ; "$____.00"
            LDA #_DL
            WBB
            LDX #0
            :
            LDA cartDollarsDigit, X
            WBB
            INX
            CPX #4
            BNE :-
            LDA #_00
            WBB
        EBW

        LDA #%00010100
        STA fingerAttr
        PLA
        TAX
        BEQ :+
            LDY #22
            JSR MoveFingerToSubmenu
            JMP :++
        :
        JSR RedrawFinger
        :
        SEC
        LDA fingerX
        SBC #10
        STA helper
        SBW helper, #$22, #$cb
            LDA #_UL
            LDX helper
            :
            DEX
            BEQ :+
            WBB
            JMP :-
            :
            LDA #_0_
            WBB
        EBW
        LDA menuOpen
        CMP #MENU_MATT_FOOD
        BNE :+
        LDA #_LB
        LDX #16
        LDY #22
        WTB
        :
        RTS
    GoodLuck:
        BDrawBlankBox #$20, #$68, #24, #24
        LDA #$c2
        STA bufferHelper
        LDX #6
        :
        TXA
        PHA
        SBW #6, #$23, bufferHelper ; attributes
            LDX #6
            LDA #$ff
            :
            WBB
            DEX
            BNE :-
        EBW
        CLC
        LDA bufferHelper
        ADC #8
        STA bufferHelper
        PLA
        TAX
        DEX
        BNE :--
        BDrawText newgamePointer+58, newgamePointer+59, #$21, #$48
        JSR BufferDrawPressStart
        RTS
.endproc

.proc BufferDrawGreenLine
    ; @param Y: tilemap y index
    LDA #$20
    STA bufferHelper
    LDA #$08
    STA bufferHelper+1
    :
    CPY #0
    BEQ :+
    CLC
    JSR BufferHelperNextLine
    DEY
    JMP :-
    :
    SBW #22, bufferHelper, bufferHelper+1
    LDX #22
    LDA #TILE_GREEN_LINE
    :
    WBB
    DEX
    BNE :-
    EBW
    RTS
.endproc

.proc GamepadMatt
    LDA buttons1
    CMP buttons1Last
    BNE :+
    RTS
    :
    LDA buttons1Last 
    BEQ CheckA
    RTS
    CheckA:
        LDA #KEY_A
        BIT buttons1
        BNE :+
        JMP CheckB
        :
        LDA menuOpen
        CMP #MENU_MATT_INTRO1
        BNE :+
            INC menuOpen
            RTS
        :
        LDA menuOpen
        CMP #MENU_MATT_INTRO2
        BNE :+
            LDA #MENU_NONE
            STA menuOpen
            RTS
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
            LDA menuCursor
            STA menuOpen
            RTS
        :
        LDA menuOpen
        CMP #MENU_MATT_OXEN
        BCS :+
        JMP :+++
        :
        CMP #MENU_MATT_GOODLUCK+1
        BCC :+
        JMP :++ 
        :
            ;JSR MattBuyItem
            RTS
        :
        RTS
    CheckB:
        LDA #KEY_B
        BIT buttons1
        BNE :+
        JMP CheckStart
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :++
            LDA menuCursor
            CMP #MENU_MATT_GOODLUCK
            BNE :+
                LDA #9 ; jump back to matt's wares
                STA fingerX
                LDA #10
                STA fingerY
                LDA #MENU_MATT_OXEN
                STA menuCursor
                RTS
            :
            RTS
        :
        RTS
    CheckStart:
        LDA #KEY_START
        BIT buttons1
        BNE :+
        JMP CheckSelect
        :
        LDA menuOpen
        CMP #MENU_MATT_INTRO1
        BNE :+
            INC menuOpen
            RTS
        :
        CMP #MENU_MATT_INTRO2
        BNE :+
            LDA #MENU_NONE
            STA menuOpen
            RTS
        :
        CMP #MENU_NONE
        BNE :++
            LDA menuCursor
            CMP #MENU_MATT_GOODLUCK
            BNE :+
                LDA menuCursor ; proceed to final "Good luck" screen
                STA menuOpen
                RTS
            :
            LDA #6 ; jump to "Press start to leave"
            STA fingerX
            LDA #26
            STA fingerY
            LDA #MENU_MATT_GOODLUCK
            STA menuCursor
            RTS
        :
        CMP #MENU_MATT_OXEN
        BNE :++
            LDX #0
            :
            LDA cartSubtotalDigit, X
            STA cartOxenCostDigit, X
            INX
            CPX #6
            BNE :-
            LDA cartItem
            STA cartOxen
            LDA cartItem+1
            STA cartOxen+1
            JMP GoBack
        :
        CMP #MENU_MATT_FOOD
        BNE :++
            LDX #0
            :
            LDA cartSubtotalDigit, X
            STA cartFoodLbsCostDigit, X
            INX
            CPX #6
            BNE :-
            LDA cartItem
            STA cartFoodLbs
            LDA cartItem+1
            STA cartFoodLbs+1
            JMP GoBack
        :
        CMP #MENU_MATT_CLOTHING
        BNE :++
            LDX #0
            :
            LDA cartSubtotalDigit, X
            STA cartClothingCostDigit, X
            INX
            CPX #6
            BNE :-
            LDA cartItem
            STA cartClothing
            LDA cartItem+1
            STA cartClothing+1
            JMP GoBack
        :
        CMP #MENU_MATT_AMMO
        BNE :++
            LDX #0
            :
            LDA cartSubtotalDigit, X
            STA cartBulletsCostDigit, X
            INX
            CPX #6
            BNE :-
            LDA cartItem
            STA cartBullets
            LDA cartItem+1
            STA cartBullets+1
            GoBack:
            JSR CloseSubmenu
            RTS
        :
        CMP #MENU_MATT_WHEELS
        BNE :+
            NextSparePart:
            CLC
            LDA cartSpareParts
            ADC cartItem
            STA cartSpareParts
            INC menuOpen
            RTS
        :
        CMP #MENU_MATT_AXLES
        BNE :+
            JMP NextSparePart
        :
        CMP #MENU_MATT_TONGUES
        BNE :++
            LDX #0
            :
            LDA cartSubtotalDigit, X
            STA cartSparePartsCostDigit, X
            INX
            CPX #6
            BNE :-
            CLC
            LDA cartSpareParts
            ADC cartItem
            STA cartSpareParts
            JMP GoBack
        :
        CMP #MENU_MATT_GOODLUCK
        BNE :++
            LDA #0
            STA menuCursor
            LDA cartSpareParts ; Transfer cart to inventory
            STA spareParts
            LDX #0
            :
            LDA cartOxen, X
            STA oxenHeadcount, X
            INX
            CPX #8
            BNE :-
            SEC
            LDA dollars ; subtract cost of cart
            SBC cartTotalDollars
            STA dollars
            LDA dollars+1
            SBC cartTotalDollars+1
            STA dollars+1
            SEC
            LDA cents
            SBC cartTotalCents
            STA cents
            MakeChange #dollars, #cents
            LDA #MENU_MATT_LOADING
            STA menuOpen
            RTS
        :
        CMP #MENU_MATT_LOADING
        BNE :+
            LDA #GAMESTATE_LANDMARK
            STA gameState
            RTS
        :
        RTS
    CheckSelect:
        LDA #KEY_SELECT
        BIT buttons1
        BNE :+
        JMP CheckDown
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
            JMP SelectHack
        :
        RTS
    CheckDown:
        LDA #KEY_DOWN
        BIT buttons1
        BNE :+
        JMP CheckUp
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :++
            SelectHack:
            LDX fingerY
            LDA menuCursor
            CMP #MENU_MATT_GOODLUCK
            BEQ :+
            INX
            INC menuCursor
            LDA menuCursor
            CMP #MENU_MATT_WHEELS+1
            BNE :+
                LDA #MENU_MATT_OXEN
                STA menuCursor
                LDX #10 ; wrap to top
            :
            STX fingerY
            RTS
        :
        CMP #MENU_MATT_OXEN
        BNE :+
            LDA #2
            STA counter
            JSR CostCursorDown
            RTS
        :
        CMP #MENU_MATT_FOOD
        BNE :+
            LDA #1
            STA counter
            JSR CostCursorDown
            RTS
        :
        CMP #MENU_MATT_CLOTHING
        BNE :+
            LDA #1
            STA counter
            JSR CostCursorDown
            RTS
        :
        CMP #MENU_MATT_AMMO
        BNE :+
            LDA #20
            STA counter
            JSR CostCursorDown
            RTS
        :
        CMP #MENU_MATT_WHEELS
        BNE :+
            LDA #1
            STA counter
            JSR CostCursorDown
            RTS
        :
        CMP #MENU_MATT_AXLES
        BNE :+
            LDA #4
            STA counter
            JSR CostCursorDown
            RTS
        :
        CMP #MENU_MATT_TONGUES
        BNE :+
            LDA #16
            STA counter
            JSR CostCursorDown
            RTS
        :
        RTS
    CheckUp:
        LDA #KEY_UP
        BIT buttons1
        BNE :+
        JMP CheckLeft
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :++
            LDX fingerY
            LDA menuCursor
            CMP #MENU_MATT_GOODLUCK
            BEQ :+
            DEX
            DEC menuCursor
            LDA menuCursor
            CMP #MENU_MATT_OXEN-1
            BNE :+
                LDA #MENU_MATT_WHEELS
                STA menuCursor
                LDX #14 ; wrap to bottom
            :
            STX fingerY
            RTS
        :
        CMP #MENU_MATT_OXEN
        BNE :+
            LDA #2
            STA counter
            JSR CostCursorUp
            RTS
        :
        CMP #MENU_MATT_FOOD
        BNE :+
            LDA #1
            STA counter
            JSR CostCursorUp
            RTS
        :
        CMP #MENU_MATT_CLOTHING
        BNE :+
            LDA #1
            STA counter
            JSR CostCursorUp
            RTS
        :
        CMP #MENU_MATT_AMMO
        BNE :+
            LDA #20
            STA counter
            JSR CostCursorUp
            RTS
        :
        CMP #MENU_MATT_WHEELS
        BNE :+
            LDA #1
            STA counter
            JSR CostCursorUp
            RTS
        :
        CMP #MENU_MATT_AXLES
        BNE :+
            LDA #4
            STA counter
            JSR CostCursorUp
            RTS
        :
        CMP #MENU_MATT_TONGUES
        BNE :+
            LDA #16
            STA counter
            JSR CostCursorUp
            RTS
        :
        RTS
    CheckLeft:
        LDA #KEY_LEFT
        BIT buttons1
        BNE :+
        JMP CheckRight
        :
        LDA menuOpen
        CMP #MENU_MATT_FOOD
        BNE :++
            ShiftCursorLeft:
            DEC fingerX
            LDA fingerX
            CMP #10
            BNE :+
                INC fingerX
                RTS
            :
            JSR CostCursorLeft
            RTS
        :
        CMP #MENU_MATT_CLOTHING
        BNE :+
            JMP ShiftCursorLeft
        :
        CMP #MENU_MATT_AMMO
        BNE :+
            JMP ShiftCursorLeft
        :
        RTS
    CheckRight:
        LDA #KEY_RIGHT
        BIT buttons1
        BNE :+
        RTS
        :
        LDA menuOpen
        CMP #MENU_MATT_FOOD
        BNE :++
            ShiftCursorRight:
            INC fingerX
            LDA fingerX
            CMP #15
            BNE :+
                DEC fingerX
                RTS
            :
            JSR CostCursorRight
            RTS
        :
        CMP #MENU_MATT_CLOTHING
        BNE :+
            JMP ShiftCursorRight
        :
        CMP #MENU_MATT_AMMO
        BNE :+
            JMP ShiftCursorRight
        :
        RTS
.endproc

.proc CostCursorLeft
    DEC costCursor
    LDX costCursor
    LDA cartItemDigit, X
    CMP #_UL
    BNE :+
    LDA #_0_
    STA cartItemDigit, X
    LDX fingerX
    LDY fingerY
    WTB
    :
    LDA cursorDollarsValue
    STA helper
    LDA cursorCentsValue
    STA helper+1
    LDA #0
    STA cursorDollarsValue
    STA cursorCentsValue
    LDX #10
    :
    CLC
    LDA cursorDollarsValue
    ADC helper
    STA cursorDollarsValue
    DEX
    BNE :-
    LDX #10
    :
    CLC
    LDA cursorCentsValue
    ADC helper+1
    STA cursorCentsValue
    LDA cursorCentsValue
    CMP #100
    BCC :+
        SEC
        LDA cursorCentsValue
        SBC #100
        STA cursorCentsValue
        INC cursorDollarsValue
    :
    DEX
    BNE :--
    RTS
.endproc

.proc CostCursorRight
    INC costCursor
    LDA cursorDollarsValue
    LSR
    TAX
    LDA cursorCentsValue
    LSR
    STA helper
    LDA #0
    STA cursorDollarsValue
    STA cursorCentsValue
    LDY #5
    :
    CPY #0
    BNE :+
    LDY #5
    INC cursorDollarsValue
    :
    CPX #0
    BEQ :+
    DEY
    DEX
    JMP :--
    :
    CPY #5
    BEQ :++
    CPY #0
    BEQ :++
    STY helper+1
    SEC
    LDA #5
    SBC helper+1
    TAY
    :
    CLC
    LDA cursorCentsValue
    ADC #20
    STA cursorCentsValue
    DEY
    BNE :-
    :
    LDX helper
    LDY #5
    :
    CPY #0
    BNE :+
    LDY #5
    INC cursorCentsValue
    :
    CPX #0
    BEQ :+
    DEY
    DEX
    JMP :--
    :
    RTS
.endproc

.proc CostCursorUp
    ; param counter+0: item multiplier
    LDA #0
    STA cartItem
    STA cartItem+1
    LDX costCursor
    LDA cartItemDigit, X
    CMP #_UL
    BNE :+
    LDA #_0_
    STA cartItemDigit, X
    :
    INC cartItemDigit, X
    LDA cartItemDigit, X
    CMP #_1_+1
    BNE :+
    LDA costCursor ; check for max 1999 lb food
    BNE :+
    LDA menuOpen
    CMP #MENU_MATT_FOOD
    BNE :+
    LDA #_0_
    STA cartItemDigit, X
    LDX #1
    JMP Wrap
    :
    LDA cartItemDigit, X
    CMP #_3_+1
    BNE :+
    LDA menuOpen ; check for max 3 spare part
    CMP #MENU_MATT_WHEELS
    BCC :+
    LDA #_0_
    STA cartItemDigit, X
    LDX #3
    JMP Wrap
    :
    LDA cartItemDigit, X
    CMP #_9_+1
    BNE PreCount
    LDA #_0_
    STA cartItemDigit, X
    LDX #9
    Wrap:
    SEC
    LDA cartSubtotalDollars
    SBC cursorDollarsValue
    STA cartSubtotalDollars
    LDA cartSubtotalDollars+1
    SBC #0
    STA cartSubtotalDollars+1
    SEC
    LDA cartSubtotalCents
    SBC cursorCentsValue
    STA cartSubtotalCents
    MakeChange #cartSubtotalDollars, #cartSubtotalCents
    DEX
    BNE Wrap
    JMP Count
    PreCount:
    CLC
    LDA cartSubtotalDollars
    ADC cursorDollarsValue
    STA cartSubtotalDollars
    LDA cartSubtotalDollars+1
    ADC #0
    STA cartSubtotalDollars+1
    CLC
    LDA cartSubtotalCents
    ADC cursorCentsValue
    STA cartSubtotalCents
    MakeChange #cartSubtotalDollars, #cartSubtotalCents
    Count:
    JSR CountSubtotal
    RTS
.endproc

.proc CostCursorDown
    ; param counter+0: item multiplier
    LDA #0
    STA cartItem
    STA cartItem+1
    LDX costCursor
    LDA cartItemDigit, X
    CMP #_UL
    BNE :+
    LDA #_0_
    STA cartItemDigit, X
    :
    DEC cartItemDigit, X
    LDA cartItemDigit, X
    CMP #_0_-1
    BNE PreCount
    LDA menuOpen
    CMP #MENU_MATT_FOOD
    BNE :+
    LDA costCursor
    BNE :+
    LDA #_1_
    STA cartItemDigit, X
    LDX #1
    JMP Wrap
    :
    LDA menuOpen
    CMP #MENU_MATT_WHEELS
    BCC :+
    LDA #_3_
    STA cartItemDigit, X
    LDX #3
    JMP Wrap
    :
    LDA #_9_
    STA cartItemDigit, X
    LDX #9
    Wrap:
    CLC
    LDA cartSubtotalDollars
    ADC cursorDollarsValue
    STA cartSubtotalDollars
    LDA cartSubtotalDollars+1
    ADC #0
    STA cartSubtotalDollars+1
    CLC
    LDA cartSubtotalCents
    ADC cursorCentsValue
    STA cartSubtotalCents
    MakeChange #cartSubtotalDollars, #cartSubtotalCents
    DEX
    BNE Wrap
    JMP Count
    PreCount:
    SEC
    LDA cartSubtotalDollars
    SBC cursorDollarsValue
    STA cartSubtotalDollars
    LDA cartSubtotalDollars+1
    SBC #0
    STA cartSubtotalDollars+1
    SEC
    LDA cartSubtotalCents
    SBC cursorCentsValue
    STA cartSubtotalCents
    MakeChange #cartSubtotalDollars, #cartSubtotalCents
    Count:
    JSR CountSubtotal
    RTS
.endproc

.proc CountSubtotal
    Count:
    LDA counter
    BNE :+
    LDX costCursor
    LDA cartItemDigit, X
    LDX fingerX
    LDY fingerY
    JSR WriteTileToBuffer
    SetDigit #cartSubtotalDigit, #cartSubtotalDollars
    RTS
    :
    DEC counter
    Thousands:
    LDA cartItemDigit
    CMP #_UL
    BEQ Hundreds
    SEC
    SBC #_0_
    TAY
    :
    CPY #0
    BEQ Hundreds
    CLC
    LDA cartItem
    ADC #$e8
    STA cartItem
    LDA cartItem+1
    ADC #$03
    STA cartItem+1
    DEY
    JMP :-
    Hundreds:
    LDA cartItemDigit+1
    CMP #_UL
    BEQ Tens
    SEC
    SBC #_0_
    TAY
    :
    CPY #0
    BEQ Tens
    CLC
    LDA cartItem
    ADC #100
    STA cartItem
    LDA cartItem+1
    ADC #0
    STA cartItem+1
    DEY
    JMP :-
    Tens:
    LDA cartItemDigit+2
    CMP #_UL
    BEQ Ones
    SEC
    SBC #_0_
    TAY
    :
    CPY #0
    BEQ Ones
    CLC
    LDA cartItem
    ADC #10
    STA cartItem
    LDA cartItem+1
    ADC #0
    STA cartItem+1
    DEY
    JMP :-
    Ones:
    SEC
    LDA cartItemDigit+3
    SBC #_0_
    CLC
    ADC cartItem
    STA cartItem
    LDA cartItem+1
    ADC #0
    STA cartItem+1
    JMP Count
    RTS
.endproc

.proc CalculateCartTotal
    LDA #0
    STA cartTotalDollars
    STA cartTotalDollars+1
    STA cartTotalCents

    LDX cartOxen
    :
    CPX #0
    BEQ :+
    CLC
    LDA cartTotalDollars
    ADC #20
    STA cartTotalDollars
    LDA cartTotalDollars+1
    ADC #0
    STA cartTotalDollars+1
    DEX
    JMP :-
    :

    LDA cartFoodLbs
    STA counter
    LDA cartFoodLbs+1
    STA counter+1
    :
    SEC
    LDA counter
    SBC #5
    STA counter
    LDA counter+1
    SBC #0
    STA counter+1
    BIT counter+1
    BPL :+
    CLC
    LDA counter
    ADC #5
    STA counter
    LDA counter+1
    ADC #0
    STA counter+1
    JMP :++
    :
    CLC
    LDA cartTotalDollars
    ADC #1
    STA cartTotalDollars
    LDA cartTotalDollars+1
    ADC #0
    STA cartTotalDollars+1
    JMP :--
    :
    LDX counter
    :
    CPX #0
    BEQ :+
    CLC
    LDA cartTotalCents
    ADC #20
    STA cartTotalCents
    DEX
    JMP :-
    :
    MakeChange #cartTotalDollars, #cartTotalCents

    LDX cartClothing
    :
    CPX #0
    BEQ :+
    CLC
    LDA cartTotalDollars
    ADC #10
    STA cartTotalDollars
    LDA cartTotalDollars+1
    ADC #0
    STA cartTotalDollars+1
    DEX
    JMP :-
    :

    LDA cartBullets
    STA counter
    LDA cartBullets+1
    STA counter+1
    :
    SEC
    LDA counter
    SBC #20
    STA counter
    LDA counter+1
    SBC #0
    STA counter+1
    BIT counter+1
    BPL :+
    CLC
    LDA counter
    ADC #20
    STA counter
    LDA counter+1
    ADC #0
    STA counter+1
    JMP :++
    :
    CLC
    LDA cartTotalDollars
    ADC #2
    STA cartTotalDollars
    LDA cartTotalDollars+1
    ADC #0
    STA cartTotalDollars+1
    JMP :--
    :
    LDX counter
    :
    CPX #0
    BEQ :+
    CLC
    LDA cartTotalCents
    ADC #10
    STA cartTotalCents
    DEX
    JMP :-
    :
    MakeChange #cartTotalDollars, #cartTotalCents

    LDA #0
    STA helper
    CLC
    LDA cartSpareParts
    AND #%00000011
    ADC helper
    STA helper
    LDA cartSpareParts
    AND #%00001100
    LSR
    LSR
    ADC helper
    STA helper
    LDA cartSpareParts
    AND #%00110000
    LSR
    LSR
    LSR
    LSR
    ADC helper
    STA helper
    TAX
    :
    CLC
    LDA cartTotalDollars
    ADC #10
    STA cartTotalDollars
    DEX
    BNE :-

    SetDigit #cartDollarsDigit, #cartTotalDollars
    RTS
.endproc

.proc CheckCents
    LDY #0
    LDA (helper2), Y
    BPL :+
    CLC
    LDA (helper2), Y
    ADC #100
    STA (helper2), Y
    SEC
    LDY #0
    LDA (helper), Y
    SBC #1
    STA (helper), Y
    INY
    LDA (helper), Y
    SBC #0
    STA (helper), Y
    RTS
    :
    LDY #0
    LDA (helper2), Y
    CMP #100
    BCC :+
    SEC
    LDA (helper2), Y
    SBC #100
    STA (helper2), Y
    CLC
    LDY #0
    LDA (helper), Y
    ADC #1
    STA (helper), Y
    INY
    LDA (helper), Y
    ADC #0
    STA (helper), Y
    :
    RTS
.endproc
