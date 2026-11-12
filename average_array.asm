; Program: Average of five array elements (8086)
; Adds five bytes at 2000H-2004H and divides the sum by 5.
; Quotient is returned in AL and remainder in AH.
CODE SEGMENT
    ASSUME CS:CODE
START:
    MOV SI, 2000H      ; Point to first element
    MOV AX, 0000H      ; Clear 16-bit dividend
    MOV AL, [SI]       ; Load first byte
    MOV CL, 04H        ; Four more elements
LOOP1:
    INC SI             ; Point to next element
    ADD AL, [SI]       ; Add next byte
    ADC AH, 00H        ; Include carry in high byte
    DEC CL             ; Decrement counter
    JNZ LOOP1          ; Repeat five-element sum
    MOV BL, 05H        ; Divisor = 5
    DIV BL             ; AX / BL: quotient AL, remainder AH
    INT 03H            ; Stop for inspection
CODE ENDS
END START

; Output: AL = integer average, AH = remainder.
; Example 1,2,3,4,5 -> AL = 03H, AH = 00H.
