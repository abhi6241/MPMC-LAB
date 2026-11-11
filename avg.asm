; Program      : Average of 5 numbers
; Description  : Reads 5 bytes stored from memory location 2000H
;                and computes their average.

CODE SEGMENT
    ASSUME CS: CODE
START:
    MOV SI, 2000H      ; SI points to first number at 2000H
    MOV CL, 04H        ; loop counter: 4 more numbers to add
    MOV AX, 0000H      ; initialize AX
    MOV AX, [SI]       ; load first value from memory
LOOP1:
    INC SI             ; move pointer to next number
    ADD AL, [SI]       ; add next number to sum in AL
    DEC CL             ; decrement counter
    JNZ LOOP1          ; repeat until all 4 numbers added
    DIV BL             ; divide sum by count in BL
    INT 03H            ; breakpoint: stop so result can be inspected
CODE ENDS
END START

; Output:
; Loop result: AL = sum of the 5 bytes at 2000H-2004H,
;              AH = byte at 2001H (left over from MOV AX, [SI])
; DIV BL  ->  BL is still 00H (never initialized), so this is a
;             divide-by-zero: INT 0 (divide overflow) fires and the
;             average is NOT produced.
; NOTE: To get the intended output, set BL = 05H and clear AH
;       before the divide (see avg_fixed.asm), giving:
;       AL = average, AH = remainder
