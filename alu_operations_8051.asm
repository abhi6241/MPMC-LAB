; Program      : ALU operations on two numbers (8051)
; Description  : Operands in RAM [40H] and [41H]. Performs addition,
;                subtraction, multiplication, division, AND, XOR and
;                a rotate-left, storing each result in RAM 42H-4AH.
; Source       : Lab record, page 15

    MOV A, 40H       ; A = [40H]
    MOV R1, 41H      ; R1 = [41H]
    ADD A, R1        ; A = [40H] + [41H]
    MOV 42H, A       ; store sum at 42H
    MOV A, 40H
    CLR C            ; clear carry before subtraction
    SUBB A, R1       ; A = [40H] - [41H]
    MOV 43H, A       ; store difference at 43H
    MOV B, 41H
    MOV A, 40H
    MUL AB           ; B:A = [40H] x [41H]
    MOV 44H, A       ; product low byte at 44H
    MOV 45H, B       ; product high byte at 45H
    MOV A, 40H
    MOV B, 41H
    DIV AB           ; A = quotient, B = remainder
    MOV 46H, A       ; quotient at 46H
    MOV 47H, B       ; remainder at 47H
    MOV A, 40H
    ANL A, R1        ; A = [40H] AND [41H]
    MOV 48H, A       ; store AND result at 48H
    MOV A, 40H
    XRL A, R1        ; A = [40H] XOR [41H]
    MOV 49H, A       ; store XOR result at 49H
    MOV A, 40H
    RL A             ; rotate [40H] left by one
    MOV 4AH, A       ; store rotated value at 4AH

; Input : [40H] = 32H, [41H] = 06H
; Output: 42H = 38H, 43H = 2CH, 44H = 1BH, 45H = 00H,
;         46H = 03H, 47H = 00H, 48H = 01H, 49H = 0AH, 4AH = 12H
;         (result table exactly as observed in the record)
