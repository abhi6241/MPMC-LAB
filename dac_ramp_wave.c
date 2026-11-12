/* Program      : Generate a ramp (sawtooth) wave using an 8-bit DAC
 * Connections  : DAC data input connected to port P1.
 * Compiler     : Keil C51
 */
#include <reg51.h>
#define DAC P1

void main(void)
{
    unsigned int i;
    while (1)
    {
        for (i = 0; i < 256; i++)
            DAC = (unsigned char)i; /* Increase from 00H to FFH */
    }
}

/* Output: Repeating rising sawtooth waveform at DAC output. */
