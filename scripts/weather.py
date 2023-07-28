
# Bouchard: [If it rains,] there is a 30% chance that it will be a "heavy" 
# rain (0.8 inches), and a 70% chance that it will be a "light" rain (0.2
# inches). [...] There is one additional twist to the weather model. [...]
# at the beginning of each simulated day, the program decides whether to
# generate "new" weather, or to repeat the previous day's weather. There is a 
# 50% chance of repeating the previous day's weather, and therefore a 50%
# chance that new weather will be generated.

import random

# ; Monthly Total Precipitation, inches * 10
# rainfallTable:
#     ;     Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
#     .byte 13, 14, 26, 34, 48, 48, 38, 40, 42, 30, 19, 15 ; Zone 1
#     .byte 4,  5,  10, 21, 30, 32, 27, 22, 16, 10, 5,  5  ; Zone 2
#     .byte 5,  5,  10, 16, 21, 14, 11, 6,  9,  9,  7,  6  ; Zone 3
#     .byte 5,  7,  12, 23, 25, 13, 8,  6,  11, 14, 8,  6  ; Zone 4
#     .byte 16, 13, 13, 12, 13, 9,  3,  2,  5,  10, 13, 15 ; Zone 5
#     .byte 55, 41, 36, 22, 21, 16, 5,  10, 17, 33, 56, 61 ; Zone 6
rainfall = [
    [13, 14, 26, 34, 48, 48, 38, 40, 42, 30, 19, 15],
    [4,  5,  10, 21, 30, 32, 27, 22, 16, 10, 5,  5],
    [5,  5,  10, 16, 21, 14, 11, 6,  9,  9,  7,  6],
    [5,  7,  12, 23, 25, 13, 8,  6,  11, 14, 8,  6],
    [16, 13, 13, 12, 13, 9,  3,  2,  5,  10, 13, 15],
    [55, 41, 36, 22, 21, 16, 5,  10, 17, 33, 56, 61]
]


months = [31,28,31,30,31,30,31,31,30,31,30,31]
in_per_rainy_day = (0.3 * 8) + (0.7 * 2)
rain_chance = []
for zone in range(6):
    rain_chance.append([])
    for month in range(12):
        rainy_days = rainfall[zone][month] / in_per_rainy_day
        probability = rainy_days / months[month]
        #roll = round(probability * 256)
        rain_chance[zone].append(probability)

print(rain_chance)
    
# maximum RNG roll in order for it to rain, without the "previous day twist":
# [[28, 34, 57, 76, 104, 108, 83, 87, 94, 65, 43, 33],
#  [9, 12, 22, 47, 65, 72, 59, 48, 36, 22, 11, 11],
#  [11, 12, 22, 36, 46, 31, 24, 13, 20, 20, 16, 13],
#  [11, 17, 26, 52, 54, 29, 17, 13, 25, 30, 18, 13],
#  [35, 31, 28, 27, 28, 20, 7, 4, 11, 22, 29, 33],
#  [120, 99, 78, 49, 46, 36, 11, 22, 38, 72, 126, 133]]



samples = 10000
averages = []
for zone in range(6):
    averages.append([])
    for month in range(12):
        total_rain = []
        for i in range(samples):
            month_rain = 0
            rained_last = int(random.random() < rain_chance[zone][month])
            for day in range(months[month]):
                if (random.random() < 0.5):
                    rained_last = int(random.random() < rain_chance[zone][month])
                month_rain += rained_last * in_per_rainy_day

            total_rain.append(month_rain)    
        averages[zone].append(round(sum(total_rain)/samples))

print(averages)

for zone in range(6):
    print([averages[zone][month] - rainfall[zone][month] for month in range(12)])

# maximum RNG roll in order for it to rain, WITH the "previous day twist":
# [[28, 34, 57, 76, 104, 108, 83, 87, 94, 65, 43, 33],
#  [9, 12, 22, 47, 65, 72, 59, 48, 36, 22, 11, 11],
#  [11, 12, 22, 36, 46, 31, 24, 13, 20, 20, 16, 13],
#  [11, 17, 26, 52, 54, 29, 17, 13, 25, 30, 18, 13],
#  [35, 31, 28, 27, 28, 20, 7, 4, 11, 22, 29, 33],
#  [120, 99, 78, 49, 46, 36, 11, 22, 38, 72, 126, 133]]
# it is the same as without the "previous day twist".