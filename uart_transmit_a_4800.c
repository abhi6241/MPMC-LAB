/* Program      : Transmit character 'A' continuously (8051)
 * Description  : UART transmission at 4800 baud, 8-bit data.
 * Clock        : 11.0592 MHz crystal; Timer 1 mode 2.
 * Compiler     : Keil C51
 */
#include <reg51.h>

void main(void)
{
    TMOD = 0x20; /* Timer 1, mode 2 (8-bit auto-reload) */
    TH1 = 0xFA;  /* Reload value for 4800 baud */
    SCON = 0x50; /* Serial mode 1, 8-bit UART, receiver enabled */
    TR1 = 1;     /* Start Timer 1 */

    while (1)
    {
        SBUF = 'A';       /* Load character into serial buffer */
        while (TI == 0)   /* Wait until transmission completes */
            ;
        TI = 0;           /* Clear transmit interrupt flag */
    }
}

/* Output: Terminal repeatedly receives A at 4800 baud. */
