# Lab Record

Source: scanned handwritten MPMC lab record (42 pages, Vasavi College of
Engineering, ECE Dept., Academic Year 2026-27, MPMC laboratory).
Every program file in this repository that carries a
`Source : Lab record, page NN` line is transcribed from the page named
in its header.

## Record index (page 1 of the record)

| Sl. | Experiment | Conducted on | Submitted on | Starts at page |
|-----|------------|--------------|--------------|----------------|
| 1 | Execution of basic programs on 8086 µP | 14/8/26 | 21/8/26 | 3 |
| 2 | Programs on data transfer, multibyte add & average | 21/8/26 | 28/8/26 | 11 |
| 3 | ALP operation & addressing mode | 28/8/26 | 11/9/26 | 15 |
| 4 | Timer programming | 8/9/26 | 9/10/26 | 17 |
| 5 | Serial communication | 18/9/26 | 9/10/26 | 21 |
| 6 | 8051 programming in C | 18/9/26 | 9/10/26 | 22 |
| 7 | LED to 8051 interface | 16/10/26 | 6/11/26 | 23 |
| 8 | LED & switch interface | 16/10/26 | 6/11/26 | 24 |
| 9 | Stepper motor | 16/10/26 | 6/11/26 | 25 |
| 10 | 16x2 LCD display | 16/10/26 | 6/11/26 | 26 |
| 11 | Wave generation | 16/10/26 | 6/11/26 | 27 |
| 12 | LCD & Keypad (4x3) interface | 16/10/26 | 6/11/26 | 28 |
| 13 | DC motor interface | 16/10/26 | 6/11/26 | 30 |
| 14 | ARM ALP operations, data transfer | 6/11/26 | 13/11/26 | 31 |

## Programs in the record, in record order

Result values are exactly as written in the record.

| Rec. page | Experiment | Program file(s) | Record result |
|-----------|------------|-----------------|---------------|
| 3 | 8-bit addition (8086) | `add_8bit.asm` | AL ← 43H, BL ← 42H → AX = FF85H, BX = 0042H |
| 4 | 8-bit subtraction (8086) | `sub_8bit.asm` | AL ← 72H, BL ← 41H → AX = FF31H, BX = 0041H |
| 5 | 8-bit multiplication (8086) | `mul_8bit.asm` | AL ← 15H, BL ← 32H → AX = 041AH, BX = 0032H |
| 6 | 8-bit division (8086) | `div_8bit.asm` | AX ← 0015H, BX ← 7H → AX = 0003H, DX = 0000H |
| 7 | 16-bit addition (8086) | `add_16bit.asm` | AX ← 4326H, BX ← 1012H → AX = 5338H |
| 8 | 16-bit subtraction (8086) | `sub_16bit.asm` | AX ← 7321H, BX ← 1329H → AX = 5FF8H |
| 9 | 16-bit multiplication (8086) | `mul_16bit.asm` | AX ← 1329H, BX ← 3715H → DX:AX = 00434A9DH |
| 10 | 16-bit division (8086) | `div_16bit.asm` | AX ← 5345H, BX ← 2356H → AX = 0002H, DX = 089DH |
| 11 | Transfer 5 bytes 2000H → 5000H (8086) | `block_transfer_8086.asm` | 075A:2000 = 01 02 03 04 05 → 075A:5000 = 01 02 03 04 05 |
| 12 | Transfer 5 bytes in reverse (8086) | `block_transfer_reverse_8086.asm` | 075A:2000 = 01 02 03 04 05 → 075A:5000 = 05 04 03 02 01 |
| 13 | Multibyte addition, 5 bytes (8086) | `array_addition.asm` | 075A:2000 = 01 02 03 04 05 → AX = 000FH, SI = 2005H |
| 14 | Average of 5 bytes (8086) | `avg.asm` (kept also as `average_array.asm`) | 075A:2000 = 01 02 03 04 05 → AX = 0003H, BX = 0005H |
| 15 | ALU operations on [40H], [41H] (8051) | `alu_operations_8051.asm` | 42H = 38H, 43H = 2CH, 44H = 1BH, 45H = 00H, 46H = 03H, 47H = 00H, 48H = 01H, 49H = 0AH, 4AH = 12H |
| 16 | (a) Direct & register indirect addressing; (b) transfer 10 bytes (8051) | `move_data_ram.asm`, `block_transfer.asm` | (a) RAM 40H–44H = 55H, then 65H; (b) RAM 40H–4AH copied to 50H–5AH |
| 17 | (a) Count 1's in a byte; (b) count 0's & 1's (8051) | `count_ones_8051.asm`, `count_zeros_ones_8051.asm` | (a) [40H] = 96H → R2 = 04H, A = 4BH; (b) [40H] = 86H → R2 = 03H (1's), R5 = 05H (0's) |
| 18 | (a) Clear 16 RAM locations; (b) packed BCD → ASCII (8051) | `clear_ram.asm`, `packed_bcd_to_ascii_8051.asm` | (a) 60H–6FH: 05H → 00H; (b) A = 29H → R2 = 32H ('2'), R6 = 39H ('9') |
| 19 | (a) Send 00–FF to port 1; (b) toggle P1 with delay (8051 C) | `port_output_ff.c`, `toggle_port_p1.c` | (a) values 00–FF sent to P1; (b) P1 alternates 55H / AAH |
| 20 | (a) P1 < 100 → P2 else P3; (b) 5 kHz square wave, Timer 0 mode 1 (8051 C) | `port_value_select.c`, `timer0_square_wave.c` | (a) P1 = 07H → P2 = 07H, P1 = FCH → P3 = FCH; (b) half period 0.268 ms (record notes ≈ 0.25 ms) |
| 21 | (a) 2500 Hz square wave, Timer 1 mode 2; (b) transmit 'A' at 4800 baud (8051 C) | `timer1_square_wave.c`, `uart_transmit_a_4800.c` | (a) half period 0.21 ms (record notes ≈ 0.2 ms); (b) serial window shows AAAA… |
| 22 | Transmit 'YES' at 9600 baud (8051 C) | `uart_transmit_yes_9600.c` | serial window shows YES YES YES… |
| 23 | (a) LED at P2.5; (b) 8 LEDs at port 2 (8051 C) | `led_blink.c`, `led_blink_port.c` | LED blinks ~0.5 s ON / 0.5 s OFF; port-wide blink |
| 24 | LED interface circuit (Proteus screenshot — no program on this page) | — | 8 LEDs on P2 of an AT89C51 |
| 25 | Stepper motor — wave / full / half drive at P2 (8051 C) | `stepper_wave_drive.c`, `stepper_full_step.c`, `stepper_half_step.c` | wave 08, 04, 02, 01; full 0C, 06, 03, 09; half 08, 0C, 04, 06, 02, 03, 01, 09 — each step held ~200 ms |
| 26 | Display characters on 16x2 LCD (8051 C) | `lcd_display.c` | line 1 shows " ECE-B" (Proteus screenshot shows "ECE-B MPMC Lab_") |
| 27 | Wave generation with 8-bit DAC: square / triangular / sine (8051 C) | `dac_square_wave.c`, `dac_triangle_wave.c`, `dac_sine_wave.c` | square, triangular and sine-like waveforms at the DAC output |
| 28–29 | LCD & 4x3 keypad interface (8051 C) | `keypad_lcd.c` | LCD line 1 shows "Key Test:", line 2 shows the pressed key (1–9, \*, 0, #) |
| 30 | DC motor interface via L293D (8051 C) | `dc_motor_l293d.c` | clockwise 0.5 s → stop 0.2 s → anti-clockwise 0.5 s → stop 0.2 s, repeating |
| 31 | ARM ALP: (1) add & subtract two constants; (2) add two numbers in memory | `arm_add_registers.asm` (kept also as `add_subtract_arm.asm`), `add_memory_arm.asm` | (1) R2 = 0x33333333, R3 = 0x11111111, XPSR = 0x21000000; (2) R1 = 0x04030201, R3 = 0x05040302, R4 = 0x09070503 |
| 32 | ARM block copy of 5 words | `block_copy_arm.asm` | [0x20000000–0x20000010] = 10, 20, 30, 40, 50 → R0 = 0x20000014, R1 = 0x20000034, R2 = 0, R3 = 50 |

Notes:

- Where the record gives one experiment in several variants (e.g. the three
  stepper drive modes, the three DAC waves, the two average listings), each
  variant is kept in its own file; duplicated listings kept under two names
  are marked in the table above.
- Oddities in the record (typos, crossed-out lines, literal `JMP R0`,
  `#16H` for 16 locations, `wave[12]` holding 11 values, etc.) are preserved
  in the program files and flagged there with `NOTE` comments.
- Other files in this repository (e.g. the seven-segment, extra LED/switch
  and ramp-wave programs, `factorial_8051.asm`) are not part of this record
  and were left untouched.
