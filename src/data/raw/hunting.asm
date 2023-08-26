
huntingBg_oak:
    .byte 6,5 ; variant 1
    .byte $00,$01,$02,$03,$04,$00
    .byte $0d,$0e,$0f,$10,$11,$12
    .byte $1f,$20,$21,$22,$23,$24
    .byte $31,$32,$33,$34,$35,$36
    .byte $00,$00,$41,$42,$00,$00
    .byte 6,5 ; variant 2
    .byte $00,$05,$06,$07,$00,$00
    .byte $13,$14,$15,$16,$17,$18
    .byte $25,$26,$27,$28,$29,$2a
    .byte $37,$38,$39,$3a,$3b,$3c
    .byte $00,$00,$43,$44,$00,$00
    .byte 6,5 ; variant 3
    .byte $08,$09,$0a,$0b,$0c,$00
    .byte $19,$1a,$1b,$1c,$1d,$1e
    .byte $2b,$2c,$2d,$2e,$2f,$30
    .byte $00,$00,$3d,$3e,$3f,$40
    .byte $00,$00,$45,$46,$47,$00

huntingBg_grass:
    .byte 6,2 ; variant 1
    .byte $48,$49,$4a,$4b,$4c,$00
    .byte $57,$58,$59,$5a,$5b,$5c
    .byte 6,2 ; variant 2
    .byte $4d,$4e,$4f,$50,$51,$00
    .byte $5d,$5e,$5f,$60,$61,$62
    .byte 6,2 ; variant 3
    .byte $52,$53,$54,$55,$56,$00
    .byte $63,$64,$65,$66,$67,$68

huntingBg_rocks:
    .byte 5,3 ; variant 1
    .byte $00,$6b,$6c,$6d,$6e
    .byte $77,$78,$79,$7a,$7b
    .byte $00,$00,$00,$86,$87
    .byte 5,4 ; variant 2
    .byte $69,$6a,$00,$00,$00
    .byte $6f,$70,$71,$72,$00
    .byte $7c,$7d,$7e,$7f,$80
    .byte $88,$89,$8a,$8b,$8c
    .byte 5,3 ; variant 3
    .byte $73,$74,$75,$76,$00
    .byte $81,$82,$83,$84,$85
    .byte $8d,$8e,$8f,$90,$91

huntingBg_pine:
    .byte 5,5 ; variant 1
    .byte $00,$92,$93,$94,$00
    .byte $05,$98,$99,$9a,$9b
    .byte $a2,$a3,$a4,$a5,$a6
    .byte $b0,$b1,$b2,$b3,$b4
    .byte $00,$00,$bf,$c0,$00
    .byte 5,5 ; variant 2
    .byte $00,$95,$00,$00,$00
    .byte $00,$9c,$9d,$95,$9e
    .byte $a7,$a8,$a9,$aa,$ab
    .byte $b5,$b6,$b7,$b8,$b9
    .byte $c1,$c2,$c3,$c4,$c5
    .byte 5,5 ; variant 3
    .byte $00,$96,$97,$00,$00
    .byte $00,$9f,$a0,$a1,$00
    .byte $ac,$ad,$ae,$af,$00
    .byte $ba,$bb,$bc,$bd,$be
    .byte $c6,$c7,$c8,$c9,$ca

huntingBg_cactus:
    .byte 6,4 ; variant 1
    .byte $00,$cc,$cd,$ce,$cf,$00
    .byte $d6,$d7,$d8,$d9,$da,$db
    .byte $e4,$e5,$e6,$e7,$e8,$e9
    .byte $ef,$f0,$f1,$f2,$f3,$f4
    .byte 6,4 ; variant 2
    .byte $00,$d0,$d1,$00,$00,$00
    .byte $dc,$dd,$de,$df,$00,$00
    .byte $00,$ea,$eb,$ec,$00,$00
    .byte $f5,$f6,$f7,$f8,$f9,$fa
    .byte 5,5 ; variant 3
    .byte $00,$cb,$cb,$cb,$00
    .byte $d2,$d3,$d4,$d5,$00
    .byte $e0,$e1,$e2,$e3,$00
    .byte $00,$00,$ed,$ee,$00
    .byte $fb,$fc,$fd,$fe,$ff

hunterSprites:
    .byte 3,3
    .byte $00,$01,$02 ; walking up frame 1
    .byte $00,$03,$04
    .byte $00,$05,$00
    .byte $00,$01,$02 ; walking up frame 2
    .byte $00,$03,$04
    .byte $00,$06,$00
    .byte $00,$01,$02 ; walking up frame 3
    .byte $00,$03,$04
    .byte $00,$07,$00
    .byte $08,$09,$0a ; walking up/left frame 1
    .byte $0b,$0c,$0d
    .byte $00,$0e,$00
    .byte $08,$09,$0a ; walking up/left frame 2
    .byte $0b,$0c,$0d
    .byte $0f,$10,$11
    .byte $08,$09,$0a ; walking up/left frame 3
    .byte $0b,$0c,$0d
    .byte $00,$12,$13
    .byte $00,$21,$00 ; walking left frame 1
    .byte $22,$23,$00
    .byte $00,$24,$00
    .byte $00,$21,$00 ; walking left frame 2
    .byte $22,$23,$00
    .byte $00,$25,$26
    .byte $00,$21,$00 ; walking left frame 3
    .byte $22,$23,$00
    .byte $00,$27,$28
    .byte $00,$14,$00 ; walking down/left frame 1
    .byte $1b,$1c,$00
    .byte $00,$1d,$00
    .byte $00,$14,$00 ; walking down/left frame 2
    .byte $1b,$1c,$00
    .byte $00,$1e,$00
    .byte $00,$14,$00 ; walking down/left frame 3
    .byte $1b,$1c,$00
    .byte $1f,$20,$00
    .byte $00,$14,$00 ; walking down frame 1
    .byte $15,$16,$00
    .byte $17,$18,$00
    .byte $00,$14,$00 ; walking down frame 2
    .byte $15,$16,$00
    .byte $17,$19,$00
    .byte $00,$14,$00 ; walking down frame 3
    .byte $15,$16,$00
    .byte $17,$1a,$00

stagSprites:
    .byte 4,3
    .byte $29,$2a,$00,$00 ; frame 1
    .byte $32,$33,$34,$35
    .byte $00,$42,$43,$44
    .byte $2b,$2c,$00,$00 ; frame 2
    .byte $36,$37,$38,$39
    .byte $00,$45,$46,$0d
    .byte $2d,$2e,$00,$00 ; frame 3
    .byte $3a,$3b,$3c,$3d
    .byte $47,$48,$49,$4a
    .byte $00,$2f,$30,$31 ; dead
    .byte $3e,$3f,$40,$41
    .byte $4b,$4c,$00,$00

deerSprites:
    .byte 4,3
    .byte $4d,$4e,$00,$4f ; frame 1
    .byte $32,$33,$34,$57
    .byte $00,$42,$43,$44
    .byte $50,$51,$00,$52 ; frame 2
    .byte $36,$37,$38,$58
    .byte $00,$45,$46,$0d
    .byte $53,$54,$00,$55 ; frame 3
    .byte $3a,$3b,$3c,$59
    .byte $47,$48,$49,$4a
    .byte $00,$56,$30,$31 ; dead
    .byte $5a,$5b,$40,$5c
    .byte $5d,$5e,$00,$5f

rabbitSprites:
    .byte 2,2
    .byte $60,$61 ; frame 1
    .byte $68,$69
    .byte $62,$63 ; frame 2
    .byte $6a,$6b
    .byte $64,$65 ; frame 3
    .byte $6c,$6d
    .byte $66,$67 ; dead
    .byte $6e,$6f

buffaloSprites:
    .byte 4,3
    .byte $70,$71,$72,$00 ; frame 1
    .byte $7a,$7b,$7c,$7d
    .byte $00,$8a,$8b,$8c
    .byte $73,$74,$75,$00 ; frame 2
    .byte $7e,$7f,$80,$81
    .byte $00,$8d,$8e,$8f
    .byte $76,$77,$78,$00 ; frame 3
    .byte $82,$83,$84,$85
    .byte $90,$91,$92,$93
    .byte $00,$79,$00,$00 ; dead
    .byte $86,$87,$88,$89
    .byte $94,$95,$96,$97

squirrelSprites:
    .byte 3,1
    .byte $98,$99,$9a ; frame 1
    .byte $9b,$9c,$9d ; frame 2
    .byte $9e,$9f,$a0 ; frame 3
    .byte $a1,$a2,$a3 ; dead

bearSprites:
    .byte 4,2
    .byte $a4,$a5,$a6,$a7 ; frame 1
    .byte $b0,$b1,$b2,$b3
    .byte $a8,$a9,$a6,$a7 ; frame 2
    .byte $b4,$b5,$b6,$b7
    .byte $aa,$ab,$a6,$a7 ; frame 3
    .byte $b8,$b9,$ba,$bb
    .byte $ac,$ad,$ae,$af ; dead
    .byte $bc,$bd,$bd,$be