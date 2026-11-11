/* Program      : Blink all LEDs on Port 2 (8051)
 * Description  : Toggles the entire P2 port between 0xFF and 0x00,
 *                so all 8 LEDs connected to P2.0-P2.7 blink
 *                together, forever, ~0.5 s per state
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
        P2 = 0xFF;               /* all P2 pins high -> LEDs OFF  */
        delay(500);              /* wait ~500 ms                  */
        P2 = 0x00;               /* all P2 pins low  -> LEDs ON   */
        delay(500);              /* wait ~500 ms                  */
    }
}

/* Output:
 * All 8 LEDs on P2.0-P2.7 blink together with a ~1 s period:
 * ~0.5 s OFF (P2 = 0xFF), ~0.5 s ON (P2 = 0x00), repeating forever. */
