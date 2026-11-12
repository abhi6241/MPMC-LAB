; Program      : Count no. of 0's & 1's in a byte (8051)
; Description  : Counts the set bits into R2. Transcribed exactly as
;                written in the record (see NOTEs - the record's
;                listing does not assemble as printed).
; Source       : Lab record, page 17

    MOV A, 40H       ; load the byte
    MOV R1, #08H     ; examine eight bits
    MOV R2, #00H     ; clear 1's count
    MOV R3, #00H     ; clear 0's count
L2:
    RLC A            ; rotate next bit into carry
    JNC L1           ; skip if bit was zero
    INC R2           ; count set bit
L1:
    JMP R0           ; NOTE: record literally writes "JMP R0"
                     ; (as printed; likely meant a jump back to L0)
    INC R3           ; NOTE: with the jump above this line is not
                     ; reached in the record's listing
L0:
    DJNZ R1, L2      ; repeat eight times

; NOTE: the record's output writes the second result to "R5" while
; the code increments R3; both are transcribed as printed.

; Input : [40H] = 86H
; Output: R2 = 03H (1's), R5 = 05H (0's, as written in the record)
