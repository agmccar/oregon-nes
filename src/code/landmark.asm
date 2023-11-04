
.proc GetLandmarkText
    ; @param X: location index
    ; @return helper2: length of text
    ; clobbers all registers, helper

    STX helper+1
    LDX #0
    LDY #0
    STX helper
    LDA locationNameText, X
    STA helper2
    :
    CPY helper+1
    BNE :+
    JMP :+++
    :
    LDX #0
    :
    INX
    CPX helper2
    BNE :-
    CLC
    ADC helper
    STA helper
    INC helper
    LDX helper
    INY
    LDA locationNameText, X
    STA helper2
    JMP :---
    :
    INC helper

    LDY #0
    LDX helper+1
    LDA landmarkAttr, X
    BPL :++ ; not a fort
    : ; a fort
    LDA helper+1
    CMP #LOC_INDEPENDENCE
    BEQ :+
    LDA locationPrefix, Y
    STA textLineHelper, Y
    INY
    CPY #5
    BNE :-
    CLC
    LDA helper2
    ADC #5
    STA helper2
    :
    LDX helper
    :
    LDA locationNameText, X
    STA textLineHelper, Y
    INX
    INY
    CPY helper2
    BNE :-
    LDX helper+1 ; is it a river?
    LDA landmarkAttr, X
    ROL
    BPL :++ ; not a river
    LDX #5 ; a river
    CLC
    LDA helper2
    ADC #15
    STA helper2
    :
    LDA locationPrefix, X
    STA textLineHelper, Y
    INX
    INY
    CPX #20
    BNE :-
    :
    RTS
.endproc

.proc LoadBgLandmark
    JSR ClearScreen
    SBD
    JSR DrawLandmarkImage ; also sets attributes
    LDX #0
    LDY #22
    JSR SetPpuAddrPointerFromXY
    JSR DrawLandmarkTitle
    EBD
    JSR BufferDrawPressStart
    RTS
.endproc

.proc GamepadLandmark
    LDA buttons1
    CMP buttons1Last
    BNE CheckStart
    JMP Done
    CheckStart:
        LDA #KEY_START
        BIT buttons1
        BNE :+
        JMP Done
        :
        LDA #GAMESTATE_TRAVELING
        STA gameState
    Done:
    RTS
.endproc
