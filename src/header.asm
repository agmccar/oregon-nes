.segment "HEADER"
    .byte "NES", $1A
    .byte 8 ; number of 16KB PRG-ROM banks
    .byte 0 ; number of 8KB CHR-ROM banks
    .byte %00100001 ; Vertical mirroring, no save RAM, unrom mapper(?)
    .byte %00000000 ; No special-case flags set, no mapper
    .byte $00 ; No PRG-RAM present
    .byte $00 ; NTSC format
    .byte $07, $00, $00