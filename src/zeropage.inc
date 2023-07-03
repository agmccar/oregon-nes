;-------------------------------------------------------------------------------
.segment "ZEROPAGE"

pointer:        .res 2
sprite0hit:     .res 1
helper:         .res 1
frameCounter:   .res 1
globalScroll:   .res 1
oxenFrame:      .res 1 ; frame 0=$01; 1=$02; 2=$04, 3=$08, 4=$10
oxenPace:       .res 1 
traveledMi:     .res 2
traveledDigit:  .res 4

; HUD
menuOpen:       .res 1
    ; %00000000
    ;  |||||||+ main menu open
    ;  ||||||+- ?
    ;  |||||+-- unused
    ;  ||||+--- unused
    ;  |||+---- unused
    ;  ||+----- unused
    ;  |+------ unused
    ;  +------- unused
; diaryTextLine1: .res 1 ; 255 available different diary text lines? (see BSS?)

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
dateDigit:      .res 2

; People
personName:    .res 20  ; 4 each, 5 people
personAttrs:   .res 5   ; 1 each
    ; %00000000
    ;  ||||++++ health (healthText($0-$8) + afflictionText($9-$F))
    ;  ++++---- unused

; remaining: $c5

