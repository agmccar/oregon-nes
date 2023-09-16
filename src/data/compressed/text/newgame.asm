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
    .byte $52,$45,$26,$43,$42,$60,$dc,$05,$e8,$da,$04,$3f,$13,$57,$de,$2e,$10,$4d,$d4,$01,$11,$58,$df,$0a,$07,$1d,$09
    .byte $00

newgameSelectOccupationBanker:
    ; 17 bytes
    .byte $35,$21,$64,$60,$d1,$08,$d1,$05,$da,$02,$d5,$17,$dc,$5b,$12,$09
    .byte $00

newgameSelectOccupationCarpenter:
    ; 19 bytes
    .byte $35,$21,$94,$40,$d1,$08,$d2,$0d,$df,$0b,$e3,$02,$d5,$17,$dc,$8a,$d8,$de
    .byte $00

newgameSelectOccupationFarmer:
    ; 18 bytes
    .byte $35,$21,$64,$80,$d1,$08,$d5,$0d,$dc,$02,$d5,$17,$86,$0c,$04,$de,$0f
    .byte $00

newgameSelectOccupationHelp:
    ; 29 bytes
    .byte $45,$43,$3b,$75,$70,$d5,$04,$d3,$03,$e3,$01,$0e,$2c,$d5,$02,$0b,$d2,$06,$d1,$11,$33,$0b,$01,$06,$15,$8f,$38,$06
    .byte $00

newgameOccupationHelpText1:
    ; 82 bytes
    .byte $33,$92,$65,$40,$e3,$1a,$e5,$1f,$04,$d6,$0a,$07,$1d,$09,$0f,$dd,$ea,$e3,$08,$bf
    .byte $31,$32,$61,$60,$2a,$e3,$2c,$e8,$03,$ea,$e1,$08,$d1,$05,$da,$02
    .byte $72,$64,$45,$38,$38,$41,$92,$16,$e8,$03,$ea,$0c,$35,$e5,$10,$07,$10,$09,$21,$d5,$07,$e2,$41,$2e,$d8,$06,$05,$3f,$02,$e5,$38,$06,$01,$05,$3a,$0d,$df,$0b,$e3,$02,$07,$55,$0d,$dc,$02
    .byte $00

newgameOccupationHelpText2:
    ; 92 bytes
    .byte $11,$70,$d7,$28,$3c,$02
    .byte $31,$36,$34,$23,$01,$72,$0d,$d3,$02,$e8,$03,$35,$53,$0a,$e3,$43
    .byte $33,$34,$63,$70,$01,$10,$07,$19,$de,$04,$31,$e8,$03,$d3,$06,$02,$53
    .byte $11,$90,$01,$02,$22,$07,$d4
    .byte $72,$36,$53,$86,$26,$33,$65,$35,$01,$22,$0d,$dc,$02,$08,$44,$e2,$01,$1d,$e1,$08,$e3,$06,$b5,$5c,$d1,$02,$13,$df,$de,$04,$31,$05,$d3,$01,$4a,$05,$da,$02,$08,$44,$e2,$01,$1f,$08,$12
    .byte $00

newgameNamePartyText1:
    ; 26 bytes
    .byte $54,$42,$35,$42,$35,$60,$30,$14,$0f,$01,$22,$3b,$12,$dd,$24,$d4,$13,$01,$18,$1c,$09,$db,$08,$d3,$02
    .byte $00

newgameNamePartyText2:
    ; 39 bytes
    .byte $74,$43,$35,$52,$34,$57,$24,$50,$30,$14,$0d,$d4,$01,$22,$3b,$12,$dd,$24,$06,$13,$01,$22,$03,$17,$01,$02,$dc,$10,$d1,$02,$e2,$04,$e8,$03,$e1,$df,$0d,$46
    .byte $00

newgameNamePartyPressStart:
    ; 20 bytes
    .byte $35,$65,$25,$60,$fc,$0b,$e3,$02,$dd,$24,$06,$07,$61,$06,$e2,$12,$0d,$e3,$fd
    .byte $00

newgameGoingBackText:
    ; 16 bytes
    .byte $25,$54,$25,$b3,$04,$d6,$d1,$3a,$da,$0a,$f2,$f9,$f5,$f9,$fb
    .byte $00

newgameSelectMonthText:
    ; 76 bytes
    .byte $22,$22,$40,$16,$0f,$f2,$f9,$f5,$f9
    .byte $41,$47,$35,$36,$2c,$e8,$03,$e1,$d9,$5c,$df,$04,$d6,$13,$d5,$2e,$3a,$22,$07,$07,$1d,$09,$0f,$04,$d3,$19,$0b,$d3,$0b,$77
    .byte $12,$80,$dc,$0f,$e2,$03,$58
    .byte $42,$34,$65,$52,$5c,$e8,$03,$aa,$12,$d3,$15,$39,$18,$bd,$23,$dc,$09,$01,$0a,$db,$08,$53,$04,$d3,$19,$0b,$d3,$0b,$77
    .byte $00

newgameSelectMonthAdvice1:
    ; 56 bytes
    .byte $85,$36,$16,$74,$36,$43,$a1,$67,$65,$e8,$03,$14,$e3,$0b,$84,$95,$59,$38,$dc,$d4,$11,$04,$20,$1f,$54,$07,$ec,$d5,$37,$8d,$25,$01,$01,$15,$2b,$2c,$07,$6e,$d0,$eb,$07,$1d,$09,$d5,$3c,$02,$ef,$ec,$e8,$03,$ea,$3e,$0a,$63,$ee
    .byte $00

newgameSelectMonthAdvice2:
    ; 142 bytes
    .byte $31,$23,$53,$50,$2c,$e8,$03,$db,$08,$53,$0a,$de,$08,$e1,$99
    .byte $52,$55,$23,$53,$44,$23,$01,$02,$18,$09,$ea,$7e,$d4,$05,$e8,$d6,$1a,$1e,$d5,$07,$e8,$03,$17,$e7,$0b,$0a,$08,$e3
    .byte $31,$23,$53,$40,$2c,$e8,$03,$db,$08,$53,$0a,$37,$14,$d4
    .byte $52,$33,$33,$26,$66,$50,$e8,$03,$dc,$2d,$34,$64,$11,$0a,$07,$1d,$09,$d1,$22,$07,$18,$04,$e3,$02,$d2,$36,$06
    .byte $41,$23,$52,$43,$54,$2c,$e8,$03,$db,$08,$e5,$08,$e3,$74,$12,$01,$02,$d8,$20,$83,$32,$d4
    .byte $62,$54,$25,$53,$37,$45,$24,$01,$02,$18,$d8,$0c,$d1,$1d,$3e,$0b,$d6,$1a,$1e,$05,$d3,$01,$18,$08,$01,$02,$25,$0c,$12,$d8,$0c,$d1,$15,$29,$db
    .byte $00

newgameBeforeLeavingText1:
    ; 85 bytes
    .byte $21,$67,$c0,$d1,$22,$07,$1f,$08,$e5,$04,$d6,$04,$d3,$19,$0b,$d3,$0b,$77
    .byte $32,$36,$39,$38,$e8,$03,$40,$03,$63,$2a,$e8,$d4,$93,$d8,$df,$dc,$0b,$e3,$05,$3f,$41,$2e,$d8,$06
    .byte $31,$34,$62,$40,$e8,$03,$35,$53,$fb,$fb,$fb,$fb,$fb,$fb,$04,$d2,$2f,$d7
    .byte $52,$33,$54,$25,$23,$30,$2a,$46,$03,$d3,$09,$ea,$01,$d0,$53,$0a,$70,$0b,$d3,$16,$d0,$0c,$dd,$28
    .byte $00

newgameBeforeLeavingText2:
    ; 33 bytes
    .byte $52,$33,$38,$34,$26,$75,$e8,$03,$d2,$05,$2a,$e8,$30,$14,$3c,$02,$e8,$03,$7b,$0e,$14,$dc,$14,$e3,$ea,$ab,$0b,$02,$2b,$12,$07,$d4
    .byte $00

newgameMattsGeneralStoreHello:
    ; 55 bytes
    .byte $11,$50,$d7,$d4,$0c,$de
    .byte $12,$34,$d8,$ea,$dc,$dc,$14,$e3
    .byte $33,$26,$52,$60,$e2,$de,$e8,$03,$ea,$e1,$1d,$de,$04,$d6,$0a,$07,$1d,$09
    .byte $55,$13,$33,$24,$43,$50,$38,$05,$8e,$e7,$e8,$03,$41,$25,$01,$30,$14,$e8,$03,$7b,$0e,$ee
    .byte $00

newgameMattsSupplies1:
    ; 20 bytes
    .byte $45,$14,$24,$24,$45,$14,$08,$dc,$13,$ba,$0b,$0a,$95,$0c,$e8,$03,$52,$1c,$09
    .byte $00

newgameMattsSupplies2:
    ; 22 bytes
    .byte $35,$83,$46,$36,$d2,$47,$01,$04,$b7,$07,$5b,$01,$e2,$5c,$dc,$02,$05,$7c,$04,$e3,$02
    .byte $00

newgameMattsSupplies3:
    ; 17 bytes
    .byte $35,$62,$43,$34,$2e,$0b,$46,$13,$d5,$29,$54,$07,$01,$11,$58,$df
    .byte $00

newgameMattsSupplies4:
    ; 19 bytes
    .byte $25,$a3,$46,$24,$dc,$3d,$16,$d8,$09,$d5,$07,$e8,$03,$e1,$e1,$2c,$db,$06
    .byte $00

newgameMattsSupplies5:
    ; 17 bytes
    .byte $35,$55,$34,$50,$70,$0d,$19,$0d,$31,$d5,$07,$e8,$03,$52,$1c,$09
    .byte $00

newgameMattsBuySupplies1:
    ; 64 bytes
    .byte $72,$53,$14,$21,$51,$92,$51,$40,$01,$02,$08,$3e,$f3,$ba,$0b,$04,$2d,$de,$4f,$ed,$3b,$15,$36,$dc,$0b,$d3,$14,$db,$08,$12,$f4,$e8,$de,$4f
    .byte $32,$16,$31,$40,$d8,$23,$0d,$71,$fe,$f5,$f1,$2d,$de,$4f
    .byte $34,$34,$23,$40,$d7,$28,$dc,$05,$e8,$60,$e8,$03,$e6,$05,$e3
    .byte $00

newgameMattsBuySupplies2:
    ; 143 bytes
    .byte $82,$19,$34,$25,$36,$24,$34,$62,$46,$3b,$15,$36,$dc,$0b,$7d,$03,$26,$da,$08,$62,$08,$12,$f3,$f1,$f1,$df,$03,$dd,$3f,$13,$d5,$29,$54,$07,$08,$23,$df,$02,$e2,$09,$04,$e8,$03,$e1,$d5,$24,$27,$e8
    .byte $52,$13,$43,$41,$62,$30,$0f,$97,$01,$14,$e8,$03,$35,$53,$f6,$57,$de,$2e,$d4,$04,$d0,$0c
    .byte $21,$64,$50,$e8,$03,$ea,$0c,$7b,$0e,$d5,$db,$03,$e1
    .byte $11,$50,$e2,$e4,$d6,$0d
    .byte $11,$50,$d1,$3a,$09
    .byte $12,$36,$05,$9f,$13,$d5,$97
    .byte $42,$25,$22,$51,$50,$45,$61,$38,$d4,$0f,$f3,$f1,$d2,$0b,$31,$98,$03,$7a
    .byte $44,$34,$62,$42,$34,$d7,$28,$dc,$05,$ce,$03,$dd,$3f,$13,$d5,$29,$d3,$60,$e8,$03,$e6,$05,$e3
    .byte $00

newgameMattsBuySupplies3:
    ; 98 bytes
    .byte $42,$64,$48,$23,$90,$e8,$03,$ea,$0c,$7b,$0e,$e6,$0d,$dc,$d2,$47,$01,$04,$d6,$04,$01,$10,$03,$dd,$26,$04,$e2
    .byte $62,$19,$62,$51,$42,$73,$60,$3b,$15,$36,$dc,$0b,$d3,$26,$da,$04,$d6,$14,$db,$08,$12,$f3,$e2,$11,$e2,$13,$d2,$47,$01,$06,$df,$02,$df,$02,$e2,$09
    .byte $22,$43,$23,$08,$23,$e2,$11,$0f,$fe,$f2,$f1
    .byte $44,$34,$42,$72,$34,$d7,$28,$dc,$05,$b1,$11,$e2,$13,$d2,$47,$01,$06,$60,$e8,$03,$e6,$05,$e3
    .byte $00

newgameMattsBuySupplies4:
    ; 57 bytes
    .byte $42,$14,$a2,$52,$27,$0f,$d4,$0c,$24,$dc,$3d,$16,$d8,$09,$04,$5b,$e7,$06,$13,$f3,$f1,$2a,$0c,$11,$e2
    .byte $22,$43,$52,$08,$23,$5b,$e7,$d2,$de,$12,$e2,$fe,$f3
    .byte $34,$34,$52,$34,$d7,$28,$dc,$05,$e8,$5b,$e7,$06,$60,$e8,$03,$e6,$05,$e3
    .byte $00

newgameMattsBuySupplies5:
    ; 58 bytes
    .byte $72,$41,$44,$24,$13,$55,$34,$50,$16,$ea,$e2,$1c,$29,$d3,$39,$08,$0a,$35,$e5,$08,$d5,$18,$70,$0d,$19,$0d,$31,$d5,$07,$e8,$03,$52,$1c,$09
    .byte $25,$43,$37,$d7,$02,$08,$3e,$01,$19,$e1,$38,$06,$ee
    .byte $25,$34,$50,$d7,$28,$dc,$05,$a7,$1c,$09
    .byte $00

newgameMattsGoodLuck:
    ; 59 bytes
    .byte $11,$44,$33,$0c,$01,$0b
    .byte $22,$65,$25,$e8,$03,$ea,$e1,$02,$08,$7d,$0a,$12,$0d,$e3
    .byte $13,$44,$d6,$29,$6b,$e4,$50
    .byte $52,$34,$14,$39,$75,$23,$e8,$03,$35,$e5,$08,$db,$09,$d6,$05,$9b,$2c,$d5,$38,$5f,$c6,$03,$44,$21,$d0,$d7,$08,$d3,$13,$e8,$03
    .byte $00

newgameNowLoadingText:
    ; 15 bytes
    .byte $25,$37,$36,$dd,$28,$47,$4d,$04,$d6,$01,$18,$1c,$09,$fb
    .byte $00

newgamePointer:
    .byte <newgameSelectOccupationText,>newgameSelectOccupationText
    .byte <newgameSelectOccupationBanker,>newgameSelectOccupationBanker
    .byte <newgameSelectOccupationCarpenter,>newgameSelectOccupationCarpenter
    .byte <newgameSelectOccupationFarmer,>newgameSelectOccupationFarmer
    .byte <newgameSelectOccupationHelp,>newgameSelectOccupationHelp
    .byte <newgameOccupationHelpText1,>newgameOccupationHelpText1
    .byte <newgameOccupationHelpText2,>newgameOccupationHelpText2
    .byte <newgameNamePartyText1,>newgameNamePartyText1
    .byte <newgameNamePartyText2,>newgameNamePartyText2
    .byte <newgameNamePartyPressStart,>newgameNamePartyPressStart
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
    .byte <newgameMattsBuySupplies1,>newgameMattsBuySupplies1
    .byte <newgameMattsBuySupplies2,>newgameMattsBuySupplies2
    .byte <newgameMattsBuySupplies3,>newgameMattsBuySupplies3
    .byte <newgameMattsBuySupplies4,>newgameMattsBuySupplies4
    .byte <newgameMattsBuySupplies5,>newgameMattsBuySupplies5
    .byte <newgameMattsGoodLuck,>newgameMattsGoodLuck
    .byte <newgameNowLoadingText,>newgameNowLoadingText
