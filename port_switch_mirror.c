/* Program      : Read port P0 and copy its value to P1 or P2 (8051)
 * Description  : Reads a byte from P0; if bit 7 is high, copies it
 *                to P1, otherwise copies it to P2.
 * Compiler     : Keil C51
 * Hardware     : P0 requires external pull-up resistors when used
 *                as a general-purpose input.
 */
#include <reg51.h>

void main(void)
{
    unsigned char value;
    P0 = 0xFF; /* Release P0 pins for input */

    while (1)
    {
        value = P0; /* Read the input byte */
        if (value & 0x80)
            P1 = value; /* P0.7 high: copy to P1 */
        else
            P2 = value; /* P0.7 low: copy to P2 */
    }
}

/* Output: P0 data is copied to P1 or P2 according to P0.7. */
