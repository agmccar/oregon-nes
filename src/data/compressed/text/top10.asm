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

top10Page1:
    ; 111 bytes
    .byte $62,$44,$98,$23,$63,$44,$30,$e8,$03,$e1,$b0,$12,$32,$df,$07,$e3,$05,$80,$06,$03,$e1,$77,$0f,$01,$19,$96,$2e,$21,$03,$35,$e5,$18,$d8,$01,$e8,$03
    .byte $b3,$37,$63,$46,$24,$53,$77,$37,$46,$24,$62,$46,$e8,$03,$e1,$15,$d4,$1b,$19,$de,$04,$31,$d5,$07,$08,$23,$dc,$10,$d1,$02,$13,$e8,$03,$e1,$df,$0d,$46,$30,$de,$0d,$e1,$1b,$06,$e2,$55,$1f,$e8,$ed,$e8,$03,$e1,$15,$d4,$1b,$10,$07,$19,$de,$04,$31,$2c,$01,$21,$0d,$e1,$1b,$d4,$04,$d6,$29,$66,$08,$db,$01
    .byte $00

top10Page2:
    ; 79 bytes
    .byte $72,$39,$36,$44,$43,$37,$23,$34,$01,$02,$06,$03,$e1,$d2,$06,$e8,$03,$0d,$e1,$1b,$18,$d8,$01,$25,$0c,$d7,$1f,$c2,$03,$d6,$11,$12,$0d,$e3,$0e,$04,$01,$0b,$18,$db,$05,$d3
    .byte $62,$37,$63,$44,$35,$62,$60,$e8,$03,$e1,$15,$d4,$1b,$19,$de,$04,$31,$d5,$07,$08,$23,$16,$10,$e8,$03,$d1,$e1,$04,$5e,$55,$1f,$e8,$0a,$07,$1d,$09
    .byte $00

top10Page3:
    ; 136 bytes
    .byte $52,$37,$63,$4a,$23,$34,$e8,$03,$e1,$15,$d4,$1b,$19,$de,$04,$31,$d5,$07,$e8,$03,$17,$d2,$d2,$41,$14,$d8,$09,$04,$01,$0b,$18,$db,$05,$d3
    .byte $51,$74,$73,$a4,$64,$70,$d1,$15,$d0,$4b,$10,$07,$22,$0d,$dc,$02,$e2,$05,$9f,$0d,$df,$0b,$e3,$02,$69,$02,$0b,$d4,$0e,$0e,$01,$05,$d1,$05,$da,$02,$e2
    .byte $61,$37,$66,$48,$26,$21,$90,$e8,$03,$e1,$15,$d4,$1b,$0e,$03,$59,$19,$de,$04,$31,$41,$09,$0d,$e1,$1b,$04,$d6,$04,$07,$1d,$09,$2f,$3a,$0d,$df,$0b,$e3,$02
    .byte $42,$36,$63,$82,$16,$05,$d3,$e3,$58,$2e,$19,$de,$04,$31,$d5,$07,$0d,$e1,$1b,$04,$d6,$2f,$55,$0d,$dc,$02
    .byte $00

top10Pointer:
    .byte <top10Page1,>top10Page1
    .byte <top10Page2,>top10Page2
    .byte <top10Page3,>top10Page3
