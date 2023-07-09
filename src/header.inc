.SEGMENT "HEADER"
    .BYTE "NES", $1A
    .BYTE 8 ; number of 16KB PRG-ROM banks
    .BYTE 0 ; number of 8KB CHR-ROM banks
    .BYTE %00100001 ; Vertical mirroring, no save RAM, unrom mapper(?)
    .BYTE %00000000 ; No special-case flags set, no mapper
    .BYTE $00 ; No PRG-RAM present
    .BYTE $00 ; NTSC format
    .BYTE $07, $00, $00