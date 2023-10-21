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
    .byte $52,$45,$26,$43,$42,$60,$dc,$05,$e8,$da,$04,$3c,$14,$58,$de,$2e,$10,$50,$d4,$01,$11,$57,$df,$0a,$06,$1d,$09
    .byte $00

newgameSelectOccupationBanker:
    ; 17 bytes
    .byte $35,$21,$64,$60,$d1,$08,$d1,$05,$da,$02,$d5,$18,$dc,$59,$12,$09
    .byte $00

newgameSelectOccupationCarpenter:
    ; 19 bytes
    .byte $35,$21,$94,$40,$d1,$08,$d2,$0d,$df,$0b,$e3,$02,$d5,$18,$dc,$87,$d8,$de
    .byte $00

newgameSelectOccupationFarmer:
    ; 18 bytes
    .byte $35,$21,$64,$80,$d1,$08,$d5,$0d,$dc,$02,$d5,$18,$84,$0c,$04,$de,$0f
    .byte $00

newgameSelectOccupationHelp:
    ; 29 bytes
    .byte $45,$43,$3b,$75,$70,$d5,$04,$d3,$03,$e3,$01,$0e,$2d,$d5,$02,$0b,$d2,$07,$d1,$11,$2c,$0b,$01,$07,$15,$7f,$35,$07
    .byte $00

newgameOccupationHelpText1:
    ; 82 bytes
    .byte $33,$92,$65,$40,$e3,$1b,$e5,$1f,$04,$d6,$0a,$06,$1d,$09,$0f,$dd,$ea,$e3,$08,$bb
    .byte $31,$32,$61,$60,$28,$e3,$2d,$e8,$03,$ea,$e1,$08,$d1,$05,$da,$02
    .byte $72,$64,$45,$38,$38,$41,$92,$16,$e8,$03,$ea,$0c,$30,$e5,$10,$06,$10,$09,$21,$d5,$06,$e2,$3f,$2e,$d8,$07,$05,$3c,$02,$e5,$35,$07,$01,$05,$36,$0d,$df,$0b,$e3,$02,$06,$55,$0d,$dc,$02
    .byte $00

newgameOccupationHelpText2:
    ; 92 bytes
    .byte $11,$70,$7f,$2c,$e5,$02
    .byte $31,$36,$34,$23,$01,$73,$0d,$d3,$02,$e8,$03,$30,$42,$0a,$e3,$41
    .byte $33,$34,$63,$70,$01,$10,$06,$17,$de,$04,$2f,$e8,$03,$d3,$07,$02,$42
    .byte $11,$90,$01,$02,$24,$06,$d4
    .byte $72,$36,$53,$86,$26,$33,$65,$35,$01,$24,$0d,$dc,$02,$08,$44,$e2,$01,$1d,$e1,$08,$e3,$07,$b0,$5b,$d1,$02,$14,$df,$de,$04,$2f,$05,$d3,$01,$67,$05,$da,$02,$08,$44,$e2,$01,$1f,$08,$12
    .byte $00

newgameGoingBackText:
    ; 15 bytes
    .byte $25,$54,$24,$ce,$04,$d6,$d1,$36,$da,$0a,$f2,$f9,$f5,$f9
    .byte $00

newgameSelectMonthText:
    ; 77 bytes
    .byte $22,$22,$40,$16,$0f,$f2,$f9,$f5,$f9
    .byte $41,$47,$35,$36,$2c,$e8,$03,$e1,$d9,$5b,$df,$04,$d6,$14,$d5,$2e,$36,$24,$06,$06,$1d,$09,$0f,$04,$d3,$17,$0b,$d3,$0b,$71
    .byte $12,$80,$dc,$0f,$e2,$03,$57
    .byte $42,$34,$65,$52,$5c,$e8,$03,$a5,$12,$d3,$15,$48,$d4,$25,$d8,$23,$dc,$09,$01,$0a,$db,$08,$42,$04,$d3,$17,$0b,$d3,$0b,$71
    .byte $00

newgameSelectMonthAdvice1:
    ; 56 bytes
    .byte $85,$36,$16,$74,$36,$43,$a1,$67,$65,$e8,$03,$19,$e3,$0b,$79,$86,$51,$35,$dc,$d4,$11,$04,$20,$1f,$54,$06,$ec,$d5,$34,$8d,$1a,$01,$01,$15,$29,$2d,$06,$70,$d0,$eb,$06,$1d,$09,$d5,$3b,$02,$ef,$ec,$e8,$03,$ea,$38,$0a,$5c,$ee
    .byte $00

newgameSelectMonthAdvice2:
    ; 142 bytes
    .byte $31,$23,$53,$50,$2d,$e8,$03,$db,$08,$42,$0a,$de,$08,$e1,$98
    .byte $52,$55,$23,$53,$44,$23,$01,$02,$3d,$09,$ea,$e3,$68,$05,$e8,$d6,$1b,$1e,$d5,$06,$e8,$03,$18,$e7,$0b,$0a,$08,$e3
    .byte $31,$23,$53,$40,$2d,$e8,$03,$db,$08,$42,$0a,$34,$19,$d4
    .byte $52,$33,$33,$26,$66,$50,$e8,$03,$dc,$32,$27,$62,$11,$0a,$06,$1d,$09,$d1,$24,$06,$3d,$04,$e3,$02,$d2,$33,$07
    .byte $41,$23,$52,$43,$54,$2d,$e8,$03,$db,$08,$e5,$08,$e3,$74,$12,$01,$02,$d8,$20,$78,$31,$d4
    .byte $62,$54,$25,$53,$37,$45,$24,$01,$02,$d4,$1a,$0c,$d1,$1d,$38,$0b,$d6,$1b,$1e,$05,$d3,$01,$3d,$08,$01,$02,$1a,$0c,$12,$d8,$0c,$d1,$15,$2b,$db
    .byte $00

newgameBeforeLeavingText1:
    ; 83 bytes
    .byte $21,$67,$c0,$d1,$24,$06,$1f,$08,$e5,$04,$d6,$04,$d3,$17,$0b,$d3,$0b,$71
    .byte $32,$36,$39,$38,$e8,$03,$3e,$03,$5c,$28,$e8,$d4,$93,$d8,$df,$dc,$0b,$e3,$05,$3c,$3f,$2e,$d8,$07
    .byte $31,$34,$52,$40,$e8,$03,$30,$42,$fb,$fb,$fb,$fb,$fb,$04,$80,$3e
    .byte $52,$33,$54,$25,$23,$30,$28,$4a,$03,$d3,$09,$ea,$01,$d0,$42,$0a,$72,$0b,$d3,$16,$d0,$0c,$27,$e6
    .byte $00

newgameBeforeLeavingText2:
    ; 33 bytes
    .byte $52,$33,$38,$34,$26,$75,$e8,$03,$d2,$05,$28,$e8,$25,$19,$3b,$02,$e8,$03,$6d,$0e,$19,$dc,$19,$e3,$ea,$89,$0b,$02,$29,$12,$06,$d4
    .byte $00

newgameMattsGeneralStoreHello:
    ; 54 bytes
    .byte $11,$50,$d7,$d4,$0c,$de
    .byte $12,$34,$d8,$ea,$dc,$dc,$19,$e3
    .byte $33,$26,$52,$60,$9d,$e8,$03,$ea,$e1,$1d,$de,$04,$d6,$0a,$06,$1d,$09
    .byte $55,$13,$33,$24,$43,$50,$35,$05,$8e,$e7,$e8,$03,$3f,$1a,$01,$25,$19,$e8,$03,$6d,$0e,$ee
    .byte $00

newgameMattsSupplies1:
    ; 23 bytes
    .byte $55,$11,$42,$42,$44,$50,$eb,$19,$08,$dc,$14,$88,$0b,$0a,$86,$0c,$e8,$03,$e1,$13,$d6,$09
    .byte $00

newgameMattsSupplies2:
    ; 24 bytes
    .byte $45,$18,$34,$63,$60,$eb,$d2,$39,$01,$04,$b4,$06,$59,$01,$e2,$5b,$dc,$02,$05,$8b,$04,$e3,$02
    .byte $00

newgameMattsSupplies3:
    ; 19 bytes
    .byte $45,$16,$24,$33,$40,$eb,$2e,$0b,$4a,$14,$d5,$2b,$54,$06,$01,$11,$57,$df
    .byte $00

newgameMattsSupplies4:
    ; 21 bytes
    .byte $35,$1a,$34,$60,$eb,$2a,$dc,$3a,$16,$d8,$09,$d5,$06,$e8,$03,$e1,$e1,$2d,$db,$07
    .byte $00

newgameMattsSupplies5:
    ; 19 bytes
    .byte $35,$15,$53,$45,$eb,$72,$0d,$17,$0d,$2f,$d5,$06,$e8,$03,$e1,$13,$d6,$09
    .byte $00

newgameMattsGeneralStore:
    ; 29 bytes
    .byte $21,$67,$5c,$dc,$19,$e3,$ea,$89,$0b,$02,$29,$12,$06,$d4,$04,$d3,$17,$0b,$d3,$0b,$71
    .byte $15,$80,$dc,$0f,$e2,$03,$57
    .byte $00

newgameMattWhichItem:
    ; 21 bytes
    .byte $44,$54,$53,$42,$30,$25,$d8,$23,$16,$10,$e6,$03,$5c,$e8,$03,$92,$46,$0a,$28,$e8
    .byte $00

newgameMattPressStart:
    ; 14 bytes
    .byte $25,$55,$25,$60,$07,$e2,$12,$0d,$e3,$0a,$db,$08,$42
    .byte $00

newgameMattOxenText:
    ; 49 bytes
    .byte $72,$53,$14,$21,$51,$92,$51,$40,$01,$02,$08,$38,$f3,$88,$0b,$04,$32,$de,$46,$ed,$40,$15,$33,$dc,$0b,$d3,$19,$db,$08,$12,$f4,$e8,$de,$46
    .byte $32,$16,$31,$40,$d8,$23,$0d,$66,$fe,$f5,$f1,$32,$de,$46
    .byte $00

newgameMattFoodText:
    ; 121 bytes
    .byte $82,$19,$34,$25,$36,$24,$34,$62,$46,$40,$15,$33,$dc,$0b,$69,$03,$22,$da,$08,$61,$08,$12,$f3,$f1,$f1,$df,$03,$dd,$3c,$14,$d5,$2b,$54,$06,$08,$23,$df,$02,$e2,$09,$04,$e8,$03,$e1,$d5,$2a,$26,$e8
    .byte $52,$13,$43,$41,$62,$30,$0f,$97,$01,$19,$e8,$03,$30,$42,$f6,$58,$de,$2e,$d4,$04,$d0,$0c
    .byte $21,$64,$50,$e8,$03,$ea,$0c,$6d,$0e,$d5,$db,$03,$e1
    .byte $11,$50,$e2,$e4,$d6,$0d
    .byte $11,$50,$d1,$36,$09
    .byte $12,$36,$05,$9e,$14,$d5,$97
    .byte $42,$25,$22,$51,$50,$45,$60,$35,$d4,$0f,$f3,$f1,$d2,$0b,$2f,$d0,$df,$03,$7b
    .byte $00

newgameMattClothingText:
    ; 75 bytes
    .byte $42,$64,$48,$23,$90,$e8,$03,$ea,$0c,$6d,$0e,$e6,$0d,$dc,$d2,$39,$01,$04,$d6,$04,$01,$10,$03,$dd,$22,$04,$e2
    .byte $62,$19,$62,$51,$42,$73,$60,$40,$15,$33,$dc,$0b,$d3,$22,$da,$04,$d6,$19,$db,$08,$12,$f3,$e2,$11,$e2,$14,$d2,$39,$01,$07,$df,$02,$df,$02,$e2,$09
    .byte $22,$43,$23,$08,$23,$e2,$11,$0f,$fe,$f2,$f1
    .byte $00

newgameMattBulletsText:
    ; 39 bytes
    .byte $42,$14,$a2,$52,$27,$0f,$d4,$0c,$2a,$dc,$3a,$16,$d8,$09,$04,$59,$e7,$07,$14,$f3,$f1,$28,$0c,$11,$e2
    .byte $22,$43,$52,$08,$23,$59,$e7,$d2,$de,$12,$e2,$fe,$f3
    .byte $00

newgameMattSparePartsText:
    ; 49 bytes
    .byte $72,$41,$44,$24,$13,$55,$34,$50,$16,$ea,$a7,$d6,$2b,$37,$d3,$08,$0a,$30,$e5,$08,$d5,$3d,$72,$0d,$17,$0d,$2f,$d5,$06,$e8,$03,$e1,$13,$d6,$09
    .byte $25,$43,$37,$d7,$02,$08,$38,$01,$17,$e1,$35,$07,$ee
    .byte $00

newgameMattHowManyText:
    ; 16 bytes
    .byte $34,$34,$23,$40,$d7,$4c,$dc,$05,$e8,$6e,$e8,$03,$e6,$05,$e3
    .byte $00

newgameMattHowManySpareText:
    ; 12 bytes
    .byte $25,$34,$50,$d7,$4c,$dc,$05,$e8,$13,$d6,$09
    .byte $00

newgameMattsGoodLuck:
    ; 59 bytes
    .byte $11,$44,$2c,$0c,$01,$0b
    .byte $22,$65,$25,$e8,$03,$ea,$e1,$02,$08,$69,$0a,$12,$0d,$e3
    .byte $13,$44,$d6,$2b,$6b,$e4,$52
    .byte $52,$34,$14,$39,$75,$23,$e8,$03,$30,$e5,$08,$db,$09,$d6,$05,$9a,$2d,$d5,$35,$5f,$c3,$03,$44,$21,$d0,$d7,$08,$d3,$14,$e8,$03
    .byte $00

newgameMattDontForget:
    ; 32 bytes
    .byte $11,$56,$d3,$09,$ea,$77,$06,$d6,$11
    .byte $42,$64,$42,$44,$50,$e8,$03,$ea,$0c,$6d,$0e,$88,$0b,$0a,$86,$0c,$e8,$03,$e1,$13,$d6,$09
    .byte $00

newgameNowLoadingText:
    ; 16 bytes
    .byte $25,$37,$36,$27,$e6,$39,$50,$04,$d6,$01,$d4,$13,$d6,$09,$fb
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
