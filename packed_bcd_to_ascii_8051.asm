; Program: Convert packed BCD to ASCII (8051)
; Packed BCD input at 40H; tens and units ASCII at 50H and 51H.
            ORG 0000H
            MOV A, 40H       ; Read packed BCD byte
            ANL A, #0F0H     ; Isolate tens nibble
            SWAP A           ; Move tens digit to low nibble
            ADD A, #30H      ; Convert digit to ASCII
            MOV 50H, A       ; Store tens ASCII
            MOV A, 40H       ; Read packed BCD again
            ANL A, #0FH      ; Isolate units nibble
            ADD A, #30H      ; Convert digit to ASCII
            MOV 51H, A       ; Store units ASCII
STOP:       SJMP STOP        ; Stop for inspection
            END

; Example: 69H -> [50H]=36H ('6'), [51H]=39H ('9').
