/* Program      : Display text on a 16x2 LCD (8051)
 * Description  : Initializes an HD44780-style LCD in 8-bit mode,
 *                then shows "ECE-B" on line 1 and "MPMC-LAB" on
 *                line 2.
 * Connections  : LCD data bus  -> Port P2
 *                RS (register select) -> P3.0
 *                EN (enable)          -> P3.1
 *                (R/W tied to ground = write only)               */

#include <reg51.h> /* SFR definitions for the 8051 (P2, etc.)  */

sbit RS = P3 ^ 0; /* RS = 0: command, RS = 1: data            */
sbit EN = P3 ^ 1; /* EN: data latched on falling edge         */

#define LCD P2 /* LCD data bus on port P2                  */

/* Delay of about i milliseconds */
void delay(unsigned int i)
{
    unsigned int j;
    while (i-- > 0) /* outer loop: i iterations      */
    {
        for (j = 0; j < 500; j++)
            ; /* inner loop: ~1 ms busy wait   */
    }
}

/* Send a command byte to the LCD (RS = 0) */
void cmd_lcd(unsigned char c)
{
    RS = 0;   /* select command register       */
    LCD = c;  /* put command on the data bus   */
    EN = 1;   /* pulse enable high...          */
    delay(2); /* ...give the LCD time to read  */
    EN = 0;   /* falling edge latches command  */
}

/* Send a data byte (one character) to the LCD (RS = 1) */
void write_lcd(unsigned char c)
{
    RS = 1;   /* select data register          */
    LCD = c;  /* put character on the data bus */
    EN = 1;   /* pulse enable high...          */
    delay(2); /* ...give the LCD time to read  */
    EN = 0;   /* falling edge latches char     */
}

/* Initialize the LCD */
void init_lcd()
{
    delay(10);     /* wait for LCD power-on ready   */
    cmd_lcd(0x38); /* function set: 8-bit, 2 lines  */
    cmd_lcd(0x0E); /* display on, cursor on         */
    cmd_lcd(0x06); /* entry mode: auto-increment    */
    cmd_lcd(0x01); /* clear display, home cursor    */
}

/* Write a null-terminated string to the LCD */
void display(unsigned char *s)
{
    while (*s) /* until the end of the string   */
    {
        write_lcd(*s++); /* send one character at a time  */
    }
}

void main()
{
    init_lcd();          /* initialize LCD: 2 lines, display on  */

    while (1)            /* keep refreshing the display forever  */
    {
        cmd_lcd(0x01);   /* clear display and home the cursor    */
        cmd_lcd(0x35);   /* (function-set / cursor command)      */
        display("ECE-B");    /* print "ECE-B" on line 1           */
        cmd_lcd(0xc3);   /* cursor to line 2, position 3         */
        display("MPMC-LAB"); /* print "MPMC-LAB" on line 2        */
        delay(500);      /* hold the display for ~500 ms         */
    }
}

/* Output:
 * The 16x2 LCD shows:
 *   line 1: "ECE-B"     (starting at position 0)
 *   line 2: "   MPMC-LAB" (starting at position 3)
 * The screen is cleared and redrawn every ~500 ms (the while(1)
 * loop), so the text stays visible with a constant refresh.       */
