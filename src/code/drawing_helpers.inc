
.proc DrawStartDateBlankLine
    PHA
    TXA
    PHA
    LDA #___
    STA PPUDATA
    STA PPUDATA
    STA PPUDATA
    STA PPUDATA
    LDA #_VR
    STA PPUDATA
    LDA #___
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #20
    BNE :-
    LDA #_VR
    STA PPUDATA
    LDA #___
    STA PPUDATA
    STA PPUDATA
    STA PPUDATA
    STA PPUDATA
    STA PPUDATA
    STA PPUDATA
    PLA
    TAX
    PLA
    RTS
.endproc

.proc DrawMenuKeyboardBlankLine
    ; PPUADDR must be set
    LDA #_VR ;vert line
    STA PPUDATA
    LDA #___
    LDX #0 ;loop 23 times
    :
    STA PPUDATA
    INX
    CPX #23
    BNE :-
    LDA #_VR ;vert line
    STA PPUDATA
    RTS
.endproc

.proc DrawLandmarkTitle
    ; pointer: ppuaddr 
    LDA PPUSTATUS   ; set footer bar location
    LDA pointer
    STA PPUADDR
    LDA pointer+1
    STA PPUADDR
    JSR DrawBlankLine   ; start footer bar
    LDX location
    JSR GetLandmarkText
    LDA #32 ; draw landmark text line
    SEC
    SBC helper2
    LSR
    STA helper2+1
    LDX #0
    LDA #0
    :
    STA PPUDATA
    INX
    CPX helper2+1
    BNE :-
    LDX helper
    LDY #0
    :
    LDA diaryLocations, X
    STA PPUDATA
    INX
    INY
    CPY helper2
    BNE :-
    LDA #32
    SEC
    SBC helper2
    SBC helper2+1
    TAX
    LDA #0
    :
    CPX #0
    BNE :+
    JMP :++
    :
    STA PPUDATA
    DEX
    JMP :--
    :
    JSR DrawBlankLine   ; blank line
    LDX #0          ; draw date text line
    LDA #0
    :
    STA PPUDATA
    INX
    CPX #10
    BNE :-
    JSR DrawDateText
    LDA #0
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #10
    BNE :-
    RTS
.endproc

.proc DrawShopEach
    ; A: value to convert to two decimal text digits
    ; destroys X,Y registers
    ; Return: helper,helper+1 - resulting digits
    STA helper
    ROL
    LSR
    LDX #_DL
    STX PPUDATA
    BIT helper
    BPL TwoDigits
    LDX #_PD
    STX PPUDATA
    CMP #1
    BCS OneDigit
    LDX #_0_
    STX PPUDATA
    JMP Done
    OneDigit:
    TAX
    DEX
    TXA
    CLC
    ADC #_1_
    STA PPUDATA
    LDX #_0_
    STX PPUDATA
    JMP Done
    TwoDigits:
    LDY #0
    LDX #_1_
    DEX
    :
    INY
    DEC helper
    CPY #10
    BNE :-
    INX
    LDY #0
    LDA helper
    CMP #10
    BCS :-
    STX PPUDATA
    LDA helper
    CMP #1
    BCS :+
    LDX #_0_
    STX PPUDATA
    LDX #_00
    STX PPUDATA
    JMP Done
    :
    LDX #_1_
    DEX
    :
    INX
    DEC helper
    LDA helper
    CMP #0
    BCS :-
    Done:
    RTS
.endproc

.proc DrawShopCost
    ; X: address of amount in cart
    ; A: cost each -> cost
    ; helper: total tally in dollars
    ; helper2: might be the address of amount in cart, don't touch
    ; cartHelperDigit: total tally in dollars
    STX pointer
    LDY #0
    STY pointer+1
    AND #$7F
    STA cost
    LDA #_DL        ; draw dollar sign
    STA PPUDATA
    LDA #_0_
    STA cartHelperDigit
    LDA #0          ; helper: total tally in dollars
    STA helper
    STA helper+1
    LDA (pointer), Y
    CMP #0          ; is cart empty?
    BNE :+
    LDA #_UL
    STA PPUDATA
    STA PPUDATA
    LDA #_0_
    STA PPUDATA
    STA cartHelperDigit+1
    STA cartHelperDigit+2
    STA cartHelperDigit+3
    JMP Done
    :               ; cart not empty
    TAX
    :
    CLC
    LDA helper
    ADC cost
    STA helper
    LDA helper+1
    ADC #$00
    STA helper+1
    DEX
    CPX #0
    BNE :-
    LDA #_0_            ; convert helper to decimal digits
    STA keyboardKey
    STA cartHelperDigit+1
    :
    LDA helper+1
    CMP #0              ; is helper >= $0100 (256)?
    BNE :+
    LDA helper
    CMP #$64            ; is helper >= $0064 (100)?
    BCC :++
    :
    SEC                 ; subtract $0064 (100)
    LDA helper
    SBC #$64
    STA helper
    LDA helper+1
    SBC #$00
    STA helper+1
    INC keyboardKey
    INC cartHelperDigit+1
    JMP :--
    :
    LDA keyboardKey
    CMP #_0_
    BNE :+
    LDA #_UL
    :
    STA PPUDATA         ; draw 100s place digit
    LDA #_0_
    STA keyboardKey
    STA cartHelperDigit+2
    :
    LDA helper
    CMP #10             ; is helper >= 10?
    BCC :+
    SEC                 ; subtract 10
    LDA helper
    SBC #10
    STA helper
    LDA helper+1
    SBC #0
    STA helper+1
    INC keyboardKey
    INC cartHelperDigit+2
    JMP :-
    :
    LDA keyboardKey
    STA PPUDATA         ; draw 10s place digit
    LDX helper
    LDA decimalDigits, X    ; draw 1s place digit
    STA PPUDATA
    STA cartHelperDigit+3
    Done:
    LDA #_00            ; draw ".00"
    STA PPUDATA
    LDX #cartHelperDigit
    LDA cartDollars
    STA costhelper
    LDA cartDollars+1
    STA costhelper
    LDY #costhelper
    JSR SetValueFromDigit
    CLC
    LDA cartDollars
    ADC costhelper
    STA cartDollars
    LDA cartDollars+1
    ADC costhelper+1
    STA cartDollars+1
    LDX #cartDollarsDigit
    LDY #cartDollars
    JSR SetDigitFromValue
    RTS
.endproc

.proc DrawShopTotal
    LDA #_DL
    STA PPUDATA
    LDA cartDollarsDigit
    STA PPUDATA
    LDA cartDollarsDigit+1
    STA PPUDATA
    LDA cartDollarsDigit+2
    STA PPUDATA
    LDA cartDollarsDigit+3
    STA PPUDATA
    LDA #_00
    STA PPUDATA
    RTS
.endproc

.proc DrawOccupationMenuBlankLine
    ; PPUADDR must be set
    TXA
    PHA
    LDA #_VR ;vert line
    STA PPUDATA
    LDA #___
    LDX #0 ;loop 15 times
    :
    STA PPUDATA
    INX
    CPX #15
    BNE :-
    LDA #_VR ;vert line
    STA PPUDATA
    PLA
    TAX
    RTS
.endproc

.proc DrawDateText
    LDX #0
    :
    LDA dateText, X
    STA PPUDATA
    INX
    CPX #TEXT_DATE_LEN
    BNE :-
    RTS
.endproc

.proc DrawBlankLine
    LDA #___
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #32
    BNE :-
    RTS
.endproc

.proc DrawHorizontalLine
    ; Y: y-coord of the horizontal line
    LDX #0
    JSR SetPpuAddrPointerFromXY
    LDA PPUSTATUS
    LDA pointer
    STA PPUADDR
    LDA pointer+1
    STA PPUADDR
    LDA #_HR
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #32
    BNE :-
    RTS
.endproc

; .proc DrawHUDStatus
;     LDA #___ ; line 1 (line0: horizontal line)
;     LDX #0
;     :
;     STA PPUDATA
;     INX
;     CPX #15
;     BNE :-
;     LDA #_VR
;     STA PPUDATA
;     LDA #___
;     STA PPUDATA
;     STA PPUDATA
;     LDX #0 ; Draw date - month
;     LDY #1
;     :
;     CPY dateMonth
;     BNE :+
;     JMP :++
;     :
;     INX
;     INX
;     INX
;     INY
;     JMP :--
;     :
;     LDA monthText, X
;     STA PPUDATA
;     INX
;     LDA monthText, X
;     STA PPUDATA
;     INX
;     LDA monthText, X
;     STA PPUDATA
;     LDA #___
;     STA PPUDATA
;     LDA dateDay ; Draw date - day
;     STA helper
;     LDX #0 ; 10s place
;     :
;     LDA helper
;     CMP #10
;     BCS :+
;     LDY helper ; 1s place
;     JMP :++
;     :
;     SEC
;     SBC #10
;     STA helper
;     INX
;     JMP :--
;     :
;     LDA decimalDigits, X
;     STA PPUDATA
;     TYA
;     TAX
;     LDA decimalDigits, X
;     STA PPUDATA
;     LDA #_CM
;     STA PPUDATA
;     LDA #___
;     STA PPUDATA
;     LDA #_1_
;     STA PPUDATA
;     LDA #_8_
;     STA PPUDATA
;     LDA #_4_
;     STA PPUDATA
;     LDA #_8_    ; todo dateYear
;     STA PPUDATA
;     LDA #___
;     STA PPUDATA
;     STA PPUDATA ; end of line 1
;     STA PPUDATA ; begin line 2
;     LDX #0
;     :
;     LDA hudStatusText, X ; "HEALTH:"
;     STA PPUDATA
;     INX
;     CPX #7
;     BNE :-

;     LDA #___    ; blank space
;     LDX #0
;     :
;     STA PPUDATA
;     INX
;     CPX #TEXT_HEALTH_LEN
;     BNE :-
;     ; LDA wagonStatus     ; wagon health itself
;     ; AND #%00001100
;     ; LSR
;     ; LSR
;     ; STA helper
;     ; LDX #0
;     ; STX helper+1
;     ; LDY #0
;     ; :
;     ; CPY helper
;     ; BNE :+
;     ; JMP :++
;     ; :
;     ; INX
;     ; INC helper+1
;     ; CPX #4
;     ; BNE :-
;     ; LDX #0
;     ; INY
;     ; BNE :--
;     ; LDY #0
;     ; LDX helper+1
;     ; :
;     ; LDA healthText, X
;     ; STA PPUDATA
;     ; INX
;     ; INY
;     ; CPY #TEXT_HEALTH_LEN
;     ; BNE :-
;     LDA #___
;     STA PPUDATA
;     LDA #_VR
;     STA PPUDATA
;     LDA #___
;     LDX #0
;     :
;     STA PPUDATA
;     INX
;     CPX #16
;     BNE :- ; end of line 2
;     LDA #___ ; start line 3
;     LDX #0
;     :
;     STA PPUDATA
;     INX
;     CPX #15
;     BNE :-
;     LDA #_VR
;     STA PPUDATA
;     LDA #___
;     LDX #0
;     :
;     STA PPUDATA
;     INX
;     CPX #16
;     BNE :- ; end of line 3
;     LDA #___ ; start line 4
;     STA PPUDATA
;     LDX #7 ; "FOOD:"
;     :
;     LDA hudStatusText, X
;     STA PPUDATA
;     INX
;     CPX #14
;     BNE :-
;     LDX #0  ; blank space
;     LDA #___
;     :
;     STA PPUDATA
;     INX
;     CPX #TEXT_HEALTH_LEN
;     BNE :-
;     ; LDX #0 ; decimal text food lbs
;     ; :
;     ; LDA foodLbsDigit, X
;     ; STA PPUDATA
;     ; INX
;     ; CPX #4
;     ; BNE :-
;     ; LDA #___
;     ; STA PPUDATA
;     ; LDA #_LB
;     ; STA PPUDATA
;     LDA #___
;     STA PPUDATA
;     LDA #_VR
;     STA PPUDATA
;     LDX #0
;     LDA #___
;     :
;     STA PPUDATA
;     INX
;     CPX #16
;     BNE :- ; end of line 4
;     LDA #___ ; start line 5
;     LDX #0
;     :
;     STA PPUDATA
;     INX
;     CPX #15
;     BNE :-
;     LDA #_VR
;     STA PPUDATA
;     LDA #___
;     LDX #0
;     :
;     STA PPUDATA
;     INX
;     CPX #16
;     BNE :- ; end of line 5
;     LDA #___ ; start line 6
;     STA PPUDATA
;     LDX #14 ; "FOOD:"
;     :
;     LDA hudStatusText, X
;     STA PPUDATA
;     INX
;     CPX #21
;     BNE :-
;     LDX #0  ; blank space
;     LDA #___
;     :
;     STA PPUDATA
;     INX
;     CPX #TEXT_HEALTH_LEN
;     BNE :-
;     LDA #___
;     STA PPUDATA
;     LDA #_VR
;     STA PPUDATA
;     LDX #0
;     LDA #___
;     :
;     STA PPUDATA
;     INX
;     CPX #16
;     BNE :- ; end of line 6
;     LDA #___ ; start line 7
;     LDX #0
;     :
;     STA PPUDATA
;     INX
;     CPX #15
;     BNE :-
;     LDA #_VR
;     STA PPUDATA
;     LDA #___
;     LDX #0
;     :
;     STA PPUDATA
;     INX
;     CPX #16
;     BNE :- ; end of line 7
;     LDA #___ ; start line 8
;     STA PPUDATA
;     LDX #21 ; "FOOD:"
;     :
;     LDA hudStatusText, X
;     STA PPUDATA
;     INX
;     CPX #28
;     BNE :-
;     LDX #0  ; blank space
;     LDA #___
;     :
;     STA PPUDATA
;     INX
;     CPX #TEXT_HEALTH_LEN
;     BNE :-
;     LDA #___
;     STA PPUDATA
;     LDA #_VR
;     STA PPUDATA
;     LDX #0
;     LDA #___
;     :
;     STA PPUDATA
;     INX
;     CPX #16
;     BNE :- ; end of line 8
;     LDA #___ ; start line 9
;     LDX #0
;     :
;     STA PPUDATA
;     INX
;     CPX #15
;     BNE :-
;     LDA #_VR
;     STA PPUDATA
;     LDA #___
;     LDX #0
;     :
;     STA PPUDATA
;     INX
;     CPX #16
;     BNE :- ; end of line 9
;     LDA #___ ; start line 10
;     LDX #0
;     :
;     STA PPUDATA
;     INX
;     CPX #15
;     BNE :-
;     LDA #_VR
;     STA PPUDATA
;     LDA #___
;     LDX #0
;     :
;     STA PPUDATA
;     INX
;     CPX #16
;     BNE :- ; end of line 10

;     RTS
; .endproc

.proc DrawHUDMap
    JSR DrawBlankLine
    LDX #0
    :
    LDA #_B_
    STA PPUDATA
    INX
    CPX #$20
    BNE :-
    JSR DrawBlankLine
    LDX #0
    :
    LDA #_B_
    STA PPUDATA
    INX
    CPX #$20
    BNE :-
    JSR DrawBlankLine
    LDX #0
    :
    LDA #_B_
    STA PPUDATA
    INX
    CPX #$20
    BNE :-
    JSR DrawBlankLine
    LDX #0
    :
    LDA #_B_
    STA PPUDATA
    INX
    CPX #$20
    BNE :-
    JSR DrawBlankLine
    JSR DrawBlankLine
    RTS
.endproc

; .proc DrawHUDDiary
;     JSR DrawBlankLine
;     LDA #___
;     STA PPUDATA
;     LDX #0
;     :
;     LDA diaryTextLine1, X
;     STA PPUDATA
;     INX
;     CPX #30
;     BNE :-
;     LDA #___
;     STA PPUDATA
;     JSR DrawBlankLine
;     STA PPUDATA
;     LDX #0
;     :
;     LDA diaryTextLine2, X
;     STA PPUDATA
;     INX
;     CPX #30
;     BNE :-
;     LDA #___
;     STA PPUDATA
;     JSR DrawBlankLine
;     STA PPUDATA
;     LDX #0
;     :
;     LDA diaryTextLine3, X
;     STA PPUDATA
;     INX
;     CPX #30
;     BNE :-
;     LDA #___
;     STA PPUDATA
;     JSR DrawBlankLine
;     STA PPUDATA
;     LDX #0
;     :
;     LDA diaryTextLine4, X
;     STA PPUDATA
;     INX
;     CPX #30
;     BNE :-
;     LDA #___
;     STA PPUDATA
;     JSR DrawBlankLine
;     JSR DrawBlankLine
;     RTS
; .endproc

.proc DrawHUDMainMenu
    LDA PPUSTATUS   ; set color palette (attribute table)
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR
    LDA #%10101010
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #8
    BNE :-
    LDA #%01101010
    STA PPUDATA
    LDA #%01011010
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #6
    BNE :-
    LDA #%10011010
    STA PPUDATA
    LDA #%10100110
    STA PPUDATA
    LDA #%10100101
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #6
    BNE :-
    LDA #%10101001
    STA PPUDATA
    LDA #%10101010
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #8*5
    BNE :-
    LDX #0  ; draw landmark text
    LDY #1
    JSR SetPpuAddrPointerFromXY
    JSR DrawLandmarkTitle

    LDX #0  ; draw health and weather box
    LDY #6
    JSR SetPpuAddrPointerFromXY
    LDA PPUSTATUS
    LDA pointer
    STA PPUADDR
    LDA pointer+1
    STA PPUADDR 
    LDX #0 ; blank row
    LDA #___
    :
    STA PPUDATA
    INX
    CPX #35
    BNE :-
    LDX #0 ; "WEATHER:"
    :
    LDA hudMenuStatusText, X
    STA PPUDATA
    INX
    CPX #8
    BNE :-
    LDX #0 ; blank row
    LDA #___
    :
    STA PPUDATA
    INX
    CPX #57
    BNE :-
    LDX #8 ; "HEALTH:"
    :
    LDA hudMenuStatusText, X
    STA PPUDATA
    INX
    CPX #15
    BNE :-
    LDX #0 ; blank row
    LDA #___
    :
    STA PPUDATA
    INX
    CPX #20
    BNE :-
    LDA #0 ; start menu loop
    STA helper
    LDX #6
    LDY #11
    JSR SetPpuAddrPointerFromXY
    LDX #0
    MenuLoop:
    LDA PPUSTATUS ; start menu option line
    LDA pointer
    STA PPUADDR
    LDA pointer+1
    STA PPUADDR
    :
    LDA hudMenu, X
    STA PPUDATA
    INX
    INC helper
    LDA helper
    CMP #TEXT_MAINMENU_LEN
    BNE :-
    LDA #0
    STA helper
    TXA
    PHA
    LDX #6
    INY
    INY
    JSR SetPpuAddrPointerFromXY
    PLA
    TAX
    CPY #29
    BNE MenuLoop
    RTS
.endproc

.proc DrawLandmarkImage
    ; set palette
    LDA PPUSTATUS
    LDA #$3F
    STA PPUADDR
    LDA #$00
    STA PPUADDR
    LDX #0
    :
    LDA landmarkPalette, X
    STA PPUDATA
    INX
    CPX #$10
    BNE :-

    LDY #4          ; switch rom bank to landmark image data
    STY tilesBank
    JSR bankswitch_y
    LDA #<independenceTiles
    STA pointer
    LDA #>independenceTiles
    STA pointer+1
    JSR CopyCHRPatternB


    LDA PPUSTATUS   ; set attribute table
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR
    LDX #0
    :
    LDA independenceAttr, X
    STA PPUDATA
    INX
    CPX #8*6
    BNE :-
    LDA #%10100101
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #8
    BNE :-
    LDA #%10101010
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #8
    BNE :-

    LDA PPUSTATUS   ; draw image
    LDA #$20
    STA PPUADDR
    LDA #$40
    STA PPUADDR
    LDA #<independenceImage
    STA pointer
    LDA #>independenceImage
    STA pointer+1
    LDX #3
    :
    LDA (pointer), Y
    STA PPUDATA
    INY
    CPX #1
    BNE :+
    CPY #$80
    BNE :+
    JMP :++
    :
    CPY #0
    BNE :--
    INC pointer+1
    DEX
    BNE :--
    :

    LDY #1
    JSR bankswitch_y
    RTS
.endproc
