/* Program      : Generate square wave using an 8-bit DAC (8051 C)
 * Connections  : DAC data input on port P1.
 * Compiler     : Keil C51
 * Source       : Lab record, page 27 (a)
 */
#include <reg51.h>
#define DAC P1

void delay()
{
    unsigned int i;
    for (i = 0; i < 5535; i++)
        ;
}

void main()
{
    DAC = 0x00;
    while (1)
    {
        while (1)
        {
            DAC = 0xFF;
            delay();
            DAC = 0x00;
            delay();
        }
    }
}

/* Output: Repeating square wave between 00H and FFH at the DAC output. */
