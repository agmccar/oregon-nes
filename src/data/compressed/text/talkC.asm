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
; $ea - $fe: Literal special chars: ["'", '-', '"', ';', ':', '.', ',', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '…', '(', ')', '%']
; $ff: Unused

talkFortBridger1:
    ; 145 bytes
    .byte $10,$47,$d0,$3d,$e3,$3e,$d1,$15,$91
    .byte $33,$29,$53,$86,$e6,$06,$d7,$03,$63,$ea,$e5,$11,$49,$0b,$01,$06,$e4,$59,$11,$e3,$15,$e4,$0a,$51
    .byte $72,$36,$24,$45,$34,$24,$23,$40,$34,$e3,$0b,$03,$20,$14,$01,$0f,$d5,$07,$68,$07,$01,$01,$11,$32,$d4,$16,$0a,$de,$da,$0a,$71,$01,$02,$d4
    .byte $23,$33,$a6,$05,$d3,$01,$d4,$03,$e3,$1a,$71,$03,$e2,$61,$38,$06
    .byte $31,$63,$32,$30,$d5,$29,$d3,$ea,$e2,$34,$81,$16,$0a,$08,$e3
    .byte $22,$44,$33,$aa,$23,$db,$06,$70,$2d,$d5,$07
    .byte $63,$47,$43,$73,$35,$24,$34,$e2,$36,$22,$37,$8d,$ea,$3f,$d4,$0c,$01,$15,$47,$01,$06,$13,$d5,$03,$e1,$d1,$3a,$8d,$2c,$33,$ea,$6b,$11,$01,$10
    .byte $00

talkFortBridger2:
    ; 150 bytes
    .byte $20,$1d,$50,$14,$3b,$0e,$eb,$db,$29,$da,$04,$d6,$e6,$36,$05
    .byte $62,$35,$72,$17,$54,$24,$70,$09,$15,$d7,$27,$9b,$17,$88,$0e,$04,$2f,$e6,$de,$0c,$0b,$d2,$3e,$cd,$08,$e2,$0a,$51,$07,$62,$0d,$24,$d8,$d4
    .byte $42,$27,$42,$74,$c4,$45,$d7,$4b,$d1,$05,$d3,$42,$0e,$13,$46,$df,$8f,$39,$dd,$08,$e1,$04,$d3,$19,$0b,$d3,$0b,$d2,$02,$de,$50
    .byte $42,$31,$65,$42,$48,$dd,$28,$16,$1a,$e5,$1f,$2b,$09,$18,$d8,$01,$45,$d5,$1b,$15,$d7,$27,$56,$0b
    .byte $11,$36,$01,$d4,$1f,$d3,$06,$e3
    .byte $11,$50,$d2,$2b,$4a
    .byte $12,$26,$0f,$1f,$3c,$0b
    .byte $52,$14,$52,$13,$62,$56,$2c,$08,$9a,$d4,$ea,$0c,$d1,$08,$dc,$05,$d1,$22,$07,$18,$02,$08,$23,$07,$1d,$09
    .byte $00

talkFortBridger3:
    ; 125 bytes
    .byte $10,$16,$14,$1a,$d3,$02
    .byte $42,$44,$35,$23,$70,$01,$0f,$d5,$07,$68,$2f,$2a,$27,$e3,$4e,$d9,$32,$d1,$e1,$39,$d6,$02
    .byte $a2,$33,$18,$36,$23,$24,$a4,$35,$52,$63,$b0,$d9,$32,$e6,$2f,$24,$03,$dd,$26,$04,$dc,$05,$d1,$22,$07,$72,$19,$b6,$04,$01,$0f,$59,$3a,$da,$6a,$d8,$01,$40,$94,$05,$3f,$dc,$d0,$0c,$12,$07,$d4,$0a,$e2,$41,$2e,$e8,$01,$d4,$4c,$02,$db,$05,$d3,$02,$e2
    .byte $31,$41,$35,$26,$60,$06,$48,$9d,$e3,$1a,$76,$04,$d7,$07,$e2,$06
    .byte $21,$33,$37,$d9,$32,$05,$66,$0f,$df,$0d,$b5,$02
    .byte $12,$70,$e5,$2f,$93,$d4,$e9
    .byte $00

talkGreenRiver1:
    ; 140 bytes
    .byte $20,$15,$30,$2d,$03,$dd,$d6,$5b,$e8
    .byte $42,$26,$63,$64,$2c,$45,$d5,$24,$27,$89,$39,$dd,$ea,$e3,$2a,$e8,$0b,$03,$20,$d5,$29,$d3,$04,$04,$d3,$19,$0b,$d3,$0b,$77
    .byte $52,$24,$46,$45,$75,$47,$33,$35,$e5,$4a,$d4,$0b,$08,$e3,$04,$d6,$e5,$02,$e8,$6a,$d0,$0c,$e1,$14,$d8,$09,$1e,$04,$d2,$22,$07,$62,$0d,$24,$d8,$d4
    .byte $42,$72,$43,$62,$40,$d1,$15,$d0,$4b,$d4,$13,$01,$14,$03,$9a,$08,$db,$01,$0f,$df,$de,$07
    .byte $31,$26,$38,$50,$45,$e2,$0f,$e3,$02,$d7,$2f,$dc,$03,$dd,$26,$04,$d5,$3c,$02
    .byte $42,$25,$74,$31,$50,$e2,$28,$d4,$ea,$e1,$06,$0a,$df,$df,$0e,$d7,$02,$22,$07,$d0,$30,$27,$d4
    .byte $00

talkGreenRiver2:
    ; 142 bytes
    .byte $20,$18,$60,$2f,$8f,$40,$09,$d8,$04,$42,$05
    .byte $41,$46,$57,$67,$40,$30,$0b,$e6,$1c,$09,$5d,$3b,$12,$12,$0d,$e3,$0e,$d2,$36,$04,$d6,$01,$e1,$03,$20,$d7,$02,$d4
    .byte $22,$23,$34,$e6,$0e,$39,$34,$6d,$04,$d3
    .byte $a2,$24,$52,$42,$54,$34,$43,$93,$44,$53,$60,$33,$3c,$0b,$d5,$03,$7a,$16,$d6,$29,$d3,$0a,$e3,$1a,$d3,$1d,$24,$d4,$05,$54,$0f,$d7,$25,$01,$01,$11,$1a,$e5,$1f,$02,$e2,$05,$66,$1f,$df,$01,$10,$d2,$17,$1e,$01,$02,$1b,$02,$e2
    .byte $72,$35,$33,$45,$33,$36,$43,$70,$dd,$28,$01,$02,$08,$3e,$0a,$36,$05,$e8,$30,$16,$10,$0b,$05,$d3,$0a,$37,$16,$62,$1f,$05,$54,$07,$d6,$1a,$e9,$04,$d6
    .byte $00

talkGreenRiver3:
    ; 138 bytes
    .byte $10,$35,$d1,$9d,$db,$03,$d8,$d4
    .byte $54,$47,$25,$24,$35,$50,$d5,$1b,$0e,$de,$0c,$0d,$e2,$0a,$d5,$02,$43,$4b,$4c,$02,$01,$1d,$3e,$0b,$e1,$1b,$02
    .byte $43,$5b,$41,$77,$69,$01,$5a,$22,$02,$43,$dc,$0b,$ea,$0c,$dc,$49,$08,$d7,$3d,$56,$0e,$60,$0c,$0d,$79,$22,$07,$4a,$e1,$08,$da,$9c,$12
    .byte $82,$54,$45,$52,$41,$52,$43,$53,$70,$33,$ea,$0c,$4f,$19,$d3,$28,$dd,$e1,$1b,$02,$3d,$e3,$27,$e6,$22,$04,$84,$2e,$3a,$d4,$0a,$d5,$07,$d3,$03,$52,$1c,$09,$05,$d3,$05,$32,$2b,$e2
    .byte $31,$46,$52,$44,$30,$14,$db,$16,$62,$10,$09,$21,$33,$35,$e5,$1f,$22,$e3
    .byte $13,$54,$33,$ea,$0c,$4f,$19
    .byte $00

talkSodaSprings1:
    ; 137 bytes
    .byte $10,$75,$d2,$1f,$04,$84,$d7,$04,$06
    .byte $11,$20,$45
    .byte $33,$34,$73,$26,$01,$06,$b8,$2f,$61,$04,$5e,$0d,$06,$de,$61,$11,$46
    .byte $32,$42,$52,$79,$cc,$10,$0a,$70,$03,$e3,$14,$e1,$1d,$5f,$0d,$04,$e3,$02,$e5,$2b,$e2
    .byte $72,$44,$24,$43,$32,$72,$35,$33,$d5,$1f,$64,$29,$d3,$0a,$74,$12,$e1,$06,$e3,$05,$d3,$34,$7e,$ad,$de,$12,$db,$0e,$04,$01,$18,$1c,$09,$d0,$0c,$d3,$2d
    .byte $31,$41,$32,$60,$30,$0b,$9d,$11,$0a,$07,$1d,$09
    .byte $73,$44,$14,$73,$35,$52,$15,$50,$d8,$ea,$0c,$35,$e5,$08,$e2,$13,$81,$08,$01,$02,$d1,$0e,$05,$d3,$dd,$3c,$02,$9e,$d4,$19,$04,$6f,$1c,$09,$1c,$d0,$04
    .byte $00

talkSodaSprings2:
    ; 136 bytes
    .byte $20,$15,$30,$2d,$03,$dd,$d6,$5b,$e8
    .byte $62,$23,$53,$22,$44,$33,$44,$45,$d9,$b9,$3c,$02,$89,$2d,$0f,$0a,$d5,$04,$7c,$29,$54,$07,$01,$15,$29,$cf,$3b,$d4
    .byte $41,$94,$44,$24,$60,$e2,$36,$11,$32,$06,$16,$ea,$e2,$e5,$02,$e8,$d7,$0d,$d3,$0a,$d5,$04,$d3,$0b,$03,$20
    .byte $62,$21,$55,$62,$13,$53,$50,$e2,$de,$0f,$e3,$07,$d4,$75,$e3,$1a,$ac,$15,$06,$04,$48,$ba,$3d,$d3,$02,$01,$18,$1c,$09
    .byte $72,$23,$71,$87,$52,$44,$56,$34,$09,$01,$19,$1a,$3b,$d8,$7f,$87,$01,$02,$0e,$2a,$51,$2b,$de,$23,$d8,$df,$e2,$0a,$2a,$44,$30,$0b,$01,$02,$18,$2f,$dd,$ea,$e3,$05,$a7,$29,$d3
    .byte $00

talkSodaSprings3:
    ; 134 bytes
    .byte $10,$58,$dc,$27,$06,$d7,$0b,$56,$38,$da
    .byte $b1,$45,$24,$45,$34,$72,$42,$73,$72,$42,$63,$39,$d8,$ea,$53,$d7,$08,$bb,$16,$c4,$39,$01,$14,$01,$02,$08,$e1,$10,$05,$e8,$d2,$e4,$0a,$51,$e2,$0a,$26,$4f,$0a,$40,$07,$e3,$0b,$01,$ad,$03,$44,$21,$eb,$eb,$01,$14,$4e,$26,$da,$04,$87,$0c,$01,$06,$d7,$07,$82,$e4,$31
    .byte $42,$33,$44,$42,$35,$e8,$03,$d2,$05,$e2,$78,$10,$05,$89,$2d,$e2,$09,$01,$11,$1a,$27
    .byte $24,$33,$30,$05,$d3,$30,$e8,$34,$e3
    .byte $43,$64,$3a,$25,$34,$e2,$78,$04,$c0,$32,$d4,$05,$d3,$df,$17,$e5,$0f,$d8,$09,$e2,$0f,$e6,$07,$01,$01,$02,$0f,$da
    .byte $00

talkFortHall1:
    ; 152 bytes
    .byte $10,$58,$dc,$27,$06,$d7,$0b,$56,$38,$da
    .byte $11,$40,$33,$0c
    .byte $11,$60,$d5,$58,$0b,$d3
    .byte $32,$42,$52,$40,$01,$0f,$0f,$30,$02,$18,$19,$0d,$e3
    .byte $52,$35,$3a,$42,$86,$25,$d8,$ea,$dc,$d1,$03,$dd,$54,$07,$d2,$2b,$2c,$07,$6e,$d0,$25,$01,$05,$32,$df,$5a,$04,$8c,$06,$02,$e3,$0a,$d2,$17,$1e
    .byte $51,$33,$26,$33,$55,$25,$05,$7d,$03,$eb,$eb,$e8,$03,$ea,$e5,$1d,$a5,$01,$06,$dd,$49,$02,$1b,$02,$0a,$d2,$17,$1e
    .byte $33,$51,$42,$26,$30,$d8,$23,$d8,$d7,$08,$e1,$0f,$34,$df,$38,$dd,$38
    .byte $11,$52,$e6,$e1,$16,$d4,$4b
    .byte $21,$32,$36,$e8,$03,$07,$01,$10,$0f,$e2,$4b
    .byte $43,$42,$42,$35,$60,$74,$12,$d0,$1e,$de,$09,$2f,$e8,$03,$e1,$08,$23,$07,$1d,$09
    .byte $00

talkFortHall2:
    ; 139 bytes
    .byte $10,$47,$d0,$3d,$e3,$3e,$d1,$15,$91
    .byte $32,$47,$85,$64,$d7,$08,$e1,$01,$02,$d4,$ea,$6a,$03,$dd,$26,$04,$40,$d4,$19,$0d,$03,$dd,$66,$02,$d4
    .byte $21,$65,$30,$0b,$03,$20,$e6,$14,$02,$0a,$de
    .byte $32,$36,$15,$24,$2a,$01,$0d,$6b,$e8,$d0,$12,$38,$da,$13,$e6,$29,$d3
    .byte $33,$56,$34,$40,$01,$05,$da,$d7,$08,$e5,$0b,$d5,$07,$d5,$07,$01,$d0,$0c
    .byte $92,$33,$45,$22,$67,$26,$53,$33,$57,$3a,$2a,$6c,$ea,$dc,$e1,$08,$db,$e2,$07,$43,$0a,$d1,$06,$2d,$04,$d6,$d6,$29,$d3,$4e,$d4,$0a,$d2,$03,$e2,$04,$dc,$27,$06,$05,$84,$0c,$01,$22,$37,$da,$40,$08,$d3,$04,$b7,$07,$d2,$2b,$2c,$07,$6e,$d0
    .byte $00

talkFortHall3:
    ; 146 bytes
    .byte $20,$16,$80,$55,$d4,$0c,$28,$e3,$1a,$e5,$1f,$02
    .byte $33,$44,$21,$44,$d5,$07,$01,$d0,$0c,$0f,$d0,$2a,$e2,$92,$07,$e3
    .byte $72,$34,$92,$65,$43,$44,$35,$74,$01,$18,$39,$06,$80,$11,$23,$06,$13,$dc,$08,$d3,$28,$d6,$1a,$1e,$d7,$02,$08,$3e,$74,$12,$30,$14,$03,$cb,$3b,$0e,$05,$32,$2b,$73,$d4,$0e
    .byte $21,$23,$20,$2f,$d5,$07,$dc,$d4
    .byte $32,$43,$23,$55,$d8,$ea,$0c,$8e,$e7,$41,$01,$18,$1c,$09,$db,$08,$8d
    .byte $82,$84,$72,$43,$37,$36,$23,$25,$57,$24,$05,$84,$ea,$e2,$e1,$08,$db,$05,$b2,$03,$e2,$0a,$e6,$2f,$35,$0c,$01,$15,$47,$01,$06,$05,$6b,$04,$0b,$e2,$04,$09,$d4,$13,$01,$5a,$15,$db,$08,$e1,$12,$e1,$08,$ae
    .byte $00

