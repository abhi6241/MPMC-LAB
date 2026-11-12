; Program: Find factorial of a number (8051)
; Input 05H at RAM location 25H; result 78H at 25H.
            ORG 0000H
            MOV A, 25H       ; Load input value (05H)
            MOV R2, #04H     ; Remaining multipliers: 4,3,2,1
FACT:       MOV B, R2        ; Load current multiplier
            MUL AB           ; Multiply A by B
            DJNZ R2, FACT    ; Repeat with next lower multiplier
            MOV 25H, A       ; Store factorial result
STOP:       SJMP STOP        ; Stop for inspection
            END

; Output: [25H] = 78H (120 decimal) for input 05H.
; This repeated 8-bit example is intended for small inputs only.
