; Program      : Demonstrate 8051 ALU operations
; Description  : Performs ADD, SUBB, MUL, DIV, ANL, XRL and RL.
; Assembler    : 8051 Keil A51
; Result bytes are stored at 42H-47H; rotated value remains in A.

            ORG 0000H
            MOV A, #40H      ; first operand = 40H
            MOV R1, #11H     ; second operand = 11H
            ADD A, R1        ; addition: 40H + 11H = 51H
            MOV 42H, A       ; store addition result

            MOV A, #40H      ; reload first operand
            CLR C            ; clear borrow before subtraction
            SUBB A, R1       ; subtraction: 40H - 11H = 2FH
            MOV 43H, A       ; store subtraction result

            MOV A, #04H      ; multiplication operand = 04H
            MOV B, #04H      ; multiplication operand = 04H
            MUL AB           ; product in B:A
            MOV 44H, A       ; store low byte of product
            MOV 45H, B       ; store high byte of product

            MOV A, #40H      ; division dividend = 40H
            MOV B, #04H      ; divisor = 04H
            DIV AB           ; quotient in A, remainder in B
            MOV 46H, A       ; store quotient
            MOV 47H, B       ; store remainder

            MOV A, #40H      ; reload operand for logical operations
            ANL A, R1        ; bitwise AND
            MOV 48H, A       ; store AND result
            MOV A, #40H      ; reload operand
            XRL A, R1        ; bitwise XOR
            MOV 49H, A       ; store XOR result
            MOV A, #40H      ; reload operand
            RL A             ; rotate accumulator left
STOP:       SJMP STOP        ; stop here for inspection
            END

; Output:
; [42H]=51H, [43H]=2FH, [44H]=10H, [45H]=00H,
; [46H]=10H, [47H]=00H. [48H] and [49H] hold AND/XOR results.
; A holds the value after rotate-left.
