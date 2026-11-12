/* Program      : Generate a square wave using an 8-bit DAC (8051)
 * Description  : Alternates DAC input between 00H and FFH.
 * Connections  : DAC data input connected to port P1.
 * Compiler     : Keil C51
 */
#include <reg51.h>
#define DAC P1

void delay(void)
{
    unsigned int i;
    for (i = 0; i < 5355; i++)
        ;
}

void main(void)
{
    while (1)
    {
        DAC = 0x00; /* Minimum DAC input */
        delay();
        DAC = 0xFF; /* Maximum DAC input */
        delay();
    }
}

/* Output: Square waveform at DAC output. */
