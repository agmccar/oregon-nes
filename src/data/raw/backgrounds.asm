
bgWagonTop:
    .byte $80,$81,$82,$83,$84,$85,$86 ; $20D8 - $20DE
    .byte $87,$88,$89,$8a,$8a,$8c,$8d ; $20F8 - $20FE

bgWagonAnim:
    .byte $90,$91,$92,$93,$8e,$94,$8f,$95,$96 ; $2115 - $211D ; frame 1
    .byte $97,$98,$99,$9a,$9b,$9c,$9d,$9e,$9f ; $2135 - $213D
    
    .byte $a0,$a1,$a2,$a3,$8e,$a4,$8f,$a5,$a6 ; $2115 - $211D ; frame 2
    .byte $a7,$a8,$a9,$aa,$ab,$ac,$ad,$ae,$af ; $2135 - $213D
    
    .byte $b0,$b1,$b2,$b3,$8e,$b4,$8f,$b5,$b6 ; $2115 - $211D ; frame 3
    .byte $b7,$b8,$b9,$ba,$bb,$bc,$bd,$be,$bf ; $2135 - $213D

attrPopupText:
    .byte $e0,$f0,$f0,$f0,$f0,$f0,$f0,$b0
    .byte $ee,$ff,$ff,$ff,$ff,$ff,$ff,$bb
