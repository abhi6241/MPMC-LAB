/* Program      : Blink LEDs in nibble groups (8051)
 * Description  : Alternates the two halves (nibbles) of port P2:
 *                upper 4 LEDs ON while lower 4 OFF, then swap.
 *                Toggles every ~500 ms forever
 *                (assuming a standard 12 MHz crystal).
 * Note         : LEDs wired active-LOW (0 = ON, 1 = OFF)          */

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
    while (1)                    /* loop forever                  */
    {
        P2 = 0x0F;               /* P2.4-P2.7 low -> upper LEDs ON,
                                    P2.0-P2.3 high -> lower OFF   */
        delay(500);              /* wait ~500 ms                  */
        P2 = 0xF0;               /* P2.0-P2.3 low -> lower LEDs ON,
                                    P2.4-P2.7 high -> upper OFF   */
        delay(500);              /* wait ~500 ms                  */
    }
}

/* Output:
 * The two nibble groups of LEDs on P2 take turns blinking every
 * ~500 ms: first P2.4-P2.7 ON / P2.0-P2.3 OFF, then P2.0-P2.3 ON /
 * P2.4-P2.7 OFF, alternating forever.                                */
