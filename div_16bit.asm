; Program      : Divide a 16-bit number (8086)
; Description  : Divides the 32-bit value in DX:AX by a 16-bit
;                value using unsigned word divide. AX gets the
;                quotient, DX gets the remainder.
; Assembler    : 8086 (MASM/TASM syntax)

ASSUME CS:CODE
CODE SEGMENT
START:
    MOV DX, 0001H      ; DX = high word of dividend
    MOV AX, 0000H      ; AX = low word -> DX:AX = 00010000H (65536)
    MOV BX, 0010H      ; BX = divisor 0010H (16 decimal)
    DIV BX             ; AX = DX:AX / BX, DX = remainder
    INT 03H            ; breakpoint: stop so result can be inspected
CODE ENDS
END START

; Output:
;   AX = 1000H  (quotient: 65536 / 16 = 4096)
;   DX = 0000H  (remainder: 65536 mod 16 = 0)
;   BX = 0010H  (unchanged, holds the divisor)
; NOTE: DX must hold the high word of the dividend (here 0000H)
;       before DIV, otherwise it corrupts the dividend.
; Program stops at INT 03H for inspection.
