;Shahan Ali Memon
;Embedded Systems
;Hw-2 Task 1
;	.cdecls C,LIST,"tm4c123gh6pm.h"
	;.equ ,	0x400253FC

.data
buffer .int 0xFF,0xFF
valueTable .int 0x0011F04F,0x000000BB,0xCC,0xDD,0xEE,0xFF,0xAA,0xBB,0xCC,0xDD,0xEE,0xFF,0xAA,0xBB,0xCC,0xDD,0xEE,0xFF,0xAA,0xBB,0xCC,0xDD,0xEE,0xFF,0xAA,0xBB,0xCC,0xDD,0xEE,0xFF
;GPIO_PORTF_DATA_R .long 0x400253FC


.text

SYSCTL_RCGCGPIO_R .field	0x400FE608
UNLOCK_CONSTANT .field 0x4C4F434B
addressofvalueTable .field valueTable

;Addition of global vars for other ports i.e. D and E and F
GPIO_PORTD_LOCK_R .field 0x40007520
GPIO_PORTE_LOCK_R .field 0x40024520
GPIO_PORTF_LOCK_R .field	0x40025520

GPIO_PORTD_CR_R .field 0x40007524
GPIO_PORTE_CR_R .field 0x40024524
GPIO_PORTF_CR_R .field	0x40025524

GPIO_PORTD_AFSEL_R .field 0x40007420
GPIO_PORTE_AFSEL_R .field 0x40024420
GPIO_PORTF_AFSEL_R .field	0x40025420

GPIO_PORTD_PCTL_R .field	0x4000752C
GPIO_PORTE_PCTL_R .field	0x4002452C
GPIO_PORTF_PCTL_R .field	0x4002552C

GPIO_PORTD_DIR_R .field	0x40007400
GPIO_PORTE_DIR_R .field	0x40024400
GPIO_PORTF_DIR_R .field	0x40025400

GPIO_PORTD_AMSEL_R .field	0x40007528
GPIO_PORTE_AMSEL_R .field 	0x40024528
GPIO_PORTF_AMSEL_R .field	0x40025528

GPIO_PORTD_DATA_R .field 0x400073FC
GPIO_PORTE_DATA_R .field 0x400243FC
GPIO_PORTF_DATA_R .field 0x400253FC

GPIO_PORTD_DEN_R .field		0x4000751C
GPIO_PORTE_DEN_R .field		0x4002451C
GPIO_PORTF_DEN_R .field		0x4002551C

GPIO_PORTD_PUR_R .field	0x40007510
GPIO_PORTE_PUR_R .field	0x40024510
GPIO_PORTF_PUR_R .field	0x40025510

	;These functions are called from main
 	.global loop
 	.global setbits


BIT5	.equ	0x20



setbits
	;***********************************
	;SYSCTL_RCGCGPIO_R |= 0x38
	;enabling clock for D,E,F
	LDR	R1,SYSCTL_RCGCGPIO_R
	MOV	R0,#0x38
	STR	R0,[R1]
	;***********************************

	;***********************************
	;GPIO_PORTD_LOCK_R = 0x4C4F434B;
	;unlocking D port
	LDR	R1,GPIO_PORTD_LOCK_R
	LDR R0,UNLOCK_CONSTANT
	STR	R0,[R1]

	;GPIO_PORTE_LOCK_R = 0x4C4F434B;
	;unlocking E port
	LDR	R1,GPIO_PORTE_LOCK_R
	LDR R0,UNLOCK_CONSTANT
	STR	R0,[R1]

	;GPIO_PORTF_LOCK_R = 0x4C4F434B;
	;unlocking F port
	LDR	R1,GPIO_PORTF_LOCK_R
	LDR R0,UNLOCK_CONSTANT
	STR	R0,[R1]
	;***********************************

	;**********************************
	;GPIO_PORTD_CR_R = 0xFF;
	;setting bits in the CR register
	LDR	R1,GPIO_PORTD_CR_R
	MOV	R0,#0xFF
	STR	R0,[R1]

	;GPIO_PORTE_CR_R = 0xFF;
	;setting bits in the CR register
	LDR	R1,GPIO_PORTE_CR_R
	MOV	R0,#0xFF
	STR	R0,[R1]

	;GPIO_PORTF_CR_R = 0xFF;
	;setting bits in the CR register
	LDR	R1,GPIO_PORTF_CR_R
	MOV	R0,#0xFF
	STR	R0,[R1]
	;***********************************

	;***********************************
	; GPIO_PORTF_AMSEL_R = 0x00;
	; disabling analog functionality
	LDR	R1,GPIO_PORTD_AMSEL_R
	BFC	R0,#0,#32
	STR	R0,[R1]

	; GPIO_PORTF_AMSEL_R = 0x00;
	; disabling analog functionality
	LDR	R1,GPIO_PORTE_AMSEL_R
	BFC	R0,#0,#32
	STR	R0,[R1]

	; GPIO_PORTF_AMSEL_R = 0x00;
	; disabling analog functionality
	LDR	R1,GPIO_PORTF_AMSEL_R
	BFC	R0,#0,#32
	STR	R0,[R1]
	;************************************

	;************************************
	;GPIO_PORTD_PCTL_R = 0x00000000;
	;Select GPIO mode in PCTL
	LDR	R1,GPIO_PORTD_PCTL_R
	STR	R0,[R1]

	;GPIO_PORTE_PCTL_R = 0x00000000;
	;Select GPIO mode in PCTL
	LDR	R1,GPIO_PORTE_PCTL_R
	STR	R0,[R1]

	;GPIO_PORTF_PCTL_R = 0x00000000;
	;Select GPIO mode in PCTL
	LDR	R1,GPIO_PORTF_PCTL_R
	STR	R0,[R1]
	;************************************

	;***********************************
	;GPIO_PORTD_DIR_R = 0x0E;
	;D0 to D3 as outputs
	LDR	R1,GPIO_PORTD_DIR_R
	MOV	R0,#0x0F
	STR	R0,[R1]

	;GPIO_PORTE_DIR_R = 0x0E;
	;E1 input and E2 output
	LDR	R1,GPIO_PORTE_DIR_R
	MOV	R0,#0x04
	STR	R0,[R1]

	;GPIO_PORTF_DIR_R = 0x0E;
	;F0 and F4 input
	LDR	R1,GPIO_PORTF_DIR_R
	MOV	R0,#0x00
	STR	R0,[R1]
	;***********************************

	;***********************************
	;GPIO_PORTD_AFSEL_R = 0x00;
	;Disable alternate functionality
	LDR	R1,GPIO_PORTD_AFSEL_R
	BFC	R0,#0,#32
	STR	R0,[R1]

	;GPIO_PORTE_AFSEL_R = 0x00;
	;Disable alternate functionality
	LDR	R1,GPIO_PORTE_AFSEL_R
	BFC	R0,#0,#32
	STR	R0,[R1]

	;GPIO_PORTF_AFSEL_R = 0x00;
	;Disable alternate functionality
	LDR	R1,GPIO_PORTF_AFSEL_R
	BFC	R0,#0,#32
	STR	R0,[R1]
	;**********************************

	;**********************************
	;GPIO_PORTD_DEN_R = 0xFF;
	;enable digital ports
	LDR	R1,GPIO_PORTD_DEN_R
	MOV	R0,#0xFF
	STR	R0,[R1]

	;GPIO_PORTE_DEN_R = 0xFF;
	;enable digital ports
	LDR	R1,GPIO_PORTE_DEN_R
	MOV	R0,#0xFF
	STR	R0,[R1]

	;GPIO_PORTF_DEN_R = 0xFF;
	;enable digital ports
	LDR	R1,GPIO_PORTF_DEN_R
	MOV	R0,#0xFF
	STR	R0,[R1]

	;**********************************

	;*********************************
	;GPIO_PORTF_PUR_R = 0x11;
	LDR	R1,GPIO_PORTF_PUR_R
	MOV	R0,#0x11
	STR	R0,[R1]
	;*********************************

	MOV R8,#0 ;R8 is my fixed register for sum
	MOV R9,#0
	BX LR

;This will check if the button1 is pressed
buttonCheck1
			;Load the PortFs address
			LDR R1,GPIO_PORTF_DATA_R
			;Dereference it
			LDR R1,[R1]
			;And to see if last bit is 0
			;If 0, set Z flag
			ANDS R1,#0x01
			;If flag is not set, check if button2 is pressed
			BNE buttonCheck2
			;This means the Z bit was set
			;Now I need a delay
			;A for loop to avoid debouncing
			MOV R2,#10
forloop1	SUBS R2,#1
			BNE forloop1
			;Now a while loop to avoid debouncing
while1
			LDR R1,GPIO_PORTF_DATA_R
			LDR R1,[R1]
			ANDS R1,#0x01
			BEQ while1
			;As soon as it goes out, increment N and sum
incrementN
			ADD R9,#1
			ADD R8,R9

			;Now check button 2

buttonCheck2
			LDR R1,GPIO_PORTF_DATA_R
			LDR R1,[R1]
			ANDS R1,#0x10  ;Z bit will be set if R1 == 0
			;Now I need to check if the Z bit was set
			BNE buttonCheck3 ;this means it was not pressed
			;this means it was pressed
			;For loop to avoid debouncing
			MOV R2,#10
forloop2	SUBS R2,#1
			BNE forloop2
			;while loop to avoid debouncing
while2
			LDR R1,GPIO_PORTF_DATA_R
			LDR R1,[R1]
			ANDS R1,#0x10
			BEQ while2
			BNE runLEDs

			;runLeds corresponsding to sum(N)
runLEDs
			MOV R7,#16
			SUBS R3,R8,#16
			BGE runRedLED
			;If the redLED is not on, then show number
showNum
			LDR R1,GPIO_PORTD_DATA_R
			STR R8,[R1]

			;Now check button3
buttonCheck3
			LDR R1,GPIO_PORTE_DATA_R
			LDR R1,[R1]
			ANDS R1,#0x02
			BEQ loop
			MOV R2,#80
			;Avoiding debouncing
delay3
			SUBS R2,#1
			BNE delay3
			LDR R1,GPIO_PORTE_DATA_R
			LDR R1,[R1]
			ANDS R1,#0x02
			BNE turnOff
			B loop
			;turnOff the lights and set N to zero
turnOff
			LDR R1,GPIO_PORTD_DATA_R
			MOV R0,#0x00
			STR R0,[R1]
			MOV R8,#0
			MOV R9,#0
			B loop

runRedLED
			LDR R1,GPIO_PORTD_DATA_R
			MOV R0,#0x08
			STR R0,[R1]
			B loop

loop
			B buttonCheck1
			B buttonCheck2
			B buttonCheck3
.end

