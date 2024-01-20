
.proc LoadBgRiverMenu
    JSR ClearScreen
    JSR ClearAttributes
    SBD
    JSR DrawAdornments
    LDX #0  ; draw location/date text
    LDY #2
    JSR SetPpuAddrPointerFromXY
    JSR DrawLandmarkTitle
    EBD
    LDA menuOpen
    CMP #MENU_RIVER_INTRO
    BNE :+
        ; You must cross the river ...
        BDrawText riverPointer+0, riverPointer+1, #$21, #$64
        JSR BufferDrawPressStart
        RTS
    :
    CMP #MENU_RIVER_OPTIONS
    BEQ :+
    JMP MenuHelp
    :
        ; "Weather:"
        SBW #8, #$21, #$22
        LDX #0 
        :
        LDA hudMenuStatusText, X
        WBB
        INX
        CPX #8
        BNE :-
        EBW
        LDA #$21
        STA pointer
        LDA #$2B
        STA pointer+1
        JSR BufferDrawWeatherText
        
        ; "River width:"
        BDrawText riverPointer+42, riverPointer+43, #$21, #$42
        SBW #9, #$21, #$4f
        LDX #0
        :
        LDA riverWidthDigit, X
        WBB
        INX
        CPX #4
        BNE :-
        LDX #0
        :
        LDA riverFeet, X
        WBB
        INX
        CPX #5
        BNE :-
        EBW

        ; "River depth:"
        BDrawText riverPointer+44, riverPointer+45, #$21, #$62
        SBW #8, #$21, #$6f
        LDX #0
        :
        LDA riverDepthDigit, X
        WBB
        INX
        CPX #3
        BNE :-
        LDX #0
        :
        LDA riverFeet, X
        WBB
        INX
        CPX #5
        BNE :-
        EBW

        ; "You may:"
        SBW #8, #$21, #$a2
        LDX #1
        :
        LDA whatIsYourChoiceText, X
        WBB
        INX
        CPX #9
        BNE :-
        EBW

        ; attempt to ford the river
        BDrawText riverPointer+2, riverPointer+3, #$21, #$e4
        ; caulk wagon and float it across
        BDrawText riverPointer+4, riverPointer+5, #$22, #$04

        LDA #$22 ; stash ppuaddr of 3rd menu option
        STA bufferHelper
        LDA #$24
        STA bufferHelper+1
        JSR GetRiverAttribute
        BPL :+ ; does river have a ferry?
        ; take a ferry across
        BDrawText riverPointer+6, riverPointer+7, bufferHelper, bufferHelper+1
        JMP Next
        :
        PHA
        AND #%01000000
        BEQ :+ ; does river have a guide?
        PLA
        ; hire an Indian to help
        BDrawText riverPointer+10, riverPointer+11, bufferHelper, bufferHelper+1
        JMP Next
        :
        PLA
        Next:
        JSR BufferHelperNextLine

        ; wait to see if conditions improve
        BDrawText riverPointer+8, riverPointer+9, bufferHelper, bufferHelper+1
        INC bufferHelper+1
        JSR BufferHelperNextLine
        BDrawText riverPointer+46, riverPointer+47, bufferHelper, bufferHelper+1
        JSR BufferHelperNextLine
        DEC bufferHelper+1

        ; get more information
        BDrawText riverPointer+12, riverPointer+13, bufferHelper, bufferHelper+1

        ; What is your choice?
        SBW #20, #$22, #$c2
            LDX #10
            :
            LDA whatIsYourChoiceText, X
            WBB
            INX
            CPX #30
            BNE :-
        EBW

        LDA #%00000100
        STA fingerAttr
        JSR DrawFinger

        RTS
    MenuHelp:
    CMP #MENU_RIVER_HELP
    BNE :++++
        LDA menuCursor
        BNE :+
        ; page 1
        BDrawText riverPointer+14, riverPointer+15, #$21, #$64
        JMP :+++
        :
        LDA menuCursor
        CMP #1
        BNE :+
        ; page 2
        BDrawText riverPointer+16, riverPointer+17, #$21, #$64
        JMP :++
        :
        CMP #2
        BNE :+
        ; page 3
        BDrawText riverPointer+18, riverPointer+19, #$21, #$64
        :
        JSR BufferDrawPressStart
        RTS
    :
    CMP #MENU_RIVER_WAIT
    BNE :+
        ; You camp near the river for a day.
        BDrawText riverPointer+20, riverPointer+21, #$21, #$64
        JSR BufferDrawPressStart
        RTS
    :
    CMP #MENU_RIVER_FERRY
    BNE :+
        ; The ferry operator says ...
        BDrawText riverPointer+34, riverPointer+35, #$21, #$64
        RTS
    :
    CMP #MENU_RIVER_INDIAN
    BNE :+++
        ; page 1
        ; A Shoshoni guide says ...
        ; Will you accept this offer?
        LDA menuCursor
        BNE :+
        BDrawText riverPointer+36, riverPointer+37, #$21, #$64
        BDrawText riverPointer+38, riverPointer+39, #$21, #$a4
        JMP :++
        :
        ; page 2
        ; The Shoshoni guide will help you float your wagon across.
        BDrawText riverPointer+40, riverPointer+41, #$21, #$a4
        :
        JSR BufferDrawPressStart
        RTS
    :
    RTS
.endproc

.proc LoadBgRiverCrossing
    JSR ClearScreen
    JSR ClearAttributes
    SBD
    LoadCHR #<riverWagonTilesMeta, #>riverWagonTilesMeta
    EBD

    RTS
.endproc

.proc GamepadRiver
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
        RTS
    CheckB:
        LDA #KEY_B
        BIT buttons1
        BNE :+
        JMP CheckStart
        :
        RTS
    CheckStart:
        LDA #KEY_START
        BIT buttons1
        BNE :+
        JMP CheckSelect
        :
        LDA menuOpen
        CMP #MENU_RIVER_INTRO
        BNE :+
            LDA #0
            STA menuCursor
            LDA #MENU_RIVER_OPTIONS
            STA menuOpen
        :
        CMP #MENU_RIVER_HELP
        BNE :++
            INC menuCursor
            LDA menuCursor
            CMP #3
            BNE :+
            LDA #0
            STA menuCursor
            LDA #MENU_RIVER_OPTIONS
            STA menuOpen
            RTS
            :
            JSR LoadBgRiverMenu
            RTS
        :
        RTS
    CheckSelect:
        LDA #KEY_SELECT
        BIT buttons1
        BNE :+
        JMP CheckDown
        :
        RTS
    CheckDown:
        LDA #KEY_DOWN
        BIT buttons1
        BNE :+
        JMP CheckUp
        :
        LDA menuOpen
        CMP #MENU_RIVER_OPTIONS
        BNE :++++
            LDA menuCursor
            CMP #3 ; "wait to see.." option
            BNE :+
            INC fingerY
            :
            INC menuCursor
            LDA menuCursor
            CMP #2 ; ferry/guide option
            BNE :+
            JSR GetRiverAttribute
            AND #%11000000
            BNE :+
            INC menuCursor
            :
            INC fingerY
            LDA menuCursor
            CMP #5 ; after last option
            BNE :+
            LDA #0 ; wrap to top
            STA menuCursor
            LDA #15
            STA fingerY 
            :
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
        CMP #MENU_RIVER_OPTIONS
        BNE :++++
            LDA menuCursor
            BNE :+
            LDA #20
            STA fingerY
            LDA #4
            STA menuCursor
            RTS
            :
            DEC menuCursor
            DEC fingerY
            JSR GetRiverAttribute
            AND #%11000000
            BNE :+
            LDA menuCursor
            CMP #2
            BNE :+
            DEC menuCursor
            :
            LDA menuCursor
            CMP #3
            BNE :+
            DEC fingerY
            :
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
