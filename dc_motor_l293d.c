/* Program      : Interface DC motor to 8051 using L293D (8051 C)
 * Description  : IN1/IN2 on P2.0/P2.1 drive the L293D; the motor
 *                turns clockwise, stops, turns anti-clockwise, stops,
 *                forever.
 * Compiler     : Keil C51
 * Source       : Lab record, page 30
 */
#include <reg51.h>

sbit IN1 = P2^0;
sbit IN2 = P2^1; /* NOTE: record's second line reads "sbit IN1=P2^1";
                    main() uses IN2, so it is written as IN2 here */

void delay(unsigned int t)
{
    unsigned int i, j;
    for (i = 0; i < t; i++)
        for (j = 0; j < 1275; j++)
            ;
}

void main()
{
    while (1)
    {
        IN1 = 1; IN2 = 0; delay(500); /* clkwise */
        IN1 = 0; IN2 = 0; delay(200); /* stop */
        IN1 = 0; IN2 = 1; delay(500); /* Anti-clkwise */
        IN1 = 0; IN2 = 0; delay(200); /* stop */
    }
}

/* Output: DC motor runs clockwise ~0.5 s, stops ~0.2 s, runs
 * anti-clockwise ~0.5 s, stops ~0.2 s, and repeats. */
