
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
    LDA #0
    LDX #0 ;loop 22 times
    :
    STA PPUDATA
    INX
    CPX #22
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
    LDA #___
    :
    STA PPUDATA
    INX
    CPX helper2+1
    BNE :-
    LDY #0
    :
    LDA textLineHelper, Y
    STA PPUDATA
    INY
    CPY helper2
    BNE :-
    LDA #32
    SEC
    SBC helper2
    SBC helper2+1
    TAX
    LDA #___
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
    LDA #___
    :
    STA PPUDATA
    INX
    CPX #10
    BNE :-
    JSR DrawDateText
    LDA #___
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

.proc DrawHUDMainMenu
    LDA PPUSTATUS   ; set color palette (attribute table)
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR
    LDA #%11111111
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #8
    BNE :-
    LDA #%01111111
    STA PPUDATA
    LDA #%01011111
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #6
    BNE :-
    LDA #%11011111
    STA PPUDATA
    LDA #%11110111
    STA PPUDATA
    LDA #%11110101
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #6
    BNE :-
    LDA #%11111101
    STA PPUDATA
    LDA #%11111111
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

.proc GetLandmarkImage
    ; Clobbers all registers
    ; Changes ROM bank
    LDA #0
    STA helper
    LDY #7
    :
    LDA helper
    CMP location
    BEQ :+
    TYA
    CLC
    ADC #7 ; landmarkImageMeta section length
    TAY
    INC helper
    JMP :-
    :
    LDA #<landmarkImageMeta
    STA pointer
    LDA #>landmarkImageMeta
    STA pointer+1
    LDX #7
    :
    DEY
    LDA (pointer), Y
    PHA
    DEX
    BNE :-
    PLA
    STA pointer
    PLA
    STA pointer+1
    PLA
    STA helper+0
    PLA
    STA helper+1
    PLA
    STA helper2+0
    PLA
    STA helper2+1
    PLA
    TAY
    JSR bankswitch_y
    JSR CopyCHRPatternB
    RTS
.endproc

.proc DrawLandmarkImage
    ; set palette
    LDA gameSettings
    AND #1
    BNE :++
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
    :
    LDA currentBank
    PHA
    JSR GetLandmarkImage
    LDA helper ; set attribute table
    STA pointer
    LDA helper+1
    STA pointer+1
    LDA #6*8
    STA counter
    LDA #0
    STA counter+1
    LDA PPUSTATUS
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR
    JSR UnpackData
    LDA #%11110101
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #8
    BNE :-
    LDA #0
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #8
    BNE :-
    LDA helper2   ; draw image
    STA pointer
    LDA helper2+1
    STA pointer+1
    LDA #$80 ; 640 bytes for bg image (#$280)
    STA counter
    LDA #$02
    STA counter+1
    LDA PPUSTATUS
    LDA #$20
    STA PPUADDR
    LDA #$40
    STA PPUADDR
    JSR UnpackData
    PLA
    TAY
    JSR bankswitch_y
    RTS
.endproc

.proc CopyCHRTiles ; copy both chr tables from ROM bank to CHR RAM
    ; @param pointer: chr binary
    LDY #0
    STY PPUMASK
    STY PPUADDR
    STY PPUADDR
    LDX #$20
    :
    LDA (pointer), Y
    STA PPUDATA
    INY
    BNE :-
    INC pointer+1
    DEX
    BNE :-
    RTS
.endproc

.proc CopyCHRPatternB
    ; copy 13 rows of 16 tiles each to Pattern B
    ; @param pointer: location of compressed data
    LDA #$00 ; load 13x16x16 into counter (number of bytes to copy)
    STA counter
    LDA #$0D
    STA counter+1
    LDA #0
    STA PPUMASK
    LDA #$10
    STA PPUADDR
    LDA #$00
    STA PPUADDR
    JSR UnpackData
    RTS
.endproc

.proc UnpackTilesMeta
    ; Clobbers all registers, helper+0, pointer, counter
    ; @param pointer: location of tile meta
    LDA currentBank
    PHA
    LDY #5 ; length of tile meta segment
    :
    DEY
    LDA (pointer), Y
    PHA
    CPY #0
    BNE :-
    PLA ; ROM bank number
    TAY
    JSR bankswitch_y
    PLA ; Address of tile CHR
    STA pointer
    PLA
    STA pointer+1
    LDA #0
    STA counter
    PLA ; Number of rows of 16 tiles 
    STA counter+1
    LDA #0
    STA PPUMASK
    LDA PPUSTATUS
    LDA #$10
    STA helper
    PLA ; Destination 'y-value' (row index) of tiles in CHRRAM
    CLC
    ADC helper
    STA PPUADDR
    LDA #0
    STA PPUADDR
    JSR UnpackData
    PLA
    TAY
    JSR bankswitch_y
    RTS
.endproc

.proc UnpackData
    ; PPUADDR should be set immediately before this subroutine
    ; @param pointer: location of compressed data 
    ; @param counter: total unpacked bytes to write to PPUDATA
    LDY #0
    NextSegment:
    LDA counter ; break loop if counter is depleted
    BNE :+
    LDA counter+1
    BNE :+
    JMP Done
    :
    LDA (pointer), Y ; read header byte
    BPL Literal
    AND #$7f ; write repeated run of bytes
    TAX
    JSR IncrementPointerY
    LDA (pointer), Y
    :
    STA PPUDATA
    JSR DecrementCounter
    DEX
    CPX #0
    BNE :-
    JSR IncrementPointerY
    JMP NextSegment
    Literal: ; write literal bytes
    TAX
    JSR IncrementPointerY
    :
    LDA (pointer), Y
    STA PPUDATA
    JSR DecrementCounter
    JSR IncrementPointerY
    DEX
    CPX #0
    BNE :-
    JMP NextSegment
    Done:
    RTS
.endproc

.proc DrawAdornments

    LDY #6
    JSR bankswitch_y

    LDA #<adornmentTiles ; load tiles into pattern B
    STA pointer
    LDA #>adornmentTiles
    STA pointer+1
    LDY #0
    STY PPUMASK
    LDY #$10
    STY PPUADDR
    LDY #$00
    STY PPUADDR
    LDX #$02
    :
    LDA (pointer), Y
    STA PPUDATA
    INY
    BNE :-
    INC pointer+1
    DEX
    BNE :-

    LDA gameState ; decide where to draw first adornment
    CMP #GAMESTATE_TITLE
    BNE :+
    LDX #$E0 ; under the title logo
    JMP :++
    :
    LDX #$60 ; tippy top of screen
    :
    LDA PPUSTATUS
    LDA #$20
    STA PPUADDR
    STX PPUADDR

    DrawThem:
    LDX #0
    :
    LDA adornmentImage, X ; draw first adornment
    STA PPUDATA
    INX
    CPX #$40
    BNE :-

    LDA PPUSTATUS ; screen location of bottom adornment is always the same 
    LDA #$23
    STA PPUADDR
    LDA #$00
    STA PPUADDR
    LDX #0
    :
    LDA adornmentImage, X ; draw second adornment
    STA PPUDATA
    INX
    CPX #$40
    BNE :-

    LDA PPUSTATUS ; color adornments
    LDA #$23 ; top adornment
    STA PPUADDR
    LDA gameState ; where is it?
    CMP #GAMESTATE_TITLE
    BNE :+
    LDA #$D0 ; below title logo
    STA PPUADDR
    LDA #$fa
    JMP :+++
    :
    LDA #$C0 ; tippy top of screen
    STA PPUADDR
    LDA #$af
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #8
    BNE :-
    LDA #$fa
    :
    
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #8
    BNE :-

    LDA gameState
    CMP #GAMESTATE_TITLE
    BNE :++
    LDA PPUSTATUS
    LDA #$23
    STA PPUADDR
    LDA #$c8
    STA PPUADDR
    LDA #$af
    LDX #0
    :
    STA PPUDATA
    INX
    CPX #8
    BNE :-
    :

    LDA PPUSTATUS
    LDA #$23
    STA PPUADDR
    LDA #$f0 ; bottom adornment
    STA PPUADDR
    LDX #0
    LDA #$fa
    :
    STA PPUDATA
    INX
    CPX #8
    BNE :-
    LDY #1
    JSR bankswitch_y
    RTS
.endproc

.proc DrawTitleLogo

    LDY #6
    JSR bankswitch_y
    
    LDA #<titleLogoTiles ; load tiles into pattern B
    STA pointer
    LDA #>titleLogoTiles
    STA pointer+1
    LDY #0
    STY PPUMASK
    LDY #$12
    STY PPUADDR
    LDY #$00
    STY PPUADDR
    LDX #$03
    :
    LDA (pointer), Y
    STA PPUDATA
    INY
    BNE :-
    INC pointer+1
    DEX
    BNE :-

    LDA PPUSTATUS ; draw title logo
    LDA #$20
    STA PPUADDR
    LDA #$60
    STA PPUADDR
    LDX #0
    :
    LDA titleLogoImage, X
    STA PPUDATA
    INX
    CPX #$80
    BNE :-

    LDA PPUSTATUS ; color title logo
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR
    LDX #0
    LDA #$af
    :
    STA PPUDATA
    INX
    CPX #8
    BNE :-
    LDX #0
    LDA #$aa
    :
    STA PPUDATA
    INX
    CPX #8
    BNE :-

    LDY #1
    JSR bankswitch_y
    
    RTS
.endproc

.proc DrawNamePartyImage

    LDA #<namepartyTilesMeta 
    STA pointer
    LDA #>namepartyTilesMeta
    STA pointer+1
    JSR UnpackTilesMeta
    
    LDY #0
    JSR bankswitch_y

    LDA #<namepartyAttr ; set attribute table
    STA pointer
    LDA #>namepartyAttr
    STA pointer+1
    LDA #8*8
    STA counter
    LDA #0
    STA counter+1
    LDA PPUSTATUS
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR
    JSR UnpackData

    LDA #<namepartyImage   ; draw image
    STA pointer
    LDA #>namepartyImage
    STA pointer+1
    LDA #$a0 ; 13x$20 tiles for nameparty image (#$1a0)
    STA counter
    LDA #$01
    STA counter+1
    LDA PPUSTATUS
    LDA #$20
    STA PPUADDR
    LDA #$40
    STA PPUADDR
    JSR UnpackData

    LDY #1
    JSR bankswitch_y

    RTS
.endproc

.proc LoadTextCHR
    LDA #<textTilesMeta
    STA pointer
    LDA #>textTilesMeta
    STA pointer+1
    JSR UnpackTilesMeta
    RTS
.endproc

.proc LoadMattCHR
    LDA #<mattTilesMeta
    STA pointer
    LDA #>mattTilesMeta
    STA pointer+1
    JSR UnpackTilesMeta
    RTS
.endproc