; HUD text variables
diaryTextLine1:     .res TEXT_DIARY_LINE_LEN
diaryTextLine2:     .res TEXT_DIARY_LINE_LEN
diaryTextLine3:     .res TEXT_DIARY_LINE_LEN
diaryTextLine4:     .res TEXT_DIARY_LINE_LEN
;;;; are these necessary? or is it OK to generate them every frame?
; weatherTextLine1:   .res TEXT_WEATHER_LEN
; weatherTextLine2:   .res TEXT_WEATHER_LEN
; temperatureText:    .res TEXT_TEMP_LEN
; healthText:         .res TEXT_HEALTH_LEN 
; foodText:           .res TEXT_FOOD_LEN
; traveledText:       .res TEXT_TRAVELED_LEN
; dateText:           .res TEXT_DATE_LEN


nametableBuffer:    .res 256
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
