/* Program      : Toggle bits of P1 continuously forever with some delay (8051 C)
 * Description  : Alternates the whole P1 port between 55H and AAH.
 * Compiler     : Keil C51
 * Source       : Lab record, page 19
 */
#include <reg51.h>

void main()
{
    unsigned int x;
    for (;;)
    {
        P1 = 0x55;
        for (x = 0; x < 4000; x++)
            ;
        P1 = 0xAA;
        for (x = 0; x < 4000; x++)
            ;
    }
}

/* Output: P1 alternates 0x55 / 0xAA continuously (with the matching
 * pin pattern), toggling forever. */
