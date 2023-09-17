
resetSentinal:      .res 6 ; sentinal value to detect hard or soft reset 

; %00000000
;  |||||||+ Color: 0:full color, 1:monochrome
;  |++++++- unused
;  +------- Sound on/off
gameSettings:       .res 1

oregonTopTen:       .res 10*(8+2) ; 10 x (8-letter name + 16 bits for score)
gravestone:         .res 8+32 ; name + epitaph 

;----------- above this line, memory is preserved on soft reset

dateText:           .res TEXT_DATE_LEN
popupTextLine1:     .res TEXT_POPUP_LINE_LEN
popupTextLine2:     .res TEXT_POPUP_LINE_LEN
textLineHelper:     .res TEXT_POPUP_LINE_LEN
eventQueue:         .res 4
eventQueuePointer:  .res 1
personName:         .res 5*8  ; 8 chars * 5 people

; Nametable buffer
;   byte    0 = length of data (0 = no more data)
;   byte    1 = high byte of target PPU address
;   byte    2 = low byte of target PPU address
;   bytes 3-X = the data to draw (number of bytes determined by the length)
; If the drawing buffer contains the following data:
;  05 20 16 CA AB 00 EF 05 01 2C 01 00 00 
;   | \___/ \____________/  | \___/  |  |
;   |   |         |         |   |    |  |
;   |   |         |         |   |    |  length (0, so no more)
;   |   |         |         |   |    byte to copy
;   |   |         |         |   PPU Address $2C01
;   |   |         |         length=1
;   |   |         bytes to copy
;   |   PPU Address $2016
;   length=5
nametableBuffer:    .res 64

talkTextBuffer:     .res 32 ; buffer to store talk text word lengths
wordBuffer:         .res 16 ; buffer to store talk text words 
