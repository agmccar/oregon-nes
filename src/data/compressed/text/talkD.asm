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
    .byte $20,$17,$40,$53,$e1,$05,$e3,$39,$24,$9a
    .byte $c1,$24,$54,$23,$7a,$44,$42,$62,$53,$23,$92,$35,$50,$17,$e2,$26,$e2,$57,$21,$01,$02,$d4,$04,$01,$06,$d7,$1c,$1b,$e8,$ad,$3b,$45,$2c,$da,$ee,$ec,$e8,$03,$dc,$4b,$01,$3c,$d4,$05,$04,$44,$05,$0a,$df,$27,$de,$46,$03,$13,$01,$14,$18,$20,$04,$62,$15,$01,$06,$dd,$4a,$02,$1c,$02
    .byte $83,$25,$92,$39,$c3,$27,$72,$87,$15,$17,$cc,$04,$92,$05,$d6,$02,$03,$e2,$2d,$2a,$e3,$df,$02,$d5,$14,$5f,$e8,$34,$d3,$02,$e2,$0a,$bd,$ef,$ec,$29,$e3,$49,$d7,$4b,$d1,$05,$d3,$04,$5a,$0f,$e2,$09,$d2,$18,$20,$04,$d6,$24,$01,$03,$e3,$1e,$e4,$3b,$d4
    .byte $00

talkSnakeRiver2:
    ; 141 bytes
    .byte $10,$2a,$05,$58,$02,$db,$05,$d3,$02
    .byte $41,$45,$75,$54,$60,$d3,$3d,$dd,$01,$02,$45,$10,$30,$0b,$01,$5c,$06,$e3,$d4,$16,$db,$7f,$1e,$07,$d6,$06
    .byte $21,$83,$80,$e3,$24,$0f,$04,$d6,$05,$82,$57,$01,$04,$d6
    .byte $22,$23,$55,$12,$01,$06,$dd,$4a,$02,$1c,$02
    .byte $53,$24,$52,$32,$42,$32,$e2,$37,$e4,$1d,$e6,$13,$02,$eb,$eb,$05,$42,$8e,$0d,$d3,$0a,$d6,$10,$0a
    .byte $41,$53,$45,$26,$66,$30,$ea,$e5,$1f,$76,$dc,$05,$aa,$27,$06,$15,$d3,$06,$02,$84,$25,$07,$d4,$07,$1f,$09
    .byte $63,$22,$42,$44,$54,$23,$80,$a5,$d1,$06,$e4,$40,$0a,$83,$0c,$e8,$03,$50,$13,$02,$da,$1f,$e2,$13,$01,$14,$18,$20,$04,$d6
    .byte $00

talkSnakeRiver3:
    ; 140 bytes
    .byte $10,$35,$d1,$a2,$db,$03,$d8,$d4
    .byte $24,$34,$45,$e2,$9c,$01,$13,$24,$db,$56,$1c,$02
    .byte $22,$63,$50,$01,$13,$ea,$e2,$01,$06,$dd,$4a,$d4
    .byte $52,$41,$74,$72,$37,$60,$dc,$05,$e8,$36,$1a,$bf,$ea,$80,$d4,$0b,$66,$28,$df,$0e,$04,$d7,$02,$d5,$de,$28,$04,$d6,$1a,$df,$3b,$e2
    .byte $43,$36,$63,$33,$26,$d7,$02,$e6,$13,$02,$0f,$1a,$e5,$1b,$d0,$0c,$01,$19,$26,$0a,$07,$1f,$09
    .byte $31,$52,$83,$40,$30,$ea,$0c,$d1,$14,$18,$20,$04,$21,$02,$a5,$09
    .byte $32,$34,$55,$45,$05,$d3,$01,$0b,$1e,$d0,$04,$53,$e3,$02,$d5,$07,$e3,$64,$12,$d4
    .byte $33,$44,$23,$80,$22,$da,$14,$0d,$08,$e3,$01,$14,$18,$20,$04,$d6
    .byte $00

talkFortBoise1:
    ; 149 bytes
    .byte $10,$5a,$d9,$36,$de,$d1,$d7,$15,$0f,$08,$d3,$02
    .byte $11,$55,$3a,$02,$e8,$6d,$21,$e3
    .byte $41,$46,$14,$43,$55,$3a,$0b,$01,$03,$21,$d8,$d0,$1d,$25,$18,$dc,$01,$0e,$26,$ea,$e2,$0a,$27,$e2
    .byte $82,$24,$26,$46,$23,$44,$42,$3a,$60,$49,$d7,$08,$d3,$12,$83,$0c,$0e,$24,$01,$56,$08,$b5,$15,$01,$02,$d8,$1d,$d5,$0d,$dc,$db,$05,$d3,$15,$01,$19,$d8,$0c,$28,$10,$e3,$3a,$d0,$0c,$23
    .byte $31,$14,$56,$14,$d8,$24,$0c,$29,$27,$d3,$49,$e2,$1b,$d5,$53,$04,$d4
    .byte $62,$89,$23,$37,$42,$46,$45,$d7,$05,$42,$37,$79,$37,$06,$e3,$08,$d3,$eb,$eb,$05,$44,$ea,$dc,$d2,$02,$22,$04,$d8,$ea,$0c,$d1,$02,$d8,$1d,$24,$01,$04,$d5,$1c,$23,$08,$6b
    .byte $00

talkFortBoise2:
    ; 151 bytes
    .byte $30,$16,$41,$50,$13,$1a,$d3,$02,$24,$01,$f7,$dc,$63,$06
    .byte $51,$63,$33,$54,$44,$90,$e8,$03,$ea,$0c,$2a,$60,$10,$e8,$02,$e6,$1e,$09,$58,$02,$01,$11,$5b,$e4,$11,$03,$dd,$22,$04,$e2
    .byte $12,$60,$8a,$0f,$02
    .byte $13,$52,$db,$08,$51,$17
    .byte $42,$53,$54,$44,$70,$d2,$18,$20,$e8,$02,$d6,$2c,$42,$58,$02,$24,$01,$df,$36,$da,$05,$33,$2b,$e2
    .byte $42,$37,$16,$24,$50,$d6,$10,$e8,$02,$e2,$1b,$d5,$36,$03,$2f,$d4,$15,$d6,$2c,$b1,$63,$06
    .byte $83,$62,$66,$35,$24,$24,$53,$54,$46,$b3,$14,$06,$15,$e6,$1e,$09,$94,$17,$e3,$02,$01,$10,$1a,$27,$eb,$eb,$db,$25,$e3,$52,$01,$11,$d5,$38,$93,$2e,$bd,$09,$ea,$01,$d4,$0e,$d6,$2c,$d3,$47,$e5,$39,$d4
    .byte $00

talkFortBoise3:
    ; 132 bytes
    .byte $10,$47,$d0,$34,$e3,$40,$d1,$14,$98
    .byte $31,$25,$45,$35,$13,$3a,$02,$9b,$07,$22,$db,$09,$d6,$01,$10,$1a,$27
    .byte $53,$64,$46,$42,$38,$40,$65,$39,$06,$32,$e5,$45,$d4,$0b,$c0,$21,$02,$01,$05,$13,$01,$16,$e1,$3a,$d8,$03,$61,$07,$e3
    .byte $23,$42,$a0,$01,$12,$12,$03,$e3,$1a,$68,$03,$e2
    .byte $33,$76,$92,$20,$01,$23,$ea,$e1,$10,$4a,$04,$d6,$47,$e5,$05,$e3,$1e,$d4,$15,$4b
    .byte $51,$21,$33,$62,$22,$50,$2d,$d8,$32,$d3,$01,$14,$d7,$05,$7e,$0a,$87,$17,$1e,$d0,$04
    .byte $32,$33,$48,$2c,$d8,$ea,$d3,$29,$aa,$07,$06,$43,$2f,$d8,$06,$04,$04,$d3,$16,$0b,$d3,$0b,$7e
    .byte $00

talkBlueMountains1:
    ; 149 bytes
    .byte $20,$15,$a0,$13,$3c,$0e,$58,$02,$db,$05,$d3,$02
    .byte $41,$58,$35,$24,$50,$e2,$04,$d2,$14,$18,$20,$04,$d6,$01,$06,$dd,$4a,$08,$7b,$07,$e3,$64,$12,$d4
    .byte $32,$44,$49,$36,$17,$ea,$80,$d4,$0b,$72,$0f,$dc,$03,$dd,$22,$04,$e2,$05,$9f,$06,$02,$e3
    .byte $52,$46,$43,$23,$62,$50,$c1,$0f,$75,$16,$02,$08,$1d,$d3,$26,$eb,$eb,$5a,$e7,$04,$1d,$06,$13,$e3,$33,$06
    .byte $11,$26,$2a,$e3,$1a,$54,$e2
    .byte $22,$46,$24,$72,$0f,$d2,$db,$03,$42,$15,$c1,$0f
    .byte $51,$46,$62,$34,$58,$35,$dc,$05,$e8,$d2,$13,$5f,$14,$a4,$da,$0e,$09,$01,$0e,$e4,$0f,$53,$e3,$02,$e2,$24,$dc,$dc,$04,$d6,$01,$02,$1c,$02
    .byte $22,$44,$34,$01,$0b,$5b,$0e,$05,$d3,$44,$0e
    .byte $00

talkBlueMountains2:
    ; 146 bytes
    .byte $10,$67,$dc,$0d,$6d,$06,$e3,$19,$0d,$e3
    .byte $92,$28,$34,$23,$64,$45,$23,$a4,$23,$49,$e6,$25,$de,$0c,$3d,$0e,$01,$d4,$0e,$68,$15,$01,$0e,$06,$02,$7b,$18,$cb,$07,$e3,$64,$12,$d4,$0a,$01,$25,$07,$d1,$3b,$d3,$04,$d6,$af,$0c,$15,$01,$45,$db,$e4,$11,$03,$dd,$22,$04,$e2
    .byte $33,$35,$48,$50,$01,$79,$d8,$0c,$66,$02,$0e,$e1,$08,$55,$63,$0f,$d4,$16
    .byte $41,$74,$63,$64,$40,$4c,$54,$04,$d6,$64,$01,$2e,$d4,$1b,$e2,$05,$95,$37,$04,$92,$3d,$dd,$94,$3d
    .byte $22,$23,$44,$e6,$1f,$76,$d3,$3d,$dd,$e2,$53,$d4
    .byte $13,$47,$df,$de,$07,$05,$33,$2b,$e2
    .byte $32,$25,$25,$34,$2a,$d6,$1a,$20,$07,$e6,$13,$02,$d5,$07,$d3,$26,$e2
    .byte $00

talkBlueMountains3:
    ; 145 bytes
    .byte $10,$5a,$d9,$36,$de,$d1,$d7,$15,$0f,$08,$d3,$02
    .byte $82,$46,$23,$65,$23,$49,$54,$42,$60,$01,$12,$90,$0c,$23,$15,$01,$1f,$e1,$05,$d3,$02,$09,$75,$12,$01,$11,$de,$0f,$d1,$08,$a3,$2d,$63,$5a,$21,$70,$ea,$e5,$06,$d4,$0b,$04,$dc,$09,$01,$e2
    .byte $33,$53,$52,$90,$e6,$13,$02,$05,$c2,$1a,$e9,$d4,$04,$d0,$29,$81,$05,$7e
    .byte $41,$32,$46,$22,$40,$05,$d3,$2d,$01,$12,$90,$0c,$23,$12,$e2,$15,$04,$d4
    .byte $43,$3a,$42,$52,$40,$01,$19,$d8,$0c,$28,$10,$e3,$11,$e4,$0f,$d1,$10,$24,$d2,$08,$61,$04,$d4
    .byte $43,$52,$76,$23,$39,$30,$ea,$0c,$d1,$06,$17,$e3,$04,$ea,$65,$10,$46,$04,$03,$48,$19,$d7,$37,$06,$e3,$08,$d3
    .byte $00

talkFortWallaWalla1:
    ; 147 bytes
    .byte $20,$15,$60,$26,$03,$dd,$d6,$9d,$01,$02
    .byte $52,$48,$24,$27,$53,$75,$d8,$ea,$e5,$10,$1a,$e5,$1b,$0e,$04,$d5,$08,$e1,$15,$04,$44,$05,$20,$04,$7e,$03,$e1,$d9,$03,$48,$23,$d1,$1f,$05
    .byte $32,$22,$35,$43,$35,$15,$e8,$10,$30,$ea,$e5,$06,$d4,$0b,$d5,$19
    .byte $62,$52,$36,$25,$62,$42,$a0,$01,$5c,$19,$11,$d4,$01,$1b,$df,$0e,$4b,$d2,$18,$20,$e1,$1c,$02,$e2,$07,$e2,$38,$d3,$4b,$e5,$1f,$10,$3f,$db,$06
    .byte $22,$51,$40,$0f,$d8,$0c,$2d,$08,$e1
    .byte $62,$44,$57,$35,$72,$82,$59,$d8,$ea,$e5,$02,$08,$c2,$1a,$e5,$11,$0d,$da,$02,$e2,$05,$6c,$08,$be,$0f,$07,$d8,$06,$15,$b8,$0c,$04,$62,$04,$01,$06,$11,$03,$dd,$22,$04,$e2
    .byte $00

talkFortWallaWalla2:
    ; 148 bytes
    .byte $10,$3b,$28,$e8,$24,$01,$02,$78,$de,$09
    .byte $72,$26,$93,$32,$38,$83,$42,$97,$49,$d2,$03,$e2,$04,$98,$01,$02,$04,$19,$35,$09,$d4,$15,$5a,$e7,$1d,$27,$56,$0b,$07,$df,$d7,$05,$0e,$05,$6f,$25,$e3,$13,$2e,$17,$dc,$05,$ea,$5d,$12,$5a,$09
    .byte $62,$54,$43,$55,$25,$38,$48,$db,$1c,$0e,$24,$01,$01,$11,$d5,$07,$01,$40,$23,$08,$6b,$eb,$eb,$34,$e3,$27,$01,$11,$d0,$20,$36,$e1,$1b,$d0,$0f,$2a,$e5,$11,$d1,$02
    .byte $21,$33,$8a,$3e,$d4,$32,$20,$67,$e5,$1c,$0e,$ba,$4a,$45,$17,$06
    .byte $11,$90,$0f,$28,$df,$0e,$06
    .byte $11,$50,$a0,$0c,$e2
    .byte $42,$62,$32,$71,$80,$83,$21,$31,$eb,$eb,$2a,$e3,$0a,$dc,$0b,$70,$09,$28,$d0,$20,$36,$40
    .byte $00

talkFortWallaWalla3:
    ; 146 bytes
    .byte $20,$16,$60,$36,$26,$4b,$d4,$04,$44,$05
    .byte $32,$33,$53,$78,$e8,$03,$35,$da,$3f,$03,$e3,$01,$19,$d7,$17,$dc,$05,$bc,$20,$36,$40
    .byte $74,$13,$33,$69,$83,$34,$28,$80,$d8,$35,$da,$e8,$03,$2e,$6e,$de,$d2,$e3,$07,$2e,$17,$dc,$05,$ea,$5d,$0e,$39,$04,$0e,$3b,$2a,$86,$67,$11,$ae,$4e,$2f,$d4,$ea,$e2,$1d,$27,$56,$0b
    .byte $42,$46,$37,$43,$90,$dc,$05,$e8,$98,$e4,$21,$e3,$01,$11,$08,$94,$06,$d5,$18,$dc,$01,$06,$7a,$05,$d6,$02,$e2
    .byte $74,$33,$38,$63,$83,$43,$82,$56,$2e,$6e,$3b,$01,$11,$0e,$39,$04,$16,$de,$12,$09,$03,$e1,$1d,$27,$56,$0b,$05,$95,$e4,$40,$01,$14,$d7,$27,$56,$0b,$15,$2e,$17,$16,$4e,$2f,$d4
    .byte $00

