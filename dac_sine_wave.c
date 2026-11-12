/* Program      : Generate a sine wave using an 8-bit DAC (8051)
 * Connections  : DAC data input connected to port P1.
 * Compiler     : Keil C51
 */
#include <reg51.h>
#define DAC P1

/* Lookup table follows the sample values in the lab record. */
unsigned char code sine_table[12] = {
    128, 192, 228, 255, 238, 192,
    128, 64, 17, 0, 17, 64
};

void delay(void)
{
    unsigned int i;
    for (i = 0; i < 4; i++)
        ;
}

void main(void)
{
    unsigned char i;
    while (1)
    {
        for (i = 0; i < 12; i++)
        {
            DAC = sine_table[i]; /* Output next sample */
            delay();
        }
    }
}

/* Output: Repeating sine-like waveform at DAC output. */
