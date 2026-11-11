; Program      : Subtract two 16-bit numbers (8086)
; Description  : Subtracts two immediate values, 1111H from 2222H,
;                keeping the difference in register AX.
; Assembler    : 8086 (MASM/TASM syntax)

ASSUME CS:CODE
CODE SEGMENT
START:
    MOV AX, 2222H      ; AX = first number 2222H
    MOV BX, 1111H      ; BX = second number 1111H
    SUB AX, BX         ; AX = AX - BX (difference)
    INT 03H            ; breakpoint: stop so result can be inspected
CODE ENDS
END START

; Output:
;   AX = 1111H  (2222H - 1111H = 1111H)
;   BX = 1111H  (unchanged, holds the second number)
; Program stops at INT 03H for inspection.
