/* Program      : Interface LED to 8051 MC at P2.5 with some delay (8051 C)
 * Description  : Blinks a single LED on pin P2.5, ~0.5 s ON / 0.5 s OFF.
 * Compiler     : Keil C51
 * Source       : Lab record, page 23
 */
#include <reg51.h>

sbit led = P2^5;

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
        led = 0;
        delay(500);
        led = 1;
        delay(500);
    }
}

/* Output: LED on P2.5 blinks with ~0.5 s ON / 0.5 s OFF. */
