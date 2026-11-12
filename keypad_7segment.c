/* Program      : Display keypad key on seven-segment (8051)
 * Description  : Scans a 3x3 keypad and displays key 1-9.
 * Connections  : Rows P1.0-P1.2, columns P1.4-P1.6;
 *                common-cathode seven-segment data on P2.
 * Compiler     : Keil C51
 */
#include <reg51.h>

unsigned char code segment_code[10] = {
    0x3F, 0x06, 0x5B, 0x4F, 0x66,
    0x6D, 0x7D, 0x07, 0x7F, 0x6F
};

unsigned char scan_key(void)
{
    unsigned char row, col;
    unsigned char code row_pattern[3] = {0xFE, 0xFD, 0xFB};
    for (row = 0; row < 3; row++)
    {
        P1 = 0xFF;
        P1 = row_pattern[row]; /* Drive selected row low */
        col = P1 & 0x70;        /* Read column pins */
        if (col != 0x70)
        {
            if ((col & 0x10) == 0) return row * 3 + 1;
            if ((col & 0x20) == 0) return row * 3 + 2;
            if ((col & 0x40) == 0) return row * 3 + 3;
        }
    }
    return 0;
}

void delay(void)
{
    unsigned int i;
    for (i = 0; i < 2000; i++)
        ;
}

void main(void)
{
    unsigned char key;
    P1 = 0xFF;
    while (1)
    {
        key = scan_key();
        if (key != 0)
        {
            P2 = segment_code[key]; /* Display pressed digit */
            delay();
            while (scan_key() != 0)
                ; /* Wait for key release */
        }
    }
}

/* Output: Pressing keys 1-9 displays the matching digit.
 * Confirm row/column wiring and display polarity before use. */
