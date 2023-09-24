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

talkTheDalles1:
    ; 139 bytes
    .byte $20,$18,$30,$23,$03,$dd,$26,$04,$dc,$05
    .byte $f2,$54,$75,$23,$a6,$33,$82,$67,$43,$53,$98,$52,$74,$54,$35,$79,$01,$06,$1f,$2f,$01,$3d,$56,$0e,$dc,$27,$06,$0a,$01,$17,$d8,$0c,$23,$11,$e3,$3c,$d0,$0c,$21,$0d,$d4,$01,$02,$03,$20,$06,$e3,$eb,$eb,$7f,$01,$02,$1a,$bc,$04,$8c,$28,$dd,$01,$06,$25,$bc,$05,$d3,$e3,$67,$2a,$db,$0b,$82,$37,$5c,$a0,$0d,$1b,$02,$07,$56,$1b,$04,$d6,$e8,$03,$52,$1c,$09,$4c,$02,$01,$06,$e3,$d4,$19,$d2,$2f,$d2,$4d,$10,$03,$dd,$26,$04,$e2
    .byte $52,$42,$65,$23,$43,$50,$d7,$3b,$d4,$05,$04,$42,$05,$a4,$39,$d4,$2c,$e8,$03,$26,$4f,$01,$02,$1b,$02
    .byte $00

talkTheDalles2:
    ; 151 bytes
    .byte $10,$3b,$23,$e8,$25,$01,$02,$70,$de,$09
    .byte $93,$26,$57,$74,$38,$47,$21,$54,$26,$37,$45,$d2,$03,$e2,$04,$99,$42,$d0,$0b,$d6,$1c,$0e,$df,$d0,$1e,$1c,$0e,$28,$dd,$01,$15,$37,$5c,$a0,$d0,$25,$01,$04,$42,$05,$e2,$eb,$eb,$3a,$05,$de,$17,$d8,$01,$f2,$f8,$57,$de,$2e,$d4,$05,$6b,$e4,$d6,$d6,$1c,$d4
    .byte $52,$34,$42,$54,$32,$32,$01,$17,$04,$d3,$59,$17,$e2,$8a,$08,$e5,$e8,$01,$21,$35,$d3,$0a,$db,$2d,$4e
    .byte $11,$44,$dd,$08,$bb,$0d,$da
    .byte $43,$45,$42,$45,$50,$bd,$20,$e6,$79,$06,$d2,$23,$d4,$41,$4c,$02,$01,$d4,$3b,$d7,$08,$3f
    .byte $11,$70,$d5,$04,$d0,$0c,$e8
    .byte $32,$44,$22,$56,$01,$21,$dc,$4d,$d4,$16,$0a,$40,$07,$06,$55,$1f,$e8
    .byte $00

talkTheDalles3:
    ; 151 bytes
    .byte $20,$14,$90,$d0,$0a,$0c,$d2,$de,$0c,$15,$e3,$07
    .byte $83,$17,$35,$33,$64,$21,$72,$53,$50,$38,$de,$0c,$15,$e3,$01,$d4,$0a,$0c,$5d,$07,$01,$49,$0d,$db,$28,$18,$4d,$eb,$eb,$47,$0d,$87,$04,$14,$e3,$25,$78,$01,$19,$e1,$38,$d4
    .byte $72,$54,$43,$a3,$26,$28,$73,$80,$3d,$6c,$0c,$d0,$12,$e8,$08,$e1,$01,$d4,$4c,$02,$db,$05,$d3,$02,$35,$d3,$34,$22,$de,$38,$d4,$eb,$eb,$3c,$02,$e8,$09,$24,$46,$14,$0e,$01,$15,$37,$5c,$a0,$d0
    .byte $22,$34,$20,$dd,$28,$25,$01,$dc,$e1
    .byte $21,$83,$40,$d1,$0d,$db,$28,$ea,$73,$17,$18,$4d
    .byte $53,$33,$54,$55,$46,$40,$e8,$03,$d2,$05,$56,$1b,$21,$03,$52,$1c,$09,$58,$20,$e3,$04,$0a,$07,$1d,$09,$d2,$16,$e8
    .byte $00

