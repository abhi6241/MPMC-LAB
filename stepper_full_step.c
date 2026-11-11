/* Program      : Stepper motor control - full-step drive (8051)
 * Description  : Rotates a stepper motor in FULL-STEP drive mode,
 *                where TWO adjacent phase coils are energized at a
 *                time (higher torque than wave drive). The 4 phase
 *                lines are driven from port P2 (P2.0-P2.3, through
 *                a driver such as ULN2003), active-low.
 *                Rotation is forward, one step every ~200 ms,
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
        P2 = 0x0C;               /* coils on P2.3 + P2.2 ON       */
        delay(200);              /* hold for ~200 ms              */
        P2 = 0x06;               /* coils on P2.2 + P2.1 ON       */
        delay(200);              /* hold for ~200 ms              */
        P2 = 0x03;               /* coils on P2.1 + P2.0 ON       */
        delay(200);              /* hold for ~200 ms              */
        P2 = 0x09;               /* coils on P2.0 + P2.3 ON       */
        delay(200);              /* hold for ~200 ms              */
    }
}

/* Output:
 * The stepper motor rotates continuously in full-step mode:
 * the 4-step phase cycle 0x0C -> 0x06 -> 0x03 -> 0x09 repeats
 * forever, one step every ~200 ms. Two adjacent coils are always
 * energized, giving more torque than wave drive at the same
 * step rate.                                                       */
