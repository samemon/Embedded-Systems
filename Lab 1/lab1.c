/*
 * Shahan Ali Memon
 * samemon
 * Embedded Systems - Hw1
 */


#include <stdint.h>
#include <stdbool.h>
#include <tm4c123gh6pm.h>
#include <sysctl.h>
#include <string.h>
#include<stdio.h>
#include<stdlib.h>

//Defining macros for the motor speed and direction
#define MS_20 99914
#define MAX_CLOCKWISE 14000
#define MAX_ANTICLOCKWISE 7000
#define MIN_CLOCKWISE 10500
#define MIN_ANTICLOCKWISE 9000
#define REST 10000


/*
 * Should the LEDs  go from 1 to 4 or 4 to 1
 * Also defines the direction of the motor
 * where 0->clockwise and 1->anticlockwise
 */
int reverse = 0;
/*
 * 0 means button is not pressed, 1 otherwise
 */
int button1 = 0;
int button2 = 0;
int button3 = 0;


/*
 * Defining state of speed and dir for the motor
 */
int speed = REST;

/*
 * This need not to be global, but for
 * modularization it is.
 * It is used to figure out the initial
 * button press event i.e. if any button is
 * pressed at the beginning for the program
 * to run
 */

int flag = 1;
/*
 * Requires: 0
 * Ensures: PortE Data == input
 */

int ledNumber = 1;

void PortE2_Output(int ms)
{
	GPIO_PORTE_DATA_R = 0x04;//(GPIO_PORTE_DATA_R | 0x04);
	int i;
	for(i=0; i < ms ; i++)
		asm("   nop");
	GPIO_PORTE_DATA_R = 0x00;//(GPIO_PORTE_DATA_R | 0x00);
	for(i=0; i< MS_20 ; i++) //golden number
			asm("   nop");
}

/*
 * Requires: a 32 bit input
 * Ensures: PortD Data == input
 */

void PortD_Output(uint32_t data)
{
	GPIO_PORTD_DATA_R = data;
}

/*
 * Requires: 0
 * Returns: Returns the LSB of Port F
 */

uint32_t PortF0_Input(void)
{
	return (GPIO_PORTF_DATA_R & 0x01);
}

/*
 * Requires: 0
 * Returns: Returns the 5th bit from right
 * for Port F
 */

uint32_t PortF4_Input(void)
{
	return (GPIO_PORTF_DATA_R & 0x10);
}

/*
 * Requires: 0
 * Returns: Returns the 2nd bit from right
 * for Port E
 */

uint32_t PortE1_Input(void)
{
	return (GPIO_PORTE_DATA_R & 0x02);
}

/*
 * Checks if the button1 is pressed,
 * if yes -> LEDs should move from 1-4
 * 			 state of button1 and button2
 * 			 changes
 * if no -> return
 * PS: flag is there just for initial case
 *     when this function is called.
 */

void button1Check()
{
	if(PortF0_Input() == 0x00)
	{
		while(PortF0_Input() == 0x00)
		{
			PortE2_Output(speed);
		}
		//At this point it has actually been pressed
		/* First we need to check if the button2 was already pressed
		 * If so we need to stop the motor
		 * If not, then we check if button1 was already pressed
		 * If so, we need to increase the speed
		 * If not then we need to move clockwise
		 */
		button1 = 1;
		flag = 0;
		if(button2 == 1)
		{
			speed = REST;
		}

		else if(button2 == 0 && speed != REST)
		{
			if(speed < MAX_CLOCKWISE) //then we need to decrease the speed
			{
				speed = speed + 100;
			}

		}
		else if(speed == REST && flag == 0) //this is starting condition
		{
			speed = MIN_CLOCKWISE;
		}

		else
		{
			speed = REST;
		}


	    reverse = 0;
	    button2 = 0;

	 }
	PortE2_Output(speed);
}

/*
 * Checks if the button2 is pressed,
 * if yes -> LEDs should move from 4-1
 * 			 state of button1 and button2
 * 			 changes
 * if no -> return
 * PS: flag is there just for initial case
 *     when this function is called.
 */

void button2Check()
{

	if(PortF4_Input() == 0x00)
	{
		while(PortF4_Input() == 0x00)
		{
			PortE2_Output(speed);

		}
		//At this point it has actually been pressed
		/* First we need to check if the button1 was already pressed
		 * If so we need to stop the motor
		 * If not, then we check if button2 was already pressed
		 * If so, we need to increase the speed
		 * If not then we need to move anticlockwise
		 */
	    button2 = 1;
	    flag = 0;
		if(button1 == 1)
		{
			speed = REST;
		}

		else if(button1 == 0 && speed != REST)
		{
			if(speed > MAX_ANTICLOCKWISE) //then we need to increase the speed
			{
				speed = speed - 100;
			}

		}
		else if(speed == REST && flag == 0)
		{
			speed = MIN_ANTICLOCKWISE;
		}

		else
		{
			speed = REST;
		}


	    reverse = 1;
	    button1 = 0;

	}

	PortE2_Output(speed);
}

/*
 * Check is the button3 is pressed,
 * if yes -> stop and until it's not
 * pressed again, don't move
 */

void button3Check()
{
	PortE2_Output(speed);
	if(PortE1_Input() == 0x02)
	{
		while(PortE1_Input() == 0x02)
		{
			PortE2_Output(speed);
		}
		button3 = 1;
		while(button3 != 0)
		{
			if(PortE1_Input() == 0x02)
			{
				while(PortE1_Input() == 0x02)
				{
					PortE2_Output(speed);
				}
				button3 = 0;
			}
			PortE2_Output(speed);
		}

	}

}

/*
 * Checks if any event has occurred
 */


void buttonCheck()
{

	button1Check();
	button2Check();
	button3Check();
}
/*
 * Requires: The Led Number
 * Ensures: To turn on the Led associated to it
 */

void runLed(int ledNum)
{
	if(ledNum == 1)
	{
		PortD_Output(0x01);
	}

	else if(ledNum == 2)
	{
		PortD_Output(0x02);
	}

	else if(ledNum == 3)
	{
		PortD_Output(0x04);
	}

	else
	{
		PortD_Output(0x08);
	}
}

/*
 * Function used for delay
 * While it's in delay, it checks for any button pressed
 */

void delayFunc()
{
	buttonCheck();
    int i,j;
    for (i = 0; i <400;i++)
        for (j = 0; j <400;j++)
        {

            asm("   nop");
        }
}
/*
 * main.c
 */
int main(void) {
	SysCtlClockSet(SYSCTL_SYSDIV_2_5 | SYSCTL_USE_PLL | SYSCTL_OSC_MAIN | SYSCTL_XTAL_16MHZ);
	SYSCTL_RCGCGPIO_R |= 0x38; // enable clock for PORT D,E,F
	GPIO_PORTD_LOCK_R = 0x4C4F434B; //unlocking the D port
	GPIO_PORTE_LOCK_R = 0x4C4F434B; //unlocking the E port
	GPIO_PORTF_LOCK_R = 0x4C4F434B; //unlocking the F port

	GPIO_PORTD_CR_R = 0xFF; //setting bits in the CR register
	GPIO_PORTE_CR_R = 0xFF; //setting bits in the CR register
	GPIO_PORTF_CR_R = 0xFF; //setting bits in the CR register

	GPIO_PORTD_AMSEL_R = 0x00; //disable analog
	GPIO_PORTE_AMSEL_R = 0x00; //disable analog
	GPIO_PORTF_AMSEL_R = 0x00; //disable analog

	GPIO_PORTD_PCTL_R = 0x00000000; // Select GPIO mode in PCTL
	GPIO_PORTE_PCTL_R = 0x00000000; // Select GPIO mode in PCTL
	GPIO_PORTF_PCTL_R = 0x00000000; // Select GPIO mode in PCTL

	GPIO_PORTD_DIR_R = 0x0F; //D0-D3 out and others in
	GPIO_PORTE_DIR_R = 0x04; //E2 out and E1 in
	GPIO_PORTF_DIR_R = 0x00; //all in

	GPIO_PORTD_AFSEL_R = 0x00; // Disable alternate functionality
	GPIO_PORTE_AFSEL_R = 0x00; // Disable alternate functionality
	GPIO_PORTF_AFSEL_R = 0x00; // Disable alternate functionality

	GPIO_PORTD_DEN_R = 0xFF; //Enable digital ports
	GPIO_PORTE_DEN_R = 0xFF; //Enable digital ports
	GPIO_PORTF_DEN_R = 0xFF; //Enable digital ports

	GPIO_PORTF_PUR_R = 0x11;
	while(flag)
	{
		//PortE2_Output();
		buttonCheck();
	}

	ledNumber = 1;
    while (1)
    {
			if(reverse == 1)
			{
				runLed(ledNumber);
				if(ledNumber <= 1)
					ledNumber = 4;
				else
					ledNumber--;

				delayFunc();

			}
			else
			{
				runLed(ledNumber);
				if(ledNumber >= 4)
					ledNumber = 1;
				else
					ledNumber++;

				delayFunc();

			}


    }
}
