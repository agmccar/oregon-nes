
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
    BufferStart #$20, #$3f, #$00
        LDX #0
        :
        LDA gameSettings
        AND #1
        BNE :+
        LDA palette, X
        JMP :++
        :
        LDA paletteMono, X
        :
        JSR WriteByteToBuffer
        INX
        CPX #$20
        BNE :---
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
    BufferStart #16, pointer, pointer+1
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
    BufferStart #16, pointer, pointer+1
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
    BufferStart #19, pointer, pointer+1
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
    BufferStart #19, pointer, pointer+1
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
    BufferStart #15, pointer, pointer+1
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
    BufferStart #23, pointer, pointer+1
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
    BufferStart #23, pointer, pointer+1
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
    BufferStart 19, pointer, pointer+1
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
    BufferStart #19, pointer, pointer+1
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
    BufferStart #19, pointer, pointer+1
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
    BufferStart #15, pointer, pointer+1
        LDX #0
        :
        LDA restText, X
        JSR WriteByteToBuffer
        INX
        CPX #9
        BNE :-
        LDA wagonRest
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

.proc BufferSetPaletteBlue
    LDA gameSettings
    AND #1
    BNE Done
    BufferStart #1, #$3f, #$02
        LDA #C_BLUE
        JSR WriteByteToBuffer
    JSR EndBufferWrite
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

.proc BufferDrawSupplies
    LDA gameSettings
    AND #1
    BNE :++
    BufferStart #$10, #$3f, #$00
        LDX #0
        :
        LDA suppliesPalette, X
        JSR WriteByteToBuffer
        INX
        CPX #$10
        BNE :-
    JSR EndBufferWrite

    : ; vblankwait
    BIT PPUSTATUS
    BPL :-
    LDY #6 ; get image data
    JSR bankswitch_y

    BufferStart #7*8, #$23, #$C0 ; attributes
        LDX #0
        :
        LDA suppliesAttr, X
        JSR WriteByteToBuffer
        INX
        CPX #7*8
        BNE :-
    JSR EndBufferWrite
    LDX #0 ; image
    STX helper
    :
    TXA
    PHA
    LDA suppliesImage, X
    TAX
    JSR StartBufferWrite
        PLA
        TAX
        LDA suppliesImage, X
        JSR WriteByteToBuffer
        CLC
        LDA helper
        ADC #3
        ADC suppliesImage, X
        STA helper
        INX
        :
        LDA suppliesImage, X
        JSR WriteByteToBuffer
        INX
        CPX helper
        BNE :-
    JSR EndBufferWrite
    LDA suppliesImage, X
    BNE :--
    LDY #1
    JSR bankswitch_y

    BufferStart #12, #$20, #$B0 ; oxenDigit
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

    BufferStart #12, #$20, #$F0 ; clothingDigit
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

    BufferStart #12, #$21, #$30 ; bulletsDigit
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

    BufferStart #12, #$21, #$70 ; wagon wheels
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

    BufferStart #12, #$21, #$b0 ; wagon axles
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

    BufferStart #12, #$21, #$F0 ; wagon tongues
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

    BufferStart #12, #$22, #$30 ; foodLbsDigit
        LDX #TEXT_SUPPLIES_LEN*6
        INX
        INX
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
        LDA #___
        JSR WriteByteToBuffer
        LDA #_LB
        JSR WriteByteToBuffer
    JSR EndBufferWrite

    BufferStart #12, #$22, #$70 ; dollars
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
    BufferStart #$20, #$22, #$00
        LDA #___
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #$20
        BNE :-
    JSR EndBufferWrite
    BufferStart #$20, #$22, #$20
        LDX #0
        :
        LDA sizeUpSituationText, X
        JSR WriteByteToBuffer
        INX
        CPX #$20
        BNE :-
    JSR EndBufferWrite

    BufferStart #8, #$23, #$E0
        LDA #$5f
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #8
        BNE :-
    JSR EndBufferWrite
    RTS
.endproc

.proc BufferDrawPressStart
    BufferStart #$20, #$23, #$40
        LDA #___
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #$20
        BNE :-
    JSR EndBufferWrite
    BufferStart #$20, #$23, #$60
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

.proc BufferDrawMapTitle
    BufferStart #3, #$23, #$C4 ; attributes
        LDA #$a5
        LDX #3
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite
    BufferStart #4, #$23, #$CC
        LDA #$0a
        LDX #4
        :
        JSR WriteByteToBuffer
        DEX
        BNE :-
    JSR EndBufferWrite
    
    BufferStart #10, #$20, #$71 ; "MAP OF THE"
        LDX #0
        :
        LDA mapTitleText, X
        JSR WriteByteToBuffer
        INX
        CPX #10
        BNE :-
    JSR EndBufferWrite
    BufferStart #12, #$20, #$92 ; "OREGON TRAIL"
        LDX #0+10
        :
        LDA mapTitleText, X
        JSR WriteByteToBuffer
        INX
        CPX #12+10
        BNE :-
    JSR EndBufferWrite
    RTS
.endproc

.proc BufferDrawBlankLine
    ; pointer: nametable address
    BufferStart #$20, pointer, pointer+1
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

    BufferStart #16, #$23, #$D0 ; attributes
        LDX #0
        :
        LDA attrPopupText, X
        JSR WriteByteToBuffer
        INX
        CPX #16
        BNE :-
    JSR EndBufferWrite
    
    LDA #$22 ; erase "Press A to size up the situation"
    STA pointer
    LDA #$00
    STA pointer+1
    LDX #2
    :
    TXA
    PHA
    BufferStart #$20, pointer, pointer+1
        LDA #TILE_GRASS
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #$20
        BNE :-
    JSR EndBufferWrite
    CLC
    LDA pointer+1
    ADC #$20
    STA pointer+1
    LDA pointer
    ADC #0
    STA pointer
    PLA
    TAX
    DEX
    BNE :--
    BufferStart #8, #$23, #$E0 ; grass color
        LDA #$5A
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #8
        BNE :-
    JSR EndBufferWrite


    BufferStart #28, #$21, #$42 ; top row
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

    LDX #4 ; row 1-4
    LDA #$62
    STA helper+1
    :
    TXA
    PHA
    BufferStart #28, #$21, helper+1
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
    LDA helper+1
    CLC
    ADC #$20
    STA helper+1
    PLA
    TAX
    DEX
    BNE :--

    BufferStart #28, #$21, #$E2 ; bottom row
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

    BufferStart #TEXT_POPUP_LINE_LEN, #$21, #$84 ; popup text line 1
        LDX #0
        :
        LDA popupTextLine1, X
        JSR WriteByteToBuffer
        INX
        CPX #TEXT_POPUP_LINE_LEN
        BNE :-
    JSR EndBufferWrite

    BufferStart #TEXT_POPUP_LINE_LEN, #$21, #$A4 ; popup text line 2
        LDX #0
        :
        LDA popupTextLine2, X
        JSR WriteByteToBuffer
        INX
        CPX #TEXT_POPUP_LINE_LEN
        BNE :-
    JSR EndBufferWrite

    JSR BufferDrawPressStart ; draw "Press start to continue"

    RTS
.endproc

.proc CloseTextPopup

    LDA #0
    STA helper
    LDA #$40
    STA helper+1
    :
    BufferStart #$20, #$21, helper+1
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

    BufferStart #16, #$23, #$D0 ; attributes
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
    BufferStart #$20, pointer+1, pointer
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

    BufferStart #8, #$23, #$E0
        LDA #%01011111
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #8
        BNE :-
    JSR EndBufferWrite

    BufferStart #8, #$23, #$E8
        LDA #%01010101
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #8
        BNE :-
    JSR EndBufferWrite

    BufferStart #8, #$23, #$F0
        LDA #%11110101
        LDX #0
        :
        JSR WriteByteToBuffer
        INX
        CPX #8
        BNE :-
    JSR EndBufferWrite

    BufferStart #6, #$22, #$6B ; draw Date:
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

    BufferStart #9, #$22, #$88 ; draw Weather:
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

    BufferStart #8, #$22, #$A9 ; draw Health:
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

    BufferStart #6, #$22, #$CB ; draw Food:
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

    BufferStart #15, #$22, #$E2 ; draw Next Landmark:
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

    BufferStart #16, #$23, #$01 ; draw Miles traveled:
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

.proc BufferDrawMainMenuHUDValues
    LDA menuOpen
    CMP #MENU_MAINMENU
    BNE Done
    LDA wagonRest
    BEQ Done
    LDA #$20 ; draw date
    STA pointer
    LDA #$8A
    STA pointer+1
    JSR BufferDrawDateText
    LDA #$20 ; draw weather
    STA pointer
    LDA #$EC
    STA pointer+1
    JSR BufferDrawWeatherText
    LDA #$21 ; draw health
    STA pointer
    LDA #$2C
    STA pointer+1
    JSR BufferDrawHealthText
    Done:
    RTS 
.endproc

.proc BufferDrawTravelingHUDValues
    LDA menuOpen
    CMP #MENU_NONE
    BEQ :+
    JMP Done
    :
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
    Done:
    RTS
.endproc

.proc BufferClearTravelingHUDValue
    BufferStart #12, pointer, pointer+1
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
    BufferStart #TEXT_DATE_LEN, pointer, pointer+1
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
    BufferStart #TEXT_WEATHER_LEN, pointer, pointer+1
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
    BufferStart #TEXT_HEALTH_LEN, pointer, pointer+1
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
    BufferStart #11, pointer, pointer+1 ; "XXXX_POUNDS"
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
    BufferStart #9, pointer, pointer+1 ; "XXX_MILES"
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
    BufferStart #10, pointer, pointer+1 ; "XXXX_MILES"
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
    LDA menuOpen
    CMP #MENU_NONE
    BEQ :+
    JMP Done
    :
    BufferStart #7, #$20, #$D8
        LDX #0
        :
        LDA bgWagonTop, X
        JSR WriteByteToBuffer
        INX
        CPX #7
        BNE :-
    JSR EndBufferWrite

    BufferStart #7, #$20, #$F8
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

    BufferStart #9, #$21, #$15
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

    BufferStart #9, #$21, #$35
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
    Done:
    RTS
.endproc

.proc BufferDrawTravelingAttr
    BufferStart #24, #$23, #$C8
        LDA location
        CMP #LOC_FORTLARAMIE
        BCS :++
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
