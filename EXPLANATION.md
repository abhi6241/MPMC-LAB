# Program Explanations

Detailed explanation for every program. Each heading matches a file name in the project folder.

## 8086 Assembly

## add_8bit.asm

Loads 48H into AL and 42H into BL, then `ADD BL, AL` adds AL into BL in place, leaving BL = 8AH. 8-bit addition uses `AL`/`BL` directly since both operands fit in one byte; the carry (if any) would land in the CF flag. The program stops at `INT 03H` so registers can be inspected.

## add_16bit.asm

Loads 2222H into AX and 1111H into BX, then `ADD AX, BX` computes the sum directly in AX = 3333H. Same idea as the 8-bit version but with full 16-bit registers, which can hold values up to FFFFH without a carry.

## sub_8bit.asm

Loads 48H into AL and 42H into BL, then `SUB BL, AL` computes BL = 48H − 42H = 06H. Subtraction sets the CF flag if the result would go negative (borrow), which is how unsigned underflow is detected.

## sub_16bit.asm

Loads 2222H into AX and 1111H into BX, then `SUB AX, BX` leaves AX = 1111H. Identical logic to the 8-bit version; 16-bit subtraction simply operates on whole registers at once.

## mul_8bit.asm

`MUL BL` is an implicit-operand instruction: it always multiplies `AL × BL` and places the 16-bit product in `AX`. Here 12H × 10H = 0120H. Two 8-bit values can produce a 16-bit result, which is why the product needs the full AX even though both inputs fit in a byte.

## mul_16bit.asm

`MUL BX` multiplies `AX × BX` and puts the 32-bit product in the register pair `DX:AX` (DX = high 16 bits, AX = low 16 bits). With 1234H × 5678H = 06260060H, DX receives 0626H and AX receives 0060H. A 16-bit multiply can overflow 16 bits, hence the pair.

## div_8bit.asm

`DIV BL` divides the 16-bit value in `AX` by BL: the quotient lands in AL and the remainder in AH. AX = 0045H (69) ÷ 0AH (10) gives AL = 06H and AH = 09H. The critical detail is that AH is part of the dividend — it must be 0 (as it is here, since AX = 0045H) or it corrupts the result. Dividing by zero raises INT 0.

## div_16bit.asm

`DIV BX` divides the 32-bit value in `DX:AX` by BX: quotient in AX, remainder in DX. The dividend here is 00010000H (DX = 0001H is the high word, so 65536), divided by 0010H (16), giving AX = 1000H and DX = 0. Unlike the add/subtract programs, the `MOV DX, ...` line is not optional — DX is genuinely part of the dividend.

## avg.asm (original, not corrected)

Intended to average 5 bytes stored at 2000H–2004H. The loop works: SI starts at 2000H, the first byte is loaded, then a 4-iteration loop (`MOV CL, 04H` + `DEC CL`/`JNZ`) adds the bytes at 2001H–2004H. But the program fails at the divide: `MOV AX, [SI]` loads a word, leaving garbage (the byte at 2001H) in AH, and `BL` is never initialized, so `DIV BL` divides by zero and raises INT 0. To fix it: `MOV AL, [SI]`, then before the divide `MOV BL, 05H` and `MOV AH, 00H`.

## 8051 Assembly

## move_data_ram.asm

Demonstrates the two main addressing modes with the same result. First half: direct addressing — `MOV 40H, A` writes the accumulator straight into RAM cell 40H (and 41H–44H), one instruction per cell. Second half: indirect addressing — `R1` is loaded with the address 40H and `MOV @R1, A` writes through the pointer, with `INC R1` walking it through 40H→44H. Both halves end with 65H in cells 40H–44H; the second overwrites the first.

## block_transfer.asm

A block-copy loop: `R0` points to the source (40H), `R1` to the destination (50H), and `R2` counts 10 bytes. Each pass copies one byte through the accumulator (`MOV A, @R0` then `MOV @R1, A`), advances both pointers with `INC`, and `DJNZ R2, LOOP1` decrements the counter and jumps back while it is nonzero. DJNZ (decrement and jump if not zero) is the 8051's compact counted-loop instruction. After the loop, 40H–49H have been duplicated to 50H–59H.

## clear_ram.asm

Fills 16 RAM cells (60H–6FH) with 00H. `CLR A` zeroes the accumulator, `R1` points at 60H, and `R2` counts 16. The loop writes 00H through the pointer (`MOV @R1, A`), advances with `INC R1`, and `DJNZ R2, AGAIN` repeats until the counter is exhausted. A pointer + counter loop is the standard way to clear a range when the cells are not contiguous from address 0.

## ARM Assembly

## add_memory_arm.asm

Reads two 32-bit words from RAM and stores their sum. `LDR R0, =0x20000000` loads the *address* into a register (the `=` makes it a literal-pool load), then `LDR R1, [R0]` reads the value at that address. The same two-step pattern fetches the second number from 0x20000010. `ADD R4, R1, R3` is ARM's classic three-operand form — destination first, then both sources. `STR R4, [R5]` writes the sum back to 0x200000FF, and `HERE B HERE` parks the CPU in an infinite loop, which is the ARM equivalent of a breakpoint stop.

## add_subtract_arm.asm

Pure register arithmetic with no memory involvement: `R0` = 22222222H, `R1` = 11111111H, then `ADD R2, R0, R1` → R2 = 33333333H and `SUBS R3, R0, R1` → R3 = 11111111H. The `S` suffix on SUBS sets the condition flags (N, Z, C, V); nothing reads them here, so it behaves like a plain SUB. Results stay in registers, then the program loops forever at HERE.

## block_copy_arm.asm

Copies 5 words from 0x20000000–0x20000010 to 0x20000020–0x20000030 using ARM's post-indexed addressing. `LDR R3, [R0], #4` loads the word at [R0] *and then* adds 4 to R0; `STR R3, [R1], #4` does the same for R1. Because the pointer update is built into the load/store, the loop body is just two instructions plus `SUBS R2, R2, #1` / `BNE LOOP` — the counter is decremented and the Z flag it sets drives the BNE branch.

## 8051 Embedded C

## led_blink.c

Blinks one LED wired to pin P2.5, declared with `sbit led = P2^5;` so the code can toggle a single pin of the port. `main` loops forever: `led = 0` pulls the pin low (LED on, active-low wiring), `delay(500)` waits ~500 ms, `led = 1` turns it off, wait again. The `delay()` function is the standard Keil busy-wait — 1275 inner iterations ≈ 1 ms at 12 MHz, so `delay(t)` ≈ t ms.

## led_blink_port.c

Same timing as led_blink.c, but writes the whole P2 register instead of one bit: `P2 = 0xFF` (all pins high, all LEDs off) and `P2 = 0x00` (all pins low, all LEDs on). Demonstrates port-wide output — one assignment drives all 8 LEDs at once.

## led_blink_nibble.c

Alternates the two halves of port P2. `P2 = 0x0F` sets the lower four pins high (lower LEDs off) and the upper four low (upper LEDs on); `P2 = 0xF0` swaps it. Each state lasts ~500 ms. Useful for showing that a byte written to a port is really eight independent bits.

## switch_led.c

Polled input: `sbit sw = P1^5` reads a switch, `sbit led = P2^5` drives an LED. The endless loop reads the pin continuously — if the switch line is high the LED pin is driven low (on), otherwise high (off). There is no delay or interrupt; the LED follows the switch as fast as the loop can spin.

## seven_segment_count.c

Counts 0–9 on a common-cathode seven-segment display wired to P2 (segments a–g on bits 0–6, bit 7 unused, segment high = on). The array `a[]` holds the segment pattern for each digit — for example 0x3F lights segments a–f for "0", 0x7F lights all seven for "8". The loop steps through the array, puts each pattern on the port, holds ~100 ms, and wraps around forever. For a common-anode display the patterns must be inverted.

## seven_segment_even_count.c

Same as the 0–9 counter but the array holds only the patterns for the even digits 0, 2, 4, 6, 8 (0x3F, 0x5B, 0x66, 0x7D, 0x7F) and the loop runs 5 times per cycle instead of 10. Shows how the lookup-table approach makes changing the sequence trivial — only the table and the loop bound change.

## stepper_wave_drive.c

Rotates a stepper motor in wave drive mode via the four phase lines on P2.0–P2.3 (through a driver such as ULN2003, active-low). In wave drive exactly one coil is energized per step, so each pattern in the arrays has exactly one bit low: a[] = 08, 01, 02, 04 steps through coils in one order, b[] = 04, 02, 01, 08 in the reverse order. The switch on P3.1 (declared with sbit) selects which array the loop uses, so rotation direction can be flipped at any time. Each step is held ~200 ms; wave drive gives the lowest torque but the simplest sequencing.

## stepper_full_step.c

Full-step drive energizes two adjacent coils per step — the patterns 0x0C (P2.3+P2.2), 0x06 (P2.2+P2.1), 0x03 (P2.1+P2.0), 0x09 (P2.0+P2.3) always have exactly two adjacent bits low. This gives more torque than wave drive at the same step rate, at the cost of higher current (two coils on). The sequence cycles forever with ~200 ms per step, rotating forward.

## stepper_half_step.c

Half-step drive interleaves the wave-drive and full-step sequences: 08, 0C, 04, 06, 02, 03, 01, 09 — alternating between one coil and two adjacent coils. The rotor advances half a step each time, giving 8 steps per cycle instead of 4 — twice the angular resolution and smoother motion, with intermediate torque. The program unrolls the 8 patterns with a delay between each, running forever.

## lcd_display.c

Drives a 16x2 HD44780 LCD in 8-bit mode: data bus on P2, RS on P3.0 (0 = command, 1 = character), EN on P3.1, R/W tied to ground. The key detail is the enable pulse — the LCD latches whatever is on the data bus on the falling edge of EN, so both `cmd_lcd` and `write_lcd` set the bus, pulse EN high, delay, then drop it low. `init_lcd` sends the standard setup sequence (0x38 = 8-bit/2 lines, 0x0E = display on, 0x06 = auto-increment, 0x01 = clear). `main` clears the screen, prints "ECE-B" on line 1, moves the cursor with 0xC3 (line 2, position 3), prints "MPMC-LAB", and the while(1) loop re-displays it every ~500 ms.
