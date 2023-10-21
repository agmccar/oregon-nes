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
    .byte $32,$35,$23,$63,$01,$07,$03,$7b,$0f,$27,$e6,$91,$44,$0e,$14,$d5
    .byte $00

soundText2:
    ; 42 bytes
    .byte $72,$33,$43,$52,$23,$63,$72,$86,$e8,$03,$dc,$32,$91,$44,$01,$07,$03,$7b,$09,$06,$14,$d5,$d3,$64,$04,$d6,$01,$17,$18,$d6,$1b,$dc,$4f,$60,$07,$e2,$04,$5e,$1f,$15,$e3
    .byte $00

soundPointer:
    .byte <soundText1,>soundText1
    .byte <soundText2,>soundText2
