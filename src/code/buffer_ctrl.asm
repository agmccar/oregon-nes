
.proc ProcessNametableBuffer
    LDA bufferLoading
    CMP #1
    BEQ Done
    LDA PPUSTATUS
    LDX #0 
    LDY nametableBuffer     ; note first byte in buffer (length of data segment)
    STX bufferPointer       ; reset buffer pointer
    STX nametableBuffer     ; reset first byte in buffer
    INX 
    @loop:                  ; read buffer
    CPY #0 
    BNE :+                  ; exit if length of data segment is 0
    JMP Done
    :
    LDA PPUSTATUS
    LDA nametableBuffer, X  ; set PPU address
    STA PPUADDR
    INX
    LDA nametableBuffer, X
    STA PPUADDR
    LDA #0
    STA PPUSCROLL           
    STA PPUSCROLL           ; default 0 scroll position
    INX 
    : 
    LDA nametableBuffer, X 
    STA PPUDATA             ; write buffer data to nametable
    INX
    DEY
    CPY #0
    BNE :-                  ; repeat until no more bytes to copy
    LDY nametableBuffer, X
    INX
    JMP @loop               ; exit if entire buffer has been read
    Done:
    RTS
.endproc

.proc StartBufferWrite
    ; X: length of segment
    ; A: not affected
    ; Y: not affected
    PHA
    INX
    INX
    INX
    INX                 ; total space needed: length + header(3) + footer(1)
    STX helper2
    LDA bufferPointer
    CLC
    ADC helper2
    CMP #64         ; buffer must have space for segment
    BCC :++
    :                   ; vblankwait
    BIT PPUSTATUS
    BPL :-
    :
    LDA #1
    STA bufferLoading
    PLA
    RTS
.endproc

.proc EndBufferWrite
    PHA
    LDA #0
    LDY bufferPointer
    STA nametableBuffer, Y
    LDA #0
    STA bufferLoading
    PLA
    RTS
.endproc

.proc WriteByteToBuffer
    ; write contents of A register to the nametable buffer
    ; clobbers Y
    LDY bufferPointer
    STA nametableBuffer, Y
    INC bufferPointer
    RTS
.endproc
    
.proc WriteTileToBuffer
    ; X,Y,A = tiles from left, tiles from top, tile index to draw
    ; write one single tile to the nametable buffer
    PHA
    TXA
    PHA
    LDX #1
    JSR StartBufferWrite
        PLA
        TAX
        JSR SetPpuAddrPointerFromXY
        LDA #1
        JSR WriteByteToBuffer
        LDA pointer
        JSR WriteByteToBuffer
        LDA pointer+1
        JSR WriteByteToBuffer
        PLA
        JSR WriteByteToBuffer
    JSR EndBufferWrite
    RTS
.endproc

