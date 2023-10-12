
; Meta-values associated with collections of tiles.
; $00, $00, 00, $00, $00
;  ||   ||||||   ||   ++ Destination 'y-value' (row index) of tiles in CHRRAM
;  ||   ||||||   ++----- Number of rows of 16 tiles
;  ||   ++++++---------- Address of tile CHR
;  ++------------------- ROM bank number, must match game.asm
textTilesMeta:
    .byte 0, <textTiles, >textTiles, 4, 12

mattTilesMeta:
    .byte 0, <mattTiles, >mattTiles, 5, 0

; wagonTilesMeta: TODO
;     .byte 0, <wagonTiles, >wagonTiles, 4, 8

adornmentTilesMeta:
    .byte 0, <adornmentTiles, >adornmentTiles, 2, 0

titleLogoTilesMeta:
    .byte 0, <titleLogoTiles, >titleLogoTiles, 3, 2

suppliesTilesMeta:
    .byte 0, <suppliesFoodTiles, >suppliesFoodTiles, 10, 0

suppliesFoodTilesMeta:
    .byte 0, <suppliesFoodTiles, >suppliesFoodTiles, 2, 5

suppliesPartsTilesMeta:
    .byte 0, <suppliesPartsTiles, >suppliesPartsTiles, 2, 5

suppliesOxenTilesMeta:
    .byte 0, <suppliesOxenTiles, >suppliesOxenTiles, 2, 5

suppliesClothesTilesMeta:
    .byte 0, <suppliesClothesTiles, >suppliesClothesTiles, 2, 5

suppliesBulletsTilesMeta:
    .byte 0, <suppliesBulletsTiles, >suppliesBulletsTiles, 2, 5

namepartyTilesMeta:
    .byte 0, <namepartyTiles, >namepartyTiles, 12, 0

; Meta-values associated with general images
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
    .byte <chimneyRockTiles, >chimneyRockTiles, <chimneyRockAttr, >chimneyRockAttr, <chimneyRockImage, >chimneyRockImage, 3
    .byte <fortLaramieTiles, >fortLaramieTiles, <fortLaramieAttr, >fortLaramieAttr, <fortLaramieImage, >fortLaramieImage, 3
    .byte <independenceRockTiles, >independenceRockTiles, <independenceRockAttr, >independenceRockAttr, <independenceRockImage, >independenceRockImage, 3
    .byte <southPassTiles, >southPassTiles, <southPassAttr, >southPassAttr, <southPassImage, >southPassImage, 3
    .byte <fortBridgerTiles, >fortBridgerTiles, <fortBridgerAttr, >fortBridgerAttr, <fortBridgerImage, >fortBridgerImage, 4
    .byte <greenRiverTiles, >greenRiverTiles, <greenRiverAttr, >greenRiverAttr, <greenRiverImage, >greenRiverImage, 4
    .byte <sodaSpringsTiles, >sodaSpringsTiles, <sodaSpringsAttr, >sodaSpringsAttr, <sodaSpringsImage, >sodaSpringsImage, 4
    .byte <fortHallTiles, >fortHallTiles, <fortHallAttr, >fortHallAttr, <fortHallImage, >fortHallImage, 4
    .byte <snakeRiverTiles, >snakeRiverTiles, <snakeRiverAttr, >snakeRiverAttr, <snakeRiverImage, >snakeRiverImage, 5
    .byte <fortBoiseTiles, >fortBoiseTiles, <fortBoiseAttr, >fortBoiseAttr, <fortBoiseImage, >fortBoiseImage, 5
    .byte <blueMountainsTiles, >blueMountainsTiles, <blueMountainsAttr, >blueMountainsAttr, <blueMountainsImage, >blueMountainsImage, 5
    .byte <fortWallaWallaTiles, >fortWallaWallaTiles, <fortWallaWallaAttr, >fortWallaWallaAttr, <fortWallaWallaImage, >fortWallaWallaImage, 5
    .byte <theDallesTiles, >theDallesTiles, <theDallesAttr, >theDallesAttr, <theDallesImage, >theDallesImage, 6
    .byte <willametteTiles, >willametteTiles, <willametteAttr, >willametteAttr, <willametteImage, >willametteImage, 6
