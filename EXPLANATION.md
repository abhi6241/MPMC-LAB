# Program Explanations

Detailed explanation for every program. Each heading matches a file name in
the project folder. Programs marked "(lab record)" are transcribed from the
scanned handwritten record — result values quoted are the record's observed
results, preserved as written; a few printed results in the record do not
recompute exactly from the printed inputs and are deliberately not corrected.

## 8086 Assembly

## add_8bit.asm (lab record, page 3)

Loads 43H into AL and 42H into BL, then `ADD AL, BL` adds BL into AL, giving
AL = 85H. Note that the record's output shows AX = FF85H: `MOV AL` only
changes the low byte, so AH keeps whatever value it held in the DOSBox session
(FFH here) — the sum itself is just 85H. The program stops at `INT 03H`
(breakpoint interrupt) so registers can be inspected.

## sub_8bit.asm (lab record, page 4)

Loads 72H into AL and 41H into BL, then `SUB AL, BL` computes AL = 72H − 41H =
31H. As in the addition program, AH is untouched, so AX reads FF31H. The
carry flag would be set if the result went negative (unsigned borrow).

## mul_8bit.asm (lab record, page 5)

`MUL BL` is an implicit-operand instruction: it always multiplies `AL × BL`
and places the 16-bit product in `AX`. Here 15H (21) × 32H (50) = 041AH
(1050). Two byte-size inputs can overflow a byte, which is why the product
needs the full AX.

## div_8bit.asm (lab record, page 6)

Loads AX = 0015H and BX = 7H, then `DIV BX`. Because the operand is BX (a
16-bit register), this is a *word* divide: DX:AX ÷ BX, quotient in AX,
remainder in DX. 0015H (21) ÷ 7 = 3 remainder 0, matching the record's
AX = 0003H, DX = 0000H. With a word divide there is no separate AH issue —
the whole AX is the dividend. Dividing by zero raises INT 0.

## add_16bit.asm (lab record, page 7)

Loads 4326H into AX and 1012H into BX, then `ADD AX, BX` computes the sum
directly in AX = 5338H. Same idea as the 8-bit version but with full 16-bit
registers.

## sub_16bit.asm (lab record, page 8)

Loads 7321H into AX and 1329H into BX, then `SUB AX, BX` leaves AX = 5FF8H.
Identical logic to the 8-bit version; 16-bit subtraction operates on whole
registers at once.

## mul_16bit.asm (lab record, page 9)

`MUL BX` multiplies `AX × BX` and puts the 32-bit product in the register
pair `DX:AX` (DX = high 16 bits, AX = low 16 bits) — a 16-bit multiply can
overflow 16 bits, hence the pair. The record's observed result is
DX = 0043H, AX = 4A9DH, transcribed as written.

## div_16bit.asm (lab record, page 10)

`DIV BX` divides the 32-bit value in `DX:AX` by BX: quotient in AX, remainder
in DX. The record's operands are AX = 5345H, BX = 2356H; the observed result
is AX = 0002H (quotient), DX = 089DH (remainder). Here DX starts at 0 (it is
cleared by the run environment) but in general DX is genuinely part of the
dividend and must be initialized before a word divide.

## block_transfer_8086.asm (lab record, page 11)

A pointer + counter copy loop: SI points at the source block (2000H), DI at
the destination (5000H), and CL counts 5 bytes. Each pass moves one byte
through AL (`MOV AL, [SI]` then `MOV [DI], AL`), advances both pointers with
INC, and `DEC CL` / `JNZ LOOP1` repeats until CL is exhausted. With input
075A:2000 = 01 02 03 04 05, the record shows 075A:5000 = 01 02 03 04 05
after the loop.

## block_transfer_reverse_8086.asm (lab record, page 12)

The same copy loop walked in opposite directions: SI starts at the *end* of
the source (2004H) and is decremented, while DI starts at the *start* of the
destination (5000H) and is incremented. Reading the source backwards while
writing forwards delivers the block reversed: input 01 02 03 04 05 arrives as
05 04 03 02 01. Useful when blocks overlap or order must be inverted.

## array_addition.asm (lab record, page 13)

Adds five bytes stored from 2000H. AX is zeroed first (so AH = 00H), SI
points at 2000H, and CL counts 5. Each pass executes `ADD AL, [SI]`,
advances SI, and `DEC CL` / `JNZ LOOP1` repeats. With input
075A:2000 = 01 02 03 04 05 the sum is 0FH, giving AX = 000FH and SI ending
at 2005H. Keeping AH = 0 is what makes AX read cleanly as the byte sum.

## avg.asm (lab record, page 14)

Extends the multibyte addition with a divide: the five bytes at 2000H are
added into AL exactly as above (BL is loaded with 05H *before* the loop),
then `DIV BL` divides AX by BL — quotient in AL, remainder in AH. Because
AX was 000FH (AH = 00H) before the divide, 15 ÷ 5 gives AX = 0003H with no
remainder, matching the record. The classic pitfall this program avoids:
if AH held garbage, the word divide would produce a wrong quotient.

## average_array.asm (lab record, page 14)

An identical second copy of the record's "average value of data at SI"
listing, kept under this name (the repo had both names before the record
sync; the record contains only one such program). See avg.asm.

## 8051 Assembly

## alu_operations_8051.asm (lab record, page 15)

Takes two operands from RAM — [40H] = 32H and [41H] = 06H in the record —
and runs the full ALU set on them, storing every result in RAM:
ADD → 42H, SUBB (carry cleared first) → 43H, MUL AB (low byte in A, high
byte in B) → 44H/45H, DIV AB (quotient in A, remainder in B) → 46H/47H,
ANL → 48H, XRL → 49H, and RL (rotate accumulator left one bit) → 4AH.
Note SUBB subtracts *with borrow*, so `CLR C` before it is required for a
plain difference. The record's result table (42H = 38H, 43H = 2CH,
44H = 1BH, 45H = 00H, 46H = 03H, 47H = 00H, 48H = 01H, 49H = 0AH, 4AH = 12H)
is reproduced as written.

## move_data_ram.asm (lab record, page 16, part a)

Demonstrates the two main addressing modes with the same shape of result.
Part (A), direct addressing: `MOV A, #55H` then one `MOV 40H, A`-style
instruction per cell writes 55H straight into RAM 40H–44H — the address is
given directly in the instruction. Part (B), register indirect addressing:
R1 is loaded with the *address* 40H and `MOV @R1, A` writes 65H through the
pointer, with `INC R1` walking it 40H→44H. Both halves end with the same
value in all five cells (55H, then overwritten by 65H); the record's
crossed-out extra MOV line is omitted.

## block_transfer.asm (lab record, page 16, part b)

A block-copy loop: `R0` points to the source (40H), `R1` to the destination
(50H), and `R2` counts 10 bytes. Each pass copies one byte through the
accumulator (`MOV A, @R0` then `MOV @R1, A`), advances both pointers with
INC, and `DJNZ R2, L1` decrements the counter and jumps back while it is
nonzero. DJNZ (decrement and jump if not zero) is the 8051's compact
counted-loop instruction. With the record's input 65 65 65 65 65 01 08 02 02 34
at 40H–4AH, the same ten bytes appear at 50H–5AH.

## count_ones_8051.asm (lab record, page 17, a)

Counts the set bits of the byte at 40H. A holds the byte, R1 counts eight
bits, R2 accumulates the answer. Each pass `RLC A` rotates the next bit into
the carry flag; `JNC L1` skips the count if the bit was 0, otherwise
`INC R2` bumps the count; `DJNZ R1, L2` repeats until all eight bits have
passed through the carry. With [40H] = 96H the record shows R2 = 04H and
A = 4BH after the rotations.

## count_zeros_ones_8051.asm (lab record, page 17, b)

Extends the 1's counter with a 0's count in R3. Transcribed exactly as
printed — the record's listing contains a literal `JMP R0` that makes the
following `INC R3` unreachable, and its output names the second result R5
while the code increments R3; both are kept as written (see the NOTE
comments in the file). With [40H] = 86H (1000 0110b — three 1s, five 0s)
the record shows R2 = 03H (1's) and R5 = 05H (0's), which is consistent
with the intended counting.

## clear_ram.asm (lab record, page 18, a)

Fills 16 RAM cells (60H–6FH) with 00H. `CLR A` zeroes the accumulator, R1
points at 60H, and R7 counts the locations. The loop writes 00H through the
pointer (`MOV @R1, A`), advances with `INC R1`, and `DJNZ R7, AGAIN` repeats
until the counter is exhausted. The record writes the count as `#16H` for
"16 locations" (hex 16H would be 22 — it is preserved as printed, flagged
with a NOTE).

## packed_bcd_to_ascii_8051.asm (lab record, page 18, b)

Converts the packed BCD value 29H into its two ASCII digits. The value is
copied to R2 for safekeeping. Lower digit: `ANL A, #0FH` masks off the upper
nibble, leaving 9; `ORL A, #30H` turns a nibble into its ASCII character
(9 → 39H = '9'), stored in R6. Upper digit: reload from R2, `ANL A, #0F0H`
keeps the 2-nibble, `SWAP A` brings it into the low nibble, `ORL A, #30H`
makes 32H = '2', stored in R2. Adding 30H works because the ASCII digits
'0'–'9' occupy 30H–39H. Record result: R2 = 32H, R6 = 39H.

## ARM Assembly

## add_subtract_arm.asm (lab record, page 31, program 1)

Pure register arithmetic with no memory involvement: `LDR R0, =0x22222222`
and `LDR R1, =0x11111111` load constants (the `=` makes them literal-pool
loads), then `ADD R2, R0, R1` → R2 = 0x33333333 and `SUBS R3, R0, R1` →
R3 = 0x11111111. The `S` suffix on SUBS sets the condition flags; the
record's XPSR = 0x21000000 shows the carry flag set (the subtraction needed
no borrow). `HERE B HERE` parks the core in an infinite loop — the ARM
equivalent of a breakpoint stop for register inspection.

## arm_add_registers.asm (lab record, page 31, program 1)

An identical second copy of record program 1, kept under this name (the repo
had both names before the record sync). See add_subtract_arm.asm.

## add_memory_arm.asm (lab record, page 31, program 2)

Reads two 32-bit words from RAM and stores their sum. `LDR R0, =0x20000000`
loads the *address* into a register, then `LDR R1, [R0]` reads the value at
that address — a two-step pattern repeated for the second number at
0x20000010. `ADD R4, R1, R3` is ARM's classic three-operand form
(destination first, then both sources), and `STR R4, [R5]` writes the sum to
0x200000FF. With the record's inputs 0x04030201 and 0x05040302, R4 =
0x09070503.

## block_copy_arm.asm (lab record, page 32)

Copies 5 words from 0x20000000–0x20000010 to 0x20000020–0x20000030 using
ARM's post-indexed addressing. `LDR R3, [R0], #4` loads the word at [R0]
*and then* adds 4 to R0; `STR R3, [R1], #4` does the same for R1. Because
the pointer update is built into the load/store, the loop body is just two
instructions plus `SUBS R2, R2, #1` / `BNE LOOP` — the S suffix sets the Z
flag and BNE tests it. With input words 10, 20, 30, 40, 50 the record shows
R0 = 0x20000014, R1 = 0x20000034, R2 = 0, R3 = 50 after the loop.

## 8051 Embedded C — general port I/O

## port_output_ff.c (lab record, page 19, a)

Sends the values 00H through FFH to port P1 with a single `for` loop. Note
the loop condition `c <= 255` on an `unsigned char` is always true (an
unsigned char can never exceed 255), so the counter wraps around instead of
terminating — preserved exactly as printed in the record. The effect is a
continuously repeating 00→FF sweep on the port pins.

## toggle_port_p1.c (lab record, page 19, b)

Alternates the whole P1 port between the two complementary checkered
patterns 0x55 (01010101) and 0xAA (10101010), holding each for a 4000-
iteration software delay, forever. Complementary patterns make the
toggling obvious on LEDs and are handy for scoping pin timing.

## port_value_select.c (lab record, page 20, a)

Polled routing: reads a byte from P1 into x, then `if (x < 100)` sends it to
P2, otherwise to P3 — a software comparator/multiplexer. The record's test:
P1 = 0x07 (7 < 100) appears on P2; P1 = 0xFC (252 ≥ 100) appears on P3. Runs
in an endless `while (1)` so it keeps routing new values.

## led_blink.c (lab record, page 23, a)

Blinks one LED wired to pin P2.5, declared with `sbit led = P2^5;` so the
code can address a single pin of the port. `main` loops forever: `led = 0`
pulls the pin low (LED on, active-low wiring), `delay(500)` waits ~500 ms,
`led = 1` turns it off, wait again. The `delay()` function is the standard
Keil busy-wait — 1275 inner iterations ≈ 1 ms at 12 MHz, so `delay(t)` ≈ t ms.

## led_blink_port.c (lab record, page 23, b)

Same timing as led_blink.c, but writes the whole P2 register instead of one
bit: `P2 = 0xFF` (all pins high, all LEDs off) and `P2 = 0x00` (all pins
low, all LEDs on). Demonstrates port-wide output — one assignment drives
all 8 LEDs at once.

## 8051 Embedded C — timers and serial port

## timer0_square_wave.c (lab record, page 20, b)

Generates a square wave on P2 by toggling the port and waiting on Timer 0,
mode 1 (16-bit). `T0M1_delay()` sets `TMOD = 0x01`, loads the reload values
TL0 = 1AH / TH0 = FFH (i.e. FFEAH, a few counts short of overflow), starts
the timer with `TR0 = 1`, busy-waits until the overflow flag TF0 sets, then
stops the timer and clears TF0. `main` drives P2 high, delays, drives it
low, delays — one full period per two delays. The record's measured half
period is 0.268 ms (noted as ≈ 0.25 ms) at XTAL = 11.0592 MHz.

## timer1_square_wave.c (lab record, page 21, a)

Same idea with Timer 1 in mode 2 — the 8-bit auto-reload mode, so only TH1
needs loading once (here `TH1 = -184`, i.e. 72 counts per overflow; the
compiler converts the negative constant). No reload bookkeeping between
delays, which is mode 2's advantage for periodic interrupts and waveforms.
The record's measured half period is 0.21 ms (noted as ≈ 0.2 ms).

## uart_transmit_a_4800.c (lab record, page 21, b)

Serial transmission of the character 'A' at 4800 baud, 8 data bits, 1 stop
bit. Timer 1 mode 2 with `TH1 = 0xFA` supplies the 4800 baud rate from the
11.0592 MHz crystal; `SCON = 0x50` selects UART mode 1 (8-bit) with receive
enabled; `TR1 = 1` starts the baud-rate timer. The endless loop writes 'A'
into SBUF and busy-waits on the transmit-interrupt flag TI, clearing it
after each byte — the record's serial window shows AAAA… continuously.

## uart_transmit_yes_9600.c (lab record, page 22)

Transmits the message "YES" at 9600 baud. Identical serial setup except
`TH1 = 0xFD` (the 9600-baud reload). Transmission is factored into
`ser_Tx(c)`, which loads SBUF, waits for TI, and clears it; `main` calls it
for 'Y', 'E', 'S' and a space forever, so the serial window shows
YES YES YES… — demonstrating both the higher baud rate and a reusable
transmit routine.

## 8051 Embedded C — stepper, LCD, DAC, keypad, DC motor

## stepper_wave_drive.c (lab record, page 25, wave mode)

Rotates a stepper motor in wave drive mode via the four phase lines on P2
(through a driver such as ULN2003, active-low). In wave drive exactly one
coil is energized per step, so each pattern has exactly one bit low:
08, 04, 02, 01 steps through the phases in order. Each step is held
~200 ms via the standard 1275-iteration delay; the loop repeats forever.
Wave drive gives the lowest torque but the simplest sequencing.

## stepper_full_step.c (lab record, page 25, full mode)

Full-step drive energizes two adjacent coils per step — the patterns 0x0C
(P2.3+P2.2), 0x06 (P2.2+P2.1), 0x03 (P2.1+P2.0), 0x09 (P2.0+P2.3) always
have exactly two adjacent bits low. This gives more torque than wave drive
at the same step rate, at the cost of higher current (two coils on). The
sequence cycles forever with ~200 ms per step.

## stepper_half_step.c (lab record, page 25, half mode)

Half-step drive interleaves the wave-drive and full-step sequences:
08, 0C, 04, 06, 02, 03, 01, 09 — alternating between one coil and two
adjacent coils. The rotor advances half a step each time, giving 8 steps
per cycle instead of 4 — twice the angular resolution and smoother motion,
with intermediate torque. The program unrolls the 8 patterns with a delay
between each, running forever.

## lcd_display.c (lab record, page 26)

Drives a 16x2 HD44780-style LCD in 8-bit mode: data bus on P2, RS on P0.0
(0 = command, 1 = character), EN on P0.1. The key detail is the enable
pulse — the LCD latches whatever is on the data bus while EN is high, so
both `cmd_lcd` and `write_LCD` set the bus, raise EN, delay, then drop it.
`init_lcd` sends the standard setup sequence (0x38 = 8-bit/2 lines, 0x0E =
display + cursor on, 0x06 = auto-increment, 0x01 = clear). `main` clears
the screen, positions at 0x80 (line 1 start) and prints " ECE-B", repeating
every ~5 s. (The record first wrote display("ABCD") and struck it out; the
final version shows " ECE-B".)

## dac_square_wave.c (lab record, page 27, a)

Generates a square wave with an 8-bit DAC whose data input sits on P1
(`#define DAC P1`). The loop alternates `DAC = 0xFF` (maximum output
voltage) and `DAC = 0x00` (zero) with a fixed software delay between them,
producing a repeating two-level waveform whose amplitude spans the DAC's
full range and whose frequency is set by the delay.

## dac_triangle_wave.c (lab record, page 27, b)

Intended to generate a triangular wave: an up-ramp `for (i = 0; i < 255;
i++) DAC = i;` climbs the DAC output from 00H toward FFH one code at a
time, and a down-ramp should bring it back. The record's down-ramp is
written `for (i = 0; i > 0; i--)` with unsigned i starting at 0 — that
condition is false immediately, so the descending ramp never runs and the
output repeats only the rising ramp (preserved as printed, flagged with a
NOTE).

## dac_sine_wave.c (lab record, page 27, c)

Generates a sine-like waveform by table lookup instead of computation:
`wave[]` holds sampled sine amplitudes (128, 192, 238, 255, 192, 128, 64,
17, 0, 17, 64) that `main` sends to P1 in order with a delay between
samples, repeating forever. The DAC smooths the stepped samples into a
sine. The record declares `wave[12]` but lists only 11 values — preserved
as printed (the 12th entry stays 0).

## keypad_lcd.c (lab record, pages 28–29)

Interfaces a 4x3 matrix keypad and the 16x2 LCD at once. Keypad: rows
R1–R4 on P1.0–P1.3, columns C1–C3 on P1.4–P1.6. `keyscan()` grounds all
rows and watches the columns; when a press pulls a column low, it grounds
one row at a time to locate the row, and the (row, column) pair maps to a
key: 1–9 across rows 1–3, then \*, 0, # on row 4. LCD: data bus on the
sfr at 0xA0 (P2), rs/rw/en on P3.7/P3.6/P3.5, driven by `lcd_cmd` /
`lcd_data` with the usual EN high pulse. `main` initializes the display,
prints "Key Test:" on line 1, moves to line 2 (0xC0), and continuously
shows the pressed key — digits as characters (`key + '0'`), \* and # as
their own characters.

## dc_motor_l293d.c (lab record, page 30)

Drives a DC motor through the L293D H-bridge: IN1 on P2.0, IN2 on P2.1
(declared with sbit). Truth table per state: IN1=1/IN2=0 → clockwise,
IN1=0/IN2=1 → anti-clockwise, both 0 → coast (stop). `main` cycles
clockwise 0.5 s, stop 0.2 s, anti-clockwise 0.5 s, stop 0.2 s, forever —
showing full bidirectional control with two pins. (The record's second
sbit line reads `sbit IN1=P2^1`; since main uses IN2, the file writes it
as IN2 with a NOTE.)

## Other programs in the repository (not part of this record)

These files predate the record sync or come from other sources; their
content was left unchanged.

## factorial_8051.asm

Computes the factorial of the number at RAM 25H. A starts at the input
(05H), R2 counts the remaining multipliers 4,3,2,1; each pass does
`MUL AB` (A × B, B loaded from R2) and `DJNZ R2, FACT` steps to the next
multiplier. 5! = 120 = 78H stored back at 25H. The repeated 8-bit multiply
overflows quickly, so this suits small inputs only.

## blink_port_p1.c

Alternates all of P1 between 0x00 (all LEDs on for active-low wiring) and
0xFF (all off) with a fixed delay — the P1 twin of led_blink_port.c.

## toggle_single_bit_p1.c

Toggles only pin P1.0 (`led = !led`) every delay cycle — the minimal way
to blink one LED without disturbing the rest of the port.

## toggle_alternate_p3.c

Alternates port P3 between 0x55 and 0xAA — the checkered toggle pattern of
toggle_port_p1.c applied to P3, with a longer software delay.

## switch_led.c

Polled input: `sbit sw = P1^5` reads a switch, `sbit led = P2^5` drives an
LED (active-low). The endless loop mirrors the switch — line high → LED
pin low (on), otherwise high (off) — updating as fast as the loop can spin.

## switch_led_pair.c

One switch on P1.0 selects complementary states on two LEDs at P2.0/P2.1:
pressed, LED1 lights; released, LED2 lights. Shows one input controlling
two outputs.

## port_switch_mirror.c

Reads a whole byte from P0 (pulled high first so the pins can float as
inputs — P0 needs external pull-ups) and copies it to P1 if bit 7 is high,
else to P2: a port mirror with a destination selected by the top bit.

## switch_select_port_output.c

A switch on P1.5 (P1 pulled high for input) chooses what the ports output:
while the line is high, P0 gets 0x55; when low, P2 gets 0xAA.

## dac_ramp_wave.c

Sawtooth/ramp version of the DAC demo: an up-counting loop writes every
code 0–254 to the DAC on P1, then restarts — a repeating rising ramp. (It
lacks the record's triangle program's intended down-ramp.)

## keypad_7segment.c

Scans a 3x3 keypad (rows P1.0–P1.2 driven low one at a time via row
patterns, columns read from P1.4–P1.6) and shows the pressed digit 1–9 on
a common-cathode seven-segment display on P2 using a lookup table of
segment codes. Waits for key release before accepting the next press.

## seven_segment_count.c

Counts 0–9 on a common-cathode seven-segment display wired to P2 (segments
a–g on bits 0–6, bit 7 unused, segment high = on). The array `a[]` holds
the segment pattern for each digit — for example 0x3F lights segments a–f
for "0", 0x7F lights all seven for "8". The loop steps through the array,
puts each pattern on the port, holds ~100 ms, and wraps around forever.
For a common-anode display the patterns must be inverted.

## seven_segment_even_count.c

Same as the 0–9 counter but the array holds only the patterns for the even
digits 0, 2, 4, 6, 8 (0x3F, 0x5B, 0x66, 0x7D, 0x7F) and the loop runs 5
times per cycle instead of 10. Shows how the lookup-table approach makes
changing the sequence trivial — only the table and the loop bound change.

## led_blink_nibble.c

Alternates the two halves of port P2. `P2 = 0x0F` sets the lower four pins
high (lower LEDs off) and the upper four low (upper LEDs on); `P2 = 0xF0`
swaps it. Each state lasts ~500 ms. Useful for showing that a byte written
to a port is really eight independent bits.
