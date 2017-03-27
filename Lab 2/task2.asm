;Shahan Ali Memon
;Embedded Systems
;Hw-2 Task 2
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

 	.global func
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

	MOV R12,#1950 ;R12 is my fixed register for motor speed at the rest speed
	MOV R11,#0 ;R11 is my fixed register for N


	BX LR


func
loop

buttonCheck1
			LDR R1,GPIO_PORTF_DATA_R
			LDR R1,[R1]
			ANDS R1,#0x01  ;Z bit will be set if R1 == 0
			BNE buttonCheck2 ;if not pressed just go to buttonCheck2
			;This means the Z bit was set
			;Now I need a delay

			MOV R2,#5
forloop1	SUBS R2,#1
			BNE forloop1

cond1
			LDR R1,GPIO_PORTF_DATA_R
			LDR R1,[R1]
			ANDS R1,#0x01
			BEQ cond1

incrementN
			MOV R0,#0x01
			ADD R11,R0

buttonCheck2
			LDR R1,GPIO_PORTF_DATA_R
			LDR R1,[R1]
			ANDS R1,#0x10
			BNE buttonCheck3

			MOV R2,#5
forloop2	SUBS R2,#1
			BNE forloop2

cond2
			LDR R1,GPIO_PORTF_DATA_R
			LDR R1,[R1]
			ANDS R1,#0x10
			BEQ cond2

updateN
			MOV R5,#7
			UDIV R6,R11,R5
			MUL R6,R6,R5
			SUB R11,R6

			;Now I need 6 if conditions
check0		SUBS R7, R11, #0
			BEQ	clearN

check1		SUBS R7, R11, #1
			;if n!=1 go to check2
			BNE	check2
			;else update the speed according to 1
			MOV R12,#2050
			B motorRotate

check2		SUBS R7, R11, #2
			;if n!=1 go to check3
			BNE	check3
			;else update the speed according to 2
			MOV R12,#2100
			B motorRotate

check3		SUBS R7, R11, #3
			;if n!=1 go to check4
			BNE	check4
			;else update the speed according to 3
			MOV R12,#3500
			B motorRotate

check4		SUBS R7, R11, #4
			;if n!=1 go to check5
			BNE	check5
			;else update the speed according to 4
			MOV R12,#1900
			B motorRotate

check5		SUBS R7, R11, #5
			;if n!=1 go to check6
			BNE	check6
			;else update the speed according to 5
			MOV R12,#1800
			B motorRotate

check6		SUBS R7, R11, #6
			;if n!=1 go to check2
			BNE	buttonCheck3
			;else update the speed according to 6
			MOV R12,#1400
;*****************************************
;*****************************************
;*****************************************
buttonCheck3
			LDR R1,GPIO_PORTE_DATA_R
			LDR R1,[R1]
			ANDS R1,#0x02
			BEQ motorRotate

			MOV R2,#5
forloop3	SUBS R2,#1
			BNE forloop3

cond3
			LDR R1,GPIO_PORTE_DATA_R
			LDR R1,[R1]
			ANDS R1,#0x02
			BNE cond3

clearN
			;setting N to zero
			MOV R11,#0
			MOV R12,#1950
			B loop

motorRotate
			LDR R1, GPIO_PORTE_DATA_R
			MOV R0,#0x04
			STR R0,[R1]

			MOV R0,R12 ;Setting the R0 to speed
outerLoop
			MOV R1,#10
innerLoop
			SUBS R1,#1
			BNE innerLoop
			SUBS R0,#1
			BNE outerLoop

			;clearing the bits
			LDR R1,GPIO_PORTE_DATA_R
			MOV R0,#0x00
			STR R0,[R1]

			MOV R0,#1000
outerLoop2
			MOV R1,#99
innerLoop2
			SUBS R1,#1
			BNE innerLoop2
			SUBS R0,#1
			BNE outerLoop2
			B loop
.end
