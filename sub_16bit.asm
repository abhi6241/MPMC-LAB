; Program      : Subtract two 16-bit numbers (8086)
; Description  : 16-bit subtraction. Loads 7321H into AX and 1329H
;                into BX, then subtracts BX from AX.
; Assembler    : 8086 (MASM/TASM syntax, run in DOSBox)
; Source       : Lab record, page 08

ASSUME CS:CODE       ; CS register points to segment named code
CODE SEGMENT         ; start of CS definition
START:               ; entry point of program
    MOV AX, 7321H    ; loads 7321H into AX
    MOV BX, 1329H    ; loads 1329H into BX
    SUB AX, BX       ; subtracts BX from AX
    INT 03H          ; interrupts to terminate / debug the program
CODE ENDS            ; end of CS
END START            ; specifies end of program

; Input:
;   AX <- 7321H
;   BX <- 1329H
; Output:
;   AX = 5FF8H
;   BX = 1329H
