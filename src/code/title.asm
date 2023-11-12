
.proc BufferDrawTopTen
    LDX #18 ; draw "The Oregon Top Ten"
    JSR StartBufferWrite
        LDA #18
        WBB
        LDA #$20
        WBB
        LDA #$87
        WBB
        LDX #0
        :
        LDA topTenHeaderText, X
        WBB
        INX
        CPX #18
        BNE :-
    EBW

    LDX #5 ; draw column headers
    JSR StartBufferWrite
        LDA #5
        WBB
        LDA #$20
        WBB
        LDA #$c4
        WBB
        LDA #TILE_COL_HEADER ; vert line
        WBB
        LDX #0
        :
        LDA topTenColumnText, X
        WBB
        INX
        CPX #4
        BNE :-
    EBW
    LDX #7
    JSR StartBufferWrite
        LDA #7
        WBB
        LDA #$20
        WBB
        LDA #$cc
        WBB
        LDA #TILE_COL_HEADER ; vert line
        WBB
        LDX #4
        :
        LDA topTenColumnText, X
        WBB
        INX
        CPX #10
        BNE :-
    EBW
    LDX #7
    JSR StartBufferWrite
        LDA #7
        WBB
        LDA #$20
        WBB
        LDA #$d4
        WBB
        LDA #TILE_COL_HEADER ; vert line
        WBB
        LDX #10
        :
        LDA topTenColumnText, X
        WBB
        INX
        CPX #16
        BNE :-
    EBW
    LDX #6
    JSR StartBufferWrite
        LDA #6
        WBB
        LDA #$23
        WBB
        LDA #$c9
        WBB
        LDA #%01011111
        LDX #6
        :
        WBB
        DEX
        BNE :-
    EBW



    LDA #0 ; draw 10 rows: name/points/rating
    STA helper ; index of row data in oregonTopTen
    LDA #8
    STA helper+1 ; end of Top Ten name data
    LDA #$21
    STA pointer ; screen location of row
    LDA #$03
    STA pointer+1
    LDX #10 ; number of rows
    NextRow:
    TXA
    PHA
    LDX #27
    JSR StartBufferWrite
        LDA #27
        WBB
        LDA pointer
        WBB
        LDA pointer+1
        WBB
        LDX helper
        :
        LDA oregonTopTen, X
        WBB ; write name
        INX
        CPX helper+1
        BNE :-
        LDA #___ ; two spaces
        WBB
        WBB
        LDA oregonTopTen, X ; stash this row's score
        STA counter+1
        INX
        LDA oregonTopTen, X
        STA counter
        INX ; stash index of next row data
        STX helper
        CLC
        LDA helper+1
        ADC #10 ; stash index of end of next row's name data
        STA helper+1
        LDX #cartHelperDigit
        LDY #counter
        JSR SetDigitFromValue
        LDX #0
        :
        LDA cartHelperDigit, X
        CMP #_UL
        BNE :+
        LDA #___
        :
        WBB ; score (decimal characters)
        INX
        CPX #4
        BNE :--
        LDA #___ ; two spaces
        WBB
        WBB
        LDA counter+1
        CMP topTenRating ; Good enough for "Trail Guide"?
        BCC Adventurer
        BNE :+
        LDA counter
        CMP topTenRating+1
        BCC Adventurer
        :
        LDX #2 ; index of "Trail Guide"
        LDA #2+11
        STA helper2
        JMP Rating
        Adventurer:
        LDA counter+1
        CMP topTenRating+13 ; index of "Adventurer" score high byte
        BCC Greenhorn
        BNE :+
        LDA counter
        CMP topTenRating+14
        BCC Greenhorn
        :
        LDX #15 ; index of "Adventurer"
        LDA #15+11
        STA helper2
        JMP Rating
        Greenhorn:
        LDX #28 ; index of "Greenhorn"
        LDA #28+11
        STA helper2
        Rating:
        LDA topTenRating, X
        WBB
        INX
        CPX helper2
        BNE Rating
    EBW
    JSR PointerToNextLine
    PLA
    TAX
    DEX
    BEQ :+
    JMP NextRow
    :
    LDX #0
    LDA #___
    :
    STA popupTextLine1, X
    STA popupTextLine2, X
    INX
    CPX #TEXT_POPUP_LINE_LEN
    BNE :-
    LDX #0
    :
    LDA topTenQuestionText, X
    STA popupTextLine1, X
    INX
    CPX #21 ; len("Would you like to see")
    BNE :-
    LDY #0
    :
    LDA topTenQuestionText, X
    STA popupTextLine2, Y
    INX
    INY
    CPX #19+21 ;  +len("how pts are earned?")
    BNE :-


    JSR BufferDrawTextBox
    RTS
.endproc

.proc BufferClearTitle
    SBW #6, #$23, #$e1 ; clear attr
        LDA #$ff
        LDX #6
        :
        WBB
        DEX
        BNE :-
    EBW

    LDX #14 ; clear 14 rows of tiles
    LDA #$21
    STA pointer+1
    LDA #$40
    STA pointer
    Line:
    TXA
    PHA
    SBW #$20, pointer+1, pointer
        LDX #0
        LDA #___
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
    ADC #0
    STA pointer+1
    PLA
    TAX
    DEX
    BNE Line
    RTS
.endproc

.proc BufferDrawTitleLearn
    JSR BufferClearTitle
    LDA menuCursor
    ASL
    TAX
    LDA learnPointer, X
    STA pointer
    INX
    LDA learnPointer, X
    STA pointer+1
    LDA #$21
    STA bufferHelper
    LDA #$64
    STA bufferHelper+1
    JSR BufferDrawText

    LDA menuCursor
    CMP #5 ; "Adjust your monitor" page
    BEQ :+
    JMP Done
    :
    SBW #TEXT_POPUP_LINE_LEN, #$22, #$a4
        LDX #0 ; colors text
        :
        LDA titleColorsText, X
        WBB
        INX
        CPX #TEXT_POPUP_LINE_LEN
        BNE :-
    EBW
    
    LDA #$22 ; color squares
    STA pointer
    LDA #$04
    STA pointer+1
    LDX #4
    ColorSquares:
    TXA
    PHA
    SBW #24, pointer, pointer+1
        LDX #4
        LDA #TILE_LIGHT_SQ
        STA helper
        @sq:
        TXA
        PHA
        LDA #0
        WBB
        LDX #4
        :
        LDA helper
        WBB
        DEX
        BNE :-
        LDA #0
        WBB
        PLA
        TAX
        CPX #4
        BCS :+
        LDA #TILE_DARK_SQ
        STA helper
        :
        DEX
        BNE @sq
    EBW
    JSR PointerToNextLine
    PLA
    TAX
    DEX
    BNE ColorSquares
    
    SBW #6, #$23, #$e1 ; colorsquare attributes 
        LDA #0
        WBB
        LDA #%10001000
        WBB
        LDA #$aa
        WBB
        WBB
        LDA #%00100010
        WBB
        LDA #0
        WBB
    EBW

    Done:
    JSR BufferDrawPressStart
    RTS
.endproc

.proc BufferDrawTitleSound
    JSR BufferClearTitle
    
    LDA soundPointer
    STA pointer
    LDA soundPointer+1
    STA pointer+1
    LDA #$21
    STA bufferHelper
    LDA #$A4
    STA bufferHelper+1
    JSR BufferDrawText

    LDA soundPointer+2
    STA pointer
    LDA soundPointer+3
    STA pointer+1
    LDA #$22
    STA bufferHelper
    LDA #$04
    STA bufferHelper+1
    JSR BufferDrawText

    BIT gameSettings
    BPL :+
    JMP Done
    :
    SBW #4, #$21, #$cb
    LDA #_O_
    WBB
    LDA #_N_
    WBB
    LDA #_PD
    WBB
    LDA #___
    WBB
    EBW
    Done:
    LDA gameSettings
    EOR #$80
    STA gameSettings
    JSR BufferDrawPressStart
    RTS
.endproc

.proc LoadBgTitle
    JSR ClearScreen
    JSR ClearAttributes ; default palette
    ;JSR BufferDrawTitle
    LDX #0                  ; default palette
    JSR UpdatePalette
    
    SBD ; draw adornments
    JSR DrawAdornments
    JSR DrawTitleLogo
    EBD
    JSR BufferDrawTitleOptions

    LDA #%10010000
    STA softPPUCTRL         ; Ensure NMIs are enabled
    LDA #%00011110 
    STA softPPUMASK         ; turn on screen
    RTS
.endproc

.proc DrawTopTenHelp
    LDA menuCursor
    CMP #4
    BNE :+
    RTS
    :
    JSR ClearScreen
    LDA menuCursor
    CMP #3
    BNE :+
    SBD
    JSR DrawAdornments
    EBD
    :
    LDX #21
    JSR StartBufferWrite ; "On Arriving In Oregon"
        LDA #21
        WBB
        LDA #$20
        WBB
        LDA #$85
        WBB
        LDX #0
        :
        LDA topTenHelpText, X
        WBB
        INX
        CPX #21
        BNE :-
    EBW

    DEC menuCursor
    LDA menuCursor
    ASL
    TAX
    INC menuCursor
    LDA top10Pointer, X
    STA pointer
    INX
    LDA top10Pointer, X
    STA pointer+1
    LDA #$20
    STA bufferHelper
    LDA #$C4
    STA bufferHelper+1
    LDA menuCursor
    CMP #3
    BNE :+
    CLC
    JSR BufferHelperNextLine
    :
    JSR BufferDrawText
    JSR BufferDrawPressStart

    LDA menuCursor
    CMP #1
    BNE :+
    LDA #$23
    STA pointer
    LDA #$e0
    STA pointer+1
    LDA #$f5
    STA helper
    LDA #10
    STA helper+1
    LDA #$22
    STA helper2
    LDA #$04
    STA helper2+1
    LDA #21
    STA counter
    LDA #30
    STA counter+1
    JMP ColorColumnHeaders
    :
    CMP #2
    BNE :+
    LDA #$23
    STA pointer
    LDA #$d8
    STA pointer+1
    LDA #$5f
    STA helper
    LDA #13
    STA helper+1
    LDA #$21
    STA helper2
    LDA #$c3
    STA helper2+1
    LDA #30
    STA counter
    LDA #42
    STA counter+1
    JMP ColorColumnHeaders
    :
    RTS

    ColorColumnHeaders:
    LDX #8
    JSR StartBufferWrite ; color column headers
        LDA #8
        WBB
        LDA pointer
        WBB
        LDA pointer+1
        WBB
        LDX #0
        :
        LDA helper
        WBB
        INX
        CPX #8
        BNE :-
    EBW

    SBW helper+1, helper2, helper2+1 ; "Health of"/"Resources of"
    LDA #TILE_COL_HEADER
    WBB
    LDX counter
    :
    LDA topTenHelpText, X
    WBB
    INX
    CPX counter+1
    BNE :-
    EBW
    CLC
    LDA helper2+1
    ADC #$20
    STA helper2+1
    SBW helper+1, helper2, helper2+1
    LDA #TILE_COL_HEADER
    WBB
    LDA #___
    LDX helper+1
    DEX
    :
    WBB
    DEX
    BNE :-
    EBW
    CLC
    LDA helper2+1
    ADC menuCursor
    STA helper2+1
    INC helper2+1
    INC helper2+1
    SBW #5, helper2, helper2+1 ; "Party"
    LDX #42
    :
    LDA topTenHelpText, X
    WBB
    INX
    CPX #47
    BNE :-
    EBW

    SEC ; next column header
    LDA helper2+1
    SBC #$21
    SBC menuCursor
    CLC
    ADC helper+1
    STA helper2+1
    SBW #11, helper2, helper2+1 ; "Points per"
    LDA #TILE_COL_HEADER
    WBB
    LDX #47
    :
    LDA topTenHelpText, X
    WBB
    INX
    CPX #57
    BNE :-
    EBW
    CLC
    LDA helper2+1
    ADC #$20
    STA helper2+1
    SBW #11, helper2, helper2+1 
    LDA #TILE_COL_HEADER
    WBB
    LDA #___
    LDX #10
    :
    WBB
    DEX
    BNE :-
    EBW
    CLC
    LDA helper2+1
    ADC menuCursor
    STA helper2+1
    INC helper2+1
    INC helper2+1
    LDA #57
    STA counter
    LDA #63
    STA counter+1
    LDA menuCursor
    CMP #2
    BNE :+
    CLC
    LDA counter
    ADC #6
    STA counter
    LDA counter+1
    ADC #6
    STA counter+1
    :
    SBW #6, helper2, helper2+1 ; "Person"/"Item  "
    LDX counter
    :
    LDA topTenHelpText, X
    WBB
    INX
    CPX counter+1
    BNE :-
    EBW

    LDA #$22
    STA pointer
    LDA menuCursor ; table rows
    CMP #1
    BNE Pg2

    LDA #$65
    STA pointer+1
    LDA #0
    STA counter
    STA counter+1
    :
    SBW #9, pointer, pointer+1
        LDX counter
        CLC
        LDA counter
        ADC #9
        STA counter
        :
        LDA healthText, X
        WBB
        INX
        CPX counter
        BNE :-
    EBW
    CLC
    LDA pointer+1
    ADC #14
    STA pointer+1
    SBW #3, pointer, pointer+1
        SEC
        LDA #_5_
        SBC counter+1
        WBB
        LDA #_0_
        WBB
        WBB
    EBW
    CLC
    LDA pointer+1
    ADC #$20-14
    STA pointer+1
    LDA pointer
    ADC #0
    STA pointer
    INC counter+1
    LDA counter+1
    CMP #4
    BNE :--
    RTS

    Pg2:
    SBW #5, #$22, #$24 ; "wagon"
        LDX #0
        :
        LDA topTenResourcesText, X
        WBB
        INX
        CPX #5
        BNE :-
    EBW
    LDX #23
    LDY #17
    LDA #_5_
    WTB
    LDX #24
    LDY #17
    LDA #_0_
    WTB

    SBW #2, #$22, #$44 ; "ox"
        LDX #5
        :
        LDA topTenResourcesText, X
        WBB
        INX
        CPX #7
        BNE :-
    EBW
    LDX #24
    LDY #18
    LDA #_4_
    WTB

    SBW #16, #$22, #$64 ; "spare wagon part"
        LDX #7
        :
        LDA topTenResourcesText, X
        WBB
        INX
        CPX #23
        BNE :-
    EBW
    LDX #24
    LDY #19
    LDA #_2_
    WTB

    SBW #15, #$22, #$84 ; "set of clothing"
        LDX #23
        :
        LDA topTenResourcesText, X
        WBB
        INX
        CPX #38
        BNE :-
    EBW
    LDX #24
    LDY #20
    LDA #_2_
    WTB

    SBW #17, #$22, #$A4 ; "bullets (each 50)"
        LDX #38
        :
        LDA topTenResourcesText, X
        WBB
        INX
        CPX #45
        BNE :-
        LDA #___
        WBB
        LDA #_OP
        WBB
        LDX #0
        :
        LDA topTenResourcesEachText, X
        WBB
        INX
        CPX #4
        BNE :-
        LDA #___
        WBB
        LDA #_5_
        WBB
        LDA #_0_
        WBB
        LDA #_CP
        WBB
    EBW
    LDX #24
    LDY #21
    LDA #_1_
    WTB

    SBW #16, #$22, #$C4 ; "food (each 25 lb)"
        LDX #45
        :
        LDA topTenResourcesText, X
        WBB
        INX
        CPX #49
        BNE :-
        LDA #___
        WBB
        LDA #_OP
        WBB
        LDX #0
        :
        LDA topTenResourcesEachText, X
        WBB
        INX
        CPX #4
        BNE :-
        LDA #___
        WBB
        LDA #_2_
        WBB
        LDA #_5_
        WBB
        LDA #___
        WBB
        LDA #_LB
        WBB
        LDA #_CP
        WBB
    EBW
    LDX #24
    LDY #22
    LDA #_1_
    WTB

    SBW #14, #$22, #$E4 ; "cash (each $5)"
        LDX #49
        :
        LDA topTenResourcesText, X
        WBB
        INX
        CPX #53
        BNE :-
        LDA #___
        WBB
        LDA #_OP
        WBB
        LDX #0
        :
        LDA topTenResourcesEachText, X
        WBB
        INX
        CPX #4
        BNE :-
        LDA #___
        WBB
        LDA #_DL
        WBB
        LDA #_5_
        WBB
        LDA #_CP
        WBB
    EBW
    LDX #24
    LDY #23
    LDA #_1_
    WTB
    
    RTS
.endproc

.proc DrawTitleLogo

    LoadCHR #<titleLogoTilesMeta, #>titleLogoTilesMeta

    LDA #<titleLogoImageMeta
    STA pointer
    LDA #>titleLogoImageMeta
    STA pointer+1
    JSR UnpackImageMeta

    LDA PPUSTATUS ; color title logo
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR
    LDX #0
    LDA #$af
    :
    STA PPUDATA
    INX
    CPX #8
    BNE :-
    LDX #0
    LDA #$aa
    :
    STA PPUDATA
    INX
    CPX #8
    BNE :-
    
    RTS
.endproc

.proc GamepadTitle
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
        CMP #MENU_TITLE_SOUND
        BNE :+
        JMP @menuTitleSound
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
            JMP Done
            :
            CMP #17 ; See the Oregon Top Ten
            BNE :+
            LDA #MENU_TITLE_TOPTEN
            STA menuOpen
            JMP Done
            :
            CMP #19 ; Turn sound [off|on]
            BNE :+
            LDA #MENU_TITLE_SOUND
            STA menuOpen
            JMP Done
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
            LDA menuCursor
            BEQ :++
            JSR DrawTopTenHelp
            INC menuCursor
            LDA menuCursor
            CMP #5
            BEQ :+
            JMP Done
            :
            LDA #0
            STA menuCursor
            :
            LDA #MENU_NONE
            STA menuOpen
            JMP Done
        @menuTitleSound:
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
        BNE :+ ; hack
        JMP CheckUp
        :
        LDA menuOpen
        CMP #MENU_NONE
        BEQ :+
        JMP Done
        :
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
        LDA menuOpen
        CMP #MENU_NONE
        BEQ :+
        JMP Done
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

.proc BufferDrawTitleOptions

    LDA whatIsYourChoiceText
    STA helper ; draw "You may:"
    SBW whatIsYourChoiceText, #$21, #$44
        INC helper
        LDX #1
        :
        LDA whatIsYourChoiceText, X
        WBB
        INX
        CPX helper
        BNE :-
    EBW

    LDA #$21 ; draw options
    STA helper
    LDA #$A6
    STA helper+1
    LDA #0 ; index of byte in titleOptionsText
    STA helper2
    LDA titleOptionsText ; length of option string
    STA helper2+1
    LDY #4 ; amount of options
    Option:
    INC helper2
    LDX helper2+1
    TYA
    PHA
    SBW helper2+1, helper, helper+1
        LDX #0
        :
        TXA
        PHA
        LDX helper2
        LDA titleOptionsText, X
        WBB
        PLA
        TAX
        INX
        INC helper2
        CPX helper2+1
        BNE :-
    EBW
    CLC
    LDA helper+1
    ADC #$40
    STA helper+1
    LDA helper
    ADC #0
    STA helper
    LDX helper2
    LDA titleOptionsText, X
    STA helper2+1
    PLA
    TAY
    DEY
    BNE Option

    SBW #3, #$22, #$71 ; sound On or Off
        LDA #_O_
        WBB
        LDA gameSettings
        BPL :+
        LDA #_F_
        WBB
        LDA #_F_
        WBB
        JMP :++
        :
        LDA #_N_
        WBB
        LDA #___
        WBB
        :
    EBW

    ; draw "What is your choice?"
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
