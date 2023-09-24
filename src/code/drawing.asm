
.proc DrawMenuKeyboard
    JSR StartBulkDrawing
    KBLine0:
        LDA #$22 ; Line 0  top border
        STA PPUADDR
        LDA #$64
        STA PPUADDR
        LDA #_RD ;corner
        STA PPUDATA
        LDA #_HR ;horiz line
        LDX #0
        @topBorderLine:
            STA PPUDATA
            INX
            CPX #(TEXT_KEYBOARD_LEN+1)*2
            BNE @topBorderLine
        LDA #_LD ;corner
        STA PPUDATA

    KBLine1:
        LDA #$22 ; Line 1 blank
        STA PPUADDR
        LDA #$84
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLine2:
        LDA #$22 ; Line 2 qwertyuiop
        STA PPUADDR
        LDA #$a4
        STA PPUADDR
        LDA #_VR ;vert line
        STA PPUDATA
        LDX #0
        @letters1:
            TXA
            AND #%00000001
            BEQ @skipLetter1
            TXA
            LSR
            TAY
            LDA keyboard, Y
            JMP @letter1
            @skipLetter1:
                LDA #0
            @letter1:
            STA PPUDATA
            INX
            CPX #TEXT_KEYBOARD_LEN*2
            BNE @letters1
        LDA #0
        STA PPUDATA
        STA PPUDATA
        LDA #_VR ;vert line
        STA PPUDATA

    KBLine3:
        LDA #$22 ; Line 3 blank
        STA PPUADDR
        LDA #$c4
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLine4:
        LDA #$22 ; Line 4 asdfghjkl
        STA PPUADDR
        LDA #$e4
        STA PPUADDR
        LDA #_VR ;vert line
        STA PPUDATA
        LDX #0
        @letters2:
            TXA
            AND #%00000001
            BEQ @skipLetter2
            TXA
            LSR
            CLC
            ADC #TEXT_KEYBOARD_LEN
            TAY
            LDA keyboard, Y
            JMP @letter2
            @skipLetter2:
                LDA #0
            @letter2:
            STA PPUDATA
            INX
            CPX #TEXT_KEYBOARD_LEN*2
            BNE @letters2
        LDA #0
        STA PPUDATA
        STA PPUDATA
        LDA #_VR ;vert line
        STA PPUDATA

    KBLine5:
        LDA #$23 ; Line 5 blank
        STA PPUADDR
        LDA #$04
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLine6:
        LDA #$23 ; Line 6 zxcvbnm Done
        STA PPUADDR
        LDA #$24
        STA PPUADDR
        LDA #_VR ;vert line
        STA PPUDATA
        LDX #0
        @letters3:
            TXA
            AND #%00000001
            BEQ @skipLetter3
            TXA
            LSR
            CLC
            ADC #TEXT_KEYBOARD_LEN*2
            TAY
            LDA keyboard, Y
            JMP @letter3
            @skipLetter3:
                LDA #0
            @letter3:
            STA PPUDATA
            INX
            CPX #TEXT_KEYBOARD_LEN*2
            BNE @letters3
        LDA #0
        STA PPUDATA
        STA PPUDATA
        LDA #_VR ;vert line
        STA PPUDATA

        LDA #$23 ; Line 6 "DONE"
        STA PPUADDR
        LDA #$36
        STA PPUADDR
        LDX #0 ;loop 4 times
        @letterDone:
            LDA keyboardDone, X
            STA PPUDATA
            INX
            CPX #4
            BNE @letterDone

    KBLine7:
        LDA #$23 ; Line 9 blank
        STA PPUADDR
        LDA #$44
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLine8:
        LDA #$23 ; Line 10  bottom border
        STA PPUADDR
        LDA #$64
        STA PPUADDR
        LDA #_RU ;corner
        STA PPUDATA
        LDA #_HR ;horiz line
        LDX #0
        @bottomBorderLine:
            STA PPUDATA
            INX
            CPX #(TEXT_KEYBOARD_LEN+1)*2
            BNE @bottomBorderLine
        LDA #_LU ;corner
        STA PPUDATA

    JSR DoneBulkDrawing
    RTS
.endproc

.proc DrawStartDateSubmenu
    JSR StartBulkDrawing
    LDA PPUSTATUS
    LDA #$22
    STA PPUADDR
    LDA #$64
    STA PPUADDR
    LDA #_RD
    STA PPUDATA
    LDX #0
    LDA #_HR
    :
    STA PPUDATA
    INX
    CPX #20
    BNE :-
    LDA #_LD
    STA PPUDATA
    LDA PPUSTATUS
    LDA #$22
    STA PPUADDR
    LDA #$84
    STA PPUADDR
    LDA #_VR
    STA PPUDATA
    LDX #0
    LDA #___
    :
    STA PPUDATA
    INX
    CPX #20
    BNE :-
    LDA #_VR
    STA PPUDATA
    LDA PPUSTATUS
    LDA #$22
    STA PPUADDR
    LDA #$A4
    STA PPUADDR
    LDY #0
    LDX #0
    STX helper
    :
    LDA #_VR
    STA PPUDATA
    LDA #___
    STA PPUDATA
    STA PPUDATA
    STA PPUDATA
    :
    LDA startingDateText, X
    STA PPUDATA
    INX
    INC helper
    LDA helper
    CMP #TEXT_STARTDATE_LEN
    BNE :-
    LDA #0
    STA helper
    LDA #___
    STA PPUDATA
    STA PPUDATA
    STA PPUDATA
    STA PPUDATA
    :
    LDA startingDateText, X
    STA PPUDATA
    INX
    INC helper
    LDA helper
    CMP #TEXT_STARTDATE_LEN
    BNE :-
    LDA #___
    STA PPUDATA
    LDA #_VR
    STA PPUDATA
    LDA #___
    STA PPUDATA
    STA PPUDATA
    STA PPUDATA
    STA PPUDATA
    STA PPUDATA
    STA PPUDATA
    JSR DrawStartDateBlankLine
    LDA #___
    STA PPUDATA
    STA PPUDATA
    STA PPUDATA
    STA PPUDATA
    LDA #0
    STA helper
    INY
    CPY #3
    BNE :---
    LDA #_RU
    STA PPUDATA
    LDA #_HR
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #20
    BNE :-
    LDA #_LU
    STA PPUDATA
    JSR DoneBulkDrawing
    RTS
.endproc

; .proc DrawOccupationMenu
;     JSR StartBulkDrawing
;     LDA PPUSTATUS
;     Line0:
;         LDA #$20 ; Line 0  top border
;         STA PPUADDR
;         LDA #$AD
;         STA PPUADDR
;         LDA #_RD ;corner
;         STA PPUDATA
;         LDA #_HR ;horiz line
;         LDX #0 ;loop 15 times
;         :
;         STA PPUDATA
;         INX
;         CPX #15
;         BNE :-
;         LDA #_LD ;corner
;         STA PPUDATA
;     Line1:
;         LDA #$20 ; Line 1 blank
;         STA PPUADDR
;         LDA #$CD
;         STA PPUADDR
;         JSR DrawOccupationMenuBlankLine
;     LDA #0
;     STA helper
;     LDY #7
;     Lines2thru17:
;         LDX #13
;         JSR SetPpuAddrPointerFromXY
;         LDA pointer
;         STA PPUADDR
;         LDA pointer+1
;         STA PPUADDR
;         LDA #_VR ; vertical line
;         STA PPUDATA
;         LDA #___ ; blank space for finger
;         STA PPUDATA
;         STA PPUDATA
;         STA PPUDATA
;         STY pointer
;         STX pointer+1
;         LDX helper
;         LDY #0
;         :
;         LDA occupationText, X
;         STA PPUDATA
;         INY
;         INX
;         INC helper
;         CPY #TEXT_OCCUPATION_LEN
;         BNE :-
;         LDY pointer
;         LDX pointer+1
;         LDA #___
;         STA PPUDATA
;         LDA #_VR
;         STA PPUDATA
;         INY
;         JSR SetPpuAddrPointerFromXY
;         LDA pointer
;         STA PPUADDR
;         LDA pointer+1
;         STA PPUADDR
;         JSR DrawOccupationMenuBlankLine
;         INY
;         CPY #23 ; below line 17
;         BNE Lines2thru17
;     Line18:
;         LDA #$22 ; Line 18 bottom border
;         STA PPUADDR
;         LDA #$ED
;         STA PPUADDR
;         LDA #_RU ;corner
;         STA PPUDATA
;         LDA #_HR ;horiz line
;         LDX #0 ;loop 15 times
;         :
;         STA PPUDATA
;         INX
;         CPX #15
;         BNE :-
;         LDA #_LU ;corner
;         STA PPUDATA
;     JSR DoneBulkDrawing
;     RTS
; .endproc

