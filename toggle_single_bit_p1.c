/* Program      : Toggle a single port bit (8051)
 * Description  : Continuously toggles P1.0 to blink an LED.
 * Compiler     : Keil C51
 */
#include <reg51.h>

sbit led = P1^0;

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
        led = !led; /* Invert only P1.0 */
        delay();
    }
}

/* Output: LED connected to P1.0 toggles continuously. */
