/* Program      : Transfer letter 'A' serially at 4800 baud, 8-bit data, 1 stop bit (8051 C)
 * Description  : Timer 1 mode 2 at TH1 = 0xFA sets the 4800 baud rate;
 *                SCON = 0x50 selects 8-bit UART, REN enabled.
 * Compiler     : Keil C51
 * Source       : Lab record, page 21
 */
#include <reg51.h>

void main()
{
    TMOD = 0x20;
    TH1 = 0xFA;
    SCON = 0x50;
    TR1 = 1;
    while (1)
    {
        SBUF = 'A';
        while (TI == 0)
            ;
        TI = 0;
    }
}

/* Output: Serial window (UART): AAAA .... continuously. */
