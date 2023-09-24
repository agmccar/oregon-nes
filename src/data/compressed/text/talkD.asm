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

talkSnakeRiver1:
    ; 140 bytes
    .byte $20,$17,$40,$55,$e1,$05,$e3,$38,$25,$c3
    .byte $c1,$24,$54,$23,$7a,$44,$42,$62,$53,$23,$92,$35,$50,$16,$e2,$2d,$e2,$58,$20,$01,$02,$d4,$04,$01,$06,$d7,$1b,$1f,$e8,$a4,$39,$49,$29,$da,$ee,$ec,$e8,$03,$dc,$4a,$01,$3b,$d4,$05,$04,$42,$05,$0a,$df,$27,$de,$4b,$03,$14,$01,$15,$18,$1e,$04,$5e,$13,$01,$06,$dd,$48,$02,$1b,$02
    .byte $83,$25,$92,$39,$c3,$27,$72,$87,$15,$16,$c9,$04,$8c,$05,$d6,$02,$03,$e2,$2c,$34,$e3,$df,$02,$d5,$15,$62,$e8,$3d,$d3,$02,$e2,$0a,$b8,$ef,$ec,$2a,$e3,$45,$d7,$4a,$d1,$05,$d3,$04,$e2,$0f,$31,$09,$d2,$18,$1e,$04,$d6,$25,$01,$03,$e3,$1c,$e4,$39,$d4
    .byte $00

talkSnakeRiver2:
    ; 141 bytes
    .byte $10,$2a,$05,$4c,$02,$db,$05,$d3,$02
    .byte $41,$45,$75,$54,$60,$d3,$28,$dd,$01,$02,$49,$11,$33,$0b,$01,$5a,$06,$e3,$d4,$19,$db,$79,$1c,$07,$d6,$06
    .byte $21,$83,$80,$68,$0f,$e3,$04,$d6,$05,$7c,$58,$01,$04,$d6
    .byte $22,$23,$55,$0f,$01,$06,$dd,$48,$02,$1b,$02
    .byte $53,$24,$52,$32,$42,$32,$e2,$36,$e4,$22,$e6,$14,$02,$eb,$eb,$05,$3f,$8a,$0d,$d3,$0a,$d6,$11,$0a
    .byte $41,$53,$45,$26,$66,$33,$ea,$e5,$1d,$de,$6d,$05,$a1,$27,$06,$13,$d3,$06,$02,$7e,$24,$07,$d4,$07,$1d,$09
    .byte $63,$22,$42,$44,$54,$23,$80,$e2,$b9,$06,$e4,$3e,$0a,$8e,$0c,$e8,$03,$52,$14,$02,$da,$1d,$e2,$14,$01,$15,$18,$1e,$04,$d6
    .byte $00

talkSnakeRiver3:
    ; 141 bytes
    .byte $10,$35,$d1,$9d,$db,$03,$d8,$d4
    .byte $24,$34,$45,$e2,$97,$01,$14,$25,$db,$56,$1b,$02
    .byte $22,$63,$50,$01,$14,$ea,$e2,$01,$06,$dd,$48,$d4
    .byte $52,$41,$74,$72,$37,$60,$dc,$05,$e8,$3a,$1a,$bc,$ea,$7a,$d4,$0b,$69,$23,$df,$0e,$04,$d7,$02,$d5,$de,$23,$04,$d6,$1a,$df,$39,$e2
    .byte $43,$36,$63,$33,$26,$d7,$02,$e6,$14,$02,$12,$1a,$e5,$1f,$d0,$0c,$01,$17,$2d,$0a,$07,$1d,$09
    .byte $31,$52,$83,$40,$33,$ea,$0c,$d1,$15,$18,$1e,$04,$20,$02,$e2,$de,$09
    .byte $32,$34,$55,$45,$05,$d3,$01,$0b,$1c,$d0,$04,$55,$e3,$02,$d5,$07,$e3,$5b,$0f,$d4
    .byte $33,$44,$23,$80,$26,$da,$15,$0d,$08,$e3,$01,$15,$18,$1e,$04,$d6
    .byte $00

talkFortBoise1:
    ; 148 bytes
    .byte $10,$5a,$d9,$3a,$b9,$d7,$13,$12,$08,$d3,$02
    .byte $11,$55,$3c,$02,$e8,$6e,$20,$e3
    .byte $41,$46,$14,$43,$55,$3c,$0b,$01,$03,$20,$d8,$d0,$22,$24,$18,$dc,$01,$0e,$2d,$ea,$e2,$0a,$27,$e2
    .byte $82,$24,$26,$46,$23,$44,$42,$3a,$60,$45,$d7,$08,$d3,$0f,$8e,$0c,$0e,$25,$01,$56,$08,$ae,$13,$01,$02,$d8,$22,$d5,$0d,$dc,$db,$05,$d3,$13,$01,$17,$d8,$0c,$23,$11,$e3,$3c,$d0,$0c,$21
    .byte $31,$14,$56,$14,$d8,$25,$0c,$2a,$27,$d3,$45,$e2,$1f,$d5,$55,$04,$d4
    .byte $62,$89,$23,$37,$42,$46,$45,$d7,$05,$3f,$36,$72,$36,$06,$e3,$08,$d3,$eb,$eb,$05,$42,$ea,$dc,$d2,$02,$26,$04,$d8,$ea,$0c,$d1,$02,$d8,$22,$25,$01,$04,$d5,$1b,$21,$08,$85
    .byte $00

talkFortBoise2:
    ; 152 bytes
    .byte $30,$16,$41,$50,$14,$1a,$d3,$02,$25,$01,$f7,$dc,$5f,$06
    .byte $51,$63,$33,$54,$44,$90,$e8,$03,$ea,$0c,$34,$64,$11,$e8,$02,$e6,$1c,$09,$4c,$02,$01,$10,$59,$e4,$10,$03,$dd,$26,$04,$e2
    .byte $12,$60,$dc,$0f,$e3,$02
    .byte $13,$52,$db,$08,$53,$16
    .byte $42,$53,$54,$44,$70,$d2,$18,$1e,$e8,$02,$d6,$29,$3f,$4c,$02,$25,$01,$df,$3a,$da,$05,$32,$2b,$e2
    .byte $42,$37,$16,$24,$50,$d6,$11,$e8,$02,$e2,$1f,$d5,$3a,$03,$2e,$d4,$13,$d6,$29,$a9,$5f,$06
    .byte $83,$62,$66,$35,$24,$24,$53,$54,$46,$ac,$15,$06,$13,$e6,$1c,$09,$9e,$16,$e3,$02,$01,$11,$1a,$27,$eb,$eb,$db,$24,$e3,$4e,$01,$10,$d5,$37,$8d,$30,$b8,$09,$ea,$01,$d4,$0e,$d6,$29,$d3,$4d,$e5,$38,$d4
    .byte $00

talkFortBoise3:
    ; 132 bytes
    .byte $10,$47,$d0,$3d,$e3,$3e,$d1,$15,$91
    .byte $31,$25,$45,$35,$14,$3c,$02,$92,$07,$26,$db,$09,$d6,$01,$11,$1a,$27
    .byte $53,$64,$46,$42,$38,$40,$61,$38,$06,$35,$e5,$49,$d4,$0b,$bd,$20,$02,$01,$05,$14,$01,$19,$e1,$3c,$d8,$03,$5d,$07,$e3
    .byte $23,$42,$a0,$01,$0f,$0f,$03,$e3,$1a,$71,$03,$e2
    .byte $33,$76,$92,$20,$01,$21,$ea,$e1,$11,$48,$04,$d6,$4d,$e5,$05,$e3,$1c,$d4,$13,$4a
    .byte $51,$21,$33,$62,$22,$50,$2c,$d8,$35,$d3,$01,$15,$d7,$05,$78,$0a,$60,$16,$1c,$d0,$04
    .byte $32,$33,$48,$2c,$d8,$ea,$d3,$2a,$a1,$07,$06,$41,$2e,$d8,$06,$04,$04,$d3,$19,$0b,$d3,$0b,$78
    .byte $00

talkBlueMountains1:
    ; 149 bytes
    .byte $20,$15,$a0,$14,$3b,$0e,$4c,$02,$db,$05,$d3,$02
    .byte $41,$58,$35,$24,$50,$e2,$04,$d2,$15,$18,$1e,$04,$d6,$01,$06,$dd,$48,$08,$81,$07,$e3,$5b,$0f,$d4
    .byte $32,$44,$49,$36,$16,$ea,$7a,$d4,$0b,$75,$12,$dc,$03,$dd,$26,$04,$e2,$05,$9b,$06,$02,$e3
    .byte $52,$46,$43,$23,$62,$50,$be,$12,$77,$19,$02,$08,$22,$d3,$2d,$eb,$eb,$65,$e7,$04,$22,$06,$14,$e3,$32,$06
    .byte $11,$26,$34,$e3,$1a,$50,$e2
    .byte $22,$46,$24,$75,$12,$d2,$db,$03,$3f,$13,$be,$12
    .byte $51,$46,$62,$34,$58,$35,$dc,$05,$e8,$d2,$14,$62,$15,$8f,$da,$0e,$09,$01,$0e,$e4,$12,$55,$e3,$02,$e2,$25,$dc,$dc,$04,$d6,$01,$02,$1b,$02
    .byte $22,$44,$34,$01,$0b,$59,$0e,$05,$d3,$42,$0e
    .byte $00

talkBlueMountains2:
    ; 146 bytes
    .byte $10,$67,$dc,$0d,$6e,$06,$e3,$17,$0d,$e3
    .byte $92,$28,$34,$23,$64,$45,$23,$a4,$23,$49,$e6,$24,$de,$0c,$28,$0e,$01,$d4,$0e,$71,$13,$01,$0e,$06,$02,$81,$18,$c8,$07,$e3,$5b,$0f,$d4,$0a,$01,$24,$07,$d1,$39,$d3,$04,$d6,$a6,$0c,$13,$01,$49,$db,$e4,$10,$03,$dd,$26,$04,$e2
    .byte $33,$35,$48,$50,$01,$72,$d8,$0c,$69,$02,$0e,$e1,$08,$54,$5f,$12,$d4,$19
    .byte $41,$74,$63,$64,$40,$46,$50,$04,$d6,$5b,$01,$30,$d4,$1f,$e2,$05,$9f,$36,$04,$8c,$28,$dd,$9e,$28
    .byte $22,$23,$44,$e6,$1d,$a5,$d3,$28,$dd,$e2,$55,$d4
    .byte $13,$47,$df,$de,$07,$05,$32,$2b,$e2
    .byte $32,$25,$25,$34,$34,$d6,$1a,$1e,$07,$e6,$14,$02,$d5,$07,$d3,$2d,$e2
    .byte $00

talkBlueMountains3:
    ; 145 bytes
    .byte $10,$5a,$d9,$3a,$b9,$d7,$13,$12,$08,$d3,$02
    .byte $82,$46,$23,$65,$23,$49,$54,$42,$60,$01,$0f,$8b,$0c,$21,$13,$01,$1d,$e1,$05,$d3,$02,$09,$77,$0f,$01,$10,$de,$12,$d1,$08,$b6,$2c,$5f,$65,$20,$6c,$ea,$e5,$06,$d4,$0b,$04,$dc,$09,$01,$e2
    .byte $33,$53,$52,$90,$e6,$14,$02,$05,$d3,$d6,$1a,$e9,$d4,$04,$d0,$2a,$74,$05,$78
    .byte $41,$32,$46,$22,$40,$05,$d3,$2c,$01,$0f,$8b,$0c,$21,$0f,$e2,$13,$04,$d4
    .byte $43,$3a,$42,$52,$40,$01,$17,$d8,$0c,$23,$11,$e3,$10,$e4,$12,$d1,$11,$25,$d2,$08,$5d,$04,$d4
    .byte $43,$52,$76,$23,$39,$33,$ea,$0c,$d1,$06,$16,$e3,$04,$ea,$61,$11,$4b,$04,$03,$44,$17,$d7,$36,$06,$e3,$08,$d3
    .byte $00

talkFortWallaWalla1:
    ; 148 bytes
    .byte $20,$15,$60,$2d,$03,$dd,$d6,$b0,$01,$02
    .byte $52,$48,$24,$27,$53,$75,$d8,$ea,$e5,$11,$1a,$e5,$1f,$0e,$04,$d5,$08,$e1,$13,$04,$42,$05,$1e,$04,$78,$03,$e1,$d9,$03,$44,$21,$d1,$1d,$05
    .byte $32,$22,$35,$43,$2f,$13,$e8,$11,$33,$ea,$e5,$06,$d4,$0b,$d5,$17
    .byte $62,$52,$36,$25,$62,$42,$a0,$01,$5a,$17,$10,$d4,$01,$1f,$df,$0e,$4a,$d2,$18,$1e,$e1,$1b,$02,$e2,$07,$e2,$37,$d3,$4a,$e5,$1d,$11,$47,$db,$06
    .byte $22,$51,$40,$12,$d8,$0c,$2c,$08,$e1
    .byte $62,$44,$57,$35,$72,$82,$59,$d8,$ea,$e5,$02,$08,$d3,$d6,$1a,$e5,$10,$0d,$da,$02,$e2,$05,$66,$08,$bb,$12,$07,$d8,$06,$13,$b4,$0c,$04,$5e,$04,$01,$06,$10,$03,$dd,$26,$04,$e2
    .byte $00

talkFortWallaWalla2:
    ; 148 bytes
    .byte $10,$3b,$23,$e8,$25,$01,$02,$70,$de,$09
    .byte $72,$26,$93,$32,$38,$83,$42,$97,$45,$d2,$03,$e2,$04,$91,$01,$02,$04,$17,$2f,$09,$d4,$13,$65,$e7,$22,$27,$56,$0b,$07,$df,$d7,$05,$0e,$05,$6b,$24,$e3,$14,$30,$16,$dc,$05,$ea,$6a,$0f,$65,$09
    .byte $62,$54,$43,$55,$25,$38,$48,$db,$1b,$0e,$25,$01,$01,$10,$d5,$07,$01,$3e,$21,$08,$85,$eb,$eb,$3d,$e3,$27,$01,$10,$d0,$1e,$3a,$e1,$1f,$d0,$12,$34,$e5,$10,$d1,$02
    .byte $21,$33,$8a,$40,$d4,$35,$1e,$67,$e5,$1b,$0e,$73,$48,$49,$16,$06
    .byte $11,$90,$12,$23,$df,$0e,$06
    .byte $11,$50,$9c,$0c,$e2
    .byte $42,$62,$32,$71,$80,$8e,$20,$31,$eb,$eb,$34,$e3,$0a,$dc,$0b,$6c,$09,$23,$d0,$1e,$3a,$3e
    .byte $00

talkFortWallaWalla3:
    ; 148 bytes
    .byte $20,$16,$60,$3a,$2d,$4a,$d4,$04,$42,$05
    .byte $32,$33,$53,$78,$e8,$03,$2f,$da,$47,$03,$e3,$01,$17,$d7,$16,$dc,$05,$dc,$d0,$1e,$3a,$3e
    .byte $74,$13,$33,$69,$83,$34,$28,$80,$d8,$2f,$da,$e8,$03,$30,$e8,$60,$d2,$e3,$07,$30,$16,$dc,$05,$ea,$6a,$0e,$38,$04,$0e,$39,$34,$82,$67,$10,$e8,$57,$de,$2e,$d4,$ea,$e2,$22,$27,$56,$0b
    .byte $42,$46,$37,$43,$90,$dc,$05,$e8,$91,$e4,$20,$e3,$01,$10,$08,$9e,$06,$d5,$18,$dc,$01,$06,$80,$05,$d6,$02,$e2
    .byte $74,$33,$38,$63,$83,$43,$82,$56,$30,$89,$39,$01,$10,$0e,$38,$04,$19,$de,$0f,$09,$03,$e1,$22,$27,$56,$0b,$05,$9f,$e4,$3e,$01,$15,$d7,$27,$56,$0b,$13,$30,$16,$19,$96,$2e,$d4
    .byte $00

