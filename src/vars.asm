
dateText:           .res TEXT_DATE_LEN
popupTextLine1:     .res TEXT_POPUP_LINE_LEN
popupTextLine2:     .res TEXT_POPUP_LINE_LEN
textLineHelper:     .res TEXT_POPUP_LINE_LEN
eventQueue:         .res 4
eventQueuePointer:  .res 1

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

; talk text header buffer, word lengths
talkTextBuffer:     .res 32