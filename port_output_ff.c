/* Program      : Send 00-FF to port 1 (8051 C)
 * Description  : Writes the values 00H through FFH to port P1.
 * Compiler     : Keil C51
 * Source       : Lab record, page 19
 */
#include <reg51.h>

void main()
{
    unsigned char c;
    for (c = 0; c <= 255; c++) /* NOTE: always true for unsigned char */
        P1 = c;
}

/* Output: The values of 00 to FF sent to port 1. */
