; .include "constants.inc"

; .segment "CODE"
; .import main
; .export reset

; .proc reset
;     SEI
;     CLD
;     LDX #$FF
;     TXS
;     INX
;     STX PPUCTRL
;     STX PPUMASK
;     STX DMCFREQ

;     ; initialize variables
;     LDA #$10
;     STA oxenPace
;     LDA #$00
;     STA globalScroll

;     JSR LoadPalette
;     JSR LoadBackground
;     JSR LoadBackgroundAttribute
;     JSR InitOxenSprite
;     JSR InitWagonSprite

; vblankwait1:
;     BIT PPUSTATUS
;     BPL vblankwait1

; clearmemory:
;     LDA #$00
;     STA $0000, X
;     STA $0100, X
;     STA $0300, X
;     STA $0400, X
;     STA $0500, X
;     STA $0600, X
;     STA $0700, X
;     LDA #$FE
;     STA $0200, X
;     INX
;     BNE clearmemory

; vblankwait2:
;     BIT PPUSTATUS
;     BPL vblankwait2

;     LDA #%10010000
;     STA PPUCTRL

;     LDA #%00011110
;     STA PPUMASK

; loadpalettes:
;     LDA PPUSTATUS
;     LDA #$3F
;     STA PPUADDR
;     LDA #$00
;     STA PPUADDR

;     JMP main

; .endproc
