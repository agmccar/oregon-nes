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
    .byte $20,$47,$40,$d0,$3c,$e3,$3a,$d1,$15,$d2,$30,$32,$e2
    .byte $a2,$14,$87,$55,$77,$32,$46,$62,$35,$58,$25,$d8,$d7,$08,$cb,$02,$57,$50,$07,$e3,$06,$d8,$07,$48,$03,$67,$1d,$09,$df,$0d,$6c,$07,$e1,$3c,$dd,$04,$d6,$03,$0a,$52,$2b,$ad,$26,$06,$d4,$06,$1c,$09,$eb,$eb,$01,$19,$d7,$36,$17,$0d,$4a,$12,$0d,$e5,$04,$d6,$0a,$d3,$08,$01
    .byte $82,$24,$53,$86,$25,$33,$52,$42,$25,$e6,$10,$e4,$12,$22,$15,$da,$03,$84,$3f,$2f,$d8,$07,$14,$e3,$0b,$ed,$e6,$10,$d8,$20,$e3,$28,$62,$11,$01,$02,$08,$1e,$de,$09,$30,$2e,$01,$04,$da
    .byte $31,$64,$33,$50,$2a,$e6,$2d,$e2,$2f,$05,$d5,$06,$01,$19,$06,$12
    .byte $12,$13,$0f,$2d
    .byte $00

talkChimneyRock2:
    ; 134 bytes
    .byte $10,$75,$d2,$1f,$04,$83,$d7,$04,$07
    .byte $42,$74,$29,$27,$70,$22,$32,$dd,$21,$18,$51,$4f,$ae,$09,$91,$20,$e3,$0f,$70,$a3,$0c,$cc,$e4,$50,$32,$d4
    .byte $62,$47,$42,$35,$44,$28,$38,$dc,$05,$e8,$04,$40,$05,$e2,$d2,$27,$d4,$0a,$03,$53,$1d,$09,$23,$01,$d5,$0f,$d7,$0a,$77,$22,$05,$d6,$26,$06,$d2,$3b,$01,$04,$d6
    .byte $22,$26,$16,$2e,$d1,$03,$20,$e3,$05,$5b,$d1,$02
    .byte $72,$4a,$63,$36,$44,$72,$36,$35,$01,$21,$3c,$d3,$02,$12,$05,$d3,$ea,$68,$99,$ea,$05,$d3,$ea,$28,$68,$99,$ef,$ea,$cd,$10,$ae,$12,$05,$af,$03,$e2,$0a,$d6,$11,$3e,$41,$31,$05,$43,$de,$51,$e2
    .byte $00

talkChimneyRock3:
    ; 142 bytes
    .byte $10,$66,$2a,$09,$e9,$b7,$1f,$05,$de
    .byte $b2,$54,$92,$42,$52,$74,$72,$23,$84,$35,$52,$44,$48,$03,$e3,$28,$09,$e8,$07,$e3,$02,$d3,$2d,$e6,$15,$27,$d4,$04,$63,$20,$0a,$d5,$22,$32,$dd,$21,$18,$51,$db,$2b,$dc,$04,$d6,$3f,$04,$01,$0e,$0f,$e3,$05,$d2,$1f,$d8,$47,$01,$1f,$14,$4a,$0a,$e6,$02,$14,$e2,$35,$d4,$0a,$87
    .byte $42,$23,$34,$62,$20,$e6,$0e,$38,$28,$82,$41,$1c,$d0,$e9,$04,$d6,$09,$16
    .byte $41,$23,$52,$54,$20,$16,$e6,$30,$48,$03,$e3,$f3,$f1,$dc,$25,$07,$d5,$18,$dc,$49
    .byte $52,$36,$25,$42,$72,$50,$05,$d3,$12,$2d,$0e,$04,$63,$20,$e3,$ea,$e3,$25,$e6,$02,$08,$22,$0e,$16,$0a,$d3,$2d
    .byte $00

talkFortLaramie1:
    ; 149 bytes
    .byte $20,$15,$80,$70,$35,$05,$e3,$1a,$e5,$1f,$02
    .byte $11,$26,$d1,$19,$0d,$dd,$0e
    .byte $12,$80,$12,$e1,$05,$d6,$02
    .byte $33,$53,$15,$40,$d3,$09,$ea,$e3,$40,$d6,$70,$13,$02,$d7,$36,$d4
    .byte $22,$54,$55,$56,$04,$da,$09,$9a,$e1,$1b,$02,$e6,$13,$02
    .byte $62,$52,$36,$52,$24,$64,$37,$e2,$2a,$4a,$30,$01,$17,$db,$13,$e3,$02,$1b,$02,$0f,$eb,$eb,$16,$ea,$97,$11,$e3,$02,$01,$05,$01,$15,$d7,$36,$02,$d0
    .byte $32,$26,$27,$44,$2e,$29,$57,$0e,$46,$d7,$49,$d1,$05,$6b,$d0,$12,$2e,$ce
    .byte $41,$53,$44,$44,$70,$d2,$03,$5c,$49,$07,$35,$73,$1f,$df,$23,$01,$01,$0f,$d7,$0d,$dd,$07,$e2
    .byte $32,$23,$35,$34,$2c,$e8,$03,$d2,$05,$71,$0d,$d4,$01,$11,$32,$d4
    .byte $00

talkFortLaramie2:
    ; 145 bytes
    .byte $20,$18,$30,$27,$03,$dd,$24,$04,$dc,$05
    .byte $72,$5a,$76,$37,$47,$59,$23,$90,$01,$07,$1c,$3a,$0b,$d7,$06,$dd,$3e,$08,$d3,$04,$d6,$39,$18,$1e,$01,$02,$de,$51,$d8,$07,$da,$28,$e6,$28,$01,$04,$d6,$48,$03,$31,$64,$e5,$1b,$04,$d6,$04,$01,$10,$03,$dd,$24,$04,$e2
    .byte $31,$24,$54,$25,$16,$d6,$11,$e2,$70,$d5,$5f,$d2,$36,$d3,$3f,$01,$02,$d4
    .byte $22,$42,$36,$3d,$0b,$04,$01,$07,$5b,$dc,$02
    .byte $83,$41,$88,$39,$34,$23,$43,$69,$34,$dc,$05,$e8,$13,$1a,$e5,$1f,$02,$d2,$18,$1e,$04,$d6,$01,$10,$03,$dd,$24,$04,$e2,$0a,$36,$13,$d4,$04,$01,$21,$08,$9b,$30,$b0,$82,$0b,$e2,$28,$e6,$d1,$03,$74,$05,$d3,$40,$0e
    .byte $00

talkFortLaramie3:
    ; 134 bytes
    .byte $20,$15,$50,$30,$d8,$03,$e7,$d1,$1a,$45
    .byte $52,$36,$33,$67,$23,$50,$01,$17,$70,$75,$08,$3a,$01,$10,$06,$24,$db,$0b,$10,$d8,$07,$14,$01,$07,$d8,$03,$e7
    .byte $52,$15,$38,$24,$36,$13,$d8,$e6,$03,$5c,$28,$01,$07,$16,$13,$d4,$0a,$b1,$0c,$05,$e8,$df,$70,$75,$d4,$32,$11
    .byte $42,$31,$45,$61,$53,$29,$6c,$34,$e5,$0b,$3d,$02,$b1,$0c,$0e,$d0,$33,$16,$10,$05
    .byte $61,$31,$34,$35,$32,$25,$25,$d0,$0c,$d8,$30,$cf,$18,$dc,$01,$19,$d7,$16,$10,$05,$0f,$0a,$db,$08,$e5,$10,$08,$db,$09,$d4
    .byte $32,$32,$52,$75,$05,$d3,$0a,$db,$08,$e5,$10,$e8,$29,$52,$2a,$de,$2a,$09,$d4
    .byte $00

talkIndependenceRock1:
    ; 141 bytes
    .byte $20,$47,$40,$d0,$3c,$e3,$3a,$d1,$15,$d2,$30,$32,$e2
    .byte $53,$26,$26,$25,$55,$47,$28,$29,$82,$02,$06,$22,$d4,$07,$d4,$06,$a5,$07,$d7,$a5,$e4,$16,$e2,$04,$d2,$26,$06,$61,$0d,$27,$c3
    .byte $11,$52,$50,$07,$6a,$d4
    .byte $a3,$33,$64,$26,$42,$44,$44,$43,$56,$24,$40,$29,$6c,$ea,$d3,$1a,$01,$02,$34,$e5,$10,$e8,$db,$0d,$d3,$02,$a3,$0c,$14,$d5,$2b,$ad,$39,$da,$08,$12,$01,$05,$34,$45,$03,$44,$27,$07,$d2,$0d,$e5,$0e,$09,$01,$13,$18,$51
    .byte $11,$40,$2e,$0c
    .byte $62,$31,$54,$64,$33,$62,$60,$e3,$0f,$30,$d8,$20,$6e,$06,$15,$d7,$d4,$02,$e8,$01,$05,$d0,$0c,$01,$1c,$1a,$e5,$07,$e6,$17,$d0,$1e,$0e
    .byte $00

talkIndependenceRock2:
    ; 143 bytes
    .byte $10,$35,$d1,$9e,$db,$03,$c3
    .byte $23,$76,$50,$d6,$2b,$d3,$4f,$17,$db,$13,$e3,$02,$1b,$02
    .byte $43,$74,$53,$57,$60,$d6,$2b,$d3,$4f,$07,$05,$69,$d8,$0c,$e2,$05,$d3,$33,$16,$d4,$29,$52,$2a,$5a,$da,$e4,$0c,$e2
    .byte $72,$32,$53,$a6,$25,$3b,$62,$54,$28,$e6,$e6,$15,$db,$32,$d1,$01,$07,$2e,$11,$e6,$13,$02,$8a,$0c,$21,$0a,$d2,$18,$1e,$01,$15,$09,$e3,$04,$0b,$24,$5c,$1b,$38,$08,$31,$03,$01,$df,$d0,$1e
    .byte $21,$46,$37,$09,$d2,$08,$d2,$18,$1e,$01,$02,$de,$51,$d8,$07
    .byte $52,$54,$15,$74,$35,$56,$2e,$ea,$0c,$dc,$4e,$08,$12,$d4,$17,$d3,$07,$d2,$0b,$e3,$04,$0a,$01,$1c,$3a,$0b,$e1,$1b,$02,$8a,$0c,$21
    .byte $00

talkIndependenceRock3:
    ; 145 bytes
    .byte $20,$15,$30,$2d,$03,$dd,$d6,$59,$e8
    .byte $61,$16,$24,$32,$34,$2c,$40,$37,$0d,$e5,$0e,$46,$dd,$27,$19,$2d,$3f,$01,$07,$38,$d4,$14,$04,$d3,$17,$0b,$d3,$0b,$d2,$02,$de,$51
    .byte $22,$43,$30,$dd,$08,$e1,$01,$d4,$0a,$df
    .byte $43,$53,$82,$52,$50,$01,$02,$08,$3a,$d7,$3c,$56,$0e,$e2,$14,$dd,$27,$07,$3f,$01,$02,$d4
    .byte $81,$36,$44,$62,$83,$33,$82,$65,$47,$01,$d4,$36,$d3,$07,$e3,$09,$07,$e6,$02,$15,$0d,$e5,$0e,$4f,$dc,$03,$dd,$24,$04,$dc,$0b,$05,$54,$64,$e3,$1a,$df,$df,$02,$e2,$eb,$eb,$d5,$27,$03,$b2,$27,$07,$91,$da,$26,$e1,$10,$09,$e3
    .byte $11,$a0,$d1,$09,$dd,$3d,$d8,$0c,$d4
    .byte $13,$36,$05,$9c,$07,$dc,$11
    .byte $00

talkSouthPass1:
    ; 143 bytes
    .byte $20,$27,$60,$05,$0d,$99,$d0,$81,$04,$40,$05
    .byte $62,$43,$53,$57,$35,$56,$43,$33,$0b,$01,$19,$d7,$16,$10,$05,$d5,$41,$12,$d2,$18,$1e,$0e,$03,$e1,$db,$05,$43,$01,$d4,$41,$e6,$1d,$09,$68,$02,$26,$19
    .byte $42,$34,$53,$52,$57,$28,$e6,$01,$21,$d2,$18,$e6,$d3,$01,$11,$1a,$25,$04,$d6,$e1,$08,$b3,$5b,$d1,$02,$e2
    .byte $42,$34,$2a,$45,$47,$01,$1f,$05,$d3,$0f,$4c,$02,$d6,$1a,$e9,$0e,$23,$01,$01,$d4,$41,$dc,$05,$e8,$05,$32,$2a,$e2
    .byte $54,$23,$53,$54,$23,$40,$6d,$05,$e8,$33,$16,$10,$0b,$12,$d8,$0c,$db,$1b,$d4,$04,$01,$d4,$08,$12
    .byte $32,$26,$42,$60,$46,$58,$de,$2f,$11,$2a,$da,$14,$dc,$4c,$04,$d6
    .byte $00

talkSouthPass2:
    ; 124 bytes
    .byte $20,$15,$40,$2d,$03,$dd,$d6,$d6,$41,$db
    .byte $72,$26,$24,$43,$23,$74,$52,$46,$46,$9d,$01,$02,$0f,$e5,$02,$cc,$37,$da,$05,$7b,$08,$e1,$02,$07,$e3,$04,$20,$02,$d4,$3c,$e3,$25,$d7,$1c,$11,$97,$11,$e3,$02
    .byte $62,$24,$47,$34,$33,$63,$80,$2e,$34,$45,$66,$0b,$94,$3e,$04,$d6,$0a,$89,$0d,$d3,$05,$d3,$03,$9b,$08,$db,$01,$34,$1e,$e4,$52,$02,$0e
    .byte $41,$42,$62,$42,$65,$33,$0b,$46,$9d,$01,$02,$0f,$48,$db,$d4,$0a,$e3,$1a,$e5,$1f,$1d,$d0,$04
    .byte $42,$24,$22,$16,$40,$e6,$19,$d8,$0c,$b0,$13,$30,$3b,$e6,$02,$df,$39,$d4
    .byte $00

talkSouthPass3:
    ; 151 bytes
    .byte $20,$16,$80,$27,$06,$dc,$09,$e3,$1a,$e5,$1f,$02
    .byte $b2,$26,$31,$64,$25,$82,$36,$23,$54,$42,$49,$70,$46,$d5,$27,$25,$e8,$05,$d3,$16,$1a,$e5,$1f,$23,$01,$f5,$f1,$de,$01,$02,$d5,$27,$25,$d8,$07,$0a,$01,$3d,$d0,$0c,$21,$14,$01,$1c,$e1,$08,$31,$2a,$61,$d0,$47,$0a,$e2,$98,$da,$e1,$1f,$9e,$d8,$03,$5d,$3a,$0e,$35
    .byte $11,$44,$d1,$39,$da,$08,$12
    .byte $22,$73,$a0,$dc,$06,$dc,$09,$e2,$0d,$17,$02,$e2,$15,$b4,$0e
    .byte $11,$24,$04,$e4,$24,$d7
    .byte $41,$54,$82,$51,$39,$2e,$ea,$0c,$b5,$04,$0a,$72,$01,$02,$0a,$29,$25,$d3,$05,$19,$d2,$35,$dc,$3c,$16,$e8
    .byte $32,$86,$44,$40,$22,$05,$d6,$04,$8b,$07,$02,$e3,$04,$0a,$d5,$0d,$dc,$db,$05,$d3
    .byte $00

