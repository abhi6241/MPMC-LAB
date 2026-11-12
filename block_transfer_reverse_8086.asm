; Program      : Transfer 5 bytes of data from one location to another in reverse direction (8086)
; Description  : Copies 5 bytes from 2004H (downwards) to 5000H
;                (upwards), so the block arrives reversed.
; Assembler    : 8086 (MASM/TASM syntax, run in DOSBox)
; Source       : Lab record, page 12

ASSUME CS:CODE       ; CS register points to segment named code
CODE SEGMENT         ; CS definition starts
START:               ; entry point of program
    MOV SI, 2004H    ; loads 2004H to SI
    MOV DI, 5000H    ; loads 5000H to DI
    MOV CL, 05H      ; loads 05H to CL
LOOP1:
    MOV AL, [SI]     ; loads data at SI to AL
    MOV [DI], AL     ; loads AL to data of DI
    DEC SI           ; decrements SI
    INC DI           ; increments DI
    DEC CL           ; decrements CL
    JNZ LOOP1        ; jumps to LOOP1, if not zero
    INT 03H          ; interrupts to terminate the program
CODE ENDS            ; end of CS
END START            ; specifies end of program

; Input : 075A:2000 = 01 02 03 04 05
; Output: 075A:5000 = 05 04 03 02 01
;         AX = FF01H, SI = 1FFFH, DI = 5005H, CX = 0000H
