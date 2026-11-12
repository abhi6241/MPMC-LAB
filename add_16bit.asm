; Program      : Add two 16-bit numbers (8086)
; Description  : 16-bit addition. Loads 4326H into AX and 1012H into
;                BX, then adds BX into AX.
; Assembler    : 8086 (MASM/TASM syntax, run in DOSBox)
; Source       : Lab record, page 07

ASSUME CS:CODE       ; CS register points to segment named code
CODE SEGMENT         ; CS definition starts
START:               ; entry point of program
    MOV AX, 4326H    ; loads 4326H into AX
    MOV BX, 1012H    ; loads 1012H into BX
    ADD AX, BX       ; adds BX into AX
    INT 03H          ; interrupts to terminate / debug the program
CODE ENDS            ; end of CS
END STARTS           ; NOTE: record writes "END STARTS"; the entry
                     ; point label defined above is START

; Input:
;   AX <- 4326H
;   BX <- 1012H
; Output:
;   AX = 5338H
;   BX = 1012H
