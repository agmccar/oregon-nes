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

riverRiverYouMustCross:
    ; 81 bytes
    .byte $52,$34,$53,$52,$52,$80,$e8,$03,$9c,$0f,$d2,$14,$1e,$01,$02,$1b,$02,$04,$07,$d3,$02,$0a,$d2,$09,$e3,$04,$e4,$d4
    .byte $51,$35,$24,$52,$94,$46,$01,$02,$1b,$02,$10,$01,$13,$c1,$04,$e3,$13,$d2,$60,$e1,$0b,$58,$e8,$fb,$fb,$fb,$fb,$83,$11,$26,$14,$1e
    .byte $42,$33,$44,$23,$60,$05,$d3,$fb,$fb,$fb,$83,$11,$69,$18,$04,$01,$12,$37,$6b,$d4
    .byte $00

riverRiverFordOption:
    ; 14 bytes
    .byte $25,$72,$45,$10,$e3,$12,$77,$0a,$d5,$07,$51,$1b,$02
    .byte $00

riverRiverCaulkOption:
    ; 14 bytes
    .byte $25,$55,$35,$79,$5d,$da,$15,$d6,$09,$05,$54,$27,$10
    .byte $00

riverRiverFerryOption:
    ; 13 bytes
    .byte $25,$41,$56,$20,$da,$08,$d5,$02,$38,$26,$14,$1e
    .byte $00

riverRiverWaitOption:
    ; 10 bytes
    .byte $25,$43,$13,$15,$19,$d5,$07,$43,$25
    .byte $00

riverRiverIndianOption:
    ; 16 bytes
    .byte $35,$42,$62,$40,$d7,$3d,$d4,$05,$04,$44,$05,$0a,$d7,$1c,$df
    .byte $00

riverRiverHelpOption:
    ; 16 bytes
    .byte $25,$34,$b0,$d6,$11,$dc,$07,$d4,$04,$d5,$07,$dc,$10,$d8,$09
    .byte $00

riverRiverHelpPage1:
    ; 61 bytes
    .byte $81,$24,$15,$52,$44,$56,$17,$42,$35,$0a,$d5,$07,$d3,$0d,$1b,$02,$8e,$05,$e2,$0a,$7e,$0c,$e8,$03,$e1,$15,$d6,$09,$26,$14,$1e,$47,$2e,$0c,$4b,$df,$0d,$0a,$d5,$01,$02,$1b,$02
    .byte $32,$43,$45,$80,$1a,$01,$01,$48,$e7,$0b,$0f,$d8,$0c,$10,$20,$1f,$0e
    .byte $00

riverRiverHelpPage2:
    ; 67 bytes
    .byte $82,$25,$35,$52,$42,$24,$25,$33,$20,$0a,$79,$5d,$da,$01,$d4,$15,$d6,$09,$8e,$05,$e2,$0a,$e2,$08,$db,$19,$8c,$01,$10,$29,$e6,$10,$02,$d2,$05,$d6,$11,$04
    .byte $52,$35,$34,$27,$64,$14,$01,$d4,$15,$d6,$09,$d2,$05,$01,$0b,$d1,$21,$27,$10,$0e,$26,$14,$1e,$84,$da,$08,$57,$10
    .byte $00

riverRiverHelpPage3:
    ; 86 bytes
    .byte $a2,$23,$15,$52,$34,$52,$32,$14,$44,$72,$74,$e3,$03,$e2,$08,$d5,$02,$38,$8e,$05,$e2,$0a,$7e,$3f,$03,$e1,$15,$d6,$09,$09,$0a,$df,$16,$4e,$db,$10,$57,$10,$01,$10,$d1,$1c,$09,$65,$0a,$e2,$34,$d4,$09,$d4,$1c,$4d
    .byte $62,$35,$23,$54,$44,$56,$35,$01,$48,$71,$02,$16,$01,$21,$02,$38,$1a,$0c,$20,$da,$22,$03,$e1,$15,$d6,$09,$26,$14,$1e,$01,$02,$1b,$02
    .byte $00

riverRiverWait:
    ; 22 bytes
    .byte $42,$34,$43,$53,$13,$e8,$03,$d2,$2d,$df,$dd,$08,$e1,$01,$02,$1b,$02,$d5,$07,$43,$25
    .byte $00

riverRiverNoTroubleFloating:
    ; 27 bytes
    .byte $42,$33,$27,$83,$56,$e8,$03,$2e,$d3,$29,$76,$03,$52,$21,$27,$10,$04,$d6,$01,$d4,$15,$d6,$09,$26,$14,$1e
    .byte $00

riverRiverMuddy:
    ; 32 bytes
    .byte $31,$23,$15,$80,$19,$15,$e2,$2d,$e4,$d3,$5b,$d2,$14,$1e,$04,$d6
    .byte $32,$33,$33,$35,$2a,$3f,$03,$d3,$37,$29,$5e,$11,$0f,$e4,$4f
    .byte $00

riverRiverSuppliesWet:
    ; 23 bytes
    .byte $22,$48,$33,$e8,$03,$6a,$3e,$2f,$d8,$06,$d6,$99,$e6,$11
    .byte $22,$41,$30,$27,$4d,$f2,$d3,$25
    .byte $00

riverRiverStuckMud:
    ; 26 bytes
    .byte $32,$36,$52,$33,$e8,$03,$d1,$17,$34,$06,$90,$4f,$04,$01,$12,$e4,$d3
    .byte $22,$41,$30,$27,$4d,$f2,$d3,$25
    .byte $00

riverRiverFerryBroke:
    ; 29 bytes
    .byte $32,$35,$55,$48,$01,$21,$02,$38,$d1,$14,$da,$1c,$2c,$e2,$21,$14,$dc,$7c,$07,$04,$65
    .byte $15,$35,$e8,$03,$27,$4d,$ee
    .byte $00

riverRiverFerrySafelyAcross:
    ; 29 bytes
    .byte $52,$35,$34,$53,$56,$60,$01,$21,$02,$38,$bf,$3f,$03,$c8,$0d,$3f,$05,$d3,$15,$d6,$09,$e2,$4e,$1c,$e8,$26,$14,$1e
    .byte $00

riverRiverFerryQuestion:
    ; 69 bytes
    .byte $a2,$35,$84,$42,$46,$33,$34,$34,$42,$41,$40,$01,$21,$02,$38,$6d,$02,$10,$07,$e2,$25,$e2,$01,$d0,$01,$d4,$1a,$0c,$1f,$0d,$d6,$22,$03,$fb,$fb,$fb,$05,$d3,$01,$10,$e8,$03,$1a,$0c,$2e,$46,$0a,$15,$19,$fb,$d3,$25,$e2
    .byte $34,$33,$72,$24,$0d,$22,$03,$1a,$0c,$04,$d6,$0a,$6e,$01,$13
    .byte $00

riverRiverIndianOffer:
    ; 61 bytes
    .byte $a2,$18,$54,$42,$44,$45,$63,$52,$83,$14,$28,$d0,$39,$de,$39,$09,$d8,$80,$37,$06,$25,$e2,$01,$d0,$01,$d4,$1a,$0c,$20,$da,$22,$03,$e1,$15,$d6,$09,$26,$14,$1e,$01,$02,$1b,$02,$04,$75,$1f,$05,$d6,$21,$07,$f4,$e2,$11,$e2,$16,$d2,$27,$01,$04,$d6
    .byte $00

riverRiverIndianQuestion:
    ; 18 bytes
    .byte $34,$43,$64,$50,$1a,$0c,$e8,$03,$26,$d2,$18,$e3,$01,$13,$16,$d5,$02
    .byte $00

riverRiverIndianWillHelp:
    ; 34 bytes
    .byte $52,$38,$54,$43,$54,$56,$01,$06,$98,$39,$09,$d8,$80,$37,$d4,$1a,$0c,$d7,$1c,$b2,$03,$d5,$27,$10,$e8,$03,$e1,$15,$d6,$09,$26,$14,$1e
    .byte $00

riverRiverWidthText:
    ; 10 bytes
    .byte $15,$56,$e1,$1b,$02,$1a,$d3,$01,$ee
    .byte $00

riverRiverDepthText:
    ; 10 bytes
    .byte $15,$56,$e1,$1b,$02,$d3,$18,$01,$ee
    .byte $00

riverPointer:
    .byte <riverRiverYouMustCross,>riverRiverYouMustCross
    .byte <riverRiverFordOption,>riverRiverFordOption
    .byte <riverRiverCaulkOption,>riverRiverCaulkOption
    .byte <riverRiverFerryOption,>riverRiverFerryOption
    .byte <riverRiverWaitOption,>riverRiverWaitOption
    .byte <riverRiverIndianOption,>riverRiverIndianOption
    .byte <riverRiverHelpOption,>riverRiverHelpOption
    .byte <riverRiverHelpPage1,>riverRiverHelpPage1
    .byte <riverRiverHelpPage2,>riverRiverHelpPage2
    .byte <riverRiverHelpPage3,>riverRiverHelpPage3
    .byte <riverRiverWait,>riverRiverWait
    .byte <riverRiverNoTroubleFloating,>riverRiverNoTroubleFloating
    .byte <riverRiverMuddy,>riverRiverMuddy
    .byte <riverRiverSuppliesWet,>riverRiverSuppliesWet
    .byte <riverRiverStuckMud,>riverRiverStuckMud
    .byte <riverRiverFerryBroke,>riverRiverFerryBroke
    .byte <riverRiverFerrySafelyAcross,>riverRiverFerrySafelyAcross
    .byte <riverRiverFerryQuestion,>riverRiverFerryQuestion
    .byte <riverRiverIndianOffer,>riverRiverIndianOffer
    .byte <riverRiverIndianQuestion,>riverRiverIndianQuestion
    .byte <riverRiverIndianWillHelp,>riverRiverIndianWillHelp
    .byte <riverRiverWidthText,>riverRiverWidthText
    .byte <riverRiverDepthText,>riverRiverDepthText
