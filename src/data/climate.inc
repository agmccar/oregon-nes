; Zone 1: Independence to Fort Kearney
;   Based on data for Kansas City, Missouri

; Zone 2: Fort Kearney to Fort Laramie
;   Based on data for North Platte, Nebraska

; Zone 3: Fort Laramie to Independence Rock
;   Based on data for Casper, Wyoming

; Zone 4: Independence Rock to Fort Hall
;   Based on data for Lander, Wyoming

; Zone 5: Fort Hall to The Dalles
;   Based on data for Boise, Idaho

; Zone 6: The Dalles to Willamette Valley
;   Based on data for Portland, Oregon

; source https://www.weather.gov/wrh/climate
; averages over date range [por,1985]

; Monthly Mean Avg Temperature, degrees Fahrenheit
temperatureTable:
    ;     Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
    .byte 29, 33, 43, 55, 65, 74, 79, 78, 70, 59, 44, 33 ; Zone 1
    .byte 23, 28, 36, 49, 59, 68, 75, 73, 63, 51, 37, 27 ; Zone 2
    .byte 22, 27, 32, 42, 52, 62, 71, 69, 58, 47, 33, 26 ; Zone 3
    .byte 19, 24, 32, 43, 52, 62, 69, 67, 57, 45, 31, 21 ; Zone 4
    .byte 29, 35, 42, 50, 58, 65, 74, 72, 62, 52, 40, 32 ; Zone 5
    .byte 39, 43, 46, 51, 57, 62, 68, 68, 63, 54, 46, 41 ; Zone 6

; Monthly Total Precipitation, inches * 10
rainfallTable:
    ;     Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
    .byte 13, 14, 26, 34, 48, 48, 38, 40, 42, 30, 19, 15 ; Zone 1
    .byte 4,  5,  10, 21, 30, 32, 27, 22, 16, 10, 5,  5  ; Zone 2
    .byte 5,  5,  10, 16, 21, 14, 11, 6,  9,  9,  7,  6  ; Zone 3
    .byte 5,  7,  12, 23, 25, 13, 8,  6,  11, 14, 8,  6  ; Zone 4
    .byte 16, 13, 13, 12, 13, 9,  3,  2,  5,  10, 13, 15 ; Zone 5
    .byte 55, 41, 36, 22, 21, 16, 5,  10, 17, 33, 56, 61 ; Zone 6

    ; 1.30, 1.42, 2.58, 3.38, 4.77, 4.78, 3.85, 4.00, 4.16, 3.04, 1.93, 1.47
    ; 0.40, 0.48, 0.97, 2.08, 3.01, 3.24, 2.74, 2.15, 1.55, 1.04, 0.54, 0.50
    ; 0.54, 0.52, 0.96, 1.57, 2.11, 1.35, 1.11, 0.62, 0.88, 0.91, 0.74, 0.59
    ; 0.50, 0.67, 1.20, 2.26, 2.47, 1.30, 0.78, 0.55, 1.08, 1.35, 0.79, 0.62
    ; 1.59, 1.30, 1.31, 1.19, 1.27, 0.90, 0.26, 0.25, 0.54, 1.02, 1.30, 1.47
    ; 5.51, 4.09, 3.61, 2.25, 2.09, 1.63, 0.54, 1.00, 1.73, 3.29, 5.55, 6.13