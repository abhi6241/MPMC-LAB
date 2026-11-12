; Program      : Transfer 10 bytes of data from one location to another (8051)
; Description  : Copies RAM 40H-4AH to 50H-5A using register indirect
;                addressing and a DJNZ loop.
; Source       : Lab record, page 16

    MOV R0, #40H     ; R0 = source pointer
    MOV R1, #50H     ; R1 = destination pointer
    MOV R2, #0AH     ; R2 = 10 bytes to copy

L1:
    MOV A, @R0       ; read byte from source
    MOV @R1, A       ; write byte to destination
    INC R0           ; next source byte
    INC R1           ; next destination byte
    DJNZ R2, L1      ; repeat until 10 bytes copied

; Input : RAM 40H-4AH = 65 65 65 65 65 01 08 02 02 34
; Output: RAM 50H-5AH = 65 65 65 65 65 01 08 02 02 34
;         R0 = 4AH, R1 = 5AH, R2 = 00H, A = 34H
