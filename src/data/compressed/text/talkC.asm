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
    ; 138 bytes
    .byte $10,$75,$d2,$1b,$04,$99,$d7,$04,$06
    .byte $11,$20,$49
    .byte $33,$34,$73,$26,$01,$06,$be,$36,$65,$04,$62,$0d,$06,$de,$65,$10,$46
    .byte $32,$42,$52,$79,$e2,$d4,$11,$0a,$70,$03,$e3,$13,$e1,$1f,$63,$0d,$04,$e3,$02,$e5,$2c,$e2
    .byte $72,$44,$24,$43,$32,$72,$35,$33,$d5,$1b,$60,$28,$d3,$0a,$74,$0f,$e1,$06,$e3,$05,$d3,$2b,$88,$b4,$de,$0f,$db,$0e,$04,$01,$1a,$1e,$09,$d0,$0c,$d3,$27
    .byte $31,$41,$32,$60,$2f,$0b,$a3,$10,$0a,$07,$1f,$09
    .byte $73,$44,$14,$73,$35,$52,$15,$50,$d8,$ea,$0c,$33,$e5,$08,$e2,$15,$77,$08,$01,$02,$d1,$0e,$05,$d3,$dd,$3a,$02,$94,$d4,$16,$04,$79,$1e,$09,$1e,$d0,$04
    .byte $00

talkSodaSprings2:
    ; 137 bytes
    .byte $20,$15,$30,$27,$03,$dd,$d6,$64,$e8
    .byte $62,$23,$53,$22,$44,$33,$44,$49,$d9,$de,$d1,$3a,$02,$6f,$27,$12,$0a,$d5,$04,$85,$28,$56,$07,$01,$14,$28,$da,$d5,$3c,$d4
    .byte $41,$94,$44,$24,$60,$e2,$37,$10,$34,$06,$17,$ea,$e2,$e5,$02,$e8,$d7,$0d,$d3,$0a,$d5,$04,$d3,$0b,$03,$21
    .byte $62,$21,$55,$62,$13,$53,$50,$a6,$d8,$0f,$07,$d4,$76,$e3,$18,$b3,$14,$06,$04,$40,$a8,$35,$d3,$02,$01,$1a,$1e,$09
    .byte $72,$23,$71,$87,$52,$44,$56,$34,$09,$01,$16,$18,$3c,$d8,$89,$8d,$01,$02,$0e,$29,$4e,$2c,$de,$1c,$d8,$df,$e2,$0a,$29,$48,$2f,$0b,$01,$02,$1a,$36,$dd,$ea,$e3,$05,$b0,$28,$d3
    .byte $00

talkSodaSprings3:
    ; 134 bytes
    .byte $10,$58,$dc,$25,$06,$d7,$0b,$54,$39,$da
    .byte $b1,$45,$24,$45,$34,$72,$42,$73,$72,$42,$63,$39,$d8,$ea,$51,$d7,$08,$bf,$17,$c9,$3b,$01,$13,$01,$02,$08,$e1,$11,$05,$e8,$d2,$e4,$0a,$4e,$e2,$0a,$22,$4f,$0a,$3e,$07,$e3,$0b,$01,$b4,$03,$48,$23,$eb,$eb,$01,$13,$52,$22,$da,$04,$8d,$0c,$01,$06,$d7,$07,$7d,$e4,$32
    .byte $42,$33,$44,$42,$35,$e8,$03,$d2,$05,$e2,$81,$11,$05,$6f,$27,$e2,$09,$01,$10,$18,$25
    .byte $24,$33,$30,$05,$d3,$2f,$e8,$2b,$e3
    .byte $43,$64,$3a,$25,$34,$e2,$81,$04,$c5,$34,$d4,$05,$d3,$df,$19,$e5,$12,$d8,$09,$e2,$12,$e6,$07,$01,$01,$02,$12,$da
    .byte $00

talkFortHall1:
    ; 152 bytes
    .byte $10,$58,$dc,$25,$06,$d7,$0b,$54,$39,$da
    .byte $11,$40,$31,$0c
    .byte $11,$60,$d5,$57,$0b,$d3
    .byte $32,$42,$52,$40,$01,$12,$12,$2f,$02,$1a,$16,$0d,$e3
    .byte $52,$35,$3a,$42,$86,$25,$d8,$ea,$dc,$d1,$03,$dd,$56,$07,$d2,$2c,$2e,$07,$6e,$d0,$26,$01,$05,$34,$df,$5d,$04,$93,$06,$02,$e3,$0a,$d2,$19,$20
    .byte $51,$33,$26,$33,$55,$25,$05,$5a,$03,$eb,$eb,$e8,$03,$ea,$e5,$1f,$78,$01,$06,$dd,$4a,$02,$1d,$02,$0a,$d2,$19,$20
    .byte $33,$51,$42,$26,$2f,$d8,$1c,$d8,$d7,$08,$e1,$12,$2b,$df,$39,$dd,$39
    .byte $11,$52,$e6,$e1,$17,$d4,$4b
    .byte $21,$32,$36,$e8,$03,$07,$01,$11,$12,$e2,$4b
    .byte $43,$42,$42,$35,$60,$74,$0f,$d0,$20,$de,$09,$36,$e8,$03,$e1,$08,$1c,$07,$1f,$09
    .byte $00

talkFortHall2:
    ; 138 bytes
    .byte $10,$47,$d0,$35,$e3,$41,$d1,$14,$97
    .byte $32,$47,$85,$64,$d7,$08,$e1,$01,$02,$d4,$ea,$5e,$03,$dd,$22,$04,$3e,$d4,$16,$0d,$03,$dd,$6d,$02,$d4
    .byte $21,$65,$30,$0b,$03,$21,$e6,$13,$02,$0a,$de
    .byte $32,$36,$15,$24,$29,$01,$0d,$71,$e8,$d0,$0f,$39,$da,$15,$e6,$28,$d3
    .byte $33,$56,$34,$40,$01,$05,$da,$d7,$08,$e5,$0b,$d5,$07,$d5,$07,$01,$d0,$0c
    .byte $92,$33,$45,$22,$67,$26,$53,$33,$57,$3a,$29,$72,$ea,$dc,$e1,$08,$a9,$07,$42,$0a,$d1,$06,$27,$04,$d6,$d6,$28,$d3,$52,$d4,$0a,$d2,$03,$e2,$04,$dc,$25,$06,$05,$99,$0c,$01,$24,$38,$da,$3e,$08,$d3,$04,$a7,$07,$d2,$2c,$2e,$07,$6e,$d0
    .byte $00

talkFortHall3:
    ; 147 bytes
    .byte $20,$16,$80,$53,$d4,$0c,$3d,$e3,$18,$e5,$1b,$02
    .byte $33,$44,$21,$44,$d5,$07,$01,$d0,$0c,$12,$d0,$29,$e2,$9b,$07,$e3
    .byte $72,$34,$92,$65,$43,$44,$35,$74,$01,$1a,$3b,$06,$7b,$10,$1c,$06,$15,$dc,$08,$d3,$3d,$d6,$18,$20,$d7,$02,$08,$41,$74,$0f,$2f,$13,$03,$e1,$e3,$3c,$0e,$05,$34,$2c,$e2,$73,$0e
    .byte $21,$23,$20,$36,$d5,$07,$dc,$d4
    .byte $32,$43,$23,$55,$d8,$ea,$0c,$87,$e7,$3f,$01,$1a,$1e,$09,$db,$08,$86
    .byte $82,$84,$72,$43,$37,$36,$23,$25,$57,$2a,$05,$99,$ea,$e2,$e1,$08,$db,$05,$b8,$03,$e2,$0a,$e6,$36,$33,$0c,$01,$14,$4d,$01,$06,$05,$71,$04,$0b,$e2,$04,$09,$d4,$15,$01,$5d,$14,$db,$08,$e1,$0f,$e1,$08,$b5
    .byte $00

talkSnakeRiver1:
    ; 140 bytes
    .byte $20,$17,$40,$53,$e1,$05,$e3,$39,$26,$9a
    .byte $c1,$24,$54,$23,$7a,$44,$42,$62,$53,$23,$92,$35,$50,$17,$e2,$27,$e2,$57,$21,$01,$02,$d4,$04,$01,$06,$d7,$1d,$1b,$e8,$ad,$3b,$45,$28,$da,$ee,$ec,$e8,$03,$dc,$4b,$01,$3c,$d4,$05,$04,$44,$05,$0a,$df,$25,$de,$46,$03,$13,$01,$14,$19,$20,$04,$62,$15,$01,$06,$dd,$4a,$02,$1d,$02
    .byte $83,$25,$92,$39,$c3,$27,$72,$87,$15,$17,$ce,$04,$93,$05,$d6,$02,$03,$e2,$2e,$2b,$e3,$df,$02,$d5,$14,$59,$e8,$35,$d3,$02,$e2,$0a,$be,$ef,$ec,$29,$e3,$49,$d7,$4b,$d1,$05,$d3,$04,$5b,$0f,$e2,$09,$d2,$19,$20,$04,$d6,$26,$01,$03,$e3,$1e,$e4,$3b,$d4
    .byte $00

talkSnakeRiver2:
    ; 141 bytes
    .byte $10,$2a,$05,$58,$02,$db,$05,$d3,$02
    .byte $41,$45,$75,$54,$60,$d3,$3d,$dd,$01,$02,$45,$10,$31,$0b,$01,$5d,$06,$e3,$d4,$16,$db,$81,$1e,$07,$d6,$06
    .byte $21,$83,$80,$e3,$26,$0f,$04,$d6,$05,$85,$57,$01,$04,$d6
    .byte $22,$23,$55,$12,$01,$06,$dd,$4a,$02,$1d,$02
    .byte $53,$24,$52,$32,$42,$32,$e2,$37,$e4,$1c,$e6,$13,$02,$eb,$eb,$05,$43,$8f,$0d,$d3,$0a,$d6,$10,$0a
    .byte $41,$53,$45,$26,$66,$31,$ea,$e5,$1f,$78,$dc,$05,$ab,$25,$06,$15,$d3,$06,$02,$88,$24,$07,$d4,$07,$1f,$09
    .byte $63,$22,$42,$44,$54,$23,$80,$a6,$d1,$06,$e4,$41,$0a,$87,$0c,$e8,$03,$50,$13,$02,$da,$1f,$e2,$13,$01,$14,$19,$20,$04,$d6
    .byte $00

talkSnakeRiver3:
    ; 140 bytes
    .byte $10,$35,$d1,$a3,$db,$03,$d8,$d4
    .byte $24,$34,$45,$e2,$9d,$01,$13,$e6,$25,$54,$1d,$02
    .byte $22,$63,$50,$01,$13,$ea,$e2,$01,$06,$dd,$4a,$d4
    .byte $52,$41,$74,$72,$37,$60,$dc,$05,$e8,$30,$18,$c0,$ea,$82,$d4,$0b,$68,$2a,$df,$0e,$04,$d7,$02,$d5,$de,$2a,$04,$d6,$18,$df,$3b,$e2
    .byte $43,$36,$63,$33,$26,$d7,$02,$e6,$13,$02,$0f,$18,$e5,$1b,$d0,$0c,$01,$1a,$27,$0a,$07,$1f,$09
    .byte $31,$52,$83,$40,$31,$ea,$0c,$d1,$14,$19,$20,$04,$21,$02,$a6,$09
    .byte $32,$34,$55,$45,$05,$d3,$01,$0b,$1e,$d0,$04,$53,$e3,$02,$d5,$07,$e3,$64,$12,$d4
    .byte $33,$44,$23,$80,$22,$da,$14,$0d,$08,$e3,$01,$14,$19,$20,$04,$d6
    .byte $00

talkFortBoise1:
    ; 149 bytes
    .byte $10,$5a,$d9,$30,$de,$d1,$d7,$15,$0f,$08,$d3,$02
    .byte $11,$55,$3a,$02,$e8,$6e,$21,$e3
    .byte $41,$46,$14,$43,$55,$3a,$0b,$01,$03,$21,$d8,$d0,$1c,$24,$19,$dc,$01,$0e,$27,$ea,$e2,$0a,$25,$e2
    .byte $82,$24,$26,$46,$23,$44,$42,$3a,$60,$49,$d7,$08,$d3,$12,$87,$0c,$0e,$26,$01,$54,$08,$b5,$15,$01,$02,$d8,$1c,$d5,$0d,$dc,$db,$05,$d3,$15,$01,$1a,$d8,$0c,$2a,$10,$e3,$3a,$d0,$0c,$23
    .byte $31,$14,$56,$14,$d8,$26,$0c,$29,$25,$d3,$49,$e2,$1b,$d5,$53,$04,$d4
    .byte $62,$89,$23,$37,$42,$46,$45,$d7,$05,$43,$37,$7a,$37,$06,$e3,$08,$d3,$eb,$eb,$05,$44,$ea,$dc,$d2,$02,$22,$04,$d8,$ea,$0c,$d1,$02,$d8,$1c,$26,$01,$04,$d5,$1d,$23,$08,$6c
    .byte $00

talkFortBoise2:
    ; 151 bytes
    .byte $30,$16,$41,$50,$13,$18,$d3,$02,$26,$01,$f7,$dc,$63,$06
    .byte $51,$63,$33,$54,$44,$90,$e8,$03,$ea,$0c,$2b,$60,$10,$e8,$02,$e6,$1e,$09,$58,$02,$01,$11,$5c,$e4,$11,$03,$dd,$22,$04,$e2
    .byte $12,$60,$8c,$0f,$02
    .byte $13,$52,$db,$08,$51,$17
    .byte $42,$53,$54,$44,$70,$d2,$19,$20,$e8,$02,$d6,$28,$43,$58,$02,$26,$01,$df,$30,$da,$05,$34,$2c,$e2
    .byte $42,$37,$16,$24,$50,$d6,$10,$e8,$02,$e2,$1b,$d5,$30,$03,$2d,$d4,$15,$d6,$28,$b1,$63,$06
    .byte $83,$62,$66,$35,$24,$24,$53,$54,$46,$b3,$14,$06,$15,$e6,$1e,$09,$94,$17,$e3,$02,$01,$10,$18,$25,$eb,$eb,$db,$24,$e3,$52,$01,$11,$d5,$38,$86,$2f,$be,$09,$ea,$01,$d4,$0e,$d6,$28,$d3,$47,$e5,$39,$d4
    .byte $00

talkFortBoise3:
    ; 132 bytes
    .byte $10,$47,$d0,$35,$e3,$41,$d1,$14,$97
    .byte $31,$25,$45,$35,$13,$3a,$02,$9b,$07,$22,$db,$09,$d6,$01,$10,$18,$25
    .byte $53,$64,$46,$42,$38,$40,$65,$39,$06,$33,$e5,$45,$d4,$0b,$c1,$21,$02,$01,$05,$13,$01,$16,$e1,$3a,$d8,$03,$61,$07,$e3
    .byte $23,$42,$a0,$01,$12,$12,$03,$e3,$18,$69,$03,$e2
    .byte $33,$76,$92,$20,$01,$23,$ea,$e1,$10,$4a,$04,$d6,$47,$e5,$05,$e3,$1e,$d4,$15,$4b
    .byte $51,$21,$33,$62,$22,$50,$2e,$d8,$33,$d3,$01,$14,$d7,$05,$80,$0a,$8a,$17,$1e,$d0,$04
    .byte $32,$33,$48,$2c,$d8,$ea,$d3,$29,$ab,$07,$06,$3f,$2d,$d8,$06,$04,$04,$d3,$16,$0b,$d3,$0b,$80
    .byte $00

talkBlueMountains1:
    ; 149 bytes
    .byte $20,$15,$a0,$13,$3c,$0e,$58,$02,$db,$05,$d3,$02
    .byte $41,$58,$35,$24,$50,$e2,$04,$d2,$14,$19,$20,$04,$d6,$01,$06,$dd,$4a,$08,$77,$07,$e3,$64,$12,$d4
    .byte $32,$44,$49,$36,$17,$ea,$82,$d4,$0b,$74,$0f,$dc,$03,$dd,$22,$04,$e2,$05,$a0,$06,$02,$e3
    .byte $52,$46,$43,$23,$62,$50,$c2,$0f,$6a,$16,$02,$08,$1c,$d3,$27,$eb,$eb,$5b,$e7,$04,$1c,$06,$13,$e3,$34,$06
    .byte $11,$26,$2b,$e3,$18,$55,$e2
    .byte $22,$46,$24,$74,$0f,$d2,$db,$03,$43,$15,$c2,$0f
    .byte $51,$46,$62,$34,$58,$35,$dc,$05,$e8,$d2,$13,$59,$14,$a5,$da,$0e,$09,$01,$0e,$e4,$0f,$53,$e3,$02,$e2,$26,$dc,$dc,$04,$d6,$01,$02,$1d,$02
    .byte $22,$44,$34,$01,$0b,$5c,$0e,$05,$d3,$44,$0e
    .byte $00

talkBlueMountains2:
    ; 146 bytes
    .byte $10,$67,$dc,$0d,$6e,$06,$e3,$1a,$0d,$e3
    .byte $92,$28,$34,$23,$64,$45,$23,$a4,$23,$49,$e6,$24,$de,$0c,$3d,$0e,$01,$d4,$0e,$69,$15,$01,$0e,$06,$02,$77,$19,$cd,$07,$e3,$64,$12,$d4,$0a,$01,$24,$07,$d1,$3b,$d3,$04,$d6,$af,$0c,$15,$01,$45,$db,$e4,$11,$03,$dd,$22,$04,$e2
    .byte $33,$35,$48,$50,$01,$7a,$d8,$0c,$68,$02,$0e,$e1,$08,$56,$63,$0f,$d4,$16
    .byte $41,$74,$63,$64,$40,$4d,$55,$04,$d6,$64,$01,$2f,$d4,$1b,$e2,$05,$95,$37,$04,$93,$3d,$dd,$94,$3d
    .byte $22,$23,$44,$e6,$1f,$78,$d3,$3d,$dd,$e2,$53,$d4
    .byte $13,$47,$df,$de,$07,$05,$34,$2c,$e2
    .byte $32,$25,$25,$34,$2b,$d6,$18,$20,$07,$e6,$13,$02,$d5,$07,$d3,$27,$e2
    .byte $00

talkBlueMountains3:
    ; 145 bytes
    .byte $10,$5a,$d9,$30,$de,$d1,$d7,$15,$0f,$08,$d3,$02
    .byte $82,$46,$23,$65,$23,$49,$54,$42,$60,$01,$12,$91,$0c,$23,$15,$01,$1f,$e1,$05,$d3,$02,$09,$6a,$12,$01,$11,$de,$0f,$d1,$08,$a4,$2e,$63,$5b,$21,$72,$ea,$e5,$06,$d4,$0b,$04,$dc,$09,$01,$e2
    .byte $33,$53,$52,$90,$e6,$13,$02,$05,$c3,$18,$e9,$d4,$04,$d0,$29,$84,$05,$80
    .byte $41,$32,$46,$22,$40,$05,$d3,$2e,$01,$12,$91,$0c,$23,$12,$e2,$15,$04,$d4
    .byte $43,$3a,$42,$52,$40,$01,$1a,$d8,$0c,$2a,$10,$e3,$11,$e4,$0f,$d1,$10,$26,$d2,$08,$61,$04,$d4
    .byte $43,$52,$76,$23,$39,$31,$ea,$0c,$d1,$06,$17,$e3,$04,$ea,$65,$10,$46,$04,$03,$48,$1a,$d7,$37,$06,$e3,$08,$d3
    .byte $00

