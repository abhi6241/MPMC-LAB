/* Program      : Control two LEDs using one switch (8051)
 * Description  : Switch at P1.0 selects opposite states on P2.0/P2.1.
 * Compiler     : Keil C51
 */
#include <reg51.h>

sbit sw   = P1^0;
sbit LED1 = P2^0;
sbit LED2 = P2^1;

void delay(void)
{
    unsigned int i, j;
    for (i = 0; i < 200; i++)
        for (j = 0; j < 1275; j++)
            ;
}

void main(void)
{
    sw = 1; /* Configure switch pin as input */
    while (1)
    {
        if (sw == 0)
        {
            LED1 = 0; /* Switch pressed: LED1 on (active-low) */
            LED2 = 1; /* LED2 off */
        }
        else
        {
            LED1 = 1; /* LED1 off */
            LED2 = 0; /* LED2 on */
        }
        delay();
    }
}

/* Output: The two LEDs show complementary states based on the switch. */
