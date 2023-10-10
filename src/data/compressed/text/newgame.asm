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
    .byte $52,$45,$26,$43,$42,$60,$dc,$05,$e8,$da,$04,$3e,$14,$58,$de,$2e,$10,$4d,$d4,$01,$11,$57,$df,$0a,$07,$1c,$09
    .byte $00

newgameSelectOccupationBanker:
    ; 17 bytes
    .byte $35,$21,$64,$60,$d1,$08,$d1,$05,$da,$02,$d5,$18,$dc,$59,$12,$09
    .byte $00

newgameSelectOccupationCarpenter:
    ; 19 bytes
    .byte $35,$21,$94,$40,$d1,$08,$d2,$0d,$df,$0b,$e3,$02,$d5,$18,$dc,$89,$d8,$de
    .byte $00

newgameSelectOccupationFarmer:
    ; 18 bytes
    .byte $35,$21,$64,$80,$d1,$08,$d5,$0d,$dc,$02,$d5,$18,$85,$0c,$04,$de,$0f
    .byte $00

newgameSelectOccupationHelp:
    ; 29 bytes
    .byte $45,$43,$3b,$75,$70,$d5,$04,$d3,$03,$e3,$01,$0e,$2c,$d5,$02,$0b,$d2,$06,$d1,$11,$33,$0b,$01,$06,$15,$8e,$38,$06
    .byte $00

newgameOccupationHelpText1:
    ; 82 bytes
    .byte $33,$92,$65,$40,$e3,$1a,$e5,$1f,$04,$d6,$0a,$07,$1c,$09,$0f,$dd,$ea,$e3,$08,$bf
    .byte $31,$32,$61,$60,$29,$e3,$2c,$e8,$03,$ea,$e1,$08,$d1,$05,$da,$02
    .byte $72,$64,$45,$38,$38,$41,$92,$16,$e8,$03,$ea,$0c,$35,$e5,$10,$07,$10,$09,$21,$d5,$07,$e2,$40,$2e,$d8,$06,$05,$3e,$02,$e5,$38,$06,$01,$05,$3a,$0d,$df,$0b,$e3,$02,$07,$55,$0d,$dc,$02
    .byte $00

newgameOccupationHelpText2:
    ; 92 bytes
    .byte $11,$70,$d7,$28,$3b,$02
    .byte $31,$36,$34,$23,$01,$73,$0d,$d3,$02,$e8,$03,$35,$45,$0a,$e3,$43
    .byte $33,$34,$63,$70,$01,$10,$07,$17,$de,$04,$30,$e8,$03,$d3,$06,$02,$45
    .byte $11,$90,$01,$02,$26,$07,$d4
    .byte $72,$36,$53,$86,$26,$33,$65,$35,$01,$26,$0d,$dc,$02,$08,$44,$e2,$01,$1c,$e1,$08,$e3,$06,$b4,$5b,$d1,$02,$14,$df,$de,$04,$30,$05,$d3,$01,$67,$05,$da,$02,$08,$44,$e2,$01,$1f,$08,$12
    .byte $00

newgameGoingBackText:
    ; 15 bytes
    .byte $25,$54,$24,$b2,$04,$d6,$d1,$3a,$da,$0a,$f2,$f9,$f5,$f9
    .byte $00

newgameSelectMonthText:
    ; 76 bytes
    .byte $22,$22,$40,$16,$0f,$f2,$f9,$f5,$f9
    .byte $41,$47,$35,$36,$2c,$e8,$03,$e1,$d9,$5b,$df,$04,$d6,$14,$d5,$2e,$3a,$26,$07,$07,$1c,$09,$0f,$04,$d3,$17,$0b,$d3,$0b,$78
    .byte $12,$80,$dc,$0f,$e2,$03,$57
    .byte $42,$34,$65,$52,$5c,$e8,$03,$ab,$12,$d3,$15,$39,$19,$bd,$22,$dc,$09,$01,$0a,$db,$08,$45,$04,$d3,$17,$0b,$d3,$0b,$78
    .byte $00

newgameSelectMonthAdvice1:
    ; 56 bytes
    .byte $85,$36,$16,$74,$36,$43,$a1,$67,$65,$e8,$03,$13,$e3,$0b,$83,$95,$50,$38,$dc,$d4,$11,$04,$20,$1f,$54,$07,$ec,$d5,$37,$8c,$23,$01,$01,$15,$2b,$2c,$07,$6f,$d0,$eb,$07,$1c,$09,$d5,$3b,$02,$ef,$ec,$e8,$03,$ea,$3c,$0a,$5c,$ee
    .byte $00

newgameSelectMonthAdvice2:
    ; 142 bytes
    .byte $31,$23,$53,$50,$2c,$e8,$03,$db,$08,$45,$0a,$de,$08,$e1,$9b
    .byte $52,$55,$23,$53,$44,$23,$01,$02,$19,$09,$ea,$e3,$68,$05,$e8,$d6,$1a,$1e,$d5,$07,$e8,$03,$18,$e7,$0b,$0a,$08,$e3
    .byte $31,$23,$53,$40,$2c,$e8,$03,$db,$08,$45,$0a,$37,$13,$d4
    .byte $52,$33,$33,$26,$66,$50,$e8,$03,$dc,$2d,$34,$63,$11,$0a,$07,$1c,$09,$d1,$26,$07,$19,$04,$e3,$02,$d2,$36,$06
    .byte $41,$23,$52,$43,$54,$2c,$e8,$03,$db,$08,$e5,$08,$e3,$75,$12,$01,$02,$d8,$20,$82,$31,$d4
    .byte $62,$54,$25,$53,$37,$45,$24,$01,$02,$19,$d8,$0c,$d1,$1c,$3c,$0b,$d6,$1a,$1e,$05,$d3,$01,$19,$08,$01,$02,$23,$0c,$12,$d8,$0c,$d1,$15,$2a,$db
    .byte $00

newgameBeforeLeavingText1:
    ; 84 bytes
    .byte $21,$67,$c0,$d1,$26,$07,$1f,$08,$e5,$04,$d6,$04,$d3,$17,$0b,$d3,$0b,$78
    .byte $32,$36,$39,$38,$e8,$03,$3f,$03,$5c,$29,$e8,$d4,$93,$d8,$df,$dc,$0b,$e3,$05,$3e,$40,$2e,$d8,$06
    .byte $31,$34,$52,$40,$e8,$03,$35,$45,$fb,$fb,$fb,$fb,$fb,$04,$d2,$2f,$d7
    .byte $52,$33,$54,$25,$23,$30,$29,$4b,$03,$d3,$09,$ea,$01,$d0,$45,$0a,$71,$0b,$d3,$16,$d0,$0c,$dd,$28
    .byte $00

newgameBeforeLeavingText2:
    ; 33 bytes
    .byte $52,$33,$38,$34,$26,$75,$e8,$03,$d2,$05,$29,$e8,$32,$13,$3b,$02,$e8,$03,$7b,$0e,$13,$dc,$13,$e3,$ea,$97,$0b,$02,$2b,$12,$07,$d4
    .byte $00

newgameMattsGeneralStoreHello:
    ; 54 bytes
    .byte $11,$50,$d7,$d4,$0c,$de
    .byte $12,$34,$d8,$ea,$dc,$dc,$13,$e3
    .byte $33,$26,$52,$60,$b9,$e8,$03,$ea,$e1,$1c,$de,$04,$d6,$0a,$07,$1c,$09
    .byte $55,$13,$33,$24,$43,$50,$38,$05,$8d,$e7,$e8,$03,$40,$23,$01,$32,$13,$e8,$03,$7b,$0e,$ee
    .byte $00

newgameMattsSupplies1:
    ; 22 bytes
    .byte $55,$11,$42,$42,$44,$50,$eb,$13,$08,$dc,$14,$ba,$0b,$0a,$95,$0c,$e8,$03,$53,$1d,$09
    .byte $00

newgameMattsSupplies2:
    ; 24 bytes
    .byte $45,$18,$34,$63,$60,$eb,$d2,$47,$01,$04,$b7,$07,$59,$01,$e2,$5b,$dc,$02,$05,$7c,$04,$e3,$02
    .byte $00

newgameMattsSupplies3:
    ; 19 bytes
    .byte $45,$16,$24,$33,$40,$eb,$2e,$0b,$4b,$14,$d5,$2a,$54,$07,$01,$11,$57,$df
    .byte $00

newgameMattsSupplies4:
    ; 21 bytes
    .byte $35,$1a,$34,$60,$eb,$27,$dc,$3d,$16,$d8,$09,$d5,$07,$e8,$03,$e1,$e1,$2c,$db,$06
    .byte $00

newgameMattsSupplies5:
    ; 18 bytes
    .byte $35,$15,$53,$45,$eb,$71,$0d,$17,$0d,$30,$d5,$07,$e8,$03,$53,$1d,$09
    .byte $00

newgameMattsGeneralStore:
    ; 29 bytes
    .byte $21,$67,$5c,$dc,$13,$e3,$ea,$97,$0b,$02,$2b,$12,$07,$d4,$04,$d3,$17,$0b,$d3,$0b,$78
    .byte $15,$80,$dc,$0f,$e2,$03,$57
    .byte $00

newgameMattWhichItem:
    ; 21 bytes
    .byte $44,$54,$53,$42,$30,$32,$d8,$22,$16,$10,$e6,$03,$5c,$e8,$03,$92,$48,$0a,$29,$e8
    .byte $00

newgameMattPressStart:
    ; 14 bytes
    .byte $25,$55,$25,$61,$06,$e2,$12,$0d,$e3,$0a,$db,$08,$45
    .byte $00

newgameMattsBuySupplies1:
    ; 64 bytes
    .byte $72,$53,$14,$21,$51,$92,$51,$40,$01,$02,$08,$3c,$f3,$ba,$0b,$04,$2d,$de,$48,$ed,$42,$15,$36,$dc,$0b,$d3,$13,$db,$08,$12,$f4,$e8,$de,$48
    .byte $32,$16,$31,$40,$d8,$22,$0d,$72,$fe,$f5,$f1,$2d,$de,$48
    .byte $34,$34,$23,$40,$d7,$28,$dc,$05,$e8,$60,$e8,$03,$e6,$05,$e3
    .byte $00

newgameMattsBuySupplies2:
    ; 143 bytes
    .byte $82,$19,$34,$25,$36,$24,$34,$62,$46,$42,$15,$36,$dc,$0b,$7d,$03,$24,$da,$08,$62,$08,$12,$f3,$f1,$f1,$df,$03,$dd,$3e,$14,$d5,$2a,$54,$07,$08,$22,$df,$02,$e2,$09,$04,$e8,$03,$e1,$d5,$27,$25,$e8
    .byte $52,$13,$43,$41,$62,$30,$0f,$99,$01,$13,$e8,$03,$35,$45,$f6,$58,$de,$2e,$d4,$04,$d0,$0c
    .byte $21,$64,$50,$e8,$03,$ea,$0c,$7b,$0e,$d5,$db,$03,$e1
    .byte $11,$50,$e2,$e4,$d6,$0d
    .byte $11,$50,$d1,$3a,$09
    .byte $12,$36,$05,$a1,$14,$d5,$99
    .byte $42,$25,$22,$51,$50,$46,$61,$38,$d4,$0f,$f3,$f1,$d2,$0b,$30,$9a,$03,$7a
    .byte $44,$34,$62,$42,$34,$d7,$28,$dc,$05,$cf,$03,$dd,$3e,$14,$d5,$2a,$d3,$60,$e8,$03,$e6,$05,$e3
    .byte $00

newgameMattsBuySupplies3:
    ; 98 bytes
    .byte $42,$64,$48,$23,$90,$e8,$03,$ea,$0c,$7b,$0e,$e6,$0d,$dc,$d2,$47,$01,$04,$d6,$04,$01,$10,$03,$dd,$24,$04,$e2
    .byte $62,$19,$62,$51,$42,$73,$60,$42,$15,$36,$dc,$0b,$d3,$24,$da,$04,$d6,$13,$db,$08,$12,$f3,$e2,$11,$e2,$14,$d2,$47,$01,$06,$df,$02,$df,$02,$e2,$09
    .byte $22,$43,$23,$08,$22,$e2,$11,$0f,$fe,$f2,$f1
    .byte $44,$34,$42,$72,$34,$d7,$28,$dc,$05,$b0,$11,$e2,$14,$d2,$47,$01,$06,$60,$e8,$03,$e6,$05,$e3
    .byte $00

newgameMattsBuySupplies4:
    ; 57 bytes
    .byte $42,$14,$a2,$52,$27,$0f,$d4,$0c,$27,$dc,$3d,$16,$d8,$09,$04,$59,$e7,$06,$14,$f3,$f1,$29,$0c,$11,$e2
    .byte $22,$43,$52,$08,$22,$59,$e7,$d2,$de,$12,$e2,$fe,$f3
    .byte $34,$34,$52,$34,$d7,$28,$dc,$05,$e8,$59,$e7,$06,$60,$e8,$03,$e6,$05,$e3
    .byte $00

newgameMattsBuySupplies5:
    ; 58 bytes
    .byte $72,$41,$44,$24,$13,$55,$34,$50,$16,$ea,$e2,$1d,$2a,$d3,$39,$08,$0a,$35,$e5,$08,$d5,$19,$71,$0d,$17,$0d,$30,$d5,$07,$e8,$03,$53,$1d,$09
    .byte $25,$43,$37,$d7,$02,$08,$3c,$01,$17,$e1,$38,$06,$ee
    .byte $25,$34,$50,$d7,$28,$dc,$05,$a9,$1d,$09
    .byte $00

newgameMattsGoodLuck:
    ; 59 bytes
    .byte $11,$44,$33,$0c,$01,$0b
    .byte $22,$65,$25,$e8,$03,$ea,$e1,$02,$08,$7d,$0a,$12,$0d,$e3
    .byte $13,$44,$d6,$2a,$6c,$e4,$51
    .byte $52,$34,$14,$39,$75,$23,$e8,$03,$35,$e5,$08,$db,$09,$d6,$05,$9d,$2c,$d5,$38,$5f,$c8,$03,$44,$21,$d0,$d7,$08,$d3,$14,$e8,$03
    .byte $00

newgameNowLoadingText:
    ; 15 bytes
    .byte $25,$37,$36,$dd,$28,$47,$4d,$04,$d6,$01,$19,$1d,$09,$fb
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
    .byte <newgameMattsBuySupplies1,>newgameMattsBuySupplies1
    .byte <newgameMattsBuySupplies2,>newgameMattsBuySupplies2
    .byte <newgameMattsBuySupplies3,>newgameMattsBuySupplies3
    .byte <newgameMattsBuySupplies4,>newgameMattsBuySupplies4
    .byte <newgameMattsBuySupplies5,>newgameMattsBuySupplies5
    .byte <newgameMattsGoodLuck,>newgameMattsGoodLuck
    .byte <newgameNowLoadingText,>newgameNowLoadingText
