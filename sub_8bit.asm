; Program      : Subtract two 8-bit numbers (8086)
; Description  : 8-bit subtraction. Loads 72H into AL and 41H into BL,
;                then subtracts BL from AL.
; Assembler    : 8086 (MASM/TASM syntax, run in DOSBox)
; Source       : Lab record, page 04

ASSUME CS:CODE       ; CS register points to segment named code
CODE SEGMENT         ; start of code segment registers
START:               ; entry point of program
    MOV AL, 72H      ; loads value 72H into AL
    MOV BL, 41H      ; loads value 41H into BL
    SUB AL, BL       ; subtracts BL from AL value
    INT 03H          ; interrupts to terminate / debug the program
CODE ENDS            ; end of code segment
END STARTS           ; NOTE: record writes "END STARTS"; the entry
                     ; point label defined above is START

; Input:
;   AL <- 72H
;   BL <- 41H
; Output:
;   AX = FF31H  (AL = 72H - 41H = 31H)
;   BX = 0041H
