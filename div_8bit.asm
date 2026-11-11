; Program      : Divide an 8-bit number (8086)
; Description  : Divides the 16-bit value in AX by an 8-bit value
;                using unsigned byte divide. AL gets the quotient,
;                AH gets the remainder.
; Assembler    : 8086 (MASM/TASM syntax)

ASSUME CS:CODE
CODE SEGMENT
START:
    MOV AX, 0045H      ; AX = dividend 0045H (69 decimal)
    MOV BL, 0AH        ; BL = divisor 0AH (10 decimal)
    DIV BL             ; AL = AX / BL, AH = remainder
    INT 03H            ; breakpoint: stop so result can be inspected
CODE ENDS
END START

; Output:
;   AL = 06H  (quotient: 69 / 10 = 6)
;   AH = 09H  (remainder: 69 mod 10 = 9)
;   BL = 0AH  (unchanged, holds the divisor)
; NOTE: AH must be cleared (here AX = 0045H has AH = 0) before DIV,
;       otherwise it corrupts the dividend.
; Program stops at INT 03H for inspection.
