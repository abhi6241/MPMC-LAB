; Program      : Move data item 55H into RAM 40H-44H (8051)
; Description  : (A) direct addressing mode and (B) register indirect
;                addressing mode. In (B) the data item is 65H.
; Source       : Lab record, page 16

; --- (A) Direct addressing mode ---
    MOV A, #55H
    MOV 40H, A
    MOV 41H, A
    MOV 42H, A
    MOV 43H, A
    MOV 44H, A

; Input : [40H] <- 55H, [41H] <- 55H, [42H] <- 55H,
;         [43H] <- 55H, [44H] <- 55H
; Output: RAM 40H-44H = 55 55 55 55 55
;         R1 = 44H, Acc = 55H

; --- (B) Register indirect addressing mode ---
    MOV A, #65H
    MOV R1, #40H
    MOV @R1, A
                     ; NOTE: a crossed-out MOV line appears in the
                     ; record here; it is omitted.
    INC R1
    MOV @R1, A
    INC R1
    MOV @R1, A
    INC R1
    MOV @R1, A
    INC R1
    MOV @R1, A

; Input : R1 <- 40H, A <- 65H
; Output: RAM 40H-44H = 65 65 65 65 65
;         R1 = 44H, Acc = 65H
