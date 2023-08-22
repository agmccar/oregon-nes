
; Discharge: cubic feet per second
; Gage height: feet
; Data used: (accessed 2023-08-21)
;   Kansas River: USGS 06889000 KANSAS R AT TOPEKA, KS
;       https://waterdata.usgs.gov/ks/nwis/monthly/?referred_module=sw&amp;site_no=06889000&amp;por_06889000_54994=92437,00060,54994,1917-06,2023-04&amp;site_no=06889000&amp;por_06889000_54995=92437,00065,54995,1987-10,2023-04&amp;format=html_table&amp;date_format=YYYY-MM-DD&amp;rdb_compression=file&amp;submitted_form=parameter_selection_list
;   Big Blue River: USGS 06882510 BIG BLUE R AT MARYSVILLE, KS
;       https://waterdata.usgs.gov/ks/nwis/monthly/?referred_module=sw&amp;site_no=06882510&amp;por_06882510_295066=92386,00060,295066,1984-10,2022-11&amp;site_no=06882510&amp;por_06882510_295067=92386,00065,295067,1987-10,2022-11&amp;format=html_table&amp;date_format=YYYY-MM-DD&amp;rdb_compression=file&amp;submitted_form=parameter_selection_list
;   Green River: USGS 09217000 GREEN RIVER NEAR GREEN RIVER, WY
;       https://waterdata.usgs.gov/wy/nwis/monthly/?referred_module=sw&amp;site_no=09217000&amp;por_09217000_161782=802469,00060,161782,1951-10,2023-05&amp;format=html_table&amp;date_format=YYYY-MM-DD&amp;rdb_compression=file&amp;submitted_form=parameter_selection_list
;   Snake River: USGS 13154500 SNAKE RIVER AT KING HILL ID
;       https://waterdata.usgs.gov/id/nwis/monthly/?referred_module=sw&amp;site_no=13154500&amp;por_13154500_45831=1154606,00060,45831,1909-06,2022-12&amp;format=html_table&amp;date_format=YYYY-MM-DD&amp;rdb_compression=file&amp;submitted_form=parameter_selection_list

riverDischarge:
    ;     Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
    .byte 2390, 3330, 5020, 6530, 8690, 11800, 9220, 5600, 5070, 4160, 3410 ; Kansas
    .byte 392, 617, 1300, 889, 2010, 2300, 1700, 882, 899, 779, 453, 502 ; Big Blue
    .byte 805, 858, 1050, 1520, 2350, 4390, 2890, 1450, 1070, 952, 872, 788 ; Green River
    .byte 10600, 10700, 11100, 12400, 12100, 12400, 8360, 7730, 8600, 10000, 10300, 10400 ; Snake River

riverGageHeight:
    ;     Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
    .byte 6.31, 6.42, 6.88, 7.15, 8.49, 9.14, 8.31, 8.05, 6.79, 6.22, 6.24, 6.72 ; Kansas
    .byte 12.34, 12.71, 12.89, 12.87, 14.36, 15.01, 13.61, 12.76, 12.64, 12.42, 12.13, 12.22 ; Big Blue
    ; No gage height data for Green River
    ; No gage height data for Snake River

; River Notes
; "If the weather were quite rainy in the days just prior to reaching the
; river, then the river should be deeper and swifter (and therefore more
; dangerous) than usual. But if the weather had been dry in the days before
; a river crossing, then the river should be shallower and safer than average."

; "[river model] took into account the amount of recent rainfall on a sliding
; scale - the more recent the rainfall, the greater the impact."

; River variables: width, depth and "speed", "based on the amount of rainfall
; in recent days and constants attached to each river."

; "River bottom type": smooth and firm (BT=0), muddy (BT=1), 
; rocky and uneven (BT=2)

; "the risk of loss in each category of supplies increases linearly as
; the depth increases - and the same goes for the risk of drowning"

; "If the river depth is between 2.5 feet and 3 feet, then you don't lose
; any supplies, and none of the oxen will drown. However, you lose a day of
; time to dry out your supplies."

; Snake
; 05-10 1010 7.4
; 05-13 1003 6.5
; 05-05 1001 6.2
; 05-05 1001 6.2


; Green
; 04-20 402 20.3
; 04-22 431 24.2
; 04-13 402 20.3
; 04-14 400 20.1


; Big Blue
; Muddy
; 03-10 261 6.5
; 03-14 244 4.3
; 03-11 244 4.2
; 03-10 255 5.8


; Kansas
; 03-05 653 8.1
; 03-05 647 7.4
; 03-05 641 6.5
; 03-05 645 7.0
; 03-05 660 9.1

; 03-04 644 6.9
; 03-05 639 6.3
; 03-06 635 5.8
; 03-07 632 5.3 
; 03-08 628 4.9 cool
; 03-09 626 4.5 cool
; 03-10 623 4.1 cool
; 03-11 628 4.8 warm
; 03-12 625 4.4 warm
; 03-13 623 4.1 cool
; 03-14 620 3.8 cold
; 03-15 618 3.5 cold
; 03-16 616 3.3 cool
; 03-17 615 3.0 cool
; 03-18 625 4.4 very rainy
; 03-19 623 4.1 cool
; 03-20 620 3.8 cool
; 03-21 618 3.5 warm
; 03-22 616 3.2 warm
; 03-23 615 3.0 cool
; 03-24 613 2.8 cool
; 03-25 612 2.6 cool
; 03-26 611 2.5 cool
; 03-27 609 2.3 cool
; 03-28 608 2.2 very snowy
; 03-29 611 2.5 rainy
; 03-30 612 2.7 rainy
; 03-31 611 2.6 cool
; 04-01 610 2.4 cool
; 04-02 609 2.3 cool
; 04-03 615 3.1 hot
; 04-04 621 3.9 hot
; 04-05 619 3.6 warm
; 04-06 617 3.4 warm
; 04-07 615 3.1 cool
; 04-08 614 2.9 cool
; 04-09 612 2.7 warm
; 04-10 611 2.6 warm
; 04-11 610 2.4 hot
; 04-12 609 2.3 hot
; 04-13 608 2.1 hot
; 04-14 607 2.0 hot
; 04-15 606 1.9 cool
; 04-16 606 1.8 cool
; 04-17 605 1.7 cool
; 04-18 605 1.7 warm
; 04-19 604 1.6 hot
; 04-20 604 1.5 warm
; 04-21 603 1.5 hot
; 04-22 603 1.4 hot
; 04-23 602 1.4 hot
; 04-24 602 1.4 warm
; 04-25 602 1.3 cool
; 04-26 602 1.3 cool
; 04-27 601 1.3 cool
; 04-28 601 1.2 cool
; 04-29 601 1.2 cool
; 04-30 604 1.6 rainy
; 05-01 606 1.9 rainy
; 05-02 618 3.4 very rainy
; 05-03 619 3.6 rainy
; 05-04 617 3.3 warm
; 05-05 615 3.1 warm
; 05-06 614 2.9 cool
; 05-07 612 2.7 warm
; 05-08 611 2.5 warm
; 05-09 610 2.4 warm
; 05-10 609 2.2 warm
; 05-11 611 2.5 rainy
; 05-12 613 2.8 rainy
; 05-13 614 3.0 rainy
; 05-14 613 2.8 hot
; 05-15 612 2.6 hot
; 05-16 610 2.4 hot
; 05-17 609 2.3 hot
; 05-18 608 2.2 hot
; 05-19 607 2.1 warm
; 05-20 607 2.0 warm
; 05-21 606 1.9 warm
; 05-22 605 1.8 warm
; 05-23 605 1.7 warm
; 05-24 604 1.6 warm
; 05-25 604 1.6 hot
; 05-26 606 1.9 rainy
; 05-27 606 1.8 warm
; 05-28 605 1.7 warm
; 05-29 604 1.7 warm
; 05-30 604 1.6 warm
; 05-31 604 1.5 warm
; 06-01 603 1.5 warm
; 06-02 603 1.4 warm
; 06-03 602 1.4 warm
; 06-04 602 1.4 hot
; 06-05 602 1.3 hot
; 06-06 605 1.7 rainy
; 06-07 607 2.0 rainy
; 06-08 606 1.9 hot
; 06-09 606 1.8 hot
; 06-10 605 1.7 warm
; 06-11 604 1.7 hot
; 06-12 607 2.0 rainy
; 06-13 606 1.9 hot
; 06-14 609 2.2 rainy
; 06-15 608 2.1 hot
; 06-16 607 2.0 hot
; 06-17 606 1.9 hot
; 06-18 605 1.8 hot
; 06-19 605 1.7 very hot
; 06-20 604 1.6 warm
; 06-21 604 1.6 hot
; 06-22 603 1.5 warm
; 06-23 603 1.5 hot
; 06-24 603 1.4 very hot
; 06-25 602 1.4 very hot
; 06-26 602 1.3 warm
; 06-27 602 1.3 warm
; 06-28 602 1.3 warm
; 06-29 601 1.2 hot
; 06-30 601 1.2 hot
; 07-01 601 1.2 warm
; 07-02 601 1.2 warm
; 07-03 601 1.2 warm
; 07-04 601 1.1 warm
; 07-05 600 1.1 warm
; 07-06 600 1.1 warm
; 07-07 600 1.1 hot
; 07-08 600 1.1 hot
; 07-09 600 1.1 hot
; 07-10 600 1.1 hot
; 07-11 600 1.1 hot
; 07-12 600 1.1 very hot
; 07-13 600 1.1 very hot
; 07-14 600 1.1 very hot
; 07-15 600 1.0 warm
; 07-16 600 1.0 very hot
; 07-17 600 1.0 very hot
; 07-18 600 1.0 hot
; 07-19 600 1.0 hot
; 07-20 600 1.0 hot
; 07-21 600 1.0 hot
; 07-22 600 1.0 hot 
; 07-23 600 1.0 hot
; 07-24 600 1.0 hot
; 07-25 600 1.0 hot
; 07-26 600 1.0 hot
; 07-27 600 1.0 hot
; 07-28 600 1.0 hot
; 07-29 600 1.0 hot
; 07-30 600 1.0 very hot
; 07-31 600 1.0 very hot
; 08-01 600 1.0 hot
; 08-02 600 1.0 hot
; 08-03 600 1.0 hot
; 08-04 600 1.0 hot
; 08-05 600 1.0 hot
; 08-06 600 1.0 hot
; 08-07 600 1.0 hot
; 08-08 600 1.0 hot
; 08-09 600 1.0 hot
; 08-10 603 1.4 rainy
; 08-11 614 3.0 very rainy
; 08-12 613 2.8 warm
; 08-13 611 2.6 hot
; 08-14 610 2.4 hot
; 08-15 609 2.3 hot
; 08-16 608 2.2 hot
; 08-17 607 2.0 warm
; 08-18 607 1.9 warm
; 08-19 606 1.8 warm
; 08-20 605 1.8 warm
; 08-21 605 1.7 very hot
; 08-22 604 1.6 very hot
; 08-23 604 1.6 hot
; 08-24 603 1.5 warm
; 08-25 603 1.4 warm
; 08-26 603 1.4 very hot
; 08-27 602 1.4 very hot
; 08-28 602 1.3 very hot
; 08-29 602 1.3 very hot
; 08-30 601 1.3 very hot
; 08-31 601 1.2 hot
; 09-01 601 1.2 hot
; 09-02 601 1.2 warm
; 09-03 601 1.2 warm
; 09-04 601 1.2 warm
; 09-05 601 1.1 hot
; 09-06 600 1.1 hot
; 09-07 600 1.1 hot
; 09-08 600 1.1 hot
; 09-09 600 1.1 hot
; 09-10 612 2.7 very rainy
; 09-11 614 2.9 rainy
; 09-12 615 3.1 rainy
; 09-13 626 4.5 very rainy
; 09-14 623 4.2 warm
; 09-15 621 3.8 warm
; 09-16 619 3.6 warm
; 09-17 617 3.3 hot
; 09-18 615 3.1 hot
; 09-19 613 2.9 hot
; 09-20 612 2.7 hot
; 09-21 611 2.5 hot
; 09-22 610 2.4 warm
; 09-23 609 2.2 warm
; 09-24 620 3.7 very rainy
; 09-25 618 3.4 warm
; 09-26 616 3.2 warm
; 09-27 614 3.0 warm
; 09-28 613 2.8 warm
; 09-29 611 2.6 warm
; 09-30 610 2.4 warm
; 10-01 609 2.3 warm
; 10-02 608 2.2 warm
; 10-03 607 2.0 warm
; 10-04 610 2.3 rainy
; 10-05 609 2.2 cool
; 10-06 608 2.1 cool
; 10-07 607 2.0 cool
; 10-08 606 1.9 hot
; 10-09 605 1.8 warm
; 10-10 605 1.7 warm
; 10-11 604 1.6 hot
; 10-12 604 1.6 hot
; 10-13 603 1.5 hot
; 10-14 603 1.5 hot
; 10-15 603 1.4 warm
; 10-16 602 1.4 warm
; 10-17 602 1.3 warm
; 10-18 602 1.3 hot
; 10-19 602 1.3 hot
; 10-20 601 1.2 warm
; 10-21 601 1.2 cool
; 10-22 601 1.2 cool
; 10-23 601 1.2 cool
; 10-24 601 1.2 hot
; 10-25 601 1.1 hot
; 10-26 600 1.1 hot
; 10-27 600 1.1 hot
; 10-28 600 1.1 warm
; 10-29 600 1.1 warm
; 10-30 600 1.1 warm
; 10-31 612 2.7 very rainy
; 11-01 611 2.5 warm
; 11-02 610 2.4 warm
; 11-03 609 2.2 warm
; 11-04 608 2.1 cool
; 11-05 607 2.0 cool
; 11-06 606 1.9 warm
; 11-07 606 1.8 warm
; 11-08 605 1.7 warm
; 11-09 604 1.7 warm
; 11-10 604 1.6 warm
; 11-11 603 1.5 warm
; 11-12 603 1.5 warm
; 11-13 603 1.4 cool
; 11-14 602 1.4 warm
; 11-15 602 1.3 warm
; 11-16 602 1.3 warm
; 11-17 602 1.3 warm
; 11-18 601 1.3 warm
; 11-19 601 1.2 warm
; 11-20 601 1.2 warm
; 11-21 601 1.2 cool
; 11-22 601 1.2 cool
; 11-23 601 1.1 cool
; 11-24 601 1.1 cool
; 11-25 600 1.1 cool
; 11-26 600 1.1 cool
; 11-27 600 1.1 snowy
; 11-28 608 2.1 warm
; 11-29 607 2.0 warm
; 11-30 606 1.9 cool
; 12-01 605 1.8 cool
; 12-02 605 1.7 warm
; 12-03 604 1.6 cool
; 12-04 604 1.6 cool
; 12-05 603 1.5 cool
; 12-06 603 1.5 cool
; 12-07 603 1.4 cool
; 12-08 602 1.4 cool
; 12-09 602 1.3 cool
; 12-10 602 1.3 cool
; 12-11 602 1.3 cold
; 12-12 601 1.2 cool
; 12-13 601 1.2 cool
; 12-14 601 1.2 cold
; 12-15 601 1.2 cool
; 12-16 601 1.2 cold
; 12-17 601 1.1 cold
; 12-18 600 1.1 cold
; 12-19 600 1.1 cold
; 12-20 600 1.1 cool
; 12-21 600 1.1 cold
; 12-22 600 1.1 cold
; 12-23 600 1.1 cold
; 12-24 600 1.1 cold
; 12-25 600 1.1 cold
; 12-26 600 1.1 cold
; 12-27 600 1.1 cold
; 12-28 600 1.0 cold
; 12-29 600 1.0 cold
; 12-30 600 1.0 cold
; 12-31 600 1.0 cold
; 01-01 600 1.0 cool
; 01-02 600 1.0 cool
; 01-03 600 1.0 cool
; 01-04 600 1.0 cool
; 01-05 600 1.0 cool
; 01-06 600 1.0 cool
; 01-07 600 1.0 cold
; 01-08 600 1.0 cool
; 01-09 600 1.0 cool
; 01-10 600 1.0 cool
; 01-11 600 1.0 cool
; 01-12 600 1.0 cool
; 01-13 600 1.0 cool
; 01-14 600 1.0 cool
; 01-15 600 1.0 cool
; 01-16 600 1.0 cold
; 01-16 600 1.0 cool
; 01-16 600 1.0 cool
; 01-16 600 1.0 cool
; 01-16 600 1.0 cool
; 01-16 600 1.0 cool
; 01-16 600 1.0 cool
; 01-16 600 1.0 cool
; 01-16 600 1.0 cool
; 01-16 600 1.0 cool
; 01-16 600 1.0 cold
; 01-16 600 1.0 cold
; 01-16 600 1.0 cold
; 01-16 600 1.0 cold
; 01-16 600 1.0 cold
; 01-16 600 1.0 cold
; 01-16 603 1.4 rainy
; 02-02 602 1.4 cold
; 02-03 602 1.3 cool
; 02-04 602 1.3 cool
; 02-05 601 1.3 cool
; 02-06 601 1.2 cool
; 02-07 601 1.2 cool
; 02-08 601 1.2 snowy
; 02-09 601 1.2 snowy
; 02-10 601 1.2 snowy
; 02-11 601 1.1 cool
; 02-12 600 1.1 cool
; 02-13 608 2.1 warm
; 02-14 607 2.0 warm
; 02-15 606 1.9 warm
; 02-16 606 1.8 warm
; 02-17 605 1.7 cold
; 02-18 604 1.7 cool
; 02-19 604 1.6 warm
; 02-20 603 1.5 cool
; 02-21 603 1.5 cold
; 02-22 603 1.4 cool
; 02-23 602 1.4 cold
; 02-24 602 1.3 cold
; 02-25 602 1.3 cold
; 02-26 602 1.3 warm
; 02-27 601 1.3 cool
; 02-28 601 1.2 cool