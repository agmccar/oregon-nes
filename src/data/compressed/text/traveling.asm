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

travelingChangePaceText:
    ; 38 bytes
    .byte $42,$34,$25,$36,$36,$01,$16,$36,$08,$e3,$2e,$d8,$1d,$e8,$03,$e3,$1a,$e5,$1b,$d2,$05,$1d,$05,$68
    .byte $25,$47,$40,$e8,$03,$e1,$1d,$de,$39,$06,$0d,$d4,$ee
    .byte $00

travelingChangePaceHelpOption:
    ; 27 bytes
    .byte $45,$43,$45,$95,$40,$d5,$04,$d3,$03,$e3,$2e,$13,$01,$06,$0e,$2d,$d5,$02,$0b,$e3,$df,$36,$06,$dc,$d4,$05
    .byte $00

travelingChangePaceHelpSteady:
    ; 59 bytes
    .byte $51,$61,$36,$51,$51,$30,$0f,$08,$69,$eb,$e8,$03,$e3,$1a,$e5,$1b,$3f,$03,$e3,$f9,$d7,$03,$6b,$47,$26
    .byte $22,$68,$50,$22,$da,$04,$a6,$40,$7d,$0b,$7a,$06,$31
    .byte $42,$34,$43,$23,$35,$e8,$03,$22,$da,$14,$0d,$0b,$76,$0a,$d6,$10,$0a,$76,$3c,$0e
    .byte $00

travelingChangePaceHelpStrenuous:
    ; 116 bytes
    .byte $51,$91,$36,$52,$51,$30,$0f,$e1,$0b,$e4,$03,$e2,$eb,$e8,$03,$e3,$1a,$e5,$1b,$3f,$03,$e3,$f2,$f3,$d7,$03,$6b,$47,$26
    .byte $52,$84,$57,$38,$76,$60,$0f,$0d,$e3,$04,$d6,$72,$0f,$53,$e3,$02,$e2,$34,$e1,$12,$d4,$05,$42,$0a,$b9,$04,$d6,$3e,$07,$5f,$e8,$d1,$25,$07,$06,$34,$e2,$10
    .byte $42,$34,$24,$44,$90,$e8,$03,$e2,$0a,$96,$07,$06,$e3,$09,$91,$2e,$0b,$dd,$14,$06,$e2,$0d,$e8
    .byte $42,$36,$43,$74,$50,$e8,$03,$d5,$04,$12,$d7,$08,$1d,$d3,$26,$9a,$1b,$04,$d6,$e5,$02,$e8,$e3,$3c,$0e
    .byte $00

travelingChangePaceHelpGrueling:
    ; 147 bytes
    .byte $51,$81,$36,$52,$51,$30,$d6,$e1,$e4,$1b,$04,$d6,$eb,$e8,$03,$e3,$1a,$e5,$1b,$3f,$03,$e3,$f2,$f7,$d7,$03,$6b,$47,$26
    .byte $42,$86,$73,$a5,$40,$0f,$0d,$e3,$04,$d6,$d1,$25,$07,$06,$34,$e1,$12,$d4,$05,$95,$09,$e3,$04,$e4,$04,$d6,$34,$e3,$27,$d3,$0d,$da
    .byte $32,$36,$54,$24,$e8,$03,$2b,$9d,$0f,$dd,$3a,$02,$e2,$0a,$96,$07,$06,$e3
    .byte $42,$32,$33,$65,$25,$e8,$03,$d3,$09,$de,$60,$10,$0b,$03,$21,$94,$d4,$16,$13,$6d,$21,$e3
    .byte $41,$36,$43,$7a,$90,$e8,$03,$d5,$04,$12,$d7,$08,$1d,$d3,$26,$9a,$1b,$04,$d6,$3f,$e2,$38,$a3,$1b,$e8,$74,$32,$e4,$0f,$0e
    .byte $22,$34,$67,$05,$69,$03,$a1,$08,$db,$01,$e2,$e4,$4d,$02,$e2
    .byte $00

travelingChangeRationsText:
    ; 54 bytes
    .byte $72,$36,$24,$36,$24,$53,$43,$36,$01,$08,$dc,$03,$dd,$0a,$4d,$2c,$d3,$01,$16,$4e,$2f,$d4,$04,$e8,$03,$e1,$df,$0d,$46,$08,$e3,$08,$1d,$d3,$26,$d2,$05,$1d,$05,$68
    .byte $25,$57,$40,$01,$06,$08,$dc,$03,$dd,$31,$0d,$d4,$ee
    .byte $00

travelingChangeRationsOptionFilling:
    ; 24 bytes
    .byte $42,$71,$53,$53,$80,$83,$0c,$04,$d6,$eb,$dc,$08,$a8,$0d,$1b,$0d,$68,$05,$c2,$0b,$02,$03,$e2
    .byte $00

travelingChangeRationsOptionMeager:
    ; 25 bytes
    .byte $31,$61,$53,$50,$dc,$08,$d6,$02,$eb,$dc,$08,$a8,$0d,$06,$bc,$0c
    .byte $12,$38,$29,$22,$75,$7d,$13,$d4
    .byte $00

travelingChangeRationsOptionBareBones:
    ; 35 bytes
    .byte $52,$45,$15,$34,$68,$56,$d1,$0d,$45,$09,$06,$eb,$dc,$08,$a8,$0d,$3a,$02,$e8,$5d,$d0,$0c,$ed,$3a,$02,$e8,$09,$06,$22,$e8,$3e,$34,$d6,$41
    .byte $00

travelingStopToRestText:
    ; 23 bytes
    .byte $44,$34,$45,$34,$24,$d7,$3d,$dc,$05,$6e,$26,$66,$03,$59,$e8,$03,$89,$da,$10,$07,$06,$e3
    .byte $00

travelingPointer:
    .byte <travelingChangePaceText,>travelingChangePaceText
    .byte <travelingChangePaceHelpOption,>travelingChangePaceHelpOption
    .byte <travelingChangePaceHelpSteady,>travelingChangePaceHelpSteady
    .byte <travelingChangePaceHelpStrenuous,>travelingChangePaceHelpStrenuous
    .byte <travelingChangePaceHelpGrueling,>travelingChangePaceHelpGrueling
    .byte <travelingChangeRationsText,>travelingChangeRationsText
    .byte <travelingChangeRationsOptionFilling,>travelingChangeRationsOptionFilling
    .byte <travelingChangeRationsOptionMeager,>travelingChangeRationsOptionMeager
    .byte <travelingChangeRationsOptionBareBones,>travelingChangeRationsOptionBareBones
    .byte <travelingStopToRestText,>travelingStopToRestText
