; Program      : Block copy of 5 words in memory (ARM)
; Description  : Copies 5 words (32-bit each) from memory starting
;                at 0x20000000 to memory starting at 0x20000020,
;                using post-indexed addressing.
; Source       : 0x20000000 - 0x20000010 (5 words)
; Destination  : 0x20000020 - 0x20000030 (5 words)
; Assembler    : ARM (Keil/ARMCC syntax, AREA directive)

        AREA P2, CODE, READONLY   ; code section named P2
        EXPORT MYAPP              ; make entry point visible
MYAPP   LDR R0, =0x20000000       ; R0 = source address
        LDR R1, =0x20000020       ; R1 = destination address
        MOV R2, #5                ; R2 = loop counter (5 words)
LOOP    LDR R3, [R0], #4          ; R3 = word at [R0]; R0 += 4
        STR R3, [R1], #4          ; store R3 at [R1]; R1 += 4
        SUBS R2, R2, #1           ; decrement counter, set flags
        BNE LOOP                  ; repeat until counter = 0
HERE    B HERE                    ; infinite loop: stay here
        END

; Output:
; The 5 words stored at 0x20000000-0x20000010 are copied to
; 0x20000020-0x20000030:
;   (0x20000020) = (0x20000000)
;   (0x20000024) = (0x20000004)
;   (0x20000028) = (0x20000008)
;   (0x2000002C) = (0x2000000C)
;   (0x20000030) = (0x20000010)
; Register state after execution:
;   R0 = 0x20000014 (one past the last source word)
;   R1 = 0x20000034 (one past the last destination word)
;   R2 = 0 (counter exhausted), R3 = last word copied
; PC then loops forever at HERE.
