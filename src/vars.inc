;-------------------------------------------------------------------------------
.segment "BSS"

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