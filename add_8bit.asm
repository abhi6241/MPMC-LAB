; Program      : Add two 8-bit numbers (8086)
; Description  : Adds two immediate values, 48H and 42H, keeping
;                the sum in register BL.
; Assembler    : 8086 (MASM/TASM syntax)

ASSUME CS:CODE
CODE SEGMENT
START:
    MOV AL, 48H        ; AL = first number 48H
    MOV BL, 42H        ; BL = second number 42H
    ADD BL, AL         ; BL = BL + AL (sum)
    INT 03H            ; breakpoint: stop so result can be inspected
CODE ENDS
END START

; Output:
;   BL = 8AH  (42H + 48H = 8AH)
;   AL = 48H  (unchanged, holds the first number)
; Program stops at INT 03H for inspection.
