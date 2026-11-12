; Program      : Add two 8-bit numbers (8086)
; Description  : 8-bit addition. Loads 43H into AL and 42H into BL,
;                then adds BL into AL.
; Assembler    : 8086 (MASM/TASM syntax, run in DOSBox)
; Source       : Lab record, page 03

ASSUME CS:CODE       ; tells that CS register points to segment named code
CODE SEGMENT         ; start of code segment definition
START:               ; entry point of program
    MOV AL, 43H      ; loads the value 43H into AL register
    MOV BL, 42H      ; loads the value 42H into BL
    ADD AL, BL       ; adds BL into AL value
    INT 03H          ; interrupts to terminate or debug the program
CODE ENDS            ; end of code segment
END START            ; specifies end of program & entry point [START]

; Input:
;   AL <- 43H
;   BL <- 42H
; Output:
;   AX = FF85H  (AL = 43H + 42H = 85H)
;   BX = 0042H
