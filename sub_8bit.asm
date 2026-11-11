; Program      : Subtract two 8-bit numbers (8086)
; Description  : Subtracts two immediate values, 42H from 48H,
;                keeping the difference in register BL.
; Assembler    : 8086 (MASM/TASM syntax)

ASSUME CS:CODE
CODE SEGMENT
START:
    MOV AL, 48H        ; AL = first number 48H
    MOV BL, 42H        ; BL = second number 42H
    SUB BL, AL         ; BL = AL - BL (difference)
    INT 03H            ; breakpoint: stop so result can be inspected
CODE ENDS
END START

; Output:
;   BL = 06H  (48H - 42H = 06H)
;   AL = 48H  (unchanged, holds the minuend)
; Program stops at INT 03H for inspection.
