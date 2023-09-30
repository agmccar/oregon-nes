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
    ; 139 bytes
    .byte $20,$17,$40,$55,$e1,$05,$e3,$36,$1a,$c0
    .byte $c1,$24,$54,$23,$7a,$44,$42,$62,$53,$23,$92,$35,$50,$16,$e2,$32,$e2,$59,$20,$01,$02,$d4,$04,$01,$06,$d7,$1c,$1f,$e8,$8d,$48,$61,$29,$da,$ee,$ec,$e8,$03,$dc,$4a,$01,$d8,$3a,$05,$04,$38,$05,$0a,$df,$25,$de,$4b,$03,$19,$01,$15,$17,$1e,$04,$5d,$14,$01,$06,$dd,$49,$02,$1c,$02
    .byte $83,$25,$92,$39,$c3,$27,$72,$87,$15,$16,$6a,$04,$89,$05,$d6,$02,$03,$e2,$2c,$33,$e3,$df,$02,$d5,$15,$62,$e8,$3c,$d3,$02,$e2,$0a,$b5,$ef,$ec,$2a,$e3,$45,$d7,$4a,$d1,$05,$d3,$04,$e2,$0f,$2f,$09,$d2,$17,$1e,$04,$d6,$1a,$01,$03,$22,$8d,$48,$d4
    .byte $00

talkSnakeRiver2:
    ; 142 bytes
    .byte $10,$2a,$05,$4d,$02,$db,$05,$d3,$02
    .byte $41,$45,$75,$54,$60,$d3,$26,$dd,$01,$02,$61,$11,$2d,$0b,$01,$5a,$06,$e3,$d4,$18,$a8,$7a,$d6,$07,$d6,$06
    .byte $21,$83,$80,$8c,$0f,$e3,$04,$d6,$05,$88,$59,$01,$04,$d6
    .byte $22,$23,$55,$0f,$01,$06,$dd,$49,$02,$1c,$02
    .byte $53,$24,$52,$32,$42,$32,$e2,$34,$e4,$23,$13,$e3,$02,$eb,$eb,$05,$3b,$85,$0d,$d3,$0a,$d6,$11,$0a
    .byte $41,$53,$45,$26,$66,$2d,$ea,$e5,$1d,$de,$6f,$05,$9f,$25,$06,$14,$d3,$06,$02,$a1,$24,$07,$d4,$07,$1d,$09
    .byte $63,$22,$42,$44,$54,$23,$80,$b6,$d1,$06,$e4,$3a,$0a,$8b,$0c,$e8,$03,$e1,$13,$e3,$02,$da,$1d,$e2,$19,$01,$15,$17,$1e,$04,$d6
    .byte $00

talkSnakeRiver3:
    ; 139 bytes
    .byte $10,$35,$d1,$9a,$db,$03,$c2
    .byte $24,$34,$45,$e2,$87,$01,$19,$1a,$db,$56,$1c,$02
    .byte $22,$63,$50,$01,$19,$ea,$e2,$01,$06,$dd,$49,$d4
    .byte $52,$41,$74,$72,$37,$60,$dc,$05,$e8,$37,$1b,$b9,$ea,$e2,$6a,$0b,$e2,$13,$bf,$0e,$04,$d7,$02,$d5,$de,$28,$04,$d6,$1b,$86,$3b
    .byte $43,$36,$63,$33,$26,$d7,$02,$13,$e3,$02,$12,$1b,$e5,$1f,$d0,$0c,$01,$d4,$13,$e8,$0a,$07,$1d,$09
    .byte $31,$52,$83,$40,$2d,$ea,$0c,$d1,$15,$17,$1e,$04,$20,$02,$b6,$09
    .byte $32,$34,$55,$45,$05,$d3,$01,$0b,$d0,$4c,$04,$55,$e3,$02,$d5,$07,$e3,$58,$0f,$d4
    .byte $33,$44,$23,$80,$22,$da,$15,$0d,$08,$e3,$01,$15,$17,$1e,$04,$d6
    .byte $00

talkFortBoise1:
    ; 148 bytes
    .byte $10,$5a,$d9,$37,$de,$d1,$d7,$14,$12,$08,$d3,$02
    .byte $11,$55,$39,$02,$e8,$70,$20,$e3
    .byte $41,$46,$14,$43,$55,$39,$0b,$01,$03,$20,$d8,$d0,$23,$24,$17,$dc,$01,$0e,$32,$ea,$e2,$0a,$25,$e2
    .byte $82,$24,$26,$46,$23,$44,$42,$3a,$60,$45,$d7,$08,$d3,$0f,$8b,$0c,$0e,$1a,$01,$56,$08,$a9,$14,$01,$02,$d8,$23,$d5,$0d,$ce,$05,$d3,$14,$01,$d4,$1a,$0c,$28,$11,$e3,$39,$d0,$0c,$21
    .byte $31,$14,$56,$14,$d8,$1a,$0c,$2a,$25,$d3,$45,$e2,$1f,$d5,$55,$04,$d4
    .byte $62,$89,$23,$37,$42,$46,$45,$d7,$05,$3b,$34,$74,$34,$06,$e3,$08,$d3,$eb,$eb,$05,$38,$ea,$dc,$d2,$02,$22,$04,$d8,$ea,$0c,$d1,$02,$d8,$23,$1a,$01,$04,$d5,$1c,$21,$08,$81
    .byte $00

talkFortBoise2:
    ; 152 bytes
    .byte $30,$16,$41,$50,$19,$1b,$d3,$02,$1a,$01,$f7,$dc,$5e,$06
    .byte $51,$63,$33,$54,$44,$90,$e8,$03,$ea,$0c,$33,$64,$11,$e8,$02,$13,$d6,$09,$4d,$02,$01,$10,$51,$e4,$10,$03,$dd,$22,$04,$e2
    .byte $12,$60,$dc,$0f,$e3,$02
    .byte $13,$52,$db,$08,$44,$16
    .byte $42,$53,$54,$44,$70,$d2,$17,$1e,$e8,$02,$d6,$29,$3b,$4d,$02,$1a,$01,$df,$37,$da,$05,$31,$2b,$e2
    .byte $42,$37,$16,$24,$50,$d6,$11,$e8,$02,$e2,$1f,$d5,$37,$03,$2e,$d4,$14,$d6,$29,$a4,$5e,$06
    .byte $83,$62,$66,$35,$24,$24,$53,$54,$46,$86,$15,$06,$14,$13,$d6,$09,$9b,$16,$e3,$02,$01,$11,$1b,$25,$eb,$eb,$db,$24,$e3,$4e,$01,$10,$d5,$35,$8a,$27,$b5,$09,$ea,$01,$d4,$0e,$d6,$29,$d3,$4f,$e5,$36,$d4
    .byte $00

talkFortBoise3:
    ; 131 bytes
    .byte $10,$47,$d0,$3c,$e3,$3a,$d1,$15,$80
    .byte $31,$25,$45,$35,$19,$39,$02,$82,$07,$22,$db,$09,$d6,$01,$11,$1b,$25
    .byte $53,$64,$46,$42,$38,$40,$60,$36,$06,$30,$44,$6a,$0b,$d7,$d8,$20,$02,$01,$05,$19,$01,$18,$e1,$39,$d8,$03,$5c,$07,$e3
    .byte $23,$42,$a0,$01,$0f,$0f,$03,$e3,$1b,$69,$03,$e2
    .byte $33,$76,$92,$20,$01,$21,$ea,$e1,$11,$49,$04,$4c,$d3,$e5,$05,$22,$69,$14,$4a
    .byte $51,$21,$33,$62,$22,$50,$2c,$d8,$30,$d3,$01,$15,$d7,$05,$71,$0a,$5f,$16,$d0,$4c,$04
    .byte $32,$33,$48,$2c,$d8,$ea,$d3,$2a,$9f,$07,$06,$3f,$2e,$d8,$06,$04,$04,$d3,$18,$0b,$d3,$0b,$71
    .byte $00

talkBlueMountains1:
    ; 149 bytes
    .byte $20,$15,$a0,$19,$40,$0e,$4d,$02,$db,$05,$d3,$02
    .byte $41,$58,$35,$24,$50,$e2,$04,$d2,$15,$17,$1e,$04,$d6,$01,$06,$dd,$49,$08,$7e,$07,$e3,$58,$0f,$d4
    .byte $32,$44,$49,$36,$16,$ea,$e2,$6a,$0b,$75,$12,$dc,$03,$dd,$22,$04,$e2,$05,$98,$06,$02,$e3
    .byte $52,$46,$43,$23,$62,$50,$ba,$12,$77,$18,$02,$08,$23,$d3,$32,$eb,$eb,$65,$e7,$04,$23,$06,$19,$e3,$31,$06
    .byte $11,$26,$33,$e3,$1b,$52,$e2
    .byte $22,$46,$24,$75,$12,$d2,$db,$03,$3b,$14,$ba,$12
    .byte $51,$46,$62,$34,$58,$35,$dc,$05,$e8,$d2,$19,$62,$15,$8e,$da,$0e,$09,$01,$0e,$e4,$12,$55,$e3,$02,$e2,$1a,$dc,$dc,$04,$d6,$01,$02,$1c,$02
    .byte $22,$44,$34,$01,$0b,$51,$0e,$05,$d3,$38,$0e
    .byte $00

talkBlueMountains2:
    ; 147 bytes
    .byte $10,$67,$dc,$0d,$70,$06,$e3,$3d,$0d,$e3
    .byte $92,$28,$34,$23,$64,$45,$23,$a4,$23,$49,$e6,$24,$de,$0c,$26,$0e,$01,$d4,$0e,$69,$14,$01,$0e,$06,$02,$7e,$17,$c6,$07,$e3,$58,$0f,$d4,$0a,$01,$24,$07,$d1,$48,$d3,$04,$d6,$13,$0c,$14,$01,$d4,$51,$e4,$10,$03,$dd,$22,$04,$e2
    .byte $33,$35,$48,$50,$01,$74,$d8,$0c,$af,$02,$0e,$e1,$08,$54,$5e,$12,$d4,$18
    .byte $41,$74,$63,$64,$40,$46,$52,$04,$d6,$58,$01,$27,$d4,$1f,$e2,$05,$9c,$34,$04,$89,$26,$dd,$9b,$26
    .byte $22,$23,$44,$e6,$1d,$de,$e3,$d3,$26,$dd,$e2,$55,$d4
    .byte $13,$47,$df,$de,$07,$05,$31,$2b,$e2
    .byte $32,$25,$25,$34,$33,$d6,$1b,$1e,$07,$13,$e3,$02,$d5,$07,$d3,$32,$e2
    .byte $00

talkBlueMountains3:
    ; 146 bytes
    .byte $10,$5a,$d9,$37,$de,$d1,$d7,$14,$12,$08,$d3,$02
    .byte $82,$46,$23,$65,$23,$49,$54,$42,$60,$01,$0f,$7a,$0c,$21,$14,$01,$1d,$e1,$05,$d3,$02,$09,$77,$0f,$01,$10,$de,$12,$d1,$08,$b2,$2c,$5e,$65,$20,$6c,$ea,$e5,$06,$d4,$0b,$04,$dc,$09,$01,$e2
    .byte $33,$53,$52,$90,$13,$e3,$02,$05,$d3,$d6,$1b,$e9,$d4,$04,$d0,$2a,$7b,$05,$71
    .byte $41,$32,$46,$22,$40,$05,$d3,$2c,$01,$0f,$7a,$0c,$21,$0f,$e2,$14,$04,$d4
    .byte $43,$3a,$42,$52,$40,$01,$d4,$1a,$0c,$28,$11,$e3,$10,$e4,$12,$d1,$11,$1a,$d2,$08,$5c,$04,$d4
    .byte $43,$52,$76,$23,$39,$2d,$ea,$0c,$d1,$06,$16,$e3,$04,$ea,$60,$11,$4b,$04,$03,$43,$d4,$27,$34,$06,$e3,$08,$d3
    .byte $00

talkFortWallaWalla1:
    ; 148 bytes
    .byte $20,$15,$60,$32,$03,$dd,$d6,$ab,$01,$02
    .byte $52,$48,$24,$27,$53,$75,$d8,$ea,$e5,$11,$1b,$e5,$1f,$0e,$04,$d5,$08,$e1,$14,$04,$38,$05,$1e,$04,$71,$03,$e1,$d9,$03,$43,$21,$d1,$1d,$05
    .byte $32,$22,$35,$43,$42,$14,$e8,$11,$2d,$ea,$e5,$06,$d4,$0b,$d5,$3d
    .byte $62,$52,$36,$25,$62,$42,$a0,$01,$5a,$3d,$10,$d4,$01,$1f,$df,$0e,$4a,$d2,$17,$1e,$e1,$1c,$02,$e2,$07,$e2,$35,$d3,$4a,$e5,$1d,$11,$47,$db,$06
    .byte $22,$51,$40,$12,$d8,$0c,$2c,$08,$e1
    .byte $62,$44,$57,$35,$72,$82,$59,$d8,$ea,$e5,$02,$08,$d3,$d6,$1b,$e5,$10,$0d,$da,$02,$e2,$05,$66,$08,$b8,$12,$07,$d8,$06,$14,$ad,$0c,$04,$5d,$04,$01,$06,$10,$03,$dd,$22,$04,$e2
    .byte $00

talkFortWallaWalla2:
    ; 149 bytes
    .byte $10,$3b,$28,$e8,$1a,$01,$02,$73,$de,$09
    .byte $72,$26,$93,$32,$38,$83,$42,$97,$45,$d2,$03,$e2,$04,$80,$01,$02,$04,$d4,$13,$e2,$09,$d4,$14,$65,$e7,$23,$25,$56,$0b,$07,$df,$d7,$05,$0e,$05,$6b,$24,$e3,$19,$27,$16,$dc,$05,$ea,$68,$0f,$65,$09
    .byte $62,$54,$43,$55,$25,$38,$48,$db,$1c,$0e,$1a,$01,$01,$10,$d5,$07,$01,$3a,$21,$08,$81,$eb,$eb,$3c,$e3,$25,$01,$10,$d0,$1e,$37,$e1,$1f,$d0,$12,$33,$e5,$10,$d1,$02
    .byte $21,$33,$8a,$3e,$d4,$30,$1e,$67,$e5,$1c,$0e,$6d,$49,$61,$16,$06
    .byte $11,$90,$12,$28,$df,$0e,$06
    .byte $11,$50,$99,$0c,$e2
    .byte $42,$62,$32,$71,$80,$8b,$20,$2f,$eb,$eb,$33,$e3,$0a,$dc,$0b,$6c,$09,$28,$d0,$1e,$37,$3a
    .byte $00

talkFortWallaWalla3:
    ; 149 bytes
    .byte $20,$16,$60,$37,$32,$4a,$d4,$04,$38,$05
    .byte $32,$33,$53,$78,$e8,$03,$42,$da,$47,$03,$e3,$01,$d4,$27,$16,$dc,$05,$dc,$d0,$1e,$37,$3a
    .byte $74,$13,$33,$69,$83,$34,$28,$80,$d8,$42,$da,$e8,$03,$27,$e8,$5f,$d2,$e3,$07,$27,$16,$dc,$05,$ea,$68,$0e,$36,$04,$0e,$48,$33,$7f,$67,$10,$e8,$57,$de,$2e,$d4,$ea,$e2,$23,$25,$56,$0b
    .byte $42,$46,$37,$43,$90,$dc,$05,$e8,$80,$e4,$20,$e3,$01,$10,$08,$9b,$06,$d5,$17,$dc,$01,$06,$7d,$05,$d6,$02,$e2
    .byte $74,$33,$38,$63,$83,$43,$82,$56,$27,$e8,$38,$d3,$01,$10,$0e,$36,$04,$18,$de,$0f,$09,$03,$e1,$23,$25,$56,$0b,$05,$9c,$e4,$3a,$01,$15,$d7,$25,$56,$0b,$14,$27,$16,$18,$93,$2e,$d4
    .byte $00

