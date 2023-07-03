;-------------------------------------------------------------------------------
.segment "ZEROPAGE"

; Engine
pointer:        .res 2
sprite0hit:     .res 1
helper:         .res 1
frameCounter:   .res 1
globalScroll:   .res 1
gameState:      .res 1 

; Graphics
oxenFrame:      .res 1 ; frame 0=$01; 1=$02; 2=$04, 3=$08, 4=$10 (a hack)

; Wagon
wagonStatus:    .res 1
    ; %00000000
    ;  |||||||+ Speed- 0:stopped, 1:moving
    ;  ||||||+- Trail- 0:at landmark, 1:on the trail 
    ;  ||||++-- unused
    ;  ++++---- Remaining rest/delay (days)- 0-15   
wagonSettings:  .res 1 
    ; %00000000
    ;  ||||||++ Pace- 00:unused, 01:steady, 10:strenuous, 11:grueling
    ;  ||||++-- Rations- 00:unused, 01:bare bones, 10:meager, 11:filling
    ;  |||+---- Rest- 0:not resting, 1:resting
    ;  ||+----- unused
    ;  |+------ unused
    ;  +------- unused

; HUD
traveledMi:     .res 2
traveledDigit:  .res 4
menuOpen:       .res 1
    ; $00: all menus closed
    ; $01: main menu open
    ; $02: status menu open
    ; $03: rations menu open
    ; $04: pace menu open
    ; $05: rest menu open
    ; $06: options menu open
    ; $07: 
    ; $08: ...

; Conditions
weather:        .res 1
    ; %00000000
    ;  ||||++++ current (calculated/generated) temperature
    ;  ++++---- current weather type

; Controller input
buttons1:       .res 1

; Supplies
dollars:        .res 2 
foodLbs:        .res 2 
foodDigit:      .res 4
clothingSets:   .res 1
bullets:        .res 2
spareParts:     .res 1 
    ; %00000000
    ;  ||||||++ wagon wheels
    ;  ||||++-- wagon axles
    ;  ||++---- wagon tongues
    ;  ++------ unused
oxenHeadcount:  .res 1

; Calendar
dateYear:       .res 1
dateMonth:      .res 1
dateDay:        .res 1

; People
personName:    .res 20  ; 4 each, 5 people
personAttrs:   .res 5   ; 1 each
    ; %00000000
    ;  ||||++++ health (healthText($0-$8) + afflictionText($9-$F))
    ;  ++++---- unused

; remaining: $c4

