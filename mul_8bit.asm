; Program      : Multiply two 8-bit numbers (8086)
; Description  : 8-bit multiplication. Loads 15H into AL and 32H into
;                BL, then multiplies BL with AL (MUL BL).
; Assembler    : 8086 (MASM/TASM syntax, run in DOSBox)
; Source       : Lab record, page 05

ASSUME CS:CODE       ; CS register points to segment named code
CODE SEGMENT         ; start of code segment definition
START:               ; entry point of program
    MOV AL, 15H      ; loads 15H into AL
    MOV BL, 32H      ; loads 32H into BL
    MUL BL           ; multiplies BL with AL (product -> AX)
    INT 03H          ; interrupts to terminate / debug the program
CODE ENDS            ; end of code segment
END STARTS           ; NOTE: record writes "END STARTS"; the entry
                     ; point label defined above is START

; Input:
;   AL <- 15H
;   BL <- 32H
; Output:
;   AX = 041AH  (15H x 32H = 041AH)
;   BX = 0032H
