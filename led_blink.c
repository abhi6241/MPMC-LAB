/* Program      : Blink a single LED (8051)
 * Description  : Toggles an LED connected to pin P2.5 ON and OFF
 *                forever, with roughly 0.5 s between transitions
 *                (assuming a standard 12 MHz crystal).
 * Note         : LED wired active-LOW (0 = ON, 1 = OFF)          */

#include <reg51.h> /* SFR definitions for the 8051 (P2, etc.)  */

sbit led = P2 ^ 5; /* led = bit 5 of port P2 (the LED pin)     */

/* Software delay of about t milliseconds */
void delay(unsigned int t)
{
    unsigned int i, j;
    for (i = 0; i < t; i++) /* outer loop: t iterations      */
    {
        for (j = 0; j < 1275; j++)
            ; /* inner loop: ~1 ms busy wait   */
    }
}

void main()
{
    while (1) /* loop forever                  */
    {
        led = 0;    /* LED ON  (pin P2.5 low)        */
        delay(500); /* wait ~500 ms                  */
        led = 1;    /* LED OFF (pin P2.5 high)       */
        delay(500); /* wait ~500 ms                  */
    }
}

/* Output:
 * The LED on pin P2.5 blinks continuously with a ~1 s period:
 * ~0.5 s ON, ~0.5 s OFF, repeating forever (no exit from main).
 * P2.5 alternates between low (0) and high (1) every 500 ms.   */
