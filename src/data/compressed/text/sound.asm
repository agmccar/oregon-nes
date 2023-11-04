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
    ; 17 bytes
    .byte $32,$35,$23,$63,$01,$06,$03,$81,$12,$2a,$e6,$97,$48,$0e,$15,$d5
    .byte $00

soundText2:
    ; 42 bytes
    .byte $72,$33,$43,$52,$23,$63,$72,$86,$e8,$03,$dc,$26,$97,$48,$01,$06,$03,$81,$09,$07,$15,$d5,$d3,$67,$04,$d6,$01,$16,$18,$d6,$1a,$dc,$52,$65,$06,$e2,$04,$62,$1b,$14,$e3
    .byte $00

soundPointer:
    .byte <soundText1,>soundText1
    .byte <soundText2,>soundText2
