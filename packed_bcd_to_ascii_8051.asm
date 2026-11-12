; Program      : Packed BCD to 2 ASCII & place them in R2 & R6 (8051)
; Description  : Converts the packed BCD value 29H into its two ASCII
;                digits: R6 = lower digit, R2 = upper digit.
; Source       : Lab record, page 18

    MOV A, #29H      ; packed BCD 29H
    MOV R2, A        ; keep a copy in R2
                     ; NOTE: a crossed-out MOV line appears in the
                     ; record here; it is omitted.
    ANL A, #0FH      ; mask lower nibble
    ORL A, #30H      ; convert to ASCII
    MOV R6, A        ; lower ASCII digit
    MOV A, R2
    ANL A, #0F0H     ; mask upper nibble
    SWAP A           ; bring it to the lower nibble
    ORL A, #30H      ; convert to ASCII
    MOV R2, A        ; upper ASCII digit

; Input : A = 29H (packed BCD)
; Output: R2 = 32H ('2'), R6 = 39H ('9')
