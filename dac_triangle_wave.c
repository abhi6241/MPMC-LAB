/* Program      : Generate triangular wave using an 8-bit DAC (8051 C)
 * Connections  : DAC data input on port P1.
 * Compiler     : Keil C51
 * Source       : Lab record, page 27 (b)
 */
#include <reg51.h>
#define DAC P1

void main()
{
    unsigned char i = 0;
    DAC = 0x00;
    while (1)
    {
        for (i = 0; i < 255; i++)
        {
            DAC = i;
        }
        for (i = 0; i > 0; i--) /* NOTE: exactly as written in the
                                   record; with unsigned i starting
                                   at 0 this loop never runs (the
                                   descending ramp is lost) */
        {
            DAC = i;
        }
    }
}

/* Output: Rising ramp 00H-FEH at the DAC output, repeating. */
