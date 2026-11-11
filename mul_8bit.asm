; Program      : Multiply two 8-bit numbers (8086)
; Description  : Multiplies two immediate values, 12H and 10H,
;                using unsigned byte multiply. The 16-bit product
;                ends up in AX.
; Assembler    : 8086 (MASM/TASM syntax)

ASSUME CS:CODE
CODE SEGMENT
START:
    MOV AL, 12H        ; AL = multiplicand 12H
    MOV BL, 10H        ; BL = multiplier 10H
    MUL BL             ; AX = AL * BL (product)
    INT 03H            ; breakpoint: stop so result can be inspected
CODE ENDS
END START

; Output:
;   AX = 0120H  (12H * 10H = 0120H, i.e. 18 * 16 = 288)
;   AL = 20H (low byte of product), AH = 01H (high byte)
;   BL = 10H (unchanged, holds the multiplier)
; Program stops at INT 03H for inspection.
