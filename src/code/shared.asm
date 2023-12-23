
; Init states ------------------------------------------------------------------

.proc InitStateTitle
    SBD
    ; LoadCHR #<testChrMeta, #>testChrMeta
    JSR LoadTextCHR
    ;JSR LoadWagonCHR TODO
    EBD
    LDY #BANK_TITLE
    JSR bankswitch_y
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
    LDA #COST_BASE
    STA costBase
    LDA #0
    STA traveledMi
    STA dateDay             ; date will increment after choosing start month
    STA location
    LDA nextLandmarkDistance ; default next landmark: Indep,MO to KansRivXing
    STA nextMi
    LDA #5                  ; default 0.5" of accumulated rainfall
    STA accumulatedRain
    JSR ClearPopupText      ; clear popup text
    LDX #0
    LDA #___
    :                       ; clear person names
    STA personName, X
    INX
    CPX #8*5
    BNE :-
    SetDigit #dollarsDigit, #dollars
    SetDigit #foodLbsDigit, #foodLbs
    SetDigit #clothingDigit, #clothing
    SetDigit #bulletsDigit, #bullets
    SetDigit #oxenDigit, #oxenHeadcount
    SetDigit #nextDigit, #nextMi
    SetDigit #traveledDigit, #traveledMi
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
    LDY #BANK_NEWGAME
    JSR bankswitch_y
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

.proc InitStateMatt
    LDA #MENU_MATT_INTRO1
    STA menuOpen
    LDA #0
    STA fingerAttr
    STA menuCursor
    STA fingerLastLastX
    STA fingerLastLastY
    STA fingerLastX
    STA fingerLastY
    LDA #9
    STA fingerX
    LDA #10
    STA fingerY
    SetDigit #cartOxenCostDigit, #cartOxen
    SetDigit #cartFoodLbsCostDigit, #cartOxen
    SetDigit #cartClothingCostDigit, #cartOxen
    SetDigit #cartBulletsCostDigit, #cartOxen
    SetDigit #cartSparePartsCostDigit, #cartOxen
    SetDigit #cartDollarsDigit, #cartOxen
    SetDigit #cartSubtotalDigit, #cartOxen
    SetDigit #cartHelperDigit, #cartOxen
    SetDigit #cartItemDigit, #cartOxen
    RTS
.endproc

.proc InitStateLandmark
    LDY #BANK_LANDMARK
    JSR bankswitch_y
    LDA #0
    STA fingerAttr      ; fingers hidden, pointing right
    STA fingerLastX     ; initialize cursor (5x,6y) tiles from top left
    STA fingerLastY
    STA menuOpen        ; no menu open
    STA menuCursor
    STA wagonStatus     ; stopped, at landmark, no rest remaining
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
.endproc

.proc InitStateMap
    RTS
.endproc

.proc InitStateTraveling
    LDY #BANK_TRAVELING
    JSR bankswitch_y
    LDA #%00000100      ; only finger visible, pointing right
    STA fingerAttr
    STA fingerLastX     ; initialize cursor (5x,6y) tiles from top left
    STA fingerLastY
    LDA #0
    STA menuCursor
    LDA #MENU_MAINMENU
    STA menuOpen
    LDA wagonStatus
    AND #%00001110
    ORA #%00000010
    STA wagonStatus     ; stopped, on the trail, no rest remaining
    LDX #TEXT_POPUP_LINE_LEN
    LDA #0
    :
    STA popupTextLine1, X
    STA popupTextLine2, X
    DEX
    BNE :-
    LDA #4
    STA fingerX
    LDA #16
    STA fingerY
    SetDigit #dollarsDigit, #dollars
    SetDigit #foodLbsDigit, #foodLbs
    SetDigit #clothingDigit, #clothing
    SetDigit #bulletsDigit, #bullets
    SetDigit #oxenDigit, #oxenHeadcount
    SetDigit #nextDigit, #nextMi
    SetDigit #traveledDigit, #traveledMi
    RTS
.endproc

; Buffer control ---------------------------------------------------------------

.proc ProcessNametableBuffer
    LDA bufferLoading
    CMP #1
    BEQ Done
    LDA PPUSTATUS
    LDX #0 
    LDY nametableBuffer     ; note first byte in buffer (length of data segment)
    STX bufferPointer       ; reset buffer pointer
    STX nametableBuffer     ; reset first byte in buffer
    INX 
    @loop:                  ; read buffer
    CPY #0 
    BNE :+                  ; exit if length of data segment is 0
    JMP Done
    :
    LDA PPUSTATUS
    LDA nametableBuffer, X  ; set PPU address
    STA PPUADDR
    INX
    LDA nametableBuffer, X
    STA PPUADDR
    LDA #0
    STA PPUSCROLL           
    STA PPUSCROLL           ; default 0 scroll position
    INX 
    : 
    LDA nametableBuffer, X 
    STA PPUDATA             ; write buffer data to nametable
    INX
    DEY
    CPY #0
    BNE :-                  ; repeat until no more bytes to copy
    LDY nametableBuffer, X
    INX
    LDA #0 ; https://www.nesdev.org/wiki/PPU_registers#Palette_corruption
    STA PPUADDR
    STA PPUADDR
    JMP @loop               ; exit if entire buffer has been read
    Done:
    RTS
.endproc

.proc StartBufferWrite
    ; @param X: length of segment
    ; A: not affected
    ; Y: not affected
    PHA
    INX
    INX
    INX
    INX                 ; total space needed: length + header(3) + footer(1)
    LDA helper2
    PHA
    STX helper2
    LDA bufferPointer
    CLC
    ADC helper2
    CMP #64         ; buffer must have space for segment
    BCC :+++
    :                   ; vblankwait
    BIT PPUSTATUS
    BPL :-
    :                   ; vblankwait2 i still dont understand NMI 
    BIT PPUSTATUS
    BPL :-
    :
    LDA #1
    STA bufferLoading
    PLA
    STA helper2
    PLA
    RTS
.endproc

.proc EndBufferWrite
    PHA
    TYA
    PHA
    LDA #0
    LDY bufferPointer
    STA nametableBuffer, Y
    LDA #0
    STA bufferLoading
    PLA
    TAY
    PLA
    RTS
.endproc

.proc WriteByteToBuffer
    ; write contents of A register to the nametable buffer
    ; clobbers Y
    LDY bufferPointer
    STA nametableBuffer, Y
    INC bufferPointer
    RTS
.endproc
    
.proc WriteTileToBuffer
    ; X,Y,A = tiles from left, tiles from top, tile index to draw
    ; write one single tile to the nametable buffer
    PHA
    TXA
    PHA
    LDX #1
    JSR StartBufferWrite
        PLA
        TAX
        JSR SetPpuAddrPointerFromXY
        LDA #1
        WBB
        LDA pointer
        WBB
        LDA pointer+1
        WBB
        PLA
        WBB
    EBW
    RTS
.endproc

; Buffer drawing ---------------------------------------------------------------

.proc DrawTextBox
    ; X: addrHi
    ; Y: addrLo
    ; A: number of middle lines (ie height-2)
    ; helper: width of box
    PHA
    STX pointer
    STY pointer+1
    JSR BufferDrawTextBoxTopRow
    JSR PointerToNextLine
    PLA
    TAX
    :
    JSR BufferDrawTextBoxMiddleRow
    JSR PointerToNextLine
    DEX
    BNE :-
    JSR BufferDrawTextBoxBottomRow
    RTS
.endproc

.proc DrawFinger
    LDA #%00001100          ; skip drawing if neither finger is set to visible
    BIT fingerAttr
    BNE :+
    RTS
    :                       ; skip drawing if finger hasn't moved
    LDX fingerX
    LDY fingerY
    CPX fingerLastX
    BNE :+
    CPY fingerLastY
    BNE :+
    RTS
    :                       ; erase finger at old position (draw blank tile)
    LDA #%00010000
    BIT fingerAttr          ; check if main finger is normal or arrows
    BEQ :++
    LDX fingerLastX
    LDY fingerLastY
    CPY #0
    BNE :+
    JMP :+++ ; dont erase if RedrawFinger was just invoked
    :
    LDA #___
    DEY
    WTB
    LDX fingerLastX
    LDY fingerLastY
    LDA #___
    INY
    WTB
    JMP :++
    :
    LDX fingerLastX
    LDY fingerLastY
    LDA #___
    WTB
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
    WTB
    :                       ; draw finger at new position
    LDA #%00000100          ; check if main finger is visible
    BIT fingerAttr
    BEQ :+++
    LDA #%00010000          ; draw normal finger or arrows
    BIT fingerAttr          ; check if main finger is normal or arrows
    BEQ :++
    LDX fingerX
    LDY fingerY
    LDA #%00000001
    BIT fingerAttr
    BEQ :+
    INX
    LDA #_AR    ; arrow right
    WTB
    LDX fingerX
    LDY fingerY
    DEX
    LDA #_AL    ; arrow left
    WTB
    JMP :+++
    :
    INY
    LDA #_AD    ; arrow down
    WTB
    LDX fingerX
    LDY fingerY
    DEY
    LDA #_AU    ; arrow up
    WTB
    JMP :++
    :
    LDX fingerX
    LDY fingerY
    LDA #_PR
    WTB
    :
    LDA fingerX             ; remember last finger position
    STA fingerLastX
    LDA fingerY
    STA fingerLastY
    RTS
.endproc

.proc UpdatePalette
    SBW #$20, #$3f, #$00
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
        WBB
        INX
        CPX #$20
        BNE :---
    EBW
    RTS
.endproc

.proc DrawStoreSubmenu ; todo deprecate
    LDX #2                  ; first row of submenu
    INX
    LDY fingerY
    DEY
    DEY
    JSR SetPpuAddrPointerFromXY
    SBW #16, pointer, pointer+1
        LDA #_RD
        WBB
        LDA #_HR
        LDX #0
        :
        WBB
        INX
        CPX #14
        BNE :-
        LDA #_LD
        WBB
    EBW
    LDX #3                  ; vertical bars (left)
    LDY fingerY
    DEY
    LDA #_VR
    WTB
    LDX #3
    LDY fingerY
    LDA #_VR
    WTB
    LDX #3
    LDY fingerY
    INY
    LDA #_VR
    WTB
    LDX #18                 ; vertical bars (right)
    LDY fingerY
    DEY
    LDA #_VR
    WTB
    LDX #18
    LDY fingerY
    LDA #_VR
    WTB
    LDX #18
    LDY fingerY
    INY
    LDA #_VR
    WTB
    LDX #2                  ; last row of submenu
    INX
    LDY fingerY
    INY
    INY
    JSR SetPpuAddrPointerFromXY
    SBW #16, pointer, pointer+1
        LDA #_RU
        WBB
        LDA #_HR
        LDX #0
        :
        WBB
        INX
        CPX #14
        BNE :-
        LDA #_LU
        WBB
    EBW
    RTS
.endproc

.proc BufferDrawPressStart
    SBW #$20, #$23, #$40
        LDA #___
        LDX #0
        :
        WBB
        INX
        CPX #$20
        BNE :-
    EBW
    SBW #$20, #$23, #$60
        LDX #0
        :
        LDA pressStartText, X
        WBB
        INX
        CPX #$20
        BNE :-
    EBW
    RTS
.endproc

.proc BufferDrawTextBoxTopRow
    ; @param helper: width of box
    ; @param pointer: ppu tilemap addr to draw
    SBW helper, pointer, pointer+1 ; top row
        DEC helper
        DEC helper
        LDA #_RD
        WBB
        LDA #_HR
        LDX #0
        :
        WBB
        INX
        CPX helper
        BNE :-
        LDA #_LD
        WBB
    EBW
    INC helper
    INC helper
    RTS
.endproc

.proc BufferDrawTextBoxBottomRow
    ; @param helper: width of box
    ; @param pointer: ppu tilemap addr to draw
    SBW helper, pointer, pointer+1 ; bottom row
        DEC helper
        DEC helper
        LDA #_RU
        WBB
        LDA #_HR
        LDX #0
        :
        WBB
        INX
        CPX helper
        BNE :-
        LDA #_LU
        WBB
    EBW
    INC helper
    INC helper
    RTS
.endproc

.proc BufferDrawTextBoxMiddleRow
    TXA
    PHA
    SBW helper, pointer, pointer+1
        DEC helper
        DEC helper
        LDA #_VR
        WBB
        LDA #___
        LDX #0
        :
        WBB
        INX
        CPX helper
        BNE :-
        LDA #_VR
        WBB
    EBW
    INC helper
    INC helper
    PLA
    TAX
    RTS
.endproc

.proc BufferDrawTextBox
    LDA gameState
    CMP #GAMESTATE_TITLE
    BNE :+
    LDA #$22
    STA pointer
    LDA #$62
    STA pointer+1
    JMP :++
    :
    LDA #$21
    STA pointer
    LDA #$42
    STA pointer+1
    :
    LDA #28
    STA helper
    JSR BufferDrawTextBoxTopRow

    LDX #4 ; row 1-4
    JSR PointerToNextLine
    :
    JSR BufferDrawTextBoxMiddleRow
    JSR PointerToNextLine
    DEX
    BNE :-

    JSR BufferDrawTextBoxBottomRow

    CLC
    LDA pointer+1
    ADC #2
    STA pointer+1
    LDA pointer
    ADC #0
    STA pointer
    SEC
    LDA pointer+1
    SBC #$60
    STA pointer+1
    LDA pointer
    SBC #0
    STA pointer

    SBW #TEXT_POPUP_LINE_LEN, pointer, pointer+1 ; popup text line 1
        LDX #0
        :
        LDA popupTextLine1, X
        WBB
        INX
        CPX #TEXT_POPUP_LINE_LEN
        BNE :-
    EBW
    JSR PointerToNextLine

    SBW #TEXT_POPUP_LINE_LEN, pointer, pointer+1 ; popup text line 2
        LDX #0
        :
        LDA popupTextLine2, X
        WBB
        INX
        CPX #TEXT_POPUP_LINE_LEN
        BNE :-
    EBW

    RTS
.endproc

.proc BufferDrawTextPopup

    SBW #16, #$23, #$D0 ; attributes
        LDX #0
        :
        LDA attrPopupText, X
        WBB
        INX
        CPX #16
        BNE :-
    EBW
    
    LDA #$22 ; erase "Press A to size up the situation"
    STA pointer
    LDA #$00
    STA pointer+1
    LDX #2
    :
    TXA
    PHA
    SBW #$20, pointer, pointer+1
        LDA #TILE_GRASS
        LDX #0
        :
        WBB
        INX
        CPX #$20
        BNE :-
    EBW
    JSR PointerToNextLine
    PLA
    TAX
    DEX
    BNE :--
    SBW #8, #$23, #$E0 ; grass color
        LDA #$5A
        LDX #0
        :
        WBB
        INX
        CPX #8
        BNE :-
    EBW

    JSR BufferDrawTextBox

    JSR BufferDrawPressStart ; draw "Press start to continue"

    RTS
.endproc

.proc BufferDrawDateText
    ; @param pointer: nametable location
    JSR BufferClearTravelingHUDValue
    SBW #TEXT_DATE_LEN, pointer, pointer+1
        LDX #0
        :
        LDA dateText, X
        WBB
        INX
        CPX #TEXT_DATE_LEN
        BNE :-
    EBW
    ; :                   ; vblankwait for aesthetic reasons
    ; BIT PPUSTATUS
    ; BPL :-
    RTS
.endproc

.proc BufferClearTravelingHUDValue
    SBW #12, pointer, pointer+1
        LDX #12
        LDA #___
        :
        WBB
        DEX
        BNE :-
    EBW
    :                   ; vblankwait for aesthetic reasons
    BIT PPUSTATUS
    BPL :-
    RTS
.endproc

.proc BufferDrawWeatherText
    ; @param pointer: nametable location
    JSR BufferClearTravelingHUDValue
    SBW #TEXT_WEATHER_LEN, pointer, pointer+1
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
        WBB
        INX
        INC helper
        LDA helper
        CMP #TEXT_WEATHER_LEN
        BNE :-
    EBW
    ; :                   ; vblankwait for aesthetic reasons
    ; BIT PPUSTATUS
    ; BPL :-
    RTS
.endproc

.proc BufferDrawHealthText
    ; @param pointer: nametable location
    JSR BufferClearTravelingHUDValue
    SBW #TEXT_HEALTH_LEN, pointer, pointer+1
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
        WBB
        INX
        INC helper
        LDA helper
        CMP #TEXT_HEALTH_LEN
        BNE :-
    EBW
    ; :                   ; vblankwait for aesthetic reasons
    ; BIT PPUSTATUS
    ; BPL :-
    RTS
.endproc

.proc BufferDrawText
    TXA
    PHA
    LDY #0 ; decompress and draw talk text
    STY counter
    LDA #0 ; clear talkTextBuffer, textLineHelper
    LDX #0
    :
    STA talkTextBuffer, X
    CPX #TEXT_POPUP_LINE_LEN
    BCS :+
    ; textLineHelper+3
    ; textLineHelper+4 ; number of words in segment
    STA textLineHelper, X
    :
    INX
    CPX #32
    BNE :--
    LDX #0 ; clear popupTextLine1
    LDA #___
    :
    STA popupTextLine1, X
    INX
    CPX #TEXT_POPUP_LINE_LEN
    BNE :-
    NextSegment:
    LDX #0
    STX counter+1 ; reset talkTextBuffer index
    LDA (pointer), Y ; read first header byte
    BNE :+
    JMP Done
    :
    AND #$0f
    STA helper ; punctuation type
    LDA (pointer), Y
    LSR
    LSR
    LSR
    LSR
    STA helper+1 ; remaining header length
    JSR IncrementPointerY
    LDX #0 ; read word length header bytes
    STX counter+1 ; talkTextBuffer index
    STX textLineHelper+4
    :
    TXA
    PHA
    LDA (pointer), Y
    LSR
    LSR
    LSR
    LSR
    LDX counter+1
    STA talkTextBuffer, X ; stash word lengths
    INC counter+1
    INC textLineHelper+4 ; number of words in segment
    INX
    LDA (pointer), Y
    AND #$0f
    STA talkTextBuffer, X
    BEQ :+
    INC textLineHelper+4 ; number of words in segment
    :
    INC counter+1
    PLA
    TAX
    JSR IncrementPointerY
    INX
    CPX helper+1
    BNE :--
    LDX counter+1
    LDA #0
    STA talkTextBuffer, X
    ; LDX textLineHelper+4
    ; DEX
    ; INC talkTextBuffer, X
    LDX #0 ; begin decompress segment payload
    STX helper2 ; storage for extra letter. starts empty
    NextWord:
    DEC textLineHelper+4
    LDA talkTextBuffer, X
    STA helper+1 ; character length of next word
    BNE SameSegment
    TXA ; done with segment
    PHA ; stash talkTextBuffer index
    LDA helper
    BEQ :+
    JMP NewSpace
    :
    TYA ; "tells you:"
    PHA
    LDA #___
    JSR WriteTextChar
    DEC counter
    LDY #0
    :
    LDA talkTellsYou, Y
    JSR WriteTextChar
    INY
    CPY #10
    BNE :-
    LDA #___
    JSR WriteTextChar

    JSR BufferDrawTextBR

    JSR BufferHelperNextLine
    LDA #_QT
    JSR WriteTextChar
    
    PLA
    TAY

    PLA
    TAX ; unstash talkTextBuffer index
    JMP NextSegment
    NewSpace:
    LDA #___
    JSR WriteTextChar ; write new space
    PLA
    TAX ; unstash talkTextBuffer index
    JMP NextSegment
    SameSegment:
    TXA
    PHA ; stash talkTextBuffer index
    LDX counter
    LDA helper2 ; check if extra letter is stashed
    BEQ NextDataByte
    JSR WriteTextChar
    LDA #0
    STA helper2
    LDA helper+1
    BNE NextDataByte
    JMP Space
    NextDataByte:
    LDA (pointer), Y
    CMP #LITERAL_CHAR
    BCC DictLookup
    CMP #LITERAL_CHAR+26
    BCC LiteralAZ
    SEC
    SBC #LITERAL_CHAR+26
    TAX
    LDA talkSpecialChar, X
    JSR WriteTextChar
    JSR IncrementPointerY
    JMP Space
    LiteralAZ:
    SEC ; literal A-Z character
    SBC #LITERAL_CHAR
    JSR LetterNumToTileIndex
    JSR WriteTextChar
    JSR IncrementPointerY
    JMP Space

    DictLookup: ; dictionary lookup
    STA helper2+1 ; stash (dictionary index+1)
    DEC helper2+1 ; dictionary index+0
    TYA
    PHA ; stash Y
    LDA pointer ; stash pointer
    STA bufferHelper+2
    LDA pointer+1
    STA bufferHelper+3
    LDA #<talkDictionary ; location of dictionary
    STA pointer
    LDA #>talkDictionary
    STA pointer+1
    LDY #0 ; get location of dictionary lookup result
    :
    CLC
    LDA pointer
    ADC helper2+1
    STA pointer
    LDA pointer+1
    ADC #0
    STA pointer+1
    INY
    CPY #2
    BNE :-
    LDY #0
    LDA (pointer), Y ; first char of dict lookup result
    JSR WriteTextChar
    JSR IncrementPointerY
    LDA helper+1
    BNE :+
    LDA (pointer), Y ; stash 2nd char for next word, done with this word
    STA helper2
    JMP :++
    :
    LDA (pointer), Y ; second char of dict lookup result
    JSR WriteTextChar
    :
    PLA ; unstash Y
    TAY
    LDA bufferHelper+2 ; unstash pointer
    STA pointer
    LDA bufferHelper+3
    STA pointer+1
    JSR IncrementPointerY
    ;JMP Space
    Space:
    LDA helper+1
    CMP #0
    BNE :+
    LDA #___
    JSR WriteTextChar
    PLA
    TAX ; unstash talkTextBuffer index
    INX
    JMP NextWord
    :
    JMP NextDataByte
    
    Done:
    LDA menuOpen
    CMP #MENU_TALK
    BNE :+
    LDA #1
    STA textLineHelper+3 ; flag for 1 literal char
    LDA #_QT
    JSR WriteTextChar
    :

    LDX counter
    JSR StartBufferWrite
        LDA counter
        WBB
        LDA bufferHelper
        WBB
        LDA bufferHelper+1
        WBB
        LDX #0
        :
        LDA popupTextLine1, X
        WBB
        INX
        CPX counter
        BNE :-
    EBW
    PLA
    TAX
    RTS
.endproc

.proc WriteTextChar
    PHA
    STX textLineHelper+2 ; stash x
    LDA textLineHelper+3 ; check single char flag
    BEQ :+
    LDA #0
    STA textLineHelper+3
    PLA
    DEC counter
    LDX counter
    STA popupTextLine1, X
    INC counter
    JMP Done
    :
    PLA
    LDX textLineHelper ; index of char in word
    STA wordBuffer, X
    CMP #___ ; check if there are more characters to write
    BEQ :+
    INC textLineHelper
    DEC helper+1 ; remaining chars in word
    JMP Done
    :
    LDA #0
    STA textLineHelper+5
    LDA textLineHelper+4 ; check if there are remaining words in segment
    BNE :+
    LDA helper ; check punctuation type
    BEQ :+
    CLC
    ADC #_CM-1
    CMP #_PR ; '$' EOL
    BEQ :+
    STA wordBuffer, X ; replace last space with punctuation mark
    LDA #1
    STA textLineHelper+5
    :
    LDA counter ; word is done
    CLC
    ADC textLineHelper ; add length of word to length of text line
    ADC textLineHelper+5
    CMP #TEXT_POPUP_LINE_LEN+1 ; check if there is space in text line for word
    BCS :+
    JMP WordToLine
    :
    JSR BufferDrawTextBR
    WordToLine: ; write finished word to line
    INC textLineHelper
    LDX #0
    :
    TXA
    PHA
    LDA wordBuffer, X
    LDX counter
    CPX #TEXT_POPUP_LINE_LEN
    BCS :+
    STA popupTextLine1, X
    :
    INC counter
    PLA
    TAX
    INX
    CPX textLineHelper
    BNE :--
    ClearWordBuffer:
    LDA #0
    STA textLineHelper ; reset index of char in word
    LDA #___
    LDX #0
    :
    STA wordBuffer, X
    INX
    CPX #16
    BNE :-
    Done:
    LDX textLineHelper+2 ; unstash x
    RTS
.endproc

.proc BufferDrawTextBR
    TYA ; no more room in line
    PHA ; stash Y
    LDX #TEXT_POPUP_LINE_LEN ; write line to screen
    JSR StartBufferWrite
        LDA #TEXT_POPUP_LINE_LEN
        WBB
        LDA bufferHelper
        WBB
        LDA bufferHelper+1
        WBB
        LDX #0
        :
        LDA popupTextLine1, X
        WBB
        INX
        CPX #TEXT_POPUP_LINE_LEN
        BNE :-
    EBW
    PLA ; unstash Y
    TAY
    JSR BufferHelperNextLine
    LDX #0
    STX counter ; reset index of char in line
    LDA #___
    :
    STA popupTextLine1, X ; clear popupTextLine1
    INX
    CPX #TEXT_POPUP_LINE_LEN
    BNE :-
    RTS
.endproc

.proc HighlightKeyboardKey
    LDA #60
    STA frameCounter
    SBW #$10, #$23, #$e8
        LDX #$10
        LDA #$ff
        :
        WBB
        DEX
        BNE :-
    EBW

    LDA #$23
    STA pointer
    LDA #$e8
    STA pointer+1
    LDA fingerX
    LSR
    LSR
    CLC
    ADC pointer+1
    STA pointer+1
    LDA fingerY
    CMP #25
    BCC :+
    CLC
    LDA pointer+1
    ADC #8
    STA pointer+1
    :

    LDA fingerX
    LSR
    AND #1
    BEQ :++
    SEC
    LDA fingerY
    SBC #21
    LSR
    AND #1
    BEQ :+
    LDA #$7f
    STA helper
    JMP Done
    :
    LDA #$f7
    STA helper
    JMP Done
    :
    SEC
    LDA fingerY
    SBC #21
    LSR
    AND #1
    BEQ :+
    LDA #$df
    STA helper
    JMP Done
    :
    LDA #$fd
    STA helper


    Done:
    ;     1  2  2  3  3  4  4  5  5  6

    ; 23  1  2  2  3  3  4  4  5  5  6
    ; 25  9  10 10 11 11 12 12    13+14

    ;     06 08 10 12 14 16 18 20 22 24
    ; 21  fb fe fb fe fb fe fb fe fb fe
    ; 23  bf ef bf ef bf ef bf ef bf ef
    ; 25  fb fe fb fe fb fe fb    fb+fe
    SBW #1, pointer, pointer+1
        LDA helper
        WBB
    EBW

    RTS
.endproc

.proc BufferDrawBlankBox
    ; @param bufferHelper[+0,+1]: tilemap address of top left corner
    ; @param X: width of box in tiles
    ; @param Y: height of box in tiles
    ; Clobbers all registers
    STX bufferHelper+2
    :
    TYA
    PHA
    SBW bufferHelper+2, bufferHelper, bufferHelper+1
    LDX bufferHelper+2
    LDA #0
    :
    WBB
    DEX
    BNE :-
    EBW
    CLC
    LDA bufferHelper+1
    ADC #$20
    STA bufferHelper+1
    LDA bufferHelper
    ADC #0
    STA bufferHelper
    PLA
    TAY
    DEY
    BNE :--
    RTS
.endproc

.proc BufferDrawDollarAmount
    ; @param A: cartDigit zero page address
    ; @param bufferHelper destination tilemap address to write text
    STA pointer
    LDA #0
    STA pointer+1
    LDA #_DL
    STA cartHelperDigit
    LDY #0
    LDX #1
    :
    LDA (pointer), Y
    STA cartHelperDigit, X
    INX
    INY
    CPY #4
    BNE :-
    LDA #_00
    STA cartHelperDigit+5

    SBW #6, bufferHelper, bufferHelper+1
        LDX #0
        :
        LDA cartHelperDigit, X
        WBB
        INX
        CPX #6
        BNE :-
    EBW
    RTS
.endproc

.proc SetPaletteSupplies
    LDA gameSettings
    AND #1
    BNE :++
    SBW #$10, #$3f, #$00
        LDX #0
        :
        LDA suppliesPalette, X
        WBB
        INX
        CPX #$10
        BNE :-
    EBW
    :
    RTS
.endproc

.proc BufferDrawTalkText
    LDA location ; get memory location of compressed talk text
    ASL
    CLC
    ADC talkOption
    ADC talkOption
    TAX
    LDA talkPointer, X
    STA pointer
    INX
    LDA talkPointer, X
    STA pointer+1
    LDA #$20 ; PPU address - start at top left
    STA bufferHelper
    LDA #$E4
    STA bufferHelper+1

    LDA currentBank
    PHA
    LDY location ; bankswitch to get text data
    LDA talkTextBank, Y
    TAY
    JSR bankswitch_y

    JSR BufferDrawText
    PLA
    TAY
    JSR bankswitch_y

    INC talkOption ; increment talkOption
    LDA talkOption
    CMP #3
    BNE :+
    LDA #0
    STA talkOption
    :
    RTS
.endproc

.proc BufferDrawImage
    LDY #0
    LDA (pointer), Y ; width
    STA helper
    INY
    LDA (pointer), Y ; height
    TAX
    INY
    LDA (pointer), Y ; ppuaddr hi
    STA helper2
    INY
    LDA (pointer), Y ; ppuaddr lo
    STA helper2+1
    INY
    STY helper+1
    :
    TXA
    PHA
    SBW helper, helper2, helper2+1
        LDX #0
        :
        LDY helper+1
        LDA (pointer), Y
        WBB
        INC helper+1
        INX
        CPX helper
        BNE :-
    EBW
    CLC
    LDA helper2+1
    ADC #$20
    STA helper2+1
    LDA helper2
    ADC #0
    STA helper2
    PLA
    TAX
    DEX
    BNE :--
    RTS
.endproc

; Bulk drawing -----------------------------------------------------------------

.proc StartBulkDrawing
    LDA #0
    STA PPUMASK
    LDA #%00000000      ; turn off screen
    STA softPPUMASK
    ; STA PPUMASK
    :                   ; wait for vblank
    BIT PPUSTATUS
    BPL :-
    RTS
.endproc

.proc EndBulkDrawing
    LDA #0              ; reset scroll position
    STA PPUSCROLL
    STA PPUSCROLL
    LDA #%00011110 
    STA softPPUMASK     ; turn on screen
    :                   ; wait for vblank
    BIT PPUSTATUS
    BPL :-
    RTS
.endproc

.proc ClearScreen
    SBD
    LDX #0 ; clear sprites
    LDA #$FE
    :
    STA $0200, X
    INX
    BNE :-
    LDA #0
    STA OAMADDR ; tell PPU to prepare for transfer to OAM starting at byte zero
    LDA #$02
    STA OAMDMA ; 256 bytes $0200-$02ff into OAM

    LDA PPUSTATUS       ; clear first screen tiles
    LDA #$20
    STA PPUADDR
    LDA #$00
    STA PPUADDR         ; $2000
    LDA #0
    TAX
    TAY
    @clear2000:
    :
    STA PPUDATA
    INX
    CPX #32
    BNE :-
    LDX #0
    INY
    CPY #30
    BNE @clear2000
    LDA PPUSTATUS       ; clear second screen tiles
    LDA #$23
    STA PPUADDR
    LDA #$00
    STA PPUADDR         ; $2300
    LDA #0
    TAX
    TAY
    @clear2300:
    :
    STA PPUDATA
    INX
    CPX #32
    BNE :-
    LDX #0
    INY
    CPY #30
    BNE @clear2300
    LDA PPUSTATUS       ; clear first screen attr table
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR         ; $23C0
    LDA #0
    TAX
    TAY
    @attributeLoop:
    :
    LDA #$FF
    STA PPUDATA
    INX
    CPX #$40
    BNE :-
    LDX #0
    LDA PPUSTATUS       ; clear second screen attr table
    LDA #$27
    STA PPUADDR
    LDA #$C0
    STA PPUADDR         ; $27C0
    INY
    CPY #2
    BNE @attributeLoop
    EBD
    RTS
.endproc

.proc ClearAttributes
    SBD
    LDA PPUSTATUS
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR
    LDA #$ff
    LDX #$C0
    :
    STA PPUDATA
    INX
    CPX #0
    BNE :-
    EBD
    RTS
.endproc

.proc DrawMenuKeyboard
    SBD

    KBLine0:
        LDA #$22 ; Line 0  top border
        STA PPUADDR
        LDA #$64
        STA PPUADDR
        LDA #_RD ;corner
        STA PPUDATA
        LDA #_HR ;horiz line
        LDX #0
        @topBorderLine:
            STA PPUDATA
            INX
            CPX #(TEXT_KEYBOARD_LEN+1)*2
            BNE @topBorderLine
        LDA #_LD ;corner
        STA PPUDATA

    KBLine1:
        LDA #$22 ; Line 1 blank
        STA PPUADDR
        LDA #$84
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLine2:
        LDA #$22 ; Line 2 qwertyuiop
        STA PPUADDR
        LDA #$a4
        STA PPUADDR
        LDA #_VR ;vert line
        STA PPUDATA
        LDX #0
        @letters1:
            TXA
            AND #%00000001
            BEQ @skipLetter1
            TXA
            LSR
            TAY
            LDA keyboard, Y
            JMP @letter1
            @skipLetter1:
                LDA #0
            @letter1:
            STA PPUDATA
            INX
            CPX #TEXT_KEYBOARD_LEN*2
            BNE @letters1
        LDA #0
        STA PPUDATA
        STA PPUDATA
        LDA #_VR ;vert line
        STA PPUDATA

    KBLine3:
        LDA #$22 ; Line 3 blank
        STA PPUADDR
        LDA #$c4
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLine4:
        LDA #$22 ; Line 4 asdfghjkl
        STA PPUADDR
        LDA #$e4
        STA PPUADDR
        LDA #_VR ;vert line
        STA PPUDATA
        LDX #0
        @letters2:
            TXA
            AND #%00000001
            BEQ @skipLetter2
            TXA
            LSR
            CLC
            ADC #TEXT_KEYBOARD_LEN
            TAY
            LDA keyboard, Y
            JMP @letter2
            @skipLetter2:
                LDA #0
            @letter2:
            STA PPUDATA
            INX
            CPX #TEXT_KEYBOARD_LEN*2
            BNE @letters2
        LDA #0
        STA PPUDATA
        STA PPUDATA
        LDA #_VR ;vert line
        STA PPUDATA

    KBLine5:
        LDA #$23 ; Line 5 blank
        STA PPUADDR
        LDA #$04
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLine6:
        LDA #$23 ; Line 6 zxcvbnm Done
        STA PPUADDR
        LDA #$24
        STA PPUADDR
        LDA #_VR ;vert line
        STA PPUDATA
        LDX #0
        @letters3:
            TXA
            AND #%00000001
            BEQ @skipLetter3
            TXA
            LSR
            CLC
            ADC #TEXT_KEYBOARD_LEN*2
            TAY
            LDA keyboard, Y
            JMP @letter3
            @skipLetter3:
                LDA #0
            @letter3:
            STA PPUDATA
            INX
            CPX #TEXT_KEYBOARD_LEN*2
            BNE @letters3
        LDA #0
        STA PPUDATA
        STA PPUDATA
        LDA #_VR ;vert line
        STA PPUDATA

        LDA #$23 ; Line 6 "DONE"
        STA PPUADDR
        LDA #$36
        STA PPUADDR
        LDX #0 ;loop 4 times
        @letterDone:
            LDA keyboardDone, X
            STA PPUDATA
            INX
            CPX #4
            BNE @letterDone

    KBLine7:
        LDA #$23 ; Line 9 blank
        STA PPUADDR
        LDA #$44
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLine8:
        LDA #$23 ; Line 10  bottom border
        STA PPUADDR
        LDA #$64
        STA PPUADDR
        LDA #_RU ;corner
        STA PPUDATA
        LDA #_HR ;horiz line
        LDX #0
        @bottomBorderLine:
            STA PPUDATA
            INX
            CPX #(TEXT_KEYBOARD_LEN+1)*2
            BNE @bottomBorderLine
        LDA #_LU ;corner
        STA PPUDATA

    EBD
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

.proc UnpackImageMeta
    LDA currentBank
    PHA
    LDY #12 ; length of ImageMeta segment
    :
    DEY
    LDA (pointer), Y
    PHA
    CPY #0
    BNE :-
    PLA ; ROM bank number
    TAY
    JSR bankswitch_y
    PLA ; Attr bytes length
    BEQ :+
    STA counter
    LDA #0
    STA counter+1
    LDA PPUSTATUS
    PLA ; Target PPU addr for attributes
    STA PPUADDR
    PLA
    STA PPUADDR
    PLA ; Address of image attribute data
    STA pointer
    PLA
    STA pointer+1
    JSR UnpackData
    JMP :++
    :
    PLA ; skip attributes
    PLA
    PLA
    PLA
    :
    PLA ; Tiles in image (Rows * $20)
    STA counter+1
    PLA
    STA counter
    LDA PPUSTATUS
    PLA ; Target PPU addr for image
    BEQ :+
    STA PPUADDR
    PLA
    STA PPUADDR
    JMP :++
    :
    PLA
    LDA helper
    STA PPUADDR
    LDA helper+1
    STA PPUADDR
    :
    PLA ; Address of image data
    STA pointer
    PLA
    STA pointer+1
    JSR UnpackData

    PLA
    TAY
    JSR bankswitch_y
    RTS
.endproc

.proc LoadTextCHR
    LoadCHR #<textTilesMeta,  #>textTilesMeta
    RTS
.endproc

.proc DecompressTokumaruTilesMeta
    ; Must only occur during Bulk drawing
    ; Clobbers all registers, helper+0, pointer, counter
    ; @param helper+1: hi byte of tilemap page to write on, $00 or $10
    ; @param pointer: location of tile meta
    LDA currentBank
    PHA
    LDY #6 ; length of tile meta segment
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
    PLA
    STA helper+1
    STA helper
    PLA ; Destination 'y-value' (row index) of tiles in CHRRAM
    CLC
    ADC helper
    TAX
    LDA #$00
    JSR DecompressTokumaruData
    PLA
    TAY
    JSR bankswitch_y
    RTS
.endproc

.proc DecompressTokumaruData
    ; PPUADDR should be set immediately before this subroutine
    ; @param pointer: location of compressed data 
    ; @param counter: total unpacked bytes to write to PPUDATA
	bit PPUSTATUS
	stx PPUADDR
	sta PPUADDR
    lda pointer+0
    sta SourcePtr+0
    ldx pointer+1
    stx SourcePtr+1
	jmp DecompressTokumaru

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
    RTS
    :
    LDA (pointer), Y ; read header byte
    AND #$c0
    CMP #$80
    BEQ Run
    CMP #$40
    BEQ Increment
    JMP Literal
    Increment:
    LDA (pointer), Y
    AND #$3f
    TAX
    JSR IncrementPointerY
    LDA (pointer), Y
    :
    STA PPUDATA
    JSR DecrementCounter
    DEX
    CLC
    ADC #1
    CPX #0
    BNE :-
    JSR IncrementPointerY
    JMP NextSegment

    Run:
    LDA (pointer), Y
    AND #$3f ; write repeated run of bytes
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
    LDA (pointer), Y
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
.endproc

.proc DrawAdornments
    LDA currentBank
    PHA
    LDY #BANK_DATA
    JSR bankswitch_y

    LoadCHR #<adornmentTilesMeta, #>adornmentTilesMeta

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
    STA helper
    STX helper+1

    LDA #<adornmentImageMeta
    STA pointer
    LDA #>adornmentImageMeta
    STA pointer+1
    JSR UnpackImageMeta

    LDA #$23 ; screen location of bottom adornment is always the same 
    STA helper
    LDA #$00
    STA helper+1
    LDA #<adornmentImageMeta
    STA pointer
    LDA #>adornmentImageMeta
    STA pointer+1
    JSR UnpackImageMeta

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
    PLA
    TAY
    JSR bankswitch_y
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

.proc CopyCHRPatternB
    ; copy 13 rows of 16 tiles each to Pattern B
    ; @param pointer: location of compressed data
    LDA #$00 ; load 13x16x16 into counter (number of bytes to copy)
    STA counter
    LDA #$0D
    STA counter+1
    LDA #0
    STA PPUMASK
    LDX #$10
    LDA #$00
    JSR DecompressTokumaruData
    RTS
.endproc

; Helpers ----------------------------------------------------------------------

.proc BufferHelperNextLine
    CLC
    LDA bufferHelper+1
    ADC #$20
    STA bufferHelper+1
    LDA bufferHelper
    ADC #0
    STA bufferHelper
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

.proc RedrawFinger ; hack to redraw finger
    PHA
    LDA #0
    STA fingerLastY
    PLA
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
    WTB
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

.proc ClearPopupTextLines
    ; clobbers X
    LDX #0
    LDA #___
    :
    STA popupTextLine1, X
    STA popupTextLine2, X
    INX
    CPX #TEXT_POPUP_LINE_LEN
    BNE :-
    RTS
.endproc

.proc Rest1To8Days
    JSR RandomNumberGenerator
    AND #7
    TAX
    INX
    :
    INC wagonRest
    DEX
    BNE :-
    RTS
.endproc

; Game logic -------------------------------------------------------------------

.proc CheckGameState
    LDA lastGameState
    CMP gameState
    BNE :+
        JSR UpdateGame
        JSR Every60Frames
        JSR DrawFinger
        RTS
    :
    LDA gameState
    STA lastGameState
    CMP #GAMESTATE_TITLE
    BNE :+
        JSR InitStateTitle
        RTS
    :
    CMP #GAMESTATE_TRAVELING
    BNE :+ 
        JSR InitStateTraveling
        RTS
    :
    CMP #GAMESTATE_NEWGAME
    BNE :+ 
        JSR InitStateNewGame
        RTS
    :
    CMP #GAMESTATE_MATT
    BNE :+ 
        JSR InitStateMatt
        RTS
    :
    CMP #GAMESTATE_LANDMARK
    BNE :+ 
        JSR InitStateLandmark
        RTS
    :
    CMP #GAMESTATE_MAP
    BNE :+
        JSR InitStateMap
        RTS
    :
    RTS
.endproc

.proc UpdateGame
    LDA menuOpen
    CMP menuOpenLast
    BEQ :+
        JSR NewMenuOpened
        LDA menuOpen
        STA menuOpenLast    ; reset last menu open
        LDA #0
        STA frameCounter    ; reset framecounter
        RTS
    :
    LDA gameState
    CMP #GAMESTATE_TITLE
    BNE :+
        ; scramble the PRNG seed while we are on the title screen.
        JSR RandomNumberGenerator
        STA helper
        JSR RandomNumberGenerator
        STA helper+1
        LDA helper
        STA seed
        LDA helper+1
        STA seed+1
        RTS
    :
    CMP #GAMESTATE_TRAVELING
    BNE :++
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        LDA wagonRest
        BNE :+
        JSR ProcessEventQueue
        :
        RTS
    :
    RTS
.endproc

.proc ReadController1
    LDA #$01    ; read inputs
    STA $4016
    LDA #$00
    STA $4016
    LDX #$08
    :
    LDA $4016
    LSR A
    ROL buttons1
    DEX
    BNE :-
    LDA gameState
    CMP lastGameState
    BEQ :+
    RTS
    :
    CMP #GAMESTATE_TRAVELING
    BNE :+
    JSR GamepadTraveling
    RTS
    :
    CMP #GAMESTATE_TITLE
    BNE :+
    JSR GamepadTitle
    RTS
    :
    CMP #GAMESTATE_NEWGAME
    BNE :+
    JSR GamepadNewGame
    RTS
    :
    CMP #GAMESTATE_MATT
    BNE :+
    JSR GamepadMatt
    RTS
    :
    CMP #GAMESTATE_LANDMARK
    BNE :+
    JSR GamepadLandmark
    RTS
    :
    CMP #GAMESTATE_MAP
    BNE :+
    JSR GamepadMap
    RTS
    :
    RTS
.endproc

.proc NewMenuOpened
    PHA
    LDA #0
    STA fingerAttr
    PLA
    ; A-register should contain menuOpen.
    CMP #MENU_NONE      ; which menu was just opened?
    BNE :+
        JMP None
    :
    CMP #MENU_TITLE_LEARN
    BNE :+
        LDA #0
        STA menuCursor ; use menuCursor to denote page number (0-6)
        JSR BufferDrawTitleLearn
        RTS
    :
    CMP #MENU_TITLE_TOPTEN
    BNE :+
        LDA #%00010101 ; "<>" finger visible
        STA fingerAttr
        LDA #26
        STA fingerX
        LDA #22
        STA fingerY
        LDA #0 ; Y/N (default N)
        STA menuCursor
        STA fingerLastY
        JSR ClearScreen
        JSR BufferDrawTopTen
        LDX fingerX
        LDY fingerY
        LDA #_N_
        WTB
        RTS
    :
    CMP #MENU_TITLE_SOUND
    BNE :+
        JSR BufferDrawTitleSound
        RTS
    :
    CMP #MENU_NEWGAME_OCCUPATION
    BNE :+
        LDA #%00000100      ; only main finger visible, pointing right
        STA fingerAttr
        LDA #4
        STA fingerX
        LDA #10
        STA fingerY
        JSR LoadBgNewGame
        ; JSR RedrawFinger
        ; JSR DrawOccupationMenu
        ; LDX #15
        ; LDY #7
        ; JSR MoveFingerToSubmenu
        RTS
    :
    CMP #MENU_NEWGAME_OCC_HELP
    BNE :+
        JSR LoadBgNewGame
        RTS
    :
    CMP #MENU_NEWGAME_NAMEPARTY
    BNE :+
        LDA #%00100000      ; keyboard key
        STA fingerAttr
        LDA #6
        STA fingerX
        LDA #21
        STA fingerY
        JSR LoadBgNewGame
        LDA #30
        STA frameCounter
        JSR HighlightKeyboardKey
        RTS
    :
    CMP #MENU_NEWGAME_STARTDATE
    BNE :+
        LDA #%00000100      ; only main finger visible, pointing right
        STA fingerAttr
        LDA #0
        STA fingerLastLastX
        STA fingerLastLastY
        STA fingerLastX
        STA fingerLastY
        LDA #4
        STA fingerX
        LDA #14
        STA fingerY
        JSR LoadBgNewGame
        RTS
    :
    CMP #MENU_STORE_ITEM1
    BNE :+
        LDA #7
        PHA
        JMP StoreSubmenu
    :
    CMP #MENU_STORE_ITEM2
    BNE :+
        LDA #7
        PHA
        JMP StoreSubmenu
    :
    CMP #MENU_STORE_ITEM4
    BNE :+
        LDA #6
        PHA
        JMP StoreSubmenu
    :
    CMP #MENU_MAINMENU
    BNE :+
        LDA #%00000100      ; only finger visible, pointing right
        STA fingerAttr
        JSR UpdatePalette ; <- TODO refactor 
        JSR LoadBgTraveling
        JSR RedrawFinger
        RTS
    :
    CMP #MENU_SUPPLIES
    BNE :+
        JSR LoadBgSupplies
        RTS
    :
    CMP #MENU_PACE
    BNE :+
        LDA #%00010100      ; only finger visible, up/down arrow
        STA fingerAttr
        LDX #12
        LDY #17
        JSR MoveFingerToSubmenu
        JSR DrawPaceSubmenu
        JSR RedrawFinger
        RTS
    :
    CMP #MENU_RATIONS
    BNE :+
        LDA #%00010100      ; only finger visible, up/down arrow
        STA fingerAttr
        LDX #15
        LDY #19
        JSR MoveFingerToSubmenu
        JSR DrawRationsSubmenu
        JSR RedrawFinger
        RTS
    :
    CMP #MENU_REST
    BNE :+
        LDA #1
        STA wagonRest
        LDA #%00010100      ; only finger visible, up/down arrow
        STA fingerAttr
        LDX #15
        LDY #21
        JSR MoveFingerToSubmenu
        JSR DrawRestSubmenu
        JSR RedrawFinger
        RTS
    :
    CMP #MENU_TALK
    BNE :+
        JSR LoadBgTalk
        RTS
    :
    CMP #MENU_TEXTPOPUP
    BNE :+
        JSR BufferDrawTextPopup
        RTS
    :
    CMP #MENU_TEXTPOPUP_YN
    BNE :+
        JSR BufferDrawTextPopup
        RTS
    :
    CMP #MENU_MAP
    BNE :+
        JSR MoveFingerToSubmenu
        JSR RedrawFinger
        JSR LoadBgMap
        RTS
    :
    CMP #MENU_NEWGAME_DATE_HELP
    BNE :+
        JSR LoadBgNewGame
        RTS
    :
    CMP #MENU_NEWGAME_GOINGBACK
    BNE :+
        LDA #0
        STA frameCounter
        STA menuCursor
        JSR LoadBgIndependence
        RTS
    :
    CMP #MENU_NEWGAME_BEFORELEAVING1
    BNE :+
        JSR LoadBgIndependence
        RTS
    :
    CMP #MENU_NEWGAME_BEFORELEAVING2
    BNE :+
        JSR LoadBgIndependence
        RTS
    :
    CMP #MENU_MATT_INTRO1
    BCS :+
    JMP :+++
    :
    CMP #MENU_MATT_GOODLUCK+1
    BCC :+
    JMP :++
    :
        JSR LoadBgMatt
        RTS
    :
    CMP #MENU_MATT_LOADING
    BNE :+
        JSR LoadBgIndependence
        RTS
    :
    RTS
    None:
        LDA #0
        STA fingerLastLastX
        STA fingerLastLastY ; clear LastLast pos since we are NOT in a submenu.
        LDA gameState
        CMP #GAMESTATE_TITLE
        BNE :+
            JSR InitStateTitle
            RTS
        :
        CMP #GAMESTATE_MATT
        BNE :+
            LDA #%00000100 ; finger pointing right
            STA fingerAttr
            JSR LoadBgMatt
            JSR RedrawFinger
            RTS
        :
        CMP #GAMESTATE_TRAVELING
        BNE :+
            LDA #%00000000      ; neither finger visible
            STA fingerAttr
            LDA menuOpenLast
            CMP #MENU_TEXTPOPUP
            BEQ :+
            CMP #MENU_TEXTPOPUP_YN
            BEQ :+
            JSR LoadBgTraveling
            RTS
        :
        RTS
    StoreSubmenu:
        LDA #%00011100      ; both fingers visible, main finger "up/down" arrows
        STA fingerAttr
        JSR DrawStoreSubmenu
        PLA
        TAX
        LDY fingerY
        JSR MoveFingerToSubmenu
        RTS
.endproc

.proc Every60Frames
    LDA gameState
    CMP #GAMESTATE_TRAVELING
    BEQ Traveling
    CMP #GAMESTATE_NEWGAME
    BNE :+
    JMP NewGame
    :
    CMP #GAMESTATE_MATT
    BNE :+
    JMP Matt
    :
    RTS
    Traveling:
        LDA frameCounter
        CMP #30
        BNE :+
        JMP @sec1
        :
        CMP #90
        BNE :+
        JMP @sec2
        :
        AND #$07
        CMP #0
        BNE :+
        JMP @animate
        :
        RTS
        @animate:
            LDA wagonRest
            BEQ :+
            JMP :+++
            :
            LDA oxenFrame
            BPL :+
            RTS
            :
            JSR BufferDrawWagon
            INC oxenFrame
            LDA oxenFrame
            CMP #3
            BNE :+
            LDA #0
            STA oxenFrame
            :
            INC frameCounter
            RTS
        @sec1:
            ; 1st second: move wagon
            LDA oxenFrame
            AND #%01111111
            STA oxenFrame
            INC frameCounter
            RTS
        @sec2:
            ; 2nd second: pause, update counters, roll for event
            LDA eventQueue
            CMP #EVENT_CLEAR_TEXT
            BNE :+
                JSR ProcessEventQueue
            :
            LDA #%10000000
            STA oxenFrame
            JSR ElapseDay
            JSR BufferDrawMainMenuHUDValues
            JSR RestOneDay
            JSR BufferDrawTravelingHUDValues
            LDA #0
            STA frameCounter
            RTS
    NewGame:
        LDA menuOpen
        CMP #MENU_NEWGAME_NAMEPARTY
        BNE :+
        JMP NameParty
        :
        CMP #MENU_NEWGAME_GOINGBACK
        BNE :+
        JMP GoingBack
        :
        RTS
        NameParty:
        LDA frameCounter ; blink cursor
        CMP #30
        BNE :+
        JMP @sec1
        :
        CMP #60
        BNE :+
        JMP @sec2
        :
        RTS
        @sec1: 
            ; SBW #2, #$3f, #$06
            ; LDA #C_GREY
            ; WBB
            ; LDA #C_WHITE
            ; WBB
            ; EBW
            ; INC frameCounter
            RTS
        @sec2:
            ; SBW #2, #$3f, #$06
            ; LDA #C_WHITE
            ; WBB
            ; LDA #C_GREY
            ; WBB
            ; EBW
            ; LDA #0
            ; STA frameCounter
            RTS
        GoingBack:
        LDA frameCounter
        CMP #60
        BNE :+
        JMP @sec1
        :
        RTS
        @sec1: 
            INC menuCursor
            LDA #0
            STA frameCounter
            LDA menuCursor
            CMP #3
            BNE :+
            LDA #MENU_NEWGAME_STARTDATE
            STA menuOpen
            :
            RTS
    Matt:
        LDA menuOpen
        CMP #MENU_MATT_LOADING
        BEQ :+
        RTS
        :
        LDA frameCounter
        CMP #60
        BEQ :+
        RTS
        : 
        INC menuCursor
        LDA #0
        STA frameCounter
        LDA menuCursor
        CMP #3
        BNE :+
        LDA #GAMESTATE_LANDMARK
        STA gameState
        :
        RTS
.endproc

.proc ElapseDay
    LDA menuOpen
    CMP #MENU_NONE
    BEQ Elapse
    CMP #MENU_MAINMENU
    BNE Done
    LDA wagonRest
    BEQ Done
    Elapse:
    JSR RandomEvent
    JSR UpdateWeather
    JSR UpdateSupplies
    JSR UpdateHealth
    JSR UpdateDistance
    JSR IncrementDate
    Done:
    RTS
.endproc

.proc RestOneDay
    LDA menuOpen
    CMP #MENU_NONE
    BEQ Rest
    CMP #MENU_MAINMENU
    BNE Done
    Rest:
    LDA wagonRest
    BEQ Done
    DEC wagonRest
    Done:
    RTS
.endproc

.proc UpdateSupplies
    ; eat food
    JSR CountAlivePeople
    STA helper
    LDA wagonSettings
    AND #%00001100
    LSR
    LSR
    TAX
    :
    SEC
    LDA foodLbs
    SBC helper
    STA foodLbs
    LDA foodLbs+1
    SBC #0
    STA foodLbs+1
    BCC :+
    DEX
    BNE :-
    JMP Done
    :
    LDA #0
    STA foodLbs
    STA foodLbs+1
    Done:
    LDX #foodLbsDigit
    LDY #foodLbs
    JSR SetDigitFromValue
    RTS
.endproc

.proc UpdateHealth
    ; 0-34: good health
    ; 35-69: fair health
    ; 70-104: poor health
    ; 105-139: very poor health
    ; 140+: remaining party members all die within a few days

    ; decrement remaining days of illness
    LDX #0
    :
    LDA personHealth, X
    AND #%11111000
    CMP #%11111000
    BEQ :+
    SEC
    LDA personHealth, X
    SBC #%00001000
    BCC :+
    STA personHealth, X
    AND #%11111000
    BNE :+
    LDA #0
    STA personHealth, X
    :
    INX
    CPX #5
    BNE :--

    LDA #0
    STA helper2+1 ; 0:fine, 1:freezing or starving 
    
    ; Natural recovery process (decrement by 10%)
    LDA wagonHealth
    STA helper
    LDA #0
    STA helper+1
    :
    SEC
    LDA helper
    SBC #10
    BCC :+
    STA helper
    INC helper+1
    JMP :-
    :
    SEC
    LDA wagonHealth
    SBC helper+1
    STA wagonHealth

    ; Weather
    LDA weather
    @veryCold:
        ; add 0 if 4 or more sets of clothing per person
        ; add 4 if 0 sets of clothing per person
        ; apply a sliding scale if between 0 and 4 sets of clothing per person
        CMP #WEATHER_COLD
        BCS @cold
        JSR CountAlivePeople
        STA helper2
        LDA clothing ; divide clothing by alive person count
        STA helper
        LDA #4
        STA helper+1 ; health loss: starts at 4 
        :
        SEC
        LDA helper ; clothing
        SBC helper2 ; alive person count
        BCC :+
        STA helper
        DEC helper+1 ; -1 health loss for each set of clothing
        BEQ :+
        JMP :-
        :
        CLC
        LDA wagonHealth 
        ADC helper+1 ; add health loss to wagonHealth
        STA wagonHealth
        LDA helper+1
        CMP #0
        BEQ :+
        CLC
        LDA wagonFreezeStarve ; freeze factor: add 0.8 (4 * 0.2)
        ADC #4
        STA wagonFreezeStarve
        LDA #1
        STA helper2+1
        :
        JMP Rations
    @cold:
        ; add 0 if 2 or more sets of clothing per person
        ; add 2 if 0 sets of clothing per person
        ; apply a sliding scale if between 0 and 2 sets of clothing per person
        CMP #WEATHER_COOL
        BCS @cool
        JSR CountAlivePeople
        STA helper2
        LDA clothing ; divide clothing by alive person count
        STA helper
        LDA #2
        STA helper+1 ; health loss: starts at 2 
        :
        SEC
        LDA helper ; clothing
        SBC helper2 ; alive person count
        BCC :+
        STA helper
        DEC helper+1 ; -1 health loss for each set of clothing
        BEQ :+
        JMP :-
        :
        CLC
        LDA wagonHealth 
        ADC helper+1 ; add health loss to wagonHealth
        STA wagonHealth
        LDA helper+1
        CMP #0
        BEQ :+
        CLC
        LDA wagonFreezeStarve ; freeze factor: add 0.8 (4 * 0.2)
        ADC #4
        STA wagonFreezeStarve
        LDA #1
        STA helper2+1
        :
        JMP Rations
    @cool:
        ; add 0; the best weather for traveling
        CMP #WEATHER_WARM
        BCS @warm
        JMP Rations
    @warm:
        ; add 0; the best weather for traveling
        CMP #WEATHER_HOT
        BCS @hot
        JMP Rations
    @hot:
        ; add 1
        CMP #WEATHER_VERY_HOT
        BCS @veryHot
        INC wagonHealth
        JMP Rations
    @veryHot:
        ; add 2
        CMP #WEATHER_RAINY
        BCS @rainy
        INC wagonHealth
        INC wagonHealth
        JMP Rations
    @rainy:
    
    Rations:
    ; Food rations
    LDA foodLbs+1
    CMP #0
    BNE :+
    LDA foodLbs
    CMP #0
    BNE :+
    CLC ; starving: 6
    LDA wagonHealth
    ADC #6
    STA wagonHealth
    CLC
    LDA wagonFreezeStarve ; starve factor: add 0.8 (4 * 0.2)
    ADC #4
    STA wagonFreezeStarve
    LDA #1
    STA helper2+1
    JMP FreezeStarve
    :
    LDA wagonSettings
    AND #%00001100
    LSR
    LSR
    CMP #2
    BCS :+
    CLC ; bare bones rations: 4
    LDA wagonHealth
    ADC #4
    STA wagonHealth
    JMP FreezeStarve
    :
    CMP #3
    BCS :+
    CLC ; meager rations: 2
    LDA wagonHealth
    ADC #2
    STA wagonHealth
    JMP FreezeStarve
    : ; filling rations: 0
    
    ; Freeze/starve factor
    FreezeStarve:
    LDA helper2+1
    BNE :+
    LDA wagonFreezeStarve
    LSR
    STA wagonFreezeStarve ; divide by 2 if neither freezing nor starving
    JMP Pace
    :
    LDA wagonFreezeStarve
    STA helper ; wagonFreezeStarve divided by 5
    LDA #0
    STA helper+1
    LDX #0
    :
    SEC
    LDA helper
    SBC #5
    STA helper
    LDA helper+1
    SBC #0
    STA helper+1
    BCC :+
    INX
    JMP :-
    :
    CLC
    LDA wagonHealth
    STX helper
    ADC helper
    STA wagonHealth

    Pace:
    LDA wagonSettings
    AND #%00010000
    BEQ :+
    JMP Illness ; resting
    :
    AND #%00000011
    CLC
    ROL
    ADC wagonHealth
    STA wagonHealth

    Illness:
    ; For each sick or injured person, add 1
    LDX #0
    STA helper
    :
    LDA personHealth, X
    BEQ :+
    INC wagonHealth
    :
    INX
    CPX #5
    BNE :--

    Done:
    RTS
.endproc

.proc UpdateDistance
    ; standard speed: 20 miles per day
    ; maximum speed is 40mpd, at full health, 4+ oxen, in prairie terrain
    LDA wagonRest ; no distance if resting
    BEQ :+
    RTS
    :
    LDA #80 ; x0.25 mpd = 20 mpd standard
    STA helper
    LDA #0
    STA helper+1
    ; Pace
    LDA wagonSettings
    AND #%00000011
    TAX
    DEX
    :
    CPX #0
    BEQ :+
    CLC
    LDA helper
    ADC #40 ; strenuous: +10mpd, grueling: +20 mpd
    STA helper
    DEX
    JMP :-
    :
    ; Mountainous terrain: x0.5
    JSR CheckMountainousTerrain
    CMP #1
    BNE :+
    LDA helper
    LSR
    STA helper
    :
    ; Oxen: x(number of healthy oxen)/4
    ; sick or injured ox counts as 1/2 of a healthy ox
    LDA oxenHeadcount
    CLC
    ROL ; x2 so we can count half-ox 
    SEC
    SBC oxenHealth
    CMP #8
    BCS Travel ; skip if 4+ healthy oxen
    ; helper *= A / #8
    TAX ; x: oxencount*2
    LDA helper
    STA cartHelperDigit ; hack, stash mpd
    CPX #0
    BNE :+
    LDA #0 ; no oxen!
    STA helper
    JMP Travel
    : ; multiply mpd by oxencount*2
    CLC
    LDA helper
    ADC cartHelperDigit
    STA helper
    LDA helper+1
    ADC #0
    STA helper+1
    DEX
    BNE :-
    ; divide by 8
    LSR helper+1
    ROR helper
    LSR helper+1
    ROR helper
    LSR helper+1
    ROR helper
    ; TODO:  Each sick party member: 10% decrease in speed
    ; TODO: Snow on the ground: up to 100% loss of speed at 30" of snow
    Travel:
    LSR helper ; convert from 0.25x mpd to 1x mpd (divide by 4)
    LSR helper 
    SEC ; subtract from distance to next landmark
    LDA nextMi
    STA helper+1 ; stash remaining miles in case it is less than our mpd
    SBC helper
    STA nextMi
    LDA nextMi+1
    SBC #0
    STA nextMi+1
    BCS :+
    LDA #0 ; mpd > remaining miles ; TODO: >=, not >
    STA nextMi ; we're at the landmark: clear nextMi
    STA nextMi+1
    LDA #EVENT_REACHED_LANDMARK
    JSR QueueEvent
    LDA #EVENT_LOOK_AROUND
    JSR QueueEvent
    LDA helper+1 ; unstash remaining miles
    STA helper ; replace mpd with remaining miles (ie stop at the landmark) 
    :
    CLC ; add mpd to total distance traveled
    LDA traveledMi
    ADC helper
    STA traveledMi
    LDA traveledMi+1
    ADC #0
    STA traveledMi+1

    LDX #traveledDigit
    LDY #traveledMi
    JSR SetDigitFromValue
    LDX #nextDigit
    LDY #nextMi
    JSR SetDigitFromValue
    RTS
.endproc

.proc UpdateWeather
    ; clobbers A, helper, helper+1, helper2, pointer
    JSR RandomNumberGenerator ; 50% chance to generate new weather
    CMP #$80
    BCS :+
    JMP MeltSnow
    :
    LDA location    ; get current location index
    CMP #3
    BCS :+
    LDA #0  ; Zone 1: Independence to Fort Kearney
    JMP Generate
    :
    CMP #5
    BCS :+
    LDA #12 ; Zone 2: Fort Kearney to Fort Laramie
    JMP Generate
    :
    CMP #6
    BCS :+
    LDA #24 ; Zone 3: Fort Laramie to Independence Rock
    JMP Generate
    :
    CMP #11
    BCS :+
    LDA #36 ; Zone 4: Independence Rock to Fort Hall
    JMP Generate
    :
    CMP #16
    BCS :+
    LDA #48 ; Zone 5: Fort Hall to The Dalles
    JMP Generate
    :
    LDA #60 ; Zone 6: The Dalles to Willamette Valley
    Generate:
    CLC
    ADC dateMonth
    STA helper2 ; table index
    DEC helper2
    TAX
    DEX
    LDA temperatureTable, X
    STA helper ; this month's mean temp
    :
    JSR RandomNumberGenerator ; add (-20,20) degrees Fahrenheit
    CMP #160+1
    BCS :- ; 0 to 160
    LSR ; 0 to 80
    LSR ; 0 to 40
    CMP #20
    BCS :+
    STA helper+1 ; -0 to -20
    SEC
    LDA helper
    SBC helper+1 ; this month's mean temp minus [0 to 20]
    JMP Temperature
    : ; 20 to 40
    SEC ; +0 to +20
    SBC #20
    STA helper+1
    CLC
    LDA helper
    ADC helper+1 ; this month's mean temp plus [0 to 20]
    Temperature:
    CMP #10
    BCS :+
    LDA #0 ; very cold
    JMP Rainfall
    :
    CMP #30
    BCS :+
    LDA #1 ; cold
    JMP Rainfall
    :
    CMP #50
    BCS :+
    LDA #2 ; cool
    JMP Rainfall
    :
    CMP #70
    BCS :+
    LDA #3 ; warm
    JMP Rainfall
    :
    CMP #90
    BCS :+
    LDA #4 ; hot
    JMP Rainfall
    :
    LDA #5 ; very hot
    Rainfall:
    STA weather
    JSR RandomNumberGenerator
    LDX helper2
    CMP rainfallTable, X ; Precipitation chance
    BCC :+
    JMP MeltSnow ; Not precipitating
    :
    LDA weather ; Precipitating
    CMP #2 ; if weather is cold/very cold, snow instead of rain
    BCS :+
    LDA #WEATHER_SNOWY
    STA weather
    JMP HeavyRainfall
    :
    LDA #WEATHER_RAINY
    STA weather
    HeavyRainfall:
    :
    JSR RandomNumberGenerator
    CMP #250 ; 0 to 250
    BCS :-
    CMP #75 ; 30% chance for "heavy" precipitation
    BCS :+
    INC weather
    LDA #8
    STA helper2
    JMP MeltSnow
    : ; 70% chance for "light" precipitation
    LDA #2
    STA helper2
    MeltSnow: ; Melt snow and/or disappear/evaporate rain
    LDA #0 ; subtract 10% of accumulated rainfall
    STA helper
    LDA accumulatedRain
    STA helper+1
    SEC
    :
    LDA helper+1
    SBC #10
    STA helper+1
    INC helper
    BCS :-
    SEC
    LDA accumulatedRain
    SBC helper
    BCS :+
    LDA #0
    :
    STA accumulatedRain
    LDA weather ; subtract from accumulated snowfall
    CMP #WEATHER_WARM
    BCS :++
    LDA #0 ; is very cold, cold, or cool; subtract 3% snowfall
    STA helper
    LDA accumulatedSnow
    STA helper+1
    SEC
    :
    LDA helper+1
    SBC #33
    STA helper+1
    INC helper
    BCS :-
    SEC
    LDA accumulatedSnow
    SBC helper
    STA accumulatedSnow
    BCS AccumulateRainfall
    LDA #0
    STA accumulatedSnow
    JMP AccumulateRainfall
    : ; it is warm+ or precipitating
    CMP #WEATHER_SNOWY
    BCS AccumulateRainfall ; it is snowing; do not subtract from snowfall
    SEC ; it is not cold nor snowing; melt 5" of snow to 0.5" of water
    LDA accumulatedSnow
    SBC #5*8
    STA accumulatedSnow
    BCS :+
    LDA #0
    STA accumulatedSnow
    JMP AccumulateRainfall
    :
    LDA accumulatedRain
    ADC #5
    STA accumulatedRain
    AccumulateRainfall:
    LDA weather
    CMP #WEATHER_RAINY
    BCS :+
    RTS
    :
    CMP #WEATHER_SNOWY
    BCS :+++
    CMP #WEATHER_VERY_RAINY
    BCS :+
    LDA #2 ; 0.1" increments (+0.2" light rain)
    STA helper2
    JMP :++
    :
    LDA #8 ; 0.1" increments (+0.8" heavy rain)
    STA helper2
    :
    CLC ; it is raining; accumulate rain instead of snow
    LDA accumulatedRain
    ADC helper2 ; 0.1" increments (+0.8" heavy rain or +0.2" light rain)
    STA accumulatedRain
    RTS
    :
    CMP #WEATHER_VERY_SNOWY
    BCS :+
    LDA #2*8 ; 0.125" increments (+2.0" light snow)
    STA helper2
    JMP :++
    :
    LDA #8*8 ; 0.125" increments (+8.0" heavy snow)
    STA helper2
    :
    CLC ; it is snowing; accumulate snow instead of rain
    LDA accumulatedSnow
    ADC helper2
    STA accumulatedSnow
    RTS
.endproc

.proc ProcessEventQueue
    LDA eventQueue ; proceed only if an event is queued
    CMP #EVENT_NONE
    BNE :+
        RTS
    :
    TAY ; stash event ID in Y register
    LDA eventQueue+1    ; shift all queued events and decrement pointer 
    STA eventQueue
    LDA eventQueue+2
    STA eventQueue+1
    LDA eventQueue+3
    STA eventQueue+2
    LDA #EVENT_NONE
    STA eventQueue+3
    DEC eventQueuePointer
    JSR ClearPopupTextLines
    TYA                ; unstash event ID
    CMP #EVENT_NEXT_LANDMARK  ; switch/case event id
    BNE :+++++
        LDX #0
        :
        LDA nextLandmarkText, X ; "it is "
        STA popupTextLine1, X
        INX
        CPX #6
        BNE :-
        LDY #1
        :
        LDA nextDigit, Y
        STA popupTextLine1, X
        INX
        INY
        CPX #9
        BNE :-
        :
        LDA nextLandmarkText, X ; " miles to "
        STA popupTextLine1, X
        INX
        CPX #18
        BNE :-
        LDX location ; "{location title}."
        INX
        JSR GetLandmarkText
        LDY #0
        :
        LDA textLineHelper, Y
        STA popupTextLine2, Y
        INY
        CPY helper2
        BNE :-
        LDA #_PD
        STA popupTextLine2, Y
        JMP TextPopup
    :
    CMP #EVENT_REACHED_LANDMARK
    BNE :+++
        LDX #0
        :
        LDA reachedLandmarkText, X ; "you have reached"
        STA popupTextLine1, X
        INX
        CPX #17
        BNE :-
        LDX location ; "{location title}."
        INX
        JSR GetLandmarkText
        LDY #0
        :
        LDA textLineHelper, Y
        STA popupTextLine2, Y
        INY
        CPY helper2
        BNE :-
        LDA #_PD
        STA popupTextLine2, Y
        JMP TextPopup
    :
    CMP #EVENT_LOAD_LANDMARK
    BNE :+
        INC location
        LDA #GAMESTATE_LANDMARK
        STA gameState
        RTS
    :
    CMP #EVENT_LOOK_AROUND
    BNE :+++
        LDX #0
        :
        LDA eventLookAroundText, X ; "Would you like to"
        STA popupTextLine1, X
        INX
        CPX #17
        BNE :-
        LDY #0
        :
        LDA eventLookAroundText, X  ; "look around? <YES>"
        STA popupTextLine2, Y
        INX
        INY
        CPY #12
        BNE :-
        LDA #___
        STA popupTextLine2, Y
        LDA #MENU_TEXTPOPUP_YN
        STA menuOpen
        RTS
    :
    CMP #EVENT_INDIAN_FOOD
    BNE :++
        LDX #1
        LDY #0
        :
        LDA eventIndianFoodText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventIndianFoodText
        BNE :-
        JMP TextPopup
    :
    CMP #EVENT_THUNDERSTORM
    BNE :+++
        SBD
        LoadCHR #<reThunderstormTilesMeta, #>reThunderstormTilesMeta
        EBD
        BufferDrawImage #<reThunderstormImage, #>reThunderstormImage
        LDX #1
        LDY #0
        :
        LDA eventThunderstormText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventThunderstormText
        BNE :-
        LDX #1
        LDY #0
        :
        LDA eventLoseDaysText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY eventLoseDaysText
        BNE :-
        LDA #_PD
        STA popupTextLine2, Y
        INC wagonRest ; lose 1 day
        JMP TextPopup
    :
    CMP #EVENT_CLEAR_THUNDERSTORM
    BNE :+
        BDrawBlankBox reThunderstormImage+2, reThunderstormImage+3, reThunderstormImage+0, reThunderstormImage+1
        RTS
    :
    CMP #EVENT_BLIZZARD
    BNE :+++
        SBD
        LoadCHR #<reBlizzardTilesMeta, #>reBlizzardTilesMeta
        EBD
        BufferDrawImage #<reBlizzardImage, #>reBlizzardImage
        LDX #1
        LDY #0
        :
        LDA eventBlizzardText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventBlizzardText
        BNE :-
        LDX #1
        LDY #0
        :
        LDA eventLoseDaysText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY eventLoseDaysText
        BNE :-
        LDA #_PD
        STA popupTextLine2, Y
        INC wagonRest ; lose 1 day
        JMP TextPopup
    :
    CMP #EVENT_CLEAR_BLIZZARD
    BNE :+
        BDrawBlankBox reBlizzardImage+2, reBlizzardImage+3, reBlizzardImage+0, reBlizzardImage+1
        RTS
    :
    CMP #EVENT_HEAVY_FOG
    BNE :++++++
        LDX #1
        LDY #0
        :
        LDA eventHeavyFogText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventHeavyFogText
        BNE :-
        JSR RandomNumberGenerator
        AND #1
        BNE :+
        INC wagonRest ; 50% chance to lose 1 day
        :
        LDA wagonRest
        BEQ :++
        LDA #_PD
        STA popupTextLine1, Y
        LDA wagonRest
        BNE :+
        JMP :+++
        :
        LDY #0
        LDX #1
        :
        LDA eventLoseDaysText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY eventLoseDaysText
        BNE :-
        LDA #_PD
        STA popupTextLine2, Y
        :
        JMP TextPopup
    :
    CMP #EVENT_HAIL_STORM
    BNE :+++++
        LDX #1
        LDY #0
        :
        LDA eventHailStormText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventHailStormText
        BNE :-
        JSR RandomNumberGenerator
        AND #1
        BNE :+
        INC wagonRest ; 50% chance to lose 1 day
        :
        LDA wagonRest
        BEQ :++
        LDY #0
        LDX #1
        :
        LDA eventLoseDaysText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY eventLoseDaysText
        BNE :-
        LDA #_PD
        STA popupTextLine2, Y
        :
        JMP TextPopup
    :
    CMP #EVENT_INJURED_OX
    BNE :+++++++
        LDX #1
        LDY #0
        :
        LDA eventInjuredOxText, X ; "ONE OF THE OXEN"
        STA popupTextLine1, Y
        INX
        INY
        CPY eventInjuredOxText
        BNE :-
        LDA oxenHealth
        BEQ :++
        LDX #16 ;"IS INJURED"
        INX
        LDY #0
        :
        LDA eventInjuredOxText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY #11
        BNE :-
        JMP :++++
        :
        LDX #1
        LDY #0
        :
        LDA eventIllnessText, X ; "HAS DIED"
        STA popupTextLine2, Y
        INX
        INY
        CPY #4
        BNE :-
        LDX #58 ; index of "DIED"
        :
        LDA eventIllnessText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY #8
        BNE :-
        LDA #_PD
        STA popupTextLine2, Y
        :
        JMP TextPopup
    :
    CMP #EVENT_INJURED_PERSON
    BNE :+
        JMP InjuredPerson
    :
    CMP #EVENT_SNAKE_BITE
    BNE :+
        JMP SnakeBite
    :
    CMP #EVENT_LOSE_TRAIL
    BNE :++++
        JSR Rest1To8Days ; rest 1-8 days
        LDX #1
        LDY #0
        :
        LDA eventLoseTrailText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventLoseTrailText
        BNE :-
        LDY #0
        LDX #1
        :
        LDA eventLoseDaysText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY eventLoseDaysText
        BNE :-
        TYA
        PHA
        DEY ; replace 1 day with X day(s)
        DEY
        DEY
        DEY
        DEY
        CLC
        LDA wagonRest
        ADC #_0_
        STA popupTextLine2, Y
        PLA
        TAY
        LDA wagonRest
        CMP #1
        BEQ :+
        LDA #_S_
        STA popupTextLine2, Y
        INY
        :
        LDA #_PD
        STA popupTextLine2, Y
        JMP TextPopup
    :
    CMP #EVENT_WRONG_TRAIL
    BNE :++++
        JSR Rest1To8Days ; rest 1-8 days
        LDX #1
        LDY #0
        :
        LDA eventWrongTrailText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventWrongTrailText
        BNE :-
        LDY #0
        LDX #1
        :
        LDA eventLoseDaysText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY eventLoseDaysText
        BNE :-
        TYA
        PHA
        DEY ; replace 1 day with X day(s)
        DEY
        DEY
        DEY
        DEY
        CLC
        LDA wagonRest
        ADC #_0_
        STA popupTextLine2, Y
        PLA
        TAY
        LDA wagonRest
        CMP #1
        BEQ :+
        LDA #_S_
        STA popupTextLine2, Y
        INY
        :
        LDA #_PD
        STA popupTextLine2, Y
        JMP TextPopup
    :
    CMP #EVENT_ROUGH_TRAIL
    BNE :++
        LDX #1
        LDY #0
        :
        LDA eventRoughTrailText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventRoughTrailText
        BNE :-
        JMP TextPopup
    :
    CMP #EVENT_IMPASSIBLE_TRAIL
    BNE :++++
        JSR Rest1To8Days
        LDX #1
        LDY #0
        :
        LDA eventImpassibleTrailText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventImpassibleTrailText
        BNE :-
        LDY #0
        LDX #1
        :
        LDA eventLoseDaysText, X
        STA popupTextLine2, Y
        INX
        INY
        CPY eventLoseDaysText
        BNE :-
        TYA
        PHA
        DEY ; replace 1 day with X day(s)
        DEY
        DEY
        DEY
        DEY
        CLC
        LDA wagonRest
        ADC #_0_
        STA popupTextLine2, Y
        PLA
        TAY
        LDA wagonRest
        CMP #1
        BEQ :+
        LDA #_S_
        STA popupTextLine2, Y
        INY
        :
        LDA #_PD
        STA popupTextLine2, Y
        JMP TextPopup
    :
    CMP #EVENT_WILD_FRUIT
    BNE :++
        SBD
        LoadCHR #<reWildFruitTilesMeta, #>reWildFruitTilesMeta
        EBD
        BufferDrawImage #<reWildFruitImage, #>reWildFruitImage
        LDX #1
        LDY #0
        :
        LDA eventWildFruitText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventWildFruitText
        BNE :-
        JMP TextPopup
    :
    CMP #EVENT_CLEAR_WILD_FRUIT
    BNE :+
        BDrawBlankBox reWildFruitImage+2, reWildFruitImage+3, reWildFruitImage+0, reWildFruitImage+1
        RTS
    :
    CMP #EVENT_FIRE_WAGON
    BNE :+
        SBD
        LoadCHR #<reWagonFireTilesMeta, #>reWagonFireTilesMeta
        EBD
        BufferDrawImage #<reWagonFireImage, #>reWagonFireImage
        JMP TextPopup
    :
    CMP #EVENT_CLEAR_FIRE_WAGON
    BNE :+
        BDrawBlankBox reWagonFireImage+2, reWagonFireImage+3, reWagonFireImage+0, reWagonFireImage+1
        JSR BufferDrawWagon
        RTS
    :
    CMP #EVENT_LOST_PERSON
    BNE :+
        JMP TextPopup
    :
    CMP #EVENT_OX_WANDERS_OFF
    BNE :+
        JMP TextPopup
    :
    CMP #EVENT_ABANDONED_WAGON
    BNE :+
        JMP TextPopup
    :
    CMP #EVENT_THIEF
    BNE :+
        SBD
        LoadCHR #<reThiefTilesMeta, #>reThiefTilesMeta
        EBD
        BufferDrawImage #<reThiefImage, #>reThiefImage
        JMP TextPopup
    :
    CMP #EVENT_CLEAR_THIEF
    BNE :+
        BDrawBlankBox reThiefImage+2, reThiefImage+3, reThiefImage+0, reThiefImage+1
        JSR BufferDrawWagon
        RTS
    :
    CMP #EVENT_BAD_WATER
    BNE :++
        LDX #1
        LDY #0
        :
        LDA eventBadWaterText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventBadWaterText
        BNE :-
        JMP TextPopup
    :
    CMP #EVENT_LITTLE_WATER
    BNE :++
        LDX #1
        LDY #0
        :
        LDA eventLittleWaterText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventLittleWaterText
        BNE :-
        JMP TextPopup
    :
    CMP #EVENT_INADEQUATE_GRASS
    BNE :++
        LDX #1
        LDY #0
        :
        LDA eventInadequateGrassText, X
        STA popupTextLine1, Y
        INX
        INY
        CPY eventInadequateGrassText
        BNE :-
        JMP TextPopup
    :
    CMP #EVENT_ILLNESS
    BNE :+
        JMP Illness
    :
    CMP #EVENT_BROKEN_PART
    BNE :+
        SBD
        LoadCHR #<reBrokenPartTilesMeta, #>reBrokenPartTilesMeta
        EBD
        BufferDrawImage #<reBrokenPartImage, #>reBrokenPartImage
        JMP TextPopup
    :
    CMP #EVENT_CLEAR_BROKEN_PART
    BNE :+
        BDrawBlankBox reBrokenPartImage+2, reBrokenPartImage+3, reBrokenPartImage+0, reBrokenPartImage+1
        JSR BufferDrawWagon
        RTS
    :
    CMP #EVENT_CLEAR_TEXT
    BNE :+
        JSR CloseTextPopup
        LDA #MENU_NONE
        STA menuOpen
        RTS
    :
    RTS
    TextPopup:
        LDA #MENU_TEXTPOPUP
        STA menuOpen
        RTS
    InjuredPerson: ; TODO DRY
        JSR RandomNumberGenerator ; select a random person
        AND #%00000111
        CMP #5 ; limit roll to 0-4 
        BCS InjuredPerson
        TAX ; check if they are alive, already sick, or dead
        LDA personHealth, X
        AND #%11111000
        CMP #%11111000
        BEQ InjuredPerson ; already dead: roll again
        CMP #1
        BCC :+ ; alive and healthy: become injured
        LDA #%11111000 ; currently sick: die
        STA personHealth, X
        JMP @writeName
        :
        JSR RandomNumberGenerator
        LDA #%11110111 ; broken limb for 30 days
        STA personHealth, X
        @writeName:
        STX helper ; ID of person who gets illness
        LDA #0
        STA helper+1
        LDX #0
        :
        CPX helper
        BEQ :+
        INX
        CLC
        LDA helper+1
        ADC #TEXT_PERSON_LEN
        STA helper+1
        JMP :-
        :
        LDX helper+1
        LDY #0 ; "{person name}"
        LDA #0
        STA helper2
        :
        LDA personName, X
        STA popupTextLine1, Y
        INX
        INY
        INC helper2
        LDA helper2
        CMP #TEXT_PERSON_LEN
        BNE :-
        LDX #0 ; " HAS "
        :
        LDA eventIllnessText, X
        STA popupTextLine1, Y
        INX
        INY
        CPX #5
        BNE :-
        LDX helper ; "{illness name}"
        LDA personHealth, X 
        CMP #%11111000
        BNE @BrokenLimb
        LDX #57 ; index of "DIED" minus 1
        LDA #4
        STA helper2
        LDA #0
        STA helper ; counter
        :
        INX
        LDA eventIllnessText, X
        STA popupTextLine1, Y
        INY
        INC helper
        LDA helper
        CMP helper2
        BNE :-
        JMP @writeIllness
        @BrokenLimb:
        LDA #_A_
        STA popupTextLine1, Y
        INY
        LDA #___
        STA popupTextLine1, Y
        INY
        LDX #10 ; index of "BROKEN"
        :
        LDA eventInjuryText, X
        STA popupTextLine1, Y
        INY
        INX
        CPX #16 ; index of "ARM"
        BNE :-
        LDA #19 ; index of "LEG"
        STA helper
        TYA
        PHA
        JSR RandomNumberGenerator
        AND #1
        BNE :+
        INC helper
        INC helper
        INC helper
        INX
        INX
        INX
        :
        PLA
        TAY
        LDA #___
        STA popupTextLine1, Y
        INY
        :
        LDA eventInjuryText, X
        STA popupTextLine1, Y
        INY
        INX
        CPX helper
        BNE :-
        @writeIllness:
        LDA #_PD
        STA popupTextLine1, Y
        JMP TextPopup
    SnakeBite: ; TODO DRY
        JSR RandomNumberGenerator ; select a random person
        AND #%00000111
        CMP #5 ; limit roll to 0-4 
        BCS SnakeBite
        TAX ; check if they are alive, already sick, or dead
        LDA personHealth, X
        AND #%11111000
        CMP #%11111000
        BEQ SnakeBite ; already dead: roll again
        CMP #1
        BCC :+ ; alive and healthy: become injured
        LDA #%11111000 ; currently sick: die
        STA personHealth, X
        JMP @writeName
        :
        JSR RandomNumberGenerator
        LDA #%01010111 ; snake bite for 10? days (not specified in Bouchard book)
        STA personHealth, X
        @writeName:
        STX helper ; ID of person who gets illness
        LDA #0
        STA helper+1
        LDX #0
        :
        CPX helper
        BEQ :+
        INX
        CLC
        LDA helper+1
        ADC #TEXT_PERSON_LEN
        STA helper+1
        JMP :-
        :
        LDX helper+1
        LDY #0 ; "{person name}"
        LDA #0
        STA helper2
        :
        LDA personName, X
        STA popupTextLine1, Y
        INX
        INY
        INC helper2
        LDA helper2
        CMP #TEXT_PERSON_LEN
        BNE :-
        LDX #0 ; " HAS "
        :
        LDA eventIllnessText, X
        STA popupTextLine1, Y
        INX
        INY
        CPX #5
        BNE :-
        LDX helper ; "{illness name}"
        LDA personHealth, X 
        CMP #%11111000
        BNE @BrokenLimb
        LDX #57 ; index of "DIED" minus 1
        LDA #4
        STA helper2
        LDA #0
        STA helper ; counter
        :
        INX
        LDA eventIllnessText, X
        STA popupTextLine1, Y
        INY
        INC helper
        LDA helper
        CMP helper2
        BNE :-
        JMP @writeIllness
        @BrokenLimb:
        LDA #_A_
        STA popupTextLine1, Y
        INY
        LDA #___
        STA popupTextLine1, Y
        INY
        LDX #0 ; index of "SNAKE BITE"
        :
        LDA eventInjuryText, X
        STA popupTextLine1, Y
        INY
        INX
        CPX #10
        BNE :-
        @writeIllness:
        LDA #_PD
        STA popupTextLine1, Y
        JMP TextPopup
    Illness: ; TODO DRY
        JSR RandomNumberGenerator ; select a random person
        AND #%00000111
        CMP #5 ; limit roll to 0-4 
        BCS Illness
        TAX ; check if they are alive, already sick, or dead
        LDA personHealth, X
        AND #%11111000
        CMP #%11111000
        BEQ Illness ; already dead: roll again
        CMP #1
        BCC :+ ; alive and healthy: become sick
        LDA #%11111000 ; currently sick: die
        STA personHealth, X
        JMP @writeName
        :
        JSR RandomNumberGenerator
        AND #%00000111
        CMP #6 ; limit roll to 0-5
        BCS :-
        STA helper
        INC helper ; roll is now 1-6 (disease ID)
        LDA #%01010000 ; sick for 10 days
        ORA helper
        STA personHealth, X
        @writeName:
        STX helper ; ID of person who gets illness
        LDA #0
        STA helper+1
        LDX #0
        :
        CPX helper
        BEQ :+
        INX
        CLC
        LDA helper+1
        ADC #TEXT_PERSON_LEN
        STA helper+1
        JMP :-
        :
        LDX helper+1
        LDY #0 ; "{person name}"
        LDA #0
        STA helper2
        :
        LDA personName, X
        STA popupTextLine1, Y
        INX
        INY
        INC helper2
        LDA helper2
        CMP #TEXT_PERSON_LEN
        BNE :-
        LDX #0 ; " HAS "
        :
        LDA eventIllnessText, X
        STA popupTextLine1, Y
        INX
        INY
        CPX #5
        BNE :-
        LDX helper ; "{illness name}"
        LDA personHealth, X 
        CMP #%11111000
        BNE :+
        LDX #57 ; index of "DIED" minus 1
        LDA #4
        STA helper2
        JMP @writeIllness
        :
        AND #%00000111
        STA helper ; ID of illness (1-6)
        LDA #5
        STA helper+1 ; index of beginning of text segment
        TYA
        PHA
        LDY #1
        :
        LDX helper+1
        LDA eventIllnessText, X
        STA helper2 ; length of text segment
        CPY helper
        BEQ :+
        CLC
        LDA helper+1
        ADC eventIllnessText, X
        STA helper+1
        INC helper+1
        INY
        JMP :-
        :
        PLA
        TAY
        LDX helper+1
        @writeIllness:
        LDA #0
        STA helper ; counter
        :
        INX
        LDA eventIllnessText, X
        STA popupTextLine1, Y
        INY
        INC helper
        LDA helper
        CMP helper2
        BNE :-
        ; TODO word wrap for great justice
        LDA #_PD ; "."
        STA popupTextLine1, Y
        JMP TextPopup
.endproc

.proc QueueEvent
    ; A: event id to add to queue
    ; clobbers X register
    LDX eventQueuePointer
    STA eventQueue, X
    INC eventQueuePointer
    RTS
.endproc
