/* Program      : Count even digits 0-8 on a seven-segment display
 * Description  : Displays the even digits 0, 2, 4, 6, 8 on a
 *                common-cathode seven-segment display connected to
 *                port P2, repeating forever. Each digit is shown
 *                for ~100 ms (assuming a standard 12 MHz crystal).
 * Connections  : Segment a -> P2.0, b -> P2.1, c -> P2.2,
 *                d -> P2.3, e -> P2.4, f -> P2.5, g -> P2.6
 *                (segment HIGH = ON for common-cathode)          */

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

/* Seven-segment codes for the even digits 0, 2, 4, 6, 8
 * (common cathode, active high): bit 0-6 = segments a-g. */
unsigned char a[5] = {0x3F, 0x5B, 0x66, 0x7D, 0x7F}; /* 0,2,4,6,8 */

void main()
{
    while (1)                    /* count forever                 */
    {
        unsigned char k;
        for (k = 0; k < 5; k++)  /* step through the 5 even digits */
        {
            P2 = a[k];           /* put digit pattern on P2       */
            delay(100);          /* show for ~100 ms              */
        }
    }
}

/* Output:
 * The seven-segment display counts up 0, 2, 4, 6, 8, showing
 * each even digit for ~100 ms, then wraps back to 0 and repeats
 * forever. The odd digits are skipped.                            */
