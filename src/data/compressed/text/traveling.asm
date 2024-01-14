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

travelingChangePaceOption:
    ; 9 bytes
    .byte $15,$64,$1f,$05,$d6,$19,$26,$d4
    .byte $00

travelingChangePaceCurrently:
    ; 10 bytes
    .byte $15,$a0,$fc,$d2,$60,$e1,$0b,$58,$e8
    .byte $00

travelingChangePaceText:
    ; 38 bytes
    .byte $42,$34,$25,$36,$36,$01,$19,$26,$08,$e3,$28,$d8,$1f,$e8,$03,$e3,$1d,$e5,$1c,$d2,$05,$1f,$05,$63
    .byte $25,$47,$40,$e8,$03,$e1,$1f,$de,$3b,$06,$0d,$d4,$ee
    .byte $00

travelingChangePaceSteady:
    ; 11 bytes
    .byte $25,$16,$40,$d0,$0f,$08,$5b,$df,$26,$d4
    .byte $00

travelingChangePaceStrenuous:
    ; 13 bytes
    .byte $25,$19,$40,$d0,$0f,$e1,$0b,$e4,$03,$72,$26,$d4
    .byte $00

travelingChangePaceGrueling:
    ; 13 bytes
    .byte $25,$18,$40,$d0,$d6,$a0,$1c,$04,$d6,$df,$26,$d4
    .byte $00

travelingChangePaceHelpOption:
    ; 26 bytes
    .byte $45,$43,$45,$95,$40,$d5,$04,$d3,$03,$e3,$28,$10,$01,$06,$0e,$2e,$d5,$02,$0b,$e3,$df,$26,$06,$8d,$05
    .byte $00

travelingChangePaceHelpSteady:
    ; 59 bytes
    .byte $51,$61,$36,$51,$51,$30,$0f,$08,$5b,$eb,$e8,$03,$e3,$1d,$e5,$1c,$40,$03,$e3,$f9,$d7,$03,$6a,$47,$25
    .byte $22,$68,$50,$20,$da,$04,$a8,$42,$85,$0b,$76,$06,$32
    .byte $42,$34,$43,$23,$35,$e8,$03,$20,$da,$18,$0d,$0b,$99,$0a,$d6,$11,$0a,$99,$3d,$0e
    .byte $00

travelingChangePaceHelpStrenuous:
    ; 116 bytes
    .byte $51,$91,$36,$52,$51,$30,$0f,$e1,$0b,$e4,$03,$e2,$eb,$e8,$03,$e3,$1d,$e5,$1c,$40,$03,$e3,$f2,$f3,$d7,$03,$6a,$47,$25
    .byte $52,$84,$57,$38,$76,$60,$0f,$0d,$e3,$04,$d6,$74,$0f,$4e,$e3,$02,$e2,$36,$e1,$13,$d4,$05,$4a,$0a,$bc,$04,$d6,$39,$07,$58,$e8,$d1,$21,$07,$06,$36,$e2,$11
    .byte $42,$34,$24,$44,$90,$e8,$03,$e2,$0a,$77,$07,$06,$e3,$09,$95,$28,$0b,$dd,$18,$06,$e2,$0d,$e8
    .byte $42,$36,$43,$74,$50,$e8,$03,$d5,$04,$13,$d7,$08,$1f,$d3,$25,$83,$1c,$04,$d6,$e5,$02,$e8,$e3,$3d,$0e
    .byte $00

travelingChangePaceHelpGrueling:
    ; 146 bytes
    .byte $51,$81,$36,$52,$51,$30,$d6,$a0,$1c,$04,$d6,$eb,$e8,$03,$e3,$1d,$e5,$1c,$40,$03,$e3,$f2,$f7,$d7,$03,$6a,$47,$25
    .byte $42,$86,$73,$a5,$40,$0f,$0d,$e3,$04,$d6,$d1,$21,$07,$06,$36,$e1,$13,$d4,$05,$9a,$09,$e3,$04,$e4,$04,$d6,$36,$e3,$2b,$d3,$0d,$da
    .byte $32,$36,$54,$24,$e8,$03,$34,$7c,$0f,$dd,$3c,$02,$e2,$0a,$77,$07,$06,$e3
    .byte $42,$32,$33,$65,$25,$e8,$03,$d3,$09,$de,$5e,$11,$0b,$03,$24,$a9,$d4,$19,$10,$70,$24,$e3
    .byte $41,$36,$43,$7a,$90,$e8,$03,$d5,$04,$13,$d7,$08,$1f,$d3,$25,$83,$1c,$04,$d6,$40,$e2,$3a,$a6,$1c,$e8,$75,$2f,$e4,$0f,$0e
    .byte $22,$34,$67,$05,$5b,$03,$a4,$08,$db,$01,$e2,$e4,$50,$02,$e2
    .byte $00

travelingChangeRationsOption:
    ; 14 bytes
    .byte $25,$64,$70,$1f,$05,$d6,$21,$2c,$51,$10,$d8,$09,$e2
    .byte $00

travelingChangeRationsText:
    ; 53 bytes
    .byte $72,$36,$24,$36,$24,$53,$43,$36,$01,$08,$dc,$03,$dd,$0a,$50,$2c,$d3,$01,$19,$48,$30,$d4,$04,$e8,$03,$c7,$0d,$3f,$08,$e3,$08,$1f,$d3,$25,$d2,$05,$1f,$05,$63
    .byte $25,$57,$40,$01,$06,$08,$dc,$03,$dd,$32,$0d,$d4,$ee
    .byte $00

travelingChangeRationsOptionFilling:
    ; 24 bytes
    .byte $42,$71,$53,$53,$80,$8e,$0c,$04,$d6,$eb,$dc,$08,$ab,$0d,$1c,$0d,$63,$05,$c5,$0b,$02,$03,$e2
    .byte $00

travelingChangeRationsOptionMeager:
    ; 25 bytes
    .byte $31,$61,$53,$50,$dc,$08,$d6,$02,$eb,$dc,$08,$ab,$0d,$06,$a7,$0c
    .byte $12,$38,$2a,$20,$69,$85,$10,$d4
    .byte $00

travelingChangeRationsOptionBareBones:
    ; 35 bytes
    .byte $52,$45,$15,$34,$68,$56,$d1,$0d,$68,$09,$06,$eb,$dc,$08,$ab,$0d,$3c,$02,$e8,$61,$d0,$0c,$ed,$3c,$02,$e8,$09,$06,$20,$e8,$39,$36,$d6,$38
    .byte $00

travelingStopToRestOption:
    ; 10 bytes
    .byte $25,$42,$40,$e2,$0a,$77,$07,$06,$e3
    .byte $00

travelingStopToRestText:
    ; 23 bytes
    .byte $44,$34,$45,$34,$24,$d7,$4c,$dc,$05,$86,$25,$96,$03,$db,$5b,$03,$84,$da,$11,$07,$06,$e3
    .byte $00

travelingContinueOnTrailOption:
    ; 14 bytes
    .byte $25,$82,$50,$d2,$09,$e3,$04,$e4,$d4,$09,$e3,$1d,$2b
    .byte $00

travelingCheckSuppliesOption:
    ; 10 bytes
    .byte $15,$58,$1f,$18,$8a,$3e,$30,$d8,$06
    .byte $00

travelingLookAtMapOption:
    ; 10 bytes
    .byte $25,$42,$30,$27,$de,$da,$10,$a7,$df
    .byte $00

travelingAttemptToTradeOption:
    ; 12 bytes
    .byte $25,$72,$50,$10,$e3,$12,$77,$0a,$e3,$1d,$69
    .byte $00

travelingHuntForFoodOption:
    ; 11 bytes
    .byte $25,$43,$40,$d7,$36,$78,$07,$d5,$2c,$d3
    .byte $00

travelingTalkToPeopleOption:
    ; 12 bytes
    .byte $25,$42,$60,$20,$db,$da,$0a,$df,$48,$30,$d4
    .byte $00

travelingBuySuppliesOption:
    ; 9 bytes
    .byte $15,$38,$2a,$9f,$3e,$30,$d8,$06
    .byte $00

travelingPointer:
    .byte <travelingChangePaceOption,>travelingChangePaceOption
    .byte <travelingChangePaceCurrently,>travelingChangePaceCurrently
    .byte <travelingChangePaceText,>travelingChangePaceText
    .byte <travelingChangePaceSteady,>travelingChangePaceSteady
    .byte <travelingChangePaceStrenuous,>travelingChangePaceStrenuous
    .byte <travelingChangePaceGrueling,>travelingChangePaceGrueling
    .byte <travelingChangePaceHelpOption,>travelingChangePaceHelpOption
    .byte <travelingChangePaceHelpSteady,>travelingChangePaceHelpSteady
    .byte <travelingChangePaceHelpStrenuous,>travelingChangePaceHelpStrenuous
    .byte <travelingChangePaceHelpGrueling,>travelingChangePaceHelpGrueling
    .byte <travelingChangeRationsOption,>travelingChangeRationsOption
    .byte <travelingChangeRationsText,>travelingChangeRationsText
    .byte <travelingChangeRationsOptionFilling,>travelingChangeRationsOptionFilling
    .byte <travelingChangeRationsOptionMeager,>travelingChangeRationsOptionMeager
    .byte <travelingChangeRationsOptionBareBones,>travelingChangeRationsOptionBareBones
    .byte <travelingStopToRestOption,>travelingStopToRestOption
    .byte <travelingStopToRestText,>travelingStopToRestText
    .byte <travelingContinueOnTrailOption,>travelingContinueOnTrailOption
    .byte <travelingCheckSuppliesOption,>travelingCheckSuppliesOption
    .byte <travelingLookAtMapOption,>travelingLookAtMapOption
    .byte <travelingAttemptToTradeOption,>travelingAttemptToTradeOption
    .byte <travelingHuntForFoodOption,>travelingHuntForFoodOption
    .byte <travelingTalkToPeopleOption,>travelingTalkToPeopleOption
    .byte <travelingBuySuppliesOption,>travelingBuySuppliesOption
