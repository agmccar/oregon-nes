
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
