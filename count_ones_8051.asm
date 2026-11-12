; Program: Count the number of 1 bits in a byte (8051)
; Input byte at 40H; count stored at 41H.
            ORG 0000H
            MOV A, 40H       ; Load input byte
            MOV R2, #08H     ; Examine eight bits
            MOV R3, #00H     ; Clear count
COUNT:      RRC A            ; Rotate bit 0 into carry
            JNC NEXT         ; Skip if bit was zero
            INC R3           ; Count set bit
NEXT:       DJNZ R2, COUNT   ; Repeat eight times
            MOV 41H, R3      ; Store count
STOP:       SJMP STOP        ; Stop for inspection
            END

; Output: [41H] = number of set bits in [40H].
; Example 13H (00010011B) produces 03H.
