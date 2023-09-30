; row len, xoffset, yoffset, [row tiles]

riverWagonTopImage:
    .byte 5,3,0,$01,$02,$03,$04,$05
    .byte 5,3,1,$06,$07,$08,$09,$0a
	.byte 0

riverWagonFordImage: ; + riverWagonTopImage
	.byte 3,0,0,$2a,$2b,$2c
	.byte 3,0,1,$1b,$1c,$1d
	.byte 6,2,2,$1e,$1f,$20,$21,$22,$23
	.byte 6,4,3,$24,$25,$26,$27,$28,$29
	.byte 0

riverWagonCaulkImage: ; + riverWagonTopImage
	.byte 6,3,2,$44,$3a,$3b,$3c,$3d,$3e
	.byte 5,5,3,$3f,$40,$41,$42,$43
	.byte 0

riverWagonFerryImage: ; + riverWagonTopImage
	.byte 2,1,1,$68,$69
	.byte 8,1,2,$24,$6a,$6b,$6c,$6d,$61,$62,$63,$64
	.byte 7,3,3,$65,$66,$67,$6e,$6f,$5b,$5c
	.byte 5,5,4,$1e,$5d,$5e,$5f,$60
	.byte 0

riverWagonSunkImage:
	.byte 5,3,0,$70,$71,$72,$73,$74
	.byte 6,3,1,$75,$76,$7d,$7e,$7f,$80
	.byte 7,1,2,$81,$82,$83,$84,$85,$77,$78
	.byte 2,4,3,$79,$7a
	.byte 2,2,4,$7b,$7c
	.byte 0
