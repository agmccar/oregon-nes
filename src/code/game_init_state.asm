
.proc InitStateTitle
    LDA #$18
    STA seed+1
    LDA #$48
    STA seed                ; set an initial seed value ($1848) arbitrarily.
    LDA #%00001101          ; default steady pace, filling rations
    STA wagonSettings
    LDA #2                  ; default cool weather
    STA weather
    LDA #3                  ; default date March 1, 1848
    STA dateMonth
    LDA #0
    STA traveledMi
    STA dateDay             ; date will increment after choosing start month
    LDA #$ff                ; default location (Independence, MO *minus one*)
    STA location            ; location will increment, so start at #$ff
    LDA nextLandmarkDistance ; default next landmark: Indep,MO to KansRivXing
    STA nextMi
    LDA #5                  ; default 0.5" of accumulated rainfall
    STA accumulatedRain
    JSR ClearPopupText      ; clear popup text
    LDX #0
    LDA #___
    :                       ; clear person names
    ;LDA defaultPersonNames, X
    STA personName, X
    INX
    CPX #8*5
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
    LDX #nextDigit
    LDY #nextMi
    JSR SetDigitFromValue
    LDX #traveledDigit
    LDY #traveledMi
    JSR SetDigitFromValue
    LDA #%00000100      ; main fingers visible, pointing right
    STA fingerAttr
    LDA #0              ; initialize cursor
    STA fingerLastX     ; (5x,6y) tiles from top left, facing R
    STA fingerLastY
    LDA #4
    STA fingerX
    LDA #13
    STA fingerY
    JSR LoadBgTitle
    RTS
.endproc

.proc InitStateNewGame
    LDA #%00001100      ; both fingers visible, pointing right
    STA fingerAttr
    LDA #0              ; initialize cursor
    STA fingerLastX     ; (5x,6y) tiles from top left, facing R
    STA fingerLastY
    STA menuCursor      ; page number
    LDA #MENU_NEWGAME_OCCUPATION
    STA menuOpen
    ; JSR LoadBgNewGame   ; Load background
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
    LDA #_0_            ; default empty shopping cart
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
    INC location        ; increment landmark (todo handle trail divide)
    LDX location
    LDA nextLandmarkDistance, X
    STA nextMi
    LDX #nextDigit
    LDY #nextMi
    JSR SetDigitFromValue


    LDA #EVENT_NEXT_LANDMARK
    JSR QueueEvent

    
    LDA #2
    STA fingerX
    LDA #10
    STA fingerY
    JSR LoadBgLandmark  ; Load background
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
    JSR LoadDefaultCHR
    JSR LoadBgTraveling  ; Load background
    RTS
.endproc
