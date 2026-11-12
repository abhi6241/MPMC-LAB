; Program      : Average of five array elements (8086)
; Description  : Adds five bytes at 2000H-2004H and divides by 5.
;                Quotient is returned in AL and remainder in AH.
; Assembler    : 8086 (MASM/TASM syntax)

CODE SEGMENT
    ASSUME CS:CODE
START:
    MOV SI, 2000H      ; SI points to the first array element
    MOV AX, 0000H      ; clear the 16-bit dividend
    MOV AL, [SI]       ; load the first element
    MOV CL, 04H        ; four more elements remain
LOOP1:
    INC SI             ; point to the next array element
    ADD AL, [SI]       ; add the next byte
    ADC AH, 00H        ; include carry in the high byte
    DEC CL             ; decrement counter
    JNZ LOOP1          ; repeat for all five elements
    MOV BL, 05H        ; divisor = number of array elements
    DIV BL             ; AX / BL: quotient AL, remainder AH
    INT 03H            ; breakpoint for result inspection
CODE ENDS
END START

; Output:
; AL = integer average; AH = remainder after division by 5.
; Example 1, 2, 3, 4, 5: AL = 03H and AH = 00H.
