; lidnariq
;  — 
; Today at 7:06 PM
; It's not that bad
; It really depends on whether you can fit your NMI and its data accesses into only bank 7
; but either way, you basically mark certain routines as "far", which means that to enter them you have to change the bank and to return from then you have to have recorded the old bank and restore it

; jroweboy
; These are only to be used on the main thread and not duing NMI

.macro farcall loc, usejmp
.scope
.import loc
.assert .bank(loc) <> .bank(*), error, "Attempting to farcall to the same bank!"
.assert .bank(loc) <> .bank(CODE), error, "Attempting to farcall to the low bank!"
.assert .bank(loc) <> .bank(FIXED), error, "Attempting to farcall to the fixed bank!"
  lda #<loc
  sta TargetAddress
  lda #>loc
  sta TargetAddress+1
  lda #.lobyte(.bank(loc))
  sta NextBank
.ifblank usejmp
  jsr FarCallCommon
.else
  jmp FarCallCommon
.endif
.endscope
.endmacro

.macro far function
.scope
.ident(.concat("farblock_", .string(function))):
  lda CurrentBank
  pha
    lda #7 | PRG_FIXED_8
    sta BankShadow
    sta BANK_SELECT
    lda #.bank(function)
    sta BANK_DATA
.endmacro

.macro endfar
    lda #7 | PRG_FIXED_8
    sta BankShadow
    sta BANK_SELECT
  pla
  sta BANK_DATA
.endscope
.endmacro


; And here's the actual proc that should be in the fixed bank

; uses 3 bytes of ZP for TargetAddrJmp and 2 bytes of BSS for CurrentBank/NextBank
.proc FarCallCommon
  lda CurrentBank
  pha
    lda #7 | PRG_FIXED_8
    sta BankShadow
    sta BANK_SELECT
    lda NextBank
    sta BANK_DATA
    sta CurrentBank
    jsr TargetAddrJmp
    lda #7 | PRG_FIXED_8
    sta BankShadow
    sta BANK_SELECT
  pla
  sta BANK_DATA
  sta CurrentBank
  rts
.endproc

; 
; jroweboy
;  — 
; Today at 6:46 PM
; if it helps, here a macro like this one to define a "null" terminated string

TEXT_END = $ff
.macro STR label, string
.ident (label):
  .byte string, TEXT_END
.export .ident(label)
.endmacro

; or if you wanted a length prefixed string you can do

.macro STR label, string
.ident (label):
  .byte .strlen(string), string
.export .ident(label)
.endmacro