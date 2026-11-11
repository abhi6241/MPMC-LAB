; Program      : Add and subtract two 32-bit constants (ARM)
; Description  : Computes the sum and difference of the constants
;                0x22222222 and 0x11111111, keeping the results in
;                registers R2 (sum) and R3 (difference).
; Assembler    : ARM (Keil/ARMCC syntax, AREA directive)

        AREA P2, CODE, READONLY   ; code section named P2
        EXPORT MYAPP              ; make entry point visible
MYAPP   LDR R0, =0x22222222       ; R0 = first constant
        LDR R1, =0x11111111       ; R1 = second constant
        ADD R2, R0, R1            ; R2 = R0 + R1 (sum)
        SUBS R3, R0, R1           ; R3 = R0 - R1 (difference)
HERE    B HERE                    ; infinite loop: stay here
        END

; Output:
;   R2 = 0x33333333  (0x22222222 + 0x11111111)
;   R3 = 0x11111111  (0x22222222 - 0x11111111)
; Both results stay in registers (nothing is stored to memory),
; then PC loops forever at HERE.
