; Program      : Add corresponding elements of an array (8086)
; Description  : Adds five byte elements beginning at 2000H.
;                The 16-bit sum is returned in AX.
; Assembler    : 8086 (MASM/TASM syntax)

CODE SEGMENT
    ASSUME CS:CODE
START:
    MOV SI, 2000H      ; SI points to the first array element
    MOV AX, 0000H      ; clear the 16-bit accumulator
    MOV AL, [SI]       ; load the first element
    MOV CL, 04H        ; four elements remain
LOOP1:
    INC SI             ; point to the next element
    ADD AL, [SI]       ; add the next byte to the low byte
    ADC AH, 00H        ; propagate carry into the high byte
    DEC CL             ; decrement remaining-element count
    JNZ LOOP1          ; repeat until all five elements are added
    INT 03H            ; breakpoint for result inspection
CODE ENDS
END START

; Output:
; AX contains the sum of bytes at 2000H through 2004H.
; Example values 01H, 02H, 03H, 04H, 05H produce AX = 000FH.
