/* Program      : Transmit YES continuously at 4800 baud (8051)
 * Clock        : 11.0592 MHz crystal; Timer 1 mode 2.
 * Compiler     : Keil C51
 */
#include <reg51.h>

void send_char(unsigned char data)
{
    SBUF = data;          /* Load one character for transmission */
    while (TI == 0)       /* Wait for transmit completion */
        ;
    TI = 0;               /* Clear transmit flag */
}

void main(void)
{
    TMOD = 0x20; /* Timer 1, mode 2 */
    TH1 = 0xFA;  /* 4800 baud */
    SCON = 0x50; /* UART mode 1 */
    TR1 = 1;     /* Start baud-rate timer */

    while (1)
    {
        send_char('Y');
        send_char('E');
        send_char('S');
        send_char(' ');   /* Separate repeated words */
    }
}

/* Output: YES YES YES ... at 4800 baud. */
