; First header byte:
; %00000000
;  ||||++++ Type of punctiation- {' ': 0, ',': 1, '.': 2, '!': 3, '?': 4}
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
; $01 - $d1: Dictionary
; $d2 - $eb: Literal A-Z
; $ec - $f5: Literal special chars: ["'", '-', '"', ';', ':', '.', ',', '…', '(', ')']
; $f6 - $ff: Unused

talkSnakeRiver1:
    ; 139 bytes
    .byte $20,$17,$40,$52,$e3,$04,$e5,$4f,$1b,$d7,$d6
    .byte $c1,$24,$54,$23,$7a,$44,$42,$62,$53,$23,$92,$35,$50,$14,$e4,$2f,$e4,$60,$1e,$01,$02,$d6,$03,$01,$06,$d9,$17,$1f,$ea,$82,$3d,$41,$2c,$dc,$f0,$ee,$ea,$05,$de,$3a,$01,$3c,$d6,$04,$03,$2e,$04,$08,$e1,$22,$e0,$4c,$05,$23,$01,$16,$15,$1c,$03,$5b,$18,$01,$06,$df,$40,$02,$17,$02
    .byte $83,$25,$92,$39,$c3,$27,$72,$87,$15,$14,$bc,$03,$80,$04,$d8,$02,$05,$e4,$39,$27,$b9,$02,$d7,$16,$5f,$ea,$37,$d5,$02,$e4,$08,$ae,$f1,$ee,$2b,$e5,$3f,$d9,$3a,$d3,$04,$d5,$03,$e4,$10,$33,$09,$d4,$15,$1c,$03,$d8,$1b,$01,$05,$1d,$82,$3d,$d6
    .byte $00

talkSnakeRiver2:
    ; 141 bytes
    .byte $10,$2a,$04,$46,$02,$dd,$04,$d5,$02
    .byte $41,$45,$75,$54,$60,$d5,$38,$df,$01,$02,$41,$11,$2a,$0c,$01,$51,$06,$d1,$1a,$a0,$73,$d8,$07,$d8,$06
    .byte $21,$83,$80,$76,$10,$e5,$03,$d8,$04,$8f,$60,$01,$03,$d8
    .byte $22,$23,$55,$10,$01,$06,$df,$40,$02,$17,$02
    .byte $53,$24,$52,$32,$42,$32,$e4,$35,$e6,$24,$12,$e5,$02,$ed,$ed,$04,$4a,$9e,$0e,$d5,$08,$d8,$11,$08
    .byte $41,$53,$45,$26,$66,$2a,$ec,$e7,$21,$e0,$71,$04,$93,$22,$06,$18,$d5,$06,$02,$66,$26,$07,$d6,$07,$21,$09
    .byte $63,$22,$42,$44,$54,$23,$80,$81,$d3,$06,$e6,$48,$08,$91,$0b,$ea,$05,$e3,$12,$e5,$02,$dc,$21,$e4,$23,$01,$16,$15,$1c,$03,$d8
    .byte $00

talkSnakeRiver3:
    ; 141 bytes
    .byte $10,$35,$d3,$90,$dd,$05,$da,$d6
    .byte $24,$34,$45,$e4,$8b,$01,$23,$1b,$dd,$4e,$17,$02
    .byte $22,$63,$50,$01,$23,$ec,$e4,$01,$06,$df,$40,$d6
    .byte $52,$41,$74,$72,$37,$60,$de,$04,$ea,$4b,$19,$b0,$ec,$74,$d6,$0c,$e4,$12,$b6,$0d,$03,$d9,$02,$d7,$e0,$29,$03,$d8,$19,$e1,$3d,$e4
    .byte $43,$36,$63,$33,$26,$d9,$02,$12,$e5,$02,$13,$19,$e7,$1f,$d2,$0b,$01,$d6,$12,$ea,$08,$07,$21,$09
    .byte $31,$52,$83,$40,$2a,$ec,$0b,$d3,$16,$15,$1c,$03,$1e,$02,$81,$09
    .byte $32,$34,$55,$45,$04,$d5,$01,$0c,$d2,$3b,$03,$52,$e5,$02,$d7,$07,$66,$e0,$10,$d6
    .byte $33,$44,$23,$80,$1d,$dc,$16,$0e,$0a,$e5,$01,$16,$15,$1c,$03,$d8
    .byte $00

talkFortBoise1:
    ; 148 bytes
    .byte $10,$5a,$db,$4b,$e0,$d3,$d9,$18,$13,$0a,$d5,$02
    .byte $11,$55,$36,$02,$ea,$72,$1e,$e5
    .byte $41,$46,$14,$43,$55,$36,$0c,$01,$05,$1e,$da,$d2,$24,$26,$15,$de,$01,$0d,$2f,$ec,$e4,$08,$22,$e4
    .byte $82,$24,$26,$46,$23,$44,$42,$3a,$60,$3f,$d9,$0a,$d5,$10,$91,$0b,$0d,$1b,$01,$4e,$0a,$a3,$18,$01,$02,$da,$24,$d7,$0e,$c7,$04,$d5,$18,$01,$d6,$1b,$0b,$29,$11,$e5,$36,$d2,$0b,$20
    .byte $31,$14,$56,$14,$da,$1b,$0b,$2b,$22,$d5,$3f,$e4,$1f,$d7,$52,$03,$d6
    .byte $62,$89,$23,$37,$42,$46,$45,$d9,$04,$4a,$35,$7d,$35,$06,$e5,$0a,$d5,$ed,$ed,$04,$2e,$ec,$de,$d4,$02,$1d,$03,$da,$ec,$0b,$d3,$02,$da,$24,$1b,$01,$03,$d7,$17,$20,$0a,$85
    .byte $00

talkFortBoise2:
    ; 151 bytes
    .byte $30,$16,$41,$50,$23,$19,$d5,$02,$1b,$01,$f7,$de,$5c,$06
    .byte $51,$63,$33,$54,$44,$90,$ea,$05,$ec,$0b,$27,$68,$11,$ea,$02,$12,$d8,$09,$46,$02,$01,$0f,$58,$e6,$0f,$05,$df,$1d,$03,$e4
    .byte $12,$60,$de,$10,$e5,$02
    .byte $13,$52,$dd,$0a,$6f,$14
    .byte $42,$53,$54,$44,$70,$d4,$15,$1c,$ea,$02,$d8,$2c,$4a,$46,$02,$1b,$01,$8d,$32,$04,$2d,$28,$e4
    .byte $42,$37,$16,$24,$50,$d8,$11,$ea,$02,$e4,$1f,$d7,$4b,$05,$30,$d6,$18,$d8,$2c,$9a,$5c,$06
    .byte $83,$62,$66,$35,$24,$24,$53,$54,$46,$a1,$16,$06,$18,$12,$d8,$09,$7f,$14,$e5,$02,$01,$11,$19,$22,$ed,$ed,$dd,$26,$e5,$4d,$01,$0f,$d7,$31,$ad,$25,$ae,$09,$ec,$01,$d6,$0d,$d8,$2c,$d5,$54,$e7,$4f,$d6
    .byte $00

talkFortBoise3:
    ; 131 bytes
    .byte $10,$47,$d2,$37,$6e,$41,$16,$83
    .byte $31,$25,$45,$35,$23,$36,$02,$7c,$07,$1d,$dd,$09,$d8,$01,$11,$19,$22
    .byte $53,$64,$46,$42,$38,$40,$6a,$4f,$06,$34,$e7,$41,$d6,$0c,$d9,$da,$1e,$02,$01,$04,$23,$01,$1a,$e3,$36,$da,$05,$57,$07,$e5
    .byte $23,$42,$a0,$01,$10,$10,$05,$e5,$19,$5d,$05,$e4
    .byte $33,$76,$92,$20,$01,$20,$ec,$e3,$11,$40,$03,$3b,$d5,$e7,$04,$1d,$5d,$18,$3a
    .byte $51,$21,$33,$62,$22,$50,$39,$da,$34,$d5,$01,$16,$d9,$04,$69,$08,$70,$14,$d2,$3b,$03
    .byte $32,$33,$48,$2c,$da,$ec,$d5,$2b,$93,$07,$06,$43,$30,$da,$06,$03,$03,$d5,$1a,$0c,$d5,$0c,$69
    .byte $00

talkBlueMountains1:
    ; 148 bytes
    .byte $20,$15,$a0,$23,$3c,$0d,$46,$02,$dd,$04,$d5,$02
    .byte $41,$58,$35,$24,$50,$e4,$03,$d4,$16,$15,$1c,$03,$d8,$01,$06,$df,$40,$0a,$79,$07,$66,$e0,$10,$d6
    .byte $32,$44,$49,$36,$14,$ec,$74,$d6,$0c,$75,$13,$de,$05,$df,$1d,$03,$e4,$04,$a9,$06,$02,$e5
    .byte $52,$46,$43,$23,$62,$50,$b1,$13,$6d,$1a,$02,$0a,$24,$d5,$2f,$ed,$ed,$55,$e9,$03,$24,$06,$23,$e5,$2d,$06
    .byte $11,$26,$27,$e5,$19,$32,$e4
    .byte $22,$46,$24,$75,$13,$d4,$dd,$05,$4a,$18,$b1,$13
    .byte $51,$46,$62,$34,$58,$35,$de,$04,$cd,$23,$5f,$16,$96,$dc,$0d,$09,$01,$0d,$e6,$13,$52,$e5,$02,$e4,$1b,$de,$de,$03,$d8,$01,$02,$17,$02
    .byte $22,$44,$34,$01,$0c,$58,$0d,$04,$d5,$2e,$0d
    .byte $00

talkBlueMountains2:
    ; 146 bytes
    .byte $10,$67,$de,$0e,$72,$06,$e5,$45,$0e,$e5
    .byte $92,$28,$34,$23,$64,$45,$23,$a4,$23,$49,$e8,$26,$e0,$0b,$38,$0d,$01,$d6,$0d,$5d,$18,$01,$0d,$06,$02,$79,$15,$bb,$07,$66,$e0,$10,$d6,$08,$01,$26,$07,$d3,$3d,$d5,$03,$d8,$12,$0b,$18,$01,$41,$dd,$e6,$0f,$05,$df,$1d,$03,$e4
    .byte $33,$35,$48,$50,$01,$7d,$da,$0b,$aa,$02,$0d,$e3,$0a,$5a,$5c,$13,$d6,$1a
    .byte $41,$74,$63,$64,$40,$53,$32,$03,$d8,$98,$01,$25,$d6,$1f,$e4,$04,$b2,$35,$03,$80,$38,$df,$7f,$38
    .byte $22,$23,$44,$e8,$21,$84,$d5,$38,$df,$e4,$52,$d6
    .byte $13,$47,$e1,$e0,$07,$04,$2d,$28,$e4
    .byte $32,$25,$25,$34,$27,$d8,$19,$1c,$07,$12,$e5,$02,$d7,$07,$d5,$2f,$e4
    .byte $00

talkBlueMountains3:
    ; 146 bytes
    .byte $10,$5a,$db,$4b,$e0,$d3,$d9,$18,$13,$0a,$d5,$02
    .byte $82,$46,$23,$65,$23,$49,$54,$42,$60,$01,$10,$73,$0b,$20,$18,$01,$21,$e3,$04,$d5,$02,$09,$6d,$10,$01,$0f,$e0,$13,$d3,$0a,$ac,$39,$5c,$55,$1e,$61,$ec,$e7,$06,$d6,$0c,$03,$de,$09,$01,$e4
    .byte $33,$53,$52,$90,$12,$e5,$02,$04,$d5,$d8,$19,$eb,$d6,$03,$d2,$2b,$8c,$04,$69
    .byte $41,$32,$46,$22,$40,$04,$2e,$d7,$01,$10,$73,$0b,$20,$10,$e4,$18,$03,$d6
    .byte $43,$3a,$42,$52,$40,$01,$d6,$1b,$0b,$29,$11,$e5,$0f,$e6,$13,$d3,$11,$1b,$d4,$0a,$57,$03,$d6
    .byte $43,$52,$76,$23,$39,$2a,$ec,$0b,$d3,$06,$14,$e5,$03,$ec,$6a,$11,$4c,$03,$05,$50,$d6,$25,$35,$06,$e5,$0a,$d5
    .byte $00

talkFortWallaWalla1:
    ; 148 bytes
    .byte $20,$15,$60,$2f,$05,$df,$d8,$a5,$01,$02
    .byte $52,$48,$24,$27,$53,$75,$da,$ec,$e7,$11,$19,$e7,$1f,$0d,$03,$d7,$0a,$15,$d7,$03,$2e,$04,$1c,$03,$69,$05,$e3,$db,$05,$50,$20,$d3,$21,$04
    .byte $32,$22,$35,$43,$44,$18,$ea,$11,$2a,$ec,$e7,$06,$d6,$0c,$d7,$45
    .byte $62,$52,$36,$25,$62,$42,$a0,$01,$51,$45,$0f,$d6,$01,$1f,$e1,$0d,$3a,$d4,$15,$1c,$e3,$17,$02,$e4,$07,$e4,$31,$d5,$3a,$e7,$21,$11,$47,$dd,$06
    .byte $22,$51,$40,$13,$da,$0b,$39,$0a,$e3
    .byte $62,$44,$57,$35,$72,$82,$59,$da,$ec,$e7,$02,$0a,$d5,$d8,$19,$e7,$0f,$0e,$dc,$02,$e4,$04,$63,$0a,$af,$13,$07,$da,$06,$18,$a8,$0b,$03,$5b,$03,$01,$06,$0f,$05,$df,$1d,$03,$e4
    .byte $00

talkFortWallaWalla2:
    ; 149 bytes
    .byte $10,$3b,$29,$ea,$1b,$01,$02,$8a,$e0,$09
    .byte $72,$26,$93,$32,$38,$83,$42,$97,$3f,$d4,$05,$e4,$03,$83,$01,$02,$03,$d6,$12,$e4,$09,$d6,$18,$55,$e9,$24,$22,$4e,$0c,$07,$e1,$d9,$04,$0d,$04,$62,$26,$1d,$e5,$25,$14,$de,$04,$ec,$5e,$10,$55,$09
    .byte $62,$54,$43,$55,$25,$38,$48,$dd,$17,$0d,$1b,$01,$01,$0f,$d7,$07,$01,$48,$20,$0a,$85,$ed,$ed,$37,$e5,$22,$01,$0f,$d2,$1c,$4b,$e3,$1f,$d2,$13,$27,$e7,$0f,$d3,$02
    .byte $21,$33,$8a,$42,$d6,$34,$1c,$64,$e7,$17,$0d,$7e,$40,$41,$14,$06
    .byte $11,$90,$13,$29,$e1,$0d,$06
    .byte $11,$50,$8e,$0b,$e4
    .byte $42,$62,$32,$71,$80,$91,$1e,$33,$ed,$ed,$27,$e5,$08,$de,$0c,$61,$09,$29,$d2,$1c,$4b,$48
    .byte $00

talkFortWallaWalla3:
    ; 148 bytes
    .byte $20,$16,$60,$4b,$2f,$3a,$d6,$03,$2e,$04
    .byte $32,$33,$53,$78,$ea,$05,$44,$dc,$47,$05,$e5,$01,$d6,$25,$14,$de,$04,$ca,$1c,$4b,$48
    .byte $74,$13,$33,$69,$83,$34,$28,$80,$da,$44,$dc,$ea,$05,$25,$ea,$70,$d4,$e5,$07,$25,$14,$de,$04,$ec,$5e,$0d,$4f,$03,$0d,$3d,$27,$7a,$64,$0f,$ea,$59,$e0,$30,$d6,$ec,$e4,$24,$22,$4e,$0c
    .byte $42,$46,$37,$43,$90,$de,$04,$ea,$83,$e6,$1e,$e5,$01,$0f,$0a,$7f,$06,$d7,$15,$de,$01,$06,$6e,$04,$d8,$02,$e4
    .byte $74,$33,$38,$63,$83,$43,$82,$56,$25,$ea,$2e,$d5,$01,$0f,$0d,$4f,$03,$1a,$e0,$10,$09,$05,$e3,$24,$22,$4e,$0c,$04,$b2,$e6,$48,$01,$16,$d9,$22,$4e,$0c,$18,$25,$14,$1a,$89,$30,$d6
    .byte $00

