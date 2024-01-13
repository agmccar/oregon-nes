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
    ; 149 bytes
    .byte $20,$15,$80,$cd,$34,$05,$e3,$1d,$e5,$1c,$02
    .byte $11,$26,$d1,$42,$0d,$dd,$0e
    .byte $12,$80,$0f,$e1,$05,$d6,$02
    .byte $33,$53,$15,$40,$d3,$09,$ea,$e3,$44,$55,$e6,$10,$02,$d7,$3a,$d4
    .byte $22,$54,$55,$51,$04,$da,$09,$95,$e1,$1b,$02,$e6,$10,$02
    .byte $62,$52,$36,$52,$24,$64,$37,$e2,$33,$3f,$47,$01,$18,$db,$10,$e3,$02,$1b,$02,$13,$eb,$eb,$19,$ea,$9e,$11,$e3,$02,$01,$05,$01,$17,$d7,$3a,$02,$d0
    .byte $32,$26,$27,$44,$31,$2a,$59,$0e,$4a,$d7,$5a,$d1,$05,$6b,$d0,$0f,$31,$bb
    .byte $41,$53,$44,$44,$70,$d2,$03,$68,$5a,$06,$34,$7f,$1c,$df,$1a,$01,$01,$13,$d7,$0d,$dd,$06,$e2
    .byte $32,$23,$35,$34,$30,$e8,$03,$d2,$05,$72,$0d,$d4,$01,$11,$35,$d4
    .byte $00

talkFortLaramie2:
    ; 146 bytes
    .byte $20,$18,$30,$2d,$03,$dd,$20,$04,$dc,$05
    .byte $72,$5a,$76,$37,$47,$59,$23,$90,$01,$06,$23,$41,$0b,$d7,$07,$dd,$39,$08,$d3,$04,$d6,$26,$14,$1e,$01,$02,$de,$4f,$d8,$06,$da,$29,$e6,$29,$01,$04,$d6,$40,$03,$32,$60,$e5,$1b,$04,$d6,$04,$01,$12,$03,$dd,$20,$04,$e2
    .byte $31,$24,$54,$25,$19,$d6,$11,$93,$e6,$d5,$5d,$d2,$3a,$d3,$3e,$01,$02,$d4
    .byte $22,$42,$36,$3c,$0b,$04,$01,$06,$62,$dc,$02
    .byte $83,$41,$88,$39,$34,$23,$43,$69,$34,$dc,$05,$e8,$10,$1d,$e5,$1c,$02,$d2,$14,$1e,$04,$d6,$01,$12,$03,$dd,$20,$04,$e2,$0a,$3a,$10,$d4,$04,$01,$22,$08,$e1,$2e,$94,$de,$7a,$0b,$e2,$29,$e6,$d1,$03,$89,$05,$d3,$44,$0e
    .byte $00

talkFortLaramie3:
    ; 135 bytes
    .byte $20,$15,$50,$47,$d8,$03,$e7,$d1,$1d,$46
    .byte $52,$36,$33,$67,$23,$50,$01,$18,$d0,$71,$d4,$08,$41,$01,$12,$07,$20,$db,$0b,$12,$d8,$06,$16,$01,$06,$d8,$03,$e7
    .byte $52,$15,$38,$24,$36,$13,$d8,$e6,$03,$68,$29,$01,$06,$19,$10,$d4,$0a,$bc,$0c,$05,$b3,$d0,$71,$b8,$35,$11
    .byte $42,$31,$45,$61,$53,$2a,$73,$2e,$e5,$0b,$3c,$02,$bc,$0c,$0e,$d0,$28,$19,$12,$05
    .byte $61,$31,$34,$35,$32,$25,$25,$d0,$0c,$d8,$47,$da,$d5,$14,$dc,$01,$d4,$28,$19,$12,$05,$13,$0a,$db,$08,$e5,$12,$08,$db,$09,$d4
    .byte $32,$32,$52,$75,$05,$d3,$0a,$db,$08,$e5,$12,$e8,$2a,$50,$d0,$27,$33,$09,$d4
    .byte $00

talkIndependenceRock1:
    ; 141 bytes
    .byte $20,$47,$40,$d0,$36,$e3,$41,$d1,$17,$d2,$47,$35,$e2
    .byte $53,$26,$26,$25,$55,$47,$29,$2a,$7a,$02,$07,$1f,$d4,$06,$d4,$07,$ca,$06,$d7,$d5,$a0,$19,$e2,$04,$d2,$21,$07,$58,$0d,$2d,$ce
    .byte $11,$52,$52,$06,$61,$d4
    .byte $a3,$33,$64,$26,$42,$44,$44,$43,$56,$24,$40,$2a,$73,$ea,$d3,$1d,$01,$02,$2e,$e5,$12,$e8,$db,$0d,$d3,$02,$af,$0c,$16,$d5,$2c,$b9,$26,$da,$08,$0f,$01,$05,$2e,$46,$03,$49,$2d,$06,$d2,$0d,$e5,$0e,$09,$01,$10,$14,$4f
    .byte $11,$40,$31,$0c
    .byte $62,$31,$54,$64,$33,$62,$60,$e3,$13,$47,$d8,$24,$7b,$07,$17,$d7,$d4,$02,$e8,$01,$05,$d0,$0c,$01,$23,$1d,$e5,$06,$e6,$18,$d0,$1e,$0e
    .byte $00

talkIndependenceRock2:
    ; 144 bytes
    .byte $10,$35,$d1,$a5,$db,$03,$ce
    .byte $23,$76,$50,$d6,$2c,$d3,$56,$18,$db,$10,$e3,$02,$1b,$02
    .byte $43,$74,$53,$57,$60,$d6,$2c,$d3,$56,$06,$05,$6f,$d8,$0c,$e2,$05,$d3,$28,$19,$d4,$2a,$50,$d0,$27,$e2,$da,$e4,$0c,$e2
    .byte $72,$32,$53,$a6,$25,$3b,$62,$54,$29,$e6,$e6,$17,$db,$35,$d1,$01,$06,$31,$11,$e6,$10,$02,$88,$0c,$22,$0a,$d2,$14,$1e,$01,$17,$09,$e3,$04,$0b,$20,$68,$1b,$37,$08,$32,$03,$01,$df,$d0,$1e
    .byte $21,$46,$37,$09,$d2,$08,$d2,$14,$1e,$01,$02,$de,$4f,$d8,$06
    .byte $52,$54,$15,$74,$35,$56,$31,$ea,$0c,$dc,$53,$08,$0f,$d4,$18,$d3,$06,$d2,$0b,$e3,$04,$0a,$01,$23,$41,$0b,$e1,$1b,$02,$88,$0c,$22
    .byte $00

talkIndependenceRock3:
    ; 145 bytes
    .byte $20,$15,$30,$25,$03,$dd,$d6,$57,$e8
    .byte $61,$16,$24,$32,$34,$2c,$40,$3b,$0d,$e5,$0e,$4a,$dd,$2d,$d4,$15,$e8,$3e,$01,$06,$37,$d4,$16,$04,$d3,$18,$0b,$d3,$0b,$d2,$02,$de,$4f
    .byte $22,$43,$30,$dd,$08,$e1,$01,$d4,$0a,$df
    .byte $43,$53,$82,$52,$50,$01,$02,$08,$41,$d7,$36,$51,$0e,$e2,$16,$dd,$2d,$06,$3e,$01,$02,$d4
    .byte $81,$36,$44,$62,$83,$33,$82,$65,$47,$01,$d4,$3a,$d3,$06,$e3,$09,$06,$e6,$02,$17,$0d,$e5,$0e,$56,$dc,$03,$dd,$20,$04,$dc,$0b,$05,$54,$60,$e3,$1d,$bd,$02,$e2,$eb,$eb,$d5,$2d,$03,$a1,$2d,$06,$84,$da,$21,$e1,$12,$09,$e3
    .byte $11,$a0,$d1,$09,$dd,$3c,$d8,$0c,$d4
    .byte $13,$36,$05,$a2,$06,$dc,$11
    .byte $00

talkSouthPass1:
    ; 144 bytes
    .byte $20,$27,$60,$05,$0d,$d0,$df,$d0,$98,$04,$44,$05
    .byte $62,$43,$53,$57,$35,$56,$43,$28,$0b,$01,$d4,$28,$19,$12,$05,$d5,$3d,$0f,$d2,$14,$1e,$0e,$03,$e1,$db,$05,$45,$01,$d4,$3d,$15,$d6,$09,$96,$02,$21,$42
    .byte $42,$34,$53,$52,$57,$29,$e6,$01,$22,$d2,$14,$e6,$d3,$01,$11,$1d,$2b,$04,$d6,$e1,$08,$be,$62,$d1,$02,$e2
    .byte $42,$34,$2a,$45,$47,$01,$1c,$05,$d3,$13,$5c,$02,$d6,$1d,$e9,$0e,$1a,$01,$01,$d4,$3d,$dc,$05,$e8,$05,$35,$33,$e2
    .byte $54,$23,$53,$54,$23,$40,$6e,$05,$e8,$28,$19,$12,$0b,$0f,$d8,$0c,$db,$1b,$d4,$04,$01,$d4,$08,$0f
    .byte $32,$26,$42,$60,$4a,$df,$48,$2f,$11,$33,$da,$16,$dc,$5c,$04,$d6
    .byte $00

talkSouthPass2:
    ; 123 bytes
    .byte $20,$15,$40,$25,$03,$dd,$d6,$d6,$3d,$db
    .byte $72,$26,$24,$43,$23,$74,$52,$46,$4a,$a3,$01,$02,$13,$e5,$02,$9f,$3b,$da,$05,$8a,$08,$e1,$02,$06,$e3,$04,$24,$02,$d4,$36,$e3,$2b,$d7,$23,$11,$9e,$11,$e3,$02
    .byte $62,$24,$47,$34,$33,$63,$80,$31,$2e,$46,$6c,$0b,$7e,$39,$04,$d6,$0a,$b5,$0d,$d3,$05,$d3,$03,$a4,$08,$db,$01,$2e,$1e,$e4,$50,$02,$0e
    .byte $41,$42,$62,$42,$65,$28,$0b,$4a,$a3,$01,$02,$13,$40,$db,$d4,$0a,$e3,$1d,$e5,$1c,$d0,$55,$04
    .byte $42,$24,$22,$16,$40,$31,$1a,$0c,$bf,$10,$47,$27,$e6,$02,$df,$26,$d4
    .byte $00

talkSouthPass3:
    ; 150 bytes
    .byte $20,$16,$80,$2d,$07,$dc,$09,$e3,$1d,$e5,$1c,$02
    .byte $b2,$26,$31,$64,$25,$82,$36,$23,$54,$42,$49,$70,$4a,$d5,$2d,$2b,$e8,$05,$d3,$19,$1d,$e5,$1c,$1a,$01,$f5,$f1,$de,$01,$02,$d5,$2d,$2b,$d8,$06,$0a,$01,$3c,$d0,$0c,$22,$16,$01,$23,$e1,$08,$32,$33,$58,$d0,$4c,$0a,$4d,$bb,$e1,$1c,$a5,$d8,$03,$64,$41,$0e,$34
    .byte $11,$44,$d1,$26,$da,$08,$0f
    .byte $22,$73,$a0,$dc,$07,$dc,$09,$e2,$0d,$18,$02,$e2,$17,$a6,$0e
    .byte $11,$24,$04,$e4,$20,$d7
    .byte $41,$54,$82,$51,$39,$31,$ea,$0c,$c0,$04,$0a,$63,$01,$02,$0a,$2a,$2b,$d3,$05,$42,$d2,$34,$dc,$36,$19,$e8
    .byte $32,$86,$44,$40,$1f,$05,$d6,$04,$97,$06,$02,$e3,$04,$0a,$d5,$0d,$dc,$db,$05,$d3
    .byte $00

talkFortBridger1:
    ; 145 bytes
    .byte $10,$47,$d0,$36,$e3,$41,$d1,$17,$79
    .byte $33,$29,$53,$86,$e6,$06,$d7,$03,$68,$ea,$e5,$11,$53,$0b,$01,$06,$e4,$52,$11,$e3,$17,$e4,$0a,$50
    .byte $72,$36,$24,$45,$34,$24,$23,$40,$29,$e3,$0b,$03,$24,$10,$01,$13,$d5,$07,$ad,$07,$01,$01,$11,$35,$d4,$19,$0a,$de,$da,$0a,$63,$01,$02,$d4
    .byte $23,$33,$a6,$05,$d3,$01,$d4,$03,$e3,$1d,$63,$03,$e2,$66,$3b,$06
    .byte $31,$63,$32,$30,$d5,$2c,$d3,$ea,$e2,$29,$78,$19,$0a,$08,$e3
    .byte $22,$44,$33,$9c,$1f,$db,$06,$72,$25,$d5,$07
    .byte $63,$47,$43,$73,$35,$24,$34,$e2,$34,$21,$3a,$8b,$ea,$45,$d4,$0c,$01,$17,$27,$01,$06,$16,$d5,$03,$e1,$d1,$26,$8b,$30,$31,$ea,$6b,$11,$01,$12
    .byte $00

talkFortBridger2:
    ; 148 bytes
    .byte $20,$1d,$50,$10,$3d,$0e,$eb,$27,$de,$da,$04,$d6,$e6,$34,$05
    .byte $62,$35,$72,$17,$54,$24,$70,$09,$17,$d7,$2b,$a2,$14,$71,$0e,$04,$47,$cb,$0c,$0b,$d2,$41,$bb,$08,$e2,$0a,$50,$07,$58,$0d,$2d,$ce
    .byte $42,$27,$42,$74,$c4,$4a,$d7,$5a,$d1,$05,$d3,$44,$0e,$16,$3f,$df,$98,$37,$dd,$08,$e1,$04,$d3,$18,$0b,$d3,$0b,$d2,$02,$de,$4f
    .byte $42,$31,$65,$42,$48,$29,$e6,$19,$1d,$e5,$1c,$33,$09,$d4,$1a,$01,$4a,$d5,$1b,$17,$d7,$2b,$51,$0b
    .byte $11,$36,$01,$d4,$1c,$d3,$06,$e3
    .byte $11,$50,$d2,$33,$67
    .byte $12,$26,$13,$1c,$3c,$0b
    .byte $52,$14,$52,$13,$62,$56,$30,$08,$a4,$d4,$ea,$0c,$d1,$08,$dc,$05,$d1,$21,$07,$42,$02,$08,$1f,$07,$23,$09
    .byte $00

talkFortBridger3:
    ; 125 bytes
    .byte $10,$16,$10,$1d,$d3,$02
    .byte $42,$44,$35,$23,$70,$01,$13,$d5,$07,$e3,$15,$e2,$2a,$2b,$e3,$56,$d9,$35,$d1,$e1,$37,$d6,$02
    .byte $a2,$33,$18,$36,$23,$24,$a4,$35,$52,$63,$b0,$d9,$35,$15,$e2,$2d,$03,$dd,$20,$04,$dc,$05,$d1,$21,$07,$7f,$18,$a6,$04,$01,$13,$52,$26,$da,$61,$d8,$01,$39,$6d,$05,$45,$a7,$0c,$0f,$07,$d4,$0a,$e2,$3e,$2f,$e8,$01,$48,$e5,$02,$db,$05,$d3,$02,$e2
    .byte $31,$41,$35,$26,$6e,$06,$40,$a5,$e3,$1d,$69,$04,$d7,$07,$e2,$06
    .byte $21,$33,$37,$d9,$35,$05,$6f,$13,$df,$0d,$be,$02
    .byte $12,$70,$e5,$47,$85,$d4,$e9
    .byte $00

talkGreenRiver1:
    ; 133 bytes
    .byte $20,$15,$30,$25,$03,$dd,$d6,$57,$e8
    .byte $42,$26,$63,$64,$2c,$4a,$d5,$2d,$2b,$86,$37,$dd,$ea,$e3,$2a,$e8,$0b,$03,$24,$d5,$2c,$d3,$04,$04,$d3,$18,$0b,$d3,$0b,$7d
    .byte $52,$24,$46,$45,$75,$47,$31,$2e,$46,$6c,$0b,$08,$e3,$04,$d6,$e5,$02,$e8,$61,$d0,$0c,$e1,$10,$d8,$09,$1e,$04,$d2,$21,$07,$58,$0d,$2d,$ce
    .byte $42,$72,$43,$62,$40,$d1,$17,$d0,$e4,$4d,$16,$01,$10,$03,$a4,$08,$db,$01,$13,$c1,$07
    .byte $31,$26,$38,$50,$4a,$5f,$0f,$02,$2e,$61,$03,$dd,$20,$04,$d5,$3c,$02
    .byte $42,$25,$74,$31,$50,$8c,$31,$ea,$e1,$06,$0a,$bd,$0e,$d7,$02,$21,$07,$d0,$28,$2b,$d4
    .byte $00

talkGreenRiver2:
    ; 143 bytes
    .byte $20,$18,$60,$d0,$39,$de,$39,$09,$d8,$04,$44,$05
    .byte $41,$46,$57,$67,$40,$28,$0b,$15,$d6,$09,$64,$3d,$0f,$0f,$0d,$e3,$0e,$d2,$34,$04,$d6,$01,$e1,$03,$24,$d7,$02,$d4
    .byte $22,$23,$34,$e6,$0e,$37,$29,$7b,$04,$d3
    .byte $a2,$24,$52,$42,$54,$34,$43,$93,$44,$53,$60,$31,$3c,$0b,$d5,$03,$89,$19,$d6,$2c,$d3,$0a,$e3,$1d,$d3,$23,$2d,$d4,$05,$54,$13,$d7,$1a,$01,$01,$11,$1d,$e5,$1c,$02,$e2,$05,$6f,$1c,$df,$01,$12,$d2,$14,$1e,$01,$02,$1b,$02,$e2
    .byte $72,$35,$33,$45,$33,$36,$43,$70,$29,$e6,$01,$02,$08,$41,$0a,$34,$05,$e8,$28,$19,$12,$0b,$05,$d3,$0a,$3a,$19,$58,$1c,$05,$54,$07,$d6,$1d,$e9,$04,$d6
    .byte $00

talkGreenRiver3:
    ; 138 bytes
    .byte $10,$35,$d1,$a5,$db,$03,$ce
    .byte $54,$47,$25,$24,$35,$50,$d5,$1b,$0e,$de,$0c,$0d,$e2,$0a,$d5,$02,$38,$5a,$5c,$02,$01,$23,$41,$0b,$e1,$1b,$02
    .byte $43,$5b,$41,$77,$69,$01,$87,$21,$02,$38,$dc,$0b,$ea,$0c,$dc,$53,$08,$d7,$36,$51,$0e,$6e,$0c,$0d,$9e,$21,$07,$67,$e1,$08,$da,$a3,$0f
    .byte $82,$54,$45,$52,$41,$52,$43,$53,$70,$31,$ea,$0c,$4c,$18,$d3,$4b,$dd,$e1,$1b,$02,$36,$e3,$2b,$e6,$21,$04,$82,$2f,$26,$d4,$0a,$d5,$07,$d3,$03,$e1,$15,$d6,$09,$05,$d3,$05,$35,$33,$e2
    .byte $31,$46,$52,$44,$28,$10,$db,$19,$58,$12,$09,$22,$31,$2e,$e5,$1c,$21,$e3
    .byte $13,$54,$31,$ea,$0c,$4c,$18
    .byte $00

