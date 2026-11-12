; Program      : Divide two 8-bit numbers (8086)
; Description  : 8-bit division. Loads 15H into AX and 7H into BX,
;                then divides AX by BX (DIV BX).
; Assembler    : 8086 (MASM/TASM syntax, run in DOSBox)
; Source       : Lab record, page 06

ASSUME CS:CODE       ; CS register points to segment named code
CODE SEGMENT         ; start of CS definition
START:               ; entry point of program
    MOV AX, 0015H    ; loads 15H into AX
    MOV BX, 7H       ; loads 7H into BX
    DIV BX           ; BX divides AX (quotient -> AL, remainder -> AH)
    INT 03H          ; interrupts to terminate / debug the program
CODE ENDS            ; end of CS
END START            ; specifies end of program & entry point [START]

; Input:
;   AX <- 15H
;   BX <- 7H
; Output:
;   AX = 0003H  =>  AL <- 0003H ; AH <- 0000H
;   BX = 0007H
;   DX = 0000H
