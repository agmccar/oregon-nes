; First header byte:
; %00000000
;  ||||++++ Type of punctiation- {' ': 0, ',': 1, '.': 2, '!': 3, '?': 4, '$': 5}
;  ++++---- Remaining length of header

; (2nd - nth) header bytes:
; Every nibble is the length of a word.
; %00000000, %00000000,...
;  ++++--------------- Length of first word
;      ++++----------- Length of 2nd word
;             ++++---- Length of 3rd word
;                 ++++ Length of 4th word, etc.

; Data segment bytes:
; $00      : End of entire section
; $01 - $cf: Dictionary
; $d0 - $e9: Literal A-Z
; $ea - $fe: Literal '-";:.,0123456789…()%
; $ff: Unused

talkFortLaramie1:
    ; 150 bytes
    .byte $20,$15,$80,$79,$37,$05,$e3,$18,$e5,$1b,$02
    .byte $11,$26,$d1,$1a,$0d,$dd,$0e
    .byte $12,$80,$0f,$e1,$05,$d6,$02
    .byte $33,$53,$15,$40,$d3,$09,$ea,$e3,$44,$d6,$79,$13,$02,$d7,$38,$d4
    .byte $22,$54,$55,$54,$04,$da,$09,$92,$e1,$1d,$02,$e6,$13,$02
    .byte $62,$52,$36,$52,$24,$64,$37,$e2,$2c,$46,$36,$01,$16,$db,$13,$e3,$02,$1d,$02,$12,$eb,$eb,$17,$ea,$82,$10,$e3,$02,$01,$05,$01,$14,$d7,$38,$02,$d0
    .byte $32,$26,$27,$44,$31,$29,$57,$0e,$49,$d7,$4b,$d1,$05,$71,$d0,$0f,$31,$d4,$da
    .byte $41,$53,$44,$44,$70,$d2,$03,$67,$4b,$06,$37,$7a,$1b,$df,$26,$01,$01,$12,$d7,$0d,$dd,$06,$e2
    .byte $32,$23,$35,$34,$2e,$e8,$03,$d2,$05,$70,$0d,$d4,$01,$10,$34,$d4
    .byte $00

talkFortLaramie2:
    ; 146 bytes
    .byte $20,$18,$30,$2a,$03,$dd,$22,$04,$dc,$05
    .byte $72,$5a,$76,$37,$47,$59,$23,$90,$01,$06,$1f,$41,$0b,$d7,$07,$dd,$3e,$08,$d3,$04,$d6,$30,$19,$20,$01,$02,$de,$55,$d8,$06,$da,$2b,$e6,$2b,$01,$04,$d6,$40,$03,$32,$66,$e5,$1d,$04,$d6,$04,$01,$11,$03,$dd,$22,$04,$e2
    .byte $31,$24,$54,$25,$17,$d6,$10,$e2,$79,$d5,$63,$d2,$38,$d3,$3f,$01,$02,$d4
    .byte $22,$42,$36,$3a,$0b,$04,$01,$06,$5f,$dc,$02
    .byte $83,$41,$88,$39,$34,$23,$43,$69,$34,$dc,$05,$e8,$13,$18,$e5,$1b,$02,$d2,$19,$20,$04,$d6,$01,$11,$03,$dd,$22,$04,$e2,$0a,$38,$13,$d4,$04,$01,$23,$08,$e1,$33,$90,$78,$e3,$0b,$e2,$2b,$e6,$d1,$03,$84,$05,$d3,$44,$0e
    .byte $00

talkFortLaramie3:
    ; 134 bytes
    .byte $20,$15,$50,$36,$d8,$03,$e7,$d1,$18,$51
    .byte $52,$36,$33,$67,$23,$50,$01,$16,$79,$73,$08,$41,$01,$11,$07,$22,$db,$0b,$11,$d8,$06,$15,$01,$06,$d8,$03,$e7
    .byte $52,$15,$38,$24,$36,$13,$d8,$e6,$03,$67,$2b,$01,$06,$17,$13,$d4,$0a,$b9,$0c,$05,$ae,$79,$73,$d4,$34,$10
    .byte $42,$31,$45,$61,$53,$29,$72,$33,$e5,$0b,$3a,$02,$b9,$0c,$0e,$d0,$2f,$17,$11,$05
    .byte $61,$31,$34,$35,$32,$25,$25,$d0,$0c,$d8,$36,$da,$d5,$19,$dc,$01,$1a,$d7,$17,$11,$05,$12,$0a,$db,$08,$e5,$11,$08,$db,$09,$d4
    .byte $32,$32,$52,$75,$05,$d3,$0a,$db,$08,$e5,$11,$e8,$29,$4e,$2c,$de,$2c,$09,$d4
    .byte $00

talkIndependenceRock1:
    ; 142 bytes
    .byte $20,$47,$40,$d0,$35,$e3,$41,$d1,$14,$d2,$36,$34,$e2
    .byte $53,$26,$26,$25,$55,$47,$2b,$29,$98,$02,$07,$1c,$d4,$06,$d4,$07,$c6,$06,$d7,$d5,$9f,$17,$e2,$04,$d2,$24,$07,$59,$0d,$2a,$d8,$d4
    .byte $11,$52,$5c,$06,$5e,$d4
    .byte $a3,$33,$64,$26,$42,$44,$44,$43,$56,$24,$40,$29,$72,$ea,$d3,$18,$01,$02,$33,$e5,$11,$e8,$db,$0d,$d3,$02,$ac,$0c,$15,$d5,$28,$b6,$30,$da,$08,$0f,$01,$05,$33,$51,$03,$48,$2a,$06,$d2,$0d,$e5,$0e,$09,$01,$13,$19,$55
    .byte $11,$40,$31,$0c
    .byte $62,$31,$54,$64,$33,$62,$60,$e3,$12,$36,$d8,$21,$7e,$07,$14,$d7,$d4,$02,$e8,$01,$05,$d0,$0c,$01,$1f,$18,$e5,$06,$e6,$16,$d0,$20,$0e
    .byte $00

talkIndependenceRock2:
    ; 144 bytes
    .byte $10,$35,$d1,$a3,$db,$03,$d8,$d4
    .byte $23,$76,$50,$d6,$28,$d3,$52,$16,$db,$13,$e3,$02,$1d,$02
    .byte $43,$74,$53,$57,$60,$d6,$28,$d3,$52,$06,$05,$6d,$d8,$0c,$e2,$05,$d3,$2f,$17,$d4,$29,$4e,$2c,$5d,$da,$e4,$0c,$e2
    .byte $72,$32,$53,$a6,$25,$3b,$62,$54,$2b,$e6,$e6,$14,$db,$34,$d1,$01,$06,$31,$10,$e6,$13,$02,$91,$0c,$23,$0a,$d2,$19,$20,$01,$14,$09,$e3,$04,$0b,$22,$67,$1d,$3b,$08,$32,$03,$01,$df,$d0,$20
    .byte $21,$46,$37,$09,$d2,$08,$d2,$19,$20,$01,$02,$de,$55,$d8,$06
    .byte $52,$54,$15,$74,$35,$56,$31,$ea,$0c,$dc,$4a,$08,$0f,$d4,$16,$d3,$06,$d2,$0b,$e3,$04,$0a,$01,$1f,$41,$0b,$e1,$1d,$02,$91,$0c,$23
    .byte $00

talkIndependenceRock3:
    ; 144 bytes
    .byte $20,$15,$30,$27,$03,$dd,$d6,$64,$e8
    .byte $61,$16,$24,$32,$34,$2c,$40,$39,$0d,$e5,$0e,$49,$dd,$2a,$1a,$27,$3f,$01,$06,$3b,$d4,$15,$04,$d3,$16,$0b,$d3,$0b,$d2,$02,$de,$55
    .byte $22,$43,$30,$dd,$08,$e1,$01,$d4,$0a,$df
    .byte $43,$53,$82,$52,$50,$01,$02,$08,$41,$d7,$35,$54,$0e,$e2,$15,$dd,$2a,$06,$3f,$01,$02,$d4
    .byte $81,$36,$44,$62,$83,$33,$82,$65,$47,$01,$d4,$38,$d3,$06,$e3,$09,$06,$e6,$02,$14,$0d,$e5,$0e,$52,$dc,$03,$dd,$22,$04,$dc,$0b,$05,$56,$66,$e3,$18,$ba,$02,$e2,$eb,$eb,$d5,$2a,$03,$bb,$2a,$06,$8b,$da,$24,$e1,$11,$09,$e3
    .byte $11,$a0,$d1,$09,$dd,$3a,$d8,$0c,$d4
    .byte $13,$36,$05,$a0,$06,$dc,$10
    .byte $00

talkSouthPass1:
    ; 143 bytes
    .byte $20,$27,$60,$05,$0d,$83,$d0,$a5,$04,$44,$05
    .byte $62,$43,$53,$57,$35,$56,$43,$2f,$0b,$01,$1a,$d7,$17,$11,$05,$d5,$3c,$0f,$d2,$19,$20,$0e,$03,$e1,$db,$05,$43,$01,$d4,$3c,$e6,$1e,$09,$68,$02,$24,$1a
    .byte $42,$34,$53,$52,$57,$2b,$e6,$01,$23,$d2,$19,$e6,$d3,$01,$10,$18,$25,$04,$d6,$e1,$08,$bc,$5f,$d1,$02,$e2
    .byte $42,$34,$2a,$45,$47,$01,$1b,$05,$d3,$12,$58,$02,$d6,$18,$e9,$0e,$26,$01,$01,$d4,$3c,$dc,$05,$e8,$05,$34,$2c,$e2
    .byte $54,$23,$53,$54,$23,$40,$8a,$05,$e8,$2f,$17,$11,$0b,$0f,$d8,$0c,$db,$1d,$d4,$04,$01,$d4,$08,$0f
    .byte $32,$26,$42,$60,$49,$df,$4c,$2d,$10,$2c,$da,$15,$dc,$58,$04,$d6
    .byte $00

talkSouthPass2:
    ; 126 bytes
    .byte $20,$15,$40,$27,$03,$dd,$d6,$d6,$3c,$db
    .byte $72,$26,$24,$43,$23,$74,$52,$46,$49,$a1,$01,$02,$12,$e5,$02,$b7,$39,$da,$05,$85,$08,$e1,$02,$06,$e3,$04,$21,$02,$d4,$35,$e3,$25,$d7,$1f,$10,$82,$10,$e3,$02
    .byte $62,$24,$47,$34,$33,$63,$80,$31,$33,$e5,$45,$d4,$0b,$9c,$3e,$04,$d6,$0a,$8f,$0d,$d3,$05,$d3,$03,$a2,$08,$db,$01,$33,$20,$e4,$4e,$02,$0e
    .byte $41,$42,$62,$42,$65,$2f,$0b,$49,$a1,$01,$02,$12,$40,$db,$d4,$0a,$e3,$18,$e5,$1b,$1e,$d0,$04
    .byte $42,$24,$22,$16,$40,$e6,$1a,$d8,$0c,$d6,$de,$13,$36,$db,$3d,$02,$df,$30,$d4
    .byte $00

talkSouthPass3:
    ; 152 bytes
    .byte $20,$16,$80,$2a,$07,$dc,$09,$e3,$18,$e5,$1b,$02
    .byte $b2,$26,$31,$64,$25,$82,$36,$23,$54,$42,$49,$70,$49,$d5,$2a,$25,$e8,$05,$d3,$17,$18,$e5,$1b,$26,$01,$f5,$f1,$de,$01,$02,$d5,$2a,$25,$d8,$06,$0a,$01,$3a,$d0,$0c,$23,$15,$01,$1f,$e1,$08,$32,$2c,$59,$4a,$d4,$0a,$e2,$9d,$da,$e1,$1b,$a3,$d8,$03,$61,$41,$0e,$37
    .byte $11,$44,$d1,$30,$da,$08,$0f
    .byte $22,$73,$a0,$dc,$07,$dc,$09,$e2,$0d,$16,$02,$e2,$14,$a4,$0e
    .byte $11,$24,$04,$e4,$22,$d7
    .byte $41,$54,$82,$51,$39,$31,$ea,$0c,$d9,$de,$04,$0a,$69,$01,$02,$0a,$29,$25,$d3,$05,$1a,$d2,$37,$dc,$35,$17,$e8
    .byte $32,$86,$44,$40,$1c,$05,$d6,$04,$93,$06,$02,$e3,$04,$0a,$d5,$0d,$dc,$db,$05,$d3
    .byte $00

talkFortBridger1:
    ; 145 bytes
    .byte $10,$47,$d0,$35,$e3,$41,$d1,$14,$97
    .byte $33,$29,$53,$86,$e6,$06,$d7,$03,$67,$ea,$e5,$10,$4a,$0b,$01,$06,$e4,$5c,$10,$e3,$14,$e4,$0a,$4e
    .byte $72,$36,$24,$45,$34,$24,$23,$40,$2b,$e3,$0b,$03,$21,$13,$01,$12,$d5,$07,$75,$07,$01,$01,$10,$34,$d4,$17,$0a,$de,$da,$0a,$69,$01,$02,$d4
    .byte $23,$33,$a6,$05,$d3,$01,$d4,$03,$e3,$18,$69,$03,$e2,$65,$39,$06
    .byte $31,$63,$32,$30,$d5,$28,$d3,$ea,$e2,$2b,$77,$17,$0a,$08,$e3
    .byte $22,$44,$33,$b2,$1c,$db,$06,$70,$27,$d5,$07
    .byte $63,$47,$43,$73,$35,$24,$34,$e2,$37,$24,$38,$86,$ea,$43,$d4,$0c,$01,$14,$4d,$01,$06,$15,$d5,$03,$e1,$d1,$30,$86,$2e,$31,$ea,$71,$10,$01,$11
    .byte $00

talkFortBridger2:
    ; 151 bytes
    .byte $20,$1d,$50,$13,$3c,$0e,$eb,$db,$28,$da,$04,$d6,$e6,$37,$05
    .byte $62,$35,$72,$17,$54,$24,$70,$09,$14,$d7,$25,$a0,$19,$8e,$0e,$04,$36,$e6,$de,$0c,$0b,$d2,$41,$d4,$da,$08,$e2,$0a,$4e,$07,$59,$0d,$2a,$d8,$d4
    .byte $42,$27,$42,$74,$c4,$49,$d7,$4b,$d1,$05,$d3,$44,$0e,$15,$46,$df,$a5,$3b,$dd,$08,$e1,$04,$d3,$16,$0b,$d3,$0b,$d2,$02,$de,$55
    .byte $42,$31,$65,$42,$48,$2b,$e6,$17,$18,$e5,$1b,$2c,$09,$1a,$d8,$01,$49,$d5,$1d,$14,$d7,$25,$54,$0b
    .byte $11,$36,$01,$d4,$1b,$d3,$06,$e3
    .byte $11,$50,$d2,$2c,$45
    .byte $12,$26,$12,$1b,$3a,$0b
    .byte $52,$14,$52,$13,$62,$56,$2e,$08,$a2,$d4,$ea,$0c,$d1,$08,$dc,$05,$d1,$24,$07,$1a,$02,$08,$1c,$07,$1f,$09
    .byte $00

talkFortBridger3:
    ; 124 bytes
    .byte $10,$16,$13,$18,$d3,$02
    .byte $42,$44,$35,$23,$70,$01,$12,$d5,$07,$75,$36,$29,$25,$e3,$52,$d9,$34,$d1,$e1,$3b,$d6,$02
    .byte $a2,$33,$18,$36,$23,$24,$a4,$35,$52,$63,$b0,$d9,$34,$e6,$36,$2a,$03,$dd,$22,$04,$dc,$05,$d1,$24,$07,$7a,$16,$a4,$04,$01,$12,$5c,$30,$da,$5e,$d8,$01,$3e,$6b,$05,$43,$bd,$0c,$0f,$07,$d4,$0a,$e2,$3f,$2d,$e8,$01,$4c,$e5,$02,$db,$05,$d3,$02,$e2
    .byte $31,$41,$35,$26,$8a,$06,$40,$a3,$e3,$18,$6a,$04,$d7,$07,$e2,$06
    .byte $21,$33,$37,$d9,$34,$05,$6d,$12,$df,$0d,$bc,$02
    .byte $12,$70,$e5,$36,$7f,$d4,$e9
    .byte $00

talkGreenRiver1:
    ; 136 bytes
    .byte $20,$15,$30,$27,$03,$dd,$d6,$64,$e8
    .byte $42,$26,$63,$64,$2c,$49,$d5,$2a,$25,$6f,$3b,$dd,$ea,$e3,$29,$e8,$0b,$03,$21,$d5,$28,$d3,$04,$04,$d3,$16,$0b,$d3,$0b,$80
    .byte $52,$24,$46,$45,$75,$47,$31,$33,$e5,$45,$d4,$0b,$08,$e3,$04,$d6,$e5,$02,$e8,$5e,$d0,$0c,$e1,$13,$d8,$09,$20,$04,$d2,$24,$07,$59,$0d,$2a,$d8,$d4
    .byte $42,$72,$43,$62,$40,$d1,$14,$d0,$4b,$d4,$15,$01,$13,$03,$a2,$08,$db,$01,$12,$df,$de,$07
    .byte $31,$26,$38,$50,$49,$5b,$0f,$02,$33,$5e,$03,$dd,$22,$04,$d5,$3a,$02
    .byte $42,$25,$74,$31,$50,$a6,$31,$ea,$e1,$06,$0a,$ba,$0e,$d7,$02,$24,$07,$d0,$2f,$25,$d4
    .byte $00

talkGreenRiver2:
    ; 142 bytes
    .byte $20,$18,$60,$36,$a5,$3e,$09,$d8,$04,$44,$05
    .byte $41,$46,$57,$67,$40,$2f,$0b,$e6,$1e,$09,$61,$3c,$0f,$0f,$0d,$e3,$0e,$d2,$37,$04,$d6,$01,$e1,$03,$21,$d7,$02,$d4
    .byte $22,$23,$34,$e6,$0e,$3b,$2b,$7e,$04,$d3
    .byte $a2,$24,$52,$42,$54,$34,$43,$93,$44,$53,$60,$31,$3a,$0b,$d5,$03,$84,$17,$d6,$28,$d3,$0a,$e3,$18,$d3,$1f,$2a,$d4,$05,$56,$12,$d7,$26,$01,$01,$10,$18,$e5,$1b,$02,$e2,$05,$6d,$1b,$df,$01,$11,$d2,$19,$20,$01,$02,$1d,$02,$e2
    .byte $72,$35,$33,$45,$33,$36,$43,$70,$2b,$e6,$01,$02,$08,$41,$0a,$37,$05,$e8,$2f,$17,$11,$0b,$05,$d3,$0a,$38,$17,$59,$1b,$05,$56,$07,$d6,$18,$e9,$04,$d6
    .byte $00

talkGreenRiver3:
    ; 138 bytes
    .byte $10,$35,$d1,$a3,$db,$03,$d8,$d4
    .byte $54,$47,$25,$24,$35,$50,$d5,$1d,$0e,$de,$0c,$0d,$e2,$0a,$d5,$02,$42,$4b,$58,$02,$01,$1f,$41,$0b,$e1,$1d,$02
    .byte $43,$5b,$41,$77,$69,$01,$5d,$24,$02,$42,$dc,$0b,$ea,$0c,$dc,$4a,$08,$d7,$35,$54,$0e,$8a,$0c,$0d,$82,$24,$07,$45,$e1,$08,$da,$a1,$0f
    .byte $82,$54,$45,$52,$41,$52,$43,$53,$70,$31,$ea,$0c,$4f,$16,$d3,$3d,$dd,$e1,$1d,$02,$35,$e3,$25,$e6,$24,$04,$99,$2d,$30,$d4,$0a,$d5,$07,$d3,$03,$50,$1e,$09,$05,$d3,$05,$34,$2c,$e2
    .byte $31,$46,$52,$44,$2f,$13,$db,$17,$59,$11,$09,$23,$31,$33,$e5,$1b,$24,$e3
    .byte $13,$54,$31,$ea,$0c,$4f,$16
    .byte $00

