; Program      : Add and subtract two 32-bit constants (ARM)
; Description  : R0 = 0x22222222, R1 = 0x11111111; ADD R2 and SUBS R3.
; Assembler    : ARM Keil armasm syntax
; Source       : Lab record, page 31 (ARM program 1)

        AREA P1, CODE, READONLY
        EXPORT MYAPP
MYAPP
        LDR R0, =0x22222222
        LDR R1, =0x11111111
        ADD R2, R0, R1           ; R2 = R0 + R1
        SUBS R3, R0, R1          ; R3 = R0 - R1, flags updated
HERE    B HERE                   ; stop for register inspection
        END

; Output: R2 = 0x33333333, R3 = 0x11111111, XPSR = 0x21000000
