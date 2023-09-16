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

talkPointer:
    .byte <talkIndependence1,>talkIndependence1
    .byte <talkIndependence2,>talkIndependence2
    .byte <talkIndependence3,>talkIndependence3
    .byte <talkKansasRiver1,>talkKansasRiver1
    .byte <talkKansasRiver2,>talkKansasRiver2
    .byte <talkKansasRiver3,>talkKansasRiver3
    .byte <talkBigBlueRiver1,>talkBigBlueRiver1
    .byte <talkBigBlueRiver2,>talkBigBlueRiver2
    .byte <talkBigBlueRiver3,>talkBigBlueRiver3
    .byte <talkFortKearney1,>talkFortKearney1
    .byte <talkFortKearney2,>talkFortKearney2
    .byte <talkFortKearney3,>talkFortKearney3
    .byte <talkChimneyRock1,>talkChimneyRock1
    .byte <talkChimneyRock2,>talkChimneyRock2
    .byte <talkChimneyRock3,>talkChimneyRock3
    .byte <talkFortLaramie1,>talkFortLaramie1
    .byte <talkFortLaramie2,>talkFortLaramie2
    .byte <talkFortLaramie3,>talkFortLaramie3
    .byte <talkIndependenceRock1,>talkIndependenceRock1
    .byte <talkIndependenceRock2,>talkIndependenceRock2
    .byte <talkIndependenceRock3,>talkIndependenceRock3
    .byte <talkSouthPass1,>talkSouthPass1
    .byte <talkSouthPass2,>talkSouthPass2
    .byte <talkSouthPass3,>talkSouthPass3
    .byte <talkFortBridger1,>talkFortBridger1
    .byte <talkFortBridger2,>talkFortBridger2
    .byte <talkFortBridger3,>talkFortBridger3
    .byte <talkGreenRiver1,>talkGreenRiver1
    .byte <talkGreenRiver2,>talkGreenRiver2
    .byte <talkGreenRiver3,>talkGreenRiver3
    .byte <talkSodaSprings1,>talkSodaSprings1
    .byte <talkSodaSprings2,>talkSodaSprings2
    .byte <talkSodaSprings3,>talkSodaSprings3
    .byte <talkFortHall1,>talkFortHall1
    .byte <talkFortHall2,>talkFortHall2
    .byte <talkFortHall3,>talkFortHall3
    .byte <talkSnakeRiver1,>talkSnakeRiver1
    .byte <talkSnakeRiver2,>talkSnakeRiver2
    .byte <talkSnakeRiver3,>talkSnakeRiver3
    .byte <talkFortBoise1,>talkFortBoise1
    .byte <talkFortBoise2,>talkFortBoise2
    .byte <talkFortBoise3,>talkFortBoise3
    .byte <talkBlueMountains1,>talkBlueMountains1
    .byte <talkBlueMountains2,>talkBlueMountains2
    .byte <talkBlueMountains3,>talkBlueMountains3
    .byte <talkFortWallaWalla1,>talkFortWallaWalla1
    .byte <talkFortWallaWalla2,>talkFortWallaWalla2
    .byte <talkFortWallaWalla3,>talkFortWallaWalla3
    .byte <talkTheDalles1,>talkTheDalles1
    .byte <talkTheDalles2,>talkTheDalles2
    .byte <talkTheDalles3,>talkTheDalles3
