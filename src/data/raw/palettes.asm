; %00000000 attribute bytes cheat sheet
;  ||||||++- top left quadrant
;  ||||++--- top right quadrant
;  ||++----- bottom left quadrant
;  ++------- bottom right quadrant

palette:
    ; background palette data
    .byte C_BLACK, C_PINK, C_ORANGE, C_WHITE
    .byte C_BLACK, C_GREY, C_WHITE, C_BLACK
    .byte C_BLACK, C_BLUE, C_GREEN, C_WHITE
    .byte C_BLACK, C_GREY, C_BLACK, C_WHITE
    ; sprite palette data
    .byte C_BLACK, C_GREY, C_LGREY, C_WHITE
    .byte C_BLACK, C_GREY, C_LGREY, C_WHITE
    .byte C_BLACK, C_GREY, C_LGREY, C_WHITE
    .byte C_BLACK, C_GREY, C_LGREY, C_WHITE

paletteMono:
    ; background palette data
    .byte C_BLACK, C_MONO+$10, C_MONO+$20, C_MONO+$30
    .byte C_BLACK, C_MONO+$10, C_MONO+$30, C_BLACK
    .byte C_BLACK, C_MONO+$10, C_MONO+$20, C_MONO+$30
    .byte C_BLACK, C_MONO+$10, C_BLACK, C_MONO+$30
    ; sprite palette data
    .byte C_BLACK, C_MONO+$10, C_MONO+$20, C_MONO+$30
    .byte C_BLACK, C_MONO+$10, C_MONO+$20, C_MONO+$30
    .byte C_BLACK, C_MONO+$10, C_MONO+$20, C_MONO+$30
    .byte C_BLACK, C_MONO+$10, C_MONO+$20, C_MONO+$30

landmarkPalette:
    ; background palette data
    .byte C_BLACK, C_PINK, C_ORANGE, C_WHITE
    .byte C_BLACK, C_GREY, C_WHITE, C_BLACK
    .byte C_BLACK, C_BLUE, C_GREEN, C_WHITE
    .byte C_BLACK, C_GREY, C_BLACK, C_WHITE

mapPalette:
    ; background palette data
    .byte C_WHITE, C_BLUE, C_GREY, C_BLACK
    .byte C_WHITE, C_BLUE, C_BLACK, C_WHITE
    .byte C_WHITE, C_BLUE, C_WHITE, C_BLACK
    .byte C_WHITE, C_BLUE, C_GREY, C_BLACK
    ; sprite palette data
    .byte C_WHITE, C_BLUE, C_GREY, C_BLACK
    .byte C_WHITE, C_BLACK, C_LGREY, C_WHITE
    .byte C_WHITE, C_BLUE, C_GREY, C_BLACK
    .byte C_WHITE, C_BLUE, C_GREY, C_BLACK

mapPaletteMono:
    ; background palette data
    .byte C_MONO+$30, C_MONO+$10, C_MONO+$20, C_BLACK
    .byte C_MONO+$30, C_MONO+$10, C_BLACK, C_MONO+$30
    .byte C_MONO+$30, C_MONO+$10, C_MONO+$30, C_BLACK
    .byte C_MONO+$30, C_MONO+$10, C_MONO+$20, C_BLACK
    ; sprite palette data
    .byte C_MONO+$30, C_MONO+$10, C_MONO+$20, C_BLACK
    .byte C_MONO+$30, C_BLACK, C_MONO+$20, C_MONO+$30
    .byte C_MONO+$30, C_MONO+$10, C_MONO+$20, C_BLACK
    .byte C_MONO+$30, C_MONO+$10, C_MONO+$20, C_BLACK

; TODO fortKearneyPalette:
; .byte C_BLACK,$25,$2a,C_WHITE
; .byte C_BLACK,$01,C_BLUE,$31

suppliesPalette:
    ; background palette data
    .byte C_BLACK, C_BLUE, C_ORANGE, C_WHITE
    .byte C_BLACK, C_PINK, C_ORANGE, C_WHITE
    .byte C_BLACK, C_GREEN, C_ORANGE, C_WHITE
    .byte C_BLACK, C_GREY, C_BLACK, C_WHITE
