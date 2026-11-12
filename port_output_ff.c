/* Program      : Send FFH to port P1 (8051)
 * Description  : Continuously writes all logic 1s to port P1.
 * Compiler     : Keil C51
 */
#include <reg51.h>

void main(void)
{
    while (1)
    {
        P1 = 0xFF; /* Set all eight P1 pins high */
    }
}

/* Output: P1 = FFH (all eight port pins are high). */
