/* Program      : Generate a sine wave using an 8-bit DAC (8051)
 * Connections  : DAC data input connected to port P1.
 * Compiler     : Keil C51
 */
#include <reg51.h>
#define DAC P1

/* 32 samples for one cycle, offset and scaled to 0-255 */
unsigned char code sine_table[32] = {
    128, 152, 176, 198, 218, 234, 246, 253,
    255, 253, 246, 234, 218, 198, 176, 152,
    128, 104, 80, 58, 38, 22, 10, 3,
    0, 3, 10, 22, 38, 58, 80, 104
};

void delay(void)
{
    unsigned int i;
    for (i = 0; i < 100; i++)
        ;
}

void main(void)
{
    unsigned char i;
    while (1)
    {
        for (i = 0; i < 32; i++)
        {
            DAC = sine_table[i]; /* Output next sine sample */
            delay();
        }
    }
}

/* Output: Repeating sine-like waveform at DAC output. */
