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

talkIndependence1:
    ; 148 bytes
    .byte $20,$14,$80,$d0,$0a,$85,$e1,$07,$48,$0b,$e3
    .byte $83,$45,$42,$54,$34,$36,$23,$42,$60,$e2,$33,$24,$34,$da,$1e,$d4,$10,$0a,$01,$04,$da,$01,$19,$8f,$2b,$e7,$0b,$0d,$d4,$0b,$03,$20,$0a,$d6,$11,$01,$10,$0a,$06,$1d,$09
    .byte $51,$34,$36,$41,$56,$50,$8f,$2b,$e7,$0b,$d2,$05,$d1,$0d,$1f,$a0,$4d,$08,$a1,$0c,$e8,$39,$50,$0e,$13,$d6,$09
    .byte $51,$32,$32,$44,$42,$40,$05,$d3,$2d,$09,$d4,$14,$01,$10,$d6,$11,$1e,$35,$da,$06,$37,$07
    .byte $32,$35,$25,$80,$e8,$03,$e6,$09,$ea,$a2,$1d,$de,$04,$d6,$05,$e8,$25,$02,$d4
    .byte $42,$18,$28,$44,$43,$d8,$e6,$03,$5c,$dd,$ea,$62,$2b,$e5,$02,$db,$05,$d3,$1a,$01,$db,$07,$e2,$01,$05,$63,$e7
    .byte $00

talkIndependence2:
    ; 143 bytes
    .byte $20,$16,$53,$19,$1b,$d3,$02,$dd,$2a,$0e,$d9,$31
    .byte $32,$64,$54,$28,$d1,$11,$e3,$02,$22,$46,$75,$e3,$1b,$e2,$11,$e2,$14,$d2,$39,$01,$04,$d6
    .byte $41,$53,$27,$35,$a0,$e3,$1b,$76,$ea,$10,$0a,$04,$37,$05,$5d,$06,$a3,$07,$d7,$e5,$1d,$11,$47,$db,$07
    .byte $22,$42,$40,$d5,$0f,$d7,$06,$dc,$08,$e3
    .byte $52,$44,$56,$26,$52,$59,$16,$ea,$e2,$2c,$0c,$e6,$06,$01,$d7,$40,$04,$d6,$05,$04,$37,$05,$90,$48,$08,$7d,$1c,$02,$d2,$18,$1e,$04,$5e
    .byte $23,$62,$34,$75,$df,$15,$e3,$0a,$df,$32,$01,$10
    .byte $21,$75,$70,$01,$21,$ea,$e1,$07,$d7,$0d,$bd,$1b,$d3,$02,$e2
    .byte $22,$36,$70,$27,$e3,$08,$e2,$26,$e8,$23,$08,$e3,$0e
    .byte $00

talkIndependence3:
    ; 149 bytes
    .byte $20,$19,$5a,$19,$1b,$e5,$1f,$02,$f0,$dc,$26,$07,$d7,$0b,$56,$35,$8d,$f0
    .byte $44,$33,$43,$8a,$50,$37,$69,$03,$e1,$08,$d3,$01,$10,$0f,$e2,$03,$e1,$40,$17,$e4,$51,$35,$05,$0a,$d3,$32
    .byte $51,$64,$45,$36,$78,$55,$eb,$eb,$e2,$32,$1e,$33,$24,$34,$da,$12,$0d,$77,$06,$06,$1d,$09,$1a,$01,$03,$7e,$0d,$41,$04,$5e,$df,$0d,$17,$0d,$2f
    .byte $32,$34,$25,$54,$27,$e3,$3b,$0b,$05,$75,$e3,$1b,$13,$d6,$09,$d0,$e7,$db,$d4
    .byte $33,$45,$44,$25,$a5,$12,$01,$04,$da,$01,$21,$d6,$18,$e6,$09,$e3,$38,$07
    .byte $52,$47,$56,$24,$29,$50,$7f,$58,$01,$21,$ea,$e1,$1f,$e4,$52,$e8,$0b,$03,$20,$0a,$d5,$04,$d3,$05,$47,$05,$d3,$09,$0e,$13,$d6,$09
    .byte $00

talkKansasRiver1:
    ; 152 bytes
    .byte $10,$18,$d0,$12,$e1,$05,$d6,$02
    .byte $32,$56,$24,$15,$d2,$05,$ea,$22,$53,$06,$d3,$0a,$22,$da,$08,$d5,$02,$41
    .byte $42,$56,$35,$41,$40,$2c,$ea,$e1,$10,$4e,$04,$d6,$03,$e1,$13,$d6,$09,$04,$0a,$47,$de,$19
    .byte $21,$54,$24,$2c,$ea,$0c,$91,$44,$d8,$0a,$e5,$02
    .byte $41,$53,$63,$54,$50,$80,$5f,$da,$01,$d4,$59,$e3,$0a,$dc,$05,$3c,$48,$07,$1a,$01,$df,$16,$23
    .byte $42,$33,$22,$53,$57,$05,$d3,$49,$d4,$16,$0a,$d5,$39,$19,$03,$e1,$d6,$2b,$3c,$36,$d2,$18,$1e
    .byte $32,$42,$43,$70,$30,$42,$0a,$e2,$1a,$dc,$01,$d4,$05,$31,$29,$e2
    .byte $53,$42,$74,$23,$74,$60,$7f,$58,$16,$6e,$07,$dd,$ea,$e3,$1b,$04,$eb,$eb,$01,$02,$1c,$02,$ea,$3e,$d8,$20,$0b,$03,$20
    .byte $00

talkKansasRiver2:
    ; 148 bytes
    .byte $20,$15,$80,$55,$02,$41,$95,$02,$19,$06
    .byte $92,$53,$24,$35,$64,$35,$32,$53,$31,$44,$d3,$09,$ea,$78,$41,$0a,$d5,$06,$d3,$05,$e8,$e1,$1c,$02,$76,$17,$02,$01,$05,$01,$d4,$13,$d6,$09,$d1,$0e,$eb,$eb,$47,$03,$78,$be,$05,$79,$d7,$29,$53,$d4,$11
    .byte $42,$65,$45,$34,$48,$e8,$03,$ea,$0c,$e2,$13,$bf,$e8,$03,$e1,$13,$d6,$09,$05,$d3,$39,$e2,$21,$03,$81,$3f,$2e,$d8,$07
    .byte $c3,$33,$53,$53,$35,$22,$22,$53,$42,$24,$45,$22,$50,$e8,$03,$d2,$05,$80,$5f,$da,$01,$d4,$13,$d6,$09,$d1,$0e,$05,$54,$39,$19,$16,$eb,$eb,$06,$d1,$07,$dc,$0d,$e3,$05,$6a,$40,$10,$d4,$0a,$22,$da,$21,$03,$e1,$13,$d6,$09,$09,$45,$d5,$02,$41
    .byte $00

talkKansasRiver3:
    ; 150 bytes
    .byte $20,$47,$40,$d0,$3a,$e3,$38,$d1,$15,$d2,$43,$31,$e2
    .byte $61,$43,$62,$67,$23,$23,$50,$1a,$01,$01,$15,$18,$e6,$3c,$14,$58,$de,$2e,$d4,$13,$16,$04,$d6,$0a,$d6,$11,$09,$01,$24,$02,$41
    .byte $43,$25,$28,$43,$40,$e6,$15,$03,$5c,$d1,$07,$7d,$05,$d3,$0e,$d7,$02,$24,$06,$d3,$32,$e2
    .byte $73,$47,$65,$33,$57,$23,$46,$54,$7f,$58,$01,$02,$d4,$ea,$e2,$0b,$03,$20,$d6,$1b,$e9,$24,$06,$d0,$0c,$01,$5a,$d4,$05,$31,$29,$e2,$eb,$eb,$27,$6f,$05,$e8,$58,$de,$2e,$15,$0d,$41,$c0,$0e
    .byte $21,$36,$40,$d8,$ea,$d3,$1b,$01,$02,$13,$16
    .byte $11,$60,$01,$03,$20
    .byte $43,$45,$21,$75,$40,$01,$05,$d2,$18,$1e,$04,$0d,$35,$da,$11,$e8,$13,$d6,$09,$59,$19
    .byte $00

talkBigBlueRiver1:
    ; 138 bytes
    .byte $30,$15,$67,$40,$d0,$df,$0d,$4a,$db,$08,$d3,$02,$d7,$08,$d3,$04,$d6,$08,$12
    .byte $23,$53,$60,$2c,$ea,$42,$30,$d3,$0b,$03,$20
    .byte $43,$55,$33,$3a,$35,$df,$07,$da,$82,$92,$07,$d0,$0c,$d3,$32,$05,$a4,$5a,$93,$d8,$0a,$07,$d0,$0c,$70,$20,$e3
    .byte $62,$46,$63,$26,$23,$23,$94,$16,$ea,$e2,$7c,$01,$02,$d1,$4e,$04,$5e,$3a,$06,$de,$71,$05,$e2,$14,$a5,$d3,$eb,$eb,$05,$3c,$33,$11,$31,$07,$59,$01
    .byte $51,$54,$79,$27,$43,$30,$e6,$06,$41,$4d,$02,$04,$37,$05,$e2,$19,$22,$52,$04,$d6,$eb,$eb,$30,$e5,$0b,$ea,$2f,$d4,$0b,$05,$e8,$e8,$11
    .byte $22,$35,$15,$28,$e3,$12,$d8,$0c,$83,$06,$41
    .byte $00

talkBigBlueRiver2:
    ; 151 bytes
    .byte $20,$15,$68,$29,$50,$e8,$f0,$dc,$0d,$70,$07,$e3,$3d,$0d,$e3,$f0
    .byte $72,$47,$26,$64,$33,$47,$34,$70,$01,$0f,$df,$1b,$40,$c1,$0f,$84,$20,$4a,$60,$11,$4a,$1a,$01,$d0,$0c,$01,$d4,$1a,$db,$54,$39,$e6,$02,$e2,$05,$d3,$22,$0c,$d6,$1b,$1e,$07
    .byte $33,$37,$34,$22,$28,$e3,$01,$02,$d4,$ea,$e2,$0a,$33,$e4,$23,$14,$16
    .byte $42,$14,$36,$14,$60,$31,$0f,$e2,$27,$01,$94,$04,$4b,$0a,$85,$dd,$08,$e1,$4f
    .byte $81,$16,$34,$45,$13,$14,$21,$44,$45,$d8,$e6,$09,$d3,$02,$d7,$4c,$dc,$05,$a6,$32,$e2,$3a,$e3,$26,$0f,$d4,$08,$0a,$85,$eb,$eb,$d0,$0a,$85,$1a,$01,$e1,$08,$db,$3e,$95,$e2
    .byte $11,$16,$d0,$23,$64,$23
    .byte $12,$80,$58,$de,$2e,$d4,$ef,$ef
    .byte $00

talkBigBlueRiver3:
    ; 145 bytes
    .byte $30,$36,$15,$70,$d1,$9c,$db,$03,$c1,$f0,$19,$1b,$26,$56,$1c,$02,$f0
    .byte $53,$27,$35,$45,$73,$40,$d1,$15,$0d,$24,$5f,$e8,$03,$d3,$09,$ea,$e3,$86,$3e,$01,$5a,$d4,$05,$31,$29,$e2,$0a,$87,$0d,$d3
    .byte $42,$76,$33,$41,$44,$46,$17,$ea,$10,$dc,$4d,$04,$d6,$28,$2f,$11,$01,$10,$55,$d0,$40,$df,$36,$d4
    .byte $62,$54,$a3,$42,$63,$24,$b7,$d2,$05,$ea,$e3,$46,$17,$56,$1c,$04,$d6,$ea,$10,$0a,$14,$d0,$12,$06,$e8,$03,$ea,$0c,$0b,$d3,$3f,$1a,$01,$db,$2a,$d4,$eb,$d5,$2b,$e3,$0e,$05,$31,$29,$e2
    .byte $73,$14,$22,$52,$42,$32,$14,$30,$29,$2a,$d4,$88,$0f,$47,$03,$22,$89,$2b,$d3,$0a,$e8,$03,$43,$50,$08,$d3,$09,$d4
    .byte $00

talkFortKearney1:
    ; 148 bytes
    .byte $20,$14,$75,$55,$06,$c4,$08,$44,$21,$e2,$d2,$03,$e3
    .byte $41,$34,$25,$95,$40,$01,$1d,$2a,$d4,$0f,$12,$d8,$0c,$2e,$0b,$e3,$2d,$5f,$29,$09,$20,$02,$d4
    .byte $32,$37,$62,$40,$28,$62,$11,$e3,$04,$ea,$d7,$0d,$d3,$02,$0a,$d5,$04,$d3
    .byte $21,$42,$4b,$1a,$01,$e2,$33,$05,$e8,$4d,$02,$db,$05,$d3,$02,$e2
    .byte $52,$15,$62,$24,$61,$35,$48,$09,$ea,$e3,$75,$df,$15,$e3,$16,$0a,$a8,$12,$dc,$06,$d4,$ea,$dd,$55,$3d,$e8,$08,$81
    .byte $31,$55,$34,$35,$d5,$34,$da,$1e,$d7,$2b,$e3,$01,$1d,$2a,$24,$06,$72,$06,$e3
    .byte $21,$41,$55,$22,$da,$08,$65,$d0,$0c,$8a,$15,$d4
    .byte $42,$33,$34,$32,$33,$05,$6b,$11,$01,$02,$07,$e3,$18,$e3,$04,$01,$07,$3a
    .byte $00

talkFortKearney2:
    ; 137 bytes
    .byte $20,$14,$70,$55,$06,$2f,$34,$37,$02
    .byte $51,$36,$43,$73,$62,$c0,$01,$11,$1b,$26,$5d,$18,$dc,$01,$c2,$5b,$df,$04,$d6,$14,$d5,$2e,$36,$07,$eb,$eb,$04,$d3,$17,$0b,$d3,$0b,$71
    .byte $12,$20,$12
    .byte $11,$60,$d9,$5a,$17,$d7
    .byte $42,$76,$24,$82,$47,$d2,$03,$dd,$d2,$26,$51,$e4,$53,$e2,$eb,$eb,$d2,$33,$d4,$0a,$66,$01,$02,$19,$d5,$06,$c4,$08,$44,$21
    .byte $42,$43,$43,$52,$33,$01,$0f,$dd,$3d,$d5,$06,$e3,$13,$e2,$28,$26,$e3,$4f,$01,$d4,$e4,$ef,$e2
    .byte $52,$42,$75,$53,$a3,$60,$0d,$45,$0a,$df,$18,$e3,$15,$e3,$01,$5a,$67,$03,$dd,$54,$06,$d2,$29,$2d,$06,$70,$d0,$05,$d3,$06,$1d,$09
    .byte $00

talkFortKearney3:
    ; 147 bytes
    .byte $10,$35,$d1,$9c,$db,$03,$c1
    .byte $72,$36,$56,$51,$77,$44,$72,$47,$01,$17,$db,$19,$e3,$02,$1c,$02,$7a,$0c,$21,$d5,$06,$a9,$05,$19,$e4,$1b,$db,$18,$50,$13,$82,$18,$c5,$06,$c4,$08,$44,$21,$0a,$d5,$06,$61,$0d,$2a,$c1
    .byte $21,$95,$3a,$e3,$1b,$e5,$1f,$02,$96,$03,$dd,$54,$06,$d2,$29,$2d,$06,$70,$d0
    .byte $11,$40,$e4,$22,$d7
    .byte $32,$36,$34,$44,$05,$d3,$06,$1d,$09,$d0,$0c,$22,$46,$01,$0f,$18,$50
    .byte $52,$52,$37,$72,$35,$40,$d2,$03,$5c,$68,$01,$d4,$08,$63,$07,$e3,$12,$e1,$11,$23,$14,$01,$d4,$25,$34,$11,$57,$df
    .byte $42,$63,$83,$62,$70,$3e,$03,$db,$3c,$97,$05,$e3,$1f,$de,$58,$05,$d3,$2e,$0b,$4a,$14,$28,$53,$29,$de
    .byte $00

