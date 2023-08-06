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
    .byte 18*8, $C2, 1, 29*8 ; "START"
    .byte 18*8, $C3, 1, 30*8
    .byte 18*8, $C4, 1, 31*8
    .byte 11*8, $C5, 1, 0*8 ; "FINISH"
    .byte 11*8, $C6, 1, 1*8
    .byte 11*8, $C7, 1, 2*8
    .byte 19*8, $BE, 0, 29*8 ; Independence to Kansas River
    .byte 19*8, $BD, 0, 28*8
    .byte 18*8, $BC, 0, 27*8 ; Kansas River to Big Blue River
    .byte 17*8, $BB, 0, 26*8 ; Big Blue River to Fort Kearney
    .byte 17*8, $BA, 0, 25*8
    .byte 17*8, $B9, 0, 24*8
    .byte 17*8, $B8, 0, 23*8 ; Fort Kearney to Chimney Rock
    .byte 17*8, $B7, 0, 22*8
    .byte 16*8, $B6, 0, 21*8 ; Chimney Rock to Fort Laramie
    .byte 16*8, $B5, 0, 20*8
    .byte 16*8, $B4, 0, 19*8
    .byte 15*8, $B2, 0, 19*8 ; Fort Laramie to Independence Rock
    .byte 15*8, $B1, 0, 18*8
    .byte 14*8, $A6, 0, 18*8
    .byte 14*8, $AE, 0, 17*8 ; Independence Rock to South Pass
    .byte 15*8, $B0, 0, 16*8
    .byte 16*8, $B0, 0, 15*8 ; South Pass to Fort Bridger
    .byte 16*8, $B3, 0, 14*8 ; Fort Bridger to Soda Springs
    .byte 15*8, $AF, 0, 14*8
    .byte 14*8, $AD, 0, 13*8 ; Soda Springs to Fort Hall 
    .byte 14*8, $AC, 0, 12*8
    .byte 14*8, $AB, 0, 11*8 ; Fort Hall to Snake River
    .byte 14*8, $AA, 0, 10*8
    .byte 14*8, $A9, 0, 9*8 ; Snake River to Fort Boise
    .byte 13*8, $A6, 0, 9*8
    .byte 13*8, $A9, 0, 8*8
    .byte 12*8, $A6, 0, 8*8 ; Fort Boise to Blue Mountains
    .byte 12*8, $A9, 0, 7*8
    .byte 11*8, $A8, 0, 7*8 ; Blue Mountains to Fort Walla Walla
    .byte 10*8, $A6, 0, 7*8
    .byte 10*8, $A5, 0, 6*8 ; Fort Walla Walla to The Dalles
    .byte 10*8, $A4, 0, 5*8
    .byte 11*8, $A7, 0, 4*8 ; The Dalles to WIllamette Valley (toll road)
    .byte 20*8, $A2, 0, 25*8 ; []
    .byte 20*8, $C8, 1, 26*8 ; Fo
    .byte 20*8, $C9, 1, 27*8 ; rt
    .byte 20*8, $CA, 1, 28*8 ; s
    .byte 21*8, $A3, 0, 25*8 ; *
    .byte 21*8, $CB, 1, 26*8 ; La
    .byte 21*8, $CC, 1, 27*8 ; nd
    .byte 21*8, $CD, 1, 28*8 ; ma
    .byte 21*8, $CE, 1, 29*8 ; rk
    .byte 21*8, $CA, 1, 30*8 ; s
    .byte 22*8, $AB, 0, 25*8 ; _
    .byte 22*8, $CF, 1, 26*8 ; Yo
    .byte 22*8, $D0, 1, 27*8 ; ur
    .byte 22*8, $D1, 1, 28*8 ;  r
    .byte 22*8, $D2, 1, 29*8 ; ou
    .byte 22*8, $D3, 1, 30*8 ; te
    .byte 23*8, $D4, 1, 26*8 ; Ri
    .byte 23*8, $D5, 1, 27*8 ; ve
    .byte 23*8, $D6, 1, 28*8 ; rs
    .byte 24*8, $D7, 1, 26*8 ; Mo
    .byte 24*8, $D8, 1, 27*8 ; un
    .byte 24*8, $D9, 1, 28*8 ; ta
    .byte 24*8, $DA, 1, 29*8 ; in
    .byte 24*8, $CA, 1, 30*8 ; s