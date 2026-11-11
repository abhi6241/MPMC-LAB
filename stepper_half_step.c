/* Program      : Stepper motor control - half-step drive (8051)
 * Description  : Rotates a stepper motor in HALF-STEP drive mode,
 *                alternating between one coil and two adjacent
 *                coils energized, giving 8 steps per cycle (double
 *                the resolution of full-step). The 4 phase lines
 *                are driven from port P2 (P2.0-P2.3, through a
 *                driver such as ULN2003), active-low.
 *                Rotation is forward, one half-step every ~200 ms,
 *                forever (assuming a standard 12 MHz crystal).     */

#include <reg51.h>   /* SFR definitions for the 8051 (P2, etc.)  */

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

void main()
{
    while (1)                    /* keep stepping forever         */
    {
        P2 = 0x08;               /* 1 coil:   P2.3                */
        delay(200);              /* hold for ~200 ms              */
        P2 = 0x0C;               /* 2 coils:  P2.3 + P2.2         */
        delay(200);
        P2 = 0x04;               /* 1 coil:   P2.2                */
        delay(200);
        P2 = 0x06;               /* 2 coils:  P2.2 + P2.1         */
        delay(200);
        P2 = 0x02;               /* 1 coil:   P2.1                */
        delay(200);
        P2 = 0x03;               /* 2 coils:  P2.1 + P2.0         */
        delay(200);
        P2 = 0x01;               /* 1 coil:   P2.0                */
        delay(200);
        P2 = 0x09;               /* 2 coils:  P2.0 + P2.3         */
        delay(200);
    }
}

/* Output:
 * The stepper motor rotates continuously in half-step mode:
 * the 8-step phase cycle
 *   0x08 -> 0x0C -> 0x04 -> 0x06 -> 0x02 -> 0x03 -> 0x01 -> 0x09
 * repeats forever, one half-step every ~200 ms. Alternate steps
 * energize one coil or two adjacent coils, giving twice the
 * angular resolution (and a smoother motion) compared to
 * full-step drive.                                                 */
