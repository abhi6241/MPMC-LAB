/* Program      : Select output port using switch P1.5 (8051)
 * Description  : If P1.5 is high, output 55H on P0; else AAH on P2.
 * Compiler     : Keil C51
 */
#include <reg51.h>

sbit mybit = P1^5;

void main(void)
{
    P1 = 0xFF; /* Release P1 pins for input */
    while (1)
    {
        if (mybit == 1)
        {
            P0 = 0x55; /* Switch high */
        }
        else
        {
            P2 = 0xAA; /* Switch low */
        }
    }
}

/* Output: P1.5 selects 55H on P0 or AAH on P2. */
