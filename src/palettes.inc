;-------------------------------------------------------------------------------
.SEGMENT "RODATA"

palette:
    ; background palette data
    .byte $21, $25, $19, $30 ; Sky, Pink, Trees, White
    .byte $21, $19, $29, $30 ; Sky, Trees, Grass, White
    .byte $21, $06, $29, $30 ; Sky, Brown, Grass, White
    .byte $21, $16, $0F, $30 ; Sky, Red, Black, White (HUD)
    ; sprite palette data
    .byte $21, $00, $10, $30 ; Sky, Grey, LGrey, White
    .byte $21, $29, $29, $29 ; Sky,Grass,Grass,Grass
    .byte $21, $00, $10, $30 ;
    .byte $21, $00, $10, $30 ;