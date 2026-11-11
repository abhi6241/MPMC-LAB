/* Program      : Stepper motor control - wave drive (8051)
 * Description  : Rotates a stepper motor in WAVE DRIVE mode, where
 *                exactly one phase (coil) is energized at a time.
 *                The 4 phase lines are driven from port P2
 *                (P2.0-P2.3, through a driver such as ULN2003).
 *                A switch on pin P3.1 selects the rotation direction:
 *                  sw = 1 -> phase sequence a[] (forward)
 *                  sw = 0 -> phase sequence b[] (reverse)
 *                Each step lasts ~200 ms; the motor keeps rotating
 *                forever (assuming a standard 12 MHz crystal).     */

#include <reg51.h>   /* SFR definitions for the 8051 (P2, etc.)  */

sbit sw = P3^1;      /* sw = bit 1 of port P3 (direction switch) */

/* Software delay of about t milliseconds */
void delay(unsigned int t)
{
    unsigned int i, j;
    for (i = 0; i < t; i++)      /* outer loop: t iterations      */
    {
        for (j = 0; j < 1275; j++)
            ;                    /* inner loop: ~1 ms busy wait   */
    }
}

/* Wave drive sequences: exactly ONE phase is ON (bit low) per step */
unsigned char a[4] = {0x08, 0x01, 0x02, 0x04};  /* A, A', B, B'... */
unsigned char b[4] = {0x04, 0x02, 0x01, 0x08};  /* reverse order   */

void main()
{
    unsigned char x;
    while (1)                    /* keep stepping forever         */
    {
        for (x = 0; x < 4; x++)  /* step through the 4 phases     */
        {
            if (sw == 1)         /* switch high: rotate forward   */
            {
                P2 = a[x];       /* energize the next phase       */
                delay(200);      /* hold for ~200 ms              */
            }
            else                 /* switch low: rotate in reverse */
            {
                P2 = b[x];       /* energize the next phase       */
                delay(200);      /* hold for ~200 ms              */
            }
        }
    }
}

/* Output:
 * The stepper motor rotates continuously in wave drive mode, one
 * phase energized per step, stepping every ~200 ms:
 *   sw = 1 -> forward rotation, phase order a[]
 *   sw = 0 -> reverse rotation, phase order b[]
 * Direction can be changed at any time with the switch on P3.1.
 * (Wave drive gives lower torque than full-step drive but only
 *  needs one phase on at a time.)                                   */
