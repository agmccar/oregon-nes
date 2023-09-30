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

talkChimneyRock1:
    ; 145 bytes
    .byte $20,$47,$40,$d0,$3c,$e3,$3a,$d1,$15,$d2,$42,$31,$e2
    .byte $a2,$14,$87,$55,$77,$32,$46,$62,$35,$58,$25,$d8,$d7,$08,$c8,$02,$59,$51,$06,$e3,$07,$d8,$06,$47,$03,$e3,$13,$d6,$09,$df,$0d,$6c,$06,$e1,$3c,$dd,$04,$d6,$03,$0a,$53,$29,$aa,$24,$07,$d4,$07,$1d,$09,$eb,$eb,$01,$d4,$27,$35,$18,$0d,$4b,$12,$0d,$e5,$04,$d6,$0a,$d3,$08,$01
    .byte $82,$24,$53,$86,$25,$33,$52,$42,$25,$e6,$10,$e4,$12,$23,$15,$da,$03,$81,$3f,$2e,$d8,$06,$14,$e3,$0b,$ed,$e6,$10,$d8,$20,$e3,$33,$64,$11,$01,$02,$08,$1e,$de,$09,$42,$2d,$01,$04,$da
    .byte $31,$64,$33,$50,$2b,$13,$96,$2e,$05,$d5,$07,$01,$3d,$07,$12
    .byte $12,$13,$0f,$32
    .byte $00

talkChimneyRock2:
    ; 137 bytes
    .byte $10,$75,$d2,$1f,$04,$79,$d7,$04,$06
    .byte $42,$74,$29,$27,$70,$23,$31,$dd,$21,$17,$52,$4e,$ab,$09,$a3,$20,$e3,$0f,$c1,$a0,$0c,$96,$e4,$51,$31,$d4
    .byte $62,$47,$42,$35,$44,$28,$38,$dc,$05,$e8,$04,$38,$05,$e2,$d2,$28,$d4,$0a,$03,$e1,$13,$d6,$09,$1a,$01,$d5,$0f,$d7,$0a,$76,$23,$05,$d6,$24,$07,$d2,$46,$01,$04,$d6
    .byte $22,$26,$16,$2d,$d1,$03,$20,$e3,$05,$5b,$d1,$02
    .byte $72,$4a,$63,$36,$44,$72,$36,$35,$01,$21,$3c,$d3,$02,$12,$05,$d3,$ea,$e2,$13,$df,$ea,$05,$d3,$ea,$33,$e2,$13,$df,$ef,$ea,$c9,$10,$ab,$12,$05,$ac,$03,$e2,$0a,$d6,$11,$3e,$40,$2f,$05,$3b,$de,$52,$e2
    .byte $00

talkChimneyRock3:
    ; 142 bytes
    .byte $10,$66,$2b,$09,$e9,$b5,$1f,$05,$de
    .byte $b2,$54,$92,$42,$52,$74,$72,$23,$84,$35,$52,$44,$47,$03,$e3,$33,$09,$e8,$06,$e3,$02,$d3,$32,$e6,$15,$28,$d4,$04,$65,$20,$0a,$d5,$23,$31,$dd,$21,$17,$52,$db,$29,$dc,$04,$d6,$3f,$04,$01,$0e,$0f,$e3,$05,$d2,$1f,$d8,$50,$01,$1f,$14,$4b,$0a,$e6,$02,$14,$e2,$34,$d4,$0a,$72
    .byte $42,$23,$34,$62,$20,$e6,$0e,$48,$33,$78,$40,$1d,$d0,$e9,$04,$d6,$09,$16
    .byte $41,$23,$52,$54,$20,$16,$13,$e2,$47,$03,$e3,$f3,$f1,$dc,$25,$06,$d5,$17,$dc,$4a
    .byte $52,$36,$25,$42,$72,$50,$05,$d3,$12,$32,$0e,$04,$65,$20,$e3,$ea,$e3,$25,$e6,$02,$08,$23,$0e,$16,$0a,$d3,$32
    .byte $00

talkFortLaramie1:
    ; 149 bytes
    .byte $20,$15,$80,$c1,$34,$05,$e3,$1b,$e5,$1f,$02
    .byte $11,$26,$d1,$3d,$0d,$dd,$0e
    .byte $12,$80,$12,$e1,$05,$d6,$02
    .byte $33,$53,$15,$40,$d3,$09,$ea,$e3,$38,$4c,$13,$e3,$02,$d7,$35,$d4
    .byte $22,$54,$55,$56,$04,$da,$09,$97,$e1,$1c,$02,$13,$e3,$02
    .byte $62,$52,$36,$52,$24,$64,$37,$e2,$2b,$4b,$42,$01,$18,$db,$19,$e3,$02,$1c,$02,$0f,$eb,$eb,$16,$ea,$95,$11,$e3,$02,$01,$05,$01,$15,$d7,$35,$02,$d0
    .byte $32,$26,$27,$44,$2d,$2a,$59,$0e,$45,$d7,$4a,$d1,$05,$6b,$d0,$12,$2d,$ca
    .byte $41,$53,$44,$44,$70,$d2,$03,$63,$4a,$06,$34,$74,$1f,$df,$1a,$01,$01,$0f,$d7,$0d,$dd,$06,$e2
    .byte $32,$23,$35,$34,$2c,$e8,$03,$d2,$05,$73,$0d,$d4,$01,$11,$31,$d4
    .byte $00

talkFortLaramie2:
    ; 145 bytes
    .byte $20,$18,$30,$28,$03,$dd,$22,$04,$dc,$05
    .byte $72,$5a,$76,$37,$47,$59,$23,$90,$01,$06,$1d,$3a,$0b,$d7,$07,$dd,$3e,$08,$d3,$04,$d6,$37,$17,$1e,$01,$02,$de,$52,$d8,$06,$da,$dd,$26,$33,$01,$04,$d6,$47,$03,$2f,$67,$e5,$1c,$04,$d6,$04,$01,$10,$03,$dd,$22,$04,$e2
    .byte $31,$24,$54,$25,$16,$d6,$11,$84,$e6,$d5,$5e,$d2,$35,$d3,$3f,$01,$02,$d4
    .byte $22,$42,$36,$39,$0b,$04,$01,$06,$5b,$dc,$02
    .byte $83,$41,$88,$39,$34,$23,$43,$69,$34,$dc,$05,$e8,$19,$1b,$e5,$1f,$02,$d2,$17,$1e,$04,$d6,$01,$10,$03,$dd,$22,$04,$e2,$0a,$35,$19,$d4,$04,$01,$21,$08,$e1,$30,$94,$de,$78,$0b,$6d,$26,$d1,$03,$7b,$05,$d3,$38,$0e
    .byte $00

talkFortLaramie3:
    ; 134 bytes
    .byte $20,$15,$50,$42,$d8,$03,$e7,$d1,$1b,$44
    .byte $52,$36,$33,$67,$23,$50,$01,$18,$d0,$72,$d4,$08,$3a,$01,$10,$07,$22,$db,$0b,$10,$d8,$06,$14,$01,$06,$d8,$03,$e7
    .byte $52,$15,$38,$24,$36,$13,$d8,$e6,$03,$63,$33,$01,$06,$16,$19,$d4,$0a,$ad,$0c,$05,$e8,$ae,$72,$87,$31,$11
    .byte $42,$31,$45,$61,$53,$2a,$6c,$30,$e5,$0b,$39,$02,$ad,$0c,$0e,$d0,$27,$16,$10,$05
    .byte $61,$31,$34,$35,$32,$25,$25,$d0,$0c,$d8,$42,$cb,$17,$dc,$01,$d4,$27,$16,$10,$05,$0f,$0a,$db,$08,$e5,$10,$08,$db,$09,$d4
    .byte $32,$32,$52,$75,$05,$d3,$0a,$db,$08,$e5,$10,$e8,$2a,$53,$2b,$de,$2b,$09,$d4
    .byte $00

talkIndependenceRock1:
    ; 141 bytes
    .byte $20,$47,$40,$d0,$3c,$e3,$3a,$d1,$15,$d2,$42,$31,$e2
    .byte $53,$26,$26,$25,$55,$47,$33,$2a,$78,$02,$07,$23,$d4,$06,$d4,$07,$a2,$06,$d7,$a2,$e4,$16,$e2,$04,$d2,$24,$07,$62,$0d,$28,$c2
    .byte $11,$52,$51,$06,$68,$d4
    .byte $a3,$33,$64,$26,$42,$44,$44,$43,$56,$24,$40,$2a,$6c,$ea,$d3,$1b,$01,$02,$30,$e5,$10,$e8,$db,$0d,$d3,$02,$a0,$0c,$14,$d5,$29,$aa,$37,$da,$08,$12,$01,$05,$30,$44,$03,$43,$28,$06,$d2,$0d,$e5,$0e,$09,$01,$19,$17,$52
    .byte $11,$40,$2d,$0c
    .byte $62,$31,$54,$64,$33,$62,$60,$e3,$0f,$42,$d8,$20,$6f,$07,$15,$d7,$d4,$02,$e8,$01,$05,$d0,$0c,$01,$1d,$1b,$e5,$06,$e6,$18,$d0,$1e,$0e
    .byte $00

talkIndependenceRock2:
    ; 142 bytes
    .byte $10,$35,$d1,$9a,$db,$03,$c2
    .byte $23,$76,$50,$d6,$29,$d3,$4e,$18,$db,$19,$e3,$02,$1c,$02
    .byte $43,$74,$53,$57,$60,$d6,$29,$d3,$4e,$06,$05,$66,$d8,$0c,$e2,$05,$d3,$27,$16,$d4,$2a,$53,$2b,$5a,$da,$e4,$0c,$e2
    .byte $72,$32,$53,$a6,$25,$3b,$62,$54,$dd,$26,$e6,$15,$db,$31,$d1,$01,$06,$2d,$11,$13,$e3,$02,$7a,$0c,$21,$0a,$d2,$17,$1e,$01,$15,$09,$e3,$04,$0b,$22,$63,$1c,$48,$08,$2f,$03,$01,$ae,$1e
    .byte $21,$46,$37,$09,$d2,$08,$d2,$17,$1e,$01,$02,$de,$52,$d8,$06
    .byte $52,$54,$15,$74,$35,$56,$2d,$ea,$0c,$dc,$49,$08,$12,$d4,$18,$d3,$06,$d2,$0b,$e3,$04,$0a,$01,$1d,$3a,$0b,$e1,$1c,$02,$7a,$0c,$21
    .byte $00

talkIndependenceRock3:
    ; 145 bytes
    .byte $20,$15,$30,$32,$03,$dd,$d6,$58,$e8
    .byte $61,$16,$24,$32,$34,$2c,$40,$36,$0d,$e5,$0e,$45,$dd,$28,$d4,$13,$e8,$3f,$01,$06,$48,$d4,$14,$04,$d3,$18,$0b,$d3,$0b,$d2,$02,$de,$52
    .byte $22,$43,$30,$dd,$08,$e1,$01,$d4,$0a,$df
    .byte $43,$53,$82,$52,$50,$01,$02,$08,$3a,$d7,$3c,$56,$0e,$e2,$14,$dd,$28,$06,$3f,$01,$02,$d4
    .byte $81,$36,$44,$62,$83,$33,$82,$65,$47,$01,$d4,$35,$d3,$06,$e3,$09,$06,$e6,$02,$15,$0d,$e5,$0e,$4e,$dc,$03,$dd,$22,$04,$dc,$0b,$05,$54,$67,$e3,$1b,$cc,$02,$e2,$eb,$eb,$d5,$28,$03,$6d,$28,$06,$a3,$da,$24,$e1,$10,$09,$e3
    .byte $11,$a0,$d1,$09,$dd,$39,$d8,$0c,$d4
    .byte $13,$36,$05,$98,$06,$dc,$11
    .byte $00

talkSouthPass1:
    ; 143 bytes
    .byte $20,$27,$60,$05,$0d,$d0,$ae,$8e,$04,$38,$05
    .byte $62,$43,$53,$57,$35,$56,$43,$27,$0b,$01,$d4,$27,$16,$10,$05,$d5,$40,$12,$d2,$17,$1e,$0e,$03,$e1,$db,$05,$3b,$01,$d4,$40,$13,$d6,$09,$af,$02,$24,$3d
    .byte $42,$34,$53,$52,$57,$dd,$26,$01,$21,$d2,$17,$e6,$d3,$01,$11,$1b,$25,$04,$d6,$e1,$08,$b0,$5b,$d1,$02,$e2
    .byte $42,$34,$2a,$45,$47,$01,$1f,$05,$d3,$0f,$4d,$02,$d6,$1b,$e9,$0e,$1a,$01,$01,$d4,$40,$dc,$05,$e8,$05,$31,$2b,$e2
    .byte $54,$23,$53,$54,$23,$40,$5f,$05,$e8,$27,$16,$10,$0b,$12,$d8,$0c,$db,$1c,$d4,$04,$01,$d4,$08,$12
    .byte $32,$26,$42,$60,$45,$57,$de,$2e,$11,$2b,$da,$14,$dc,$4d,$04,$d6
    .byte $00

talkSouthPass2:
    ; 123 bytes
    .byte $20,$15,$40,$32,$03,$dd,$d6,$d6,$40,$db
    .byte $72,$26,$24,$43,$23,$74,$52,$46,$45,$99,$01,$02,$0f,$e5,$02,$96,$36,$da,$05,$88,$08,$e1,$02,$06,$e3,$04,$20,$02,$d4,$3c,$e3,$25,$d7,$1d,$11,$95,$11,$e3,$02
    .byte $62,$24,$47,$34,$33,$63,$80,$2d,$30,$44,$6a,$0b,$92,$3e,$04,$d6,$0a,$85,$0d,$d3,$05,$d3,$03,$b1,$08,$db,$01,$30,$1e,$e4,$53,$02,$0e
    .byte $41,$42,$62,$42,$65,$27,$0b,$45,$99,$01,$02,$0f,$47,$db,$d4,$0a,$e3,$1b,$e5,$1f,$d0,$4c,$04
    .byte $42,$24,$22,$16,$40,$2d,$1a,$0c,$cd,$19,$42,$db,$26,$02,$df,$37,$d4
    .byte $00

talkSouthPass3:
    ; 150 bytes
    .byte $20,$16,$80,$28,$07,$dc,$09,$e3,$1b,$e5,$1f,$02
    .byte $b2,$26,$31,$64,$25,$82,$36,$23,$54,$42,$49,$70,$45,$d5,$28,$25,$e8,$05,$d3,$16,$1b,$e5,$1f,$1a,$01,$f5,$f1,$de,$01,$02,$d5,$28,$25,$d8,$06,$0a,$01,$39,$d0,$0c,$21,$14,$01,$1d,$e1,$08,$2f,$2b,$62,$49,$d4,$0a,$e2,$87,$da,$e1,$1f,$9a,$d8,$03,$5c,$3a,$0e,$34
    .byte $11,$44,$d1,$37,$da,$08,$12
    .byte $22,$73,$a0,$dc,$07,$dc,$09,$e2,$0d,$18,$02,$e2,$15,$b2,$0e
    .byte $11,$24,$04,$e4,$22,$d7
    .byte $41,$54,$82,$51,$39,$2d,$ea,$0c,$b3,$04,$0a,$69,$01,$02,$0a,$2a,$25,$d3,$05,$3d,$d2,$34,$dc,$3c,$16,$e8
    .byte $32,$86,$44,$40,$23,$05,$d6,$04,$89,$06,$02,$e3,$04,$0a,$d5,$0d,$ce,$05,$d3
    .byte $00

