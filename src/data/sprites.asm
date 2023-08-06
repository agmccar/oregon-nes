; 4 byte per object: 
;   +Y
;   tile index
;   attributes
;   +X

; 76543210  OAM Attributes
; ||||||||
; ||||||++- Palette (4 to 7) of sprite
; |||+++--- Unimplemented (read 0)
; ||+------ Priority (0: in front of background; 1: behind background)
; |+------- Flip sprite horizontally
; +-------- Flip sprite vertically

; oxenSprites:
;     ; +Y, tile index, attributes, +X
;     .byte $1F, $20, $00, $B8 ;$A0 ; tile 0   0 1
;     .byte $1F, $21, $00, $C0 ;$A8 ; tile 1   2 3 4 5
;     .byte $27, $22, $00, $B8 ;$A0 ; tile 2   6 7 8 9
;     .byte $27, $23, $00, $C0 ;$A8 ; tile 3
;     .byte $27, $24, $00, $C8 ;$B0 ; tile 4
;     .byte $27, $29, $00, $D0 ;$B8 ; tile 5
;     .byte $2F, $2B, $00, $B8 ;$A0 ; tile 6
;     .byte $2F, $2F, $00, $C0 ;$A8 ; tile 7
;     .byte $2F, $34, $00, $C8 ;$B0 ; tile 8
;     .byte $2F, $39, $00, $D0 ;$B8 ; tile 9

trailSprites: ; without shortcuts
    ; +Y, tile index, attributes, +X
    .byte 21*8, $BE, 0, 29*8 ; Independence
    .byte 21*8, $BD, 0, 28*8
    .byte 20*8, $BC, 0, 27*8
    .byte 19*8, $BB, 0, 26*8
    .byte 19*8, $BA, 0, 25*8
    .byte 19*8, $B9, 0, 24*8
    .byte 19*8, $B8, 0, 23*8
    .byte 19*8, $B7, 0, 22*8
    .byte 18*8, $B6, 0, 21*8
    .byte 18*8, $B5, 0, 20*8
    .byte 18*8, $B4, 0, 19*8
    .byte 17*8, $B2, 0, 19*8
    .byte 17*8, $B1, 0, 18*8
    .byte 16*8, $A6, 0, 18*8
    .byte 16*8, $AE, 0, 17*8
    .byte 17*8, $B0, 0, 16*8
    .byte 18*8, $B0, 0, 15*8
    .byte 18*8, $B3, 0, 14*8
    .byte 17*8, $AF, 0, 14*8
    .byte 16*8, $AD, 0, 13*8
    .byte 16*8, $AC, 0, 12*8
    .byte 16*8, $AB, 0, 11*8
    .byte 16*8, $AA, 0, 10*8
    .byte 16*8, $A9, 0, 9*8
    .byte 15*8, $A6, 0, 9*8
    .byte 15*8, $A9, 0, 8*8
    .byte 14*8, $A6, 0, 8*8
    .byte 14*8, $A9, 0, 7*8
    .byte 13*8, $A8, 0, 7*8
    .byte 12*8, $A6, 0, 7*8
    .byte 12*8, $A5, 0, 6*8
    .byte 12*8, $A4, 0, 5*8
    .byte 13*8, $A7, 0, 4*8