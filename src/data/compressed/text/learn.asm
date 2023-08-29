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

learnPage1:
    ; 130 bytes
    .byte $61,$36,$17,$27,$56,$45,$26,$e5,$3b,$1b,$dc,$04,$3d,$db,$05,$4c,$20,$4e,$d4,$42,$02,$0d,$11,$d8,$0a,$4d,$15,$1a,$f5,$f3,$f3,$f3,$de,$1f,$06,$17,$34,$d2,$04,$e4
    .byte $11,$60,$e3,$1d,$02,$e4
    .byte $12,$39,$03,$99,$05,$df,$1b,$04,$e4
    .byte $13,$30,$e5,$3b
    .byte $21,$23,$60,$0a,$01,$1e,$a0,$04,$e4
    .byte $a4,$43,$54,$47,$33,$c4,$24,$34,$74,$36,$40,$19,$0b,$ea,$05,$e4,$50,$39,$ea,$05,$15,$e9,$0c,$01,$e3,$05,$1c,$b5,$d5,$03,$d5,$11,$e5,$02,$ed,$80,$0b,$0d,$e3,$e6,$44,$07,$19,$0b,$ea,$05,$34,$8c,$01,$e3,$05,$1c,$86,$14,$38,$e9,$04,$24,$06,$6a,$1e
    .byte $00

learnPage2:
    ; 102 bytes
    .byte $34,$34,$35,$36,$d9,$37,$19,$0b,$ea,$05,$d4,$15,$1a,$01,$02,$1d,$02,$e4
    .byte $21,$23,$45,$4a,$ea,$05,$33,$e7,$0f,$0a,$20
    .byte $61,$35,$41,$53,$52,$17,$20,$ea,$05,$8a,$1c,$e5,$1b,$dc,$09,$d7,$02,$3b,$fa,$4a,$01,$02,$d6,$0e,$5c,$02,$3b,$f1,$fb,$07
    .byte $73,$33,$43,$53,$43,$34,$56,$95,$ea,$05,$d4,$03,$d7,$07,$d5,$01,$02,$1d,$02,$03,$65,$8c,$20,$05,$03,$83,$05,$e3,$11,$d8,$0a,$12,$0c,$ec,$44,$11,$0b,$37,$0d,$28,$1d,$d6
    .byte $00

learnPage3:
    ; 84 bytes
    .byte $24,$45,$80,$25,$d2,$1b,$d3,$05,$44,$47,$34,$da,$06
    .byte $11,$40,$26,$0b
    .byte $42,$26,$32,$43,$34,$4a,$ea,$05,$ec,$e3,$23,$37,$0a,$d7,$2c,$83,$05,$d4,$03,$d9,$36,$e5
    .byte $42,$35,$31,$83,$50,$ea,$05,$8a,$1c,$64,$10,$d2,$2a,$45,$28,$e0,$f9,$ea,$05,$8a,$1c,$e5
    .byte $42,$35,$34,$23,$90,$03,$d5,$01,$02,$09,$41,$d3,$09,$e3,$04,$01,$0f,$05,$df,$1b,$04,$e4
    .byte $00

learnPage4:
    ; 92 bytes
    .byte $21,$23,$60,$21,$01,$0d,$d2,$0b,$06
    .byte $41,$33,$3a,$38,$50,$ea,$05,$d4,$03,$e5,$3b,$df,$8b,$90,$21,$04,$d8,$01,$18,$2f,$61,$91,$12,$1d,$02
    .byte $61,$32,$73,$64,$19,$45,$36,$2a,$e5,$4a,$e3,$36,$df,$04,$d8,$01,$02,$d2,$e1,$40,$e4,$19,$01,$29,$3f,$06,$d9,$4a,$e5,$16,$d7,$6d,$3f,$06,$ea,$05,$9a,$09,$e4,$ea
    .byte $32,$64,$36,$40,$d3,$10,$e5,$02,$1b,$55,$01,$46,$12,$dd,$37,$15,$54
    .byte $00

learnPage5:
    ; 145 bytes
    .byte $61,$23,$46,$35,$72,$45,$50,$da,$45,$07,$e4,$32,$02,$09,$e4,$0a,$ea,$05,$d5,$0a,$ec,$44,$68,$e7,$1d,$d6,$ed,$ed,$ea,$05,$e3,$11,$d8,$0a,$2a,$4c,$e4
    .byte $31,$27,$54,$40,$07,$01,$da,$35,$06,$14,$09,$a6,$05,$15,$e9,$0c
    .byte $31,$23,$33,$2a,$07,$ea,$05,$e3,$36,$05,$08,$d7,$e1,$15,$e7,$0e,$da,$0a,$e4
    .byte $53,$23,$32,$72,$54,$20,$07,$ea,$05,$2e,$d6,$17,$24,$2f,$02,$d2,$ed,$ed,$d5,$0a,$ec,$64,$1d,$d6,$47
    .byte $92,$36,$36,$54,$42,$24,$36,$23,$63,$30,$e5,$3b,$d2,$3d,$04,$f9,$03,$79,$3d,$04,$f9,$36,$e5,$1f,$ea,$05,$4c,$29,$d6,$0e,$47,$19,$01,$01,$9e,$01,$02,$e4,$0a,$01,$d6,$07,$22,$0a,$08,$b3,$0c
    .byte $00

learnPage6:
    ; 38 bytes
    .byte $62,$33,$35,$62,$64,$72,$a0,$ea,$05,$de,$31,$e6,$3e,$01,$06,$18,$2f,$07,$e4,$08,$54,$73,$14,$ea,$05,$e3,$de,$0a,$13,$07,$07,$e5,$23,$35,$0e,$da,$0a
    .byte $00

learnPointer:
    .byte <learnPage1,>learnPage1
    .byte <learnPage2,>learnPage2
    .byte <learnPage3,>learnPage3
    .byte <learnPage4,>learnPage4
    .byte <learnPage5,>learnPage5
    .byte <learnPage6,>learnPage6
