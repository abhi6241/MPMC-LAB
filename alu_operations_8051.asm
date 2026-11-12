; Program: Perform basic ALU operations using 8051
; Operations: ADD, SUBB, MUL, DIV, AND, XOR, rotate left.
            ORG 0000H
            MOV A, #40H      ; Load first operand
            MOV R1, #11H     ; Load second operand
            ADD A, R1        ; Addition
            MOV 42H, A       ; Store sum
            MOV A, #40H      ; Reload first operand
            CLR C            ; Clear borrow
            SUBB A, R1       ; Subtraction
            MOV 43H, A       ; Store difference
            MOV A, #04H      ; Multiplication operand
            MOV B, #04H      ; Multiplication operand
            MUL AB           ; Product in B:A
            MOV 44H, A       ; Store low product byte
            MOV 45H, B       ; Store high product byte
            MOV A, #40H      ; Division dividend
            MOV B, #04H      ; Divisor
            DIV AB           ; Quotient in A, remainder in B
            MOV 46H, A       ; Store quotient
            MOV 47H, B       ; Store remainder
            MOV A, #40H      ; Reload first operand
            ANL A, R1        ; Logical AND
            MOV 48H, A       ; Store AND result
            MOV A, #40H      ; Reload first operand
            XRL A, R1        ; Logical XOR
            MOV 49H, A       ; Store XOR result
            MOV A, #40H      ; Reload first operand
            RL A             ; Rotate accumulator left
STOP:       SJMP STOP        ; Stop for inspection
            END

; Results: 42H=51H, 43H=2FH, 44H=10H, 45H=00H,
; 46H=10H, 47H=00H. 48H and 49H contain AND/XOR results.
