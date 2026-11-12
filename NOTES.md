# MPMC Reference Notes

## 8086 — MUL and DIV result registers

| Instruction | Operates on | Result goes to |
|-------------|-------------|----------------|
| `MUL r8` | `AL × r8` | `AX` (16-bit product) |
| `MUL r16` | `AX × r16` | `DX:AX` (32-bit product, DX = high word) |
| `DIV r8` | `AX ÷ r8` | `AL` = quotient, `AH` = remainder |
| `DIV r16` | `DX:AX ÷ r16` | `AX` = quotient, `DX` = remainder |

Gotchas:
- Before `DIV r8`, `AH` must hold the **high byte of the dividend** (usually 0) — garbage in `AH` corrupts the quotient.
- Before `DIV r16`, `DX` is the **high word of the dividend** — it is not just a spare register.
- `DIV` by zero raises INT 0 (divide overflow).
- `#` is 8051 immediate syntax; **8086 immediates are bare** (`MOV AL, 48H`).

## 8051 — Addressing modes

| Mode | Example | Meaning |
|------|---------|---------|
| Immediate | `MOV A, #55H` | load the constant 55H |
| Direct | `MOV 40H, A` | address given directly in the instruction |
| Indirect (register) | `MOV @R1, A` | R1 holds the address; @R1 accesses it |
| Register | `MOV R1, #40H` | operate on the register itself |

## 8051 — Delay loop (12 MHz crystal)

```c
for (j = 0; j < 1275; j++) ;   /* ≈ 1 ms per outer iteration */
```

Standard Keil C51 busy-wait: 1275 inner iterations ≈ 1 ms, so `delay(t)` ≈ t ms.

## Stepper motor drive modes (phases on P2.0–P2.3, active-low via ULN2003)

| Mode | Coils energized per step | Steps/cycle | Torque | Example sequence |
|------|--------------------------|-------------|--------|------------------|
| Wave drive | 1 | 4 | lowest | 08, 04, 02, 01 |
| Full-step | 2 adjacent | 4 | highest | 0C, 06, 03, 09 |
| Half-step | alternating 1 / 2 | 8 | medium | 08, 0C, 04, 06, 02, 03, 01, 09 |

Half-step = wave + full-step sequences interleaved → double the angular resolution.

## Seven-segment codes (common cathode, segments a–g on bits 0–6)

| Digit | Code | Digit | Code |
|-------|--------|-------|--------|
| 0 | 3F | 5 | 6D |
| 1 | 06 | 6 | 7D |
| 2 | 5B | 7 | 07 |
| 3 | 4F | 8 | 7F |
| 4 | 66 | 9 | 6F |

Common-anode displays use the complement (invert each code, e.g. `P2 = ~a[k];`).

## HD44780 LCD (16x2, 8-bit mode)

- Pins: data bus on a port (P2), `RS` (0 = command, 1 = data), `EN` (data latches on the **falling edge**), `R/W` (0 = write; write-only wiring often ties it to ground, but the record's keypad LCD drives it on P3.6).
- Standard init commands: `0x38` (8-bit, 2 lines), `0x0E` (display + cursor on), `0x06` (entry mode, auto-increment), `0x01` (clear + home).
- Cursor addresses: line 1 starts at `0x80`, line 2 starts at `0xC0` (e.g. `0xC3` = line 2, position 3).
- Careful with function-set values: `0x38` = 2-line mode; stray values like `0x35` reconfigure to 1-line/5×10-dot mode.

## ARM (ARM7 / Cortex-M lab syntax)

- Directives: `AREA name, CODE, READONLY`, `EXPORT label`, `END`.
- Post-indexed addressing: `LDR R3, [R0], #4` loads from `[R0]` then does `R0 += 4` — ideal for block copies.
- `SUBS`/`ADDS` set the flags; the trailing `BNE`/`BEQ` test them. A plain `SUB`/`ADD` leaves flags untouched.
- Typical RAM bases: `0x20000000` (Cortex-M), `0x40000000` (LPC2148 / ARM7).
- End programs with `HERE B HERE` (infinite loop).
