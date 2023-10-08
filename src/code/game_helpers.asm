
.proc SetCartFromDigit
    ; X: address of digits to reference (4 bytes)
    ; Y: ZP address of cart value (1 byte)
    ; cost+0: bit 7: unit- 0:dollars, 1:cents
    TYA
    PHA
    BIT cost
    BPL :+
    LDA #_0_
    STA cartHelperDigit
    STX pointer
    LDY #0
    STY pointer+1
    LDA (pointer), Y
    STA cartHelperDigit+1
    INY
    LDA (pointer), Y
    STA cartHelperDigit+2
    INY
    LDA (pointer), Y
    STA cartHelperDigit+3
    LDX #cartHelperDigit
    :
    LDY #costhelper
    JSR SetValueFromDigit
    LDY #0
    PLA
    STA pointer
    STY pointer+1
    LDA costhelper
    STA (pointer), Y

    RTS
.endproc

.proc SetValueFromDigit
    ; X: address of digits to reference (4 bytes)
    ; Y: ZP address of value (2 bytes)
    STX helper      ; helper: address of digit
    LDX #0
    STX helper+1
    STY pointer     ; pointer: address of value
    LDY #0
    STY pointer+1
    LDA #0          ; clear value
    STA (pointer), Y
    INY
    STA (pointer), Y
    Thousands:
        LDY #0
        SEC
        LDA (helper), Y
        SBC #_0_
        CMP #0
        BNE :+
        JMP Hundreds
        :
        TAX
        :
        LDY #0
        CLC
        LDA (pointer), Y
        ADC #$E8
        STA (pointer), Y
        INY
        LDA (pointer), Y
        ADC #$03
        STA (pointer), Y
        DEX
        CPX #0
        BNE :-
    Hundreds:
        LDY #1
        SEC
        LDA (helper), Y
        SBC #_0_
        CMP #0
        BNE :+
        JMP Tens
        :
        TAX
        :
        LDY #0
        CLC
        LDA (pointer), Y
        ADC #$64
        STA (pointer), Y
        INY
        LDA (pointer), Y
        ADC #$00
        STA (pointer), Y
        DEX
        CPX #0
        BNE :-
    Tens:
        LDY #2
        SEC
        LDA (helper), Y
        SBC #_0_
        CMP #0
        BNE :+
        JMP Ones
        :
        TAX
        :
        LDY #0
        CLC
        LDA (pointer), Y
        ADC #$0A
        STA (pointer), Y
        INY
        LDA (pointer), Y
        ADC #$00
        STA (pointer), Y
        DEX
        CPX #0
        BNE :-
    Ones:
        LDY #3
        SEC
        LDA (helper), Y
        SBC #_0_
        CMP #0
        BNE :+
        JMP Done
        :
        TAX
        :
        LDY #0
        CLC
        LDA (pointer), Y
        ADC #$01
        STA (pointer), Y
        INY
        LDA (pointer), Y
        ADC #$00
        STA (pointer), Y
        DEX
        CPX #0
        BNE :-
    Done:
    RTS
.endproc

.proc SetDigitFromValue
    ; X: address of digits to reference (4 bytes)
    ; Y: ZP address of value (2 bytes)
    LDA helper
    PHA
    LDA helper+1
    PHA
    LDA helper2
    PHA
    LDA helper2+1
    PHA
    LDA pointer
    PHA
    LDA pointer+1
    PHA
    STX helper2
    LDX #0
    STX helper2+1
    STY pointer
    LDY #0
    STY pointer+1
    LDA (pointer), Y
    STA helper
    INY
    LDA (pointer), Y
    STA helper+1
    LDA #_0_            ; convert helper to decimal digits
    LDY #0
    STA (helper2), Y    ; 0 in 1000s place
    Thousands:   ; 1000s place
        LDA helper+1 
        CMP #4 ; is helper >= 1024?
        BCS :++ ; yes: helper >= 1000
        CMP #3 ; is helper >= 768?
        BCS :+ ; yes: helper >= 768
        JMP Hundreds ; no: helper < 1000
        : ; helper >= 768
        LDA helper
        CMP #$E8 ; is helper >= 1000?
        BCC Hundreds ; no: helper < 1000 
        : ; helper >= 1000
        SEC
        LDA helper
        SBC #$E8
        STA helper
        LDA helper+1
        SBC #$03
        STA helper+1
        LDA (helper2), Y
        CLC
        ADC #1
        STA (helper2), Y
        JMP Thousands
    Hundreds: ; helper < 1000
        LDA (helper2), Y
        SEC
        SBC #_0_
        CMP #0          ; 0 in 1000s place?
        BNE :+
        LDA #_UL        ; replace with line
        STA (helper2), Y
        :
        INY
        LDA #_0_
        STA (helper2), Y    ; 0 in 100s place
        :
        LDA helper+1
        CMP #0              ; is helper >= $0100 (256)?
        BNE :+
        LDA helper
        CMP #$64            ; is helper >= $0064 (100)?
        BCC Tens
        :
        SEC                 ; subtract $0064 (100)
        LDA helper
        SBC #$64
        STA helper
        LDA helper+1
        SBC #$00
        STA helper+1
        LDA (helper2), Y
        CLC
        ADC #1
        STA (helper2), Y
        JMP :--
    Tens:
        LDA (helper2), Y
        SEC
        SBC #_0_
        CMP #0          ; 0 in 100s place?
        BNE :+
        DEY
        LDA (helper2), Y
        INY
        SEC
        SBC #_UL        ; underline in 1000s place?
        CMP #0
        BNE :+
        LDA #_UL        ; replace 100s place with line
        STA (helper2), Y
        :
        INY
        LDA #_0_
        STA (helper2), Y
        :
        LDA helper
        CMP #10             ; is helper >= 10?
        BCC Ones
        SEC                 ; subtract 10
        LDA helper
        SBC #10
        STA helper
        LDA helper+1
        SBC #0
        STA helper+1
        LDA (helper2), Y
        CLC
        ADC #1
        STA (helper2), Y
        JMP :-
    Ones: 
        LDA (helper2), Y
        SEC
        SBC #_0_
        CMP #0          ; 0 in 10s place?
        BNE :+
        DEY
        LDA (helper2), Y
        INY
        SEC
        SBC #_UL        ; underline in 100s place?
        CMP #0
        BNE :+
        DEY
        DEY
        LDA (helper2), Y
        INY
        INY
        SEC
        SBC #_UL        ; underline in 1000s place?
        CMP #0
        BNE :+
        LDA #_UL        ; replace 10s place with line
        STA (helper2), Y
        DEY
        :
    LDX helper
    LDA decimalDigits, X    ; draw 1s place digit
    LDY #3
    STA (helper2), Y
    PLA
    STA pointer+1
    PLA
    STA pointer
    PLA
    STA helper2+1
    PLA
    STA helper2
    PLA
    STA helper+1
    PLA
    STA helper
    RTS
.endproc

.proc SetDefaultTopTen
    LDX #0
    :
    LDA topTenDefault, X
    STA oregonTopTen, X
    INX
    CPX #100 ; len of topTenDefault data in entirety
    BNE :-
    RTS
.endproc

.proc ToggleYN
    LDA menuCursor
    EOR #1
    STA menuCursor
    BNE :+
    LDA #_N_
    JMP :++
    :
    LDA #_Y_
    :
    LDX fingerX
    LDY fingerY
    JSR WriteTileToBuffer
    RTS
.endproc

.proc SetPpuAddrPointerFromXY
    ; X - tiles right of origin
    ; Y - tiles down from origin
    ; Store PPU address of tile x,y in pointer
    TXA
    PHA
    TYA
    PHA
    LDA #0 ; clear pointer
    STA pointer
    STA pointer+1
    TYA 
    CLC
    ROL 
    ROL 
    ROL
    TAY
    TXA 
    CLC
    ROL 
    ROL 
    ROL
    TAX
    LDA #%00001000 ;base value for $2000 (change lower 2 bits for other NTs)
    STA pointer
    TYA
    AND #%11111000
    ASL
    ROL pointer
    ASL
    ROL pointer
    STA pointer+1
    TXA
    LSR
    LSR
    LSR
    ORA pointer+1
    STA pointer+1
    PLA
    TAY
    PLA
    TAX
    RTS
.endproc

.proc MoveFingerToSubmenu
    ; X - tiles right of origin
    ; Y - tiles down from origin
    ; Move finger to submenu position x,y
    LDA fingerX
    STA fingerLastLastX
    LDA fingerY
    STA fingerLastLastY ; Set LastLast pos since we are in a submenu.
    STX fingerX
    STX fingerLastX
    STY fingerY         ; move finger to keyboard 'A'
    JSR RedrawFinger
    RTS
.endproc

.proc RedrawFinger ; hack to redraw finger
    PHA
    LDA #0
    STA fingerLastY
    PLA
    RTS
.endproc

.proc CloseSubmenu
    LDA fingerLastLastX
    STA fingerX
    LDA fingerLastLastY
    STA fingerY
    LDA #0
    STA fingerLastLastX
    STA fingerLastLastY
    LDA #MENU_NONE
    STA menuOpen
    RTS
.endproc

.proc DoStorePurchase
    SEC                     ; dollars
    LDA dollars
    SBC cartDollars
    STA dollars
    LDA dollars+1
    SBC cartDollars+1
    STA dollars+1
    LDX #dollarsDigit
    LDY #dollars
    JSR SetDigitFromValue
    CLC                     ; oxen
    LDA oxenHeadcount
    ADC cartOxen
    STA oxenHeadcount
    LDX #oxenDigit
    LDY #oxenHeadcount
    JSR SetDigitFromValue
    CLC                     ; clothing
    LDA clothing
    ADC cartClothing
    STA clothing
    LDX #clothingDigit
    LDY #clothing
    JSR SetDigitFromValue
    LDA cartSpareParts      ; wheels
    AND #%00000011
    STA helper
    LDA spareParts
    AND #%00000011
    CLC
    ADC helper
    STA helper
    LDA spareParts
    AND #%11111100
    CLC
    ADC helper
    STA spareParts
    LDA cartSpareParts      ; axles
    AND #%00001100
    STA helper
    LDA spareParts
    AND #%00001100
    CLC
    ADC helper
    STA helper
    LDA spareParts
    AND #%11110011
    CLC
    ADC helper
    STA spareParts
    LDA cartSpareParts      ; tongues
    AND #%00110000
    STA helper
    LDA spareParts
    AND #%00110000
    CLC
    ADC helper
    STA helper
    LDA spareParts
    AND #%11001111
    CLC
    ADC helper
    STA spareParts
    LDX cartBullets             ; bullets- x10
    :
    CPX #0
    BEQ :+
    CLC
    LDA bullets
    ADC #10
    STA bullets
    LDA bullets+1
    ADC #0
    STA bullets+1
    DEX
    JMP :-
    :
    LDX #bulletsDigit
    LDY #bullets
    JSR SetDigitFromValue
    LDX cartFoodLbs             ; food lbs- x10
    :
    CPX #0
    BEQ :+
    CLC
    LDA foodLbs
    ADC #10
    STA foodLbs
    LDA foodLbs+1
    ADC #0
    STA foodLbs+1
    DEX
    JMP :-
    :
    LDX #foodLbsDigit
    LDY #foodLbs
    JSR SetDigitFromValue
    LDA #0                  ; empty cart
    STA helper
    STA helper+1
    STA cartBullets
    STA cartBullets+1
    STA cost
    STA cost+1
    STA costhelper
    STA costhelper+1
    STA cartFoodLbs
    STA cartFoodLbs+1
    STA cartSpareParts
    STA cartClothing
    STA cartOxen
    STA cartDollars
    STA cartDollars+1
    RTS
.endproc

.proc ValidateCart
    ; return A = 1 or 0 if cart is valid
    ;   Invalid: cart+inv exceeds wagon capacity, cost exceeds wallet
    ;       Capacity- wheels/axles/tongues: 3
    ; TODO: food 2000lb, bullets 2000, clothing 99?, oxen ~20?
    LDA dollars+1   ; can we afford it?
    CMP cartDollars+1
    BCC :+ ; branch if dollars high byte < cartDollars high byte
    BEQ :++ ; branch if dollars high byte = cartDollars high byte
    JMP :+++
    : 
    LDA #0 ; not enough money
    JMP Done
    : ; dollars high byte = cartDollars high byte
    LDA dollars
    CMP cartDollars
    BCS :+ ; branch if dollars low byte >= cartDollars low byte
    JMP :--
    :
    LDA cartSpareParts
    AND #%00000011
    STA helper
    LDA spareParts
    AND #%00000011
    CLC
    ADC helper
    CMP #4
    BCC :+
    LDA #0 ; too many wheels
    JMP Done
    :
    LDA cartSpareParts
    AND #%00001100
    LSR
    LSR
    STA helper
    LDA spareParts
    AND #%00001100
    LSR
    LSR
    CLC
    ADC helper
    CMP #4
    BCC :+
    LDA #0
    JMP Done
    :
    LDA cartSpareParts
    AND #%00110000
    LSR
    LSR
    LSR
    LSR
    STA helper
    LDA spareParts
    AND #%00110000
    LSR
    LSR
    LSR
    LSR
    CLC
    ADC helper
    CMP #4
    BCC :+
    LDA #0
    JMP Done
    :
    LDA #1
    Done:
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
    LDX occupation
    LDA occupationAttribute, X
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

.proc ClearPopupText
    LDA #___
    LDX #0
    :
    STA popupTextLine1, X
    STA popupTextLine2, X
    INX
    CPX #TEXT_POPUP_LINE_LEN
    BNE :-
    RTS
.endproc

.proc GetLandmarkText
    ; @param X: location index
    ; @return helper2: length of text
    ; clobbers all registers, helper

    STX helper+1
    LDX #0
    LDY #0
    STX helper
    LDA locationNameText, X
    STA helper2
    :
    CPY helper+1
    BNE :+
    JMP :+++
    :
    LDX #0
    :
    INX
    CPX helper2
    BNE :-
    CLC
    ADC helper
    STA helper
    INC helper
    LDX helper
    INY
    LDA locationNameText, X
    STA helper2
    JMP :---
    :
    INC helper

    LDY #0
    LDX helper+1
    LDA landmarkAttr, X
    BPL :++ ; not a fort
    : ; a fort
    LDA helper+1
    CMP #LOC_INDEPENDENCE
    BEQ :+
    LDA locationPrefix, Y
    STA textLineHelper, Y
    INY
    CPY #5
    BNE :-
    CLC
    LDA helper2
    ADC #5
    STA helper2
    :
    LDX helper
    :
    LDA locationNameText, X
    STA textLineHelper, Y
    INX
    INY
    CPY helper2
    BNE :-
    LDX helper+1 ; is it a river?
    LDA landmarkAttr, X
    ROL
    BPL :++ ; not a river
    LDX #5 ; a river
    CLC
    LDA helper2
    ADC #15
    STA helper2
    :
    LDA locationPrefix, X
    STA textLineHelper, Y
    INX
    INY
    CPX #20
    BNE :-
    :
    RTS
.endproc

.proc IncrementDate
    INC dateDay

    LDA dateDay
    CMP #29
    BCS :+
    JMP Done
    :
    BNE :++
    LDA dateMonth
    CMP #2
    BNE :+
    LDA dateYear
    CMP #0
    BEQ Done ; 1848-02-29 is fine.
    JMP IncrementMonth ; not 1848: no feb 29
    :
    JMP Done ; XXXX-XX-29 is fine if its not February
    :
    LDA dateDay
    CMP #30
    BNE :++
    LDA dateMonth
    CMP #2
    BNE :+
    JMP IncrementMonth
    :
    JMP Done ; XXXX-XX-30 is fine if its not February
    :
    LDA dateDay
    CMP #31
    BNE IncrementMonth
    LDA dateMonth
    CMP #1
    BNE :+
    JMP Done
    :
    CMP #3
    BNE :+
    JMP Done
    :
    CMP #5
    BNE :+
    JMP Done
    :
    CMP #7
    BNE :+
    JMP Done
    :
    CMP #8
    BNE :+
    JMP Done
    :
    CMP #10
    BNE :+
    JMP Done
    :
    CMP #12
    BNE :+
    JMP Done
    :
    IncrementMonth:
        LDA #1
        STA dateDay
        INC dateMonth
        LDA dateMonth
        CMP #13
        BNE Done
        LDA #1
        STA dateMonth
        INC dateYear
    Done:
    ; store date as text
    LDX #0 
    LDY #1
    :
    CPY dateMonth
    BNE :+
    JMP :++
    :
    INX
    INX
    INX
    INY
    JMP :--
    :
    LDA monthText, X
    STA dateText
    INX
    LDA monthText, X
    STA dateText+1
    INX
    LDA monthText, X
    STA dateText+2
    LDA #___
    STA dateText+3
    LDA dateDay ; Draw date - day
    STA helper
    LDX #0 ; 10s place
    :
    LDA helper
    CMP #10
    BCS :+
    LDY helper ; 1s place
    JMP :++
    :
    SEC
    SBC #10
    STA helper
    INX
    JMP :--
    :
    LDA decimalDigits, X
    STA dateText+4
    TYA
    TAX
    LDA decimalDigits, X
    STA dateText+5
    LDA #_CM
    STA dateText+6
    LDA #___
    STA dateText+7
    LDA dateYear
    CLC
    ADC #48
    STA helper
    LDA #0
    STA helper+1
    LDX #cartHelperDigit
    LDY #helper
    JSR SetDigitFromValue
    LDA #_1_
    STA dateText+8
    LDA #_8_
    STA dateText+9
    LDA cartHelperDigit+2
    STA dateText+10
    LDA cartHelperDigit+3
    STA dateText+11
    RTS
.endproc

.proc RandomNumberGenerator
    ; Returns a random 8-bit number in A (0-255), clobbers Y (unknown).
    ; https://www.nesdev.org/wiki/Random_number_generator
	lda seed+1
    cmp #0
    bne :+
    lda #1
    :
	tay ; store copy of high byte
	; compute seed+1 ($39>>1 = %11100)
	lsr ; shift to consume zeroes on left...
	lsr
	lsr
	sta seed+1 ; now recreate the remaining bits in reverse order... %111
	lsr
	eor seed+1
	lsr
	eor seed+1
	eor seed+0 ; recombine with original low byte
	sta seed+1
	; compute seed+0 ($39 = %111001)
	tya ; original high byte
	sta seed+0
	asl
	eor seed+0
	asl
	eor seed+0
	asl
	asl
	asl
	eor seed+0
	sta seed+0
	rts
.endproc

.proc CountAlivePeople
    ; @return A: alive people
    ; clobbers X, helper
    LDX #0
    STX helper
    :
    LDA personHealth, X
    AND #%11111000
    CMP #%11111000
    BNE :+
    INX ; dead
    CPX #5
    BNE :-
    JMP :++
    : ; alive
    INC helper
    INX
    CPX #5
    BNE :-
    :
    LDA helper
    RTS
.endproc

.proc CheckMountainousTerrain
    ; @return A: 0:prairie, 1:mountains
    LDA traveledMi+1
    CMP #$03
    BCS :+
    LDA #0 ; traveled less than 0x300 (768) miles 
    JMP Done
    :
    CMP #$04
    BCS :+
    LDA traveledMi
    CMP #$B6
    BCS :+
    LDA #0 ; traveled between 0x300 (768) and 0x3B6 (950) miles
    JMP Done
    :
    LDA #1 ; traveled more than 0x3B6 (950) or 0x400 (1024) miles
    Done:
    RTS
.endproc

.proc DecrementCounter
    PHA
    LDA counter
    BNE :+
    DEC counter+1
    :
    DEC counter
    PLA
    RTS
.endproc

.proc IncrementPointerY
    INY
    BNE :+
    INC pointer+1
    :
    RTS
.endproc

.proc LetterNumToTileIndex
    PHP
    CLC
    ADC #_A_
    CMP #_A_+14
    BCC Done
    BEQ :+
    SEC
    SBC #1
    JMP Done
    :
    LDA #_O_
    Done:
    PLP
    RTS
.endproc

.proc PointerToNextLine
    PHP
    PHA
    CLC
    LDA pointer+1
    ADC #$20
    STA pointer+1
    LDA pointer
    ADC #0
    STA pointer
    PLA
    PLP
    RTS
.endproc