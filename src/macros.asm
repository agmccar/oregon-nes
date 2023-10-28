
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

.macro LoadCHR tilesMetaAddrHi, tilesMetaAddrLo
    LDA tilesMetaAddrHi
    STA pointer
    LDA tilesMetaAddrLo
    STA pointer+1
    JSR UnpackTilesMeta
.endmacro

.macro LoadImage imageMetaAddrHi, imageMetaAddrLo
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

.macro BDrawTextBox ppuAddrHi, ppuAddrLo, width, height
    LDX ppuAddrHi
    LDY ppuAddrLo
    LDA width
    STA helper
    LDA height
    JSR DrawTextBox
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

.macro SBD
    JSR StartBulkDrawing
.endmacro

.macro EBD
    JSR EndBulkDrawing
.endmacro

.macro WTB
    JSR WriteTileToBuffer
.endmacro

.macro MakeChange dollarsAddr, centsAddr
    LDA #0
    STA helper+1
    STA helper2+1
    LDA dollarsAddr
    STA helper
    LDA centsAddr
    STA helper2
    JSR CheckCents
.endmacro

.macro CPA val
    CMP val
.endmacro

.macro PPU hi, lo
    LDA PPUSTATUS
    LDA hi
    STA PPUADDR
    LDA lo
    STA PPUADDR
.endmacro
