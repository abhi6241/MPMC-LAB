/* Program      : Interface stepper motor to 8051 MC in 3 modes of operation at P2 (8051 C)
 * Description  : WAVE DRIVE MODE - exactly one phase energized at a
 *                time. Phase sequence on P2: 08, 04, 02, 01.
 * Compiler     : Keil C51
 * Source       : Lab record, page 25 (wave drive main)
 * NOTE         : The record lists the three drive modes as separate
 *                main() versions on one page; this file is the wave
 *                drive version (see stepper_full_step.c and
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

/* wave drive mode */
void main()
{
    while (1)
    {
        P2 = 0x08; delay(200);
        P2 = 0x04; delay(200);
        P2 = 0x02; delay(200);
        P2 = 0x01; delay(200);
    }
}

/* Output: Stepper rotates continuously in wave drive mode, one phase
 * per step, stepping every ~200 ms. */
