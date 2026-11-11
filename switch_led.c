/* Program      : Control an LED with a switch (8051)
 * Description  : Reads a switch on pin P1.5 and drives an LED on
 *                pin P2.5 accordingly: switch closed (input high)
 *                -> LED ON; switch open -> LED OFF.
 * Note         : LED wired active-LOW (0 = ON, 1 = OFF)          */

#include <reg51.h>   /* SFR definitions for the 8051 (P2, etc.)  */

sbit led = P2^5;     /* led = bit 5 of port P2 (the LED pin)     */
sbit sw  = P1^5;     /* sw  = bit 5 of port P1 (the switch pin)  */

void main()
{
    while (1)                    /* loop forever                  */
    {
        if (sw == 1)             /* switch pressed / line high    */
            led = 0;             /*   LED ON  (pin P2.5 low)      */
        else                     /* switch released / line low    */
            led = 1;             /*   LED OFF (pin P2.5 high)     */
    }
}

/* Output:
 * The LED on P2.5 continuously mirrors the switch on P1.5:
 *   sw = 1 -> LED ON
 *   sw = 0 -> LED OFF
 * Updates instantly, polling the switch in an endless loop.       */
