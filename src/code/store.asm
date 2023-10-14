
; .proc LoadBgStore
;     JSR ClearScreen
;     JSR ClearAttributes         ; default palette
;     SBD
;     LDA location
;     CMP #$FF
;     BEQ :++
;     LDX #$FF                    ; calculate address of store name text
;     LDY #$FF
;     :
;     INX
;     LDA landmarkAttr, X
;     BPL :-
;     INY
;     LDA landmarkAttr, X
;     CMP location
;     BEQ :+
;     JMP :-
;     :
;     StoreName:
;         LDA #0
;         STA cartDollars
;         STA cartDollars+1
;         LDY #0
;         LDA PPUSTATUS           ; write store name
;         LDA #$20
;         STA PPUADDR
;         LDA #$64
;         STA PPUADDR
;         :
;         LDA storeNameText, X
;         STA PPUDATA
;         INX
;         INY
;         CPY #TEXT_STORENAME_LEN
;         BNE :-
;         LDX #0                  ; write " GENERAL STORE"
;         LDA #___
;         STA PPUDATA
;         :
;         LDA generalStoreText, X
;         STA PPUDATA
;         INX
;         CPX #13
;         BNE :-
;     ColumnHeaders:
;         LDY #0
;         LDA PPUSTATUS           ; write column headers
;         LDA #$20
;         STA PPUADDR
;         LDA #$C4
;         STA PPUADDR
;         LDX #0
;         :
;         LDA storeColumnHeaderText, X
;         STA PPUDATA
;         INX
;         CPX #4
;         BNE :-
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA
;         :
;         LDA storeColumnHeaderText, X
;         STA PPUDATA
;         INX
;         CPX #8
;         BNE :-
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA
;         STA PPUDATA
;         STA PPUDATA
;         STA PPUDATA
;         :
;         LDA storeColumnHeaderText, X
;         STA PPUDATA
;         INX
;         CPX #12
;         BNE :-
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA
;         :
;         LDA storeColumnHeaderText, X
;         STA PPUDATA
;         INX
;         CPX #16
;         BNE :-
;     Oxen:
;         LDA PPUSTATUS           ; write oxen row
;         LDA #$21
;         STA PPUADDR
;         LDA #$04
;         STA PPUADDR
;         LDA #_UL
;         STA PPUDATA
;         STA PPUDATA
;         LDA cartOxenDigit+2     ; number in Buy column
;         CMP #_0_
;         BNE :+
;         LDA #_UL
;         :
;         STA PPUDATA
;         LDA cartOxenDigit+3
;         STA PPUDATA
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA             ; the word "OXEN"
;         LDY #0
;         LDX #0                  
;         :
;         LDA suppliesText, X
;         STA PPUDATA
;         INX
;         INY
;         CPY #TEXT_SUPPLIES_LEN
;         BNE :-
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA
        
;         ; LDA location            ; calculate price each
;         ; AND #$0F
;         LDA #COST_OXEN
;         JSR DrawShopEach        ; number in Each column
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA
;         LDX #cartOxen
;         LDA #COST_OXEN
;         JSR DrawShopCost        ; number in Cost column
;     Clothes:
;         LDA PPUSTATUS           ; write clothes row
;         LDA #$21
;         STA PPUADDR
;         LDA #$44
;         STA PPUADDR
;         LDA #_UL
;         STA PPUDATA
;         STA PPUDATA
;         LDA cartClothingDigit+2 ; number in Buy column
;         CMP #_0_
;         BNE :+
;         LDA #_UL
;         :
;         STA PPUDATA
;         LDA cartClothingDigit+3
;         STA PPUDATA
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA             ; the word "CLOTHES"
;         LDY #0
;         LDX #7
;         :
;         LDA suppliesText, X
;         STA PPUDATA
;         INX
;         INY
;         CPY #TEXT_SUPPLIES_LEN
;         BNE :-
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA
        
;         ; LDA location            ; calculate price each
;         ; AND #$0F
;         LDA #COST_CLOTHES

;         JSR DrawShopEach        ; number in Each column
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA
;         LDX #cartClothing
;         LDA #COST_CLOTHES
;         JSR DrawShopCost        ; number in Cost column
;     Bullets:
;         LDA PPUSTATUS           ; write bullets row
;         LDA #$21
;         STA PPUADDR
;         LDA #$84
;         STA PPUADDR
;         LDA cartBulletsDigit    ; number in Buy column
;         CMP #_0_
;         BNE :+
;         LDA #_UL
;         :
;         STA PPUDATA
;         LDA cartBulletsDigit+1
;         CMP #_0_
;         BNE :++
;         LDA cartBulletsDigit
;         CMP #_0_
;         BNE :+
;         LDA #_UL
;         JMP :++
;         :
;         LDA #_0_
;         :
;         STA PPUDATA
;         LDA cartBulletsDigit+2
;         STA PPUDATA
;         LDA cartBulletsDigit+3
;         STA PPUDATA
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA             ; the word "bullets"
;         LDY #0
;         LDX #14
;         :
;         LDA suppliesText, X
;         STA PPUDATA
;         INX
;         INY
;         CPY #TEXT_SUPPLIES_LEN
;         BNE :-
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA
        
;         ; LDA location            ; calculate price each
;         ; AND #$0F
;         LDA #COST_BULLETS

;         JSR DrawShopEach        ; number in Each column
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA
;         LDX #cartBullets
;         LDA #COST_BULLETS
;         JSR DrawShopCost        ; number in Cost column
;     Wheels:
;         LDA PPUSTATUS           ; write Wheels row
;         LDA #$21
;         STA PPUADDR
;         LDA #$C4
;         STA PPUADDR
;         LDA #_UL
;         STA PPUDATA
;         STA PPUDATA
;         STA PPUDATA
;         LDA cartSpareParts      ; number in Buy column
;         AND #%00000011
;         TAY
;         LDX #_1_
;         DEX
;         CPY #0
;         BNE :+
;         LDA #_0_
;         STA PPUDATA
;         JMP :++
;         :
;         INX
;         DEY
;         CPY #0
;         BNE :-
;         STX PPUDATA
;         :
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA             ; the word "Wheels"
;         LDY #0
;         LDX #21
;         :
;         LDA suppliesText, X
;         STA PPUDATA
;         INX
;         INY
;         CPY #TEXT_SUPPLIES_LEN
;         BNE :-
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA
        
;         ; LDA location            ; calculate price each
;         ; AND #$0F
;         LDA #COST_PARTS

;         JSR DrawShopEach        ; number in Each column
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA
;         LDA cartSpareParts      ; number in Cost column
;         AND #%00000011
;         STA helper2
;         LDX #helper2
;         LDA #COST_PARTS
;         JSR DrawShopCost
;     Axles:
;         LDA PPUSTATUS           ; write Axles row
;         LDA #$22
;         STA PPUADDR
;         LDA #$04
;         STA PPUADDR
;         LDA #_UL
;         STA PPUDATA
;         STA PPUDATA
;         STA PPUDATA
;         LDA cartSpareParts      ; number in Buy column
;         LSR
;         LSR
;         AND #%00000011
;         TAY
;         LDX #_1_
;         DEX
;         CPY #0
;         BNE :+
;         LDA #_0_
;         STA PPUDATA
;         JMP :++
;         :
;         INX
;         DEY
;         CPY #0
;         BNE :-
;         STX PPUDATA
;         :
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA             ; the word "Axles"
;         LDY #0
;         LDX #28
;         :
;         LDA suppliesText, X
;         STA PPUDATA
;         INX
;         INY
;         CPY #TEXT_SUPPLIES_LEN
;         BNE :-
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA
        
;         ; LDA location            ; calculate price each
;         ; AND #$0F
;         LDA #COST_PARTS

;         JSR DrawShopEach        ; number in Each column
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA
;         LDA cartSpareParts      ; number in Cost column
;         LSR
;         LSR
;         AND #%00000011
;         STA helper2
;         LDX #helper2
;         LDA #COST_PARTS
;         JSR DrawShopCost
;     Tongues:
;         LDA PPUSTATUS           ; write Tongues row
;         LDA #$22
;         STA PPUADDR
;         LDA #$44
;         STA PPUADDR
;         LDA #_UL
;         STA PPUDATA
;         STA PPUDATA
;         STA PPUDATA
;         LDA cartSpareParts      ; number in Buy column
;         LSR
;         LSR
;         LSR
;         LSR
;         AND #%00000011
;         TAY
;         LDX #_1_
;         DEX
;         CPY #0
;         BNE :+
;         LDA #_0_
;         STA PPUDATA
;         JMP :++
;         :
;         INX
;         DEY
;         CPY #0
;         BNE :-
;         STX PPUDATA
;         :
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA             ; the word "Tongues"
;         LDY #0
;         LDX #35
;         :
;         LDA suppliesText, X
;         STA PPUDATA
;         INX
;         INY
;         CPY #TEXT_SUPPLIES_LEN
;         BNE :-
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA
        
;         ; LDA location            ; calculate price each
;         ; AND #$0F
;         LDA #COST_PARTS

;         JSR DrawShopEach        ; number in Each column
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA
;         LDA cartSpareParts      ; number in Cost column
;         LSR
;         LSR
;         LSR
;         LSR
;         AND #%00000011
;         STA helper2
;         LDX #helper2
;         LDA #COST_PARTS
;         JSR DrawShopCost
;     Food:
;         LDA PPUSTATUS           ; write Food row
;         LDA #$22
;         STA PPUADDR
;         LDA #$84
;         STA PPUADDR
;         LDA cartFoodLbsDigit    ; number in Buy column
;         CMP #_0_
;         BNE :+
;         LDA #_UL
;         :
;         STA PPUDATA
;         LDA cartFoodLbsDigit+1
;         CMP #_0_
;         BNE :++
;         LDA cartFoodLbsDigit
;         CMP #_0_
;         BNE :+
;         LDA #_UL
;         JMP :++
;         :
;         LDA #_0_
;         :
;         STA PPUDATA
;         LDA cartFoodLbsDigit+2
;         STA PPUDATA
;         LDA cartFoodLbsDigit+3
;         STA PPUDATA
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA             ; the word "Food"
;         LDY #0
;         LDX #42
;         :
;         LDA suppliesText, X
;         STA PPUDATA
;         INX
;         INY
;         CPY #TEXT_SUPPLIES_LEN
;         BNE :-
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA
        
;         ; LDA location            ; calculate price each
;         ; AND #$0F
;         LDA #COST_FOOD_LB

;         JSR DrawShopEach        ; number in Each column
;         LDA #___
;         STA PPUDATA
;         STA PPUDATA
;         LDX #cartFoodLbs
;         LDA #COST_FOOD_LB
;         JSR DrawShopCost
;     Total:
;         LDA PPUSTATUS           ; write Total:
;         LDA #$22
;         STA PPUADDR
;         LDA #$EE
;         STA PPUADDR
;         LDX #0
;         :
;         LDA storeTotalText, X
;         STA PPUDATA
;         INX
;         CPX #9
;         BNE :-
;         LDA #___
;         STA PPUDATA
;         JSR DrawShopTotal
;     YouHave:
;         LDA PPUSTATUS           ; write You Have: 
;         LDA #$23
;         STA PPUADDR
;         LDA #$6E
;         STA PPUADDR
;         LDX #9
;         :
;         LDA storeTotalText, X
;         STA PPUDATA
;         INX
;         CPX #18
;         BNE :-
;         LDA #___
;         STA PPUDATA
;         LDA #_DL
;         STA PPUDATA
;         LDA dollarsDigit
;         STA PPUDATA
;         LDA dollarsDigit+1
;         STA PPUDATA
;         LDA dollarsDigit+2
;         STA PPUDATA
;         LDA dollarsDigit+3
;         STA PPUDATA
;         LDA #_00
;         STA PPUDATA
;     Done:
;     EBD
;     RTS
; .endproc

; .proc DrawShopEach
;     ; A: value to convert to two decimal text digits
;     ; destroys X,Y registers
;     ; Return: helper,helper+1 - resulting digits
;     STA helper
;     ROL
;     LSR
;     LDX #_DL
;     STX PPUDATA
;     BIT helper
;     BPL TwoDigits
;     LDX #_PD
;     STX PPUDATA
;     CMP #1
;     BCS OneDigit
;     LDX #_0_
;     STX PPUDATA
;     JMP Done
;     OneDigit:
;     TAX
;     DEX
;     TXA
;     CLC
;     ADC #_1_
;     STA PPUDATA
;     LDX #_0_
;     STX PPUDATA
;     JMP Done
;     TwoDigits:
;     LDY #0
;     LDX #_1_
;     DEX
;     :
;     INY
;     DEC helper
;     CPY #10
;     BNE :-
;     INX
;     LDY #0
;     LDA helper
;     CMP #10
;     BCS :-
;     STX PPUDATA
;     LDA helper
;     CMP #1
;     BCS :+
;     LDX #_0_
;     STX PPUDATA
;     LDX #_00
;     STX PPUDATA
;     JMP Done
;     :
;     LDX #_1_
;     DEX
;     :
;     INX
;     DEC helper
;     LDA helper
;     CMP #0
;     BCS :-
;     Done:
;     RTS
; .endproc

; .proc DrawShopCost
;     ; X: address of amount in cart
;     ; A: cost each -> cost
;     ; helper: total tally in dollars
;     ; helper2: might be the address of amount in cart, don't touch
;     ; cartHelperDigit: total tally in dollars
;     STX pointer
;     LDY #0
;     STY pointer+1
;     AND #$7F
;     STA cost
;     LDA #_DL        ; draw dollar sign
;     STA PPUDATA
;     LDA #_0_
;     STA cartHelperDigit
;     LDA #0          ; helper: total tally in dollars
;     STA helper
;     STA helper+1
;     LDA (pointer), Y
;     CMP #0          ; is cart empty?
;     BNE :+
;     LDA #_UL
;     STA PPUDATA
;     STA PPUDATA
;     LDA #_0_
;     STA PPUDATA
;     STA cartHelperDigit+1
;     STA cartHelperDigit+2
;     STA cartHelperDigit+3
;     JMP Done
;     :               ; cart not empty
;     TAX
;     :
;     CLC
;     LDA helper
;     ADC cost
;     STA helper
;     LDA helper+1
;     ADC #$00
;     STA helper+1
;     DEX
;     CPX #0
;     BNE :-
;     LDA #_0_            ; convert helper to decimal digits
;     STA keyboardKey
;     STA cartHelperDigit+1
;     :
;     LDA helper+1
;     CMP #0              ; is helper >= $0100 (256)?
;     BNE :+
;     LDA helper
;     CMP #$64            ; is helper >= $0064 (100)?
;     BCC :++
;     :
;     SEC                 ; subtract $0064 (100)
;     LDA helper
;     SBC #$64
;     STA helper
;     LDA helper+1
;     SBC #$00
;     STA helper+1
;     INC keyboardKey
;     INC cartHelperDigit+1
;     JMP :--
;     :
;     LDA keyboardKey
;     CMP #_0_
;     BNE :+
;     LDA #_UL
;     :
;     STA PPUDATA         ; draw 100s place digit
;     LDA #_0_
;     STA keyboardKey
;     STA cartHelperDigit+2
;     :
;     LDA helper
;     CMP #10             ; is helper >= 10?
;     BCC :+
;     SEC                 ; subtract 10
;     LDA helper
;     SBC #10
;     STA helper
;     LDA helper+1
;     SBC #0
;     STA helper+1
;     INC keyboardKey
;     INC cartHelperDigit+2
;     JMP :-
;     :
;     LDA keyboardKey
;     STA PPUDATA         ; draw 10s place digit
;     LDX helper
;     LDA decimalDigits, X    ; draw 1s place digit
;     STA PPUDATA
;     STA cartHelperDigit+3
;     Done:
;     LDA #_00            ; draw ".00"
;     STA PPUDATA
;     LDX #cartHelperDigit
;     LDA cartDollars
;     STA costhelper
;     LDA cartDollars+1
;     STA costhelper
;     LDY #costhelper
;     JSR SetValueFromDigit
;     CLC
;     LDA cartDollars
;     ADC costhelper
;     STA cartDollars
;     LDA cartDollars+1
;     ADC costhelper+1
;     STA cartDollars+1
;     LDX #cartDollarsDigit
;     LDY #cartDollars
;     JSR SetDigitFromValue
;     RTS
; .endproc

; .proc DrawShopTotal
;     LDA #_DL
;     STA PPUDATA
;     LDA cartDollarsDigit
;     STA PPUDATA
;     LDA cartDollarsDigit+1
;     STA PPUDATA
;     LDA cartDollarsDigit+2
;     STA PPUDATA
;     LDA cartDollarsDigit+3
;     STA PPUDATA
;     LDA #_00
;     STA PPUDATA
;     RTS
; .endproc

; .proc GamepadStore
;     LDA buttons1
;     CMP buttons1Last
;     BNE CheckA
;     RTS
;     CheckA:
;         LDA #KEY_A
;         BIT buttons1
;         BNE :+
;         JMP CheckB
;         :
;         LDA menuOpen
;         CMP #MENU_NONE
;         BNE :+
;         JMP @menuNone
;         :
;         CMP #MENU_STORE_ITEM1
;         BNE :+
;         JMP @menuItem1
;         :
;         CMP #MENU_STORE_ITEM2
;         BNE :+
;         JMP @menuItem2
;         :
;         CMP #MENU_STORE_ITEM4
;         BNE :+
;         JMP @menuItem4
;         :
;         JMP CheckB
;         @menuNone:
;             LDA fingerY     ; 'Oxen' selected
;             CMP #8
;             BNE :+
;             LDA #MENU_STORE_ITEM2
;             STA menuOpen
;             RTS
;             :
;             CMP #10         ; 'Clothes' selected
;             BNE :+
;             LDA #MENU_STORE_ITEM2
;             STA menuOpen
;             RTS
;             :
;             CMP #12         ; 'Bullets' selected
;             BNE :+
;             LDA #MENU_STORE_ITEM4
;             STA menuOpen
;             RTS
;             :
;             CMP #14         ; 'Wheels' selected
;             BNE :+
;             LDA #MENU_STORE_ITEM1
;             STA menuOpen
;             RTS
;             :
;             CMP #16         ; 'Axles' selected
;             BNE :+
;             LDA #MENU_STORE_ITEM1
;             STA menuOpen
;             RTS
;             :
;             CMP #18         ; 'Tongues' selected
;             BNE :+
;             LDA #MENU_STORE_ITEM1
;             STA menuOpen
;             RTS
;             :
;             CMP #20         ; 'lb Food' selected
;             BNE :+
;             LDA #MENU_STORE_ITEM4
;             STA menuOpen
;             RTS
;             :
;             RTS
;         @menuItem1:
;         @menuItem2:
;         @menuItem4:
;             JSR CloseSubmenu
;             RTS

;     CheckB:
;         LDA #KEY_B
;         BIT buttons1
;         BNE :+
;         JMP CheckStart
;         :
;         LDA menuOpen
;         CMP #MENU_NONE
;         BNE :+
;         JMP @menuNone
;         :
;         CMP #MENU_STORE_ITEM1
;         BNE :+
;         JMP @menuItem1
;         :
;         CMP #MENU_STORE_ITEM2
;         BNE :+
;         JMP @menuItem2
;         :
;         CMP #MENU_STORE_ITEM4
;         BNE :+
;         JMP @menuItem4
;         :
;         JMP CheckStart
;         @menuNone:
;             RTS
;         @menuItem1:
;         @menuItem2:
;         @menuItem4:
;             JSR CloseSubmenu
;             RTS

;     CheckStart:
;         LDA #KEY_START
;         BIT buttons1
;         BNE :+
;         JMP CheckLeft
;         :
;         LDA menuOpen
;         CMP #MENU_NONE
;         BNE :+
;         JMP @menuNone
;         :
;         CMP #MENU_STORE_ITEM1
;         BNE :+
;         JMP @menuItem1
;         :
;         CMP #MENU_STORE_ITEM2
;         BNE :+
;         JMP @menuItem2
;         :
;         CMP #MENU_STORE_ITEM4
;         BNE :+
;         JMP @menuItem4
;         :
;         JMP CheckLeft
;         @menuNone:
;             JSR ValidateCart
;             CMP #1
;             BEQ :+
;             RTS
;             :
;             JSR DoStorePurchase
;             LDA #GAMESTATE_LANDMARK
;             STA gameState
;             RTS
;         @menuItem1:
;         @menuItem2:
;         @menuItem4:
;         RTS

;     CheckLeft:
;         LDA #KEY_LEFT
;         BIT buttons1
;         BNE :+
;         JMP CheckRight
;         :
;         LDA menuOpen
;         CMP #MENU_NONE
;         BNE :+
;         JMP @menuNone
;         :
;         CMP #MENU_STORE_ITEM1
;         BNE :+
;         JMP @menuItem1
;         :
;         CMP #MENU_STORE_ITEM2
;         BNE :+
;         JMP @menuItem2
;         :
;         CMP #MENU_STORE_ITEM4
;         BNE :+
;         JMP @menuItem4
;         :
;         JMP CheckRight
;         @menuNone:
;         @menuItem1:
;             RTS
;         @menuItem2:
;             LDX fingerX
;             DEX
;             CPX #5      ; check if finger is too far left
;             BNE :+
;             LDX #7     ; wrap around to right
;             :
;             STX fingerX
;             RTS
;         @menuItem4:
;             LDX fingerX
;             DEX
;             CPX #3      ; check if finger is too far left
;             BNE :+
;             LDX #6     ; wrap around to right
;             :
;             STX fingerX
;             RTS
;         RTS

;     CheckRight:
;         LDA #KEY_RIGHT
;         BIT buttons1
;         BNE :+
;         JMP CheckUp
;         :
;         LDA menuOpen
;         CMP #MENU_NONE
;         BNE :+
;         JMP @menuNone
;         :
;         CMP #MENU_STORE_ITEM1
;         BNE :+
;         JMP @menuItem1
;         :
;         CMP #MENU_STORE_ITEM2
;         BNE :+
;         JMP @menuItem2
;         :
;         CMP #MENU_STORE_ITEM4
;         BNE :+
;         JMP @menuItem4
;         :
;         JMP CheckUp
;         @menuNone:
;         @menuItem1:
;             RTS
;         @menuItem2:
;             LDX fingerX
;             INX
;             CPX #8      ; check if finger is too far right
;             BNE :+
;             LDX #6     ; wrap around to left
;             :
;             STX fingerX
;             RTS
;         @menuItem4:
;             LDX fingerX
;             INX
;             CPX #7      ; check if finger is too far right
;             BNE :+
;             LDX #4     ; wrap around to left
;             :
;             STX fingerX
;             RTS
;         RTS

;     CheckUp:
;         LDA #KEY_UP
;         BIT buttons1
;         BNE :+
;         JMP CheckDown
;         :
;         LDA menuOpen
;         CMP #MENU_NONE
;         BNE :+
;         JMP @menuNone
;         :
;         CMP #MENU_STORE_ITEM1
;         BNE :+
;         JMP @menuItem1
;         :
;         CMP #MENU_STORE_ITEM2
;         BNE :+
;         JMP @menuItem2
;         :
;         CMP #MENU_STORE_ITEM4
;         BNE :+
;         JMP @menuItem4
;         :
;         JMP CheckDown
;         @menuNone:
;             LDX fingerY
;             DEX
;             DEX
;             CPX #6      ; check if finger is past top of list
;             BNE :+
;             LDX #20     ; wrap around to bottom
;             :
;             STX fingerY
;             RTS
;         @menuItem1:
;             LDA fingerY
;             CMP #14
;             BNE :+
;             LDA cartSpareParts ; wheels
;             AND #%00000011
;             TAY
;             INY
;             TYA
;             AND #%00000011
;             TAX
;             LDA #%11111100
;             AND cartSpareParts
;             STA cartSpareParts
;             TXA
;             ORA cartSpareParts
;             STA cartSpareParts
;             LDA decimalDigits, X
;             LDX fingerX
;             LDY fingerY
;             JSR WriteTileToBuffer
;             RTS
;             :
;             CMP #16
;             BNE :+
;             LDA cartSpareParts ; Axles
;             AND #%00001100
;             LSR
;             LSR
;             TAY
;             INY
;             TYA
;             AND #%00000011
;             TAX
;             CLC
;             ROL
;             ROL
;             LDA #%11110011
;             AND cartSpareParts
;             STA cartSpareParts
;             TXA
;             CLC
;             ROL
;             ROL
;             ORA cartSpareParts
;             STA cartSpareParts
;             LDA decimalDigits, X
;             LDX fingerX
;             LDY fingerY
;             JSR WriteTileToBuffer
;             RTS
;             :
;             CMP #18
;             BNE :+
;             LDA cartSpareParts ; Tongues
;             AND #%00110000
;             LSR
;             LSR
;             LSR
;             LSR
;             TAY
;             INY
;             TYA
;             AND #%00000011
;             TAX
;             CLC
;             ROL
;             ROL
;             ROL
;             ROL
;             LDA #%11001111
;             AND cartSpareParts
;             STA cartSpareParts
;             TXA
;             CLC
;             ROL
;             ROL
;             ROL
;             ROL
;             ORA cartSpareParts
;             STA cartSpareParts
;             LDA decimalDigits, X
;             LDX fingerX
;             LDY fingerY
;             JSR WriteTileToBuffer
;             :
;             RTS
;         @menuItem2:
;             LDA fingerY
;             CMP #8
;             BNE :+
;             LDX #COST_OXEN
;             STX cost
;             LDX #cartOxenDigit
;             JSR IncreaseDigit
;             LDX #cartOxenDigit
;             LDY #COST_OXEN
;             STY cost
;             LDY #cartOxen
;             JSR SetCartFromDigit
;             RTS
;             :
;             CMP #10
;             BNE :+
;             LDX #COST_CLOTHES
;             STX cost
;             LDX #cartClothingDigit
;             JSR IncreaseDigit
;             LDX #cartClothingDigit
;             LDY #COST_CLOTHES
;             STY cost
;             LDY #cartClothing
;             JSR SetCartFromDigit
;             :
;             RTS
;         @menuItem4:
;             LDA fingerY
;             CMP #12
;             BNE :+
;             LDX #COST_BULLETS
;             STX cost
;             LDX #cartBulletsDigit
;             JSR IncreaseDigit
;             LDX #cartBulletsDigit
;             LDY #COST_BULLETS
;             STY cost
;             LDY #cartBullets
;             JSR SetCartFromDigit
;             RTS
;             :
;             CMP #20
;             BNE :+
;             LDX #COST_FOOD_LB
;             STX cost
;             LDX #cartFoodLbsDigit
;             JSR IncreaseDigit
;             LDX #cartFoodLbsDigit
;             LDY #COST_FOOD_LB
;             STY cost
;             LDY #cartFoodLbs
;             JSR SetCartFromDigit
;             :
;             RTS
;     CheckDown:
;         LDA #KEY_DOWN
;         BIT buttons1
;         BNE :+
;         RTS
;         :
;         LDA menuOpen
;         CMP #MENU_NONE
;         BNE :+
;         JMP @menuNone
;         :
;         CMP #MENU_STORE_ITEM1
;         BNE :+
;         JMP @menuItem1
;         :
;         CMP #MENU_STORE_ITEM2
;         BNE :+
;         JMP @menuItem2
;         :
;         CMP #MENU_STORE_ITEM4
;         BNE :+
;         JMP @menuItem4
;         :
;         RTS
;         @menuNone:
;             LDX fingerY
;             INX
;             INX
;             CPX #22     ; check if finger is past bottom of list
;             BNE :+
;             LDX #8      ; wrap around to top
;             :
;             STX fingerY
;             RTS
;         @menuItem1:
;             LDA fingerY
;             CMP #14
;             BNE :+
;             LDA cartSpareParts ; wheels
;             AND #%00000011
;             TAY
;             DEY
;             TYA
;             AND #%00000011
;             TAX
;             LDA #%11111100
;             AND cartSpareParts
;             STA cartSpareParts
;             TXA
;             ORA cartSpareParts
;             STA cartSpareParts
;             LDA decimalDigits, X
;             LDX fingerX
;             LDY fingerY
;             JSR WriteTileToBuffer
;             RTS
;             :
;             CMP #16
;             BNE :+
;             LDA cartSpareParts ; Axles
;             AND #%00001100
;             LSR
;             LSR
;             TAY
;             DEY
;             TYA
;             AND #%00000011
;             TAX
;             CLC
;             ROL
;             ROL
;             LDA #%11110011
;             AND cartSpareParts
;             STA cartSpareParts
;             TXA
;             CLC
;             ROL
;             ROL
;             ORA cartSpareParts
;             STA cartSpareParts
;             LDA decimalDigits, X
;             LDX fingerX
;             LDY fingerY
;             JSR WriteTileToBuffer
;             RTS
;             :
;             CMP #18
;             BNE :+
;             LDA cartSpareParts ; Tongues
;             AND #%00110000
;             LSR
;             LSR
;             LSR
;             LSR
;             TAY
;             DEY
;             TYA
;             AND #%00000011
;             TAX
;             CLC
;             ROL
;             ROL
;             ROL
;             ROL
;             LDA #%11001111
;             AND cartSpareParts
;             STA cartSpareParts
;             TXA
;             CLC
;             ROL
;             ROL
;             ROL
;             ROL
;             ORA cartSpareParts
;             STA cartSpareParts
;             LDA decimalDigits, X
;             LDX fingerX
;             LDY fingerY
;             JSR WriteTileToBuffer
;             :
;             RTS
;         @menuItem2:
;             LDA fingerY
;             CMP #8
;             BNE :+
;             LDX #COST_OXEN
;             STX cost
;             LDX #cartOxenDigit
;             JSR DecreaseDigit
;             LDX #cartOxenDigit
;             LDY #COST_OXEN
;             STY cost
;             LDY #cartOxen
;             JSR SetCartFromDigit
;             RTS
;             :
;             CMP #10
;             BNE :+
;             LDX #COST_CLOTHES
;             STX cost
;             LDX #cartClothingDigit
;             JSR DecreaseDigit
;             LDX #cartClothingDigit
;             LDY #COST_CLOTHES
;             STY cost
;             LDY #cartClothing
;             JSR SetCartFromDigit
;             :
;             RTS
;         @menuItem4:
;             LDA fingerY
;             CMP #12
;             BNE :+
;             LDX #COST_BULLETS
;             STX cost
;             LDX #cartBulletsDigit
;             JSR DecreaseDigit
;             LDX #cartBulletsDigit
;             LDY #COST_BULLETS
;             STY cost
;             LDY #cartBullets
;             JSR SetCartFromDigit
;             RTS
;             :
;             CMP #20
;             BNE :+
;             LDX #COST_FOOD_LB
;             STX cost
;             LDX #cartFoodLbsDigit
;             JSR DecreaseDigit
;             LDX #cartFoodLbsDigit
;             LDY #COST_FOOD_LB
;             STY cost
;             LDY #cartFoodLbs
;             JSR SetCartFromDigit
;             :
;             RTS
;     RTS
; .endproc

; .proc ValidateCart
;     ; return A = 1 or 0 if cart is valid
;     ;   Invalid: cart+inv exceeds wagon capacity, cost exceeds wallet
;     ;       Capacity- wheels/axles/tongues: 3
;     ; TODO: food 2000lb, bullets 2000, clothing 99?, oxen ~20?
;     LDA dollars+1   ; can we afford it?
;     CMP cartDollars+1
;     BCC :+ ; branch if dollars high byte < cartDollars high byte
;     BEQ :++ ; branch if dollars high byte = cartDollars high byte
;     JMP :+++
;     : 
;     LDA #0 ; not enough money
;     JMP Done
;     : ; dollars high byte = cartDollars high byte
;     LDA dollars
;     CMP cartDollars
;     BCS :+ ; branch if dollars low byte >= cartDollars low byte
;     JMP :--
;     :
;     LDA cartSpareParts
;     AND #%00000011
;     STA helper
;     LDA spareParts
;     AND #%00000011
;     CLC
;     ADC helper
;     CMP #4
;     BCC :+
;     LDA #0 ; too many wheels
;     JMP Done
;     :
;     LDA cartSpareParts
;     AND #%00001100
;     LSR
;     LSR
;     STA helper
;     LDA spareParts
;     AND #%00001100
;     LSR
;     LSR
;     CLC
;     ADC helper
;     CMP #4
;     BCC :+
;     LDA #0
;     JMP Done
;     :
;     LDA cartSpareParts
;     AND #%00110000
;     LSR
;     LSR
;     LSR
;     LSR
;     STA helper
;     LDA spareParts
;     AND #%00110000
;     LSR
;     LSR
;     LSR
;     LSR
;     CLC
;     ADC helper
;     CMP #4
;     BCC :+
;     LDA #0
;     JMP Done
;     :
;     LDA #1
;     Done:
;     RTS
; .endproc

; .proc DoStorePurchase
;     SEC                     ; dollars
;     LDA dollars
;     SBC cartDollars
;     STA dollars
;     LDA dollars+1
;     SBC cartDollars+1
;     STA dollars+1
;     LDX #dollarsDigit
;     LDY #dollars
;     JSR SetDigitFromValue
;     CLC                     ; oxen
;     LDA oxenHeadcount
;     ADC cartOxen
;     STA oxenHeadcount
;     LDX #oxenDigit
;     LDY #oxenHeadcount
;     JSR SetDigitFromValue
;     CLC                     ; clothing
;     LDA clothing
;     ADC cartClothing
;     STA clothing
;     LDX #clothingDigit
;     LDY #clothing
;     JSR SetDigitFromValue
;     LDA cartSpareParts      ; wheels
;     AND #%00000011
;     STA helper
;     LDA spareParts
;     AND #%00000011
;     CLC
;     ADC helper
;     STA helper
;     LDA spareParts
;     AND #%11111100
;     CLC
;     ADC helper
;     STA spareParts
;     LDA cartSpareParts      ; axles
;     AND #%00001100
;     STA helper
;     LDA spareParts
;     AND #%00001100
;     CLC
;     ADC helper
;     STA helper
;     LDA spareParts
;     AND #%11110011
;     CLC
;     ADC helper
;     STA spareParts
;     LDA cartSpareParts      ; tongues
;     AND #%00110000
;     STA helper
;     LDA spareParts
;     AND #%00110000
;     CLC
;     ADC helper
;     STA helper
;     LDA spareParts
;     AND #%11001111
;     CLC
;     ADC helper
;     STA spareParts
;     LDX cartBullets             ; bullets- x10
;     :
;     CPX #0
;     BEQ :+
;     CLC
;     LDA bullets
;     ADC #10
;     STA bullets
;     LDA bullets+1
;     ADC #0
;     STA bullets+1
;     DEX
;     JMP :-
;     :
;     LDX #bulletsDigit
;     LDY #bullets
;     JSR SetDigitFromValue
;     LDX cartFoodLbs             ; food lbs- x10
;     :
;     CPX #0
;     BEQ :+
;     CLC
;     LDA foodLbs
;     ADC #10
;     STA foodLbs
;     LDA foodLbs+1
;     ADC #0
;     STA foodLbs+1
;     DEX
;     JMP :-
;     :
;     LDX #foodLbsDigit
;     LDY #foodLbs
;     JSR SetDigitFromValue
;     LDA #0                  ; empty cart
;     STA helper
;     STA helper+1
;     STA cartBullets
;     STA cartBullets+1
;     STA cost
;     STA cost+1
;     STA costhelper
;     STA costhelper+1
;     STA cartFoodLbs
;     STA cartFoodLbs+1
;     STA cartSpareParts
;     STA cartClothing
;     STA cartOxen
;     STA cartDollars
;     STA cartDollars+1
;     RTS
; .endproc

; .proc SetValueFromDigit
;     ; X: address of digits to reference (4 bytes)
;     ; Y: ZP address of value (2 bytes)
;     STX helper      ; helper: address of digit
;     LDX #0
;     STX helper+1
;     STY pointer     ; pointer: address of value
;     LDY #0
;     STY pointer+1
;     LDA #0          ; clear value
;     STA (pointer), Y
;     INY
;     STA (pointer), Y
;     Thousands:
;         LDY #0
;         SEC
;         LDA (helper), Y
;         SBC #_0_
;         CMP #0
;         BNE :+
;         JMP Hundreds
;         :
;         TAX
;         :
;         LDY #0
;         CLC
;         LDA (pointer), Y
;         ADC #$E8
;         STA (pointer), Y
;         INY
;         LDA (pointer), Y
;         ADC #$03
;         STA (pointer), Y
;         DEX
;         CPX #0
;         BNE :-
;     Hundreds:
;         LDY #1
;         SEC
;         LDA (helper), Y
;         SBC #_0_
;         CMP #0
;         BNE :+
;         JMP Tens
;         :
;         TAX
;         :
;         LDY #0
;         CLC
;         LDA (pointer), Y
;         ADC #$64
;         STA (pointer), Y
;         INY
;         LDA (pointer), Y
;         ADC #$00
;         STA (pointer), Y
;         DEX
;         CPX #0
;         BNE :-
;     Tens:
;         LDY #2
;         SEC
;         LDA (helper), Y
;         SBC #_0_
;         CMP #0
;         BNE :+
;         JMP Ones
;         :
;         TAX
;         :
;         LDY #0
;         CLC
;         LDA (pointer), Y
;         ADC #$0A
;         STA (pointer), Y
;         INY
;         LDA (pointer), Y
;         ADC #$00
;         STA (pointer), Y
;         DEX
;         CPX #0
;         BNE :-
;     Ones:
;         LDY #3
;         SEC
;         LDA (helper), Y
;         SBC #_0_
;         CMP #0
;         BNE :+
;         JMP Done
;         :
;         TAX
;         :
;         LDY #0
;         CLC
;         LDA (pointer), Y
;         ADC #$01
;         STA (pointer), Y
;         INY
;         LDA (pointer), Y
;         ADC #$00
;         STA (pointer), Y
;         DEX
;         CPX #0
;         BNE :-
;     Done:
;     RTS
; .endproc

; .proc SetCartFromDigit
;     ; X: address of digits to reference (4 bytes)
;     ; Y: ZP address of cart value (1 byte)
;     ; cost+0: bit 7: unit- 0:dollars, 1:cents
;     TYA
;     PHA
;     BIT cost
;     BPL :+
;     LDA #_0_
;     STA cartHelperDigit
;     STX pointer
;     LDY #0
;     STY pointer+1
;     LDA (pointer), Y
;     STA cartHelperDigit+1
;     INY
;     LDA (pointer), Y
;     STA cartHelperDigit+2
;     INY
;     LDA (pointer), Y
;     STA cartHelperDigit+3
;     LDX #cartHelperDigit
;     :
;     LDY #costhelper
;     JSR SetValueFromDigit
;     LDY #0
;     PLA
;     STA pointer
;     STY pointer+1
;     LDA costhelper
;     STA (pointer), Y

;     RTS
; .endproc
