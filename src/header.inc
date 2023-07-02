.SEGMENT "HEADER"
    .BYTE "NES", $1A
    .BYTE $01 ; number of 16KB PRG-ROM banks
    .BYTE $01 ; number of 8KB CHR-ROM banks
    .BYTE %00000001 ; Vertical mirroring, no save RAM, no mapper
    .BYTE %00000000 ; No special-case flags set, no mapper
    .BYTE $00 ; No PRG-RAM present
    .BYTE $00 ; NTSC format
    .BYTE $00, $00, $00