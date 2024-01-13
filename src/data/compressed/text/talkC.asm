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

talkSodaSprings1:
    ; 139 bytes
    .byte $10,$75,$d2,$1c,$04,$82,$d7,$04,$06
    .byte $11,$20,$4a
    .byte $33,$34,$73,$26,$01,$06,$c2,$47,$66,$04,$65,$0d,$06,$de,$66,$11,$3f
    .byte $32,$42,$52,$79,$4d,$12,$0a,$72,$03,$e3,$10,$e1,$23,$5d,$0d,$04,$e3,$02,$e5,$33,$e2
    .byte $72,$44,$24,$43,$32,$72,$35,$33,$d5,$1c,$5e,$2c,$d3,$0a,$74,$0f,$e1,$06,$e3,$05,$d3,$29,$e3,$6c,$c0,$0f,$db,$0e,$04,$01,$d4,$15,$d6,$09,$d0,$0c,$d3,$25
    .byte $31,$41,$32,$60,$28,$0b,$a5,$11,$0a,$07,$23,$09
    .byte $73,$44,$14,$73,$35,$52,$15,$50,$d8,$ea,$0c,$2e,$e5,$08,$e2,$16,$78,$08,$01,$02,$d1,$0e,$05,$d3,$dd,$3c,$02,$a9,$d4,$18,$04,$d0,$15,$d6,$09,$d0,$55,$04
    .byte $00

talkSodaSprings2:
    ; 138 bytes
    .byte $20,$15,$30,$25,$03,$dd,$d6,$57,$e8
    .byte $62,$23,$53,$22,$44,$33,$44,$4a,$c0,$d1,$3c,$02,$86,$25,$13,$0a,$d5,$04,$8a,$2c,$54,$07,$01,$17,$2c,$da,$d5,$3d,$d4
    .byte $41,$94,$44,$24,$60,$e2,$34,$11,$35,$06,$19,$ea,$e2,$e5,$02,$e8,$d7,$0d,$d3,$0a,$d5,$04,$d3,$0b,$03,$24
    .byte $62,$21,$55,$62,$13,$53,$50,$8c,$d8,$0f,$07,$d4,$75,$e3,$1d,$9d,$17,$06,$04,$40,$aa,$36,$d3,$02,$01,$d4,$15,$d6,$09
    .byte $72,$23,$71,$87,$52,$44,$56,$34,$09,$01,$18,$1d,$3d,$d8,$b1,$55,$01,$02,$0e,$2a,$50,$d0,$27,$1f,$d8,$df,$e2,$0a,$2a,$49,$28,$0b,$01,$02,$d4,$15,$a1,$ea,$e3,$05,$e8,$e6,$2c,$d3
    .byte $00

talkSodaSprings3:
    ; 134 bytes
    .byte $10,$58,$dc,$2b,$06,$d7,$0b,$51,$3b,$da
    .byte $b1,$45,$24,$45,$34,$72,$42,$73,$72,$42,$63,$39,$d8,$ea,$46,$d7,$08,$c3,$19,$93,$37,$01,$10,$01,$02,$08,$e1,$12,$05,$e8,$d2,$e4,$0a,$50,$e2,$0a,$20,$4c,$0a,$39,$07,$e3,$0b,$01,$cf,$03,$49,$22,$eb,$eb,$01,$10,$56,$20,$da,$04,$55,$0c,$01,$06,$d7,$07,$81,$e4,$32
    .byte $42,$33,$44,$42,$35,$e8,$03,$d2,$05,$93,$e5,$12,$05,$86,$25,$e2,$09,$01,$11,$1d,$2b
    .byte $24,$33,$30,$05,$d3,$28,$e8,$29,$e3
    .byte $43,$64,$3a,$25,$34,$93,$e5,$04,$c9,$35,$d4,$05,$d3,$df,$14,$e5,$13,$d8,$09,$e2,$13,$e6,$07,$01,$01,$02,$13,$da
    .byte $00

talkFortHall1:
    ; 152 bytes
    .byte $10,$58,$dc,$2b,$06,$d7,$0b,$51,$3b,$da
    .byte $11,$40,$31,$0c
    .byte $11,$60,$d5,$59,$0b,$d3
    .byte $32,$42,$52,$40,$01,$13,$13,$28,$02,$42,$18,$0d,$e3
    .byte $52,$35,$3a,$42,$86,$25,$d8,$ea,$dc,$d1,$03,$dd,$54,$07,$d2,$33,$30,$07,$70,$d0,$1a,$01,$05,$35,$df,$87,$04,$97,$06,$02,$e3,$0a,$d2,$14,$1e
    .byte $51,$33,$26,$33,$55,$25,$05,$5b,$03,$eb,$eb,$e8,$03,$ea,$e5,$23,$99,$01,$06,$dd,$53,$02,$1b,$02,$0a,$d2,$14,$1e
    .byte $33,$51,$42,$26,$28,$d8,$1f,$d8,$d7,$08,$e1,$13,$29,$df,$3b,$dd,$3b
    .byte $11,$52,$e6,$e1,$19,$d4,$5a
    .byte $21,$32,$36,$e8,$03,$07,$01,$12,$13,$e2,$5a
    .byte $43,$42,$42,$35,$60,$74,$0f,$d0,$1e,$de,$09,$47,$e8,$03,$e1,$08,$1f,$07,$23,$09
    .byte $00

talkFortHall2:
    ; 138 bytes
    .byte $10,$47,$d0,$36,$e3,$41,$d1,$17,$79
    .byte $32,$47,$85,$64,$d7,$08,$e1,$01,$02,$d4,$ea,$61,$03,$dd,$20,$04,$39,$d4,$18,$0d,$03,$dd,$6f,$02,$d4
    .byte $21,$65,$30,$0b,$03,$24,$e6,$10,$02,$0a,$de
    .byte $32,$36,$15,$24,$2a,$01,$0d,$6b,$e8,$d0,$0f,$3b,$da,$16,$e6,$2c,$d3
    .byte $33,$56,$34,$40,$01,$05,$da,$d7,$08,$e5,$0b,$d5,$07,$d5,$07,$01,$d0,$0c
    .byte $92,$33,$45,$22,$67,$26,$53,$33,$57,$3a,$2a,$73,$ea,$dc,$e1,$08,$ab,$07,$38,$0a,$d1,$06,$25,$04,$d6,$d6,$2c,$d3,$56,$d4,$0a,$d2,$03,$e2,$04,$dc,$2b,$06,$05,$82,$0c,$01,$21,$3a,$da,$39,$08,$d3,$04,$a8,$07,$d2,$33,$30,$07,$70,$d0
    .byte $00

talkFortHall3:
    ; 148 bytes
    .byte $20,$16,$80,$4e,$d4,$0c,$4b,$e3,$1d,$e5,$1c,$02
    .byte $33,$44,$21,$44,$d5,$07,$01,$d0,$0c,$13,$d0,$2a,$e2,$91,$07,$e3
    .byte $72,$34,$92,$65,$43,$44,$35,$74,$01,$d4,$1a,$d3,$06,$76,$11,$1f,$06,$16,$dc,$08,$d3,$4b,$d6,$1d,$1e,$d7,$02,$08,$41,$74,$0f,$28,$10,$03,$e1,$e3,$3d,$0e,$05,$35,$33,$e2,$8d,$0e
    .byte $21,$23,$20,$47,$d5,$07,$8e
    .byte $32,$43,$23,$55,$d8,$ea,$0c,$8f,$e7,$3e,$01,$d4,$15,$d6,$09,$db,$08,$8b
    .byte $82,$84,$72,$43,$37,$36,$23,$25,$57,$2d,$05,$82,$ea,$e2,$e1,$08,$db,$05,$ba,$03,$e2,$0a,$15,$e2,$2e,$0c,$01,$17,$27,$01,$06,$05,$6b,$04,$0b,$e2,$04,$09,$d4,$16,$01,$87,$17,$db,$08,$e1,$0f,$e1,$08,$b7
    .byte $00

talkSnakeRiver1:
    ; 138 bytes
    .byte $20,$17,$40,$4e,$e1,$05,$e3,$3b,$1a,$83
    .byte $c1,$24,$54,$23,$7a,$44,$42,$62,$53,$23,$92,$35,$50,$19,$e2,$25,$e2,$59,$24,$01,$02,$d4,$04,$01,$06,$d7,$1b,$1c,$e8,$80,$37,$67,$2c,$da,$ee,$ec,$e8,$03,$dc,$5a,$01,$3d,$d4,$05,$04,$44,$05,$0a,$9d,$27,$3f,$03,$10,$01,$17,$14,$1e,$04,$65,$16,$01,$06,$dd,$53,$02,$1b,$02
    .byte $83,$25,$92,$39,$c3,$27,$72,$87,$15,$19,$6c,$04,$97,$05,$d6,$02,$03,$e2,$30,$29,$e3,$df,$02,$d5,$17,$58,$e8,$36,$d3,$02,$e2,$0a,$c2,$ef,$ec,$2a,$e3,$4a,$d7,$5a,$d1,$05,$d3,$04,$5f,$0f,$e2,$09,$d2,$14,$1e,$04,$d6,$1a,$01,$03,$20,$80,$37,$d4
    .byte $00

talkSnakeRiver2:
    ; 142 bytes
    .byte $10,$2a,$05,$5c,$02,$db,$05,$d3,$02
    .byte $41,$45,$75,$54,$60,$d3,$4b,$dd,$01,$02,$67,$11,$31,$0b,$01,$87,$06,$e3,$d4,$18,$b6,$88,$d6,$07,$d6,$06
    .byte $21,$83,$80,$e3,$1a,$0f,$04,$d6,$05,$8a,$59,$01,$04,$d6
    .byte $22,$23,$55,$13,$01,$06,$dd,$53,$02,$1b,$02
    .byte $53,$24,$52,$32,$42,$32,$e2,$34,$e4,$1f,$e6,$10,$02,$eb,$eb,$05,$45,$b5,$0d,$d3,$0a,$d6,$11,$0a
    .byte $41,$53,$45,$26,$66,$31,$ea,$e5,$23,$de,$7b,$05,$ae,$2b,$06,$16,$d3,$06,$02,$b0,$21,$07,$d4,$07,$23,$09
    .byte $63,$22,$42,$44,$54,$23,$80,$8c,$d1,$06,$e4,$41,$0a,$8f,$0c,$e8,$03,$e1,$e6,$10,$02,$da,$23,$e2,$10,$01,$17,$14,$1e,$04,$d6
    .byte $00

talkSnakeRiver3:
    ; 141 bytes
    .byte $10,$35,$d1,$a5,$db,$03,$ce
    .byte $24,$34,$45,$4d,$d4,$01,$10,$1a,$db,$51,$1b,$02
    .byte $22,$63,$50,$01,$10,$ea,$e2,$01,$06,$dd,$d0,$4c
    .byte $52,$41,$74,$72,$37,$60,$dc,$05,$e8,$26,$1d,$c4,$ea,$e2,$6c,$0b,$e2,$15,$dc,$df,$0e,$04,$d7,$02,$d5,$de,$2d,$04,$d6,$1d,$df,$37,$e2
    .byte $43,$36,$63,$33,$26,$d7,$02,$e6,$10,$02,$0f,$1d,$e5,$1c,$d0,$0c,$01,$d4,$15,$e8,$0a,$07,$23,$09
    .byte $31,$52,$83,$40,$31,$ea,$0c,$d1,$17,$14,$1e,$04,$24,$02,$8c,$09
    .byte $32,$34,$55,$45,$05,$d3,$01,$0b,$d0,$55,$04,$4e,$e3,$02,$d5,$07,$e3,$57,$13,$d4
    .byte $33,$44,$23,$80,$20,$da,$17,$0d,$08,$e3,$01,$17,$14,$1e,$04,$d6
    .byte $00

talkFortBoise1:
    ; 149 bytes
    .byte $10,$5a,$d9,$26,$de,$d1,$d7,$16,$0f,$08,$d3,$02
    .byte $11,$55,$3c,$02,$e8,$70,$24,$e3
    .byte $41,$46,$14,$43,$55,$3c,$0b,$01,$03,$24,$d8,$d0,$1f,$21,$14,$dc,$01,$0e,$25,$ea,$e2,$0a,$2b,$e2
    .byte $82,$24,$26,$46,$23,$44,$42,$3a,$60,$4a,$d7,$08,$d3,$13,$8f,$0c,$0e,$1a,$01,$51,$08,$b7,$16,$01,$02,$d8,$1f,$d5,$0d,$dc,$db,$05,$d3,$16,$01,$d4,$1a,$0c,$2d,$11,$e3,$3c,$d0,$0c,$22
    .byte $31,$14,$56,$14,$d8,$1a,$0c,$2a,$2b,$d3,$4a,$e2,$1c,$d5,$4e,$04,$d4
    .byte $62,$89,$23,$37,$42,$46,$45,$d7,$05,$45,$34,$7f,$34,$06,$e3,$08,$d3,$eb,$eb,$05,$44,$ea,$dc,$d2,$02,$20,$04,$d8,$ea,$0c,$d1,$02,$d8,$1f,$1a,$01,$04,$d5,$1b,$22,$08,$6a
    .byte $00

talkFortBoise2:
    ; 152 bytes
    .byte $30,$16,$41,$50,$10,$1d,$d3,$02,$1a,$01,$f7,$dc,$5d,$06
    .byte $51,$63,$33,$54,$44,$90,$e8,$03,$ea,$0c,$29,$5e,$11,$e8,$02,$15,$d6,$09,$5c,$02,$01,$12,$52,$e4,$12,$03,$dd,$20,$04,$e2
    .byte $12,$60,$92,$0f,$02
    .byte $13,$52,$db,$08,$46,$19
    .byte $42,$53,$54,$44,$70,$d2,$14,$1e,$e8,$02,$d6,$2c,$45,$5c,$02,$1a,$01,$df,$26,$da,$05,$35,$33,$e2
    .byte $42,$37,$16,$24,$50,$d6,$11,$e8,$02,$e2,$1c,$d5,$26,$03,$2f,$d4,$16,$d6,$2c,$d3,$dc,$5d,$06
    .byte $83,$62,$66,$35,$24,$24,$53,$54,$46,$9d,$17,$06,$16,$15,$d6,$09,$a9,$19,$e3,$02,$01,$11,$1d,$2b,$eb,$eb,$db,$21,$e3,$56,$01,$12,$d5,$3a,$8b,$28,$c2,$09,$ea,$01,$d4,$0e,$d6,$2c,$d3,$43,$e5,$3b,$d4
    .byte $00

talkFortBoise3:
    ; 130 bytes
    .byte $10,$47,$d0,$36,$e3,$41,$d1,$17,$79
    .byte $31,$25,$45,$35,$10,$3c,$02,$91,$07,$20,$db,$09,$d6,$01,$11,$1d,$2b
    .byte $53,$64,$46,$42,$38,$40,$66,$3b,$06,$2e,$46,$6c,$0b,$c5,$24,$02,$01,$05,$10,$01,$18,$e1,$3c,$d8,$03,$64,$07,$e3
    .byte $23,$42,$a0,$01,$13,$13,$03,$e3,$1d,$63,$03,$e2
    .byte $33,$76,$92,$20,$01,$22,$ea,$e1,$11,$53,$04,$d6,$43,$e5,$05,$20,$63,$16,$5a
    .byte $51,$21,$33,$62,$22,$50,$30,$d8,$2e,$d3,$01,$17,$d7,$05,$7d,$0a,$6e,$19,$d0,$55,$04
    .byte $32,$33,$48,$2c,$d8,$ea,$d3,$2a,$ae,$07,$06,$3e,$2f,$d8,$06,$04,$04,$d3,$18,$0b,$d3,$0b,$7d
    .byte $00

talkBlueMountains1:
    ; 149 bytes
    .byte $20,$15,$a0,$10,$3d,$0e,$5c,$02,$db,$05,$d3,$02
    .byte $41,$58,$35,$24,$50,$e2,$04,$d2,$17,$14,$1e,$04,$d6,$01,$06,$dd,$53,$08,$78,$07,$e3,$57,$13,$d4
    .byte $32,$44,$49,$36,$19,$ea,$e2,$6c,$0b,$74,$0f,$dc,$03,$dd,$20,$04,$e2,$05,$a2,$06,$02,$e3
    .byte $52,$46,$43,$23,$62,$50,$9b,$0f,$69,$18,$02,$08,$1f,$d3,$25,$eb,$eb,$5f,$e7,$04,$1f,$06,$10,$e3,$35,$06
    .byte $11,$26,$29,$e3,$1d,$4f,$e2
    .byte $22,$46,$24,$74,$0f,$d2,$db,$03,$45,$16,$9b,$0f
    .byte $51,$46,$62,$34,$58,$35,$dc,$05,$e8,$d2,$10,$58,$17,$98,$da,$0e,$09,$01,$0e,$e4,$0f,$4e,$e3,$02,$e2,$1a,$dc,$dc,$04,$d6,$01,$02,$1b,$02
    .byte $22,$44,$34,$01,$0b,$52,$0e,$05,$d3,$44,$0e
    .byte $00

talkBlueMountains2:
    ; 147 bytes
    .byte $10,$67,$dc,$0d,$70,$06,$e3,$42,$0d,$e3
    .byte $92,$28,$34,$23,$64,$45,$23,$a4,$23,$49,$e6,$21,$de,$0c,$4b,$0e,$01,$d4,$0e,$63,$16,$01,$0e,$06,$02,$78,$14,$dc,$d5,$07,$e3,$57,$13,$d4,$0a,$01,$21,$07,$d1,$37,$d3,$04,$d6,$15,$0c,$16,$01,$d4,$52,$e4,$12,$03,$dd,$20,$04,$e2
    .byte $33,$35,$48,$50,$01,$7f,$d8,$0c,$96,$02,$0e,$e1,$08,$54,$5d,$0f,$d4,$18
    .byte $41,$74,$63,$64,$40,$27,$4f,$04,$d6,$57,$01,$28,$d4,$1c,$e2,$05,$9a,$34,$04,$97,$4b,$dd,$e2,$27,$e6
    .byte $22,$23,$44,$e6,$23,$99,$d3,$4b,$dd,$e2,$4e,$d4
    .byte $13,$47,$c1,$07,$05,$35,$33,$e2
    .byte $32,$25,$25,$34,$29,$d6,$1d,$1e,$07,$e6,$10,$02,$d5,$07,$d3,$25,$e2
    .byte $00

talkBlueMountains3:
    ; 145 bytes
    .byte $10,$5a,$d9,$26,$de,$d1,$d7,$16,$0f,$08,$d3,$02
    .byte $82,$46,$23,$65,$23,$49,$54,$42,$60,$01,$13,$88,$0c,$22,$16,$01,$23,$e1,$05,$d3,$02,$09,$69,$13,$01,$12,$de,$0f,$d1,$08,$a6,$30,$5d,$5f,$24,$73,$ea,$e5,$06,$d4,$0b,$04,$dc,$09,$01,$e2
    .byte $33,$53,$52,$90,$e6,$10,$02,$05,$c6,$1d,$e9,$d4,$04,$d0,$2a,$89,$05,$7d
    .byte $41,$32,$46,$22,$40,$05,$d3,$30,$01,$13,$88,$0c,$22,$13,$e2,$16,$04,$d4
    .byte $43,$3a,$42,$52,$40,$01,$d4,$1a,$0c,$2d,$11,$e3,$12,$e4,$0f,$d1,$11,$1a,$d2,$08,$64,$04,$d4
    .byte $43,$52,$76,$23,$39,$31,$ea,$0c,$d1,$06,$19,$e3,$04,$ea,$66,$11,$3f,$04,$03,$49,$d4,$28,$34,$06,$e3,$08,$d3
    .byte $00

