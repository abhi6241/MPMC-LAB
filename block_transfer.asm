; Program      : Block data transfer (8051)
; Description  : Copies a block of 10 bytes from internal RAM
;                starting at location 40H to locations starting
;                at 50H, using indirect addressing.
; Source       : 40H - 49H
; Destination  : 50H - 59H

MOV R0, #40H         ; R0 = source pointer (starts at 40H)
MOV R1, #50H         ; R1 = destination pointer (starts at 50H)
MOV R2, #0AH         ; R2 = loop counter (10 bytes to copy)

LOOP1:
    MOV A, @R0       ; read one byte from address in R0 into A
    MOV @R1, A       ; write it to the address in R1
    INC R0           ; advance source pointer to next byte
    INC R1           ; advance destination pointer to next byte
    DJNZ R2, LOOP1   ; decrement counter, repeat until all 10 copied

; Output:
; After execution, the 10 bytes from 40H-49H are copied to 50H-59H:
; (50H) = (40H), (51H) = (41H), (52H) = (42H), (53H) = (43H),
; (54H) = (44H), (55H) = (45H), (56H) = (46H), (57H) = (47H),
; (58H) = (48H), (59H) = (49H)
; A = value of the last byte copied (content of 49H)
; R0 = 4AH (source pointer one past the last byte)
; R1 = 5AH (destination pointer one past the last byte)
; R2 = 00H (counter exhausted)
