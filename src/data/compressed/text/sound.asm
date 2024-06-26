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

soundText1:
    ; 15 bytes
    .byte $35,$35,$23,$60,$01,$06,$03,$88,$13,$29,$e6,$8f,$49,$0e
    .byte $00

soundText2:
    ; 42 bytes
    .byte $72,$33,$43,$52,$23,$63,$72,$86,$e8,$03,$dc,$25,$8f,$49,$01,$06,$03,$88,$09,$07,$19,$d5,$d3,$60,$04,$d6,$01,$18,$14,$d6,$1d,$dc,$56,$67,$06,$e2,$04,$66,$1c,$17,$e3
    .byte $00

soundPointer:
    .byte <soundText1,>soundText1
    .byte <soundText2,>soundText2
