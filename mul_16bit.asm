; Program      : Multiply two 16-bit numbers (8086)
; Description  : Multiplies two immediate values, 1234H and 5678H,
;                using unsigned word multiply. The 32-bit product
;                ends up in DX:AX (DX = high word, AX = low word).
; Assembler    : 8086 (MASM/TASM syntax)

ASSUME CS:CODE
CODE SEGMENT
START:
    MOV AX, 1234H      ; AX = multiplicand 1234H
    MOV BX, 5678H      ; BX = multiplier 5678H
    MUL BX             ; DX:AX = AX * BX (32-bit product)
    INT 03H            ; breakpoint: stop so result can be inspected
CODE ENDS
END START

; Output:
;   DX = 0626H (high word), AX = 0060H (low word)
;   i.e. 1234H * 5678H = 06260060H (4660 * 22136 = 103,153,760)
;   BX = 5678H (unchanged, holds the multiplier)
; Program stops at INT 03H for inspection.
