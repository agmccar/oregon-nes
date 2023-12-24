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

talkFortWallaWalla1:
    ; 147 bytes
    .byte $20,$15,$60,$26,$03,$dd,$d6,$9d,$01,$02
    .byte $52,$48,$24,$27,$53,$75,$d8,$ea,$e5,$10,$1a,$e5,$1b,$0e,$04,$d5,$08,$e1,$15,$04,$44,$05,$20,$04,$7e,$03,$e1,$d9,$03,$48,$23,$d1,$1f,$05
    .byte $32,$22,$35,$43,$36,$15,$e8,$10,$31,$ea,$e5,$06,$d4,$0b,$d5,$19
    .byte $62,$52,$36,$25,$62,$42,$a0,$01,$5d,$19,$11,$d4,$01,$1b,$df,$0e,$4b,$d2,$18,$20,$e1,$1c,$02,$e2,$07,$e2,$38,$d3,$4b,$e5,$1f,$10,$3f,$db,$06
    .byte $22,$51,$40,$0f,$d8,$0c,$2d,$08,$e1
    .byte $62,$44,$57,$35,$72,$82,$59,$d8,$ea,$e5,$02,$08,$c2,$1a,$e5,$11,$0d,$da,$02,$e2,$05,$6c,$08,$be,$0f,$07,$d8,$06,$15,$b8,$0c,$04,$62,$04,$01,$06,$11,$03,$dd,$22,$04,$e2
    .byte $00

talkFortWallaWalla2:
    ; 148 bytes
    .byte $10,$3b,$28,$e8,$25,$01,$02,$6f,$de,$09
    .byte $72,$26,$93,$32,$38,$83,$42,$97,$49,$d2,$03,$e2,$04,$98,$01,$02,$04,$19,$36,$09,$d4,$15,$5b,$e7,$1d,$27,$54,$0b,$07,$df,$d7,$05,$0e,$05,$70,$24,$e3,$13,$2e,$17,$dc,$05,$ea,$5e,$12,$5b,$09
    .byte $62,$54,$43,$55,$25,$38,$48,$db,$1c,$0e,$25,$01,$01,$11,$d5,$07,$01,$40,$23,$08,$6b,$eb,$eb,$35,$e3,$27,$01,$11,$d0,$20,$2f,$e1,$1b,$d0,$0f,$2b,$e5,$11,$d1,$02
    .byte $21,$33,$8a,$3e,$d4,$33,$20,$66,$e5,$1c,$0e,$ba,$4a,$45,$17,$06
    .byte $11,$90,$0f,$28,$df,$0e,$06
    .byte $11,$50,$a1,$0c,$e2
    .byte $42,$62,$32,$71,$80,$83,$21,$32,$eb,$eb,$2b,$e3,$0a,$dc,$0b,$71,$09,$28,$d0,$20,$2f,$40
    .byte $00

talkFortWallaWalla3:
    ; 146 bytes
    .byte $20,$16,$60,$2f,$26,$4b,$d4,$04,$44,$05
    .byte $32,$33,$53,$78,$e8,$03,$36,$da,$3f,$03,$e3,$01,$19,$d7,$17,$dc,$05,$bc,$20,$2f,$40
    .byte $74,$13,$33,$69,$83,$34,$28,$80,$d8,$36,$da,$e8,$03,$2e,$6e,$de,$d2,$e3,$07,$2e,$17,$dc,$05,$ea,$5e,$0e,$39,$04,$0e,$3b,$2b,$86,$66,$11,$ae,$4e,$30,$d4,$ea,$e2,$1d,$27,$54,$0b
    .byte $42,$46,$37,$43,$90,$dc,$05,$e8,$98,$e4,$21,$e3,$01,$11,$08,$94,$06,$d5,$18,$dc,$01,$06,$7a,$05,$d6,$02,$e2
    .byte $74,$33,$38,$63,$83,$43,$82,$56,$2e,$6e,$3b,$01,$11,$0e,$39,$04,$16,$de,$12,$09,$03,$e1,$1d,$27,$54,$0b,$05,$95,$e4,$40,$01,$14,$d7,$27,$54,$0b,$15,$2e,$17,$16,$4e,$30,$d4
    .byte $00

talkTheDalles1:
    ; 139 bytes
    .byte $20,$18,$30,$28,$03,$dd,$22,$04,$dc,$05
    .byte $f2,$54,$75,$23,$a6,$33,$82,$67,$43,$53,$98,$52,$74,$54,$35,$79,$01,$06,$1b,$36,$01,$35,$54,$0e,$dc,$27,$06,$0a,$01,$19,$d8,$0c,$28,$10,$e3,$3a,$d0,$0c,$23,$0d,$d4,$01,$02,$03,$21,$06,$e3,$eb,$eb,$85,$01,$02,$1a,$bf,$04,$92,$3d,$dd,$01,$06,$25,$bf,$05,$d3,$e3,$66,$29,$db,$0b,$86,$38,$5f,$aa,$0d,$1c,$02,$07,$54,$1c,$04,$d6,$e8,$03,$50,$1e,$09,$58,$02,$01,$06,$e3,$d4,$16,$d2,$36,$d2,$47,$11,$03,$dd,$22,$04,$e2
    .byte $52,$42,$65,$23,$43,$50,$d7,$3c,$d4,$05,$04,$44,$05,$ad,$3b,$d4,$2d,$e8,$03,$22,$4f,$01,$02,$1c,$02
    .byte $00

talkTheDalles2:
    ; 151 bytes
    .byte $10,$3b,$28,$e8,$25,$01,$02,$6f,$de,$09
    .byte $93,$26,$57,$74,$38,$47,$21,$54,$26,$37,$49,$d2,$03,$e2,$04,$91,$44,$d0,$0b,$d6,$1e,$0e,$df,$d0,$20,$1e,$0e,$3d,$dd,$01,$14,$38,$5f,$aa,$d0,$25,$01,$04,$44,$05,$e2,$eb,$eb,$2f,$05,$de,$19,$d8,$01,$f2,$f8,$df,$4e,$30,$d4,$05,$70,$e4,$d6,$d6,$1e,$d4
    .byte $52,$34,$42,$54,$32,$32,$01,$19,$04,$d3,$5c,$19,$e2,$8e,$08,$e5,$e8,$01,$23,$33,$d3,$0a,$db,$26,$52
    .byte $11,$44,$dd,$08,$be,$0d,$da
    .byte $43,$45,$42,$45,$50,$c0,$21,$e6,$7f,$06,$d2,$28,$d4,$43,$58,$02,$01,$d4,$3c,$d7,$08,$42
    .byte $11,$70,$d5,$04,$d0,$0c,$e8
    .byte $32,$44,$22,$56,$01,$23,$dc,$47,$d4,$17,$0a,$3e,$07,$06,$53,$1b,$e8
    .byte $00

talkTheDalles3:
    ; 151 bytes
    .byte $20,$14,$90,$d0,$0a,$0c,$d2,$de,$0c,$14,$e3,$07
    .byte $83,$17,$35,$33,$64,$21,$72,$53,$50,$39,$de,$0c,$14,$e3,$01,$d4,$0a,$0c,$61,$07,$01,$45,$0d,$db,$3d,$18,$47,$eb,$eb,$3f,$0d,$8b,$04,$13,$e3,$25,$7e,$01,$16,$e1,$39,$d4
    .byte $72,$54,$43,$a3,$26,$28,$73,$80,$35,$71,$0c,$d0,$0f,$e8,$08,$e1,$01,$4e,$e5,$02,$db,$05,$d3,$02,$33,$d3,$2b,$1d,$de,$39,$d4,$eb,$eb,$3a,$02,$e8,$09,$24,$4c,$13,$0e,$01,$14,$38,$5f,$aa,$d0
    .byte $22,$34,$20,$2b,$e6,$25,$01,$dc,$e1
    .byte $21,$83,$40,$d1,$0d,$db,$3d,$ea,$ba,$19,$18,$47
    .byte $53,$33,$54,$55,$46,$40,$e8,$03,$d2,$05,$54,$1c,$23,$03,$50,$1e,$09,$57,$21,$e3,$04,$0a,$07,$1f,$09,$d2,$17,$e8
    .byte $00

