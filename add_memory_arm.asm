; Program      : Add two numbers stored in memory (ARM)
; Description  : Adds the words at 0x20000000 and 0x20000010 and
;                stores the sum at 0x200000FF.
; Assembler    : ARM Keil armasm syntax
; Source       : Lab record, page 31 (ARM program 2)

        AREA P2, CODE, READONLY
        LDR R0, =0x20000000
        LDR R1, [R0]             ; R1 = [0x20000000]
        LDR R2, =0x20000010
        LDR R3, [R2]             ; R3 = [0x20000010]
        ADD R4, R1, R3           ; R4 = R1 + R3
        LDR R5, =0x200000FF
        STR R4, [R5]             ; [0x200000FF] = R4
HERE    B HERE                   ; stop for register inspection
        END

; Input : [0x20000000] = 0x04030201, [0x20000010] = 0x05040302
; Output: R1 = 0x04030201, R3 = 0x05040302, R4 = 0x09070503,
;         R5 = 0x200000FF
