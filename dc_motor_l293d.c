/* Program      : DC motor interfacing with 8051 using L293D
 * Description  : Runs clockwise, stops, then runs anticlockwise.
 * Connections  : IN1 -> P2.0, IN2 -> P2.1; motor on L293D outputs.
 *                Enable pin must be high; motor supply is separate.
 * Compiler     : Keil C51
 */
#include <reg51.h>

sbit IN1 = P2^0;
sbit IN2 = P2^1;

void delay(unsigned int t)
{
    unsigned int i, j;
    for (i = 0; i < t; i++)
        for (j = 0; j < 1275; j++)
            ;
}

void main(void)
{
    while (1)
    {
        IN1 = 1; IN2 = 0; /* Clockwise rotation */
        delay(500);
        IN1 = 0; IN2 = 0; /* Stop */
        delay(200);
        IN1 = 0; IN2 = 1; /* Anticlockwise rotation */
        delay(500);
        IN1 = 0; IN2 = 0; /* Stop */
        delay(200);
    }
}

/* Output: Motor alternates clockwise, stop, anticlockwise, stop.
 * Use an external motor supply and common ground. */
