
.proc BufferDrawTopTen
    LDX #18 ; draw "The Oregon Top Ten"
    JSR StartBufferWrite
        LDA #18
        JSR WriteByteToBuffer
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$87
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA topTenHeaderText, X
        JSR WriteByteToBuffer
        INX
        CPX #18
        BNE :-
    JSR EndBufferWrite

    LDX #5 ; draw column headers
    JSR StartBufferWrite
        LDA #5
        JSR WriteByteToBuffer
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$c4
        JSR WriteByteToBuffer
        LDA #TILE_COL_HEADER ; vert line
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA topTenColumnText, X
        JSR WriteByteToBuffer
        INX
        CPX #4
        BNE :-
    JSR EndBufferWrite
    LDX #7
    JSR StartBufferWrite
        LDA #7
        JSR WriteByteToBuffer
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$cc
        JSR WriteByteToBuffer
        LDA #TILE_COL_HEADER ; vert line
        JSR WriteByteToBuffer
        LDX #4
        :
        LDA topTenColumnText, X
        JSR WriteByteToBuffer
        INX
        CPX #10
        BNE :-
    JSR EndBufferWrite
    LDX #7
    JSR StartBufferWrite
        LDA #7
        JSR WriteByteToBuffer
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$d4
        JSR WriteByteToBuffer
        LDA #TILE_COL_HEADER ; vert line
        JSR WriteByteToBuffer
        LDX #10
        :
        LDA topTenColumnText, X
        JSR WriteByteToBuffer
        INX
        CPX #16
        BNE :-
    JSR EndBufferWrite
    LDX #6
    JSR StartBufferWrite
        LDA #6
        JSR WriteByteToBuffer
        LDA #$23
        JSR WriteByteToBuffer
        LDA #$c9
        JSR WriteByteToBuffer
        LDA #%01011111
        LDX #6
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite



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
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDX helper
        :
        LDA oregonTopTen, X
        JSR WriteByteToBuffer ; write name
        INX
        CPX helper+1
        BNE :-
        LDA #___ ; two spaces
        JSR WriteByteToBuffer
        JSR WriteByteToBuffer
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
        JSR WriteByteToBuffer ; score (decimal characters)
        INX
        CPX #4
        BNE :--
        LDA #___ ; two spaces
        JSR WriteByteToBuffer
        JSR WriteByteToBuffer
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
        JSR WriteByteToBuffer
        INX
        CPX helper2
        BNE Rating
    JSR EndBufferWrite
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
    BufferStart #6, #$23, #$e1 ; clear attr
        LDA #$ff
        LDX #6
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite

    LDX #14 ; clear 14 rows of tiles
    LDA #$21
    STA pointer+1
    LDA #$40
    STA pointer
    Line:
    TXA
    PHA
    BufferStart #$20, pointer+1, pointer
        LDX #0
        LDA #___
        :
        JSR WriteByteToBuffer
        INX
        CPX #$20
        BNE :-
    JSR EndBufferWrite
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
    BufferStart #TEXT_POPUP_LINE_LEN, #$22, #$a4
        LDX #0 ; colors text
        :
        LDA titleColorsText, X
        JSR WriteByteToBuffer
        INX
        CPX #TEXT_POPUP_LINE_LEN
        BNE :-
    JSR EndBufferWrite
    
    LDA #$22 ; color squares
    STA pointer
    LDA #$04
    STA pointer+1
    LDX #4
    ColorSquares:
    TXA
    PHA
    BufferStart #24, pointer, pointer+1
        LDX #4
        LDA #TILE_LIGHT_SQ
        STA helper
        @sq:
        TXA
        PHA
        LDA #0
        JSR WriteByteToBuffer
        LDX #4
        :
        LDA helper
        JSR WriteByteToBuffer
        DEX
        BNE :-
        LDA #0
        JSR WriteByteToBuffer
        PLA
        TAX
        CPX #4
        BCS :+
        LDA #TILE_DARK_SQ
        STA helper
        :
        DEX
        BNE @sq
    JSR EndBufferWrite
    JSR PointerToNextLine
    PLA
    TAX
    DEX
    BNE ColorSquares
    
    BufferStart #6, #$23, #$e1 ; colorsquare attributes 
        LDA #0
        JSR WriteByteToBuffer
        LDA #%10001000
        JSR WriteByteToBuffer
        LDA #$aa
        JSR WriteByteToBuffer
        JSR WriteByteToBuffer
        LDA #%00100010
        JSR WriteByteToBuffer
        LDA #0
        JSR WriteByteToBuffer
    JSR EndBufferWrite

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
    BufferStart #4, #$21, #$cb
    LDA #_O_
    JSR WriteByteToBuffer
    LDA #_N_
    JSR WriteByteToBuffer
    LDA #_PD
    JSR WriteByteToBuffer
    LDA #___
    JSR WriteByteToBuffer
    JSR EndBufferWrite
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
    
    JSR StartBulkDrawing ; draw adornments
    JSR DrawAdornments
    JSR DrawTitleLogo
    JSR DoneBulkDrawing
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
    JSR StartBulkDrawing
    JSR DrawAdornments
    JSR DoneBulkDrawing
    :
    LDX #21
    JSR StartBufferWrite ; "On Arriving In Oregon"
        LDA #21
        JSR WriteByteToBuffer
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$85
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA topTenHelpText, X
        JSR WriteByteToBuffer
        INX
        CPX #21
        BNE :-
    JSR EndBufferWrite

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
    LDA bufferHelper+1
    ADC #$80
    STA bufferHelper+1
    LDA bufferHelper
    ADC #0
    STA bufferHelper
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
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA helper
        JSR WriteByteToBuffer
        INX
        CPX #8
        BNE :-
    JSR EndBufferWrite

    BufferStart helper+1, helper2, helper2+1 ; "Health of"/"Resources of"
    LDA #TILE_COL_HEADER
    JSR WriteByteToBuffer
    LDX counter
    :
    LDA topTenHelpText, X
    JSR WriteByteToBuffer
    INX
    CPX counter+1
    BNE :-
    JSR EndBufferWrite
    CLC
    LDA helper2+1
    ADC #$20
    STA helper2+1
    BufferStart helper+1, helper2, helper2+1
    LDA #TILE_COL_HEADER
    JSR WriteByteToBuffer
    LDA #___
    LDX helper+1
    DEX
    :
    JSR WriteByteToBuffer
    DEX
    BNE :-
    JSR EndBufferWrite
    CLC
    LDA helper2+1
    ADC menuCursor
    STA helper2+1
    INC helper2+1
    INC helper2+1
    BufferStart #5, helper2, helper2+1 ; "Party"
    LDX #42
    :
    LDA topTenHelpText, X
    JSR WriteByteToBuffer
    INX
    CPX #47
    BNE :-
    JSR EndBufferWrite

    SEC ; next column header
    LDA helper2+1
    SBC #$21
    SBC menuCursor
    CLC
    ADC helper+1
    STA helper2+1
    BufferStart #11, helper2, helper2+1 ; "Points per"
    LDA #TILE_COL_HEADER
    JSR WriteByteToBuffer
    LDX #47
    :
    LDA topTenHelpText, X
    JSR WriteByteToBuffer
    INX
    CPX #57
    BNE :-
    JSR EndBufferWrite
    CLC
    LDA helper2+1
    ADC #$20
    STA helper2+1
    BufferStart #11, helper2, helper2+1 
    LDA #TILE_COL_HEADER
    JSR WriteByteToBuffer
    LDA #___
    LDX #10
    :
    JSR WriteByteToBuffer
    DEX
    BNE :-
    JSR EndBufferWrite
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
    BufferStart #6, helper2, helper2+1 ; "Person"/"Item  "
    LDX counter
    :
    LDA topTenHelpText, X
    JSR WriteByteToBuffer
    INX
    CPX counter+1
    BNE :-
    JSR EndBufferWrite

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
    BufferStart #9, pointer, pointer+1
        LDX counter
        CLC
        LDA counter
        ADC #9
        STA counter
        :
        LDA healthText, X
        JSR WriteByteToBuffer
        INX
        CPX counter
        BNE :-
    JSR EndBufferWrite
    CLC
    LDA pointer+1
    ADC #14
    STA pointer+1
    BufferStart #3, pointer, pointer+1
        SEC
        LDA #_5_
        SBC counter+1
        JSR WriteByteToBuffer
        LDA #_0_
        JSR WriteByteToBuffer
        JSR WriteByteToBuffer
    JSR EndBufferWrite
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
    BufferStart #5, #$22, #$24 ; "wagon"
        LDX #0
        :
        LDA topTenResourcesText, X
        JSR WriteByteToBuffer
        INX
        CPX #5
        BNE :-
    JSR EndBufferWrite
    LDX #23
    LDY #17
    LDA #_5_
    JSR WriteTileToBuffer
    LDX #24
    LDY #17
    LDA #_0_
    JSR WriteTileToBuffer

    BufferStart #2, #$22, #$44 ; "ox"
        LDX #5
        :
        LDA topTenResourcesText, X
        JSR WriteByteToBuffer
        INX
        CPX #7
        BNE :-
    JSR EndBufferWrite
    LDX #24
    LDY #18
    LDA #_4_
    JSR WriteTileToBuffer

    BufferStart #16, #$22, #$64 ; "spare wagon part"
        LDX #7
        :
        LDA topTenResourcesText, X
        JSR WriteByteToBuffer
        INX
        CPX #23
        BNE :-
    JSR EndBufferWrite
    LDX #24
    LDY #19
    LDA #_2_
    JSR WriteTileToBuffer

    BufferStart #15, #$22, #$84 ; "set of clothing"
        LDX #23
        :
        LDA topTenResourcesText, X
        JSR WriteByteToBuffer
        INX
        CPX #38
        BNE :-
    JSR EndBufferWrite
    LDX #24
    LDY #20
    LDA #_2_
    JSR WriteTileToBuffer

    BufferStart #17, #$22, #$A4 ; "bullets (each 50)"
        LDX #38
        :
        LDA topTenResourcesText, X
        JSR WriteByteToBuffer
        INX
        CPX #45
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDA #_OP
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA topTenResourcesEachText, X
        JSR WriteByteToBuffer
        INX
        CPX #4
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDA #_5_
        JSR WriteByteToBuffer
        LDA #_0_
        JSR WriteByteToBuffer
        LDA #_CP
        JSR WriteByteToBuffer
    JSR EndBufferWrite
    LDX #24
    LDY #21
    LDA #_1_
    JSR WriteTileToBuffer

    BufferStart #16, #$22, #$C4 ; "food (each 25 lb)"
        LDX #45
        :
        LDA topTenResourcesText, X
        JSR WriteByteToBuffer
        INX
        CPX #49
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDA #_OP
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA topTenResourcesEachText, X
        JSR WriteByteToBuffer
        INX
        CPX #4
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDA #_2_
        JSR WriteByteToBuffer
        LDA #_5_
        JSR WriteByteToBuffer
        LDA #___
        JSR WriteByteToBuffer
        LDA #_LB
        JSR WriteByteToBuffer
        LDA #_CP
        JSR WriteByteToBuffer
    JSR EndBufferWrite
    LDX #24
    LDY #22
    LDA #_1_
    JSR WriteTileToBuffer

    BufferStart #14, #$22, #$E4 ; "cash (each $5)"
        LDX #49
        :
        LDA topTenResourcesText, X
        JSR WriteByteToBuffer
        INX
        CPX #53
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDA #_OP
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA topTenResourcesEachText, X
        JSR WriteByteToBuffer
        INX
        CPX #4
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDA #_DL
        JSR WriteByteToBuffer
        LDA #_5_
        JSR WriteByteToBuffer
        LDA #_CP
        JSR WriteByteToBuffer
    JSR EndBufferWrite
    LDX #24
    LDY #23
    LDA #_1_
    JSR WriteTileToBuffer
    
    RTS
.endproc

.proc DrawTitleLogo

    LDA #<titleLogoTilesMeta
    STA pointer
    LDA #>titleLogoTilesMeta
    STA pointer+1
    JSR UnpackTilesMeta

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
    BufferStart whatIsYourChoiceText, #$21, #$44
        INC helper
        LDX #1
        :
        LDA whatIsYourChoiceText, X
        JSR WriteByteToBuffer
        INX
        CPX helper
        BNE :-
    JSR EndBufferWrite

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
    BufferStart helper2+1, helper, helper+1
        LDX #0
        :
        TXA
        PHA
        LDX helper2
        LDA titleOptionsText, X
        JSR WriteByteToBuffer
        PLA
        TAX
        INX
        INC helper2
        CPX helper2+1
        BNE :-
    JSR EndBufferWrite
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

    BufferStart #3, #$22, #$71 ; sound On or Off
        LDA #_O_
        JSR WriteByteToBuffer
        LDA gameSettings
        BPL :+
        LDA #_F_
        JSR WriteByteToBuffer
        LDA #_F_
        JSR WriteByteToBuffer
        JMP :++
        :
        LDA #_N_
        JSR WriteByteToBuffer
        LDA #___
        JSR WriteByteToBuffer
        :
    JSR EndBufferWrite

    ; draw "What is your choice?"
    BufferStart #20, #$22, #$C4
        LDX #10
        :
        LDA whatIsYourChoiceText, X
        JSR WriteByteToBuffer
        INX
        CPX #30
        BNE :-
    JSR EndBufferWrite
    RTS
.endproc
