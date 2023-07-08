.include "constants.inc"
.include "header.inc"
.include "palettes.inc"
.include "backgrounds.inc"
.include "sprites.inc"
.include "text.inc"
.include "zeropage.inc"
.include "diarytext.inc"
.include "vars.inc"

;-------------------------------------------------------------------------------
.segment "CHARS"
    .incbin "../graphics/tiles.chr"

;-------------------------------------------------------------------------------
.segment "VECTORS"
    .addr nmi, reset, irq

;-------------------------------------------------------------------------------
.segment "CODE"
;--------------------------------------

.proc irq
    RTI
.endproc

;--------------------------------------

.proc reset
    SEI
    CLD
    LDX #$FF
    TXS
    INX
    STX PPUCTRL
    STX PPUMASK
    STX DMCFREQ
    :                   ; vblankwait
    BIT PPUSTATUS
    BPL :-
    :                   ; clear memory
    LDA #$00
    STA $0000, X
    STA $0100, X
    STA $0300, X
    STA $0400, X
    STA $0500, X
    STA $0600, X
    STA $0700, X
    LDA #$FE
    STA $0200, X
    INX
    BNE :-
    :                   ; vblankwait again
    BIT PPUSTATUS
    BPL :-
    LDA #%10010000      ; enable NMI, sprites use first pattern table
    STA softPPUCTRL
    STA PPUCTRL
    JSR InitStateTitle
    JMP main
.endproc

;--------------------------------------

.proc main
    JSR ReadController1
    JSR CheckGameState
    JMP main
.endproc

;--------------------------------------

.proc nmi
    PHP
    PHA
    TXA
    PHA
    TYA
    PHA
    LDA softPPUCTRL
    STA PPUCTRL
    LDA softPPUMASK
    STA PPUMASK
    JSR ProcessNametableBuffer
    INC frameCounter
    PLA
    TAY
    PLA
    TAX
    PLA
    PLP
    RTI
.endproc

;--SUBROUTINES------------------------------------------------------------------

; Direct screen drawing ---------------
.proc StartBulkDrawing
    LDA #%00000000      ; turn off screen
    STA softPPUMASK
    STA PPUMASK
    RTS
.endproc

.proc DoneBulkDrawing
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
    JSR StartBulkDrawing
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
    JSR DoneBulkDrawing
    RTS
.endproc

.proc DrawMenuKeyboard
    JSR StartBulkDrawing
    KBLine0:
        LDA #$22 ; Line 0  top border
        STA PPUADDR
        LDA #$04
        STA PPUADDR
        LDA #_RD ;corner
        STA PPUDATA
        LDA #_HR ;horiz line
        LDX #0 ;loop 23 times
        @topBorderLine:
            STA PPUDATA
            INX
            CPX #23
            BNE @topBorderLine
        LDA #_LD ;corner
        STA PPUDATA

    KBLine1:
        LDA #$22 ; Line 1 blank
        STA PPUADDR
        LDA #$24
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLine2:
        LDA #$22 ; Line 2 A-9
        STA PPUADDR
        LDA #$44
        STA PPUADDR
        LDA #_VR ;vert line
        STA PPUDATA
        LDA #___
        LDX #0 ;loop 23 times
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
                LDA #___
            @letter1:
            STA PPUDATA
            INX
            CPX #23
            BNE @letters1
        LDA #_VR ;vert line
        STA PPUDATA

    KBLine3:
        LDA #$22 ; Line 3 blank
        STA PPUADDR
        LDA #$64
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLine4:
        LDA #$22 ; Line 4 I-6
        STA PPUADDR
        LDA #$84
        STA PPUADDR
        LDA #_VR ;vert line
        STA PPUDATA
        LDX #0 ;loop 23 times
        @letters2:
            TXA
            AND #%00000001
            BEQ @skipLetter2
            TXA
            LSR
            CLC
            ADC #11
            TAY
            LDA keyboard, Y
            JMP @letter2
            @skipLetter2:
                LDA #___
            @letter2:
            STA PPUDATA
            INX
            CPX #23
            BNE @letters2
        LDA #_VR ;vert line
        STA PPUDATA

    KBLine5:
        LDA #$22 ; Line 5 blank
        STA PPUADDR
        LDA #$A4
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLine6:
        LDA #$22 ; Line 6 Q-3
        STA PPUADDR
        LDA #$C4
        STA PPUADDR
        LDA #_VR ;vert line
        STA PPUDATA
        LDX #0 ;loop 23 times
        @letters3:
            TXA
            AND #%00000001
            BEQ @skipLetter3
            TXA
            LSR
            CLC
            ADC #22
            TAY
            LDA keyboard, Y
            JMP @letter3
            @skipLetter3:
                LDA #___
            @letter3:
            STA PPUDATA
            INX
            CPX #23
            BNE @letters3
        LDA #_VR ;vert line
        STA PPUDATA

    KBLine7:
        LDA #$22 ; Line 7 blank
        STA PPUADDR
        LDA #$E4
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLine8:
        LDA #$23 ; Line 8 Y-?
        STA PPUADDR
        LDA #$04
        STA PPUADDR
        LDA #_VR ;vert line
        STA PPUDATA
        LDX #0 ;loop 23 times
        @letters4:
            TXA
            AND #%00000001
            BEQ @skipLetter4
            TXA
            LSR
            CLC
            ADC #33
            TAY
            LDA keyboard, Y
            JMP @letter4
            @skipLetter4:
                LDA #___
            @letter4:
            STA PPUDATA
            INX
            CPX #23
            BNE @letters4
        LDA #_VR ;vert line
        STA PPUDATA

        LDA #$23 ; Line 8 "DONE"
        STA PPUADDR
        LDA #$16
        STA PPUADDR
        LDX #0 ;loop 4 times
        @letterDone:
            LDA keyboardDone, X
            STA PPUDATA
            INX
            CPX #4
            BNE @letterDone

    KBLine9:
        LDA #$23 ; Line 9 blank
        STA PPUADDR
        LDA #$24
        STA PPUADDR
        JSR DrawMenuKeyboardBlankLine

    KBLineA:
        LDA #$23 ; Line 10  bottom border
        STA PPUADDR
        LDA #$44
        STA PPUADDR
        LDA #_RU ;corner
        STA PPUDATA
        LDA #_HR ;horiz line
        LDX #0 ;loop 23 times
        @bottomBorderLine:
            STA PPUDATA
            INX
            CPX #23
            BNE @bottomBorderLine
        LDA #_LU ;corner
        STA PPUDATA

    JSR DoneBulkDrawing
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

.proc LoadBgNewGame
    JSR StartBulkDrawing
    Leader:
        LDA PPUSTATUS       ; write "LEADER:"
        LDA #$20            
        STA PPUADDR
        LDA #$85
        STA PPUADDR
        LDX #0
        :
        LDA newGameText, X  
        STA PPUDATA
        INX
        CPX #7
        BNE :-
    Occupation:
        LDA PPUSTATUS       ; write "OCCUPATION:"
        LDA #$20     
        STA PPUADDR
        LDA #$8F
        STA PPUADDR
        :
        LDA newGameText, X  
        STA PPUDATA
        INX
        CPX #18
        BNE :-
    OtherPartyMembers:
        LDA PPUSTATUS       ; write "OTHER PARTY MEMBERS:"
        LDA #$21
        STA PPUADDR
        LDA #$45
        STA PPUADDR
        :
        LDA newGameText, X  
        STA PPUDATA
        INX
        CPX #38
        BNE :-
    NameLeader:
        LDA PPUSTATUS       ; write leader name
        LDA #$20
        STA PPUADDR
        LDA #$C7
        STA PPUADDR
        LDX #0
        :
        LDA personName, X
        CMP #___
        BNE :+
        LDA #_UL
        :
        STA PPUDATA
        INX
        CPX #4
        BNE :--
    NameOccupation:
        LDA PPUSTATUS       ; write occupation
        LDA #$20            
        STA PPUADDR
        LDA #$D0
        STA PPUADDR
        LDX #0
        LDY #0
        LDA occupation
        CMP #0
        BNE :+
        JMP @occTextLoop
        :
        STX helper
        :
        INX
        INC helper
        CPX #TEXT_OCCUPATION_LEN
        BNE :-
        LDX #0
        INY
        CPY occupation
        BNE :-
        LDY #0
        LDX helper
        @occTextLoop:
        LDA occupationText, X
        CMP #___
        BNE :+
        LDA #_UL
        :
        STA PPUDATA
        INX
        INY
        CPY #TEXT_OCCUPATION_LEN
        BNE @occTextLoop
    NamePerson1:
        LDA PPUSTATUS       ; write party member 1 name
        LDA #$21            
        STA PPUADDR
        LDA #$87
        STA PPUADDR
        LDX #0
        @underline3:
        LDA personName+4, X
        CMP #___
        BNE :+
        LDA #_UL
        :
        STA PPUDATA
        INX
        CPX #4
        BNE @underline3
    NamePerson2:
        LDA PPUSTATUS       ; write party member 3 name
        LDA #$21
        STA PPUADDR
        LDA #$91
        STA PPUADDR
        LDX #0
        @underline4:
        LDA personName+12, X
        CMP #___
        BNE :+
        LDA #_UL
        :
        STA PPUDATA
        INX
        CPX #4
        BNE @underline4
    NamePerson3:
        LDA PPUSTATUS       ; write party member 2 name
        LDA #$21
        STA PPUADDR
        LDA #$C7
        STA PPUADDR
        LDX #0
        @underline5:
        LDA personName+8, X
        CMP #___
        BNE :+
        LDA #_UL
        :
        STA PPUDATA
        INX
        CPX #4
        BNE @underline5
    NamePerson4:
        LDA PPUSTATUS       ; write party member 4 name
        LDA #$21
        STA PPUADDR
        LDA #$D1
        STA PPUADDR
        LDX #0
        @underline6:
        LDA personName+16, X
        CMP #___
        BNE :+
        LDA #_UL
        :
        STA PPUDATA
        INX
        CPX #4
        BNE @underline6
    JSR DoneBulkDrawing
    RTS
.endproc

.proc LoadBgStore
    JSR StartBulkDrawing
    LDA location            ; calculate address of store name text
    AND #%00001111
    STA helper
    LDY #0
    LDX #0
    CPY helper
    BNE :+
    JMP StoreName
    :
    INX
    CPX #TEXT_STORENAME_LEN
    BNE :-
    INY
    CPY helper
    BNE :-
    StoreName:
        LDY #0
        LDA PPUSTATUS           ; write store name
        LDA #$20
        STA PPUADDR
        LDA #$64
        STA PPUADDR
        :
        LDA storeNameText, X
        STA PPUDATA
        INX
        INY
        CPY #TEXT_STORENAME_LEN
        BNE :-
        LDX #0                  ; write " GENERAL STORE"
        LDA #___
        STA PPUDATA
        :
        LDA generalStoreText, X
        STA PPUDATA
        INX
        CPX #13
        BNE :-
    ColumnHeaders:
        LDY #0
        LDA PPUSTATUS           ; write column headers
        LDA #$20
        STA PPUADDR
        LDA #$C4
        STA PPUADDR
        LDX #0
        :
        LDA storeColumnHeaderText, X
        STA PPUDATA
        INX
        CPX #4
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        :
        LDA storeColumnHeaderText, X
        STA PPUDATA
        INX
        CPX #8
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        STA PPUDATA
        STA PPUDATA
        STA PPUDATA
        :
        LDA storeColumnHeaderText, X
        STA PPUDATA
        INX
        CPX #12
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        :
        LDA storeColumnHeaderText, X
        STA PPUDATA
        INX
        CPX #16
        BNE :-
    Oxen:
        LDA PPUSTATUS           ; write oxen row
        LDA #$21
        STA PPUADDR
        LDA #$04
        STA PPUADDR
        LDA #___
        STA PPUDATA
        STA PPUDATA
        LDA cartOxenDigit       ; number in Buy column
        STA PPUDATA
        LDA cartOxenDigit+1
        STA PPUDATA
        LDA #___
        STA PPUDATA
        STA PPUDATA             ; the word "OXEN"
        LDY #0
        LDX #0                  
        :
        LDA suppliesText, X
        STA PPUDATA
        INX
        INY
        CPY #TEXT_SUPPLIES_LEN
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        
        ; LDA location            ; calculate price each
        ; AND #$0F
        LDA #COST_OXEN

        JSR DrawShopEach        ; number in Each column
        LDA #___
        STA PPUDATA
        STA PPUDATA
        JSR DrawShopCost        ; number in Cost column
    Clothes:
        LDA PPUSTATUS           ; write clothes row
        LDA #$21
        STA PPUADDR
        LDA #$44
        STA PPUADDR
        LDA #___
        STA PPUDATA
        STA PPUDATA
        LDA cartClothingDigit   ; number in Buy column
        STA PPUDATA
        LDA cartClothingDigit+1
        STA PPUDATA
        LDA #___
        STA PPUDATA
        STA PPUDATA             ; the word "CLOTHES"
        LDY #0
        LDX #7
        :
        LDA suppliesText, X
        STA PPUDATA
        INX
        INY
        CPY #TEXT_SUPPLIES_LEN
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        
        ; LDA location            ; calculate price each
        ; AND #$0F
        LDA #COST_CLOTHES

        JSR DrawShopEach        ; number in Each column
        LDA #___
        STA PPUDATA
        STA PPUDATA
        JSR DrawShopCost        ; number in Cost column
    Bullets:
        LDA PPUSTATUS           ; write bullets row
        LDA #$21
        STA PPUADDR
        LDA #$84
        STA PPUADDR
        LDA cartBulletsDigit    ; number in Buy column
        STA PPUDATA
        LDA cartBulletsDigit+1
        STA PPUDATA
        LDA cartBulletsDigit+2
        STA PPUDATA
        LDA cartBulletsDigit+3
        STA PPUDATA
        LDA #___
        STA PPUDATA
        STA PPUDATA             ; the word "bullets"
        LDY #0
        LDX #14
        :
        LDA suppliesText, X
        STA PPUDATA
        INX
        INY
        CPY #TEXT_SUPPLIES_LEN
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        
        ; LDA location            ; calculate price each
        ; AND #$0F
        LDA #COST_BULLETS

        JSR DrawShopEach        ; number in Each column
        LDA #___
        STA PPUDATA
        STA PPUDATA
        JSR DrawShopCost        ; number in Cost column
    Wheels:
        LDA PPUSTATUS           ; write Wheels row
        LDA #$21
        STA PPUADDR
        LDA #$C4
        STA PPUADDR
        LDA #___
        STA PPUDATA
        STA PPUDATA
        STA PPUDATA
        LDA cartSpareParts      ; number in Buy column
        AND #%00000011
        TAY
        LDX #_1_
        DEX
        CPY #0
        BNE :+
        LDA #_0_
        STA PPUDATA
        JMP :++
        :
        INX
        DEY
        CPY #0
        BNE :-
        STX PPUDATA
        :
        LDA #___
        STA PPUDATA
        STA PPUDATA             ; the word "Wheels"
        LDY #0
        LDX #21
        :
        LDA suppliesText, X
        STA PPUDATA
        INX
        INY
        CPY #TEXT_SUPPLIES_LEN
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        
        ; LDA location            ; calculate price each
        ; AND #$0F
        LDA #COST_PARTS

        JSR DrawShopEach        ; number in Each column
        LDA #___
        STA PPUDATA
        STA PPUDATA
        JSR DrawShopCost        ; number in Cost column
    Axles:
        LDA PPUSTATUS           ; write Axles row
        LDA #$22
        STA PPUADDR
        LDA #$04
        STA PPUADDR
        LDA #___
        STA PPUDATA
        STA PPUDATA
        STA PPUDATA
        LDA cartSpareParts      ; number in Buy column
        LSR
        LSR
        AND #%00000011
        TAY
        LDX #_1_
        DEX
        CPY #0
        BNE :+
        LDA #_0_
        STA PPUDATA
        JMP :++
        :
        INX
        DEY
        CPY #0
        BNE :-
        STX PPUDATA
        :
        LDA #___
        STA PPUDATA
        STA PPUDATA             ; the word "Axles"
        LDY #0
        LDX #28
        :
        LDA suppliesText, X
        STA PPUDATA
        INX
        INY
        CPY #TEXT_SUPPLIES_LEN
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        
        ; LDA location            ; calculate price each
        ; AND #$0F
        LDA #COST_PARTS

        JSR DrawShopEach        ; number in Each column
        LDA #___
        STA PPUDATA
        STA PPUDATA
        JSR DrawShopCost        ; number in Cost column
    Tongues:
        LDA PPUSTATUS           ; write Tongues row
        LDA #$22
        STA PPUADDR
        LDA #$44
        STA PPUADDR
        LDA #___
        STA PPUDATA
        STA PPUDATA
        STA PPUDATA
        LDA cartSpareParts      ; number in Buy column
        LSR
        LSR
        LSR
        LSR
        AND #%00000011
        TAY
        LDX #_1_
        DEX
        CPY #0
        BNE :+
        LDA #_0_
        STA PPUDATA
        JMP :++
        :
        INX
        DEY
        CPY #0
        BNE :-
        STX PPUDATA
        :
        LDA #___
        STA PPUDATA
        STA PPUDATA             ; the word "Tongues"
        LDY #0
        LDX #35
        :
        LDA suppliesText, X
        STA PPUDATA
        INX
        INY
        CPY #TEXT_SUPPLIES_LEN
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        
        ; LDA location            ; calculate price each
        ; AND #$0F
        LDA #COST_PARTS

        JSR DrawShopEach        ; number in Each column
        LDA #___
        STA PPUDATA
        STA PPUDATA
        JSR DrawShopCost        ; number in Cost column
    Food:
        LDA PPUSTATUS           ; write Food row
        LDA #$22
        STA PPUADDR
        LDA #$84
        STA PPUADDR
        LDA cartFoodLbsDigit    ; number in Buy column
        STA PPUDATA
        LDA cartFoodLbsDigit+1
        STA PPUDATA
        LDA cartFoodLbsDigit+2
        STA PPUDATA
        LDA cartFoodLbsDigit+3
        STA PPUDATA
        LDA #___
        STA PPUDATA
        STA PPUDATA             ; the word "Food"
        LDY #0
        LDX #42
        :
        LDA suppliesText, X
        STA PPUDATA
        INX
        INY
        CPY #TEXT_SUPPLIES_LEN
        BNE :-
        LDA #___
        STA PPUDATA
        STA PPUDATA
        
        ; LDA location            ; calculate price each
        ; AND #$0F
        LDA #COST_FOOD_LB

        JSR DrawShopEach        ; number in Each column
        LDA #___
        STA PPUDATA
        STA PPUDATA
        JSR DrawShopCost        ; number in Cost column
    Total:
        LDA PPUSTATUS           ; write Total:
        LDA #$22
        STA PPUADDR
        LDA #$EE
        STA PPUADDR
        LDX #0
        :
        LDA storeTotalText, X
        STA PPUDATA
        INX
        CPX #9
        BNE :-
        LDA #___
        STA PPUDATA
        JSR DrawShopTotal
    YouHave:
        LDA PPUSTATUS           ; write You Have: 
        LDA #$23
        STA PPUADDR
        LDA #$6E
        STA PPUADDR
        LDX #9
        :
        LDA storeTotalText, X
        STA PPUDATA
        INX
        CPX #18
        BNE :-
        LDA #___
        STA PPUDATA
        JSR DrawShopTotal
    Done:
    JSR DoneBulkDrawing
    RTS
.endproc

.proc DrawShopEach
    ; A: value to convert to two decimal text digits
    ; destroys X,Y registers
    ; Return: helper,helper+1 - resulting digits
    STA helper
    LDX #_DL
    STX PPUDATA
    CMP #10
    BCS TwoDigits
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
    LDA #_DL
    STA PPUDATA
    LDA #_UL
    STA PPUDATA
    STA PPUDATA
    LDA #_0_
    STA PPUDATA
    LDA #_00
    STA PPUDATA
    RTS
.endproc

.proc DrawShopTotal
    LDA #_DL
    STA PPUDATA
    LDA #_UL
    STA PPUDATA
    STA PPUDATA
    STA PPUDATA
    LDA #_0_
    STA PPUDATA
    LDA #_00
    STA PPUDATA
    RTS
.endproc

.proc DrawOccupationMenu
    JSR StartBulkDrawing
    LDA PPUSTATUS
    Line0:
        LDA #$20 ; Line 0  top border
        STA PPUADDR
        LDA #$AD
        STA PPUADDR
        LDA #_RD ;corner
        STA PPUDATA
        LDA #_HR ;horiz line
        LDX #0 ;loop 15 times
        :
        STA PPUDATA
        INX
        CPX #15
        BNE :-
        LDA #_LD ;corner
        STA PPUDATA
    Line1:
        LDA #$20 ; Line 1 blank
        STA PPUADDR
        LDA #$CD
        STA PPUADDR
        JSR DrawOccupationMenuBlankLine
    LDA #0
    STA helper
    LDY #7
    Lines2thru17:
        LDX #13
        JSR SetPpuAddrPointerFromXY
        LDA pointer
        STA PPUADDR
        LDA pointer+1
        STA PPUADDR
        LDA #_VR ; vertical line
        STA PPUDATA
        LDA #___ ; blank space for finger
        STA PPUDATA
        STA PPUDATA
        STA PPUDATA
        STY pointer
        STX pointer+1
        LDX helper
        LDY #0
        :
        LDA occupationText, X
        STA PPUDATA
        INY
        INX
        INC helper
        CPY #TEXT_OCCUPATION_LEN
        BNE :-
        LDY pointer
        LDX pointer+1
        LDA #___
        STA PPUDATA
        LDA #_VR
        STA PPUDATA
        INY
        JSR SetPpuAddrPointerFromXY
        LDA pointer
        STA PPUADDR
        LDA pointer+1
        STA PPUADDR
        JSR DrawOccupationMenuBlankLine
        INY
        CPY #23 ; below line 17
        BNE Lines2thru17
    Line18:
        LDA #$22 ; Line 18 bottom border
        STA PPUADDR
        LDA #$ED
        STA PPUADDR
        LDA #_RU ;corner
        STA PPUDATA
        LDA #_HR ;horiz line
        LDX #0 ;loop 15 times
        :
        STA PPUDATA
        INX
        CPX #15
        BNE :-
        LDA #_LU ;corner
        STA PPUDATA
    JSR DoneBulkDrawing
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

; Buffer drawing ----------------------

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
    BNE :-                  ; repeat until no more bytes to copy
    LDY nametableBuffer, X
    INX
    CPX #0
    BNE @loop               ; exit if entire buffer has been read
    Done:
    RTS
.endproc

.proc WriteByteToBuffer
    ; write contents of A register to the nametable buffer
    ; this will kill the contents of Y register
    LDY bufferPointer
    STA nametableBuffer, Y
    INC bufferPointer
    RTS
.endproc
    
.proc WriteTileToBuffer
    ; X,Y,A = tiles from left, tiles from top, tile index to draw
    ; write one single tile to the nametable buffer
    PHA
    LDA #1
    STA bufferLoading
    JSR SetPpuAddrPointerFromXY
    LDA #1
    JSR WriteByteToBuffer
    LDA pointer
    JSR WriteByteToBuffer
    LDA pointer+1
    JSR WriteByteToBuffer
    PLA
    JSR WriteByteToBuffer
    LDA #0
    LDY bufferPointer
    STA nametableBuffer, Y
    STA bufferLoading
    RTS
.endproc

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
    LDX fingerLastX
    LDY fingerLastY
    LDA #___
    JSR WriteTileToBuffer
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
    LDA #1
    STA bufferLoading
    LDA #$20                ; length of palette
    JSR WriteByteToBuffer
    LDA #$3F                ; $3F00 - palette VRAM location
    JSR WriteByteToBuffer
    LDA #$00
    JSR WriteByteToBuffer
    :                       
    LDA palette, X
    JSR WriteByteToBuffer
    INX
    CPX #$20
    BNE :-
    LDA #0
    STA bufferLoading
    RTS
.endproc

.proc DrawStoreSubmenu
    LDX #2                  ; first row of submenu
    INX
    LDY fingerY
    DEY
    DEY
    JSR SetPpuAddrPointerFromXY
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
    RTS
.endproc

.proc IncreaseDigit
    ; X: memory location of digit to increment
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
        LDY #1
        LDA (pointer), Y
        TAX
        INX
        CPX #_CL ; #_9_+1
        BNE :+
        LDX #_0_
        :
        TXA
        STA (pointer), Y
        LDX fingerX
        LDY fingerY
        JSR WriteTileToBuffer
        JMP Done
    Tens:
        CMP #6 ; 10's place
        BNE Hundreds
        JMP Done
    Hundreds:
        CMP #5 ; 100's place
        BNE Thousands
        JMP Done
    Thousands:
    
    Done:
    RTS
.endproc

.proc DecreaseDigit
    ; X: memory location of digit to decrement
    CPX #0
    BEQ Done


    Done:
    RTS
.endproc

; Game logic --------------------------

.proc CheckGameState
    LDA lastGameState
    CMP gameState
    BNE :+
    JSR UpdateGame
    JMP Done
    :
    JSR ClearScreen
    LDA gameState   
    STA lastGameState
    CMP #GAMESTATE_TITLE
    BNE :+
    JSR InitStateTitle
    JMP Done
    :
    CMP #GAMESTATE_TRAVELING
    BNE :+ 
    JSR InitStateTraveling
    JMP Done
    :
    CMP #GAMESTATE_NEWGAME
    BNE :+ 
    JSR InitStateNewGame
    JMP Done
    :
    CMP #GAMESTATE_STORE
    BNE :+ 
    JSR InitStateStore
    JMP Done
    :
    CMP #GAMESTATE_STARTDATE
    BNE :+ 
    JSR InitStateStartDate
    JMP Done
    :
    CMP #GAMESTATE_LANDMARK
    BNE :+ 
    JSR InitStateLandmark
    JMP Done
    :
    CMP #GAMESTATE_MAP
    BNE :+
    JSR InitStateMap
    JMP Done
    :
    Done:
    RTS
.endproc

.proc UpdateGame
    LDA menuOpen
    CMP menuOpenLast
    BEQ :+
    JSR NewMenuOpened
    JMP Done
    :
    LDA gameState
    CMP #GAMESTATE_TITLE
    BNE :+
    JMP Done
    :
    CMP #GAMESTATE_TRAVELING
    BNE :+ 
    JMP Done
    :
    CMP #GAMESTATE_NEWGAME
    BNE :+ 
    JMP Done
    :
    CMP #GAMESTATE_STORE
    BNE :+ 
    JMP Done
    :
    CMP #GAMESTATE_STARTDATE
    BNE :+ 
    JMP Done
    :
    CMP #GAMESTATE_LANDMARK
    BNE :+ 
    JMP Done
    :
    CMP #GAMESTATE_MAP
    BNE :+
    JMP Done
    :
    Done:
    JSR DrawFinger
    RTS
.endproc

.proc NewMenuOpened
    ; A-register should contain menuOpen.
    STA menuOpenLast    ; reset last menu open
    CMP #MENU_NONE      ; which menu was just opened?
    BNE :+
    JMP None
    :
    CMP #MENU_NEWGAME_TYPING
    BNE :+
    JMP NewGameTyping
    :
    CMP #MENU_NEWGAME_OCCUPATION
    BNE :+
    JMP NewGameOccupation
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
    None:
        LDA #0
        STA fingerLastLastX
        STA fingerLastLastY ; clear LastLast pos since we are NOT in a submenu.
        JSR ClearScreen
        LDA gameState
        CMP #GAMESTATE_NEWGAME
        BNE :+
        LDA #%00001100      ; both fingers visible, normal, pointing right
        STA fingerAttr
        JSR LoadBgNewGame
        :
        CMP #GAMESTATE_STORE
        BNE :+
        LDA #%00001100      ; both fingers visible, normal, pointing right
        STA fingerAttr
        LDA #0
        STA fingerLastY     ; hack to redraw finger
        JSR LoadBgStore
        :
        JMP Done
    NewGameTyping:
        LDA #%00001100      ; both fingers visible, pointing right
        STA fingerAttr
        LDA #0              ; default key to 'A'
        STA keyboardKey
        JSR DrawMenuKeyboard
        LDX #5
        LDY #18
        JSR MoveFingerToSubmenu
        JMP Done
    NewGameOccupation:
        LDA #%00000100      ; only main finger visible, pointing right
        STA fingerAttr
        JSR DrawOccupationMenu
        LDX #15
        LDY #7
        JSR MoveFingerToSubmenu
        JMP Done
    StoreSubmenu:
        LDA #%00011100      ; both fingers visible, main finger "up/down" arrows
        STA fingerAttr
        JSR DrawStoreSubmenu
        PLA
        TAX
        LDY fingerY
        JSR MoveFingerToSubmenu
        JMP Done
    Done:
    RTS
.endproc

.proc UpdateBg ; deprecated

    CheckIfFingerMoved:
        LDA fingerX
        CMP fingerLastX
        BNE @fingerMoved
        LDA fingerY
        CMP fingerLastY
        BNE @fingerMoved
        ;JMP CheckForNewMenu
        @fingerMoved:
            LDA #0
            STA bgLoaded


    CheckState:
        LDA gameState

        CMP #GAMESTATE_TITLE
        BEQ Title

        CMP #GAMESTATE_TRAVELING
        BEQ Traveling

        CMP #GAMESTATE_NEWGAME
        BEQ NewGame

        CMP #GAMESTATE_STORE
        BEQ Store

        CMP #GAMESTATE_STARTDATE
        BEQ StartDate

        CMP #GAMESTATE_LANDMARK
        BEQ Landmark

        CMP #GAMESTATE_MAP
        BEQ Map

    Title:
        JMP Done
        
    NewGame:
        LDA bgLoaded
        CMP #0
        BNE :+
        JSR LoadBgNewGame
        LDA menuOpen
        CMP #MENU_NEWGAME_TYPING
        BNE :+
        JSR DrawMenuKeyboard
        :
        JSR DrawFinger
        JMP Done
        
    Store:
        JMP Done
        
    StartDate:
        JMP Done
        
    Landmark:
        JMP Done
        
    Map:
        JMP Done

    Traveling:
        LDX globalScroll
        DEX
        STX PPUSCROLL ; horizontal scroll (globalScroll - 1)
        LDA #0
        STA PPUSCROLL ; vertical scroll (0)
        STX globalScroll ; update globalScroll
        ; CheckSprite0Hit: ; t. @cuttercross
        LDA #%11000000  ;; We'll bit test for both sprite0 flag and vBlank flag at the same time 
                        ;; [Safety measure to prevent a full lockup scenario on sprite0 miss]
        @sprite0Poll1:
            BIT PPUSTATUS
            BNE @sprite0Poll1    ;; Ensure that sprite0 + vBlank flag are clear before proceeding
        @sprite0Poll2:
            BIT PPUSTATUS 
            BEQ @sprite0Poll2    ;; Wait for sprite0 flag to be set
            ;; Freeze scroll for status bar
            LDA #0
            STA PPUSCROLL 
            STA PPUSCROLL
            JMP Done

    Done:

    LDA #1
    STA bgLoaded
    RTS
.endproc

; Helper / math functions -------------

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
    LDA #0
    STA fingerLastY     ; hack to redraw finger
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

; Game state initialization -----------

.proc InitStateTitle
    LDA #%00001101          ; default steady pace, filling rations
    STA wagonSettings
    LDA #%00000100          ; default fair weather
    STA weather
    LDA #%00000000          ; default no fingers visible, facing right
    STA fingerAttr
    LDA #LOC_INDEPENDENCE   ; default location Independence, MO
    STA location
    :                       ; default person names
    LDA defaultPersonNames, X
    STA personName, X
    INX
    CPX #20
    BNE :-
    LDA #1                  ; begin writing to buffer
    STA bufferLoading
    LDX #0                  ; default palette
    JSR UpdatePalette
    LDA #17                 ; title text
    JSR WriteByteToBuffer
    LDA #$21                ; $2129 - title text VRAM location
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
    LDA #12                 ; title options text
    JSR WriteByteToBuffer 
    LDA #$22                ; $220B - titleOptions VRAM location
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
    LDA #0                  ; finish writing to buffer
    LDY bufferPointer
    STA nametableBuffer, Y
    STA bufferLoading
    LDA #%10010000
    STA softPPUCTRL         ; Ensure NMIs are enabled
    LDA #%00011110 
    STA softPPUMASK         ; turn on screen
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
    LDA #___                ; default empty shopping cart
    STA cartDollarsDigit    ; Dollars: "   0"
    STA cartDollarsDigit+1
    STA cartDollarsDigit+2
    STA cartFoodLbsDigit    ; food lbs: "  00"
    STA cartFoodLbsDigit+1
    STA cartBulletsDigit    ; bullets: "  00"
    STA cartBulletsDigit+1
    STA cartClothingDigit   ; clothing: " 0"
    STA cartOxenDigit       ; oxen: " 0"
    LDA #_0_            
    STA cartDollarsDigit+3
    STA cartFoodLbsDigit+2
    STA cartFoodLbsDigit+3
    STA cartBulletsDigit+2
    STA cartBulletsDigit+3
    STA cartClothingDigit+1
    STA cartOxenDigit+1
    LDA #0
    STA cartDollars
    STA cartDollars+1
    STA cartFoodLbs
    STA cartFoodLbs+1
    STA cartBullets
    STA cartBullets+1
    STA cartClothing
    STA cartOxen
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
        LDA #$90        ; default $400.00 dollar amount (#$190)
        STA dollars
        LDA #$01
        STA dollars+1
        LDX occupation
        LDA occupationAttribute, X
        LSR             ; shift occupationAttribute to only starting cash
        LSR
        LSR
        LSR
        LSR
        LSR
        TAY
        :
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
        BNE :-
        JMP Done
    ; Loc2:
    ;     JMP Done
    Done:
    JSR LoadBgStore     ; Load background
    RTS
.endproc

.proc InitStateStartDate
    RTS
.endproc

.proc InitStateLandmark
    RTS
.endproc

.proc InitStateMap
    RTS
.endproc

.proc InitStateTraveling
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

; Controller reading ------------------

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
    CMP #GAMESTATE_TRAVELING
    BNE :+
    JSR ControllerTraveling
    JMP Done
    :
    CMP #GAMESTATE_TITLE
    BNE :+
    JSR ControllerTitle
    JMP Done
    :
    CMP #GAMESTATE_NEWGAME
    BNE :+
    JSR ControllerNewGame
    JMP Done
    :
    CMP #GAMESTATE_STORE
    BNE :+
    JSR ControllerStore
    JMP Done
    :
    CMP #GAMESTATE_STARTDATE
    BNE :+
    JSR ControllerStartDate
    JMP Done
    :
    CMP #GAMESTATE_LANDMARK
    BNE :+
    JSR ControllerLandmark
    JMP Done
    :
    CMP #GAMESTATE_MAP
    BNE :+
    JSR ControllerMap
    JMP Done
    :
    Done:
    LDA buttons1
    STA buttons1Last    ; Remember last controller inputs
    RTS
.endproc

.proc ControllerTitle
    LDA #KEY_START
    BIT buttons1
    BEQ :+
    LDA #GAMESTATE_NEWGAME
    STA gameState
    :
    RTS
.endproc
        
.proc ControllerNewGame
    LDA buttons1
    CMP buttons1Last
    BNE CheckA
    JMP Done
    CheckA:
        LDA #KEY_A
        BIT buttons1
        BNE :+
        JMP CheckB
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_NEWGAME_TYPING
        BNE :+
        JMP @menuTyping
        :
        CMP #MENU_NEWGAME_OCCUPATION
        BNE :+
        JMP @menuOccupation
        :
        JMP CheckB
        @menuNone:
            LDA fingerX ; check finger coords for "Leader" selection
            CMP #5
            BNE :+
            LDA fingerY 
            CMP #6
            BNE :+
            LDA #MENU_NEWGAME_TYPING
            STA menuOpen
            LDA #0
            STA nameCursor
            JMP Done
            :
            LDA fingerX ; check finger coords for "Occupation" selection
            CMP #14
            BNE :+
            LDA fingerY 
            CMP #6
            BNE :+
            LDA #0
            STA occupationCursor
            LDA #MENU_NEWGAME_OCCUPATION
            STA menuOpen
            JMP Done
            :
            LDA fingerX ; check finger coords for "Person1" selection
            CMP #5
            BNE :+ 
            LDA fingerY 
            CMP #12
            BNE :+  
            LDA #MENU_NEWGAME_TYPING
            STA menuOpen
            LDA #4
            STA nameCursor
            JMP Done
            :
            LDA fingerX ; check finger coords for "Person2" selection
            CMP #5
            BNE :+ 
            LDA fingerY 
            CMP #14
            BNE :+  
            LDA #MENU_NEWGAME_TYPING
            STA menuOpen
            LDA #8
            STA nameCursor
            JMP Done
            :
            LDA fingerX ; check finger coords for "Person3" selection
            CMP #15
            BNE :+ 
            LDA fingerY 
            CMP #12
            BNE :+  
            LDA #MENU_NEWGAME_TYPING
            STA menuOpen
            LDA #12
            STA nameCursor
            JMP Done
            :
            LDA fingerX ; check finger coords for "Person4" selection
            CMP #15
            BNE CheckB
            LDA fingerY 
            CMP #14
            BNE CheckB
            LDA #MENU_NEWGAME_TYPING
            STA menuOpen
            LDA #16
            STA nameCursor
            JMP Done
        @menuOccupation:
            LDA occupationCursor
            STA occupation
            JSR CloseSubmenu
            JMP Done
        @menuTyping:
            LDA fingerX
            CMP #21
            BNE :+
            LDA fingerY
            CMP #24
            BNE :+
            JSR CloseSubmenu
            JMP Done
            :
            LDX keyboardKey
            LDA keyboard, X
            LDY nameCursor
            STA personName,Y
            INC nameCursor
            LDA nameCursor
            AND #%00000011
            BNE :+
            DEC nameCursor
            LDA #41         ; jump to "DONE" key
            STA keyboardKey
            LDA #21
            STA fingerX
            LDA #24
            STA fingerY
            :
            JSR LoadBgNewGame ; todo: only update 1 tile (use WriteTileToBuffer?)
            JMP Done

    CheckB:
        LDA #KEY_B
        BIT buttons1
        BNE :+
        JMP CheckStart
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_NEWGAME_TYPING
        BNE :+
        JMP @menuTyping
        :
        CMP #MENU_NEWGAME_OCCUPATION
        BNE :+
        JMP @menuOccupation
        :
        JMP CheckStart
        @menuNone:
        JMP Done
        @menuTyping:
        JMP Done
        @menuOccupation:
        JSR CloseSubmenu
        JMP Done

    CheckStart:
        LDA #KEY_START
        BIT buttons1
        BNE :+
        JMP CheckLeft
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_NEWGAME_TYPING
        BNE :+
        JMP @menuTyping
        :
        CMP #MENU_NEWGAME_OCCUPATION
        BNE :+
        JMP @menuOccupation
        :
        JMP CheckLeft
        @menuNone:
            LDA #GAMESTATE_STORE
            STA gameState
            JMP Done
        @menuTyping:
            LDA #21
            CMP fingerX
            BNE :+
            LDA #24
            CMP fingerY
            BNE :+
            JSR CloseSubmenu    ; "DONE" key pressed. close keyboard
            JMP Done
            :
            LDA #21             ; move finger to the "DONE" key
            STA fingerX
            LDA #24
            STA fingerY
            JMP Done
        @menuOccupation:
            LDA occupationCursor
            STA occupation
            JSR CloseSubmenu
            JMP Done

    CheckLeft:
        LDA #KEY_LEFT
        BIT buttons1
        BNE @checkMenuL_None
        JMP @skipL
        @checkMenuL_None:
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkMenuL_Typing
            JMP @checkLeaderL
        @checkMenuL_Typing:
            CMP #MENU_NEWGAME_TYPING
            BNE @skipL
            JMP @checkTypingL
        @skipL:
            JMP CheckRight
        @checkLeaderL:
            LDA fingerX ; check finger coords for "Leader" selection
            CMP #5
            BNE @checkOccupationL
            LDA fingerY 
            CMP #6
            BNE @checkOccupationL
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkOccupationL
            LDA #14
            STA fingerX ; move finger to "Occupation"
            JMP Done
        @checkOccupationL:
            LDA fingerX ; check finger coords for "Occupation" selection
            CMP #14
            BNE @checkPerson1L
            LDA fingerY 
            CMP #6
            BNE @checkPerson1L
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson1L
            LDA #5
            STA fingerX ; move finger to "Leader"
            JMP Done
        @checkPerson1L:
            LDA fingerX ; check finger coords for "Person1" selection
            CMP #5
            BNE @checkPerson2L
            LDA fingerY 
            CMP #12
            BNE @checkPerson2L
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson2L
            LDA #15
            STA fingerX ; move finger to "Person3"
            JMP Done
        @checkPerson2L:
            LDA fingerX ; check finger coords for "Person2" selection
            CMP #5
            BNE @checkPerson3L
            LDA fingerY 
            CMP #14
            BNE @checkPerson3L
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson3L
            LDA #15
            STA fingerX ; move finger to "Person4"
            JMP Done
        @checkPerson3L:
            LDA fingerX ; check finger coords for "Person3" selection
            CMP #15
            BNE @checkPerson4L
            LDA fingerY 
            CMP #12
            BNE @checkPerson4L
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson4L
            LDA #5
            STA fingerX ; move finger to "Person1"
            JMP Done
        @checkPerson4L:
            LDA fingerX ; check finger coords for "Person4" selection
            CMP #15
            BNE CheckRight
            LDA fingerY 
            CMP #14
            BNE CheckRight
            LDA menuOpen
            CMP #MENU_NONE
            BNE CheckRight
            LDA #5
            STA fingerX ; move finger to "Person2"
            JMP Done
        @checkTypingL:
            LDX fingerX
            DEX
            DEX
            DEC keyboardKey
            LDA keyboardKey
            STA helper
            CPX #3  ; check if we need to wrap around
            BNE @moveFingerL
            LDX #25 ; wrap around
            LDA keyboardKey
            CLC
            ADC #TEXT_KEYBOARD_LEN
            STA helper
            LDA fingerY
            CMP #24 ; check if we need to wrap to the "DONE" keyboard button
            BNE @moveFingerL
            LDX #21 ; wrap around to "DONE" keyboard button
            LDA #41
            STA helper
            @moveFingerL:
            STX fingerX
            LDA helper
            STA keyboardKey
            JMP Done
    CheckRight:
        LDA #KEY_RIGHT
        BIT buttons1
        BNE @checkMenuR_None
        JMP @skipR
        @checkMenuR_None:
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkMenuR_Typing
            JMP @checkLeaderR
        @checkMenuR_Typing:
            CMP #MENU_NEWGAME_TYPING
            BNE @skipR
            JMP @checkTypingR
        @skipR:
            JMP CheckUp
        @checkLeaderR:
            LDA fingerX ; check finger coords for "Leader" selection
            CMP #5
            BNE @checkOccupationR
            LDA fingerY 
            CMP #6
            BNE @checkOccupationR
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkOccupationR
            LDA #14
            STA fingerX ; move finger to "Occupation"
            JMP Done
        @checkOccupationR:
            LDA fingerX ; check finger coords for "Occupation" selection
            CMP #14
            BNE @checkPerson1R
            LDA fingerY 
            CMP #6
            BNE @checkPerson1R
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson1R
            LDA #5
            STA fingerX ; move finger to "Leader"
            JMP Done
        @checkPerson1R:
            LDA fingerX ; check finger coords for "Person1" selection
            CMP #5
            BNE @checkPerson2R
            LDA fingerY 
            CMP #12
            BNE @checkPerson2R
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson2R
            LDA #15
            STA fingerX ; move finger to "Person3"
            JMP Done
        @checkPerson2R:
            LDA fingerX ; check finger coords for "Person2" selection
            CMP #5
            BNE @checkPerson3R
            LDA fingerY 
            CMP #14
            BNE @checkPerson3R
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson3R
            LDA #15
            STA fingerX ; move finger to "Person4"
            JMP Done
        @checkPerson3R:
            LDA fingerX ; check finger coords for "Person3" selection
            CMP #15
            BNE @checkPerson4R
            LDA fingerY 
            CMP #12
            BNE @checkPerson4R
            LDA menuOpen
            CMP #MENU_NONE
            BNE @checkPerson4R
            LDA #5
            STA fingerX ; move finger to "Person1"
            JMP Done
        @checkPerson4R:
            LDA fingerX ; check finger coords for "Person4" selection
            CMP #15
            BNE CheckUp
            LDA fingerY 
            CMP #14
            BNE CheckUp
            LDA menuOpen
            CMP #MENU_NONE
            BNE CheckUp
            LDA #5
            STA fingerX ; move finger to "Person2"
            JMP Done
        @checkTypingR:
            LDX fingerX
            INX
            INX
            INC keyboardKey
            LDA keyboardKey
            STA helper
            LDA fingerY
            CMP #24 ; check if we are on bottom row
            BNE @wrapFingerNormallyR
            CPX #23 ; check if we need to wrap around the "DONE" key
            BEQ @wrapFingerR
            @wrapFingerNormallyR:
            CPX #27 ; check if we need to wrap around normally
            BNE @moveFingerR
            LDA helper
            SEC
            SBC #2
            STA helper
            @wrapFingerR:
            LDX #5  ; wrap around
            LDA helper
            SEC
            SBC #9
            STA helper
            @moveFingerR:
            STX fingerX
            LDA helper
            STA keyboardKey
            JMP Done
    CheckUp:
        LDA #KEY_UP
        BIT buttons1
        BNE :+
        JMP CheckDown
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_NEWGAME_TYPING
        BNE :+
        JMP @menuTyping
        :
        CMP #MENU_NEWGAME_OCCUPATION
        BNE :+
        JMP @menuOccupation
        :
        JMP CheckDown
        @menuNone:
            LDA fingerX ; check finger coords for "Leader" selection
            CMP #5
            BNE :+
            LDA fingerY 
            CMP #6
            BNE :+
            LDA #14
            STA fingerY ; move finger to "Person2"
            JMP Done
            :
            LDA fingerX ; check finger coords for "Occupation" selection
            CMP #14
            BNE :+
            LDA fingerY 
            CMP #6
            BNE :+
            LDA #15
            STA fingerX
            LDA #14
            STA fingerY ; move finger to "Person4"
            JMP Done
            :
            LDA fingerX ; check finger coords for "Person1" selection
            CMP #5
            BNE :+
            LDA fingerY 
            CMP #12
            BNE :+
            LDA #6
            STA fingerY ; move finger to "Leader"
            JMP Done
            :
            LDA fingerX ; check finger coords for "Person2" selection
            CMP #5
            BNE :+
            LDA fingerY 
            CMP #14
            BNE :+
            LDA #12
            STA fingerY ; move finger to "Person1"
            JMP Done
            :
            LDA fingerX ; check finger coords for "Person3" selection
            CMP #15
            BNE :+
            LDA fingerY 
            CMP #12
            BNE :+
            LDA #14
            STA fingerX
            LDA #6
            STA fingerY ; move finger to "Occupation"
            JMP Done
            :
            LDA fingerX ; check finger coords for "Person4" selection
            CMP #15
            BNE :+
            LDA fingerY 
            CMP #14
            BNE :+
            LDA #12
            STA fingerY ; move finger to "Person3"
            JMP Done
            :
            JMP CheckDown
        @menuTyping:
            LDX fingerY
            DEX
            DEX
            LDA keyboardKey
            SEC
            SBC #TEXT_KEYBOARD_LEN
            STA helper
            CPX #16 ; check if fingerY is past top of keyboard
            BNE @moveFingerU
            LDA fingerX
            CMP #23 ; check if we are in last 2 columns
            BCC @wrapFingerU
            LDA #21
            STA fingerX ; wrap to the "DONE" key
            LDA #41
            STA helper
            LDX #24 ; wrap to bottom of keyboard
            JMP @moveFingerU
            @wrapFingerU:
            LDX #24 ; wrap to bottom of keyboard
            LDA keyboardKey
            CLC
            ADC #33
            STA helper
            @moveFingerU:
            STX fingerY
            LDA helper
            STA keyboardKey
            JMP Done
        @menuOccupation:
            LDX fingerY
            DEX
            DEX
            CPX #5 ; check if fingerY is past top of menu
            BNE :+
            LDX #21 ; wrap to bottom of menu
            LDA #8
            STA occupationCursor
            :
            DEC occupationCursor
            STX fingerY
            JMP Done
    CheckDown:
        LDA #KEY_DOWN
        BIT buttons1
        BNE :+
        JMP Done
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_NEWGAME_TYPING
        BNE :+
        JMP @menuTyping
        :
        CMP #MENU_NEWGAME_OCCUPATION
        BNE :+
        JMP @menuOccupation
        :
        JMP Done
        @menuNone:
            LDA fingerX ; check finger coords for "Leader" selection
            CMP #5
            BNE :+
            LDA fingerY 
            CMP #6
            BNE :+
            LDA #12
            STA fingerY ; move finger to "Person1"
            JMP Done
            :
            LDA fingerX ; check finger coords for "Occupation" selection
            CMP #14
            BNE :+
            LDA fingerY 
            CMP #6
            BNE :+
            LDA #15
            STA fingerX
            LDA #12
            STA fingerY ; move finger to "Person3"
            JMP Done
            :
            LDA fingerX ; check finger coords for "Person1" selection
            CMP #5
            BNE :+
            LDA fingerY 
            CMP #12
            BNE :+
            LDA #14
            STA fingerY ; move finger to "Person2"
            JMP Done
            :
            LDA fingerX ; check finger coords for "Person2" selection
            CMP #5
            BNE :+
            LDA fingerY 
            CMP #14
            BNE :+
            LDA #6
            STA fingerY ; move finger to "Leader"
            JMP Done
            :
            LDA fingerX ; check finger coords for "Person3" selection
            CMP #15
            BNE :+
            LDA fingerY 
            CMP #12
            BNE :+
            LDA #14
            STA fingerY ; move finger to "Person4"
            JMP Done
            :
            LDA fingerX ; check finger coords for "Person4" selection
            CMP #15
            BNE Done
            LDA fingerY 
            CMP #14
            BNE Done
            LDA #14
            STA fingerX
            LDA #6
            STA fingerY ; move finger to "Occupation"
            JMP Done
        @menuTyping:
            LDX fingerY
            INX
            INX
            LDA keyboardKey
            CLC
            ADC #11
            STA helper
            CPX #26 ; check if fingerY is past bottom of screen
            BEQ @wrapFingerD
            LDA fingerX
            CMP #23 ; check if fingerX is in "DONE" columns
            BCC @moveFingerD
            CPX #24 ; check if fingerY is in 3rd row
            BNE @moveFingerD
            LDA #21
            STA fingerX
            LDA #41
            STA helper
            JMP @moveFingerD
            @wrapFingerD:
            LDX #18 ; wrap to top of screen
            LDA keyboardKey
            SEC
            SBC #33
            STA helper
            @moveFingerD:
            STX fingerY
            LDA helper
            STA keyboardKey
            JMP Done
        @menuOccupation:
            LDX fingerY
            INX
            INX
            CPX #23 ; check if fingerY is past bottom of menu
            BNE :+
            LDX #7 ; wrap to top of menu
            LDA #$FF
            STA occupationCursor
            :
            INC occupationCursor
            STX fingerY
            JMP Done
    Done:
    RTS
.endproc
        
.proc ControllerStore
    LDA buttons1
    CMP buttons1Last
    BNE CheckA
    JMP Done
    CheckA:
        LDA #KEY_A
        BIT buttons1
        BNE :+
        JMP CheckB
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_STORE_ITEM1
        BNE :+
        JMP @menuItem1
        :
        CMP #MENU_STORE_ITEM2
        BNE :+
        JMP @menuItem2
        :
        CMP #MENU_STORE_ITEM4
        BNE :+
        JMP @menuItem4
        :
        JMP CheckB
        @menuNone:
            LDA fingerY     ; 'Oxen' selected
            CMP #8
            BNE :+
            LDA #MENU_STORE_ITEM2
            STA menuOpen
            JMP Done
            :
            CMP #10         ; 'Clothes' selected
            BNE :+
            LDA #MENU_STORE_ITEM2
            STA menuOpen
            JMP Done
            :
            CMP #12         ; 'Bullets' selected
            BNE :+
            LDA #MENU_STORE_ITEM4
            STA menuOpen
            JMP Done
            :
            CMP #14         ; 'Wheels' selected
            BNE :+
            LDA #MENU_STORE_ITEM1
            STA menuOpen
            JMP Done
            :
            CMP #16         ; 'Axles' selected
            BNE :+
            LDA #MENU_STORE_ITEM1
            STA menuOpen
            JMP Done
            :
            CMP #18         ; 'Tongues' selected
            BNE :+
            LDA #MENU_STORE_ITEM1
            STA menuOpen
            JMP Done
            :
            CMP #20         ; 'lb Food' selected
            BNE :+
            LDA #MENU_STORE_ITEM4
            STA menuOpen
            JMP Done
            :
            JMP Done
        @menuItem1:
        @menuItem2:
        @menuItem4:
            JSR CloseSubmenu
            JMP Done

    CheckB:
        LDA #KEY_B
        BIT buttons1
        BNE :+
        JMP CheckStart
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_STORE_ITEM1
        BNE :+
        JMP @menuItem1
        :
        CMP #MENU_STORE_ITEM2
        BNE :+
        JMP @menuItem2
        :
        CMP #MENU_STORE_ITEM4
        BNE :+
        JMP @menuItem4
        :
        JMP CheckStart
        @menuNone:
            JMP Done
        @menuItem1:
        @menuItem2:
        @menuItem4:
            JSR CloseSubmenu
            JMP Done

    CheckStart:
        LDA #KEY_START
        BIT buttons1
        BNE :+
        JMP CheckLeft
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_STORE_ITEM1
        BNE :+
        JMP @menuItem1
        :
        CMP #MENU_STORE_ITEM2
        BNE :+
        JMP @menuItem2
        :
        CMP #MENU_STORE_ITEM4
        BNE :+
        JMP @menuItem4
        :
        JMP CheckLeft
        @menuNone:
        @menuItem1:
        @menuItem2:
        @menuItem4:
        JMP Done

    CheckLeft:
        LDA #KEY_LEFT
        BIT buttons1
        BNE :+
        JMP CheckRight
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_STORE_ITEM1
        BNE :+
        JMP @menuItem1
        :
        CMP #MENU_STORE_ITEM2
        BNE :+
        JMP @menuItem2
        :
        CMP #MENU_STORE_ITEM4
        BNE :+
        JMP @menuItem4
        :
        JMP CheckRight
        @menuNone:
        @menuItem1:
        @menuItem2:
        @menuItem4:
        JMP Done

    CheckRight:
        LDA #KEY_RIGHT
        BIT buttons1
        BNE :+
        JMP CheckUp
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_STORE_ITEM1
        BNE :+
        JMP @menuItem1
        :
        CMP #MENU_STORE_ITEM2
        BNE :+
        JMP @menuItem2
        :
        CMP #MENU_STORE_ITEM4
        BNE :+
        JMP @menuItem4
        :
        JMP CheckUp
        @menuNone:
        @menuItem1:
        @menuItem2:
        @menuItem4:
        JMP Done

    CheckUp:
        LDA #KEY_UP
        BIT buttons1
        BNE :+
        JMP CheckDown
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_STORE_ITEM1
        BNE :+
        JMP @menuItem1
        :
        CMP #MENU_STORE_ITEM2
        BNE :+
        JMP @menuItem2
        :
        CMP #MENU_STORE_ITEM4
        BNE :+
        JMP @menuItem4
        :
        JMP CheckDown
        @menuNone:
            LDX fingerY
            DEX
            DEX
            CPX #6      ; check if finger is past top of list
            BNE :+
            LDX #20     ; wrap around to bottom
            :
            STX fingerY
            JMP Done
        @menuItem1:
            LDA fingerY
            CMP #14
            BNE :+
            LDA cartSpareParts ; wheels
            AND #%00000011
            TAY
            INY
            TYA
            AND #%00000011
            TAX
            LDA #%11111100
            AND cartSpareParts
            STA cartSpareParts
            TXA
            ORA cartSpareParts
            STA cartSpareParts
            LDA decimalDigits, X
            LDX fingerX
            LDY fingerY
            JSR WriteTileToBuffer
            JMP Done
            :
            CMP #16
            BNE :+
            LDA cartSpareParts ; Axles
            AND #%00001100
            LSR
            LSR
            TAY
            INY
            TYA
            AND #%00000011
            TAX
            CLC
            ROL
            ROL
            LDA #%11110011
            AND cartSpareParts
            STA cartSpareParts
            TXA
            CLC
            ROL
            ROL
            ORA cartSpareParts
            STA cartSpareParts
            LDA decimalDigits, X
            LDX fingerX
            LDY fingerY
            JSR WriteTileToBuffer
            JMP Done
            :
            CMP #18
            BNE :+
            LDA cartSpareParts ; Tongues
            AND #%00110000
            LSR
            LSR
            LSR
            LSR
            TAY
            INY
            TYA
            AND #%00000011
            TAX
            CLC
            ROL
            ROL
            ROL
            ROL
            LDA #%11001111
            AND cartSpareParts
            STA cartSpareParts
            TXA
            CLC
            ROL
            ROL
            ROL
            ROL
            ORA cartSpareParts
            STA cartSpareParts
            LDA decimalDigits, X
            LDX fingerX
            LDY fingerY
            JSR WriteTileToBuffer
            :
            JMP Done
        @menuItem2:
            LDA fingerY
            CMP #8
            BNE :+
            LDX #cartOxenDigit
            JMP @increaseDigit
            :
            CMP #10
            BNE :+
            LDX #cartClothingDigit
            JMP @increaseDigit
            :
            JMP Done
        @menuItem4:
            LDA fingerY
            CMP #12
            BNE :+
            LDX #cartBulletsDigit
            JMP @increaseDigit
            :
            CMP #20
            BNE :+
            LDX #cartFoodLbsDigit
            JMP @increaseDigit
            :
            JMP Done
        @increaseDigit:
            JSR IncreaseDigit 
            JMP Done
    CheckDown:
        LDA #KEY_DOWN
        BIT buttons1
        BNE :+
        JMP Done
        :
        LDA menuOpen
        CMP #MENU_NONE
        BNE :+
        JMP @menuNone
        :
        CMP #MENU_STORE_ITEM1
        BNE :+
        JMP @menuItem1
        :
        CMP #MENU_STORE_ITEM2
        BNE :+
        JMP @menuItem2
        :
        CMP #MENU_STORE_ITEM4
        BNE :+
        JMP @menuItem4
        :
        JMP Done
        @menuNone:
            LDX fingerY
            INX
            INX
            CPX #22     ; check if finger is past bottom of list
            BNE :+
            LDX #8      ; wrap around to top
            :
            STX fingerY
            JMP Done
        @menuItem1:
            LDA fingerY
            CMP #14
            BNE :+
            LDA cartSpareParts ; wheels
            AND #%00000011
            TAY
            DEY
            TYA
            AND #%00000011
            TAX
            LDA #%11111100
            AND cartSpareParts
            STA cartSpareParts
            TXA
            ORA cartSpareParts
            STA cartSpareParts
            LDA decimalDigits, X
            LDX fingerX
            LDY fingerY
            JSR WriteTileToBuffer
            JMP Done
            :
            CMP #16
            BNE :+
            LDA cartSpareParts ; Axles
            AND #%00001100
            LSR
            LSR
            TAY
            DEY
            TYA
            AND #%00000011
            TAX
            CLC
            ROL
            ROL
            LDA #%11110011
            AND cartSpareParts
            STA cartSpareParts
            TXA
            CLC
            ROL
            ROL
            ORA cartSpareParts
            STA cartSpareParts
            LDA decimalDigits, X
            LDX fingerX
            LDY fingerY
            JSR WriteTileToBuffer
            JMP Done
            :
            CMP #18
            BNE :+
            LDA cartSpareParts ; Tongues
            AND #%00110000
            LSR
            LSR
            LSR
            LSR
            TAY
            DEY
            TYA
            AND #%00000011
            TAX
            CLC
            ROL
            ROL
            ROL
            ROL
            LDA #%11001111
            AND cartSpareParts
            STA cartSpareParts
            TXA
            CLC
            ROL
            ROL
            ROL
            ROL
            ORA cartSpareParts
            STA cartSpareParts
            LDA decimalDigits, X
            LDX fingerX
            LDY fingerY
            JSR WriteTileToBuffer
            :
            JMP Done
        @menuItem2:
            LDA fingerY
            CMP #8
            BNE :+
            LDX #cartOxenDigit
            JMP @decreaseDigit
            :
            CMP #10
            BNE :+
            LDX #cartClothingDigit
            JMP @decreaseDigit
            :
            JMP Done
        @menuItem4:
            LDA fingerY
            CMP #12
            BNE :+
            LDX #cartBulletsDigit
            JMP @decreaseDigit
            :
            CMP #20
            BNE :+
            LDX #cartFoodLbsDigit
            JMP @decreaseDigit
            :
            JMP Done
        @decreaseDigit:
            JSR DecreaseDigit 
            JMP Done
    Done:
    RTS
.endproc
        
.proc ControllerStartDate
    RTS
.endproc
        
.proc ControllerLandmark
    RTS
.endproc
        
.proc ControllerMap
    RTS
.endproc

.proc ControllerTraveling
    RTS
.endproc

;--------------------------------------

.proc UpdateSprites
    LDA #$00
    STA OAMADDR ; tell PPU to prepare for transfer to OAM starting at byte zero
    LDA #$02
    STA OAMDMA ; tell PPU to initiate transfer of 256 bytes $0200-$02ff into OAM

    LDA #0
    STA PPUADDR
    STA PPUADDR

    LDA gameState

    CMP #GAMESTATE_TRAVELING
    BEQ Traveling

    CMP #GAMESTATE_TITLE
    BEQ Title

    CMP #GAMESTATE_NEWGAME
    BEQ NewGame

    CMP #GAMESTATE_STORE
    BEQ Store

    CMP #GAMESTATE_STARTDATE
    BEQ StartDate

    CMP #GAMESTATE_LANDMARK
    BEQ Landmark

    CMP #GAMESTATE_MAP
    BEQ Map

    Title:
        JMP Done
        
    NewGame:
        JMP Done
        
    Store:
        JMP Done
        
    StartDate:
        JMP Done
        
    Landmark:
        JMP Done
        
    Map:
        JMP Done

    Traveling:
        LDA frameCounter
        CLC
        ROL
        CMP #$80
        BNE @skipOxenUpdate
        LDA frameCounter
        JSR UpdateOxenSprite
        LDA #$00
    @skipOxenUpdate:
        LDA frameCounter
        CLC
        ROL
        CMP #$00
        BNE @skipWagonUpdate
        JSR UpdateWagonSprite
    @skipWagonUpdate:
        JMP Done

    Done:
    RTS
.endproc

.proc InitOxenSprite
    LDX #0
    @loop:
        LDA oxenSprites, X
        STA OXENSPRITES, X
        INX
        CPX #40
        BNE @loop
    RTS
.endproc

.proc UpdateOxenSprite
    LDA oxenFrame
    CMP #1
    BNE @update
    JSR InitOxenSprite
    @update:
        LDX #1 ; start on tile index
        LDY #0
        STY helper ; use the stack!!!
    @animLoop:
        LDA oxenAnimation, Y
        AND oxenFrame
        CMP #0
        BEQ @skipTileIncrement
        LDA #1
        STA helper
    @skipTileIncrement:
        LDA OXENSPRITES, X
        CLC
        ADC helper
        STA OXENSPRITES, X
        INX
        INX
        INX
        INX
        INY
        LDA #0
        STA helper
        CPX #41
        BNE @animLoop

    ; clear helper
        LDA #0
        STA helper

    ; increment frame
        CLC
        LDA oxenFrame
        ROL
        STA helper
        AND #%00011111
        CMP #0
        BNE @animDone
        LDA #$01 ; reset animation
        STA helper
    @animDone:
        LDA helper
        STA oxenFrame

    RTS
.endproc

.proc InitWagonSprite
    LDX #0
    @loop:
        LDA wagonSprites, X
        STA WAGONSPRITES, X
        INX
        CPX #48
        BNE @loop
    RTS
.endproc

.proc UpdateWagonSprite
    LDA frameCounter
    CMP #$80
    BNE @update
    JSR InitWagonSprite
    JMP @done
    @update:
        LDX #1 ; start on tile index
        LDY #0
    @animLoop:
        LDA WAGONSPRITES, X
        PHA
        CPY #5
        BMI @skipTile
        PLA
        CLC
        ADC #1
        PHA
    @skipTile:
        PLA
        STA WAGONSPRITES, X
        INX
        INX
        INX
        INX
        INY
        CPX #49
        BNE @animLoop
    @done:
    RTS
.endproc

;--------------------------------------