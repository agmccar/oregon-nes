
.proc NewMenuOpened
    ; A-register should contain menuOpen.
    CMP #MENU_NONE      ; which menu was just opened?
    BNE :+
    JMP None
    :
    CMP #MENU_NEWGAME_TYPING
    BNE :+
    JMP NewGameTyping
    :
    CMP #MENU_NEWGAME_OCCUPATION
    BNE :+
    JMP NewGameOccupation
    :
    CMP #MENU_NEWGAME_STARTDATE
    BNE :+
    JMP NewGameStartDate
    :
    CMP #MENU_STORE_ITEM1
    BNE :+
    LDA #7
    PHA
    JMP StoreSubmenu
    :
    CMP #MENU_STORE_ITEM2
    BNE :+
    LDA #7
    PHA
    JMP StoreSubmenu
    :
    CMP #MENU_STORE_ITEM4
    BNE :+
    LDA #6
    PHA
    JMP StoreSubmenu
    :
    CMP #MENU_MAINMENU
    BNE :+
    JMP MainMenu
    :
    CMP #MENU_SUPPLIES
    BNE :+
    JMP Supplies
    :
    CMP #MENU_PACE
    BNE :+
    JMP Pace
    :
    CMP #MENU_RATIONS
    BNE :+
    JMP Rations
    :
    CMP #MENU_REST
    BNE :+
    JMP Rest
    :
    CMP #MENU_TEXTPOPUP
    BNE :+
    JMP TextPopup
    :
    JMP Done
    None:
        LDA #0
        STA fingerLastLastX
        STA fingerLastLastY ; clear LastLast pos since we are NOT in a submenu.
        LDA gameState
        CMP #GAMESTATE_NEWGAME
        BNE :+
        LDA #%00001100      ; both fingers visible, normal, pointing right
        STA fingerAttr
        JSR LoadBgNewGame
        :
        CMP #GAMESTATE_STORE
        BNE :+
        LDA #%00001100      ; both fingers visible, normal, pointing right
        STA fingerAttr
        JSR RedrawFinger
        JSR LoadBgStore
        :
        CMP #GAMESTATE_LANDMARK
        BNE :+
        LDA #%00000000      ; neither finger visible
        STA fingerAttr
        JSR LoadBgLandmark
        :
        CMP #GAMESTATE_TRAVELING
        BNE :+
        LDA #%00000000      ; neither finger visible
        STA fingerAttr
        LDA menuOpenLast
        CMP #MENU_TEXTPOPUP
        BEQ :+
        JSR LoadBgTraveling
        JMP Done
        :
        JMP Done
    NewGameTyping:
        LDA #%00001100      ; both fingers visible, pointing right
        STA fingerAttr
        LDA #0              ; default key to 'A'
        STA keyboardKey
        JSR DrawMenuKeyboard
        LDX #5
        LDY #18
        JSR MoveFingerToSubmenu
        JMP Done
    NewGameOccupation:
        LDA #%00000100      ; only main finger visible, pointing right
        STA fingerAttr
        JSR DrawOccupationMenu
        LDX #15
        LDY #7
        JSR MoveFingerToSubmenu
        JMP Done
    NewGameStartDate:
        LDA #%00000100      ; only main finger visible
        STA fingerAttr
        JSR DrawStartDateSubmenu
        LDX #6
        LDY #21
        JSR MoveFingerToSubmenu
        JMP Done
    StoreSubmenu:
        LDA #%00011100      ; both fingers visible, main finger "up/down" arrows
        STA fingerAttr
        JSR DrawStoreSubmenu
        PLA
        TAX
        LDY fingerY
        JSR MoveFingerToSubmenu
        JMP Done
    MainMenu:
        LDA #%00000100      ; only finger visible, pointing right
        STA fingerAttr
        JSR LoadBgTraveling
        JSR RedrawFinger
        JMP Done
    Supplies:
        LDA #0 ;no fingers visible
        STA fingerAttr
        JSR LoadBgSupplies
        JMP Done
    Pace:
        LDA #%00010100      ; only finger visible, up/down arrow
        STA fingerAttr
        LDX #12
        LDY #17
        JSR MoveFingerToSubmenu
        JSR DrawPaceSubmenu
        JSR RedrawFinger
        JMP Done
    Rations:
        LDA #%00010100      ; only finger visible, up/down arrow
        STA fingerAttr
        LDX #15
        LDY #19
        JSR MoveFingerToSubmenu
        JSR DrawRationsSubmenu
        JSR RedrawFinger
        JMP Done
    Rest:
        LDA #%00010100      ; only finger visible, up/down arrow
        STA fingerAttr
        LDX #15
        LDY #21
        JSR MoveFingerToSubmenu
        JSR DrawRestSubmenu
        JSR RedrawFinger
        JMP Done
    TextPopup:

        JSR BufferDrawTextPopup
        JMP Done
    Done:
    LDA menuOpen
    STA menuOpenLast    ; reset last menu open
    LDA #0
    STA frameCounter    ; reset framecounter
    RTS
.endproc
