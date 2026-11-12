/* Program      : Generate 5 kHz square wave on P2 using Timer 0, Mode 1 (8051 C)
 * Description  : XTAL = 11.0592 MHz. T0M1_delay() loads Timer 0 mode 1
 *                with FFEAH (TL0=1AH, TH0=FFH) and waits for overflow.
 * Compiler     : Keil C51
 * Source       : Lab record, page 20
 */
#include <reg51.h>

void T0M1_delay()
{
    TMOD = 0x01;
    TL0 = 0x1A;
    TH0 = 0xFF;
    TR0 = 1;
    while (TF0 == 0)
        ;
    TR0 = 0;
    TF0 = 0;
}

void main()
{
    while (1)
    {
        P2 = 0xFF;
        T0M1_delay();
        P2 = 0x00;
        T0M1_delay();
    }
}

/* Output: Square wave on P2; half period measured in the record as
 * 0.268 ms (record notes it as ~ 0.25 ms). */
