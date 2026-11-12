/* Program      : Interface 16x2 LCD and keypad with 8051 MC (8051 C)
 * Description  : Rows R1-R4 on P1.0-P1.3, columns C1-C3 on
 *                P1.4-P1.6; LCD data bus on 0xA0 (P2), rs/rw/en on
 *                P3.7/P3.6/P3.5. Prints "Key Test:" and shows the
 *                pressed key on the second line.
 * Compiler     : Keil C51 (at89x52.h)
 * Source       : Lab record, pages 28-29
 */
#include <at89x52.h>

sbit R1 = P1^0;
sbit R2 = P1^1;
sbit R3 = P1^2;
sbit R4 = P1^3;
sbit C1 = P1^4;
sbit C2 = P1^5;
sbit C3 = P1^6;
sfr ldata = 0xA0;
sbit rs = P3^7;
sbit rw = P3^6;
sbit en = P3^5;

void delay(int t)
{
    int i, j;
    for (i = 0; i < t; i++)
        for (j = 0; j < 1275; j++)
            ;
}

void lcd_cmd(char c)
{
    ldata = c;
    rs = 0;
    rw = 0;
    en = 1; delay(1);
    en = 0;
}

void lcd_data(char c)
{
    ldata = c; rs = 1;
    rw = 0;
    en = 1; delay(1);
    en = 0;
}

char keyscan()
{
    R1 = R2 = R3 = R4 = 0;
    C1 = C2 = C3 = 1;
    while (1)
    {
        if (C1 == 0 || C2 == 0 || C3 == 0)
        {
            /* ROW1 */
            R1 = 0;
            R2 = R3 = R4 = 1;
            if (C1 == 0)
                return 1;
            if (C2 == 0)
                return 2;
            if (C3 == 0)
                return 3;
            /* ROW2 */
            R2 = 0; R1 = R3 = R4 = 1;
            if (C1 == 0)
                return 4;
            if (C2 == 0)
                return 5;
            if (C3 == 0)
                return 6;
            /* ROW3 */
            R3 = 0; R1 = R2 = R4 = 1;
            if (C1 == 0)
                return 7;
            if (C2 == 0)
                return 8;
            if (C3 == 0)
                return 9;
            /* ROW4 */
            R4 = 0; R1 = R2 = R3 = 1;
            if (C1 == 0)
                return '*';
            if (C2 == 0)
                return 0;
            if (C3 == 0)
                return '#';
        }
    }
}

void lcd_print(char *s)
{
    while (*s)
    {
        lcd_data(*s);
        s++;
    }
}

void lcdinit(void)
{
    lcd_cmd(0x38);
    lcd_cmd(0x0E);
    lcd_cmd(0x01);
    lcd_cmd(0x06);
}

void main()
{
    lcdinit();
    lcd_cmd(0x80);
    lcd_print("Key Test:");
    lcd_cmd(0xC0);
    while (1)
    {
        int key;
        key = keyscan();
        if (key >= 0 && key <= 9)
        {
            lcd_data(key + '0');
        }
        else
        {
            lcd_data(key);
        }
        delay(100);
    }
}

/* Output: LCD shows "Key Test:" on line 1; the pressed keypad key
 * (1-9, *, 0, #) appears on line 2. */
