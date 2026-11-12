/* Program      : Generate a triangular wave using an 8-bit DAC (8051)
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
        for (i = 0; i < 255; i++)
            DAC = (unsigned char)i; /* Ramp upward */
        for (i = 255; i > 0; i--)
            DAC = (unsigned char)i; /* Ramp downward */
    }
}

/* Output: Repeating triangular waveform at the DAC output. */
