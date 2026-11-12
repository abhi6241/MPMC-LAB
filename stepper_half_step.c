/* Program      : Interface stepper motor to 8051 MC in 3 modes of operation at P2 (8051 C)
 * Description  : HALF DRIVE MODE - wave and full-step sequences
 *                interleaved. Phase sequence on P2:
 *                08, 0C, 04, 06, 02, 03, 01, 09.
 * Compiler     : Keil C51
 * Source       : Lab record, page 25 (half drive main)
 * NOTE         : The record lists the three drive modes as separate
 *                main() versions on one page; this file is the half
 *                drive version (see stepper_wave_drive.c and
 *                stepper_full_step.c for the others).
 */
#include <reg51.h>

void delay(unsigned int t)
{
    unsigned int i, j;
    for (i = 0; i < t; i++)
        for (j = 0; j < 1275; j++)
            ;
}

/* Half drive mode */
void main()
{
    while (1)
    {
        P2 = 0x08; delay(200);
        P2 = 0x0C; delay(200);
        P2 = 0x04; delay(200);
        P2 = 0x06; delay(200);
        P2 = 0x02; delay(200);
        P2 = 0x03; delay(200);
        P2 = 0x01; delay(200);
        P2 = 0x09; delay(200);
    }
}

/* Output: Stepper rotates continuously in half drive mode, 8
 * half-steps per cycle, each held ~200 ms. */
