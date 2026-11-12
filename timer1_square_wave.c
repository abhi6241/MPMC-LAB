/* Program      : Generate 2500 Hz frequency square wave on P2 using Timer 1, Mode 2 (8051 C)
 * Description  : T1M2_delay() loads Timer 1 mode 2 (auto-reload) with
 *                TH1 = -184 and waits for overflow.
 * Compiler     : Keil C51
 * Source       : Lab record, page 21
 */
#include <reg51.h>

void T1M2_delay()
{
    TMOD = 0x20;
    TH1 = -184;
    TR1 = 1;
    while (TF1 == 0)
        ;
    TR1 = 0;
    TF1 = 0;
}

void main()
{
    while (1)
    {
        P2 = 0xFF;
        T1M2_delay();
        P2 = 0x00;
        T1M2_delay();
    }
}

/* Output: Square wave on P2; half period measured in the record as
 * 0.21 ms (record notes it as ~ 0.2 ms). */
