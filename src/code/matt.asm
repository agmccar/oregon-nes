
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
    BCS :+
    JMP :+++
    :
    CMP #MENU_MATT_WHEELS+1
    BCC :+
    JMP :++
    :
        JMP Explain
    :
    CMP #MENU_MATT_AXLES
    BNE :+
        JMP HowManyWagonX
    :
    CMP #MENU_MATT_TONGUES
    BNE :+
        JMP HowManyWagonX
    :
    CMP #MENU_MATT_GOODLUCK
    BNE :+
        JMP GoodLuck
    :
    RTS

    GenStore:
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
        CLC
        LDA bufferHelper+1
        ADC #$20
        STA bufferHelper+1
        LDA bufferHelper
        ADC #0
        STA bufferHelper
        PLA
        TAX
        DEX
        BNE :--

        ; Draw item costs
        BDrawDollarAmount #$21, #$57, #cartOxenDigit
        BDrawDollarAmount #$21, #$77, #cartFoodLbsDigit
        BDrawDollarAmount #$21, #$97, #cartClothingDigit
        BDrawDollarAmount #$21, #$b7, #cartBulletsDigit
        BDrawDollarAmount #$21, #$d7, #cartSparePartsDigit

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
        
        CLC ; newline+newline
        LDA bufferHelper+1
        ADC #$40
        STA bufferHelper+1
        LDA bufferHelper
        ADC #0
        STA bufferHelper

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
        CLC
        LDA bufferHelper+1
        ADC #$20
        STA bufferHelper+1
        LDA bufferHelper
        ADC #0
        STA bufferHelper
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
        JSR WriteTileToBuffer

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
    LDA bufferHelper+1
    ADC #$20
    STA bufferHelper+1
    LDA bufferHelper
    ADC #0
    STA bufferHelper
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
        BCS :+
        JMP :+++
        :
        CMP #MENU_MATT_AMMO+1
        BCC :+
        JMP :++
        :
            GoBack:
            LDA #MENU_NONE
            STA menuOpen
            RTS
        :
        CMP #MENU_MATT_WHEELS
        BNE :+
            INC menuOpen
            RTS
        :
        CMP #MENU_MATT_AXLES
        BNE :+
            INC menuOpen
            RTS
        :
        CMP #MENU_MATT_TONGUES
        BNE :+
            JMP GoBack
        :
        CMP #MENU_MATT_GOODLUCK
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
        RTS
    CheckLeft:
        LDA #KEY_LEFT
        BIT buttons1
        BNE :+
        JMP CheckRight
        :
        RTS
    CheckRight:
        LDA #KEY_RIGHT
        BIT buttons1
        BNE :+
        RTS
        :
        RTS
.endproc
