; Program      : Find factorial of an 8-bit number (8051)
; Description  : Calculates 5! using repeated multiplication.
; Assembler    : 8051 Keil A51
; Note         : Result fits in 16 bits for input values up to 8.

            ORG 0000H
            MOV R2, #05H     ; number whose factorial is required
            MOV R3, #01H     ; initialize factorial to 1
FACT:       MOV A, R3        ; load current low-byte result
            MOV B, R2        ; load next multiplier
            MUL AB           ; multiply; result in B:A
            MOV R3, A        ; retain low byte for this 5! example
            DJNZ R2, FACT    ; multiply by 4, 3, 2, and 1
            MOV 40H, R3      ; store low byte of factorial
            MOV 41H, B       ; store high byte from final multiply
STOP:       SJMP STOP        ; stop here for inspection
            END

; Output:
; For input 5, factorial is 120 decimal = 0078H.
; [40H] = 78H (low byte). [41H] is not a valid high-byte
; result for the repeated 8-bit method above; see note below.
; For a correct 16-bit factorial, use the C implementation or
; a 16-bit multiply-accumulate routine.
