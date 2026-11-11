; Program      : Move data into internal RAM (8051)
; Description  : Stores the value 55H at RAM locations 40H-44H using
;                direct addressing, then stores 65H at the same
;                locations using indirect addressing (register R1).

; Direct addressing mode
; The destination address is given directly in the instruction

MOV A, #55H          ; load immediate value 55H into accumulator A
MOV 40H, A           ; copy A into internal RAM location 40H
MOV 41H, A           ; copy A into internal RAM location 41H
MOV 42H, A           ; copy A into internal RAM location 42H
MOV 43H, A           ; copy A into internal RAM location 43H
MOV 44H, A           ; copy A into internal RAM location 44H

; Register Indiret addressing mode
; R1 holds the address; @R1 accesses the RAM location it points to

MOV A, #65H          ; load immediate value 65H into accumulator A
MOV R1, #40H         ; R1 = starting address 40H (pointer)
MOV @R1, A           ; store 65H at address pointed by R1 (40H)
INC R1               ; increment pointer to 41H
MOV @R1, A           ; store 65H at 41H
INC R1               ; increment pointer to 42H
MOV @R1, A           ; store 65H at 42H
INC R1               ; increment pointer to 43H
MOV @R1, A           ; store 65H at 43H
INC R1               ; increment pointer to 44H
MOV @R1, A           ; store 65H at 44H

; Output:
; First section (direct addressing): 40H-44H = 55H
; Second section (indirect addressing) overwrites them: 40H-44H = 65H
; Final state after execution:
;   (40H) = 65H, (41H) = 65H, (42H) = 65H, (43H) = 65H, (44H) = 65H
;   A  = 65H
;   R1 = 44H (pointer left at the last address written)
