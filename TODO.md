# TODO


## Title screen

- [x] title screen graphics
- [x] title screen options
    - [x] 1. Travel the trail (new game)
    - [x] 2. Learn about the trail
        - [x] raw text
        - [x] pages
    - [x] 3. See the Oregon Top Ten
        - [x] raw text
        - [x] Top Ten list
        - [x] explanation pages 
    - [x] 4. Turn sound on|off
        - [x] explanation page

## New game screens

- [x] choose occupation menu
- [x] Name party members graphics
- [x] name party members input
- [x] decide which month to leave menu
- [x] independence graphic + text boxes screens

## Matt's general store

- [x] Matts general store intro text/menus
- [x] shop screen graphics
    - [x] matt
    - [x] compress chr tiles 
    - [x] rewrite check supplies screen

## Buy supplies

- [ ] prices increase at each fort
- [ ] Buy supplies screen

## River crossing

- [x] river crossing data tables: depth, width
- [x] river crossing graphics data
- [ ] river crossing graphics implementation
- [ ] river crossing logic

## The Dalles rafting minigame

- [ ] rafting graphics data
- [ ] rafting graphics implementation
- [ ] rafting logic

## Traveling main menu

- [x] fix double reload bug
- [ ] fix palette glitch
- [ ] Conditional options: Talk to people, Hunt, Buy supplies
- [ ] change pace
- [ ] change rations
- [ ] rest for x days

## Traveling screen

- [x] weather/climate data tables
- [x] calculate weather daily
- [ ] traveling screen graphics
    - [x] oxen and wagon graphics
    - [x] animated oxen and wagon on screen
    - [x] landmark sprites
    - [ ] display landmark sprites on screen
- [ ] gravestones
    - [ ] preserve gravestone data on soft resets
- [x] event queue
- [ ] random events logic
  - [x] Indians help find food
  - [x] Severe thunderstorm
  - [x] Severe blizzard
  - [x] Heavy fog
  - [x] Hail storm
  - [x] Injured or dead ox
  - [x] Injured party member (broken arm or leg)
  - [x] Snake bite
  - [x] Lose trail
  - [x] Wrong trail
  - [x] Rough trail
  - [x] Impassible trail
  - [x] Find wild fruit
  - [ ] Fire in the wagon
  - [ ] Lost party member
  - [ ] Ox wanders off
  - [ ] Find an abandoned wagon
  - [ ] Thief comes during the night
  - [x] Bad water
  - [x] Very little water
  - [x] Inadequate grass
  - [x] Illness
  - [ ] Broken wagon part
  - [ ] Snow bound
- [ ] random events graphics
  - [ ] implement
  - [x] Severe thunderstorm
  - [x] Severe blizzard
  - [x] Find wild fruit
  - [x] Fire in the wagon
  - [x] Thief comes during the night
  - [x] Broken wagon part
  - [x] Snow bound
- [ ] grass color
- [x] stop to rest
- [ ] drought events don't pause the game
- [ ] shortcuts

## Map screen

- [x] map graphics (background)
- [ ] trail line
    - [x] trail sprites
    - [ ] shortcuts graphics

## Hunting minigame

- [ ] hunting graphics
    - [x] tile/sprite data
    - [ ] animation code
- [ ] hunting logic
    - [ ] movement
    - [ ] shooting
    - [ ] collisions
    - [ ] timer

## Trade screen

- [ ] trade screen graphics
- [ ] trading logic/RNG

## Talk to people

- [x] text data
- [x] logic (text dependent on location)

## Landmark screen

- [ ] "Would you like to look around?"
- [x] landmark screen graphics
- [x] landmark screen logic
- [ ] fix fort kearney color palette

## Music
- [ ] sound engine
- [ ] Music for each landmark
    - [x] Independence, MO: Yankee Doodle.
    - [ ] Kansas River: I Gave My Love a Cherry
    - [ ] Big Blue River: Oh Dear!  What Can the Matter Be?
    - [ ] Fort Kearney: The Campbells are Coming.
    - [ ] Chimney Rock: Auld Lang Syne.
    - [ ] Fort Laramie: Billy Boy.
    - [ ] Independence Rock:  Wayfaring Stranger.
    - [ ] Fort Bridger:  Where Has My Laddie Gone?  (Blue Bells of Scotland).
    - [ ] Green River Crossing:  All Through the Night
    - [ ] Soda Springs: Charlie Is My Darling
    - [ ] South Pass: Believe Me, Of All Those Endearing Young Charms.
    - [ ] Fort Hall: Skip to My Lou
    - [ ] Snake River Crossing: O Shenandoah.
    - [ ] Fort Boise:  On Top of Old Smokey
    - [ ] Grande Ronde in the Blue Mountains: Long Long Ago
    - [ ] Fort Walla Walla:  Flow Gently Sweet Afton.
    - [ ] The Dalles: Jimmy Crack Corn (Blue Tail Fly)
    - [ ] Willamette Valley:  Viva la compangie (Viva l'amour).
- [ ] (easter egg) annoying 1 channel music if in Monochrome mode?

## Supplies screen

- [x] supplies graphics

## Housekeeping

- [x] move text data to banks 2-6 + move decompression code to bank 7

## Graphics (general)

- [x] Green Only mode
- [x] nametable update buffer
- [x] compress tile and nametable data (PackBits?)

## Polish (nice to have)

- [ ] lowercase letters
- [ ] cursor/finger icon blinks
- [ ] fix Turn sound on/off screen glitch frame
- [ ] original game returns to main menu after a long idle time?
- [ ] MECC loading screen
- [x] ROM1 use meaningful filenames instead of `rom1.asm`
- [x] use `.charmap` instead of `_T_,_H_,_I_,_S_,___,_N_,_O_,_N_,_S_,_E_,_N_,_S_,_E_`
- [ ] don't reload bg at "Before leaving" screens
- [ ] third packbits segment type: run of incrementing bytes (eg 1,2,3,4..)