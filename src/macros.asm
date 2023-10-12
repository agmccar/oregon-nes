
.macro BufferStart len, addrHi, addrLo
    LDX len
    JSR StartBufferWrite
    LDA len
    JSR WriteByteToBuffer
    LDA addrHi
    JSR WriteByteToBuffer
    LDA addrLo
    JSR WriteByteToBuffer
.endmacro
