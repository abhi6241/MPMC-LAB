/* Program      : Interface 8 LEDs at port 2 of 8051 MC with delay (8051 C)
 * Description  : Blinks all eight LEDs of port P2 together.
 * Compiler     : Keil C51
 * Source       : Lab record, page 23
 */
#include <reg51.h>

void delay(unsigned int t)
{
    unsigned int i, j;
    for (i = 0; i < t; i++)
    {
        for (j = 0; j < 1275; j++)
            ;
    }
}

void main()
{
    while (1)
    {
        P2 = 0xFF;
        delay(500);
        P2 = 0x00;
        delay(500);
    }
}

/* Output: All 8 LEDs on P2 blink together (~0.5 s each state). */
