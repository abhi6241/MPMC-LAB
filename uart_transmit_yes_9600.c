/* Program      : Transfer message 'YES' serially at 9600 baud, 8-bit data, 1 stop bit (8051 C)
 * Description  : Timer 1 mode 2 at TH1 = 0xFD sets the 9600 baud rate;
 *                ser_Tx() sends one character and clears TI.
 * Compiler     : Keil C51
 * Source       : Lab record, page 22
 */
#include <reg51.h>

void ser_Tx(unsigned char c)
{
    SBUF = c;
    while (TI == 0)
        ;
    TI = 0;
}

void main()
{
    TMOD = 0x20;
    TH1 = 0xFD;
    SCON = 0x50;
    TR1 = 1;
    while (1)
    {
        ser_Tx('Y');
        ser_Tx('E');
        ser_Tx('S');
        ser_Tx(' ');
    }
}

/* Output: Serial window (UART): YES YES YES .... continuously. */
