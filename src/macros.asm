
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
    JSR DecompressTokumaruTilesMeta
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
.macro branch_check opc, dest
    opc dest
    .assert >* = >(dest), warning, "branch_check: failed, crosses page"
.endmacro

.macro Jcc dest
	branch_check bcc, dest
.endmacro
.macro Jcs dest
	branch_check bcs, dest
.endmacro
.macro Jeq dest
	branch_check beq, dest
.endmacro
.macro Jne dest
	branch_check bne, dest
.endmacro
.macro Jmi dest
	branch_check bmi, dest
.endmacro
.macro Jpl dest
	branch_check bpl, dest
.endmacro
.macro Jvc dest
	branch_check bvc, dest
.endmacro
.macro Jvs dest
	branch_check bvs, dest
.endmacro

.macro TableWrapCheck table, last_index, message
	.assert >(table) = >(table+(last_index)), warning, message
.endmacro

.macro delay_n n
    .if (n)=2
	nop
    .elseif (n)=3
	cmp DummyByte
    .elseif (n)=5
	inc DummyByte
    .elseif (n)=7
	php
	plp
    .elseif (n)=9
	nop
	delay_n 7
    .elseif (n)=12
	jsr rts12
    .elseif (n)=14
	jsr rts14
    .elseif (n)=15
	jsr rts15
    .elseif (n)<34
	delay_n (n)/2
	delay_n (n) - (n)/2
    .elseif ((n) <= 289)
	; overhead: 7+2 = 9
	; Size: 7 bytes
	pha
	 lda #((n)-(25+9))
	 jsr delay_a_25_clocks
	pla
    .else
	; overhead: 7+7+4+4 = 22
	; Size: 13 bytes
	pha
	txa
	pha
	 lda #<((n)-(30+22))
	 ldx #>((n)-(30+22))
	 jsr delay_256x_a_30_clocks
	pla
	tax
	pla
    .endif
.endmacro
