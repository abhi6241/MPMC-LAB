# Lab Record

| # | Date | Aim | Program | Result |
|---|------|-----|---------|--------|
| 1 | 11 Nov 2026 | Add two 8-bit numbers (8086) | `add_8bit.asm` | BL = 8AH |
| 2 | 11 Nov 2026 | Add two 16-bit numbers (8086) | `add_16bit.asm` | AX = 3333H |
| 3 | 11 Nov 2026 | Subtract two 8-bit numbers (8086) | `sub_8bit.asm` | BL = 06H |
| 4 | 11 Nov 2026 | Subtract two 16-bit numbers (8086) | `sub_16bit.asm` | AX = 1111H |
| 5 | 11 Nov 2026 | Multiply two 8-bit numbers (8086) | `mul_8bit.asm` | AX = 0120H |
| 6 | 11 Nov 2026 | Multiply two 16-bit numbers (8086) | `mul_16bit.asm` | DX:AX = 0626:0060 |
| 7 | 11 Nov 2026 | Divide an 8-bit number (8086) | `div_8bit.asm` | AL = 06H, AH = 09H |
| 8 | 11 Nov 2026 | Divide a 16-bit number (8086) | `div_16bit.asm` | AX = 1000H, DX = 0 |
| 9 | 11 Nov 2026 | Average of 5 numbers (8086) | `avg.asm` | divide-by-zero; needs BL = 05H, AH = 0 (see NOTES) |
| 10 | 11 Nov 2026 | Direct & indirect addressing (8051) | `move_data_ram.asm` | RAM 40H–44H = 65H |
| 11 | 11 Nov 2026 | Block transfer, 10 bytes (8051) | `block_transfer.asm` | 40H–49H copied to 50H–59H |
| 12 | 11 Nov 2026 | Clear 16 RAM locations (8051) | `clear_ram.asm` | 60H–6FH = 00H |
| 13 | 11 Nov 2026 | Blink single LED on P2.5 (8051 C) | `led_blink.c` | 0.5 s ON / 0.5 s OFF |
| 14 | 11 Nov 2026 | Blink all LEDs on port P2 (8051 C) | `led_blink_port.c` | port-wide blink |
| 15 | 11 Nov 2026 | Alternate LED nibbles on P2 (8051 C) | `led_blink_nibble.c` | groups take turns |
| 16 | 11 Nov 2026 | Switch-controlled LED (8051 C) | `switch_led.c` | LED mirrors switch on P1.5 |
| 17 | 11 Nov 2026 | Seven-segment counter 0–9 (8051 C) | `seven_segment_count.c` | digits 0–9 repeating |
| 18 | 11 Nov 2026 | Seven-segment even digits (8051 C) | `seven_segment_even_count.c` | 0, 2, 4, 6, 8 repeating |
| 19 | 11 Nov 2026 | Stepper motor — wave drive (8051 C) | `stepper_wave_drive.c` | rotates, direction via P3.1 |
| 20 | 11 Nov 2026 | Stepper motor — full-step drive (8051 C) | `stepper_full_step.c` | forward rotation, high torque |
| 21 | 11 Nov 2026 | Stepper motor — half-step drive (8051 C) | `stepper_half_step.c` | 8 half-steps/cycle |
| 22 | 11 Nov 2026 | Text display on 16x2 LCD (8051 C) | `lcd_display.c` | "ECE-B" / "MPMC-LAB" |
| 23 | 11 Nov 2026 | Add two numbers in memory (ARM) | `add_memory_arm.asm` | sum stored at 0x200000FF |
| 24 | 11 Nov 2026 | Add & subtract two constants (ARM) | `add_subtract_arm.asm` | R2 = 0x33333333, R3 = 0x11111111 |
| 25 | 11 Nov 2026 | Block copy of 5 words (ARM) | `block_copy_arm.asm` | 0x20000000 → 0x20000020 |

Notes column available for observations during execution.
