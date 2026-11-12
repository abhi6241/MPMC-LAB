/* Program      : Generate sine wave using lookup table (8051 C)
 * Connections  : DAC data input on port P1.
 * Compiler     : Keil C51
 * Source       : Lab record, page 27 (c)
 */
#include <reg51.h>

void delay()
{
    unsigned int i;
    for (i = 0; i < 500; i++)
        ;
}

void main()
{
    /* NOTE: record declares wave[12] but lists only 11 values;
     * transcribed as printed (wave[11] stays 0). */
    unsigned char wave[12] = {128, 192, 238, 255, 192, 128,
                              64, 17, 0, 17, 64};
    unsigned char x;
    while (1)
    {
        for (x = 0; x < 12; x++)
        {
            P1 = wave[x];
            delay();
        }
    }
}

/* Output: Repeating sine-like waveform at the DAC output (P1). */
