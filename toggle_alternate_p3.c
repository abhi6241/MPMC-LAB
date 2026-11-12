/* Program      : Toggle alternate bits of port P3 (8051)
 * Description  : Alternates 55H and AAH on port P3.
 * Compiler     : Keil C51
 */
#include <reg51.h>

void delay(void)
{
    unsigned int i;
    for (i = 0; i < 50000; i++)
        ; /* Software delay */
}

void main(void)
{
    while (1)
    {
        P3 = 0x55; /* Alternate bit pattern 01010101B */
        delay();
        P3 = 0xAA; /* Complementary pattern 10101010B */
        delay();
    }
}

/* Output: P3 alternates between 55H and AAH. */
