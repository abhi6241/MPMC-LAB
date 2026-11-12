; Program      : No. of 1's in a byte (8051)
; Description  : Counts the set bits of the byte at 40H by rotating
;                through the carry; count is kept in R2.
; Source       : Lab record, page 17

    MOV A, 40H       ; load the byte
    MOV R1, #08H     ; examine eight bits
    MOV R2, #00H     ; clear count
L2:
    RLC A            ; rotate next bit into carry
    JNC L1           ; skip if bit was zero
    INC R2           ; count set bit
L1:
    DJNZ R1, L2      ; repeat eight times

; Input : [40H] = 96H
; Output: R2 = 04H (number of 1's), A = 4BH (rotated byte)
