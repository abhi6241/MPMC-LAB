; Program      : Transfer 5 bytes of data from one memory location to another (8086)
; Description  : Copies 5 bytes from 2000H to 5000H using SI and DI.
; Assembler    : 8086 (MASM/TASM syntax, run in DOSBox)
; Source       : Lab record, page 11

ASSUME CS:CODE       ; CS register points to segment named code
CODE SEGMENT         ; CS definition starts
START:               ; entry point of program
    MOV SI, 2000H    ; loads 2000H to SI
    MOV DI, 5000H    ; loads 5000H to DI
    MOV CL, 05H      ; loads no. of bytes to transfer to CL
LOOP1:
    MOV AL, [SI]     ; loads data at SI to AL
    MOV [DI], AL     ; loads AL to data of DI
    INC SI           ; SI increases by 1
    INC DI           ; DI increases by 1
    DEC CL           ; CL decreases by 1
    JNZ LOOP1        ; jump to LOOP1, if not zero
    INT 03H          ; interrupts to terminate program
CODE ENDS            ; end of CS
END START            ; specifies end of program

; Input : 075A:2000 = 01 02 03 04 05
; Output: 075A:5000 = 01 02 03 04 05
;         AX = FF05H, SI = 2005H, DI = 5005H, CX = 0000H
