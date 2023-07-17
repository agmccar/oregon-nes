
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

.proc BufferDrawStatus
    CLC ; draw health
    LDA pointer+1
    ADC #$48
    STA pointer+1
    LDA pointer
    ADC #$0
    STA pointer
    LDX #6
    JSR StartBufferWrite
        LDA #6
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer

        LDA wagonStatus
        AND #%00001100
        LSR
        LSR
        STA helper
        LDX #0
        LDY #0
        STY helper+1
        :
        CPY helper
        BNE :+
        JMP :++
        :
        INX
        INC helper+1
        LDA helper+1
        CMP #TEXT_HEALTH_LEN
        BNE :-
        LDA #0
        STA helper+1
        INY
        CPY helper
        BNE :--
        :
        LDA healthText, X
        JSR WriteByteToBuffer
        INX
        CPX #TEXT_HEALTH_LEN
        BNE :-
    JSR EndBufferWrite

    CLC ; draw food
    LDA pointer+1
    ADC #$40
    STA pointer+1
    LDA pointer
    ADC #$0
    STA pointer
    LDX #6
    JSR StartBufferWrite
        LDA #6
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
        LDA #_LB
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    CLC ; draw Next
    LDA pointer+1
    ADC #$40
    STA pointer+1
    LDA pointer
    ADC #$0
    STA pointer
    LDX #6
    JSR StartBufferWrite
        LDA #6
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDA #___
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA #_QU ; TODO miles to next landmark
        JSR WriteByteToBuffer
        INX
        CPX #3
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDA #_MI
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    CLC ; draw weather text
    LDA weather
    AND #$F0
    LSR
    LSR
    LSR
    LSR
    TAX
    LDA weatherAttributes, X
    STA helper
    AND #$80
    BNE :+
    JMP Weather1Line
    :
    JMP Weather2Lines
    

    Weather1Line:
        CLC
        LDA pointer+1
        ADC #$29
        STA pointer+1
        LDA pointer
        ADC #$0
        STA pointer
        LDX #TEXT_WEATHER_LEN
        JSR StartBufferWrite
            LDA #TEXT_WEATHER_LEN
            JSR WriteByteToBuffer
            LDA pointer
            JSR WriteByteToBuffer
            LDA pointer+1
            JSR WriteByteToBuffer
            LDA helper
            AND #$0F
            STA helper
            LDY #0
            LDX #0
            STX helper+1
            :
            CPY helper
            BNE :+
            JMP :++
            :
            INX
            INC helper+1
            LDA helper+1
            CMP #TEXT_WEATHER_LEN
            BNE :-
            LDA #0
            STA helper+1
            INY
            JMP :--
            :
            LDA weatherText, X
            JSR WriteByteToBuffer
            INX
            INC helper+1
            LDA helper+1
            CMP #TEXT_WEATHER_LEN
            BNE :-
        JSR EndBufferWrite
        CLC
        LDA pointer+1
        ADC #$A
        STA pointer+1
        LDA pointer
        ADC #$0
        STA pointer
        JMP WeatherTemp
    Weather2Lines:
        CLC
        LDA pointer+1
        ADC #$9
        STA pointer+1
        LDA pointer
        ADC #$0
        STA pointer
        LDX #TEXT_WEATHER_LEN
        JSR StartBufferWrite
            LDA #TEXT_WEATHER_LEN
            JSR WriteByteToBuffer
            LDA pointer
            JSR WriteByteToBuffer
            LDA pointer+1
            JSR WriteByteToBuffer
            LDA helper
            AND #$0F
            STA helper
            LDY #0
            LDX #0
            STX helper+1
            :
            CPY helper
            BNE :+
            JMP :++
            :
            INX
            INC helper+1
            LDA helper+1
            CMP #TEXT_WEATHER_LEN
            BNE :-
            LDA #0
            STA helper+1
            INY
            JMP :--
            :
            LDA weatherText, X
            JSR WriteByteToBuffer
            INX
            INC helper+1
            LDA helper+1
            CMP #TEXT_WEATHER_LEN
            BNE :-
        JSR EndBufferWrite

        CLC
        LDA pointer+1
        ADC #$40
        STA pointer+1
        LDA pointer
        ADC #$0
        STA pointer
        LDX #TEXT_WEATHER_LEN
        JSR StartBufferWrite
            LDA #TEXT_WEATHER_LEN
            JSR WriteByteToBuffer
            LDA pointer
            JSR WriteByteToBuffer
            LDA pointer+1
            JSR WriteByteToBuffer
            LDA helper
            AND #$0F
            STA helper
            LDY #0
            LDX #0
            STX helper+1
            :
            CPY helper
            BNE :+
            JMP :++
            :
            INX
            INC helper+1
            LDA helper+1
            CMP #TEXT_WEATHER_LEN
            BNE :-
            LDA #0
            STA helper+1
            INY
            JMP :--
            :
            CLC
            TXA
            ADC #8
            TAX
            :
            LDA weatherText, X
            JSR WriteByteToBuffer
            INX
            INC helper+1
            LDA helper+1
            CMP #TEXT_WEATHER_LEN
            BNE :-
        JSR EndBufferWrite

        SEC
        LDA pointer+1
        SBC #$16
        STA pointer+1
        LDA pointer
        SBC #$0
        STA pointer
        JMP WeatherTemp
    WeatherTemp:
        LDX #TEXT_TEMP_LEN
        JSR StartBufferWrite
            LDA #TEXT_TEMP_LEN
            JSR WriteByteToBuffer
            LDA pointer
            JSR WriteByteToBuffer
            LDA pointer+1
            JSR WriteByteToBuffer
            LDA weather
            AND #$07
            STA helper
            LDY #0
            LDX #0
            STX helper+1
            :
            CPY helper
            BNE :+
            JMP :++
            :
            INX
            INC helper+1
            LDA helper+1
            CMP #TEXT_TEMP_LEN
            BNE :-
            LDA #0
            STA helper+1
            INY
            JMP :--
            :
            LDA temperatureText, X
            JSR WriteByteToBuffer
            INX
            INC helper+1
            LDA helper+1
            CMP #TEXT_TEMP_LEN
            BNE :-
        JSR EndBufferWrite

    Total:
    CLC ; draw Total
    LDA pointer+1
    ADC #13
    STA pointer+1
    LDA pointer
    ADC #$0
    STA pointer
    LDX #6
    JSR StartBufferWrite
        LDA #6
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
        LDA #_MI
        JSR WriteByteToBuffer
    JSR EndBufferWrite

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
    LDX #$40
    JSR StartBufferWrite    ; oxenDigit
        LDA #$40
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
