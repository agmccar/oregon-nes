
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
    JSR ClearScreen
    JSR ClearAttributes ; default palette
    ;JSR BufferDrawTitle
    LDX #0                  ; default palette
    JSR UpdatePalette
    
    JSR StartBulkDrawing ; draw adornments
    JSR DrawAdornments
    JSR DrawTitleLogo
    JSR DoneBulkDrawing
    JSR BufferDrawTitleOptions

    LDA #%10010000
    STA softPPUCTRL         ; Ensure NMIs are enabled
    LDA #%00011110 
    STA softPPUMASK         ; turn on screen
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
    LDY #0
    JSR bankswitch_y
    LDA #<suppliesFoodTiles
    STA pointer
    LDA #>suppliesFoodTiles
    STA pointer+1
    LDA #$00
    STA counter
    LDA #$0a
    STA counter+1
    LDA #0
    STA PPUMASK
    LDA #$10
    STA PPUADDR
    LDA #$00
    STA PPUADDR
    JSR UnpackData
    LDA PPUSTATUS ; attributes
    LDA #$23
    STA PPUADDR
    LDA #$C0
    STA PPUADDR
    LDX #0
    :
    LDA suppliesAttr, X
    STA PPUDATA
    INX
    CPX #7*8
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
    LDA gameSettings
    AND #1
    BNE :+
    LDA mapPalette, X
    JMP :++
    :
    LDA mapPaletteMono, X
    :
    STA PPUDATA
    INX
    CPX #$20
    BNE :---
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
    JSR DrawAdornments
    JSR DoneBulkDrawing
    JSR BufferDrawTalkText
    JSR BufferDrawPressStart
    RTS
.endproc

.proc DrawTopTenHelp
    LDA menuCursor
    CMP #4
    BNE :+
    JMP Done
    :
    JSR ClearScreen
    LDA menuCursor
    CMP #3
    BNE :+
    JSR DrawAdornments
    :
    LDX #21
    JSR StartBufferWrite ; "On Arriving In Oregon"
        LDA #21
        JSR WriteByteToBuffer
        LDA #$20
        JSR WriteByteToBuffer
        LDA #$85
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA topTenHelpText, X
        JSR WriteByteToBuffer
        INX
        CPX #21
        BNE :-
    JSR EndBufferWrite

    DEC menuCursor
    LDA menuCursor
    ASL
    TAX
    INC menuCursor
    LDA top10Pointer, X
    STA pointer
    INX
    LDA top10Pointer, X
    STA pointer+1
    LDA #$20
    STA bufferHelper
    LDA #$C4
    STA bufferHelper+1
    LDA menuCursor
    CMP #3
    BNE :+
    CLC
    LDA bufferHelper+1
    ADC #$80
    STA bufferHelper+1
    LDA bufferHelper
    ADC #0
    STA bufferHelper
    :
    JSR BufferDrawText
    JSR BufferDrawPressStart

    LDA menuCursor
    CMP #1
    BNE :+
    LDA #$23
    STA pointer
    LDA #$e0
    STA pointer+1
    LDA #$f5
    STA helper
    LDA #10
    STA helper+1
    LDA #$22
    STA helper2
    LDA #$04
    STA helper2+1
    LDA #21
    STA counter
    LDA #30
    STA counter+1
    JMP ColorColumnHeaders
    :
    CMP #2
    BNE :+
    LDA #$23
    STA pointer
    LDA #$d8
    STA pointer+1
    LDA #$5f
    STA helper
    LDA #13
    STA helper+1
    LDA #$21
    STA helper2
    LDA #$c3
    STA helper2+1
    LDA #30
    STA counter
    LDA #42
    STA counter+1
    JMP ColorColumnHeaders
    :
    JMP Done

    ColorColumnHeaders:
    LDX #8
    JSR StartBufferWrite ; color column headers
        LDA #8
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA helper
        JSR WriteByteToBuffer
        INX
        CPX #8
        BNE :-
    JSR EndBufferWrite

    BufferStart_ helper+1, helper2, helper2+1 ; "Health of"/"Resources of"
    LDA #TILE_COL_HEADER
    JSR WriteByteToBuffer
    LDX counter
    :
    LDA topTenHelpText, X
    JSR WriteByteToBuffer
    INX
    CPX counter+1
    BNE :-
    JSR EndBufferWrite
    CLC
    LDA helper2+1
    ADC #$20
    STA helper2+1
    BufferStart_ helper+1, helper2, helper2+1
    LDA #TILE_COL_HEADER
    JSR WriteByteToBuffer
    LDA #___
    LDX helper+1
    DEX
    :
    JSR WriteByteToBuffer
    DEX
    BNE :-
    JSR EndBufferWrite
    CLC
    LDA helper2+1
    ADC menuCursor
    STA helper2+1
    INC helper2+1
    INC helper2+1
    BufferStart_ #5, helper2, helper2+1 ; "Party"
    LDX #42
    :
    LDA topTenHelpText, X
    JSR WriteByteToBuffer
    INX
    CPX #47
    BNE :-
    JSR EndBufferWrite

    SEC ; next column header
    LDA helper2+1
    SBC #$21
    SBC menuCursor
    CLC
    ADC helper+1
    STA helper2+1
    BufferStart_ #11, helper2, helper2+1 ; "Points per"
    LDA #TILE_COL_HEADER
    JSR WriteByteToBuffer
    LDX #47
    :
    LDA topTenHelpText, X
    JSR WriteByteToBuffer
    INX
    CPX #57
    BNE :-
    JSR EndBufferWrite
    CLC
    LDA helper2+1
    ADC #$20
    STA helper2+1
    BufferStart_ #11, helper2, helper2+1 
    LDA #TILE_COL_HEADER
    JSR WriteByteToBuffer
    LDA #___
    LDX #10
    :
    JSR WriteByteToBuffer
    DEX
    BNE :-
    JSR EndBufferWrite
    CLC
    LDA helper2+1
    ADC menuCursor
    STA helper2+1
    INC helper2+1
    INC helper2+1
    LDA #57
    STA counter
    LDA #63
    STA counter+1
    LDA menuCursor
    CMP #2
    BNE :+
    CLC
    LDA counter
    ADC #6
    STA counter
    LDA counter+1
    ADC #6
    STA counter+1
    :
    BufferStart_ #6, helper2, helper2+1 ; "Person"/"Item  "
    LDX counter
    :
    LDA topTenHelpText, X
    JSR WriteByteToBuffer
    INX
    CPX counter+1
    BNE :-
    JSR EndBufferWrite

    LDA #$22
    STA pointer
    LDA menuCursor ; table rows
    CMP #1
    BNE Pg2

    LDA #$65
    STA pointer+1
    LDA #0
    STA counter
    STA counter+1
    :
    BufferStart_ #9, pointer, pointer+1
        LDX counter
        CLC
        LDA counter
        ADC #9
        STA counter
        :
        LDA healthText, X
        JSR WriteByteToBuffer
        INX
        CPX counter
        BNE :-
    JSR EndBufferWrite
    CLC
    LDA pointer+1
    ADC #14
    STA pointer+1
    BufferStart_ #3, pointer, pointer+1
        SEC
        LDA #_5_
        SBC counter+1
        JSR WriteByteToBuffer
        LDA #_0_
        JSR WriteByteToBuffer
        JSR WriteByteToBuffer
    JSR EndBufferWrite
    CLC
    LDA pointer+1
    ADC #$20-14
    STA pointer+1
    LDA pointer
    ADC #0
    STA pointer
    INC counter+1
    LDA counter+1
    CMP #4
    BNE :--
    JMP Done

    Pg2:
    BufferStart_ #5, #$22, #$24 ; "wagon"
        LDX #0
        :
        LDA topTenResourcesText, X
        JSR WriteByteToBuffer
        INX
        CPX #5
        BNE :-
    JSR EndBufferWrite
    LDX #23
    LDY #17
    LDA #_5_
    JSR WriteTileToBuffer
    LDX #24
    LDY #17
    LDA #_0_
    JSR WriteTileToBuffer

    BufferStart_ #2, #$22, #$44 ; "ox"
        LDX #5
        :
        LDA topTenResourcesText, X
        JSR WriteByteToBuffer
        INX
        CPX #7
        BNE :-
    JSR EndBufferWrite
    LDX #24
    LDY #18
    LDA #_4_
    JSR WriteTileToBuffer

    BufferStart_ #16, #$22, #$64 ; "spare wagon part"
        LDX #7
        :
        LDA topTenResourcesText, X
        JSR WriteByteToBuffer
        INX
        CPX #23
        BNE :-
    JSR EndBufferWrite
    LDX #24
    LDY #19
    LDA #_2_
    JSR WriteTileToBuffer

    BufferStart_ #15, #$22, #$84 ; "set of clothing"
        LDX #23
        :
        LDA topTenResourcesText, X
        JSR WriteByteToBuffer
        INX
        CPX #38
        BNE :-
    JSR EndBufferWrite
    LDX #24
    LDY #20
    LDA #_2_
    JSR WriteTileToBuffer

    BufferStart_ #17, #$22, #$A4 ; "bullets (each 50)"
        LDX #38
        :
        LDA topTenResourcesText, X
        JSR WriteByteToBuffer
        INX
        CPX #45
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDA #_OP
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA topTenResourcesEachText, X
        JSR WriteByteToBuffer
        INX
        CPX #4
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDA #_5_
        JSR WriteByteToBuffer
        LDA #_0_
        JSR WriteByteToBuffer
        LDA #_CP
        JSR WriteByteToBuffer
    JSR EndBufferWrite
    LDX #24
    LDY #21
    LDA #_1_
    JSR WriteTileToBuffer

    BufferStart_ #16, #$22, #$C4 ; "food (each 25 lb)"
        LDX #45
        :
        LDA topTenResourcesText, X
        JSR WriteByteToBuffer
        INX
        CPX #49
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDA #_OP
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA topTenResourcesEachText, X
        JSR WriteByteToBuffer
        INX
        CPX #4
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDA #_2_
        JSR WriteByteToBuffer
        LDA #_5_
        JSR WriteByteToBuffer
        LDA #___
        JSR WriteByteToBuffer
        LDA #_LB
        JSR WriteByteToBuffer
        LDA #_CP
        JSR WriteByteToBuffer
    JSR EndBufferWrite
    LDX #24
    LDY #22
    LDA #_1_
    JSR WriteTileToBuffer

    BufferStart_ #14, #$22, #$E4 ; "cash (each $5)"
        LDX #49
        :
        LDA topTenResourcesText, X
        JSR WriteByteToBuffer
        INX
        CPX #53
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDA #_OP
        JSR WriteByteToBuffer
        LDX #0
        :
        LDA topTenResourcesEachText, X
        JSR WriteByteToBuffer
        INX
        CPX #4
        BNE :-
        LDA #___
        JSR WriteByteToBuffer
        LDA #_DL
        JSR WriteByteToBuffer
        LDA #_5_
        JSR WriteByteToBuffer
        LDA #_CP
        JSR WriteByteToBuffer
    JSR EndBufferWrite
    LDX #24
    LDY #23
    LDA #_1_
    JSR WriteTileToBuffer
    
    Done:
    RTS
.endproc

.proc LoadBgRiverCrossing
    RTS
.endproc

.proc LoadBgIndependence
    JSR ClearScreen
    JSR ClearAttributes
    JSR StartBulkDrawing
    JSR DrawLandmarkImage
    JSR DoneBulkDrawing
    JSR BufferDrawIntroTextBox
    RTS
.endproc