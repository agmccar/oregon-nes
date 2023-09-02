; First header byte:
; %00000000
;  ||||++++ Type of punctiation- {' ': 0, ',': 1, '.': 2, '!': 3, '?': 4}
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
; $01 - $d1: Dictionary
; $d2 - $eb: Literal A-Z
; $ec - $f5: Literal special chars: ["'", '-', '"', ';', ':', '.', ',', '…', '(', ')']
; $f6 - $ff: Unused

top10Page1:
    ; 110 bytes
    .byte $62,$44,$98,$23,$63,$44,$30,$ea,$05,$e3,$a5,$13,$2d,$e1,$07,$e5,$04,$6e,$06,$05,$e3,$69,$10,$01,$1a,$89,$30,$20,$05,$34,$6f,$1b,$01,$ea,$05
    .byte $b3,$37,$63,$46,$24,$53,$77,$37,$46,$24,$62,$46,$ea,$05,$e3,$16,$d6,$17,$1a,$e0,$03,$33,$d7,$07,$0a,$24,$de,$0f,$d3,$02,$18,$ea,$05,$e3,$e1,$0e,$4c,$25,$e0,$0e,$e3,$17,$06,$e4,$52,$1f,$ea,$ef,$ea,$05,$e3,$16,$d6,$17,$0f,$07,$1a,$e0,$03,$33,$39,$01,$20,$0e,$e3,$17,$d6,$03,$d8,$2c,$63,$0a,$dd,$01
    .byte $00

top10Page2:
    ; 79 bytes
    .byte $72,$39,$36,$44,$43,$37,$23,$34,$01,$02,$06,$05,$e3,$d4,$06,$ea,$05,$0e,$e3,$17,$d6,$1b,$01,$1b,$0b,$d9,$1f,$e1,$ea,$05,$d8,$11,$13,$0e,$e5,$0d,$03,$01,$0c,$45,$dd,$04,$d5
    .byte $62,$37,$63,$44,$35,$62,$60,$ea,$05,$e3,$16,$d6,$17,$1a,$e0,$03,$33,$d7,$07,$0a,$24,$14,$0f,$ea,$05,$c9,$03,$5b,$52,$1f,$ea,$08,$07,$21,$09
    .byte $00

top10Page3:
    ; 136 bytes
    .byte $52,$37,$63,$4a,$23,$34,$ea,$05,$e3,$16,$d6,$17,$1a,$e0,$03,$33,$d7,$07,$ea,$05,$15,$d4,$d4,$43,$23,$da,$09,$03,$01,$0c,$45,$dd,$04,$d5
    .byte $51,$74,$73,$a4,$64,$70,$d3,$16,$d2,$3a,$0f,$07,$26,$0e,$de,$02,$e4,$04,$b2,$0e,$e1,$0c,$e5,$02,$aa,$02,$0c,$d6,$0d,$0d,$01,$04,$d3,$04,$dc,$02,$e4
    .byte $61,$37,$66,$48,$26,$21,$90,$ea,$05,$e3,$16,$d6,$17,$0d,$05,$58,$1a,$e0,$03,$33,$43,$09,$0e,$e3,$17,$03,$d8,$03,$07,$21,$09,$44,$4b,$0e,$e1,$0c,$e5,$02
    .byte $42,$36,$63,$82,$16,$04,$d5,$e5,$60,$30,$1a,$e0,$03,$33,$d7,$07,$0e,$e3,$17,$03,$3b,$e4,$52,$0e,$de,$02
    .byte $00

top10Pointer:
    .byte <top10Page1,>top10Page1
    .byte <top10Page2,>top10Page2
    .byte <top10Page3,>top10Page3
