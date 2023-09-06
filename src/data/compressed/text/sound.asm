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

soundText1:
    ; 18 bytes
    .byte $32,$35,$23,$63,$01,$06,$05,$75,$10,$26,$e8,$e5,$46,$df,$0d,$18,$d7
    .byte $00

soundText2:
    ; 43 bytes
    .byte $72,$33,$43,$52,$23,$63,$72,$86,$ea,$05,$de,$2f,$e5,$46,$df,$01,$06,$05,$75,$08,$07,$18,$d7,$d5,$46,$03,$d8,$01,$1a,$15,$d8,$19,$de,$4b,$64,$06,$e4,$03,$58,$1f,$16,$e5
    .byte $00

soundPointer:
    .byte <soundText1,>soundText1
    .byte <soundText2,>soundText2
