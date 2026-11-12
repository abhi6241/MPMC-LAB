; Program      : Add two 32-bit numbers using ARM registers
; Description  : Adds 11111111H and 22222222H.
; Assembler    : ARM Keil armasm syntax

        AREA P1, CODE, READONLY
        EXPORT MYAPP
MYAPP
        LDR R0, =0x11111111      ; Load first 32-bit operand
        LDR R2, =0x22222222      ; Load second 32-bit operand
        ADD R4, R2, R0           ; R4 = R2 + R0
HERE    B HERE                   ; Stop for register inspection
        END

; Output: R0=11111111H, R2=22222222H, R4=33333333H.
