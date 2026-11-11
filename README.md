# MPMC Lab Programs

Collection of microprocessor / microcontroller lab programs: 8086 arithmetic, 8051 assembly and embedded C (LEDs, LCD, stepper motor, seven-segment), and ARM data-processing.

Every program has a detailed step-by-step explanation in [`EXPLANATION.md`](EXPLANATION.md) — the file names in the tables below link straight to it.

## 8086 Assembly (MASM/TASM)

Arithmetic on immediate values, results kept in registers, all ending with `INT 03H` for inspection.

| File | Operation | Output |
|------|-----------|--------|
| [`add_8bit.asm`](EXPLANATION.md#add_8bitasm) | 42H + 48H | BL = 8AH |
| [`add_16bit.asm`](EXPLANATION.md#add_16bitasm) | 1111H + 2222H | AX = 3333H |
| [`sub_8bit.asm`](EXPLANATION.md#sub_8bitasm) | 48H − 42H | BL = 06H |
| [`sub_16bit.asm`](EXPLANATION.md#sub_16bitasm) | 2222H − 1111H | AX = 1111H |
| [`mul_8bit.asm`](EXPLANATION.md#mul_8bitasm) | 12H × 10H | AX = 0120H |
| [`mul_16bit.asm`](EXPLANATION.md#mul_16bitasm) | 1234H × 5678H | DX:AX = 0626:0060 |
| [`div_8bit.asm`](EXPLANATION.md#div_8bitasm) | 0045H ÷ 0AH | AL = 06H, AH = 09H |
| [`div_16bit.asm`](EXPLANATION.md#div_16bitasm) | 0001:0000 ÷ 0010H | AX = 1000H, DX = 0 |

Notes:
- **8-bit MUL** → product in `AX`; **16-bit MUL** → 32-bit product in `DX:AX`.
- **8-bit DIV** → quotient in `AL`, remainder in `AH` (`AH` must be 0 before the divide).
- **16-bit DIV** → quotient in `AX`, remainder in `DX` (`DX` is the high word of the dividend).
- `avg.asm` (average of 5 numbers at 2000H) is the original uncorrected version — its `DIV BL` divides by an uninitialized `BL` and `AH` is not cleared, so it does not produce a correct average. See [`EXPLANATION.md`](EXPLANATION.md#avgasm-original-not-corrected).

## 8051 Assembly (Keil A51)

| File | Description | Result |
|------|-------------|--------|
| [`move_data_ram.asm`](EXPLANATION.md#move_data_ramasm) | Direct vs indirect addressing demo | RAM 40H–44H = 65H |
| [`block_transfer.asm`](EXPLANATION.md#block_transferasm) | Copy 10 bytes 40H–49H → 50H–59H | block copied |
| [`clear_ram.asm`](EXPLANATION.md#clear_ramasm) | Fill 16 locations 60H–6FH with 00H | RAM cleared |

## ARM Assembly (Keil armasm)

| File | Description | Result |
|------|-------------|--------|
| [`add_memory_arm.asm`](EXPLANATION.md#add_memory_armasm) | Add two words from 0x20000000 and 0x20000010 | sum stored at 0x200000FF |
| [`add_subtract_arm.asm`](EXPLANATION.md#add_subtract_armasm) | 0x22222222 ± 0x11111111 | R2 = 0x33333333, R3 = 0x11111111 |
| [`block_copy_arm.asm`](EXPLANATION.md#block_copy_armasm) | Copy 5 words 0x20000000 → 0x20000020 | block copied, R2 = 0 |

## 8051 Embedded C (Keil C51)

| File | Description | Output |
|------|-------------|--------|
| [`led_blink.c`](EXPLANATION.md#led_blinkc) | Single LED on P2.5 blinks (~1 s period) | 0.5 s ON / 0.5 s OFF |
| [`led_blink_port.c`](EXPLANATION.md#led_blink_portc) | All 8 LEDs on P2 blink together | port-wide blink |
| [`led_blink_nibble.c`](EXPLANATION.md#led_blink_nibblec) | Upper / lower nibble of P2 alternate | 4-LED groups take turns |
| [`switch_led.c`](EXPLANATION.md#switch_ledc) | Switch on P1.5 controls LED on P2.5 | LED mirrors switch |
| [`seven_segment_count.c`](EXPLANATION.md#seven_segment_countc) | Count 0–9 on seven-segment (common cathode) | 0…9 repeating |
| [`seven_segment_even_count.c`](EXPLANATION.md#seven_segment_even_countc) | Count even digits only | 0, 2, 4, 6, 8 repeating |
| [`stepper_wave_drive.c`](EXPLANATION.md#stepper_wave_drivec) | Stepper, wave drive (1 coil/step), direction from P3.1 | forward / reverse chase |
| [`stepper_full_step.c`](EXPLANATION.md#stepper_full_stepc) | Stepper, full-step drive (2 adjacent coils) | forward rotation |
| [`stepper_half_step.c`](EXPLANATION.md#stepper_half_stepc) | Stepper, half-step drive (8 steps/cycle) | smoother, double resolution |
| [`lcd_display.c`](EXPLANATION.md#lcd_displayc) | 16x2 LCD text via P2 data bus, RS/EN on P3.0/P3.1 | "ECE-B" / "MPMC-LAB" |

Common building blocks:
- `delay()` — the standard Keil ~1 ms busy-wait loop (`1275` iterations at 12 MHz).
- LEDs and seven-segment displays on P2 are treated as **active-high** in the seven-segment programs and **active-low** in the LED/stepper programs (check the wiring comment in each file).

## Conventions used across all files

- Header comment block: program name, description, connections (where relevant).
- Every line carries an inline comment explaining the instruction.
- An `Output:` comment block at the bottom states the expected result and final register/memory state.

## License

Distributed under the [MIT License](LICENSE).
Contributions are expected to follow the [Code of Conduct](CODE_OF_CONDUCT.md).
