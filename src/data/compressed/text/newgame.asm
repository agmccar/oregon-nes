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

newgameSelectOccupationText:
    ; 28 bytes
    .byte $52,$45,$26,$43,$42,$60,$dc,$05,$e8,$da,$04,$42,$15,$df,$4e,$2f,$11,$47,$d4,$01,$10,$57,$df,$0a,$07,$1f,$09
    .byte $00

newgameSelectOccupationBanker:
    ; 17 bytes
    .byte $35,$21,$64,$60,$d1,$08,$d1,$05,$da,$02,$d5,$18,$dc,$64,$0f,$09
    .byte $00

newgameSelectOccupationCarpenter:
    ; 19 bytes
    .byte $35,$21,$94,$40,$d1,$08,$d2,$0d,$df,$0b,$e3,$02,$d5,$18,$dc,$8e,$d8,$de
    .byte $00

newgameSelectOccupationFarmer:
    ; 18 bytes
    .byte $35,$21,$64,$80,$d1,$08,$d5,$0d,$dc,$02,$d5,$18,$8a,$0c,$04,$de,$12
    .byte $00

newgameSelectOccupationHelp:
    ; 29 bytes
    .byte $45,$43,$3b,$75,$70,$d5,$04,$d3,$03,$e3,$01,$0e,$2d,$d5,$02,$0b,$d2,$06,$d1,$10,$30,$0b,$01,$06,$14,$a4,$39,$06
    .byte $00

newgameOccupationHelpText1:
    ; 82 bytes
    .byte $33,$92,$65,$40,$e3,$1a,$e5,$1b,$04,$d6,$0a,$07,$1f,$09,$12,$dd,$ea,$e3,$08,$c3
    .byte $31,$32,$61,$60,$29,$e3,$2d,$e8,$03,$ea,$e1,$08,$d1,$05,$da,$02
    .byte $72,$64,$45,$38,$38,$41,$92,$16,$e8,$03,$ea,$0c,$32,$e5,$11,$07,$11,$09,$23,$d5,$07,$e2,$43,$2f,$d8,$06,$05,$42,$02,$e5,$39,$06,$01,$05,$36,$0d,$df,$0b,$e3,$02,$07,$53,$0d,$dc,$02
    .byte $00

newgameOccupationHelpText2:
    ; 92 bytes
    .byte $11,$70,$a4,$30,$e5,$02
    .byte $31,$36,$34,$23,$01,$79,$0d,$d3,$02,$e8,$03,$32,$51,$0a,$e3,$41
    .byte $33,$34,$63,$70,$01,$11,$07,$16,$de,$04,$31,$e8,$03,$d3,$06,$02,$51
    .byte $11,$90,$01,$02,$25,$07,$d4
    .byte $72,$36,$53,$86,$26,$33,$65,$35,$01,$25,$0d,$dc,$02,$08,$48,$e2,$01,$1f,$e1,$08,$e3,$06,$bb,$5e,$d1,$02,$15,$df,$de,$04,$31,$05,$d3,$01,$45,$05,$da,$02,$08,$48,$e2,$01,$1b,$08,$0f
    .byte $00

newgameGoingBackText:
    ; 16 bytes
    .byte $25,$54,$24,$d6,$de,$04,$d6,$d1,$36,$da,$0a,$f2,$f9,$f5,$f9
    .byte $00

newgameSelectMonthText:
    ; 76 bytes
    .byte $22,$22,$40,$17,$12,$f2,$f9,$f5,$f9
    .byte $41,$47,$35,$36,$2c,$e8,$03,$e1,$d9,$5e,$df,$04,$d6,$15,$d5,$2f,$36,$25,$07,$07,$1f,$09,$12,$04,$d3,$16,$0b,$d3,$0b,$7e
    .byte $12,$80,$dc,$12,$e2,$03,$57
    .byte $42,$34,$65,$52,$5c,$e8,$03,$b2,$0f,$d3,$14,$3b,$19,$c0,$1d,$dc,$09,$01,$0a,$db,$08,$51,$04,$d3,$16,$0b,$d3,$0b,$7e
    .byte $00

newgameSelectMonthAdvice1:
    ; 56 bytes
    .byte $85,$36,$16,$74,$36,$43,$a1,$67,$65,$e8,$03,$13,$e3,$0b,$88,$8d,$5b,$39,$dc,$d4,$10,$04,$21,$1b,$55,$07,$ec,$d5,$38,$93,$24,$01,$01,$14,$2b,$2d,$07,$6d,$d0,$eb,$07,$1f,$09,$d5,$3a,$02,$ef,$ec,$e8,$03,$ea,$40,$0a,$59,$ee
    .byte $00

newgameSelectMonthAdvice2:
    ; 142 bytes
    .byte $31,$23,$53,$50,$2d,$e8,$03,$db,$08,$51,$0a,$de,$08,$e1,$91
    .byte $52,$55,$23,$53,$44,$23,$01,$02,$19,$09,$ea,$84,$d4,$05,$e8,$d6,$1a,$20,$d5,$07,$e8,$03,$18,$e7,$0b,$0a,$08,$e3
    .byte $31,$23,$53,$40,$2d,$e8,$03,$db,$08,$51,$0a,$38,$13,$d4
    .byte $52,$33,$33,$26,$66,$50,$e8,$03,$dc,$26,$2a,$60,$10,$0a,$07,$1f,$09,$d1,$25,$07,$19,$04,$e3,$02,$d2,$37,$06
    .byte $41,$23,$52,$43,$54,$2d,$e8,$03,$db,$08,$e5,$08,$e3,$72,$0f,$01,$02,$d8,$21,$99,$33,$d4
    .byte $62,$54,$25,$53,$37,$45,$24,$01,$02,$19,$d8,$0c,$d1,$1f,$40,$0b,$d6,$1a,$20,$05,$d3,$01,$19,$08,$01,$02,$24,$0c,$0f,$d8,$0c,$d1,$14,$2c,$db
    .byte $00

newgameBeforeLeavingText1:
    ; 84 bytes
    .byte $21,$67,$c0,$d1,$25,$07,$1b,$08,$e5,$04,$d6,$04,$d3,$16,$0b,$d3,$0b,$7e
    .byte $32,$36,$39,$38,$e8,$03,$3e,$03,$59,$29,$e8,$d4,$7d,$d8,$df,$dc,$0b,$e3,$05,$42,$43,$2f,$d8,$06
    .byte $31,$34,$52,$40,$e8,$03,$32,$51,$fb,$fb,$fb,$fb,$fb,$04,$d2,$35,$d7
    .byte $52,$33,$54,$25,$23,$30,$29,$46,$03,$d3,$09,$ea,$01,$d0,$51,$0a,$78,$0b,$d3,$17,$d0,$0c,$2a,$e6
    .byte $00

newgameBeforeLeavingText2:
    ; 33 bytes
    .byte $52,$33,$38,$34,$26,$75,$e8,$03,$d2,$05,$29,$e8,$2e,$13,$3a,$02,$e8,$03,$71,$0e,$13,$dc,$13,$e3,$ea,$8f,$0b,$02,$2b,$0f,$07,$d4
    .byte $00

newgameMattsGeneralStoreHello:
    ; 54 bytes
    .byte $11,$50,$d7,$d4,$0c,$de
    .byte $12,$34,$d8,$ea,$dc,$dc,$13,$e3
    .byte $33,$26,$52,$60,$a5,$e8,$03,$ea,$e1,$1f,$de,$04,$d6,$0a,$07,$1f,$09
    .byte $55,$13,$33,$24,$43,$50,$39,$05,$83,$e7,$e8,$03,$43,$24,$01,$2e,$13,$e8,$03,$71,$0e,$ee
    .byte $00

newgameMattsSupplies1:
    ; 22 bytes
    .byte $55,$11,$42,$42,$44,$50,$eb,$13,$08,$dc,$15,$a7,$0b,$0a,$8d,$0c,$e8,$03,$50,$1e,$09
    .byte $00

newgameMattsSupplies2:
    ; 24 bytes
    .byte $45,$18,$34,$63,$60,$eb,$d2,$4c,$01,$04,$a6,$07,$64,$01,$e2,$5e,$dc,$02,$05,$82,$04,$e3,$02
    .byte $00

newgameMattsSupplies3:
    ; 19 bytes
    .byte $45,$16,$24,$33,$40,$eb,$2f,$0b,$46,$15,$d5,$2c,$55,$07,$01,$10,$57,$df
    .byte $00

newgameMattsSupplies4:
    ; 21 bytes
    .byte $35,$1a,$34,$60,$eb,$28,$dc,$34,$17,$d8,$09,$d5,$07,$e8,$03,$e1,$e1,$2d,$db,$06
    .byte $00

newgameMattsSupplies5:
    ; 18 bytes
    .byte $35,$15,$53,$45,$eb,$78,$0d,$16,$0d,$31,$d5,$07,$e8,$03,$50,$1e,$09
    .byte $00

newgameMattsGeneralStore:
    ; 29 bytes
    .byte $21,$67,$5c,$dc,$13,$e3,$ea,$8f,$0b,$02,$2b,$0f,$07,$d4,$04,$d3,$16,$0b,$d3,$0b,$7e
    .byte $15,$80,$dc,$12,$e2,$03,$57
    .byte $00

newgameMattWhichItem:
    ; 21 bytes
    .byte $44,$54,$53,$42,$30,$2e,$d8,$1d,$17,$11,$e6,$03,$59,$e8,$03,$89,$4f,$0a,$29,$e8
    .byte $00

newgameMattPressStart:
    ; 14 bytes
    .byte $25,$55,$25,$65,$06,$e2,$0f,$0d,$e3,$0a,$db,$08,$51
    .byte $00

newgameMattOxenText:
    ; 49 bytes
    .byte $72,$53,$14,$21,$51,$92,$51,$40,$01,$02,$08,$40,$f3,$a7,$0b,$04,$26,$de,$4f,$ed,$3c,$14,$37,$dc,$0b,$d3,$13,$db,$08,$0f,$f4,$e8,$de,$4f
    .byte $32,$16,$31,$40,$d8,$1d,$0d,$68,$fe,$f5,$f1,$26,$de,$4f
    .byte $00

newgameMattFoodText:
    ; 120 bytes
    .byte $82,$19,$34,$25,$36,$24,$34,$62,$46,$3c,$14,$37,$dc,$0b,$69,$03,$22,$da,$08,$5f,$08,$0f,$f3,$f1,$f1,$df,$03,$dd,$42,$15,$d5,$2c,$55,$07,$08,$1d,$df,$02,$e2,$09,$04,$e8,$03,$e1,$d5,$28,$27,$e8
    .byte $52,$13,$43,$41,$62,$30,$12,$9c,$01,$13,$e8,$03,$32,$51,$f6,$df,$4e,$2f,$d4,$04,$d0,$0c
    .byte $21,$64,$50,$e8,$03,$ea,$0c,$71,$0e,$d5,$db,$03,$e1
    .byte $11,$50,$e2,$e4,$d6,$0d
    .byte $11,$50,$d1,$36,$09
    .byte $12,$36,$05,$95,$15,$9a,$d4
    .byte $42,$25,$22,$51,$50,$49,$65,$39,$d4,$12,$f3,$f1,$d2,$0b,$31,$9e,$03,$81
    .byte $00

newgameMattClothingText:
    ; 75 bytes
    .byte $42,$64,$48,$23,$90,$e8,$03,$ea,$0c,$71,$0e,$e6,$0d,$dc,$d2,$4c,$01,$04,$d6,$04,$01,$11,$03,$dd,$22,$04,$e2
    .byte $62,$19,$62,$51,$42,$73,$60,$3c,$14,$37,$dc,$0b,$d3,$22,$da,$04,$d6,$13,$db,$08,$0f,$f3,$e2,$10,$e2,$15,$d2,$4c,$01,$06,$df,$02,$df,$02,$e2,$09
    .byte $22,$43,$23,$08,$1d,$e2,$10,$12,$fe,$f2,$f1
    .byte $00

newgameMattBulletsText:
    ; 39 bytes
    .byte $42,$14,$a2,$52,$27,$12,$d4,$0c,$28,$dc,$34,$17,$d8,$09,$04,$64,$e7,$06,$15,$f3,$f1,$29,$0c,$10,$e2
    .byte $22,$43,$52,$08,$1d,$64,$e7,$d2,$de,$0f,$e2,$fe,$f3
    .byte $00

newgameMattSparePartsText:
    ; 48 bytes
    .byte $72,$41,$44,$24,$13,$55,$34,$50,$17,$ea,$e2,$1e,$2c,$d3,$3b,$08,$0a,$32,$e5,$08,$d5,$19,$78,$0d,$16,$0d,$31,$d5,$07,$e8,$03,$50,$1e,$09
    .byte $25,$43,$37,$d7,$02,$08,$40,$01,$16,$e1,$39,$06,$ee
    .byte $00

newgameMattHowManyText:
    ; 16 bytes
    .byte $34,$34,$23,$40,$d7,$3d,$dc,$05,$6e,$de,$e8,$03,$e6,$05,$e3
    .byte $00

newgameMattHowManySpareText:
    ; 11 bytes
    .byte $25,$34,$50,$d7,$3d,$dc,$05,$b0,$1e,$09
    .byte $00

newgameMattsGoodLuck:
    ; 59 bytes
    .byte $11,$44,$30,$0c,$01,$0b
    .byte $22,$65,$25,$e8,$03,$ea,$e1,$02,$08,$69,$0a,$0f,$0d,$e3
    .byte $13,$44,$d6,$2c,$6f,$e4,$54
    .byte $52,$34,$14,$39,$75,$23,$e8,$03,$32,$e5,$08,$db,$09,$d6,$05,$9f,$2d,$d5,$39,$63,$c9,$03,$48,$23,$d0,$d7,$08,$d3,$15,$e8,$03
    .byte $00

newgameMattDontForget:
    ; 31 bytes
    .byte $11,$56,$d3,$09,$ea,$7b,$07,$d6,$10
    .byte $42,$64,$42,$44,$50,$e8,$03,$ea,$0c,$71,$0e,$a7,$0b,$0a,$8d,$0c,$e8,$03,$50,$1e,$09
    .byte $00

newgameNowLoadingText:
    ; 14 bytes
    .byte $25,$37,$35,$2a,$e6,$4c,$47,$04,$d6,$01,$19,$1e,$09
    .byte $00

newgamePointer:
    .byte <newgameSelectOccupationText,>newgameSelectOccupationText
    .byte <newgameSelectOccupationBanker,>newgameSelectOccupationBanker
    .byte <newgameSelectOccupationCarpenter,>newgameSelectOccupationCarpenter
    .byte <newgameSelectOccupationFarmer,>newgameSelectOccupationFarmer
    .byte <newgameSelectOccupationHelp,>newgameSelectOccupationHelp
    .byte <newgameOccupationHelpText1,>newgameOccupationHelpText1
    .byte <newgameOccupationHelpText2,>newgameOccupationHelpText2
    .byte <newgameGoingBackText,>newgameGoingBackText
    .byte <newgameSelectMonthText,>newgameSelectMonthText
    .byte <newgameSelectMonthAdvice1,>newgameSelectMonthAdvice1
    .byte <newgameSelectMonthAdvice2,>newgameSelectMonthAdvice2
    .byte <newgameBeforeLeavingText1,>newgameBeforeLeavingText1
    .byte <newgameBeforeLeavingText2,>newgameBeforeLeavingText2
    .byte <newgameMattsGeneralStoreHello,>newgameMattsGeneralStoreHello
    .byte <newgameMattsSupplies1,>newgameMattsSupplies1
    .byte <newgameMattsSupplies2,>newgameMattsSupplies2
    .byte <newgameMattsSupplies3,>newgameMattsSupplies3
    .byte <newgameMattsSupplies4,>newgameMattsSupplies4
    .byte <newgameMattsSupplies5,>newgameMattsSupplies5
    .byte <newgameMattsGeneralStore,>newgameMattsGeneralStore
    .byte <newgameMattWhichItem,>newgameMattWhichItem
    .byte <newgameMattPressStart,>newgameMattPressStart
    .byte <newgameMattOxenText,>newgameMattOxenText
    .byte <newgameMattFoodText,>newgameMattFoodText
    .byte <newgameMattClothingText,>newgameMattClothingText
    .byte <newgameMattBulletsText,>newgameMattBulletsText
    .byte <newgameMattSparePartsText,>newgameMattSparePartsText
    .byte <newgameMattHowManyText,>newgameMattHowManyText
    .byte <newgameMattHowManySpareText,>newgameMattHowManySpareText
    .byte <newgameMattsGoodLuck,>newgameMattsGoodLuck
    .byte <newgameMattDontForget,>newgameMattDontForget
    .byte <newgameNowLoadingText,>newgameNowLoadingText
