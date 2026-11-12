; Program      : Convert packed BCD digits to ASCII (8051)
; Description  : Converts the two nibbles of packed BCD at 40H.
; Assembler    : 8051 Keil A51
; Output       : Tens ASCII at 50H, units ASCII at 51H.

            ORG 0000H
            MOV A, 40H       ; read packed BCD byte
            ANL A, #0F0H     ; isolate tens nibble
            SWAP A           ; move tens digit to low nibble
            ADD A, #30H      ; convert digit to ASCII
            MOV 50H, A       ; store tens ASCII character

            MOV A, 40H       ; read packed BCD byte again
            ANL A, #0FH      ; isolate units nibble
            ADD A, #30H      ; convert digit to ASCII
            MOV 51H, A       ; store units ASCII character
STOP:       SJMP STOP        ; stop here for inspection
            END

; Example: [40H] = 69H gives [50H] = 36H ('6'),
; [51H] = 39H ('9').
