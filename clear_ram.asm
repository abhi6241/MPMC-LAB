; Program      : Clear a block of internal RAM (8051)
; Description  : Fills 16 RAM locations starting at 60H with 00H,
;                using indirect addressing.
; Target range : 60H - 6FH

CLR A                ; A = 00H (value to be written)
MOV R1, #60H         ; R1 = pointer to first location (60H)
MOV R2, #16          ; counter: 16 locations to clear (10H)

AGAIN:
    MOV @R1, A       ; write 00H to the location pointed by R1
    INC R1           ; advance pointer to next location
    DJNZ R2, AGAIN   ; decrement counter, repeat until all 16 cleared

; Output:
; Internal RAM locations 60H-6FH are all cleared to 00H
; Final state after execution:
;   (60H) = (61H) = ... = (6FH) = 00H
;   A  = 00H
;   R1 = 70H (pointer one past the last location cleared)
;   R2 = 00H (counter exhausted)
