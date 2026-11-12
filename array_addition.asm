; Program      : Multibyte addition (8086)
; Description  : Adds the five bytes stored from 2000H; the sum is
;                kept in AL (AX low byte).
; Assembler    : 8086 (MASM/TASM syntax, run in DOSBox)
; Source       : Lab record, page 13

ASSUME CS:CODE       ; CS register points to segment named code
CODE SEGMENT         ; CS definition starts
START:               ; entry point of program
    MOV AX, 0000H    ; loads 0000H to AX
    MOV SI, 2000H    ; loads 2000H to SI
    MOV CL, 05H      ; loads 05H to CL
LOOP1:
    ADD AL, [SI]     ; adds data at SI into AL
    INC SI           ; increment of SI by 1
    DEC CL           ; decrement of CL by 1
    JNZ LOOP1        ; jumps to LOOP1, if not zero
    INT 03H          ; interrupts to terminate the program
CODE ENDS            ; CS ends
END STARTS           ; NOTE: record writes "END STARTS"; the entry
                     ; point label defined above is START

; Input : 075A:2000 = 01 02 03 04 05
; Output: AX = 000FH, SI = 2005H, CX = 0000H
