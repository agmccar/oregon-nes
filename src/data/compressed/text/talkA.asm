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

talkIndependence1:
    ; 148 bytes
    .byte $20,$14,$80,$d2,$09,$6c,$e3,$06,$3d,$0c,$e5
    .byte $83,$45,$42,$54,$34,$36,$23,$42,$60,$e4,$35,$27,$31,$dc,$1c,$d6,$0f,$09,$01,$03,$dc,$01,$23,$77,$2c,$e9,$0c,$0e,$d6,$0c,$05,$1e,$09,$d8,$11,$01,$0f,$09,$07,$21,$08
    .byte $51,$34,$36,$41,$56,$50,$77,$2c,$e9,$0c,$d4,$04,$d3,$0e,$1f,$93,$47,$0a,$94,$0b,$ea,$53,$54,$0d,$12,$d8,$08
    .byte $51,$32,$32,$44,$42,$40,$04,$2e,$d7,$08,$d6,$18,$01,$0f,$d8,$11,$1c,$da,$32,$07,$2e,$06
    .byte $32,$35,$25,$80,$ea,$05,$e8,$08,$ec,$67,$21,$e0,$03,$d8,$04,$ea,$25,$02,$d6
    .byte $42,$18,$28,$44,$43,$da,$e8,$05,$68,$df,$ec,$69,$2c,$e7,$02,$dd,$04,$d5,$1b,$01,$dd,$06,$e4,$01,$04,$55,$e9
    .byte $00

talkIndependence2:
    ; 143 bytes
    .byte $20,$16,$53,$23,$19,$d5,$02,$df,$29,$0d,$db,$2d
    .byte $32,$64,$54,$28,$d3,$11,$e5,$02,$1d,$56,$6d,$e5,$19,$e4,$11,$e4,$18,$d4,$53,$01,$03,$d8
    .byte $41,$53,$27,$35,$a0,$e5,$19,$6e,$ec,$0f,$09,$03,$2e,$04,$57,$07,$95,$06,$d9,$e7,$21,$11,$48,$dd,$06
    .byte $22,$42,$40,$d7,$10,$d9,$07,$de,$0a,$e5
    .byte $52,$44,$56,$26,$52,$59,$14,$ec,$e4,$2a,$0b,$e8,$07,$01,$d9,$3c,$03,$d8,$04,$03,$2e,$04,$83,$3d,$0a,$6f,$17,$02,$d4,$15,$1c,$03,$58
    .byte $23,$62,$34,$6d,$e1,$16,$e5,$09,$e1,$2f,$01,$0f
    .byte $21,$75,$70,$01,$20,$ec,$e3,$06,$d9,$0e,$b4,$19,$d5,$02,$e4
    .byte $22,$36,$70,$26,$e5,$0a,$e4,$22,$ea,$24,$0a,$e5,$0d
    .byte $00

talkIndependence3:
    ; 150 bytes
    .byte $20,$19,$5a,$23,$19,$e7,$1f,$02,$f2,$de,$22,$06,$d9,$0c,$4e,$da,$32,$e4,$f2
    .byte $44,$33,$43,$8a,$50,$2e,$79,$05,$e3,$0a,$d5,$01,$0f,$10,$e4,$05,$e3,$3c,$1a,$e6,$59,$4f,$04,$09,$d5,$2f
    .byte $51,$64,$45,$36,$78,$55,$ed,$ed,$e4,$2f,$1c,$35,$27,$31,$dc,$13,$0e,$7a,$07,$07,$21,$08,$1b,$01,$05,$7b,$0e,$3e,$03,$58,$e1,$0e,$1a,$0e,$33
    .byte $32,$34,$25,$54,$26,$e5,$36,$0c,$04,$6d,$e5,$19,$12,$d8,$08,$d2,$e9,$dd,$d6
    .byte $33,$45,$44,$25,$b6,$13,$01,$03,$dc,$01,$20,$d8,$15,$e8,$08,$e5,$50,$06
    .byte $52,$47,$56,$24,$29,$50,$96,$5a,$01,$20,$ec,$e3,$1f,$e6,$32,$ea,$0c,$05,$1e,$09,$d7,$03,$d5,$04,$48,$04,$d5,$08,$0d,$12,$d8,$08
    .byte $00

talkKansasRiver1:
    ; 151 bytes
    .byte $10,$18,$d2,$13,$e3,$04,$d8,$02
    .byte $32,$56,$24,$15,$d4,$04,$ec,$1d,$49,$07,$d5,$09,$1d,$dc,$0a,$d7,$02,$3e
    .byte $42,$56,$35,$41,$40,$2a,$ec,$e3,$0f,$40,$03,$d8,$05,$e3,$12,$d8,$08,$03,$09,$48,$e0,$23
    .byte $21,$54,$24,$2a,$ec,$0b,$e5,$46,$6a,$09,$e7,$02
    .byte $41,$53,$63,$54,$50,$84,$5d,$dc,$01,$41,$85,$09,$de,$04,$4a,$3d,$06,$1b,$01,$e1,$14,$24
    .byte $42,$33,$22,$53,$57,$04,$d5,$3a,$d6,$14,$09,$d7,$53,$23,$05,$e3,$d8,$2c,$4a,$4c,$d4,$15,$1c
    .byte $32,$42,$43,$70,$34,$70,$09,$e4,$1b,$de,$01,$d6,$04,$2d,$28,$e4
    .byte $53,$42,$74,$23,$74,$60,$96,$5a,$14,$71,$06,$df,$ec,$e5,$19,$03,$ed,$ed,$01,$02,$17,$02,$ec,$42,$da,$1e,$0c,$05,$1e
    .byte $00

talkKansasRiver2:
    ; 148 bytes
    .byte $20,$15,$80,$52,$02,$3e,$89,$02,$23,$07
    .byte $92,$53,$24,$35,$64,$35,$32,$53,$31,$44,$d5,$08,$ec,$97,$3e,$09,$d7,$07,$d5,$04,$ea,$e3,$17,$02,$6e,$1a,$02,$01,$04,$01,$d6,$12,$d8,$08,$d3,$0d,$ed,$ed,$48,$05,$e5,$77,$e0,$04,$7c,$d9,$28,$49,$d6,$11
    .byte $42,$65,$45,$34,$48,$ea,$05,$ec,$0b,$e4,$12,$b5,$ea,$05,$e3,$12,$d8,$08,$04,$62,$51,$20,$05,$86,$43,$30,$da,$06
    .byte $c3,$33,$53,$53,$35,$22,$22,$53,$42,$24,$45,$22,$50,$ea,$05,$d4,$04,$84,$5d,$dc,$01,$d6,$12,$d8,$08,$d3,$0d,$04,$5b,$53,$23,$14,$ed,$ed,$07,$d3,$06,$de,$0e,$e5,$04,$63,$3c,$0f,$d6,$09,$1d,$dc,$20,$05,$e3,$12,$d8,$08,$08,$3f,$d7,$02,$3e
    .byte $00

talkKansasRiver3:
    ; 150 bytes
    .byte $20,$47,$40,$d2,$37,$6f,$41,$16,$d4,$44,$2d,$e4
    .byte $61,$43,$62,$67,$23,$23,$50,$1b,$01,$01,$16,$15,$e8,$4a,$18,$5a,$e0,$30,$d6,$12,$14,$03,$d8,$09,$d8,$11,$08,$01,$27,$02,$3e
    .byte $43,$25,$28,$43,$40,$e8,$16,$05,$68,$d3,$06,$6f,$04,$d5,$0d,$d9,$02,$27,$07,$d5,$2f,$e4
    .byte $73,$47,$65,$33,$57,$23,$46,$54,$96,$5a,$01,$02,$d6,$ec,$e4,$0c,$05,$1e,$d8,$19,$eb,$27,$07,$d2,$0b,$01,$51,$d6,$04,$2d,$28,$e4,$ed,$ed,$26,$72,$04,$ea,$5a,$e0,$30,$16,$0e,$3e,$d7,$d6,$0d
    .byte $21,$36,$40,$da,$ec,$d5,$19,$01,$02,$12,$14
    .byte $11,$60,$01,$05,$1e
    .byte $43,$45,$21,$75,$40,$01,$04,$d4,$15,$1c,$03,$0e,$da,$32,$11,$ea,$12,$d8,$08,$98,$23
    .byte $00

talkBigBlueRiver1:
    ; 138 bytes
    .byte $30,$15,$67,$40,$d2,$e1,$0e,$4d,$dd,$0a,$d5,$02,$d9,$0a,$d5,$03,$d8,$0a,$13
    .byte $23,$53,$60,$2a,$ec,$70,$34,$d5,$0c,$05,$1e
    .byte $43,$55,$33,$3a,$35,$e1,$06,$dc,$7d,$99,$06,$d2,$0b,$d5,$2f,$04,$9a,$51,$9b,$da,$09,$06,$d2,$0b,$6a,$1e,$e5
    .byte $62,$46,$63,$26,$23,$23,$94,$14,$ec,$e4,$78,$01,$02,$d3,$40,$03,$58,$37,$07,$e0,$6b,$04,$e4,$18,$b6,$d5,$ed,$ed,$04,$4a,$35,$11,$2d,$06,$98,$01
    .byte $51,$54,$79,$27,$43,$30,$e8,$07,$3e,$47,$02,$03,$2e,$04,$e4,$23,$1d,$32,$03,$d8,$ed,$ed,$34,$e7,$0c,$ec,$33,$d6,$0c,$04,$ea,$ea,$11
    .byte $22,$35,$15,$2b,$e5,$13,$da,$0b,$9c,$07,$3e
    .byte $00

talkBigBlueRiver2:
    ; 152 bytes
    .byte $20,$15,$68,$28,$54,$ea,$f2,$de,$0e,$6a,$06,$e5,$45,$0e,$e5,$f2
    .byte $72,$47,$26,$64,$33,$47,$34,$70,$01,$10,$e1,$19,$3c,$da,$d6,$10,$87,$1e,$4d,$64,$11,$4d,$1b,$01,$d2,$0b,$01,$d6,$1b,$dd,$5b,$dd,$38,$02,$e4,$04,$d5,$1d,$0b,$d8,$19,$1c,$06
    .byte $33,$37,$34,$22,$2b,$e5,$01,$02,$d6,$ec,$e4,$09,$35,$e6,$24,$18,$14
    .byte $42,$14,$36,$14,$60,$2d,$10,$e4,$26,$01,$88,$03,$3b,$09,$6c,$df,$0a,$e3,$4b
    .byte $81,$16,$34,$45,$13,$14,$21,$44,$45,$da,$e8,$08,$d5,$02,$d9,$38,$de,$04,$9d,$2f,$e4,$37,$e5,$22,$10,$d6,$0a,$09,$6c,$ed,$ed,$d2,$09,$6c,$1b,$01,$e3,$0a,$dd,$42,$89,$e4
    .byte $11,$16,$d2,$24,$46,$24
    .byte $12,$80,$5a,$e0,$30,$d6,$f1,$f1
    .byte $00

talkBigBlueRiver3:
    ; 146 bytes
    .byte $30,$36,$15,$70,$d3,$90,$dd,$05,$da,$d6,$f2,$23,$19,$22,$4e,$17,$02,$f2
    .byte $53,$27,$35,$45,$73,$40,$d3,$16,$0e,$27,$5d,$ea,$05,$d5,$08,$ec,$b8,$3a,$d9,$01,$51,$d6,$04,$2d,$28,$e4,$09,$9e,$0e,$d5
    .byte $42,$76,$33,$41,$44,$56,$1a,$ec,$0f,$de,$47,$03,$d8,$2b,$33,$11,$01,$0f,$52,$d2,$3c,$e1,$4c,$d6
    .byte $62,$54,$a3,$42,$63,$24,$b7,$d4,$04,$ec,$e5,$56,$1a,$4e,$17,$03,$d8,$ec,$0f,$09,$18,$d2,$13,$07,$ea,$05,$ec,$0b,$0c,$d5,$43,$1b,$01,$dd,$29,$d6,$ed,$d7,$2c,$e5,$0d,$04,$2d,$28,$e4
    .byte $73,$14,$22,$52,$42,$32,$14,$30,$28,$29,$8a,$e9,$10,$48,$05,$1d,$9f,$2c,$d5,$09,$ea,$05,$44,$54,$0a,$d5,$08,$d6
    .byte $00

talkFortKearney1:
    ; 148 bytes
    .byte $20,$14,$75,$52,$07,$b9,$0a,$5c,$20,$e4,$d4,$05,$e5
    .byte $41,$34,$25,$95,$40,$01,$21,$29,$d6,$10,$13,$da,$0b,$30,$0c,$e5,$39,$5d,$28,$08,$1e,$02,$d6
    .byte $32,$37,$62,$40,$2b,$69,$11,$e5,$03,$ec,$d9,$0e,$d5,$02,$09,$d7,$03,$d5
    .byte $21,$42,$4b,$1b,$01,$e4,$35,$04,$ea,$47,$02,$dd,$04,$d5,$02,$e4
    .byte $52,$15,$62,$24,$61,$35,$3d,$08,$ec,$e5,$6d,$e1,$16,$e5,$14,$09,$a0,$13,$de,$07,$d6,$ec,$df,$52,$45,$ea,$0a,$86
    .byte $31,$55,$34,$35,$d7,$31,$dc,$1c,$d9,$2c,$e5,$01,$21,$29,$27,$07,$8b,$07,$e5
    .byte $21,$41,$55,$1d,$dc,$0a,$5e,$d2,$0b,$a1,$16,$d6
    .byte $42,$33,$34,$32,$33,$04,$62,$11,$01,$02,$06,$e5,$15,$e5,$03,$01,$06,$37
    .byte $00

talkFortKearney2:
    ; 137 bytes
    .byte $20,$14,$70,$52,$07,$33,$31,$2e,$02
    .byte $51,$36,$43,$73,$62,$c0,$01,$11,$19,$22,$57,$15,$de,$01,$a2,$65,$e1,$03,$d8,$18,$d7,$30,$4c,$06,$ed,$ed,$03,$d5,$1a,$0c,$d5,$0c,$6b
    .byte $12,$20,$13
    .byte $11,$60,$db,$51,$1a,$d9
    .byte $42,$76,$24,$82,$47,$d4,$05,$df,$d4,$22,$59,$e6,$49,$e4,$ed,$ed,$d4,$35,$d6,$09,$66,$01,$02,$23,$d7,$07,$b9,$0a,$5c,$20
    .byte $42,$43,$43,$52,$33,$01,$10,$df,$45,$d7,$07,$e5,$12,$e4,$2b,$22,$e5,$4b,$01,$d6,$e6,$f1,$e4
    .byte $52,$42,$75,$53,$a3,$60,$0e,$3f,$09,$e1,$15,$e5,$16,$e5,$01,$51,$41,$05,$df,$5b,$07,$d4,$28,$39,$07,$6a,$d2,$04,$d5,$07,$21,$08
    .byte $00

talkFortKearney3:
    ; 149 bytes
    .byte $10,$35,$d3,$90,$dd,$05,$da,$d6
    .byte $72,$36,$56,$51,$77,$44,$72,$47,$01,$1a,$dd,$23,$e5,$02,$17,$02,$73,$0b,$20,$d7,$07,$a3,$04,$23,$e6,$19,$dd,$15,$54,$12,$7d,$15,$ba,$07,$b9,$0a,$5c,$20,$09,$d7,$07,$5f,$0e,$29,$da,$d6
    .byte $21,$95,$3a,$e5,$19,$e7,$1f,$02,$74,$05,$df,$5b,$07,$d4,$28,$39,$07,$6a,$d2
    .byte $11,$40,$e6,$1d,$d9
    .byte $32,$36,$34,$44,$04,$d5,$07,$21,$08,$d2,$0b,$1d,$56,$01,$10,$15,$54
    .byte $52,$52,$37,$72,$35,$40,$d4,$05,$68,$bb,$01,$d6,$0a,$55,$06,$e5,$13,$e3,$11,$24,$18,$01,$d6,$25,$31,$11,$60,$e1
    .byte $42,$63,$83,$62,$70,$42,$05,$dd,$4a,$8c,$04,$e5,$1f,$e0,$5a,$04,$d5,$30,$0c,$4d,$18,$2b,$49,$28,$e0
    .byte $00

