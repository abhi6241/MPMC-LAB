; Program      : Divide two 16-bit numbers (8086)
; Description  : 16-bit division. Loads 5345H into AX and 2356H into
;                BX, then divides AX by BX (DIV BX).
; Assembler    : 8086 (MASM/TASM syntax, run in DOSBox)
; Source       : Lab record, page 10

ASSUME CS:CODE       ; CS register points to segment named code
CODE SEGMENT         ; start of CS definition
START:               ; entry point of program
    MOV AX, 5345H    ; loads 5345H into AX
    MOV BX, 2356H    ; loads 2356H into BX
    DIV BX           ; BX divides AX (quotient -> AX, remainder -> DX)
    INT 03H          ; interrupts to terminate / debug the program
CODE ENDS            ; end of CS
END START            ; specifies end of program

; Input:
;   AX <- 5345H
;   BX <- 2356H
; Output:
;   AX = 0002H
;   BX = 2356H
;   DX = 089DH
