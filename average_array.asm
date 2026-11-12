; Program      : Average of the five data bytes at 2000H (8086)
; Description  : Same program as the record's "average value of data
;                at SI" (kept as a separate copy under this name):
;                add five bytes from 2000H, then DIV BL (BL = 05H).
; Assembler    : 8086 (MASM/TASM syntax, run in DOSBox)
; Source       : Lab record, page 14

ASSUME CS:CODE       ; CS register points to segment named code
CODE SEGMENT         ; CS definition starts
START:               ; entry point of program
    MOV AX, 0000H    ; loads 0000H (address) to AX
    MOV SI, 2000H    ; loads 2000H to SI
    MOV CL, 05H      ; loads 05H to CL
    MOV BL, 05H      ; loads 05H to BL
AVG:
    ADD AL, [SI]     ; adds data at SI with AL and stores in AL
    INC SI           ; increments SI by 1
    DEC CL           ; decrements CL by 1
    JNZ AVG          ; jumps, if not zero
    DIV BL           ; divides AX with BL into AX
    INT 03H          ; interrupts to terminate the program
CODE ENDS            ; end of CS
END START            ; end of program

; Input : 075A:2000 = 01 02 03 04 05
; Output: AX = 0003H, BX = 0005H, DX = 0000H, SI = 2005H, CX = 0000H
