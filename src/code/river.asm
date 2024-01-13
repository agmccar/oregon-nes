
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
        
        ; "River width:"
        BDrawText riverPointer+42, riverPointer+43, #$21, #$42

        ; "River depth:"
        BDrawText riverPointer+44, riverPointer+45, #$21, #$62

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
        ; take a ferry across
        BDrawText riverPointer+6, riverPointer+7, #$22, #$24
        ; wait to see if conditions improve
        BDrawText riverPointer+8, riverPointer+9, #$22, #$44
        ; ; hire an Indian to help
        ; BDrawText riverPointer+10, riverPointer+11, #$22, #$44
        ; get more information
        BDrawText riverPointer+12, riverPointer+13, #$22, #$64

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
        RTS
    :
    CMP #MENU_RIVER_FERRY
    BNE :+
        ; The ferry operator says ...
        RTS
    :
    CMP #MENU_RIVER_INDIAN
    BNE :+
        ; page 1
        ; A Shoshoni guide says ...
        ; Will you accept this offer?

        ; page 2
        ; The Shoshoni guide will help you float your wagon across.
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
        RTS
    CheckUp:
        LDA #KEY_UP
        BIT buttons1
        BNE :+
        JMP CheckLeft
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