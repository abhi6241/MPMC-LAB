/* Program      : Get a byte of data from P1; if less than 100 send it to P2, else send it to P3 (8051 C)
 * Description  : Reads P1 and routes the value to P2 (<100) or P3.
 * Compiler     : Keil C51
 * Source       : Lab record, page 20
 */
#include <reg51.h>

void main()
{
    unsigned char x;
    while (1)
    {
        x = P1;
        if (x < 100)
            P2 = x;
        else
            P3 = x;
    }
}

/* Output: Port 1 <- 0x07  =>  Port 2 <- 0x07
 *         Port 1 <- 0xFC  =>  Port 3 <- 0xFC */
