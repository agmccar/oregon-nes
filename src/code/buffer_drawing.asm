
.proc DrawFinger
    LDA #%00001100          ; skip drawing if neither finger is set to visible
    BIT fingerAttr
    BNE :+
    JMP Done
    :                       ; skip drawing if finger hasn't moved
    LDX fingerX
    LDY fingerY
    CPX fingerLastX
    BNE :+
    CPY fingerLastY
    BNE :+
    JMP Done
    :                       ; erase finger at old position (draw blank tile)
    LDA #%00010000
    BIT fingerAttr          ; check if main finger is normal or "up/down" arrows
    BEQ :++
    LDX fingerLastX
    LDY fingerLastY
    CPY #0
    BNE :+
    JMP :+++ ; dont erase if RedrawFinger was just invoked
    :
    LDA #___
    DEY
    JSR WriteTileToBuffer
    LDX fingerLastX
    LDY fingerLastY
    LDA #___
    INY
    JSR WriteTileToBuffer
    JMP :++
    :
    LDX fingerLastX
    LDY fingerLastY
    LDA #___
    JSR WriteTileToBuffer
    :
    LDX fingerLastLastX     ; are we in a submenu?
    LDY fingerLastLastY 
    CPX #0
    BNE :+
    CPY #0
    BNE :+
    JMP :++
    :                       ; draw "old" finger (if there's a submenu open)
    LDA #%00001000
    BIT fingerAttr
    BEQ :+
    LDA #_PR
    JSR WriteTileToBuffer
    :                       ; draw finger at new position
    LDA #%00000100          ; check if main finger is visible
    BIT fingerAttr
    BEQ :++
    LDA #%00010000          ; draw normal finger or "up/down" arrows
    BIT fingerAttr          ; check if main finger is normal or "up/down" arrows
    BEQ :+
    LDX fingerX
    LDY fingerY
    INY
    LDA #_AD    ; arrow down
    JSR WriteTileToBuffer
    LDX fingerX
    LDY fingerY
    DEY
    LDA #_AU    ; arrow up
    JSR WriteTileToBuffer
    JMP :++
    :
    LDX fingerX
    LDY fingerY
    LDA #_PR
    JSR WriteTileToBuffer
    :
    LDA fingerX             ; remember last finger position
    STA fingerLastX
    LDA fingerY
    STA fingerLastY
    Done:
    RTS
.endproc

.proc UpdatePalette
    ; X register set to $00 => first palette
    ; X register set to $20 => second palette. etc.
    LDX #$20
    JSR StartBufferWrite
        LDA #$20                ; length of palette
        JSR WriteByteToBuffer
        LDA #$3F                ; $3F00 - palette VRAM location
        JSR WriteByteToBuffer
        LDA #$00
        JSR WriteByteToBuffer
        LDX #0
        :                       
        LDA palette, X
        JSR WriteByteToBuffer
        INX
        CPX #$20
        BNE :-
    JSR EndBufferWrite
    RTS
.endproc

.proc DrawStoreSubmenu
    LDX #2                  ; first row of submenu
    INX
    LDY fingerY
    DEY
    DEY
    JSR SetPpuAddrPointerFromXY
    LDX #16
    JSR StartBufferWrite
        LDA #16
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDA #_RD
        JSR WriteByteToBuffer
        LDA #_HR
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #14
        BNE :-
        LDA #_LD
        JSR WriteByteToBuffer
    JSR EndBufferWrite
    LDX #3                  ; vertical bars (left)
    LDY fingerY
    DEY
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #3
    LDY fingerY
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #3
    LDY fingerY
    INY
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #18                 ; vertical bars (right)
    LDY fingerY
    DEY
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #18
    LDY fingerY
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #18
    LDY fingerY
    INY
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #2                  ; last row of submenu
    INX
    LDY fingerY
    INY
    INY
    JSR SetPpuAddrPointerFromXY
    LDX #16
    JSR StartBufferWrite
        LDA #16
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDA #_RU
        JSR WriteByteToBuffer
        LDA #_HR
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #14
        BNE :-
        LDA #_LU
        JSR WriteByteToBuffer
    JSR EndBufferWrite
    RTS
.endproc

.proc IncreaseDigit
    ; X: memory location of digit to increment
    ; cost+0: bit 7: unit- 0:dollars, 1:cents
    LDA #0
    STA pointer+1
    STX pointer
    CPX #0
    BNE Ones
    JMP Done
    Ones:
        LDA fingerX
        CMP #7 ; 1's place
        BNE Tens
        LDY #3
        JMP Done
    Tens:
        CMP #6 ; 10's place
        BNE Hundreds
        LDY #2
        JMP Done
    Hundreds:
        CMP #5 ; 100's place
        BNE Thousands
        LDY #1
        JMP Done
    Thousands:
        LDY #0
    Done:
    LDA (pointer), Y
    TAX
    INX
    CPX #_CL ; #_9_+1
    BNE :+
    LDX #_0_
    :
    BIT cost
    BMI :+
    LDA fingerX
    CMP #7
    BCS :+
    CPX #_2_
    BNE :+
    LDX #_0_
    :
    LDA fingerX
    CMP #5
    BCS :+
    CPX #_2_ ; #_1_+1
    BNE :+
    LDX #_0_
    :
    TXA
    STA (pointer), Y
    LDX fingerX
    LDY fingerY
    JSR WriteTileToBuffer
    RTS
.endproc

.proc DecreaseDigit
    ; X: memory location of digit to decrement
    ; cost+0: bit 7: unit- 0:dollars, 1:cents
    LDA #0
    STA pointer+1
    STX pointer
    CPX #0
    BNE Ones
    JMP Done
    Ones:
        LDA fingerX
        CMP #7 ; 1's place
        BNE Tens
        LDY #3
        JMP Done
    Tens:
        CMP #6 ; 10's place
        BNE Hundreds
        LDY #2
        JMP Done
    Hundreds:
        CMP #5 ; 100's place
        BNE Thousands
        LDY #1
        JMP Done
    Thousands:
        LDY #0
    Done:
    LDA (pointer), Y
    TAX
    DEX
    CPX #_Z_ ; #_0_-1
    BNE :+
    LDX #_9_
    :
    BIT cost
    BMI :+
    LDA fingerX
    CMP #7
    BCS :+
    CPX #_9_
    BNE :+
    LDX #_1_
    :
    LDA fingerX
    CMP #5
    BCS :+
    CPX #_9_ ; #_1_+1
    BNE :+
    LDX #_1_
    :
    TXA
    STA (pointer), Y
    LDX fingerX
    LDY fingerY
    JSR WriteTileToBuffer
    RTS
.endproc

.proc DrawPaceSubmenu
    LDX #4 ; top row of menu
    LDY #15
    JSR SetPpuAddrPointerFromXY
    LDX #19
    JSR StartBufferWrite
        LDA #19
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDA #_RD
        JSR WriteByteToBuffer
        LDA #_HR
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #17
        BNE :-
        LDA #_LD
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    LDX #4  ; vertical bars (left)
    LDY #16
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #4
    LDY #17
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #4
    LDY #18
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #22  ; vertical bars (right)
    LDY #16
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #22
    LDY #17
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #22
    LDY #18
    LDA #_VR
    JSR WriteTileToBuffer

    LDX #4 ; bottom row of menu
    LDY #19
    JSR SetPpuAddrPointerFromXY
    LDX #19
    JSR StartBufferWrite
        LDA #19
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDA #_RU
        JSR WriteByteToBuffer
        LDA #_HR
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #17
        BNE :-
        LDA #_LU
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    LDX #6  ; "PACE: xxxxxxxxx"
    LDY #17
    JSR SetPpuAddrPointerFromXY
    LDX #15
    JSR StartBufferWrite
        LDA #15
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDX #15
        :
        LDA hudMenuStatusText, X
        JSR WriteByteToBuffer
        INX
        CPX #20
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDX #0
        LDY #0
        STY helper+1
        LDA wagonSettings
        AND #%00000011
        STA helper
        DEC helper
        :
        CPY helper
        BNE :+
        JMP :++
        :
        INX
        INC helper+1
        LDA helper+1
        CMP #TEXT_PACE_LEN
        BNE :-
        LDA #0
        STA helper+1
        INY
        JMP :--
        :
        LDA paceText, X
        JSR WriteByteToBuffer
        INX
        INC helper+1
        LDA helper+1
        CMP #TEXT_PACE_LEN
        BNE :-
    JSR EndBufferWrite

    RTS
.endproc

.proc DrawRationsSubmenu
    LDX #4 ; top row of menu
    LDY #17
    JSR SetPpuAddrPointerFromXY
    LDX #23
    JSR StartBufferWrite
        LDA #23
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDA #_RD
        JSR WriteByteToBuffer
        LDA #_HR
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #21
        BNE :-
        LDA #_LD
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    LDX #4  ; vertical bars (left)
    LDY #18
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #4
    LDY #19
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #4
    LDY #20
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #26  ; vertical bars (right)
    LDY #18
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #26
    LDY #19
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #26
    LDY #20
    LDA #_VR
    JSR WriteTileToBuffer

    LDX #4 ; bottom row of menu
    LDY #21
    JSR SetPpuAddrPointerFromXY
    LDX #23
    JSR StartBufferWrite
        LDA #23
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDA #_RU
        JSR WriteByteToBuffer
        LDA #_HR
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #21
        BNE :-
        LDA #_LU
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    LDX #6  ; "RATIONS: xxxxxxxxxx"
    LDY #19
    JSR SetPpuAddrPointerFromXY
    LDX #19
    JSR StartBufferWrite
        LDA #19
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDX #20
        :
        LDA hudMenuStatusText, X
        JSR WriteByteToBuffer
        INX
        CPX #28
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDX #0
        LDY #0
        STY helper+1
        LDA wagonSettings
        AND #%00001100
        LSR
        LSR
        STA helper
        DEC helper
        :
        CPY helper
        BNE :+
        JMP :++
        :
        INX
        INC helper+1
        LDA helper+1
        CMP #TEXT_RATIONS_LEN
        BNE :-
        LDA #0
        STA helper+1
        INY
        JMP :--
        :
        LDA rationsText, X
        JSR WriteByteToBuffer
        INX
        INC helper+1
        LDA helper+1
        CMP #TEXT_RATIONS_LEN
        BNE :-
    JSR EndBufferWrite

    RTS
.endproc

.proc DrawRestSubmenu
    LDX #4 ; top row of menu
    LDY #19
    JSR SetPpuAddrPointerFromXY
    LDX #19
    JSR StartBufferWrite
        LDA #19
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDA #_RD
        JSR WriteByteToBuffer
        LDA #_HR
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #17
        BNE :-
        LDA #_LD
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    LDX #4  ; vertical bars (left)
    LDY #20
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #4
    LDY #21
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #4
    LDY #22
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #22  ; vertical bars (right)
    LDY #20
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #22
    LDY #21
    LDA #_VR
    JSR WriteTileToBuffer
    LDX #22
    LDY #22
    LDA #_VR
    JSR WriteTileToBuffer

    LDX #4 ; bottom row of menu
    LDY #23
    JSR SetPpuAddrPointerFromXY
    LDX #19
    JSR StartBufferWrite
        LDA #19
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDA #_RU
        JSR WriteByteToBuffer
        LDA #_HR
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #17
        BNE :-
        LDA #_LU
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    LDX #6  ; "REST FOR x DAYS"
    LDY #21
    JSR SetPpuAddrPointerFromXY
    LDX #15
    JSR StartBufferWrite
        LDA #15
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA restText, X
        JSR WriteByteToBuffer
        INX
        CPX #9
        BNE :-
        LDA wagonStatus
        AND #%11110000
        LSR
        LSR
        LSR
        LSR
        TAX
        LDA decimalDigits, X
        JSR WriteByteToBuffer
        LDX #9
        :
        LDA restText, X
        JSR WriteByteToBuffer
        INX
        CPX #14
        BNE :-
    JSR EndBufferWrite

    RTS
.endproc

.proc BufferDrawTitle
    LDX #17
    JSR StartBufferWrite    ; title text
        LDA #17                 
        JSR WriteByteToBuffer
        LDA #$21
        JSR WriteByteToBuffer
        LDA #$29
        JSR WriteByteToBuffer
        LDX #0
        :                       
        LDA titleText, X
        JSR WriteByteToBuffer
        INX
        CPX #17
        BNE :-
    JSR EndBufferWrite
    LDX #12
    JSR StartBufferWrite    ; title options text
        LDA #12
        JSR WriteByteToBuffer 
        LDA #$22
        JSR WriteByteToBuffer 
        LDA #$0B
        JSR WriteByteToBuffer 
        LDX #0
        :                       
        LDA titleOptions, X
        JSR WriteByteToBuffer
        INX
        CPX #12
        BNE :-
    JSR EndBufferWrite
    RTS
.endproc

.proc BufferDrawSupplies
    LDX #12
    JSR StartBufferWrite    ; oxenDigit
        LDA #12                 
        JSR WriteByteToBuffer
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$B0
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA suppliesText, X
        JSR WriteByteToBuffer
        INX
        CPX #TEXT_SUPPLIES_LEN
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA oxenDigit, X
        CMP #_UL
        BNE :+
        LDA #___
        :
        JSR WriteByteToBuffer
        INX
        CPX #4
        BNE :--
    JSR EndBufferWrite

    LDX #12
    JSR StartBufferWrite    ; clothingDigit
        LDA #12                 
        JSR WriteByteToBuffer
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$F0
        JSR WriteByteToBuffer
        LDX #TEXT_SUPPLIES_LEN
        :
        LDA suppliesText, X
        JSR WriteByteToBuffer
        INX
        CPX #TEXT_SUPPLIES_LEN*2
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA clothingDigit, X
        CMP #_UL
        BNE :+
        LDA #___
        :
        JSR WriteByteToBuffer
        INX
        CPX #4
        BNE :--
    JSR EndBufferWrite

    LDX #12
    JSR StartBufferWrite    ; bulletsDigit
        LDA #12                 
        JSR WriteByteToBuffer
        LDA #$21
        JSR WriteByteToBuffer
        LDA #$30
        JSR WriteByteToBuffer
        LDX #TEXT_SUPPLIES_LEN*2
        :
        LDA suppliesText, X
        JSR WriteByteToBuffer
        INX
        CPX #TEXT_SUPPLIES_LEN*3
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA bulletsDigit, X
        CMP #_UL
        BNE :+
        LDA #___
        :
        JSR WriteByteToBuffer
        INX
        CPX #4
        BNE :--
    JSR EndBufferWrite

    LDX #12
    JSR StartBufferWrite    ; wagon wheels
        LDA #12                 
        JSR WriteByteToBuffer
        LDA #$21
        JSR WriteByteToBuffer
        LDA #$70
        JSR WriteByteToBuffer
        LDX #TEXT_SUPPLIES_LEN*3
        :
        LDA suppliesText, X
        JSR WriteByteToBuffer
        INX
        CPX #TEXT_SUPPLIES_LEN*4
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        JSR WriteByteToBuffer
        JSR WriteByteToBuffer
        JSR WriteByteToBuffer
        LDA spareParts
        AND #%00000011
        CLC
        ADC #_0_
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    LDX #12
    JSR StartBufferWrite    ; wagon axles
        LDA #12                 
        JSR WriteByteToBuffer
        LDA #$21
        JSR WriteByteToBuffer
        LDA #$B0
        JSR WriteByteToBuffer
        LDX #TEXT_SUPPLIES_LEN*4
        :
        LDA suppliesText, X
        JSR WriteByteToBuffer
        INX
        CPX #TEXT_SUPPLIES_LEN*5
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        JSR WriteByteToBuffer
        JSR WriteByteToBuffer
        JSR WriteByteToBuffer
        LDA spareParts
        AND #%00001100
        LSR
        LSR
        CLC
        ADC #_0_
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    LDX #12
    JSR StartBufferWrite    ; wagon tongues
        LDA #12                 
        JSR WriteByteToBuffer
        LDA #$21
        JSR WriteByteToBuffer
        LDA #$F0
        JSR WriteByteToBuffer
        LDX #TEXT_SUPPLIES_LEN*5
        :
        LDA suppliesText, X
        JSR WriteByteToBuffer
        INX
        CPX #TEXT_SUPPLIES_LEN*6
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        JSR WriteByteToBuffer
        JSR WriteByteToBuffer
        JSR WriteByteToBuffer
        LDA spareParts
        AND #%00110000
        LSR
        LSR
        LSR
        LSR
        CLC
        ADC #_0_
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    LDX #12
    JSR StartBufferWrite    ; foodLbsDigit
        LDA #12                 
        JSR WriteByteToBuffer
        LDA #$22
        JSR WriteByteToBuffer
        LDA #$30
        JSR WriteByteToBuffer
        LDX #TEXT_SUPPLIES_LEN*6
        :
        LDA suppliesText, X
        JSR WriteByteToBuffer
        INX
        CPX #TEXT_SUPPLIES_LEN*7
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA foodLbsDigit, X
        CMP #_UL
        BNE :+
        LDA #___
        :
        JSR WriteByteToBuffer
        INX
        CPX #4
        BNE :--
    JSR EndBufferWrite

    LDX #12
    JSR StartBufferWrite    ; dollars
        LDA #12                 
        JSR WriteByteToBuffer
        LDA #$22
        JSR WriteByteToBuffer
        LDA #$70
        JSR WriteByteToBuffer
        LDA #_C_
        JSR WriteByteToBuffer
        LDA #_A_
        JSR WriteByteToBuffer
        LDA #_S_
        JSR WriteByteToBuffer
        LDA #_H_
        JSR WriteByteToBuffer
        LDA #___
        JSR WriteByteToBuffer
        LDA #___
        JSR WriteByteToBuffer
        LDA #_DL
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA dollarsDigit, X
        JSR WriteByteToBuffer
        INX
        CPX #4
        BNE :-
        LDA #_00
        JSR WriteByteToBuffer
    JSR EndBufferWrite
    RTS
.endproc

.proc BufferDrawSizeUpSituation
    LDX #$20
    JSR StartBufferWrite
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$22
        JSR WriteByteToBuffer
        LDA #$00
        JSR WriteByteToBuffer
        LDA #___
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #$20
        BNE :-
    JSR EndBufferWrite
    LDX #$20
    JSR StartBufferWrite
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$22
        JSR WriteByteToBuffer
        LDA #$20
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA sizeUpSituationText, X
        JSR WriteByteToBuffer
        INX
        CPX #$20
        BNE :-
    JSR EndBufferWrite
    RTS
.endproc

.proc BufferDrawPressStart
    LDX #$20
    JSR StartBufferWrite
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$23
        JSR WriteByteToBuffer
        LDA #$40
        JSR WriteByteToBuffer
        LDA #___
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #$20
        BNE :-
    JSR EndBufferWrite
    LDX #$20
    JSR StartBufferWrite
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$23
        JSR WriteByteToBuffer
        LDA #$60
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA pressStartText, X
        JSR WriteByteToBuffer
        INX
        CPX #$20
        BNE :-
    JSR EndBufferWrite
    RTS
.endproc

.proc BufferDrawBlankLine
    ; pointer: nametable address
    LDX #$20
    JSR StartBufferWrite
        LDA #$20
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDA #___
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #$20
        BNE :-
    JSR EndBufferWrite
    RTS
.endproc

.proc BufferDrawTextPopup

    LDX #16  ; attributes
    JSR StartBufferWrite
        LDA #16
        JSR WriteByteToBuffer
        LDA #$23
        JSR WriteByteToBuffer
        LDA #$D0
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA attrPopupText, X
        JSR WriteByteToBuffer
        INX
        CPX #16
        BNE :-
    JSR EndBufferWrite

    LDX #28 ; top row
    JSR StartBufferWrite
        LDA #28
        JSR WriteByteToBuffer
        LDA #$21
        JSR WriteByteToBuffer
        LDA #$42
        JSR WriteByteToBuffer
        LDA #_RD
        JSR WriteByteToBuffer
        LDA #_HR
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #26
        BNE :-
        LDA #_LD
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    LDA #0 ; row 1-5
    STA helper
    LDA #$62
    STA helper+1
    :
    LDX #28
    JSR StartBufferWrite
        LDA #28
        JSR WriteByteToBuffer
        LDA #$21
        JSR WriteByteToBuffer
        LDA helper+1
        JSR WriteByteToBuffer
        LDA #_VR
        JSR WriteByteToBuffer
        LDA #___
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #26
        BNE :-
        LDA #_VR
        JSR WriteByteToBuffer
    JSR EndBufferWrite
    INC helper
    LDA helper+1
    CLC
    ADC #$20
    STA helper+1
    LDA helper
    CMP #5
    BNE :--

    LDX #28 ; bottom row
    JSR StartBufferWrite
        LDA #28
        JSR WriteByteToBuffer
        LDA #$22
        JSR WriteByteToBuffer
        LDA #$02
        JSR WriteByteToBuffer
        LDA #_RU
        JSR WriteByteToBuffer
        LDA #_HR
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #26
        BNE :-
        LDA #_LU
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    LDX #TEXT_POPUP_LINE_LEN  ; popup text line 1
    JSR StartBufferWrite
        LDA #TEXT_POPUP_LINE_LEN
        JSR WriteByteToBuffer
        LDA #$21
        JSR WriteByteToBuffer
        LDA #$84
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA popupTextLine1, X
        JSR WriteByteToBuffer
        INX
        CPX #TEXT_POPUP_LINE_LEN
        BNE :-
    JSR EndBufferWrite

    LDX #TEXT_POPUP_LINE_LEN  ; popup text line 2
    JSR StartBufferWrite
        LDA #TEXT_POPUP_LINE_LEN
        JSR WriteByteToBuffer
        LDA #$21
        JSR WriteByteToBuffer
        LDA #$C4
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA popupTextLine2, X
        JSR WriteByteToBuffer
        INX
        CPX #TEXT_POPUP_LINE_LEN
        BNE :-
    JSR EndBufferWrite

    LDA #$22 ; erase "Press A to size up the situation"
    STA pointer
    LDA #$20
    STA pointer+1
    JSR BufferDrawBlankLine
    JSR BufferDrawPressStart ; draw "Press start to continue"

    RTS
.endproc

.proc CloseTextPopup

    LDX #16  ; attributes
    JSR StartBufferWrite
        LDA #16
        JSR WriteByteToBuffer
        LDA #$23
        JSR WriteByteToBuffer
        LDA #$D0
        JSR WriteByteToBuffer
        LDX #8
        LDA #$a0
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
        LDX #8
        LDA #$aa
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite

    LDA #0
    STA helper
    LDA #$40
    STA helper+1
    :
    LDX #$20
    JSR StartBufferWrite
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$21
        JSR WriteByteToBuffer
        LDA helper+1
        JSR WriteByteToBuffer
        LDA #TILE_GRASS
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #$20
        BNE :-
    JSR EndBufferWrite
    INC helper
    LDA helper+1
    CLC
    ADC #$20
    STA helper+1
    LDA helper
    CMP #6
    BNE :--

    JSR ClearPopupText

    LDA #$23 ; erase "Press Start to continue"
    STA pointer
    LDA #$60
    STA pointer+1
    JSR BufferDrawBlankLine
    JSR BufferDrawSizeUpSituation ; draw "Press A to size up the situation"
    RTS
.endproc

.proc BufferDrawTravelingHUD
    LDA #0
    STA helper
    LDA #$22
    STA pointer+1
    LDA #$40
    STA pointer
    :
    LDX #$20
    JSR StartBufferWrite
        LDA #$20
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA #___
        LDX #0
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
    ADC #$0
    STA pointer+1
    INC helper
    LDA helper
    CMP #8
    BNE :--

    LDX #8
    JSR StartBufferWrite
        LDA #8
        JSR WriteByteToBuffer
        LDA #$23
        JSR WriteByteToBuffer
        LDA #$E0
        JSR WriteByteToBuffer
        LDA #%01011111
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #8
        BNE :-
    JSR EndBufferWrite

    LDX #8
    JSR StartBufferWrite
        LDA #8
        JSR WriteByteToBuffer
        LDA #$23
        JSR WriteByteToBuffer
        LDA #$E8
        JSR WriteByteToBuffer
        LDA #%01010101
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #8
        BNE :-
    JSR EndBufferWrite

    LDX #8
    JSR StartBufferWrite
        LDA #8
        JSR WriteByteToBuffer
        LDA #$23
        JSR WriteByteToBuffer
        LDA #$F0
        JSR WriteByteToBuffer
        LDA #%11110101
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #8
        BNE :-
    JSR EndBufferWrite

    LDX #6 ; draw Date:
    JSR StartBufferWrite
        LDA #6
        JSR WriteByteToBuffer
        LDA #$22
        JSR WriteByteToBuffer
        LDA #$6B
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA hudText, X
        JSR WriteByteToBuffer
        INX
        CPX #4
        BNE :-
        LDA #_CL
        JSR WriteByteToBuffer
        LDA #___
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    LDX #9 ; draw Weather:
    JSR StartBufferWrite
        LDA #9
        JSR WriteByteToBuffer
        LDA #$22
        JSR WriteByteToBuffer
        LDA #$88
        JSR WriteByteToBuffer
        LDX #4
        :
        LDA hudText, X
        JSR WriteByteToBuffer
        INX
        CPX #11
        BNE :-
        LDA #_CL
        JSR WriteByteToBuffer
        LDA #___
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    LDX #8 ; draw Health:
    JSR StartBufferWrite
        LDA #8
        JSR WriteByteToBuffer
        LDA #$22
        JSR WriteByteToBuffer
        LDA #$A9
        JSR WriteByteToBuffer
        LDX #11
        :
        LDA hudText, X
        JSR WriteByteToBuffer
        INX
        CPX #17
        BNE :-
        LDA #_CL
        JSR WriteByteToBuffer
        LDA #___
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    LDX #6 ; draw Food:
    JSR StartBufferWrite
        LDA #6
        JSR WriteByteToBuffer
        LDA #$22
        JSR WriteByteToBuffer
        LDA #$CB
        JSR WriteByteToBuffer
        LDX #17
        :
        LDA hudText, X
        JSR WriteByteToBuffer
        INX
        CPX #21
        BNE :-
        LDA #_CL
        JSR WriteByteToBuffer
        LDA #___
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    LDX #15 ; draw Next Landmark:
    JSR StartBufferWrite
        LDA #15
        JSR WriteByteToBuffer
        LDA #$22
        JSR WriteByteToBuffer
        LDA #$E2
        JSR WriteByteToBuffer
        LDX #21
        :
        LDA hudText, X
        JSR WriteByteToBuffer
        INX
        CPX #34
        BNE :-
        LDA #_CL
        JSR WriteByteToBuffer
        LDA #___
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    LDX #16 ; draw Miles traveled:
    JSR StartBufferWrite
        LDA #16
        JSR WriteByteToBuffer
        LDA #$23
        JSR WriteByteToBuffer
        LDA #$01
        JSR WriteByteToBuffer
        LDX #34
        :
        LDA hudText, X
        JSR WriteByteToBuffer
        INX
        CPX #48
        BNE :-
        LDA #_CL
        JSR WriteByteToBuffer
        LDA #___
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    RTS
.endproc

.proc BufferDrawTravelingHUDValues
    LDA #$22 ; draw date
    STA pointer
    LDA #$70
    STA pointer+1
    JSR BufferDrawDateText
    LDA #$22 ; draw weather
    STA pointer
    LDA #$90
    STA pointer+1
    JSR BufferDrawWeatherText
    LDA #$22 ; draw health
    STA pointer
    LDA #$B0
    STA pointer+1
    JSR BufferDrawHealthText
    LDA #$22 ; draw food
    STA pointer
    LDA #$D0
    STA pointer+1
    JSR BufferDrawFoodText
    LDA #$22 ; draw next landmark miles
    STA pointer
    LDA #$F0
    STA pointer+1
    JSR BufferDrawNextText
    LDA #$23 ; draw miles traveled
    STA pointer
    LDA #$10
    STA pointer+1
    JSR BufferDrawTraveledText
    RTS
.endproc

.proc BufferClearTravelingHUDValue
    LDX #12
    JSR StartBufferWrite
        LDA #12
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDX #12
        LDA #___
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite
    :                   ; vblankwait for aesthetic reasons
    BIT PPUSTATUS
    BPL :-
    RTS
.endproc

.proc BufferDrawDateText
    ; @param pointer: nametable location
    JSR BufferClearTravelingHUDValue
    LDX #TEXT_DATE_LEN
    JSR StartBufferWrite
        LDA #TEXT_DATE_LEN
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA dateText, X
        JSR WriteByteToBuffer
        INX
        CPX #TEXT_DATE_LEN
        BNE :-
    JSR EndBufferWrite
    :                   ; vblankwait for aesthetic reasons
    BIT PPUSTATUS
    BPL :-
    RTS
.endproc

.proc BufferDrawWeatherText
    ; @param pointer: nametable location
    JSR BufferClearTravelingHUDValue
    LDX #TEXT_WEATHER_LEN
    JSR StartBufferWrite
        LDA #TEXT_WEATHER_LEN
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDX #0 ; weather text (temperature)
        STX helper
        LDY #0
        :
        CPY weather
        BNE :+
        JMP :++
        :
        INX
        INC helper
        LDA helper
        CMP #TEXT_WEATHER_LEN
        BNE :-
        LDA #0
        STA helper
        INY
        JMP :--
        :
        LDA weatherText, X
        JSR WriteByteToBuffer
        INX
        INC helper
        LDA helper
        CMP #TEXT_WEATHER_LEN
        BNE :-
    JSR EndBufferWrite
    :                   ; vblankwait for aesthetic reasons
    BIT PPUSTATUS
    BPL :-
    RTS
.endproc

.proc BufferDrawHealthText
    ; @param pointer: nametable location
    JSR BufferClearTravelingHUDValue
    LDX #TEXT_HEALTH_LEN
    JSR StartBufferWrite
        LDA #TEXT_HEALTH_LEN
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDA wagonHealth
        CMP #35
        BCS :+
        LDX #TEXT_HEALTH_LEN*0 ; good health
        JMP @text
        :
        CMP #70
        BCS :+
        LDX #TEXT_HEALTH_LEN*1 ; fair health
        JMP @text
        :
        CMP #105
        BCS :+
        LDX #TEXT_HEALTH_LEN*2 ; poor health
        JMP @text
        :
        LDX #TEXT_HEALTH_LEN*3 ; very poor health
        @text:
        LDY #0
        STY helper
        :
        LDA healthText, X
        JSR WriteByteToBuffer
        INX
        INC helper
        LDA helper
        CMP #TEXT_HEALTH_LEN
        BNE :-
    JSR EndBufferWrite
    :                   ; vblankwait for aesthetic reasons
    BIT PPUSTATUS
    BPL :-
    RTS
.endproc

.proc BufferDrawFoodText
    ; @param pointer: nametable location
    JSR BufferClearTravelingHUDValue
    LDX #11 ; "XXXX_POUNDS"
    JSR StartBufferWrite
        LDA #11
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA foodLbsDigit, X
        JSR WriteByteToBuffer
        INX
        CPX #4
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDX #41
        :
        LDA hudMenuStatusText, X
        JSR WriteByteToBuffer
        INX
        CPX #47
        BNE :-
    JSR EndBufferWrite
    :                   ; vblankwait for aesthetic reasons
    BIT PPUSTATUS
    BPL :-
    RTS
.endproc

.proc BufferDrawNextText
    ; @param pointer: nametable location
    JSR BufferClearTravelingHUDValue
    LDX #9 ; "XXX_MILES"
    JSR StartBufferWrite
        LDA #9
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDX #1
        :
        LDA nextDigit, X
        JSR WriteByteToBuffer
        INX
        CPX #4
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDX #47
        :
        LDA hudMenuStatusText, X
        JSR WriteByteToBuffer
        INX
        CPX #52
        BNE :-
    JSR EndBufferWrite
    :                   ; vblankwait for aesthetic reasons
    BIT PPUSTATUS
    BPL :-
    RTS
.endproc

.proc BufferDrawTraveledText
    ; @param pointer: nametable location
    JSR BufferClearTravelingHUDValue
    LDX #10 ; "XXXX_MILES"
    JSR StartBufferWrite
        LDA #10
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA traveledDigit, X
        JSR WriteByteToBuffer
        INX
        CPX #4
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDX #47
        :
        LDA hudMenuStatusText, X
        JSR WriteByteToBuffer
        INX
        CPX #52
        BNE :-
    JSR EndBufferWrite
    :                   ; vblankwait for aesthetic reasons
    BIT PPUSTATUS
    BPL :-
    RTS
.endproc

.proc BufferDrawWagon
    LDX #7
    JSR StartBufferWrite
        LDA #7
        JSR WriteByteToBuffer
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$D8
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA bgWagonTop, X
        JSR WriteByteToBuffer
        INX
        CPX #7
        BNE :-
    JSR EndBufferWrite

    LDX #7
    JSR StartBufferWrite
        LDA #7
        JSR WriteByteToBuffer
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$F8
        JSR WriteByteToBuffer
        LDX #7
        :
        LDA bgWagonTop, X
        JSR WriteByteToBuffer
        INX
        CPX #14
        BNE :-
    JSR EndBufferWrite

    LDX #0
    LDY oxenFrame
    :
    CPY #0
    BEQ :+
    TXA
    CLC
    ADC #18
    TAX
    DEY
    JMP :-
    :
    STX helper

    LDX #9
    JSR StartBufferWrite
        LDA #9
        JSR WriteByteToBuffer
        LDA #$21
        JSR WriteByteToBuffer
        LDA #$15
        JSR WriteByteToBuffer
        LDX helper
        LDA #0
        STA helper+1
        :
        LDA bgWagonAnim, X
        JSR WriteByteToBuffer
        INX
        INC helper+1
        LDA helper+1
        CMP #9
        BNE :-
        STX helper
    JSR EndBufferWrite

    LDX #9
    JSR StartBufferWrite
        LDA #9
        JSR WriteByteToBuffer
        LDA #$21
        JSR WriteByteToBuffer
        LDA #$35
        JSR WriteByteToBuffer
        LDX helper
        LDA #0
        STA helper+1
        :
        LDA bgWagonAnim, X
        JSR WriteByteToBuffer
        INX
        INC helper+1
        LDA helper+1
        CMP #9
        BNE :-
    JSR EndBufferWrite

    RTS
.endproc

.proc BufferDrawTravelingAttr
    LDX #24
    JSR StartBufferWrite
        LDA #24
        JSR WriteByteToBuffer
        LDA #$23
        JSR WriteByteToBuffer
        LDA #$C8
        JSR WriteByteToBuffer
        JSR CheckMountainousTerrain
        BNE :++
        LDA #$0a
        LDX #8
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
        JMP :+++
        :
        LDA #$00
        LDX #8
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
        :
        LDA #$a0
        LDX #8
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
        LDA #$aa
        LDX #8
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite
    RTS
.endproc