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

learnPage1:
    ; 130 bytes
    .byte $61,$36,$17,$27,$56,$45,$26,$e3,$38,$20,$da,$04,$55,$d9,$03,$49,$22,$56,$d2,$5c,$02,$0e,$15,$d6,$09,$26,$14,$1e,$f3,$f1,$f1,$f1,$dc,$2b,$06,$19,$30,$d0,$04,$e2
    .byte $11,$60,$e1,$1b,$02,$e2
    .byte $12,$39,$05,$d3,$dc,$03,$dd,$20,$04,$e2
    .byte $13,$30,$e3,$38
    .byte $21,$23,$60,$09,$01,$18,$b6,$04,$e2
    .byte $a4,$43,$54,$47,$33,$c4,$24,$34,$74,$36,$40,$1a,$0c,$e8,$03,$e2,$27,$39,$e8,$03,$14,$e7,$0b,$01,$e1,$03,$24,$9c,$d3,$05,$89,$10,$02,$eb,$8e,$0c,$0e,$a0,$32,$07,$1a,$0c,$e8,$03,$df,$27,$df,$01,$e1,$03,$24,$9b,$0f,$5f,$e7,$04,$1f,$06,$69,$18
    .byte $00

learnPage2:
    ; 102 bytes
    .byte $34,$34,$35,$36,$d7,$4c,$1a,$0c,$e8,$03,$d2,$14,$1e,$01,$02,$1b,$02,$e2
    .byte $21,$23,$45,$2e,$e8,$03,$2f,$e5,$12,$09,$22
    .byte $61,$35,$41,$53,$52,$17,$20,$e8,$03,$91,$24,$e3,$20,$da,$08,$d5,$02,$38,$fc,$2e,$01,$02,$d4,$13,$4e,$02,$38,$ef,$fd,$07
    .byte $73,$33,$43,$53,$43,$34,$56,$95,$e8,$03,$d2,$05,$d5,$07,$d3,$01,$02,$1b,$02,$05,$6f,$6d,$22,$03,$05,$5b,$03,$e1,$15,$d6,$09,$0d,$0b,$ea,$32,$15,$0c,$4c,$0e,$34,$1b,$d4
    .byte $00

learnPage3:
    ; 83 bytes
    .byte $24,$45,$80,$28,$10,$40,$03,$32,$3e,$30,$d8,$06
    .byte $11,$40,$31,$0c
    .byte $42,$26,$32,$43,$34,$2e,$e8,$03,$ea,$e1,$1c,$4c,$09,$d5,$2c,$5b,$03,$d2,$05,$d7,$36,$e3
    .byte $42,$35,$31,$83,$50,$e8,$03,$91,$24,$5e,$11,$d0,$2a,$50,$d0,$27,$fb,$e8,$03,$91,$24,$e3
    .byte $42,$35,$34,$23,$90,$05,$d3,$01,$02,$08,$42,$d1,$08,$e1,$04,$01,$12,$03,$dd,$20,$04,$e2
    .byte $00

learnPage4:
    ; 91 bytes
    .byte $21,$23,$60,$10,$01,$0e,$d0,$0c,$06
    .byte $41,$33,$3a,$38,$50,$e8,$03,$d2,$05,$e3,$38,$dd,$b4,$a5,$10,$04,$d6,$01,$17,$3a,$62,$ac,$0d,$1b,$02
    .byte $61,$32,$73,$64,$19,$45,$36,$2a,$e3,$2e,$e1,$36,$dd,$04,$d6,$01,$02,$d0,$df,$37,$e2,$1a,$01,$2d,$53,$06,$d7,$2e,$e3,$1d,$d5,$7b,$53,$06,$e8,$03,$85,$08,$c6
    .byte $32,$64,$36,$40,$d1,$11,$e3,$02,$20,$4d,$01,$68,$0d,$27,$e6,$14,$47
    .byte $00

learnPage5:
    ; 145 bytes
    .byte $61,$23,$46,$35,$72,$45,$50,$2e,$d5,$07,$e2,$35,$02,$08,$e2,$09,$e8,$03,$d3,$09,$ea,$32,$60,$e5,$1b,$d4,$eb,$eb,$e8,$03,$e1,$15,$d6,$09,$2a,$49,$e2
    .byte $31,$27,$54,$40,$07,$01,$d8,$3c,$06,$0f,$08,$95,$03,$14,$e7,$0b
    .byte $31,$23,$33,$2a,$07,$e8,$03,$e1,$36,$03,$0a,$d5,$df,$14,$e5,$13,$d8,$09,$e2
    .byte $53,$23,$32,$72,$54,$20,$07,$e8,$03,$44,$d4,$19,$1f,$3a,$02,$d0,$eb,$eb,$d3,$09,$ea,$5e,$1b,$d4,$3e
    .byte $92,$36,$36,$54,$42,$24,$36,$23,$63,$30,$e3,$38,$d0,$55,$04,$fb,$05,$82,$55,$04,$fb,$36,$e3,$2b,$e8,$03,$49,$2d,$d4,$13,$3e,$1a,$01,$01,$48,$01,$02,$e2,$09,$01,$d4,$07,$23,$09,$0a,$77,$0b
    .byte $00

learnPage6:
    ; 38 bytes
    .byte $62,$33,$35,$62,$64,$72,$a0,$e8,$03,$dc,$25,$e4,$41,$01,$06,$17,$3a,$07,$e2,$0a,$47,$74,$0f,$e8,$03,$e1,$dc,$09,$16,$07,$07,$e3,$1c,$3c,$13,$d8,$09
    .byte $00

learnPage7:
    ; 42 bytes
    .byte $72,$33,$43,$52,$23,$63,$72,$86,$e8,$03,$dc,$25,$8f,$49,$01,$06,$03,$88,$09,$07,$19,$d5,$d3,$60,$04,$d6,$01,$18,$14,$d6,$1d,$dc,$56,$67,$06,$e2,$04,$66,$1c,$17,$e3
    .byte $00

learnPointer:
    .byte <learnPage1,>learnPage1
    .byte <learnPage2,>learnPage2
    .byte <learnPage3,>learnPage3
    .byte <learnPage4,>learnPage4
    .byte <learnPage5,>learnPage5
    .byte <learnPage6,>learnPage6
    .byte <learnPage7,>learnPage7
