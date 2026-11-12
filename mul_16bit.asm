; Program      : Multiply two 16-bit numbers (8086)
; Description  : 16-bit multiplication. Loads 1329H into AX and 3715H
;                into BX, then multiplies BX with AX (MUL BX).
; Assembler    : 8086 (MASM/TASM syntax, run in DOSBox)
; Source       : Lab record, page 09

ASSUME CS:CODE       ; CS register points to segment named code
CODE SEGMENT         ; CS definition start
START:               ; entry point of program
    MOV AX, 1329H    ; loads 1329H into AX
    MOV BX, 3715H    ; loads 3715H into BX
    MUL BX           ; multiplies BX with AX (product -> DX:AX)
    INT 03H          ; interrupts to terminate / debug the program
CODE ENDS            ; end of CS
END START            ; specifies end of program

; Input:
;   AX <- 1329H
;   BX <- 3715H
; Output:
;   AX = 4A9DH
;   BX = 3715H
;   DX = 0043H
;   DX:AX = 0043 4A9D H
