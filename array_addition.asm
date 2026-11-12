; Program: Add corresponding elements of an array (8086)
; Adds five bytes beginning at 2000H. Sum is returned in AX.
CODE SEGMENT
    ASSUME CS:CODE
START:
    MOV SI, 2000H      ; Point to first array element
    MOV AX, 0000H      ; Clear 16-bit sum
    MOV AL, [SI]       ; Load first byte
    MOV CL, 04H        ; Four more elements
LOOP1:
    INC SI             ; Next element
    ADD AL, [SI]       ; Add byte to low sum
    ADC AH, 00H        ; Propagate carry to high byte
    DEC CL             ; Decrement count
    JNZ LOOP1          ; Repeat until all elements are added
    INT 03H            ; Stop for result inspection
CODE ENDS
END START

; Output: AX = sum of bytes at 2000H-2004H.
; Example 01H,02H,03H,04H,05H -> AX = 000FH.
