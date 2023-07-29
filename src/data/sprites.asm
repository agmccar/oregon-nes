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

oxenSprites:
    ; +Y, tile index, attributes, +X
    .byte $1F, $20, $00, $B8 ;$A0 ; tile 0   0 1
    .byte $1F, $21, $00, $C0 ;$A8 ; tile 1   2 3 4 5
    .byte $27, $22, $00, $B8 ;$A0 ; tile 2   6 7 8 9
    .byte $27, $23, $00, $C0 ;$A8 ; tile 3
    .byte $27, $24, $00, $C8 ;$B0 ; tile 4
    .byte $27, $29, $00, $D0 ;$B8 ; tile 5
    .byte $2F, $2B, $00, $B8 ;$A0 ; tile 6
    .byte $2F, $2F, $00, $C0 ;$A8 ; tile 7
    .byte $2F, $34, $00, $C8 ;$B0 ; tile 8
    .byte $2F, $39, $00, $D0 ;$B8 ; tile 9

oxenAnimation:
    ; how much to increment each tile
    ; 76543210
    ; |||||||+- frame 0(unused)
    ; ||||||+-- frame 1
    ; |||||+--- frame 2
    ; ||||+---- frame 3
    ; |||+----- frame 4
    ; ||+------ increment cumulatively y/n
    ; ++------- unused
    .byte %00100000 ; tile 0: 20,20,20,20,20
    .byte %00100000 ; tile 1: 21,21,21,21,21
    .byte %00100000 ; tile 2: 22,22,22,22,22
    .byte %00100000 ; tile 3: 23,23,23,23,23
    .byte %00111110 ; tile 4: 24,25,26,27,28
    .byte %00110000 ; tile 5: 29,29,29,29,2A ! todo %00000010
    .byte %00110110 ; tile 6: 2C,2D,2E,2E,2F
    .byte %00111110 ; tile 7: 30,31,32,33,34
    .byte %00111110 ; tile 8: 35,36,37,38,39
    .byte %00111110 ; tile 9: 3A,3B,3C,3D,3E

wagonSprites:
    ; +Y, tile index, attributes, +X
    .byte $1F, $3E, $00, $D8 ; tile 0   0 1 2 3
    .byte $1F, $3F, $00, $E0 ; tile 1   4 5 6 7
    .byte $1F, $40, $00, $E8 ; tile 2   8 9 A B
    .byte $1F, $41, $00, $F0 ; tile 3
    .byte $27, $42, $00, $D8 ; tile 4
    .byte $27, $43, $00, $E0 ; tile 5 (2 frame animation)
    .byte $27, $45, $00, $E8 ; tile 6 (2 frame animation)
    .byte $27, $47, $00, $F0 ; tile 7 (2 frame animation)
    .byte $2F, $49, $00, $D8 ; tile 8 (2 frame animation)
    .byte $2F, $4B, $00, $E0 ; tile 9 (2 frame animation)
    .byte $2F, $4D, $00, $E8 ; tile A (2 frame animation)
    .byte $2F, $4F, $00, $F0 ; tile B (2 frame animation)
