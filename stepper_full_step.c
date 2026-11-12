/* Program      : Interface stepper motor to 8051 MC in 3 modes of operation at P2 (8051 C)
 * Description  : FULL DRIVE MODE - two adjacent phases energized at a
 *                time. Phase sequence on P2: 0C, 06, 03, 09.
 * Compiler     : Keil C51
 * Source       : Lab record, page 25 (full drive main)
 * NOTE         : The record lists the three drive modes as separate
 *                main() versions on one page; this file is the full
 *                drive version (see stepper_wave_drive.c and
 *                stepper_half_step.c for the others).
 */
#include <reg51.h>

void delay(unsigned int t)
{
    unsigned int i, j;
    for (i = 0; i < t; i++)
        for (j = 0; j < 1275; j++)
            ;
}

/* full drive mode */
void main()
{
    while (1)
    {
        P2 = 0x0C; delay(200);
        P2 = 0x06; delay(200);
        P2 = 0x03; delay(200);
        P2 = 0x09; delay(200);
    }
}

/* Output: Stepper rotates continuously in full drive mode, two
 * adjacent phases per step, stepping every ~200 ms. */
