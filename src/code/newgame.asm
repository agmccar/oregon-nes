
.proc LoadBgNewGame
    JSR ClearScreen
    JSR ClearAttributes

    LDA menuOpen
    CMP #MENU_NEWGAME_OCCUPATION
    BNE :+
    JMP Occupation
    :
    CMP #MENU_NEWGAME_OCC_HELP
    BNE :+
    JMP OccupationHelp
    :
    CMP #MENU_NEWGAME_NAMEPARTY
    BNE :+
    JMP NameParty
    :
    CMP #MENU_NEWGAME_STARTDATE
    BNE :+
    JMP StartDate
    :
    CMP #MENU_NEWGAME_DATE_HELP
    BNE :+
    JMP DateHelp
    :
    RTS
    Occupation:
        JSR StartBulkDrawing
        JSR DrawAdornments
        JSR DoneBulkDrawing
        LDX #0 ; newgameSelectOccupationText
        LDA #$20
        STA bufferHelper
        LDA #$c4
        STA bufferHelper+1
        :
        LDA newgamePointer,X
        STA pointer
        INX
        LDA newgamePointer,X
        STA pointer+1
        INX
        JSR BufferDrawText
        CPX #2
        BNE :+
        CLC
        LDA bufferHelper+1
        ADC #2
        STA bufferHelper+1
        :
        LDA #$60
        STA helper
        CPX #6
        BCC :+
        LDA #$40
        STA helper
        :
        CLC
        LDA bufferHelper+1
        ADC helper
        STA bufferHelper+1
        LDA bufferHelper
        ADC #0
        STA bufferHelper
        CPX #10
        BNE :---
        RTS
    OccupationHelp:
        JSR StartBulkDrawing
        JSR DrawAdornments
        JSR DoneBulkDrawing
        LDX #10 ; newgameOccupationHelpText1
        LDA #$20
        STA bufferHelper
        LDA #$c4
        STA bufferHelper+1
        :
        LDA newgamePointer,X
        STA pointer
        INX
        LDA newgamePointer,X
        STA pointer+1
        INX
        JSR BufferDrawText
        CLC
        LDA bufferHelper+1
        ADC #$40
        STA bufferHelper+1
        LDA bufferHelper
        ADC #0
        STA bufferHelper
        CPX #14
        BNE :-
        JSR BufferDrawPressStart
        RTS
    NameParty:
        JSR StartBulkDrawing
        JSR DrawNamePartyImage
        JSR DrawMenuKeyboard
        JSR DoneBulkDrawing
        BufferStart #29, #$22, #$02
        LDX #0
        :
        LDA newgameNamePartyWhatText, X
        JSR WriteByteToBuffer
        INX
        CPX #29
        BNE :-
        JSR EndBufferWrite

        BufferStart #13, #$22, #$22
        LDX #0
        :
        LDA newgameNamePartyPersonText, X
        JSR WriteByteToBuffer
        INX
        CPX #13
        BNE :-



        
        JSR EndBufferWrite
        
        BufferStart #TEXT_NAME_LEN, #$22, #$37
        LDX #8
        LDA #_UL
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
        JSR EndBufferWrite
        RTS
    StartDate:
        JSR StartBulkDrawing
        JSR DrawAdornments
        JSR LoadTextCHR
        JSR DoneBulkDrawing

        LDA newgamePointer+16 ; "It is 1848. Your jumping off place ..."
        STA pointer
        LDA newgamePointer+17
        STA pointer+1
        LDA #$20
        STA bufferHelper
        LDA #$c4
        STA bufferHelper+1
        JSR BufferDrawText
        
        LDA #$21 ; Month selection list
        STA pointer
        LDA #$c6
        STA pointer+1
        LDX #0
        STX counter
        STX counter+1
        :
        TXA
        PHA
        LDX counter
        LDA startingDateText, X
        STA helper
        INC counter
        CLC
        LDA counter+1
        ADC helper
        STA counter+1
        INC counter+1
        BufferStart helper, pointer, pointer+1
            LDX counter
            :
            LDA startingDateText, X
            JSR WriteByteToBuffer
            INX
            CPX counter+1
            BNE :-
            STX counter
        JSR EndBufferWrite
        JSR PointerToNextLine
        PLA
        TAX
        INX
        CPX #6 ; number of options
        BNE :--

        ; "What is your choice?"
        BufferStart #20, #$22, #$c4
            LDX #0
            :
            LDA whatIsYourChoiceText+10, X
            JSR WriteByteToBuffer
            INX
            CPX #20
            BNE :-
        JSR EndBufferWrite


        RTS
    DateHelp:
        JSR StartBulkDrawing
        JSR DrawAdornments
        JSR DoneBulkDrawing

        LDA newgamePointer+18 ; SelectMonthAdvice1 
        STA pointer
        LDA newgamePointer+19 ; "You attend a public meeting ..."
        STA pointer+1
        LDA #$20
        STA bufferHelper
        LDA #$c4
        STA bufferHelper+1
        JSR BufferDrawText

        LDA newgamePointer+20 ; SelectMonthAdvice2 
        STA pointer
        LDA newgamePointer+21 ; "You attend a public meeting ..."
        STA pointer+1
        LDA #$21
        STA bufferHelper
        LDA #$84
        STA bufferHelper+1
        JSR BufferDrawText
        JSR BufferDrawPressStart
        RTS
.endproc

.proc PressedDoneNextName
    LDA #0
    STA nameCursor
    STA keyboardKey
    LDA #6
    STA fingerX
    LDA #21
    STA fingerY
    INC menuCursor
    LDA menuCursor
    CMP #5 ; Done with all people in party?
    BEQ :+
    JSR BufferDrawNextNamePrompt
    JSR HighlightKeyboardKey
    RTS
    :
    LDA #$22 ; clear screen tiles
    STA pointer
    LDA #$00
    STA pointer+1
    LDX #4*3
    :
    TXA
    PHA
    BufferStart #$20, pointer, pointer+1
    LDA #0
    LDX #$20
    :
    JSR WriteByteToBuffer
    DEX
    BNE :-
    JSR EndBufferWrite
    JSR PointerToNextLine
    PLA
    TAX
    DEX
    BNE :--

    BufferStart #3*8, #$23, #$e0
    LDA #$ff ; clear attr
    LDX #3*8
    :
    JSR WriteByteToBuffer
    DEX
    BNE :-
    JSR EndBufferWrite

    LDA #$22 ; draw party member names
    STA pointer
    LDA #$44
    STA pointer+1
    LDA #TEXT_NAME_LEN
    STA helper+1
    LDX #0
    STX helper
    :
    TXA
    PHA
    BufferStart #TEXT_NAME_LEN+3, pointer, pointer+1
        PLA
        TAX
        CLC
        ADC #_1_
        JSR WriteByteToBuffer
        TXA
        PHA
        LDA #_PD
        JSR WriteByteToBuffer
        LDA #___
        JSR WriteByteToBuffer
        LDX helper
        :
        LDA personName, X
        JSR WriteByteToBuffer
        INX
        INC helper
        CPX helper+1
        BNE :-
    JSR EndBufferWrite
    CLC
    LDA helper+1
    ADC #TEXT_NAME_LEN
    STA helper+1
    JSR PointerToNextLine
    PLA
    TAX
    INX
    CPX #5
    BNE :--

    BufferStart #24, #$23, #$22
    LDX #0
    : ; "Are these names correct?"
    LDA newgameNamePartyCorrectText, X
    JSR WriteByteToBuffer
    INX
    CPX #24
    BNE :-
    JSR EndBufferWrite

    LDA #0
    STA fingerLastLastY
    STA fingerLastY
    LDX #28 ; y/n
    STX fingerX
    LDY #25
    STY fingerY
    LDA #_Y_
    JSR WriteTileToBuffer
    LDA #%00011111
    STA fingerAttr
    JSR DrawFinger
    LDA #MENU_NEWGAME_NAMESCORRECT
    STA menuOpen
    LDA #1
    STA menuCursor

    RTS
.endproc

.proc GamepadNewGame
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
        CMP #MENU_NEWGAME_NAMEPARTY
        BNE :+
        JMP @menuNameParty
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_NAMESCORRECT
        BNE :+
        JMP @menuNamesCorrect
        :
        RTS
        @menuNameParty:
            LDA keyboardKey ; Done?
            CMP #KEYBOARD_DONE
            BNE :+
            JSR PressedDoneNextName
            RTS
            :
            JSR NameKeyHelper
            LDA nameCursor
            CMP #TEXT_NAME_LEN
            BNE :+
            DEC nameCursor
            DEY
            :
            LDX keyboardKey
            LDA keyboard, X
            STA personName, Y
            STA helper+1
            INC nameCursor
            LDA nameCursor
            CMP #TEXT_NAME_LEN
            BNE :+
            LDA #KEYBOARD_DONE ; jump to "DONE" key
            STA keyboardKey
            LDA #22
            STA fingerX
            LDA #25
            STA fingerY
            JSR NameKeyHelper
            DEY
            LDA personName, Y
            STA helper+1
            :
            CLC ; tilex from left
            LDA nameCursor
            ADC #22
            TAX
            LDA helper+1 ; tile index to draw
            LDY #17 ; tiles from top
            JSR WriteTileToBuffer
            JSR HighlightKeyboardKey
            RTS
        @menuNamesCorrect:
            LDA menuCursor
            BEQ :+
            JSR IncrementDate
            JSR SetOpeningBalance
            LDA #MENU_NEWGAME_GOINGBACK
            STA menuOpen
            RTS
            :
            ; "N"
            RTS
    CheckB:
        LDA #KEY_B
        BIT buttons1
        BNE :+
        JMP CheckStart
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_NAMEPARTY
        BNE :+
        JMP @menuNameParty
        :
        RTS
        @menuNameParty:
            DEC nameCursor
            JSR NameKeyHelper
            LDA nameCursor
            CMP #TEXT_NAME_LEN-1
            BEQ :+
            INY
            LDA #___
            STA personName, Y
            DEY
            :
            LDA nameCursor
            BMI :+
            LDA #___
            STA personName, Y
            :
            CLC ; tilex from left
            LDA nameCursor
            ADC #23
            CMP #22
            BEQ :+
            TAX
            LDA #_UL ; tile index to draw
            LDY #17 ; tiles from top
            JSR WriteTileToBuffer
            :
            BIT nameCursor
            BPL :+
            INC nameCursor
            :
            RTS
    CheckStart:
        LDA #KEY_START
        BIT buttons1
        BNE :+
        JMP CheckSelect
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_OCCUPATION
        BNE :+
            JMP @menuOccupation
        :
        CMP #MENU_NEWGAME_OCC_HELP
        BNE :+
            LDA #MENU_NEWGAME_OCCUPATION
            STA menuOpen
            RTS
        :
        CMP #MENU_NEWGAME_NAMEPARTY
        BNE :++
            LDA keyboardKey
            CMP #KEYBOARD_DONE
            BNE :+
            JSR PressedDoneNextName
            RTS
            :
            LDA #KEYBOARD_DONE ; jump to "Done"
            STA keyboardKey
            LDA #22
            STA fingerX
            LDA #25
            STA fingerY
            JSR HighlightKeyboardKey
            RTS
        :
        CMP #MENU_NEWGAME_NAMESCORRECT
        BNE :++
            LDA menuCursor
            BEQ :+
            JSR IncrementDate ; "Y" selected
            JSR SetOpeningBalance
            LDA #MENU_NEWGAME_GOINGBACK
            STA menuOpen
            RTS
            :
            ; LDA #MENU_NEWGAME_CHANGENAME ; "N" selected
            ; STA menuOpen
                ; LDA #$23 ; clear text line
                ; STA bufferHelper
                ; LDA #$22
                ; STA bufferHelper
                ; LDX #28
                ; LDY #1
                ; JSR BufferDrawBlankBox
                ; BufferStart #18, #$23, #$22 ; "Change which name?"
                ; LDX #0
                ; :
                ; LDA newgameNamePartyChangeText, X
                ; JSR WriteByteToBuffer
                ; INX
                ; CPX #18
                ; BNE :-
                ; JSR EndBufferWrite
            
            RTS
        :
        CMP #MENU_NEWGAME_STARTDATE
        BNE :++
            LDA fingerY
            SEC
            SBC #14
            CMP #5
            BEQ :+
            CLC
            ADC #3
            STA dateMonth
            LDA #MENU_NEWGAME_BEFORELEAVING1
            STA menuOpen
            RTS
            :
            LDA #MENU_NEWGAME_DATE_HELP
            STA menuOpen
            RTS
        :
        CMP #MENU_NEWGAME_DATE_HELP
        BNE :+
            LDA #MENU_NEWGAME_STARTDATE
            STA menuOpen
            RTS
        :
        CMP #MENU_NEWGAME_BEFORELEAVING1
        BNE :+
            LDA #MENU_NEWGAME_BEFORELEAVING2
            STA menuOpen
            RTS
        :
        CMP #MENU_NEWGAME_BEFORELEAVING2
        BNE :+
            LDA #MENU_NEWGAME_MATT
            STA menuOpen
            LDA #0
            STA menuCursor
            RTS
        :
        CMP #MENU_NEWGAME_MATT
        BNE :+
            INC menuCursor
            JSR LoadBgMatt
        :
        RTS
        @menuOccupation:
            LDA #MENU_NEWGAME_NAMEPARTY
            STA menuOpen
            LDA fingerY
            CMP #10 ; "Be a banker from Boston"
            BNE :+
            LDA occupationAttribute
            STA occupation
            RTS
            :
            CMP #13 ; "Be a carpenter from Ohio"
            BNE :+
            LDA occupationAttribute+1
            STA occupation
            RTS
            :
            CMP #16 ; "Be a farmer from Illinois"
            BNE :+
            LDA occupationAttribute+2
            STA occupation
            RTS
            :
            CMP #19 ; "Find out the differences between these choices"
            BNE :+
            LDA #MENU_NEWGAME_OCC_HELP
            STA menuOpen
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
        CMP #MENU_NEWGAME_OCCUPATION
        BNE :+
        JMP @menuOccupation
        :
        RTS
        @menuOccupation:
            LDX fingerY
            INX
            INX
            INX
            CPX #22 ; check if fingerY is past bottom of menu
            BNE :+
            LDX #10 ; wrap to top of menu
            :
            STX fingerY
            RTS
    CheckDown:
        LDA #KEY_DOWN
        BIT buttons1
        BNE :+ ; hack
        JMP CheckUp
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_OCCUPATION
        BNE :+
        JMP @menuOccupation
        :
        CMP #MENU_NEWGAME_NAMEPARTY
        BNE :+
        JMP @menuNameParty
        :
        CMP #MENU_NEWGAME_STARTDATE
        BNE :+
        JMP @menuStartDate
        :
        RTS
        @menuOccupation:
            LDX fingerY
            INX
            INX
            INX
            CPX #22 ; check if fingerY is past bottom of menu
            BNE :+
            LDX #10 ; wrap to top of menu
            :
            STX fingerY
            RTS
        @menuNameParty:
            LDX fingerY
            INX
            INX
            LDA keyboardKey
            CLC
            ADC #TEXT_KEYBOARD_LEN
            STA helper
            CPX #27 ; check if fingerY is past bottom of screen
            BEQ @wrapFingerD
            LDA fingerX
            CMP #22 ; check if fingerX is in "DONE" columns
            BCC @moveFingerD
            CPX #25 ; check if fingerY is in 2nd row
            BNE @moveFingerD
            LDA #22
            STA fingerX
            LDA #KEYBOARD_DONE
            STA helper
            JMP @moveFingerD
            @wrapFingerD:
            LDX #21 ; wrap to top row
            LDA keyboardKey
            SEC
            SBC #TEXT_KEYBOARD_LEN*2
            STA helper
            @moveFingerD:
            STX fingerY
            LDA helper
            STA keyboardKey
            JSR HighlightKeyboardKey
            RTS
        @menuStartDate:
            LDX fingerY
            INX
            CPX #20
            BNE :+
            LDX #14 ; wrap to top
            :
            STX fingerY
            RTS
    CheckUp:
        LDA #KEY_UP
        BIT buttons1
        BNE :+
        JMP CheckLeft
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_OCCUPATION
        BNE :+
        JMP @menuOccupation
        :
        CMP #MENU_NEWGAME_NAMEPARTY
        BNE :+
        JMP @menuNameParty
        :
        CMP #MENU_NEWGAME_STARTDATE
        BNE :+
        JMP @menuStartDate
        :
        RTS
        @menuOccupation:
            LDX fingerY
            DEX
            DEX
            DEX
            CPX #7 ; check if fingerY is past top of menu
            BNE :+
            LDX #19 ; wrap to bottom of menu
            :
            STX fingerY
            RTS
        @menuNameParty:
            LDX fingerY
            DEX
            DEX
            LDA keyboardKey
            SEC
            SBC #TEXT_KEYBOARD_LEN
            STA helper
            CPX #19 ; check if fingerY is past top of keyboard
            BNE @moveFingerU
            LDA fingerX
            CMP #22 ; check if we are in last 2 columns
            BCC @wrapFingerU
            LDA #22
            STA fingerX ; wrap to the "DONE" key
            LDA #KEYBOARD_DONE
            STA helper
            LDX #25 ; wrap to bottom of keyboard
            JMP @moveFingerU
            @wrapFingerU:
            LDX #25 ; wrap to bottom of keyboard
            LDA keyboardKey
            CLC
            ADC #TEXT_KEYBOARD_LEN*2
            STA helper
            @moveFingerU:
            STX fingerY
            LDA helper
            STA keyboardKey
            JSR HighlightKeyboardKey
            RTS
        @menuStartDate:
            LDX fingerY
            DEX
            CPX #13
            BNE :+
            LDX #19 ; wrap to bottom
            :
            STX fingerY
            RTS
    CheckLeft:
        LDA #KEY_LEFT
        BIT buttons1
        BNE :+
        JMP CheckRight
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_NAMEPARTY
        BNE :+
        JMP @menuNameParty
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_NAMESCORRECT
        BNE :+
        JMP @menuNamesCorrect
        :
        RTS
        @menuNameParty:
            LDX fingerX
            DEX
            DEX
            DEC keyboardKey
            LDA keyboardKey
            STA helper
            CPX #4  ; check if we need to wrap around
            BNE :+
            LDX #24 ; wrap around
            LDA keyboardKey
            CLC
            ADC #TEXT_KEYBOARD_LEN
            STA helper
            LDA fingerY
            CMP #25 ; check if we need to wrap to the "DONE" keyboard button
            BNE :+
            LDX #22 ; wrap around to "DONE" keyboard button
            LDA #TEXT_KEYBOARD_LEN*3-2
            STA helper
            :
            STX fingerX
            LDA helper
            STA keyboardKey
            JSR HighlightKeyboardKey
            RTS
        @menuNamesCorrect:
            JSR ToggleYN
            RTS
    CheckRight:
        LDA #KEY_RIGHT
        BIT buttons1
        BNE :+
        RTS
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_NAMEPARTY
        BNE :+
        JMP @menuNameParty
        :
        LDA menuOpen
        CMP #MENU_NEWGAME_NAMESCORRECT
        BNE :+
        JMP @menuNamesCorrect
        :
        RTS
        @menuNameParty:
            LDX fingerX
            INX
            INX
            INC keyboardKey
            LDA keyboardKey
            STA helper
            LDA fingerY
            CMP #25 ; check if we are on bottom row
            BNE @wrapFingerNormallyR
            CPX #24 ; check if we need to wrap around the "DONE" key
            BEQ @wrapFingerR
            @wrapFingerNormallyR:
            CPX #26 ; check if we need to wrap around normally
            BNE @moveFingerR
            DEC helper
            @wrapFingerR:
            LDX #6  ; wrap around
            LDA helper
            SEC
            SBC #TEXT_KEYBOARD_LEN-1
            STA helper
            @moveFingerR:
            STX fingerX
            LDA helper
            STA keyboardKey
            JSR HighlightKeyboardKey
            RTS
        @menuNamesCorrect:
            JSR ToggleYN
            RTS
.endproc

.proc NameKeyHelper
    PHA
    LDA menuCursor
    ASL
    ASL
    ASL
    CLC
    ADC nameCursor
    TAY
    PLA
    RTS
.endproc

.proc BufferDrawNextNamePrompt
    BufferStart #$20, #$22, #$22
        LDX #$20
        LDA #0
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite
    BufferStart #3, #$22, #$22
        LDX #0
        LDY menuCursor
        DEY
        :
        CPY #0
        BEQ :+
        INX
        INX
        INX
        DEY
        JMP :-
        :
        TYA
        PHA
        LDA newgameNewPartyNthText, X
        JSR WriteByteToBuffer
        PLA
        TAY
        INX
        INY
        CPY #3
        BNE :-
    JSR EndBufferWrite
    BufferStart #13, #$22, #$22+4
        LDX #13
        :
        LDA newgameNamePartyPersonText, X
        JSR WriteByteToBuffer
        INX
        CPX #26
        BNE :-
    JSR EndBufferWrite
    BufferStart #TEXT_NAME_LEN, #$22, #$37
        LDX #TEXT_NAME_LEN
        LDA #_UL
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite


    RTS
.endproc

.proc BufferDrawIntroTextBox
    BufferStart #8, #$23, #$f0
        LDA #$ff
        LDX #8
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite

    LDA menuOpen
    CMP #MENU_NEWGAME_GOINGBACK
    BEQ :+
    JMP BeforeLeaving1
    :
    LDX #$22 ; text box
    LDY #$02
    LDA #2
    JSR DrawTextBox
    LDA newgamePointer+14 ; newgameGoingBackText 
    STA pointer
    LDA newgamePointer+15 ; "Going back to 1848..."
    STA pointer+1
    LDA #$22
    STA bufferHelper
    LDA #$25
    STA bufferHelper+1
    JSR BufferDrawText
    BufferStart #3, #$22, #$37
        LDA #_PD
        LDX #3
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite
    BufferStart #8, #$23, #$e0 ; attributes
        LDA #%11001110
        JSR WriteByteToBuffer
        LDA #$ff
        LDX #6
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
        LDA #%00110011
        JSR WriteByteToBuffer
    JSR EndBufferWrite
    RTS
    BeforeLeaving1:
    CMP #MENU_NEWGAME_BEFORELEAVING1
    BEQ :+
    JMP BeforeLeaving2
    :
    BufferStart #24, #$23, #$d8 ; attributes
        LDX #3
        :
        TXA
        PHA
        LDA #%11001110
        JSR WriteByteToBuffer
        LDA #$ff
        LDX #6
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
        LDA #%00110011
        JSR WriteByteToBuffer
        PLA
        TAX
        DEX
        BNE :--
    JSR EndBufferWrite
    LDX #$21 ; text box
    LDY #$82
    LDA #9
    JSR DrawTextBox
    LDA newgamePointer+22 ; newgameBeforeLeavingText1
    STA pointer
    LDA newgamePointer+23 ; "Before leaving Independence..."
    STA pointer+1
    LDA #$21
    STA bufferHelper
    LDA #$c4
    STA bufferHelper+1
    JSR BufferDrawText
    BufferStart #5, #$22, #$37
        LDA #_DL
        JSR WriteByteToBuffer
        LDX #0
        STX helper
        :
        LDA dollarsDigit, X
        CPX #0
        BNE :+
        CMP #_0_
        BNE :+
        INX
        JMP :-
        :
        JSR WriteByteToBuffer
        INX
        INC helper
        CPX #4
        BNE :--
        LDA helper
        CMP #3
        BNE :+
        LDA #_00
        JSR WriteByteToBuffer
        :
    JSR EndBufferWrite
    JSR BufferDrawPressStart
    RTS
    BeforeLeaving2:
    CMP #MENU_NEWGAME_BEFORELEAVING2
    BEQ :+
    RTS
    :
    BufferStart #16, #$23, #$e0 ; attributes
        LDA #%11001110
        JSR WriteByteToBuffer
        LDX #6
        LDA #$ff
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
        LDA #%00110011
        JSR WriteByteToBuffer
        LDX #8
        LDA #$ff
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite
    LDX #$22 ; text box
    LDY #$02
    LDA #5
    JSR DrawTextBox
    LDA newgamePointer+24 ; newgameBeforeLeavingText2
    STA pointer
    LDA newgamePointer+25 ; "You can buy whatever you need..."
    STA pointer+1
    LDA #$22
    STA bufferHelper
    LDA #$44
    STA bufferHelper+1
    JSR BufferDrawText
    JSR BufferDrawPressStart
    RTS
.endproc

.proc LoadBgMatt
    LDA menuCursor
    CMP #0
    BNE Page2
        JSR ClearScreen ; "Hello, I'm Matt" page 1
        JSR ClearAttributes
        JSR StartBulkDrawing

        LDA #<mattTilesMeta
        STA pointer
        LDA #>mattTilesMeta
        STA pointer+1
        JSR UnpackTilesMeta

        LDA #<mattImageMeta
        STA pointer
        LDA #>mattImageMeta
        STA pointer+1
        JSR UnpackImageMeta

        JSR DoneBulkDrawing

        LDA newgamePointer+26 ; MattsGeneralStoreHello
        STA pointer
        LDA newgamePointer+27
        STA pointer+1
        LDA #$20
        STA bufferHelper
        LDA #$84
        STA bufferHelper+1
        JSR BufferDrawText

        LDA newgamePointer+28 ; newgameMattsSupplies1
        STA pointer
        LDA newgamePointer+29
        STA pointer+1
        LDA #$21
        STA bufferHelper
        LDA #$68
        STA bufferHelper+1
        JSR BufferDrawText

        LDA newgamePointer+30 ; newgameMattsSupplies2
        STA pointer
        LDA newgamePointer+31
        STA pointer+1
        LDA #$21
        STA bufferHelper
        LDA #$c8
        STA bufferHelper+1
        JSR BufferDrawText

        JSR BufferDrawPressStart
        RTS
    Page2:
        CMP #1 ; "Hello, I'm Matt" page 2
        BEQ :+
        JMP GenStoreInit
        :

        LDA #$21 ; erase text from previous page
        STA bufferHelper
        LDA #$68
        STA bufferHelper+1
        LDX #24
        LDY #5
        JSR BufferDrawBlankBox

        LDA newgamePointer+32 ; newgameMattsSupplies3
        STA pointer
        LDA newgamePointer+33
        STA pointer+1
        LDA #$21
        STA bufferHelper
        LDA #$68
        STA bufferHelper+1
        JSR BufferDrawText

        LDA newgamePointer+34 ; newgameMattsSupplies4
        STA pointer
        LDA newgamePointer+35
        STA pointer+1
        LDA #$21
        STA bufferHelper
        LDA #$c8
        STA bufferHelper+1
        JSR BufferDrawText

        LDA newgamePointer+36 ; newgameMattsSupplies5
        STA pointer
        LDA newgamePointer+37
        STA pointer+1
        LDA #$22
        STA bufferHelper
        LDA #$28
        STA bufferHelper+1
        JSR BufferDrawText

        JSR BufferDrawPressStart
        RTS
    GenStoreInit:
        CMP #2 ; General store main menu, initially
        BEQ :+
        JMP Page4
        :
        LDA #$20 ; erase text from previous page
        STA bufferHelper
        LDA #$84
        STA bufferHelper+1
        LDX #23
        LDY #4
        JSR BufferDrawBlankBox

        LDY #3
        JSR BufferDrawGreenLine

        LDA newgamePointer+38 ; MattsGeneralStore
        STA pointer
        LDA newgamePointer+39
        STA pointer+1
        LDA #$20
        STA bufferHelper
        LDA #$88
        STA bufferHelper+1
        JSR BufferDrawText

        GenStoreAgain:
        LDA #$20 ; erase to the right of Matt
        STA bufferHelper
        LDA #$c8
        STA bufferHelper+1
        LDX #24
        LDY #21
        JSR BufferDrawBlankBox
        LDA #$23
        STA bufferHelper
        LDA #$64
        STA bufferHelper+1
        LDX #24
        LDY #1
        JSR BufferDrawBlankBox
        LDA #$20
        STA pointer
        LDA #$f2
        STA pointer+1
        JSR BufferDrawDateText
        BufferStart #6, #$23, #$d2 ; attributes for green line
        LDX #6
        LDA #$fa
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
        JSR EndBufferWrite
        LDY #8
        JSR BufferDrawGreenLine
        RTS
    Page4:
        JMP GenStoreAgain
    RTS
.endproc

.proc DrawNamePartyImage

    LDA #<namepartyTilesMeta 
    STA pointer
    LDA #>namepartyTilesMeta
    STA pointer+1
    JSR UnpackTilesMeta

    LDA #<namepartyImageMeta
    STA pointer
    LDA #>namepartyImageMeta
    STA pointer+1
    JSR UnpackImageMeta

    RTS
.endproc

.proc LoadBgIndependence
    JSR ClearScreen
    JSR ClearAttributes
    JSR StartBulkDrawing
    JSR DrawLandmarkImage
    LDA menuOpen
    CMP #MENU_NEWGAME_GOINGBACK
    BEQ :+
    JSR LoadTextCHR
    :
    JSR BufferDrawIntroTextBox
    JSR DoneBulkDrawing
    RTS
.endproc

.proc SetOpeningBalance
    LDA #$90        ; default $400.00 dollar amount (#$190)
    STA dollars
    LDA #$01
    STA dollars+1
    LDA #_0_
    STA dollarsDigit
    STA dollarsDigit+2
    STA dollarsDigit+3
    LDA #_4_
    STA dollarsDigit+1
    LDA occupation
    LSR             ; shift occupationAttribute to only starting cash
    LSR
    LSR
    LSR
    LSR
    LSR
    TAY
    CPY #0
    BNE :+
    JMP Done
    :
    CLC
    LDA dollarsDigit+1
    ADC #4
    CMP #_PD ; _8_ + 4 
    BNE :+
    INC dollarsDigit
    LDA #_2_
    :
    STA dollarsDigit+1
    CLC
    LDA #$FF     ; add $400.00 (#$00FF+#$0091) to starting cash, <=4 times
    ADC dollars
    STA dollars
    LDA #$00
    ADC dollars+1
    STA dollars+1
    CLC
    LDA #$91
    ADC dollars
    STA dollars
    LDA #$00
    ADC dollars+1
    STA dollars+1
    DEY
    CPY #0
    BNE :--
    Done:
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
    BufferStart #22, bufferHelper, bufferHelper+1
    LDX #22
    LDA #TILE_GREEN_LINE
    :
    JSR WriteByteToBuffer
    DEX
    BNE :-
    JSR EndBufferWrite
    RTS
.endproc
