; TODO compress

; suppliesTiles:
;     .incbin "../chr/supplies.chr"

; ; <Length>, <Location>, <Location+1>, <Data>  
; suppliesImage: 
; 	.byte 3, $20,$62, $01,$02,$03 ; food
; 	.byte 6, $20,$82, $04,$05,$06,$07,$08,$09
; 	.byte 7, $20,$a1, $0a,$0b,$0c,$0d,$0e,$0f,$10
; 	.byte 6, $20,$c1, $11,$12,$13,$14,$15,$16
; 	.byte 5, $20,$e1, $17,$18,$19,$1a,$1b
; 	.byte 4, $21,$45, $21,$22,$23,$24 ; wagon parts
; 	.byte 5, $21,$65, $25,$26,$27,$28,$29
; 	.byte 5, $21,$85, $2a,$2b,$2c,$2d,$2e
; 	.byte 6, $21,$A5, $2f,$30,$31,$32,$33,$34
; 	.byte 4, $21,$C6, $35,$36,$37,$38
; 	.byte 3, $21,$E5, $39,$3a,$3b
; 	.byte 7, $22,$41, $41,$42,$43,$44,$45,$46,$47 ; oxen
; 	.byte 7, $22,$61, $48,$49,$4a,$4b,$4c,$4d,$4e
; 	.byte 7, $22,$82, $4f,$50,$51,$52,$53,$54,$55
; 	.byte 6, $22,$A3, $56,$57,$58,$59,$5a,$5b
; 	.byte 2, $22,$C3, $5c,$5d
;     .byte 10, $22,$ea, $61,$62,$63,$64,$65,$4b,$66,$67,$68,$69 ; clothing
; 	.byte 11, $23,$09, $6a,$6b,$6c,$6d,$6e,$6f,$70,$71,$72,$73,$74
; 	.byte 10, $23,$29, $75,$76,$77,$78,$79,$7a,$7b,$7c,$7d,$7e
; 	.byte 2, $22,$bd, $81,$82 ; guns & bullets
; 	.byte 4, $22,$da, $83,$84,$85,$86
; 	.byte 8, $22,$f6, $87,$88,$89,$8a,$8b,$8c,$8d,$8e
; 	.byte 9, $23,$16, $8f,$90,$91,$92,$93,$94,$95,$97,$98
; 	.byte 7, $23,$37, $99,$9a,$9b,$9c,$9d,$9e,$9f
;     .byte 0

; suppliesAttr:
; 	.byte $c0,$30,$00,$00,$00,$00,$00,$00
;     .byte $5f,$8b,$00,$00,$00,$00,$00,$00
; 	.byte $00,$a0,$20,$00,$00,$00,$00,$00
;     .byte $00,$aa,$2a,$00,$00,$00,$00,$00
; 	.byte $b0,$e0,$00,$00,$00,$00,$00,$00
;     .byte $8c,$2a,$82,$a0,$a0,$80,$a0,$2a
; 	.byte $00,$00,$0a,$0a,$0a,$08,$0a,$0a
suppliesAttr:
    .byte $3f,$cf,$ff,$ff,$ff,$ff,$ff,$ff
    .byte $50,$b8,$ff,$ff,$ff,$ff,$ff,$ff
    .byte $ff,$af,$ef,$ff,$ff,$ff,$ff,$ff
    .byte $ff,$aa,$ea,$ff,$ff,$ff,$ff,$ff
    .byte $8f,$3f,$ff,$ff,$ff,$ff,$ff,$ff
    .byte $b3,$ea,$be,$af,$af,$bf,$af,$ea
    .byte $ff,$ff,$fa,$fa,$fa,$fb,$fa,$fa
	
; Len, +X, <data> 
suppliesImageFood:
	.byte $20,$61 ; (1,3)
	.byte 3, 1, $01,$02,$03 ; food
	.byte 6, 1, $04,$05,$06,$07,$08,$09
	.byte 7, 0, $0a,$0b,$0c,$0d,$0e,$0f,$10
	.byte 6, 0, $11,$12,$13,$14,$15,$16
	.byte 5, 0, $17,$18,$19,$1a,$1b
    .byte 0

suppliesImageParts:
	.byte $21,$45 ; (5,10)
	.byte 4, 0, $21,$22,$23,$24 ; wagon parts
	.byte 5, 0, $25,$26,$27,$28,$29
	.byte 5, 0, $2a,$2b,$2c,$2d,$2e
	.byte 6, 0, $2f,$30,$31,$32,$33,$34
	.byte 4, 1, $35,$36,$37,$38
	.byte 3, 0, $39,$3a,$3b
    .byte 0

suppliesImageOxen:
	.byte $22,$41 ; (1,18)
	.byte 7, 0, $41,$42,$43,$44,$45,$46,$47 ; oxen
	.byte 7, 0, $48,$49,$4a,$4b,$4c,$4d,$4e
	.byte 7, 1, $4f,$50,$51,$52,$53,$54,$55
	.byte 6, 2, $56,$57,$58,$59,$5a,$5b
	.byte 2, 2, $5c,$5d
    .byte 0

suppliesImageClothes:
	.byte $22,$e9 ; (9,23)
    .byte 10, 1, $61,$62,$63,$64,$65,$4b,$66,$67,$68,$69 ; clothing
	.byte 11, 0, $6a,$6b,$6c,$6d,$6e,$6f,$70,$71,$72,$73,$74
	.byte 10, 0, $75,$76,$77,$78,$79,$7a,$7b,$7c,$7d,$7e
    .byte 0

suppliesImageBullets:
	.byte $22,$b6 ; (22,21)
	.byte 2, 7, $81,$82 ; guns & bullets
	.byte 4, 4, $83,$84,$85,$86
	.byte 8, 0, $87,$88,$89,$8a,$8b,$8c,$8d,$8e
	.byte 9, 0, $8f,$90,$91,$92,$93,$94,$95,$97,$98
	.byte 7, 1, $99,$9a,$9b,$9c,$9d,$9e,$9f
    .byte 0