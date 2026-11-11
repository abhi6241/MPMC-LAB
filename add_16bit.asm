; Program      : Add two 16-bit numbers (8086)
; Description  : Adds two immediate values, 2222H and 1111H,
;                keeping the sum in register AX.
; Assembler    : 8086 (MASM/TASM syntax)

ASSUME CS:CODE
CODE SEGMENT
START:
    MOV AX, 2222H      ; AX = first number 2222H
    MOV BX, 1111H      ; BX = second number 1111H
    ADD AX, BX         ; AX = AX + BX (sum)
    INT 03H            ; breakpoint: stop so result can be inspected
CODE ENDS
END START

; Output:
;   AX = 3333H  (2222H + 1111H = 3333H)
;   BX = 1111H  (unchanged, holds the second number)
; Program stops at INT 03H for inspection.
