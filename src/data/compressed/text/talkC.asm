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

talkFortBridger1:
    ; 144 bytes
    .byte $10,$47,$d2,$37,$6f,$41,$16,$84
    .byte $33,$29,$53,$86,$e8,$06,$d9,$05,$68,$ec,$e7,$11,$40,$0c,$01,$06,$e6,$59,$11,$e5,$16,$e6,$09,$49
    .byte $72,$36,$24,$45,$34,$24,$23,$40,$26,$e5,$0c,$05,$1e,$23,$01,$10,$d7,$07,$77,$07,$01,$01,$11,$2d,$d6,$14,$09,$e0,$dc,$09,$66,$01,$02,$d6
    .byte $23,$33,$a6,$04,$d5,$01,$d6,$05,$e5,$19,$66,$05,$e4,$64,$4f,$06
    .byte $31,$63,$32,$30,$d7,$2c,$d5,$ec,$e4,$26,$7a,$14,$09,$0a,$e5
    .byte $22,$44,$33,$b6,$24,$dd,$06,$8b,$2f,$d7,$07
    .byte $63,$47,$43,$73,$35,$24,$34,$e4,$35,$27,$31,$ad,$ec,$4a,$d6,$0b,$01,$16,$53,$01,$06,$18,$d7,$05,$e3,$c4,$32,$e4,$39,$2a,$ec,$62,$11,$01,$0f
    .byte $00

talkFortBridger2:
    ; 150 bytes
    .byte $20,$1d,$50,$23,$3c,$0d,$ed,$dd,$2c,$dc,$03,$d8,$e8,$35,$04
    .byte $62,$35,$72,$17,$54,$24,$70,$08,$16,$d9,$22,$a9,$15,$6c,$0d,$03,$44,$e8,$e0,$0b,$0c,$d4,$50,$c0,$0a,$e4,$09,$49,$07,$5f,$0e,$29,$da,$d6
    .byte $42,$27,$42,$74,$c4,$3f,$d9,$3a,$d3,$04,$d5,$2e,$0d,$18,$4d,$e1,$96,$3d,$df,$0a,$e3,$03,$d5,$1a,$0c,$d5,$0c,$d4,$02,$e0,$32
    .byte $42,$31,$65,$42,$48,$26,$e8,$14,$19,$e7,$1f,$28,$08,$d6,$1b,$01,$3f,$d7,$17,$16,$d9,$22,$4e,$0c
    .byte $11,$36,$01,$d6,$1f,$d5,$06,$e5
    .byte $11,$50,$d4,$28,$41
    .byte $12,$26,$10,$1f,$36,$0c
    .byte $52,$14,$52,$13,$62,$56,$39,$0a,$ab,$d6,$ec,$0b,$d3,$0a,$de,$04,$d3,$27,$07,$45,$02,$0a,$24,$07,$21,$08
    .byte $00

talkFortBridger3:
    ; 124 bytes
    .byte $10,$16,$23,$19,$d5,$02
    .byte $42,$44,$35,$23,$70,$01,$10,$d7,$07,$e5,$12,$e4,$2b,$22,$e5,$4b,$db,$2d,$c8,$3d,$d8,$02
    .byte $a2,$33,$18,$36,$23,$24,$a4,$35,$52,$63,$b0,$db,$2d,$12,$e4,$29,$05,$df,$1d,$03,$de,$04,$d3,$27,$07,$7e,$1a,$ac,$03,$01,$10,$59,$d2,$32,$5e,$da,$01,$42,$89,$04,$4a,$c9,$0b,$13,$07,$d6,$09,$e4,$43,$30,$ea,$01,$d6,$47,$02,$dd,$04,$d5,$02,$e4
    .byte $31,$41,$35,$26,$71,$06,$48,$90,$e5,$19,$6e,$03,$d9,$07,$e4,$06
    .byte $21,$33,$37,$db,$2d,$04,$63,$10,$e1,$0e,$c3,$02
    .byte $12,$70,$e7,$44,$9b,$d6,$eb
    .byte $00

talkGreenRiver1:
    ; 136 bytes
    .byte $20,$15,$30,$2f,$05,$df,$d8,$98,$ea
    .byte $42,$26,$63,$64,$2c,$3f,$d7,$29,$22,$ea,$2e,$ca,$ec,$e5,$2b,$ea,$0c,$05,$1e,$d7,$2c,$d5,$03,$03,$d5,$1a,$0c,$d5,$0c,$6b
    .byte $52,$24,$46,$45,$75,$47,$2a,$34,$e7,$41,$d6,$0c,$0a,$e5,$03,$d8,$e7,$02,$ea,$5e,$d2,$0b,$19,$61,$08,$1c,$03,$d4,$27,$07,$5f,$0e,$29,$da,$d6
    .byte $42,$72,$43,$62,$40,$d3,$16,$d2,$3a,$d6,$18,$01,$23,$05,$ab,$0a,$dd,$01,$10,$e1,$e0,$07
    .byte $31,$26,$38,$50,$3f,$e4,$10,$e5,$02,$34,$5e,$05,$df,$1d,$03,$d7,$36,$02
    .byte $42,$25,$74,$31,$50,$82,$2a,$ec,$e3,$06,$09,$c2,$0d,$d9,$02,$27,$07,$d2,$25,$22,$d6
    .byte $00

talkGreenRiver2:
    ; 143 bytes
    .byte $20,$18,$60,$d2,$42,$e0,$42,$08,$da,$03,$2e,$04
    .byte $41,$46,$57,$67,$40,$25,$0c,$12,$d8,$08,$57,$3c,$13,$13,$0e,$e5,$0d,$d4,$35,$03,$d8,$01,$e3,$05,$1e,$d9,$02,$d6
    .byte $22,$23,$34,$e8,$0d,$3d,$26,$72,$03,$d5
    .byte $a2,$24,$52,$42,$54,$34,$43,$93,$44,$53,$60,$2a,$36,$0c,$d7,$05,$75,$14,$d8,$2c,$d5,$09,$e5,$19,$d5,$21,$29,$d6,$04,$5b,$10,$d9,$1b,$01,$01,$11,$19,$e7,$1f,$02,$e4,$04,$63,$1f,$e1,$01,$0f,$d4,$15,$1c,$01,$02,$17,$02,$e4
    .byte $72,$35,$33,$45,$33,$36,$43,$70,$26,$e8,$01,$02,$0a,$50,$09,$35,$04,$ea,$25,$14,$0f,$0c,$04,$d5,$09,$31,$14,$5f,$1f,$04,$5b,$07,$d8,$19,$eb,$03,$d8
    .byte $00

talkGreenRiver3:
    ; 139 bytes
    .byte $10,$35,$d3,$90,$dd,$05,$da,$d6
    .byte $54,$47,$25,$24,$35,$50,$d7,$17,$0d,$e0,$0b,$0e,$e4,$09,$d7,$02,$3e,$3a,$47,$02,$01,$21,$50,$0c,$e3,$17,$02
    .byte $43,$5b,$41,$77,$69,$01,$51,$27,$02,$3e,$de,$0c,$ec,$0b,$de,$40,$0a,$d9,$37,$4e,$0d,$71,$0b,$0e,$74,$27,$07,$41,$e3,$0a,$dc,$8e,$13
    .byte $82,$54,$45,$52,$41,$52,$43,$53,$70,$2a,$ec,$0b,$56,$1a,$d5,$38,$df,$e3,$17,$02,$37,$e5,$22,$e8,$27,$03,$7c,$30,$4c,$d6,$09,$d7,$07,$d5,$05,$e3,$12,$d8,$08,$04,$d5,$04,$2d,$28,$e4
    .byte $31,$46,$52,$44,$25,$23,$dd,$14,$5f,$0f,$08,$20,$2a,$34,$e7,$1f,$27,$e5
    .byte $13,$54,$2a,$ec,$0b,$56,$1a
    .byte $00

talkSodaSprings1:
    ; 137 bytes
    .byte $10,$75,$d4,$1f,$03,$7c,$d9,$03,$06
    .byte $11,$20,$3f
    .byte $33,$34,$73,$26,$01,$06,$ae,$44,$64,$03,$58,$0e,$06,$e0,$64,$11,$4d
    .byte $32,$42,$52,$79,$bf,$0f,$09,$8b,$05,$1d,$6f,$21,$5d,$0e,$03,$e5,$02,$e7,$28,$e4
    .byte $72,$44,$24,$43,$32,$72,$35,$33,$d7,$1f,$69,$2c,$d5,$09,$76,$13,$e3,$06,$e5,$04,$d5,$26,$67,$a2,$e0,$13,$dd,$0d,$03,$01,$d6,$12,$d8,$08,$d2,$0b,$d5,$2f
    .byte $31,$41,$32,$60,$25,$0c,$90,$11,$09,$07,$21,$08
    .byte $73,$44,$14,$73,$35,$52,$15,$50,$da,$ec,$0b,$34,$e7,$0a,$e4,$18,$7a,$0a,$01,$02,$d3,$0d,$04,$ca,$36,$02,$80,$d6,$1a,$03,$d2,$12,$d8,$08,$d2,$3b,$03
    .byte $00

talkSodaSprings2:
    ; 137 bytes
    .byte $20,$15,$30,$2f,$05,$df,$d8,$98,$ea
    .byte $62,$23,$53,$22,$44,$33,$44,$3f,$c5,$d3,$36,$02,$9d,$2f,$10,$09,$d7,$03,$8f,$2c,$5b,$07,$01,$16,$2c,$c1,$3c,$d6
    .byte $41,$94,$44,$24,$60,$e4,$35,$11,$2d,$06,$14,$ec,$e4,$e7,$02,$c7,$0e,$d5,$09,$d7,$03,$d5,$0c,$05,$1e
    .byte $62,$21,$55,$62,$13,$53,$50,$82,$10,$e5,$07,$d6,$6d,$e5,$19,$a1,$16,$06,$03,$48,$e0,$e9,$37,$d5,$02,$01,$d6,$12,$d8,$08
    .byte $72,$23,$71,$87,$52,$44,$56,$34,$08,$01,$1a,$19,$3c,$da,$78,$3b,$01,$02,$0d,$2b,$49,$28,$e0,$24,$da,$e1,$e4,$09,$2b,$5c,$25,$0c,$01,$02,$d6,$12,$7f,$ec,$e5,$04,$ea,$e8,$2c,$d5
    .byte $00

talkSodaSprings3:
    ; 133 bytes
    .byte $10,$58,$de,$22,$06,$d9,$0c,$4e,$da,$32
    .byte $b1,$45,$24,$45,$34,$72,$42,$73,$72,$42,$63,$39,$da,$ec,$70,$d9,$0a,$af,$14,$b7,$3d,$01,$23,$01,$02,$0a,$e3,$0f,$04,$cc,$e6,$09,$49,$e4,$09,$1d,$56,$09,$42,$07,$e5,$0c,$01,$a2,$05,$5c,$20,$ed,$ed,$01,$23,$4b,$1d,$dc,$03,$3b,$0b,$01,$06,$d9,$07,$7b,$e6,$33
    .byte $42,$33,$44,$42,$35,$ea,$05,$d4,$04,$e4,$88,$0f,$04,$9d,$2f,$e4,$08,$01,$11,$19,$22
    .byte $24,$33,$30,$04,$d5,$25,$ea,$26,$e5
    .byte $43,$64,$3a,$25,$34,$e4,$88,$03,$b3,$2d,$d6,$04,$d5,$e1,$15,$e7,$10,$da,$08,$e4,$10,$e8,$07,$01,$01,$02,$10,$dc
    .byte $00

talkFortHall1:
    ; 151 bytes
    .byte $10,$58,$de,$22,$06,$d9,$0c,$4e,$da,$32
    .byte $11,$40,$2a,$0b
    .byte $11,$60,$d7,$60,$0c,$d5
    .byte $32,$42,$52,$40,$01,$10,$10,$25,$02,$45,$1a,$0e,$e5
    .byte $52,$35,$3a,$42,$86,$25,$da,$ec,$de,$d3,$05,$df,$5b,$07,$d4,$28,$39,$07,$6a,$d2,$1b,$01,$04,$2d,$e1,$51,$03,$81,$06,$02,$e5,$09,$d4,$15,$1c
    .byte $51,$33,$26,$33,$55,$25,$04,$79,$05,$ed,$ed,$ea,$05,$ec,$e7,$21,$85,$01,$06,$df,$40,$02,$17,$02,$09,$d4,$15,$1c
    .byte $33,$51,$42,$26,$25,$da,$24,$bc,$0a,$e3,$10,$26,$e1,$4f,$df,$4f
    .byte $11,$52,$e8,$e3,$14,$d6,$3a
    .byte $21,$32,$36,$ea,$05,$07,$01,$0f,$10,$e4,$3a
    .byte $43,$42,$42,$35,$60,$76,$13,$d2,$1c,$e0,$08,$44,$ea,$05,$e3,$0a,$24,$07,$21,$08
    .byte $00

talkFortHall2:
    ; 136 bytes
    .byte $10,$47,$d2,$37,$6f,$41,$16,$84
    .byte $32,$47,$85,$64,$d9,$0a,$e3,$01,$02,$d6,$ec,$5e,$05,$df,$1d,$03,$42,$d6,$1a,$0e,$05,$df,$63,$02,$d6
    .byte $21,$65,$30,$0c,$05,$1e,$12,$e5,$02,$09,$e0
    .byte $32,$36,$15,$24,$2b,$01,$0e,$62,$ea,$d2,$13,$da,$32,$18,$e8,$2c,$d5
    .byte $33,$56,$34,$40,$01,$04,$cd,$0a,$e7,$0c,$d7,$07,$d7,$07,$01,$d2,$0b
    .byte $92,$33,$45,$22,$67,$26,$53,$33,$57,$3a,$2b,$61,$ec,$ce,$0a,$dd,$e4,$07,$3e,$09,$d3,$06,$2f,$03,$d8,$d8,$2c,$d5,$4b,$d6,$09,$d4,$05,$e4,$03,$de,$22,$06,$04,$7c,$0b,$01,$27,$31,$dc,$42,$0a,$d5,$03,$cb,$07,$d4,$28,$39,$07,$6a,$d2
    .byte $00

talkFortHall3:
    ; 147 bytes
    .byte $20,$16,$80,$52,$d6,$0b,$38,$e5,$19,$e7,$1f,$02
    .byte $33,$44,$21,$44,$d7,$07,$01,$d2,$0b,$10,$d2,$2b,$e4,$7d,$07,$e5
    .byte $72,$34,$92,$65,$43,$44,$35,$74,$01,$d6,$1b,$d5,$06,$6f,$11,$24,$06,$18,$de,$0a,$d5,$38,$d8,$19,$1c,$d9,$02,$0a,$50,$76,$13,$25,$23,$05,$bd,$3c,$0d,$04,$2d,$28,$7f,$d6,$0d
    .byte $21,$23,$20,$44,$d7,$07,$de,$d6
    .byte $32,$43,$23,$55,$da,$ec,$0b,$91,$e9,$43,$01,$d6,$12,$d8,$08,$dd,$0a,$ad
    .byte $82,$84,$72,$43,$37,$36,$23,$25,$57,$29,$04,$7c,$ec,$cf,$0a,$dd,$04,$a6,$05,$e4,$09,$12,$e4,$34,$0b,$01,$16,$53,$01,$06,$04,$62,$03,$0c,$e4,$03,$08,$d6,$18,$01,$51,$16,$dd,$0a,$e3,$13,$e3,$0a,$a3
    .byte $00

