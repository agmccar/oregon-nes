
; Meta-values associated with tile CHR.
; $00, $00, 00, $00, $00, $00
;  ||   ||||||   ||   ||   ++ hi byte of tilemap page to write on, $00 or $10
;  ||   ||||||   ||   ++----- Destination 'y-value' (row index) of tiles in CHRRAM
;  ||   ||||||   ++---------- Number of rows of 16 tiles ("height")
;  ||   ++++++--------------- Address of tile CHR
;  ++------------------------ ROM bank number, must match game.asm
; testChrMeta:
;     .byte 0, <testChr, >testChr, 16, 0, $00
textTilesMeta:
    .byte 0, <textTiles, >textTiles, 4, 12, $10

mattTilesMeta:
    .byte 0, <mattTiles, >mattTiles, 5, 0, $10

horizonPlainsTilesMeta:
    .byte BANK_TRAVELING, <horizonPlainsTiles, >horizonPlainsTiles, 4, 0, $10

horizonMountainsTilesMeta:
    .byte BANK_TRAVELING, <horizonMountainsTiles, >horizonMountainsTiles, 4, 0, $10

wagonTilesMeta:
    .byte BANK_TRAVELING, <wagonTiles, >wagonTiles, 4, 8, $10

mapTilesMeta:
    .byte 0, <mapTiles, >mapTiles, 13, 0, $10

adornmentTilesMeta:
    .byte 0, <adornmentTiles, >adornmentTiles, 2, 0, $10

titleLogoTilesMeta:
    .byte 0, <titleLogoTiles, >titleLogoTiles, 3, 2, $10

suppliesTilesMeta:
    .byte 0, <suppliesFoodTiles, >suppliesFoodTiles, 10, 0, $10

suppliesFoodTilesMeta:
    .byte 0, <suppliesFoodTiles, >suppliesFoodTiles, 2, 5, $10

suppliesPartsTilesMeta:
    .byte 0, <suppliesPartsTiles, >suppliesPartsTiles, 2, 5, $10

suppliesOxenTilesMeta:
    .byte 0, <suppliesOxenTiles, >suppliesOxenTiles, 2, 5, $10

suppliesClothesTilesMeta:
    .byte 0, <suppliesClothesTiles, >suppliesClothesTiles, 2, 5, $10

suppliesBulletsTilesMeta:
    .byte 0, <suppliesBulletsTiles, >suppliesBulletsTiles, 2, 5, $10

namepartyTilesMeta:
    .byte 0, <namepartyTiles, >namepartyTiles, 12, 0, $10

trailSpritesTilesMeta:
    .byte 0, <trailSpritesTiles, >trailSpritesTiles, 4, 11, $00

; landmarkSpritesTilesMeta:
;     .byte 1, <landmarkSpritesTiles, >landmarkSpritesTiles, 11, 0, $00

reBlizzardTilesMeta:
    .byte BANK_RANDOMEVENT, <reBlizzardTiles, >reBlizzardTiles, 1, 4, $10

reBrokenPartTilesMeta:
    .byte BANK_RANDOMEVENT, <reBrokenPartTiles, >reBrokenPartTiles, 1, 4, $10

reSnowboundTilesMeta:
    .byte BANK_RANDOMEVENT, <reSnowboundTiles, >reSnowboundTiles, 1, 4, $10

reThiefTilesMeta:
    .byte BANK_RANDOMEVENT, <reThiefTiles, >reThiefTiles, 1, 4, $10

reThunderstormTilesMeta:
    .byte BANK_RANDOMEVENT, <reThunderstormTiles, >reThunderstormTiles, 1, 4, $10

reWagonFireTilesMeta:
    .byte BANK_RANDOMEVENT, <reWagonFireTiles, >reWagonFireTiles, 1, 4, $10

reWildFruitTilesMeta:
    .byte BANK_RANDOMEVENT, <reWildFruitTiles, >reWildFruitTiles, 1, 4, $10

; Meta-values associated with general images
; TODO: images less than a screen wide?
; 0,0,0,0,0,0
; | | ||| +++ Address of image attribute data
; | | +++---- Target PPU addr for attributes
; | +-------- Attr bytes length
; +---------- ROM bank number
; 0,0,0,0,0,0
; ||| ||| +++ Address of image data
; ||| +++---- Target PPU addr for image. if 0,0: use helper
; +++-------- Tiles in image (Rows * $20)
namepartyImageMeta:
    .byte 0, 64, $23, $c0, <namepartyAttr, >namepartyAttr
    .byte $01, $a0, $20, $40, <namepartyImage, >namepartyImage

mattImageMeta:
    .byte 0, 64, $23, $c0, <mattAttr, >mattAttr
    .byte $02, $20, $21, $00, <mattImage, >mattImage

adornmentImageMeta:
    .byte 0, 0, 0, 0, 0, 0
    .byte $00, $40, 0, 0, <adornmentImage, >adornmentImage

titleLogoImageMeta:
    .byte 0, 0, 0, 0, 0, 0
    .byte $00, $80, $20, $60, <titleLogoImage, >titleLogoImage

suppliesMattFoodImageMeta:
    .byte 0, 16, $23, $e8, <suppliesMattFoodAttr, >suppliesMattFoodAttr
    .byte $00, $a0, $22, $80, <suppliesMattFoodImage, >suppliesMattFoodImage

suppliesMattPartsImageMeta:
    .byte 0, 16, $23, $e8, <suppliesMattPartsAttr, >suppliesMattPartsAttr
    .byte $00, $c0, $22, $60, <suppliesMattPartsImage, >suppliesMattPartsImage

suppliesMattOxenImageMeta:
    .byte 0, 16, $23, $e8, <suppliesMattOxenAttr, >suppliesMattOxenAttr
    .byte $00, $a0, $22, $80, <suppliesMattOxenImage, >suppliesMattOxenImage

suppliesMattClothesImageMeta:
    .byte 0, 16, $23, $e8, <suppliesMattClothesAttr, >suppliesMattClothesAttr
    .byte $00, $60, $22, $c0, <suppliesMattClothesImage, >suppliesMattClothesImage

suppliesMattBulletsImageMeta:
    .byte 0, 16, $23, $e8, <suppliesMattBulletsAttr, >suppliesMattBulletsAttr
    .byte $00, $a0, $22, $80, <suppliesMattBulletsImage, >suppliesMattBulletsImage

horizonPlainsImageMeta:
    .byte BANK_TRAVELING, 0, 0, 0, 0, 0
    .byte $00, $40, $20, $80, <horizonPlainsImage, >horizonPlainsImage

horizonMountainsImageMeta:
    .byte BANK_TRAVELING, 0, 0, 0, 0, 0
    .byte $00, $40, $20, $80, <horizonMountainsImage, >horizonMountainsImage

mapImageMeta:
    .byte 0, 0, 0, 0, 0, 0
    .byte $03, $00, $20, $40, <mapImage, >mapImage

; Meta-values associated with landmark images.
; Sections of 7 bytes are ordered by location index.
; 0,0,0,0,0,0,0
; ||| ||| ||| + ROM bank number, must match game.asm
; ||| ||| +++-- Address of landmark image
; ||| +++------ Address of landmark image attributes
; +++---------- Address of landmark tile CHR
landmarkImageMeta:
    .byte <independenceTiles, >independenceTiles, <independenceAttr, >independenceAttr, <independenceImage, >independenceImage, 2
    .byte <kansasRiverTiles, >kansasRiverTiles, <kansasRiverAttr, >kansasRiverAttr, <kansasRiverImage, >kansasRiverImage, 2
    .byte <bigBlueRiverTiles, >bigBlueRiverTiles, <bigBlueRiverAttr, >bigBlueRiverAttr, <bigBlueRiverImage, >bigBlueRiverImage, 2
    .byte <fortKearneyTiles, >fortKearneyTiles, <fortKearneyAttr, >fortKearneyAttr, <fortKearneyImage, >fortKearneyImage, 2
    .byte <chimneyRockTiles, >chimneyRockTiles, <chimneyRockAttr, >chimneyRockAttr, <chimneyRockImage, >chimneyRockImage, 2
    .byte <fortLaramieTiles, >fortLaramieTiles, <fortLaramieAttr, >fortLaramieAttr, <fortLaramieImage, >fortLaramieImage, 3
    .byte <independenceRockTiles, >independenceRockTiles, <independenceRockAttr, >independenceRockAttr, <independenceRockImage, >independenceRockImage, 3
    .byte <southPassTiles, >southPassTiles, <southPassAttr, >southPassAttr, <southPassImage, >southPassImage, 3
    .byte <fortBridgerTiles, >fortBridgerTiles, <fortBridgerAttr, >fortBridgerAttr, <fortBridgerImage, >fortBridgerImage, 3
    .byte <greenRiverTiles, >greenRiverTiles, <greenRiverAttr, >greenRiverAttr, <greenRiverImage, >greenRiverImage, 3
    .byte <sodaSpringsTiles, >sodaSpringsTiles, <sodaSpringsAttr, >sodaSpringsAttr, <sodaSpringsImage, >sodaSpringsImage, 4
    .byte <fortHallTiles, >fortHallTiles, <fortHallAttr, >fortHallAttr, <fortHallImage, >fortHallImage, 4
    .byte <snakeRiverTiles, >snakeRiverTiles, <snakeRiverAttr, >snakeRiverAttr, <snakeRiverImage, >snakeRiverImage, 4
    .byte <fortBoiseTiles, >fortBoiseTiles, <fortBoiseAttr, >fortBoiseAttr, <fortBoiseImage, >fortBoiseImage, 4
    .byte <blueMountainsTiles, >blueMountainsTiles, <blueMountainsAttr, >blueMountainsAttr, <blueMountainsImage, >blueMountainsImage, 4
    .byte <fortWallaWallaTiles, >fortWallaWallaTiles, <fortWallaWallaAttr, >fortWallaWallaAttr, <fortWallaWallaImage, >fortWallaWallaImage, 5
    .byte <theDallesTiles, >theDallesTiles, <theDallesAttr, >theDallesAttr, <theDallesImage, >theDallesImage, 5
    .byte <willametteTiles, >willametteTiles, <willametteAttr, >willametteAttr, <willametteImage, >willametteImage, 5
