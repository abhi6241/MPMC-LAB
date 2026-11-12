/* Program      : Read P0 and mirror its value to P1 or P2 (8051)
 * Description  : If P0.7 is high, copy P0 to P1; otherwise P2.
 * Compiler     : Keil C51
 */
#include <reg51.h>

void main(void)
{
    unsigned char value;

    P0 = 0xFF; /* Configure P0 as input (external pull-ups required) */
    while (1)
    {
        value = P0; /* Read the switch bank */
        if (value & 0x80)
            P1 = value; /* P0.7 high: display on P1 */
        else
            P2 = value; /* P0.7 low: display on P2 */
    }
}

/* Output: The sampled P0 byte is copied to P1 or P2 based on P0.7. */
