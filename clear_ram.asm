; Program      : Clear 16-bit RAM locations starting at 60H (8051)
; Description  : Clears 16 internal RAM locations from 60H to 6FH.
; Source       : Lab record, page 18

    CLR A            ; A = 00H
    MOV R1, #60H     ; R1 points to first location
    MOV R7, #16H     ; NOTE: record writes #16H for 16 locations
                     ; (hex 10H); transcribed as printed
AGAIN:
    MOV @R1, A       ; write 00H to location in R1
    INC R1           ; next location
    DJNZ R7, AGAIN   ; repeat for all locations

; Input : [60H]-[6FH] = 05H (each of the 16 locations)
; Output: [60H]-[6FH] = 00H (each of the 16 locations)
