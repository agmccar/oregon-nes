
.macro BDrawText txtPtrHi, txtPtrLo, ppuPtrHi, ppuPtrLo
    LDA txtPtrHi
    STA pointer
    LDA txtPtrLo
    STA pointer+1
    LDA ppuPtrHi
    STA bufferHelper
    LDA ppuPtrLo
    STA bufferHelper+1
    JSR BufferDrawText
.endmacro

.macro UnpTilesMeta tilesMetaAddrHi, tilesMetaAddrLo
    LDA tilesMetaAddrHi
    STA pointer
    LDA tilesMetaAddrLo
    STA pointer+1
    JSR UnpackTilesMeta
.endmacro

.macro UnpImageMeta imageMetaAddrHi, imageMetaAddrLo
    LDA imageMetaAddrHi
    STA pointer
    LDA imageMetaAddrLo
    STA pointer+1
    JSR UnpackImageMeta
.endmacro

.macro BDrawBlankBox ppuAddrHi, ppuAddrLo, width, height
    LDA ppuAddrHi
    STA bufferHelper
    LDA ppuAddrLo
    STA bufferHelper+1
    LDX width
    LDY height
    JSR BufferDrawBlankBox
.endmacro

.macro BDrawDateText ppuAddrHi, ppuAddrLo
    LDA ppuAddrHi
    STA pointer
    LDA ppuAddrLo
    STA pointer+1
    JSR BufferDrawDateText
.endmacro

.macro SetDigit digitAddr, valueAddr
    LDX digitAddr
    LDY valueAddr
    JSR SetDigitFromValue
.endmacro

.macro BDrawDollarAmount ppuAddrHi, ppuAddrLo, cartDigitAddr
    LDA ppuAddrHi
    STA bufferHelper
    LDA ppuAddrLo
    STA bufferHelper+1
    LDA cartDigitAddr
    JSR BufferDrawDollarAmount
.endmacro

.macro SBW len, addrHi, addrLo
    LDX len
    JSR StartBufferWrite
    LDA len
    WBB
    LDA addrHi
    WBB
    LDA addrLo
    WBB
.endmacro

.macro WBB
    JSR WriteByteToBuffer
.endmacro

.macro EBW
    JSR EndBufferWrite
.endmacro
