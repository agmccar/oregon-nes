
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

    LDA location ; TODO this entire subroutine needs DRY
    CMP #LOC_INDEPENDENCE
    BNE :+
    LDA #<independenceTiles
    STA pointer
    LDA #>independenceTiles
    STA pointer+1
    LDA #<independenceAttr
    STA helper
    LDA #>independenceAttr
    STA helper+1
    LDA #<independenceImage
    STA helper2
    LDA #>independenceImage
    STA helper2+1
    LDY #2
    JSR bankswitch_y
    JMP Attributes
    :
    CMP #LOC_KANSASRIVER
    BNE :+
    LDA #<kansasRiverTiles
    STA pointer
    LDA #>kansasRiverTiles
    STA pointer+1
    LDA #<kansasRiverAttr
    STA helper
    LDA #>kansasRiverAttr
    STA helper+1
    LDA #<kansasRiverImage
    STA helper2
    LDA #>kansasRiverImage
    STA helper2+1
    LDY #2
    JSR bankswitch_y
    JMP Attributes
    :
    CMP #LOC_BIGBLUERIVER
    BNE :+
    LDA #<bigBlueRiverTiles
    STA pointer
    LDA #>bigBlueRiverTiles
    STA pointer+1
    LDA #<bigBlueRiverAttr
    STA helper
    LDA #>bigBlueRiverAttr
    STA helper+1
    LDA #<bigBlueRiverImage
    STA helper2
    LDA #>bigBlueRiverImage
    STA helper2+1
    LDY #2
    JSR bankswitch_y
    JMP Attributes
    :
    CMP #LOC_FORTKEARNEY
    BNE :+
    LDA #<fortKearneyTiles
    STA pointer
    LDA #>fortKearneyTiles
    STA pointer+1
    LDA #<fortKearneyAttr
    STA helper
    LDA #>fortKearneyAttr
    STA helper+1
    LDA #<fortKearneyImage
    STA helper2
    LDA #>fortKearneyImage
    STA helper2+1
    LDY #2
    JSR bankswitch_y
    JMP Attributes
    :
    CMP #LOC_CHIMNEYROCK
    BNE :+
    LDA #<chimneyRockTiles
    STA pointer
    LDA #>chimneyRockTiles
    STA pointer+1
    LDA #<chimneyRockAttr
    STA helper
    LDA #>chimneyRockAttr
    STA helper+1
    LDA #<chimneyRockImage
    STA helper2
    LDA #>chimneyRockImage
    STA helper2+1
    LDY #3
    JSR bankswitch_y
    JMP Attributes
    :
    CMP #LOC_FORTLARAMIE
    BNE :+
    LDA #<fortLaramieTiles
    STA pointer
    LDA #>fortLaramieTiles
    STA pointer+1
    LDA #<fortLaramieAttr
    STA helper
    LDA #>fortLaramieAttr
    STA helper+1
    LDA #<fortLaramieImage
    STA helper2
    LDA #>fortLaramieImage
    STA helper2+1
    LDY #3
    JSR bankswitch_y
    JMP Attributes
    :
    CMP #LOC_INDEPENDENCEROCK
    BNE :+
    LDA #<independenceRockTiles
    STA pointer
    LDA #>independenceRockTiles
    STA pointer+1
    LDA #<independenceRockAttr
    STA helper
    LDA #>independenceRockAttr
    STA helper+1
    LDA #<independenceRockImage
    STA helper2
    LDA #>independenceRockImage
    STA helper2+1
    LDY #3
    JSR bankswitch_y
    JMP Attributes
    :
    CMP #LOC_SOUTHPASS
    BNE :+
    LDA #<southPassTiles
    STA pointer
    LDA #>southPassTiles
    STA pointer+1
    LDA #<southPassAttr
    STA helper
    LDA #>southPassAttr
    STA helper+1
    LDA #<southPassImage
    STA helper2
    LDA #>southPassImage
    STA helper2+1
    LDY #3
    JSR bankswitch_y
    JMP Attributes
    :
    CMP #LOC_FORTBRIDGER
    BNE :+
    LDA #<fortBridgerTiles
    STA pointer
    LDA #>fortBridgerTiles
    STA pointer+1
    LDA #<fortBridgerAttr
    STA helper
    LDA #>fortBridgerAttr
    STA helper+1
    LDA #<fortBridgerImage
    STA helper2
    LDA #>fortBridgerImage
    STA helper2+1
    LDY #4
    JSR bankswitch_y
    JMP Attributes
    :
    CMP #LOC_GREENRIVER
    BNE :+
    LDA #<greenRiverTiles
    STA pointer
    LDA #>greenRiverTiles
    STA pointer+1
    LDA #<greenRiverAttr
    STA helper
    LDA #>greenRiverAttr
    STA helper+1
    LDA #<greenRiverImage
    STA helper2
    LDA #>greenRiverImage
    STA helper2+1
    LDY #4
    JSR bankswitch_y
    JMP Attributes
    :
    CMP #LOC_SODASPRINGS
    BNE :+
    LDA #<sodaSpringsTiles
    STA pointer
    LDA #>sodaSpringsTiles
    STA pointer+1
    LDA #<sodaSpringsAttr
    STA helper
    LDA #>sodaSpringsAttr
    STA helper+1
    LDA #<sodaSpringsImage
    STA helper2
    LDA #>sodaSpringsImage
    STA helper2+1
    LDY #4
    JSR bankswitch_y
    JMP Attributes
    :
    CMP #LOC_FORTHALL
    BNE :+
    LDA #<fortHallTiles
    STA pointer
    LDA #>fortHallTiles
    STA pointer+1
    LDA #<fortHallAttr
    STA helper
    LDA #>fortHallAttr
    STA helper+1
    LDA #<fortHallImage
    STA helper2
    LDA #>fortHallImage
    STA helper2+1
    LDY #4
    JSR bankswitch_y
    JMP Attributes
    :
    CMP #LOC_SNAKERIVER
    BNE :+
    LDA #<snakeRiverTiles
    STA pointer
    LDA #>snakeRiverTiles
    STA pointer+1
    LDA #<snakeRiverAttr
    STA helper
    LDA #>snakeRiverAttr
    STA helper+1
    LDA #<snakeRiverImage
    STA helper2
    LDA #>snakeRiverImage
    STA helper2+1
    LDY #5
    JSR bankswitch_y
    JMP Attributes
    :
    CMP #LOC_FORTBOISE
    BNE :+
    LDA #<fortBoiseTiles
    STA pointer
    LDA #>fortBoiseTiles
    STA pointer+1
    LDA #<fortBoiseAttr
    STA helper
    LDA #>fortBoiseAttr
    STA helper+1
    LDA #<fortBoiseImage
    STA helper2
    LDA #>fortBoiseImage
    STA helper2+1
    LDY #5
    JSR bankswitch_y
    JMP Attributes
    :
    CMP #LOC_BLUEMOUNTAINS
    BNE :+
    LDA #<blueMountainsTiles
    STA pointer
    LDA #>blueMountainsTiles
    STA pointer+1
    LDA #<blueMountainsAttr
    STA helper
    LDA #>blueMountainsAttr
    STA helper+1
    LDA #<blueMountainsImage
    STA helper2
    LDA #>blueMountainsImage
    STA helper2+1
    LDY #5
    JSR bankswitch_y
    JMP Attributes
    :
    CMP #LOC_FORTWALLAWALLA
    BNE :+
    LDA #<fortWallaWallaTiles
    STA pointer
    LDA #>fortWallaWallaTiles
    STA pointer+1
    LDA #<fortWallaWallaAttr
    STA helper
    LDA #>fortWallaWallaAttr
    STA helper+1
    LDA #<fortWallaWallaImage
    STA helper2
    LDA #>fortWallaWallaImage
    STA helper2+1
    LDY #5
    JSR bankswitch_y
    JMP Attributes
    :
    CMP #LOC_THEDALLES
    BNE :+
    LDA #<theDallesTiles
    STA pointer
    LDA #>theDallesTiles
    STA pointer+1
    LDA #<theDallesAttr
    STA helper
    LDA #>theDallesAttr
    STA helper+1
    LDA #<theDallesImage
    STA helper2
    LDA #>theDallesImage
    STA helper2+1
    LDY #6
    JSR bankswitch_y
    JMP Attributes
    :
    CMP #LOC_WILLAMETTE
    BNE :+
    LDA #<willametteTiles
    STA pointer
    LDA #>willametteTiles
    STA pointer+1
    LDA #<willametteAttr
    STA helper
    LDA #>willametteAttr
    STA helper+1
    LDA #<willametteImage
    STA helper2
    LDA #>willametteImage
    STA helper2+1
    LDY #6
    JSR bankswitch_y
    JMP Attributes
    :

    Attributes:
    JSR CopyCHRPatternB
    LDA PPUSTATUS   ; set attribute table
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR
    LDY #0
    :
    LDA (helper), Y
    STA PPUDATA
    INY
    CPY #8*6
    BNE :-
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

    LDA PPUSTATUS   ; draw image
    LDA #$20
    STA PPUADDR
    LDA #$40
    STA PPUADDR

    LDY #0
    LDX #3
    :
    LDA (helper2), Y
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
    INC helper2+1
    DEX
    BNE :--
    :

    LDY #1
    JSR bankswitch_y
    RTS
.endproc
