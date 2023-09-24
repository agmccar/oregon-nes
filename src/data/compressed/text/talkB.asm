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
    .byte $20,$47,$40,$d0,$3d,$e3,$3e,$d1,$15,$d2,$2f,$32,$e2
    .byte $a2,$14,$87,$55,$77,$32,$46,$62,$35,$58,$25,$d8,$d7,$08,$cb,$02,$58,$59,$06,$e3,$07,$d8,$06,$47,$03,$68,$1c,$09,$df,$0d,$6c,$06,$e1,$3d,$dd,$04,$d6,$03,$0a,$51,$29,$af,$24,$07,$d4,$07,$1d,$09,$eb,$eb,$01,$17,$d7,$37,$19,$0d,$4b,$12,$0d,$e5,$04,$d6,$0a,$d3,$08,$01
    .byte $82,$24,$53,$86,$25,$33,$52,$42,$25,$e6,$10,$e4,$12,$22,$15,$da,$03,$85,$41,$2e,$d8,$06,$13,$e3,$0b,$ed,$e6,$10,$d8,$20,$e3,$34,$64,$11,$01,$02,$08,$1e,$de,$09,$2f,$33,$01,$04,$da
    .byte $31,$64,$33,$50,$2b,$e6,$2d,$e2,$2e,$05,$d5,$07,$01,$17,$07,$12
    .byte $12,$13,$0f,$2d
    .byte $00

talkChimneyRock2:
    ; 134 bytes
    .byte $10,$75,$d2,$1f,$04,$84,$d7,$04,$06
    .byte $42,$74,$29,$27,$70,$22,$32,$dd,$21,$18,$50,$4e,$b0,$09,$a8,$20,$e3,$0f,$6f,$a2,$0c,$b1,$e4,$59,$32,$d4
    .byte $62,$47,$42,$35,$44,$28,$38,$dc,$05,$e8,$04,$42,$05,$e2,$d2,$23,$d4,$0a,$03,$52,$1c,$09,$25,$01,$d5,$0f,$d7,$0a,$76,$22,$05,$d6,$24,$07,$d2,$46,$01,$04,$d6
    .byte $22,$26,$16,$33,$d1,$03,$20,$e3,$05,$5c,$d1,$02
    .byte $72,$4a,$63,$36,$44,$72,$36,$35,$01,$21,$3d,$d3,$02,$12,$05,$d3,$ea,$69,$98,$ea,$05,$d3,$ea,$34,$69,$98,$ef,$ea,$cc,$10,$b0,$12,$05,$b2,$03,$e2,$0a,$d6,$11,$40,$3b,$31,$05,$3f,$de,$50,$e2
    .byte $00

talkChimneyRock3:
    ; 142 bytes
    .byte $10,$66,$2b,$09,$e9,$b8,$1f,$05,$de
    .byte $b2,$54,$92,$42,$52,$74,$72,$23,$84,$35,$52,$44,$47,$03,$e3,$34,$09,$e8,$06,$e3,$02,$d3,$2d,$e6,$15,$23,$d4,$04,$65,$20,$0a,$d5,$22,$32,$dd,$21,$18,$50,$db,$29,$dc,$04,$d6,$41,$04,$01,$0e,$0f,$e3,$05,$d2,$1f,$d8,$4f,$01,$1f,$13,$4b,$0a,$e6,$02,$13,$e2,$36,$d4,$0a,$88
    .byte $42,$23,$34,$62,$20,$e6,$0e,$39,$34,$83,$3b,$1d,$d0,$e9,$04,$d6,$09,$16
    .byte $41,$23,$52,$54,$20,$16,$e6,$2f,$47,$03,$e3,$f3,$f1,$dc,$27,$06,$d5,$18,$dc,$4a
    .byte $52,$36,$25,$42,$72,$50,$05,$d3,$12,$2d,$0e,$04,$65,$20,$e3,$ea,$e3,$27,$e6,$02,$08,$22,$0e,$16,$0a,$d3,$2d
    .byte $00

talkFortLaramie1:
    ; 149 bytes
    .byte $20,$15,$80,$6f,$36,$05,$e3,$1a,$e5,$1f,$02
    .byte $11,$26,$d1,$17,$0d,$dd,$0e
    .byte $12,$80,$12,$e1,$05,$d6,$02
    .byte $33,$53,$15,$40,$d3,$09,$ea,$e3,$42,$d6,$6f,$14,$02,$d7,$37,$d4
    .byte $22,$54,$55,$56,$04,$da,$09,$99,$e1,$1b,$02,$e6,$14,$02
    .byte $62,$52,$36,$52,$24,$64,$37,$e2,$2b,$4b,$2f,$01,$19,$db,$14,$e3,$02,$1b,$02,$0f,$eb,$eb,$16,$ea,$7a,$11,$e3,$02,$01,$05,$01,$15,$d7,$37,$02,$d0
    .byte $32,$26,$27,$44,$33,$2a,$58,$0e,$45,$d7,$4a,$d1,$05,$6b,$d0,$12,$33,$cd
    .byte $41,$53,$44,$44,$70,$d2,$03,$63,$4a,$06,$36,$72,$1f,$df,$25,$01,$01,$0f,$d7,$0d,$dd,$06,$e2
    .byte $32,$23,$35,$34,$2c,$e8,$03,$d2,$05,$70,$0d,$d4,$01,$11,$32,$d4
    .byte $00

talkFortLaramie2:
    ; 144 bytes
    .byte $20,$18,$30,$23,$03,$dd,$26,$04,$dc,$05
    .byte $72,$5a,$76,$37,$47,$59,$23,$90,$01,$06,$1d,$3e,$0b,$d7,$07,$dd,$40,$08,$d3,$04,$d6,$3a,$18,$1e,$01,$02,$de,$50,$d8,$06,$da,$dd,$28,$34,$01,$04,$d6,$47,$03,$31,$67,$e5,$1b,$04,$d6,$04,$01,$10,$03,$dd,$26,$04,$e2
    .byte $31,$24,$54,$25,$16,$d6,$11,$e2,$6f,$d5,$5f,$d2,$37,$d3,$41,$01,$02,$d4
    .byte $22,$42,$36,$3c,$0b,$04,$01,$06,$5c,$dc,$02
    .byte $83,$41,$88,$39,$34,$23,$43,$69,$34,$dc,$05,$e8,$14,$1a,$e5,$1f,$02,$d2,$18,$1e,$04,$d6,$01,$10,$03,$dd,$26,$04,$e2,$0a,$37,$14,$d4,$04,$01,$21,$08,$9a,$2f,$b3,$83,$0b,$73,$28,$d1,$03,$74,$05,$d3,$42,$0e
    .byte $00

talkFortLaramie3:
    ; 133 bytes
    .byte $20,$15,$50,$2f,$d8,$03,$e7,$d1,$1a,$53
    .byte $52,$36,$33,$67,$23,$50,$01,$19,$6f,$7b,$08,$3e,$01,$10,$07,$26,$db,$0b,$10,$d8,$06,$13,$01,$06,$d8,$03,$e7
    .byte $52,$15,$38,$24,$36,$13,$d8,$e6,$03,$63,$34,$01,$06,$16,$14,$d4,$0a,$b4,$0c,$05,$ce,$6f,$7b,$d4,$32,$11
    .byte $42,$31,$45,$61,$53,$2a,$6c,$35,$e5,$0b,$3c,$02,$b4,$0c,$0e,$d0,$30,$16,$10,$05
    .byte $61,$31,$34,$35,$32,$25,$25,$d0,$0c,$d8,$2f,$cf,$18,$dc,$01,$17,$d7,$16,$10,$05,$0f,$0a,$db,$08,$e5,$10,$08,$db,$09,$d4
    .byte $32,$32,$52,$75,$05,$d3,$0a,$db,$08,$e5,$10,$e8,$2a,$51,$2b,$de,$2b,$09,$d4
    .byte $00

talkIndependenceRock1:
    ; 142 bytes
    .byte $20,$47,$40,$d0,$3d,$e3,$3e,$d1,$15,$d2,$2f,$32,$e2
    .byte $53,$26,$26,$25,$55,$47,$34,$2a,$83,$02,$07,$22,$d4,$06,$d4,$07,$a3,$06,$d7,$a3,$e4,$16,$e2,$04,$d2,$24,$07,$62,$0d,$23,$d8,$d4
    .byte $11,$52,$59,$06,$6a,$d4
    .byte $a3,$33,$64,$26,$42,$44,$44,$43,$56,$24,$40,$2a,$6c,$ea,$d3,$1a,$01,$02,$35,$e5,$10,$e8,$db,$0d,$d3,$02,$a2,$0c,$13,$d5,$29,$af,$3a,$da,$08,$12,$01,$05,$35,$53,$03,$44,$23,$06,$d2,$0d,$e5,$0e,$09,$01,$14,$18,$50
    .byte $11,$40,$33,$0c
    .byte $62,$31,$54,$64,$33,$62,$60,$e3,$0f,$2f,$d8,$20,$6d,$07,$15,$d7,$d4,$02,$e8,$01,$05,$d0,$0c,$01,$1d,$1a,$e5,$06,$e6,$19,$d0,$1e,$0e
    .byte $00

talkIndependenceRock2:
    ; 144 bytes
    .byte $10,$35,$d1,$9d,$db,$03,$d8,$d4
    .byte $23,$76,$50,$d6,$29,$d3,$4e,$19,$db,$14,$e3,$02,$1b,$02
    .byte $43,$74,$53,$57,$60,$d6,$29,$d3,$4e,$06,$05,$66,$d8,$0c,$e2,$05,$d3,$30,$16,$d4,$2a,$51,$2b,$5a,$da,$e4,$0c,$e2
    .byte $72,$32,$53,$a6,$25,$3b,$62,$54,$dd,$28,$e6,$15,$db,$32,$d1,$01,$06,$33,$11,$e6,$14,$02,$8b,$0c,$21,$0a,$d2,$18,$1e,$01,$15,$09,$e3,$04,$0b,$26,$63,$1b,$39,$08,$31,$03,$01,$df,$d0,$1e
    .byte $21,$46,$37,$09,$d2,$08,$d2,$18,$1e,$01,$02,$de,$50,$d8,$06
    .byte $52,$54,$15,$74,$35,$56,$33,$ea,$0c,$dc,$48,$08,$12,$d4,$19,$d3,$06,$d2,$0b,$e3,$04,$0a,$01,$1d,$3e,$0b,$e1,$1b,$02,$8b,$0c,$21
    .byte $00

talkIndependenceRock3:
    ; 145 bytes
    .byte $20,$15,$30,$2d,$03,$dd,$d6,$5b,$e8
    .byte $61,$16,$24,$32,$34,$2c,$40,$38,$0d,$e5,$0e,$45,$dd,$23,$17,$2d,$41,$01,$06,$39,$d4,$13,$04,$d3,$19,$0b,$d3,$0b,$d2,$02,$de,$50
    .byte $22,$43,$30,$dd,$08,$e1,$01,$d4,$0a,$df
    .byte $43,$53,$82,$52,$50,$01,$02,$08,$3e,$d7,$3d,$56,$0e,$e2,$13,$dd,$23,$06,$41,$01,$02,$d4
    .byte $81,$36,$44,$62,$83,$33,$82,$65,$47,$01,$d4,$37,$d3,$06,$e3,$09,$06,$e6,$02,$15,$0d,$e5,$0e,$4e,$dc,$03,$dd,$26,$04,$dc,$0b,$05,$54,$67,$e3,$1a,$df,$df,$02,$e2,$eb,$eb,$d5,$23,$03,$73,$23,$06,$a8,$da,$24,$e1,$10,$09,$e3
    .byte $11,$a0,$d1,$09,$dd,$3c,$d8,$0c,$d4
    .byte $13,$36,$05,$9b,$06,$dc,$11
    .byte $00

talkSouthPass1:
    ; 143 bytes
    .byte $20,$27,$60,$05,$0d,$98,$d0,$8f,$04,$42,$05
    .byte $62,$43,$53,$57,$35,$56,$43,$30,$0b,$01,$17,$d7,$16,$10,$05,$d5,$3b,$12,$d2,$18,$1e,$0e,$03,$e1,$db,$05,$3f,$01,$d4,$3b,$e6,$1c,$09,$69,$02,$24,$17
    .byte $42,$34,$53,$52,$57,$dd,$28,$01,$21,$d2,$18,$e6,$d3,$01,$11,$1a,$27,$04,$d6,$e1,$08,$b5,$5c,$d1,$02,$e2
    .byte $42,$34,$2a,$45,$47,$01,$1f,$05,$d3,$0f,$4c,$02,$d6,$1a,$e9,$0e,$25,$01,$01,$d4,$3b,$dc,$05,$e8,$05,$32,$2b,$e2
    .byte $54,$23,$53,$54,$23,$40,$60,$05,$e8,$30,$16,$10,$0b,$12,$d8,$0c,$db,$1b,$d4,$04,$01,$d4,$08,$12
    .byte $32,$26,$42,$60,$45,$57,$de,$2e,$11,$2b,$da,$13,$dc,$4c,$04,$d6
    .byte $00

talkSouthPass2:
    ; 125 bytes
    .byte $20,$15,$40,$2d,$03,$dd,$d6,$d6,$3b,$db
    .byte $72,$26,$24,$43,$23,$74,$52,$46,$45,$9c,$01,$02,$0f,$e5,$02,$b1,$38,$da,$05,$7c,$08,$e1,$02,$06,$e3,$04,$20,$02,$d4,$3d,$e3,$27,$d7,$1d,$11,$7a,$11,$e3,$02
    .byte $62,$24,$47,$34,$33,$63,$80,$33,$35,$e5,$49,$d4,$0b,$95,$40,$04,$d6,$0a,$8a,$0d,$d3,$05,$d3,$03,$9a,$08,$db,$01,$35,$1e,$e4,$51,$02,$0e
    .byte $41,$42,$62,$42,$65,$30,$0b,$45,$9c,$01,$02,$0f,$47,$db,$d4,$0a,$e3,$1a,$e5,$1f,$1c,$d0,$04
    .byte $42,$24,$22,$16,$40,$e6,$17,$d8,$0c,$b3,$14,$2f,$db,$28,$02,$df,$3a,$d4
    .byte $00

talkSouthPass3:
    ; 152 bytes
    .byte $20,$16,$80,$23,$07,$dc,$09,$e3,$1a,$e5,$1f,$02
    .byte $b2,$26,$31,$64,$25,$82,$36,$23,$54,$42,$49,$70,$45,$d5,$23,$27,$e8,$05,$d3,$16,$1a,$e5,$1f,$25,$01,$f5,$f1,$de,$01,$02,$d5,$23,$27,$d8,$06,$0a,$01,$3c,$d0,$0c,$21,$13,$01,$1d,$e1,$08,$31,$2b,$62,$48,$d4,$0a,$e2,$97,$da,$e1,$1f,$9d,$d8,$03,$5d,$3e,$0e,$36
    .byte $11,$44,$d1,$3a,$da,$08,$12
    .byte $22,$73,$a0,$dc,$07,$dc,$09,$e2,$0d,$19,$02,$e2,$15,$b6,$0e
    .byte $11,$24,$04,$e4,$26,$d7
    .byte $41,$54,$82,$51,$39,$33,$ea,$0c,$d9,$de,$04,$0a,$71,$01,$02,$0a,$2a,$27,$d3,$05,$17,$d2,$36,$dc,$3d,$16,$e8
    .byte $32,$86,$44,$40,$22,$05,$d6,$04,$8c,$06,$02,$e3,$04,$0a,$d5,$0d,$dc,$db,$05,$d3
    .byte $00

