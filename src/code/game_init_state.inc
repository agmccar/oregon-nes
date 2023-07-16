
.proc InitStateTitle
    LDA #%00001101          ; default steady pace, filling rations
    STA wagonSettings
    LDA #%00000100          ; default fair weather
    STA weather
    LDA #3                  ; default date March 1, 1848
    STA dateMonth
    LDA #1
    STA dateDay
    LDA #LOC_INDEPENDENCE   ; default location Independence, MO
    STA location
    :                       ; default person names
    LDA defaultPersonNames, X
    STA personName, X
    INX
    CPX #20
    BNE :-
    LDX #dollarsDigit       ; reset digits
    LDY #dollars
    JSR SetDigitFromValue
    LDX #foodLbsDigit
    LDY #foodLbs
    JSR SetDigitFromValue
    LDX #clothingDigit
    LDY #clothing
    JSR SetDigitFromValue
    LDX #bulletsDigit
    LDY #bullets
    JSR SetDigitFromValue
    LDX #oxenDigit
    LDY #oxenHeadcount
    JSR SetDigitFromValue
    LDX #0                  ; default palette
    JSR UpdatePalette
    JSR LoadBgTitle
    RTS
.endproc

.proc InitStateNewGame
    LDA #%00001100      ; both fingers visible, pointing right
    STA fingerAttr
    LDA #0              ; initialize cursor
    STA fingerLastX     ; (5x,6y) tiles from top left, facing R
    STA fingerLastY
    LDA #5
    STA fingerX
    LDA #6
    STA fingerY
    JSR LoadBgNewGame   ; Load background
    RTS
.endproc

.proc InitStateStore
    LDA #%00000100      ; main finger visible, pointing right
    STA fingerAttr
    LDA #0              ; initialize cursor
    STA fingerLastX     ; (5x,6y) tiles from top left, facing R
    STA fingerLastY
    LDA #2
    STA fingerX
    LDA #8
    STA fingerY
    ; LDA #___                ; default empty shopping cart
    LDA #_0_
    LDX #0
    :
    STA cartDollarsDigit, X
    INX
    CPX #20
    BNE :-
    LDA #0
    LDX #0
    :
    STA cartDollars, X
    INX
    CPX #7
    BNE :-
    STA cartSpareParts
    LDA location        ; switch location
    CMP #LOC_INDEPENDENCE
    BNE :+
    JMP Independence
    :
    ; CMP #LOC_LOC2
    ; BNE :+
    ; JMP Loc2
    ; :
    JMP Done
    Independence:
        JMP Done
    ; Loc2:
    ;     JMP Done
    Done:
    JSR LoadBgStore     ; Load background
    RTS
.endproc

.proc InitStateLandmark
    LDA #0
    STA fingerAttr      ; fingers hidden, pointing right
    STA fingerLastX     ; initialize cursor (5x,6y) tiles from top left
    STA fingerLastY
    STA menuOpen        ; no menu open
    STA wagonStatus     ; stopped, at landmark, no rest remaining
    LDA #2
    STA fingerX
    LDA #10
    STA fingerY
    JSR LoadBgLandmark     ; Load background
    RTS
    RTS
.endproc

.proc InitStateMap
    RTS
.endproc

.proc InitStateTraveling
    LDA #%00000100      ; only finger visible, pointing right
    STA fingerAttr
    STA fingerLastX     ; initialize cursor (5x,6y) tiles from top left
    STA fingerLastY
    LDA #MENU_MAINMENU
    STA menuOpen
    LDA wagonStatus
    AND #%00001110
    ORA #%00000010
    STA wagonStatus     ; stopped, on the trail, no rest remaining
    LDA #4
    STA fingerX
    LDA #11
    STA fingerY

    JSR LoadBgTraveling  ; Load background
    RTS
.endproc

.proc InitStateTraveling_
    ; zero sprite
    LDA #$37         ; Y
    STA ZEROSPRITE
    LDA #0          ; tile index
    STA ZEROSPRITE+1
    LDA #%00000001   ; attr
    STA ZEROSPRITE+2
    LDA #$F0         ; X
    STA ZEROSPRITE+3
        
    ;JSR LoadPalette

    LoadBackground:
        LDA PPUSTATUS
        LDA #$20
        STA PPUADDR
        LDA #$00
        STA PPUADDR ; $2000

        LDX #0
        LDY #0
    @repeatLoop:
        INY
    @loop:
        LDA terrain, X
        STA PPUDATA
        INX
        CPX #$00
        BNE @loop
        LDA #$24
        STA PPUADDR
        LDA #$00
        STA PPUADDR ; $2400
        LDX #0
        CPY #2
        BNE @repeatLoop

        LDA #$21
        STA PPUADDR
        LDA #$00
        STA PPUADDR ; $2100
        LDX #0
    @loop2:
        LDA hud1, X
        STA PPUDATA
        INX
        CPX #$00
        BNE @loop2

    @loop3:
        LDA hud2, X
        STA PPUDATA
        INX
        CPX #$00
        BNE @loop3

    @loop4:
        LDA hud3, X
        STA PPUDATA
        INX
        CPX #$C0
        BNE @loop4

    LoadBackgroundAttribute:
        LDA PPUSTATUS
        LDA #$23
        STA PPUADDR
        LDA #$C0
        STA PPUADDR ; $23C0 (first screen attribute table)

        LDX #0
        LDY #0
    @repeatLoop:
        INY
    @loop:
        LDA bgAttribute, X
        STA PPUDATA
        INX
        CPX #$40
        BNE @loop

        LDX #0
        LDA PPUSTATUS ; load second screen attr table
        LDA #$27
        STA PPUADDR
        LDA #$C0
        STA PPUADDR ; $27C0 (attribute table)
        CPY #2
        BNE @repeatLoop ; 2nd screen

        JSR InitOxenSprite
        JSR InitWagonSprite
    RTS
.endproc
