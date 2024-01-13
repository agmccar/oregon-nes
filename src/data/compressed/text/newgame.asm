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
    .byte $52,$45,$26,$43,$42,$60,$dc,$05,$e8,$da,$04,$45,$16,$df,$48,$2f,$12,$43,$d4,$01,$11,$59,$df,$0a,$07,$23,$09
    .byte $00

newgameSelectOccupationBanker:
    ; 17 bytes
    .byte $35,$21,$64,$60,$d1,$08,$d1,$05,$da,$02,$d5,$14,$dc,$57,$0f,$09
    .byte $00

newgameSelectOccupationCarpenter:
    ; 18 bytes
    .byte $35,$21,$94,$40,$d1,$08,$d2,$0d,$df,$0b,$e3,$02,$d5,$14,$7c,$c5,$de
    .byte $00

newgameSelectOccupationFarmer:
    ; 18 bytes
    .byte $35,$21,$64,$80,$d1,$08,$d5,$0d,$dc,$02,$d5,$14,$92,$0c,$04,$de,$13
    .byte $00

newgameSelectOccupationHelp:
    ; 29 bytes
    .byte $45,$43,$3b,$75,$70,$d5,$04,$d3,$03,$e3,$01,$0e,$30,$d5,$02,$0b,$d2,$06,$d1,$11,$31,$0b,$01,$06,$17,$98,$3b,$06
    .byte $00

newgameOccupationHelpText1:
    ; 82 bytes
    .byte $33,$92,$65,$40,$e3,$1d,$e5,$1c,$04,$d6,$0a,$07,$23,$09,$13,$dd,$ea,$e3,$08,$c7
    .byte $31,$32,$61,$60,$2a,$e3,$30,$e8,$03,$ea,$e1,$08,$d1,$05,$da,$02
    .byte $72,$64,$45,$38,$38,$41,$92,$16,$e8,$03,$ea,$0c,$2e,$e5,$12,$07,$12,$09,$22,$d5,$07,$e2,$3e,$2f,$d8,$06,$05,$45,$02,$e5,$3b,$06,$01,$05,$26,$0d,$df,$0b,$e3,$02,$07,$4e,$0d,$dc,$02
    .byte $00

newgameOccupationHelpText2:
    ; 91 bytes
    .byte $11,$70,$98,$31,$e5,$02
    .byte $31,$36,$34,$23,$01,$7f,$0d,$d3,$02,$e8,$03,$2e,$46,$0a,$e3,$38
    .byte $33,$34,$63,$70,$01,$12,$07,$18,$de,$04,$32,$e8,$03,$d3,$06,$02,$46
    .byte $11,$90,$01,$02,$21,$07,$d4
    .byte $72,$36,$53,$86,$26,$33,$65,$35,$01,$21,$0d,$dc,$02,$08,$49,$e2,$01,$23,$e1,$08,$e3,$06,$be,$62,$d1,$02,$16,$c1,$04,$32,$05,$d3,$01,$67,$05,$da,$02,$08,$49,$e2,$01,$1c,$08,$0f
    .byte $00

newgameGoingBackText:
    ; 15 bytes
    .byte $25,$54,$24,$bf,$04,$d6,$d1,$26,$da,$0a,$f2,$f9,$f5,$f9
    .byte $00

newgameSelectMonthText:
    ; 77 bytes
    .byte $22,$22,$40,$19,$13,$f2,$f9,$f5,$f9
    .byte $41,$47,$35,$36,$2c,$e8,$03,$e1,$d9,$62,$df,$04,$d6,$16,$d5,$2f,$26,$21,$07,$07,$23,$09,$13,$04,$d3,$18,$0b,$d3,$0b,$7d
    .byte $12,$80,$dc,$13,$e2,$03,$59
    .byte $42,$34,$65,$52,$5c,$e8,$03,$9c,$0f,$d3,$17,$37,$d4,$28,$d8,$1f,$dc,$09,$01,$0a,$db,$08,$46,$04,$d3,$18,$0b,$d3,$0b,$7d
    .byte $00

newgameSelectMonthAdvice1:
    ; 55 bytes
    .byte $85,$36,$16,$74,$36,$43,$a1,$67,$65,$e8,$03,$10,$e3,$0b,$82,$7e,$52,$3b,$8e,$11,$04,$24,$1c,$54,$07,$ec,$d5,$3a,$8b,$1a,$01,$01,$17,$33,$30,$07,$70,$d0,$eb,$07,$23,$09,$d5,$3c,$02,$ef,$ec,$e8,$03,$ea,$41,$0a,$68,$ee
    .byte $00

newgameSelectMonthAdvice2:
    ; 142 bytes
    .byte $31,$23,$53,$50,$30,$e8,$03,$db,$08,$46,$0a,$de,$08,$e1,$95
    .byte $52,$55,$23,$53,$44,$23,$01,$02,$42,$09,$ea,$e3,$6c,$05,$e8,$d6,$1d,$1e,$d5,$07,$e8,$03,$14,$e7,$0b,$0a,$08,$e3
    .byte $31,$23,$53,$40,$30,$e8,$03,$db,$08,$46,$0a,$3a,$10,$d4
    .byte $52,$33,$33,$26,$66,$50,$e8,$03,$dc,$25,$29,$5e,$11,$0a,$07,$23,$09,$d1,$21,$07,$42,$04,$e3,$02,$d2,$34,$06
    .byte $41,$23,$52,$43,$54,$30,$e8,$03,$db,$08,$e5,$08,$e3,$74,$0f,$01,$02,$d8,$24,$7a,$35,$d4
    .byte $62,$54,$25,$53,$37,$45,$24,$01,$02,$d4,$1a,$0c,$d1,$23,$41,$0b,$d6,$1d,$1e,$05,$d3,$01,$42,$08,$01,$02,$1a,$0c,$0f,$d8,$0c,$d1,$17,$2c,$db
    .byte $00

newgameBeforeLeavingText1:
    ; 83 bytes
    .byte $21,$67,$c0,$d1,$21,$07,$1c,$08,$e5,$04,$d6,$04,$d3,$18,$0b,$d3,$0b,$7d
    .byte $32,$36,$39,$38,$e8,$03,$39,$03,$68,$2a,$e8,$d4,$85,$d8,$df,$dc,$0b,$e3,$05,$45,$3e,$2f,$d8,$06
    .byte $31,$34,$52,$40,$e8,$03,$2e,$46,$fb,$fb,$fb,$fb,$fb,$04,$79,$39
    .byte $52,$33,$54,$25,$23,$30,$2a,$3f,$03,$d3,$09,$ea,$01,$d0,$46,$0a,$72,$0b,$d3,$19,$d0,$0c,$29,$e6
    .byte $00

newgameBeforeLeavingText2:
    ; 33 bytes
    .byte $52,$33,$38,$34,$26,$75,$e8,$03,$d2,$05,$2a,$e8,$28,$10,$3c,$02,$e8,$03,$8d,$0e,$10,$dc,$10,$e3,$ea,$94,$0b,$02,$33,$0f,$07,$d4
    .byte $00

newgameMattsGeneralStoreHello:
    ; 54 bytes
    .byte $11,$50,$d7,$d4,$0c,$de
    .byte $12,$34,$d8,$ea,$dc,$dc,$10,$e3
    .byte $33,$26,$52,$60,$8c,$e8,$03,$ea,$e1,$23,$de,$04,$d6,$0a,$07,$23,$09
    .byte $55,$13,$33,$24,$43,$50,$3b,$05,$8f,$e7,$e8,$03,$3e,$1a,$01,$28,$10,$e8,$03,$8d,$0e,$ee
    .byte $00

newgameMattsSupplies1:
    ; 23 bytes
    .byte $55,$11,$42,$42,$44,$50,$eb,$10,$08,$dc,$16,$aa,$0b,$0a,$7e,$0c,$e8,$03,$e1,$15,$d6,$09
    .byte $00

newgameMattsSupplies2:
    ; 24 bytes
    .byte $45,$18,$34,$63,$60,$eb,$d2,$27,$01,$04,$a8,$07,$57,$01,$e2,$62,$dc,$02,$05,$8a,$04,$e3,$02
    .byte $00

newgameMattsSupplies3:
    ; 19 bytes
    .byte $45,$16,$24,$33,$40,$eb,$2f,$0b,$3f,$16,$d5,$2c,$54,$07,$01,$11,$59,$df
    .byte $00

newgameMattsSupplies4:
    ; 21 bytes
    .byte $35,$1a,$34,$60,$eb,$2d,$dc,$36,$19,$d8,$09,$d5,$07,$e8,$03,$e1,$e1,$30,$db,$06
    .byte $00

newgameMattsSupplies5:
    ; 19 bytes
    .byte $35,$15,$53,$45,$eb,$72,$0d,$18,$0d,$32,$d5,$07,$e8,$03,$e1,$15,$d6,$09
    .byte $00

newgameMattsGeneralStore:
    ; 29 bytes
    .byte $21,$67,$5c,$dc,$10,$e3,$ea,$94,$0b,$02,$33,$0f,$07,$d4,$04,$d3,$18,$0b,$d3,$0b,$7d
    .byte $15,$80,$dc,$13,$e2,$03,$59
    .byte $00

newgameMattWhichItem:
    ; 21 bytes
    .byte $44,$54,$53,$42,$30,$28,$d8,$1f,$19,$12,$e6,$03,$db,$5b,$03,$84,$4c,$0a,$2a,$e8
    .byte $00

newgameMattPressStart:
    ; 14 bytes
    .byte $25,$55,$25,$66,$06,$e2,$0f,$0d,$e3,$0a,$db,$08,$46
    .byte $00

newgameMattOxenText:
    ; 49 bytes
    .byte $72,$53,$14,$21,$51,$92,$51,$40,$01,$02,$08,$41,$f3,$aa,$0b,$04,$25,$de,$4c,$ed,$3d,$17,$34,$dc,$0b,$d3,$10,$db,$08,$0f,$f4,$e8,$de,$4c
    .byte $32,$16,$31,$40,$d8,$1f,$0d,$63,$fe,$f5,$f1,$25,$de,$4c
    .byte $00

newgameMattFoodText:
    ; 121 bytes
    .byte $82,$19,$34,$25,$36,$24,$34,$62,$46,$3d,$17,$34,$dc,$0b,$5b,$03,$20,$da,$08,$58,$08,$0f,$f3,$f1,$f1,$df,$03,$dd,$45,$16,$d5,$2c,$54,$07,$08,$1f,$df,$02,$e2,$09,$04,$e8,$03,$e1,$d5,$2d,$2b,$e8
    .byte $52,$13,$43,$41,$62,$30,$13,$b8,$01,$10,$e8,$03,$2e,$46,$f6,$df,$48,$2f,$d4,$04,$d0,$0c
    .byte $21,$64,$50,$e8,$03,$ea,$0c,$8d,$0e,$d5,$db,$03,$e1
    .byte $11,$50,$e2,$e4,$d6,$0d
    .byte $11,$50,$d1,$26,$09
    .byte $12,$36,$05,$9a,$16,$83,$d4
    .byte $42,$25,$22,$51,$50,$4a,$66,$3b,$d4,$13,$f3,$f1,$d2,$0b,$32,$d0,$df,$03,$89
    .byte $00

newgameMattClothingText:
    ; 75 bytes
    .byte $42,$64,$48,$23,$90,$e8,$03,$ea,$0c,$8d,$0e,$e6,$0d,$dc,$d2,$27,$01,$04,$d6,$04,$01,$12,$03,$dd,$20,$04,$e2
    .byte $62,$19,$62,$51,$42,$73,$60,$3d,$17,$34,$dc,$0b,$d3,$20,$da,$04,$d6,$10,$db,$08,$0f,$f3,$e2,$11,$e2,$16,$d2,$27,$01,$06,$df,$02,$df,$02,$e2,$09
    .byte $22,$43,$23,$08,$1f,$e2,$11,$13,$fe,$f2,$f1
    .byte $00

newgameMattBulletsText:
    ; 39 bytes
    .byte $42,$14,$a2,$52,$27,$13,$d4,$0c,$2d,$dc,$36,$19,$d8,$09,$04,$57,$e7,$06,$16,$f3,$f1,$2a,$0c,$11,$e2
    .byte $22,$43,$52,$08,$1f,$57,$e7,$d2,$de,$0f,$e2,$fe,$f3
    .byte $00

newgameMattSparePartsText:
    ; 49 bytes
    .byte $72,$41,$44,$24,$13,$55,$34,$50,$19,$ea,$93,$d6,$2c,$d3,$37,$08,$0a,$2e,$e5,$08,$d5,$42,$72,$0d,$18,$0d,$32,$d5,$07,$e8,$03,$e1,$15,$d6,$09
    .byte $25,$43,$37,$d7,$02,$08,$41,$01,$18,$e1,$3b,$06,$ee
    .byte $00

newgameMattHowManyText:
    ; 16 bytes
    .byte $34,$34,$23,$40,$d7,$4b,$dc,$05,$e8,$6e,$e8,$03,$e6,$05,$e3
    .byte $00

newgameMattHowManySpareText:
    ; 12 bytes
    .byte $25,$34,$50,$d7,$4b,$dc,$05,$e8,$15,$d6,$09
    .byte $00

newgameMattsGoodLuck:
    ; 60 bytes
    .byte $11,$44,$31,$0c,$01,$0b
    .byte $22,$65,$25,$e8,$03,$ea,$e1,$02,$08,$5b,$0a,$0f,$0d,$e3
    .byte $13,$44,$d6,$2c,$6b,$e4,$4f
    .byte $52,$34,$14,$39,$75,$23,$e8,$03,$2e,$e5,$08,$db,$09,$d6,$05,$a2,$30,$d5,$3b,$5d,$e3,$d9,$03,$49,$22,$d0,$d7,$08,$d3,$16,$e8,$03
    .byte $00

newgameMattDontForget:
    ; 32 bytes
    .byte $11,$56,$d3,$09,$ea,$78,$07,$d6,$11
    .byte $42,$64,$42,$44,$50,$e8,$03,$ea,$0c,$8d,$0e,$aa,$0b,$0a,$7e,$0c,$e8,$03,$e1,$15,$d6,$09
    .byte $00

newgameNowLoadingText:
    ; 15 bytes
    .byte $25,$37,$35,$29,$e6,$27,$43,$04,$d6,$01,$d4,$15,$d6,$09
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
