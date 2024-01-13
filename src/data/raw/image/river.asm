; TODO compress
; row len, xoffset, yoffset, [row tiles]

riverWagonTopImage:
    .byte 5,3,0,$24,$25,$26,$27,$28
    .byte 5,3,1,$2c,$2d,$2e,$2f,$30
	.byte 0

riverWagonFordImage: ; + riverWagonTopImage
	.byte 3,0,0,$21,$22,$23
	.byte 3,0,1,$29,$2a,$2b
	.byte 6,2,2,$31,$32,$33,$34,$35,$36
	.byte 6,4,3,$37,$38,$39,$3a,$3b,$3c
	.byte 0

riverWagonCaulkImage: ; + riverWagonTopImage
	.byte 6,3,2,$3d,$3e,$3f,$40,$41,$42
	.byte 5,5,3,$43,$44,$45,$46,$47
	.byte 0

riverWagonFerryImage: ; + riverWagonTopImage
	.byte 2,1,1,$48,$49
	.byte 8,1,2,$37,$4a,$4b,$4c,$4d,$4e,$4f,$50,$51
	.byte 7,3,3,$52,$53,$54,$55,$56,$57,$58
	.byte 5,5,4,$31,$59,$5a,$5b,$5c
	.byte 0

riverWagonSunkImage:
	.byte 5,3,0,$5d,$5e,$5f,$60,$61
	.byte 6,3,1,$62,$63,$64,$65,$66,$67
	.byte 7,1,2,$68,$69,$6a,$6b,$6c,$6d,$6e
	.byte 2,4,3,$6f,$70
	.byte 2,2,4,$71,$72
	.byte 0