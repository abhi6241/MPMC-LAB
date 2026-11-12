; Program      : Block copy of 5 words (ARM)
; Description  : Copies 5 words from 0x20000000 to 0x20000020 using
;                post-indexed addressing and a flag-tested loop.
; Assembler    : ARM Keil armasm syntax
; Source       : Lab record, page 32

        AREA P3, CODE, READONLY
        LDR R0, =0x20000000      ; source pointer
        LDR R1, =0x20000020      ; destination pointer
        MOV R2, #5               ; word count
LOOP    LDR R3, [R0], #4         ; load word, R0 += 4
        STR R3, [R1], #4         ; store word, R1 += 4
        SUBS R2, R2, #1          ; count down, set flags
        BNE LOOP                 ; repeat until R2 = 0
HERE    B HERE                   ; stop for register inspection
        END

; Input : [0x20000000-0x20000010] = 10, 20, 30, 40, 50
; Output: R0 = 0x20000014, R1 = 0x20000034, R2 = 0, R3 = 50 (0x32)
