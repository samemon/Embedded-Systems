/*
 * Shahan Ali Memon
 * samemon
 * Embedded Systems - Hw1
 */


#include <stdint.h>
#include <stdbool.h>
#include <tm4c123gh6pm.h>
#include <sysctl.h>
/*
 * main.c
 */
extern void myfunc();
int main(void) {
    SysCtlClockSet(SYSCTL_SYSDIV_2_5 | SYSCTL_USE_PLL | SYSCTL_OSC_MAIN | SYSCTL_XTAL_16MHZ);
    setbits();
    loop();
	return 0;
}
