/* Program      : Blink all LEDs connected to P1 (8051)
 * Description  : Alternates P1 between 00H and FFH.
 * Compiler     : Keil C51
 */
#include <reg51.h>

void delay(void)
{
    unsigned int i, j;
    for (i = 0; i < 200; i++)
        for (j = 0; j < 1275; j++)
            ;
}

void main(void)
{
    while (1)
    {
        P1 = 0x00; /* All pins low */
        delay();
        P1 = 0xFF; /* All pins high */
        delay();
    }
}

/* Output: LEDs on P1 blink together. Active level depends on wiring. */
