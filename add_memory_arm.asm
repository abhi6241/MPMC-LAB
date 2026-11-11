; Program      : Add two 32-bit numbers in memory (ARM)
; Description  : Loads two words from memory locations
;                0x20000000 and 0x20000010, adds them, and
;                stores the result at 0x200000FF.
; Assembler    : ARM (Keil/ARMCC syntax, AREA directive)

        AREA P2, CODE, READONLY   ; code section named P2
        EXPORT MYAPP              ; make entry point visible
MYAPP   LDR R0, =0x20000000       ; R0 = address of first number
        LDR R1, [R0]              ; R1 = first number from memory
        LDR R2, =0x20000010       ; R2 = address of second number
        LDR R3, [R2]              ; R3 = second number from memory
        ADD R4, R1, R3            ; R4 = first + second number
        LDR R5, =0x200000ff       ; R5 = result address
        STR R4, [R5]              ; store sum at 0x200000FF
HERE    B HERE                    ; infinite loop: stay here
        END

; Output:
; The 32-bit word at 0x20000000 is added to the 32-bit word at
; 0x20000010, and the sum is stored at 0x200000FF.
; Example: if (0x20000000) = 00000005H and (0x20000010) = 0000000AH,
;          then (0x200000FF) = 0000000FH (5 + 10 = 15).
; Register state after execution:
;   R1 = first number, R3 = second number, R4 = sum, R5 = 0x200000FF
; PC then loops forever at HERE.
