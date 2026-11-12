; Program      : Count the number of 1 bits in a byte (8051)
; Description  : Counts set bits in the byte stored at 40H.
; Assembler    : 8051 Keil A51

            ORG 0000H
            MOV A, 40H       ; load the input byte
            MOV R2, #08H     ; examine all eight bits
            MOV R3, #00H     ; clear the count
COUNT:      RRC A            ; rotate bit 0 into carry
            JNC NEXT         ; skip increment when bit was zero
            INC R3           ; count one set bit
NEXT:       DJNZ R2, COUNT   ; repeat eight times
            MOV 41H, R3      ; store number of ones at 41H
STOP:       SJMP STOP        ; stop here for inspection
            END

; Output:
; [41H] contains the number of set bits in [40H].
; Example: input 13H (00010011B) produces 03H.
