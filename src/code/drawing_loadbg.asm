
.proc LoadDefaultCHR
    JSR StartBulkDrawing
    LDY #0
    JSR bankswitch_y
    LDA #<tiles_chr
    STA pointer
    LDA #>tiles_chr
    STA pointer+1
    JSR CopyCHRTiles
    LDY #1          ; switch rom bank to default image data
    JSR bankswitch_y
    JSR DoneBulkDrawing
    JSR UpdatePalette
    RTS
.endproc

.proc LoadBgTitle
    JSR ClearAttributes ; default palette
    ;JSR BufferDrawTitle

    JSR StartBulkDrawing ; draw adornments
    LDY #6
    JSR bankswitch_y
    JSR DrawAdornments
    JSR DrawTitleLogo
    LDY #1
    JSR bankswitch_y
    JSR DoneBulkDrawing
    JSR BufferDrawTitleOptions

    LDA #%10010000
    STA softPPUCTRL         ; Ensure NMIs are enabled
    LDA #%00011110 
    STA softPPUMASK         ; turn on screen
    RTS
.endproc

.proc LoadBgNewGame
    JSR ClearScreen
    JSR ClearAttributes ; default palette
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
    StartingDate:
        LDA PPUSTATUS
        LDA #$22
        STA PPUADDR
        LDA #$45
        STA PPUADDR
        LDX #38
        :               ; draw "STARTING DATE:"
        LDA newGameText, X
        STA PPUDATA
        INX
        CPX #52
        BNE :-
        LDA PPUSTATUS   ; draw the month name
        LDA #$22
        STA PPUADDR
        LDA #$87
        STA PPUADDR
        LDA dateMonth
        CMP #3
        BNE :+
        LDA #0
        JMP @doLoop
        :
        CMP #4
        BNE :+
        LDA #12
        JMP @doLoop
        :
        CMP #5
        BNE :+
        LDA #24
        JMP @doLoop
        :
        CMP #6
        BNE :+
        LDA #6
        JMP @doLoop
        :
        CMP #7
        BNE :+
        LDA #18
        JMP @doLoop
        :
        CMP #8
        BNE :+
        LDA #30
        :
        @doLoop:
        TAX 
        LDY #0
        :
        LDA startingDateText, X
        STA PPUDATA
        INX
        INY
        CPY #TEXT_STARTDATE_LEN
        BNE :-

    JSR DoneBulkDrawing
    RTS
.endproc

.proc LoadBgStore
    JSR ClearScreen
    JSR ClearAttributes         ; default palette
    JSR StartBulkDrawing
    LDA location
    CMP #$FF
    BEQ :++
    LDX #$FF                    ; calculate address of store name text
    LDY #$FF
    :
    INX
    LDA landmarkAttr, X
    BPL :-
    INY
    LDA landmarkAttr, X
    CMP location
    BEQ :+
    JMP :-
    :
    StoreName:
        LDA #0
        STA cartDollars
        STA cartDollars+1
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
        LDA #_UL
        STA PPUDATA
        STA PPUDATA
        LDA cartOxenDigit+2     ; number in Buy column
        CMP #_0_
        BNE :+
        LDA #_UL
        :
        STA PPUDATA
        LDA cartOxenDigit+3
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
        LDX #cartOxen
        LDA #COST_OXEN
        JSR DrawShopCost        ; number in Cost column
    Clothes:
        LDA PPUSTATUS           ; write clothes row
        LDA #$21
        STA PPUADDR
        LDA #$44
        STA PPUADDR
        LDA #_UL
        STA PPUDATA
        STA PPUDATA
        LDA cartClothingDigit+2 ; number in Buy column
        CMP #_0_
        BNE :+
        LDA #_UL
        :
        STA PPUDATA
        LDA cartClothingDigit+3
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
        LDX #cartClothing
        LDA #COST_CLOTHES
        JSR DrawShopCost        ; number in Cost column
    Bullets:
        LDA PPUSTATUS           ; write bullets row
        LDA #$21
        STA PPUADDR
        LDA #$84
        STA PPUADDR
        LDA cartBulletsDigit    ; number in Buy column
        CMP #_0_
        BNE :+
        LDA #_UL
        :
        STA PPUDATA
        LDA cartBulletsDigit+1
        CMP #_0_
        BNE :++
        LDA cartBulletsDigit
        CMP #_0_
        BNE :+
        LDA #_UL
        JMP :++
        :
        LDA #_0_
        :
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
        LDX #cartBullets
        LDA #COST_BULLETS
        JSR DrawShopCost        ; number in Cost column
    Wheels:
        LDA PPUSTATUS           ; write Wheels row
        LDA #$21
        STA PPUADDR
        LDA #$C4
        STA PPUADDR
        LDA #_UL
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
        LDA cartSpareParts      ; number in Cost column
        AND #%00000011
        STA helper2
        LDX #helper2
        LDA #COST_PARTS
        JSR DrawShopCost
    Axles:
        LDA PPUSTATUS           ; write Axles row
        LDA #$22
        STA PPUADDR
        LDA #$04
        STA PPUADDR
        LDA #_UL
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
        LDA cartSpareParts      ; number in Cost column
        LSR
        LSR
        AND #%00000011
        STA helper2
        LDX #helper2
        LDA #COST_PARTS
        JSR DrawShopCost
    Tongues:
        LDA PPUSTATUS           ; write Tongues row
        LDA #$22
        STA PPUADDR
        LDA #$44
        STA PPUADDR
        LDA #_UL
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
        LDA cartSpareParts      ; number in Cost column
        LSR
        LSR
        LSR
        LSR
        AND #%00000011
        STA helper2
        LDX #helper2
        LDA #COST_PARTS
        JSR DrawShopCost
    Food:
        LDA PPUSTATUS           ; write Food row
        LDA #$22
        STA PPUADDR
        LDA #$84
        STA PPUADDR
        LDA cartFoodLbsDigit    ; number in Buy column
        CMP #_0_
        BNE :+
        LDA #_UL
        :
        STA PPUDATA
        LDA cartFoodLbsDigit+1
        CMP #_0_
        BNE :++
        LDA cartFoodLbsDigit
        CMP #_0_
        BNE :+
        LDA #_UL
        JMP :++
        :
        LDA #_0_
        :
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
        LDX #cartFoodLbs
        LDA #COST_FOOD_LB
        JSR DrawShopCost
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
        LDA #_DL
        STA PPUDATA
        LDA dollarsDigit
        STA PPUDATA
        LDA dollarsDigit+1
        STA PPUDATA
        LDA dollarsDigit+2
        STA PPUDATA
        LDA dollarsDigit+3
        STA PPUDATA
        LDA #_00
        STA PPUDATA
    Done:
    JSR DoneBulkDrawing
    RTS
.endproc

.proc LoadBgLandmark
    JSR StartBulkDrawing
    JSR DrawLandmarkImage ; also sets attributes
    LDX #0
    LDY #22
    JSR SetPpuAddrPointerFromXY
    JSR DrawLandmarkTitle
    JSR DoneBulkDrawing
    JSR BufferDrawPressStart
    RTS
.endproc

.proc LoadBgTraveling
    JSR ClearScreen
    JSR ClearAttributes ; default palette
    JSR StartBulkDrawing
    LDA menuOpen
    CMP #MENU_MAINMENU
    BNE :+
    JMP @menuMain
    :
    CMP #MENU_NONE
    BNE :+
    JMP @menuNone
    :
    @menuMain:
        ;LDA menuOpenLast
        ;CMP #MENU_MAP
        ;BNE :+
        ; reload pattern B tiles
        LDY #0
        JSR bankswitch_y
        LDA #<tiles_chr
        STA pointer
        LDA #>tiles_chr
        STA pointer+1
        JSR CopyCHRTiles
        LDY #1
        JSR bankswitch_y
        ;:
        JSR DrawHUDMainMenu
        LDA #$20    ; weather text
        STA pointer
        LDA #$EC
        STA pointer+1
        JSR BufferDrawWeatherText
        LDA #$21    ; Health text
        STA pointer
        LDA #$2C
        STA pointer+1
        JSR BufferDrawHealthText
        JMP Done
    @menuNone:
        LDA PPUSTATUS
        LDA #$23
        STA PPUADDR
        LDA #$C8
        STA PPUADDR
        LDX #24
        LDA #%10101010
        :
        STA PPUDATA
        DEX
        BNE :-
        LDA PPUSTATUS
        LDA #$20
        STA PPUADDR
        LDX #0 ; temp- draw horizon
        LDA location
        CMP #LOC_FORTLARAMIE
        BCS :++
        LDA #$80
        STA PPUADDR
        :
        LDA bgPlains, X
        STA PPUDATA
        INX
        CPX #$40
        BNE :-
        JMP :+++
        :
        LDA #$60
        STA PPUADDR
        :
        LDA bgMountains, X
        STA PPUDATA
        INX
        CPX #$60
        BNE :-
        :
        LDA PPUSTATUS
        LDA #$21
        STA PPUADDR
        LDA #$40
        STA PPUADDR
        LDX #0 ; draw ground
        LDA #TILE_GRASS
        :
        STA PPUDATA
        INX
        CPX #$C0
        BNE :-
        JSR BufferDrawTravelingAttr
        JSR BufferDrawSizeUpSituation
        JSR BufferDrawTravelingHUD
        JSR BufferDrawTravelingHUDValues
        JSR BufferDrawPressStart
        JSR BufferDrawWagon
    



        JMP Done
    Done:
    JSR DoneBulkDrawing
    RTS
.endproc

.proc LoadBgSupplies
    JSR ClearScreen
    JSR ClearAttributes ; default palette
    JSR StartBulkDrawing
    LDX #16
    LDY #2
    JSR SetPpuAddrPointerFromXY
    LDA PPUSTATUS
    LDA pointer
    STA PPUADDR
    LDA pointer+1
    STA PPUADDR
    LDX #28
    :
    LDA hudMenuStatusText, X
    STA PPUDATA
    INX
    CPX #41
    BNE :-

    ; tile chr
    LDY #6
    JSR bankswitch_y
    LDA #<suppliesTiles
    STA pointer
    LDA #>suppliesTiles
    STA pointer+1
    LDY #0
    STY PPUMASK
    LDY #$10
    STY PPUADDR
    LDY #$00
    STY PPUADDR
    LDX #$09
    :
    LDA (pointer), Y
    STA PPUDATA
    INY
    BNE :-
    INC pointer+1
    DEX
    BNE :-
    LDY #1
    JSR bankswitch_y

    JSR DoneBulkDrawing
    JSR BufferDrawSupplies
    JSR BufferDrawPressStart
    RTS
.endproc

.proc LoadBgMap
    JSR ClearScreen
    JSR ClearAttributes
    JSR StartBulkDrawing
    LDA PPUSTATUS ; map palette
    LDA #$3F
    STA PPUADDR
    LDA #$00
    STA PPUADDR
    LDX #0
    :                       
    LDA mapPalette, X
    STA PPUDATA
    INX
    CPX #$20
    BNE :-
    LDY #6 ; get image data
    JSR bankswitch_y
    LDA #<mapTiles 
    STA pointer
    LDA #>mapTiles
    STA pointer+1
    LDA #<mapImage
    STA helper2
    LDA #>mapImage
    STA helper2+1
    JSR CopyCHRPatternB
    LDA PPUSTATUS ; draw letterbox (top)
    LDA #$20
    STA PPUADDR
    LDA #$00
    STA PPUADDR
    LDX #$40
    LDA #___
    :
    STA PPUDATA
    DEX
    BNE :-
    LDA PPUSTATUS ; draw letterbox (bottom)
    LDA #$23
    STA PPUADDR
    LDA #$40
    STA PPUADDR
    LDX #0
    LDA #___
    :
    STA PPUDATA
    INX
    CPX #$80
    BNE :-
    LDA PPUSTATUS ; attribute table
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR
    LDA #$05
    LDX #8
    :
    STA PPUDATA
    DEX
    BNE :-
    LDA #$00
    LDX #5*8
    :
    STA PPUDATA
    DEX
    BNE :-
    LDA #$50
    LDX #8
    :
    STA PPUDATA
    DEX
    BNE :-
    LDA #$55
    LDX #8
    :
    STA PPUDATA
    DEX
    BNE :-

    LDA helper2 ; set attribute table
    STA pointer
    LDA helper2+1
    STA pointer+1
    LDA #$00
    STA counter
    LDA #$03
    STA counter+1
    LDA PPUSTATUS
    LDA #$20
    STA PPUADDR
    LDA #$40
    STA PPUADDR
    JSR UnpackData

    LDY #1
    JSR bankswitch_y
    JSR DoneBulkDrawing
    JSR BufferDrawMapTitle
    JSR LoadTrailSprites
    JSR BufferDrawPressStart
    RTS
.endproc

.proc LoadBgTalk
    JSR ClearScreen
    JSR ClearAttributes
    JSR StartBulkDrawing
    LDY #6
    JSR bankswitch_y
    JSR DrawAdornments
    LDY #1
    JSR bankswitch_y
    JSR DoneBulkDrawing
    JSR BufferDrawTalkText
    JSR BufferDrawPressStart
    RTS
.endproc