/* Program      : Display required characters on 16x2 LCD display (8051 C)
 * Description  : HD44780-style LCD in 8-bit mode. Data bus on P2,
 *                RS on P0.0, EN on P0.1. Clears the screen and shows
 *                " ECE-B" forever.
 * Compiler     : Keil C51
 * Source       : Lab record, page 26
 */
#include <reg51.h>

#define LCD P2
sbit RS = P0^0;
sbit EN = P0^1;

void delay(unsigned int t)
{
    unsigned int i, j;
    for (i = 0; i < t; i++) /* NOTE: record prints "j++" here */
    {
        for (j = 0; j < 1275; j++)
            ;
    }
}

void cmd_lcd(unsigned char c)
{
    RS = 0;
    LCD = c;
    EN = 1; delay(2);
    EN = 0;
}

void write_LCD(unsigned char c)
{
    EN = 1;
    RS = 1;
    LCD = c; delay(2);
    EN = 0;
}

void display(unsigned char *s)
{
    while (*s)
    {
        write_LCD(*s++);
    }
}

void init_lcd(void)
{
    delay(10);
    cmd_lcd(0x38);
    cmd_lcd(0x0E);
    cmd_lcd(0x06);
    cmd_lcd(0x01);
}

void main()
{
    init_lcd();
    while (1)
    {
        cmd_lcd(0x01);
        cmd_lcd(0x80);
        display(" ECE-B"); /* NOTE: the record first wrote
                              display("ABCD") here and struck it
                              out; final version shows " ECE-B" */
        delay(5000);
    }
}

/* Output: LCD line 1 shows " ECE-B", cleared and refreshed every
 * ~5 s. (Proteus screenshot in the record shows "ECE-B MPMC Lab_".) */
