// Scott Holley
// CS413 Lab 5
// coffee maker button input


/*
Makes it easier to use in the program
*/
.equ small, 6
.equ medium, 8
.equ large, 10
.equ start_waterCount, 48
.equ PUD_UP, 2
.equ low, 0
.equ high, 1

.global main
/*-----------------------------------------------------------------------------*/
main:
	//set up led access
	BL wiringPiSetup
	CMP r0, #-1 //check if an error was encountered
	BEQ ledProbMenu //on error, exit immediately
	
	//set up pin2 for output
	LDR r0, =pin2
	LDR r0, [r0]
	MOV r1, #1 //1 is the code for output
	BL pinMode

	//set up pin3 for output
	LDR r0, =pin3
	LDR r0, [r0]
	MOV r1, #1
	BL pinMode

	//set up pin4 for output
	LDR r0, =pin4
	LDR r0, [r0]
	MOV r1, #1
	BL pinMode

	//set the pin5 mode to output
	LDR r0, =pin5
	LDR r0, [r0]
	MOV r1, #1
	BL pinMode
	
	//set up blue button for input
	LDR r0, =BLUE
	LDR r0, [r0]
	MOV r1, #0 //0 is the code for input
	BL pinMode
	
	//set up green button for input
	LDR r0, =Green
	LDR r0, [r0]
	MOV r1, #0
	BL pinMode
	
	//set up yellow button for input
	LDR r0, =YELLOW
	LDR r0, [r0]
	MOV r1, #0
	BL pinMode
	
	//set up red button for input
	LDR r0, =RED
	LDR r0, [r0]
	MOV r1, #0
	BL pinMode
	
	//set read method on buttons
	LDR r0, =BLUE
	LDR r0, [r0]
	MOV r1, #PUD_UP
	BL pullUpDnControl
	
	LDR r0, =Green
	LDR r0, [r0]
	MOV r1, #PUD_UP
	BL pullUpDnControl
	
	LDR r0, =YELLOW
	LDR r0, [r0]
	MOV r1, #PUD_UP
	BL pullUpDnControl
	
	LDR r0, =RED
	LDR r0, [r0]
	MOV r1, #PUD_UP
	BL pullUpDnControl
	
	//set up registers to debounce buttons and prevent firing on hold
	MOV r5, #0xff
	MOV r6, #0xff
	MOV r7, #0xff
	MOV r8, #0xff

	//set up stack and frame pointers
	LDR sp, =bottomOfStack
	MOV fp, sp
	STR fp, [sp]
	
	//set up starting water resevoir, store it in r0
	MOV r0, #start_waterCount
	//r1 will hold number of small cups brewed
	MOV r1, #0
	//r2 will hold number of medium cups brewed
	MOV r2, #0
	//r3 will hold number of large cups brewed
	MOV r3, #0
	
	//store values so they stay untouched during all the prints
	STMFD sp!, {r0, r1, r2, r3}
/*-----------------------------------------------------------------------------*/
mainMenu:
	//print out main menu
	LDR r0, =Intro_message
	BL printf
	
//delay to debounce the buttons
startLoop:
	LDR r0, =Delay_Buttons
	LDR r0, [r0]
	BL delay
	
//wait for user to press red button to begin
initialRed_read_in:
	LDR r0, =RED
	LDR r0, [r0]
	BL digitalRead
	
	//see if button is being pressed
	CMP r0, #high
	MOVEQ r5, r0 //not pressed, set last value as such, do nothing else
	BEQ startLoop
	
	//button was pressed, see if being held
	CMP r5, #low
	BEQ startLoop
	
	//new button press, turn on red led and move on with app
	MOV r5, r0
	//turn on red led at pin5, will remain on until program exits
	LDR r0, =pin5
	LDR r0, [r0]
	MOV r1, #1 //1 tells the led to turn on
	BL digitalWrite
/*-----------------------------------------------------------------------------*/	
sizeMenu:
	//print out size menu
	LDR r0, =menu
	BL printf
/*-----------------------------------------------------------------------------*/	
//delay to debounce buttons
menu_loop:
	LDR r0, =Delay_Buttons
	LDR r0, [r0]
	BL delay
/*-----------------------------------------------------------------------------*/	
//check the buttons to see which is pressed
Blue_read_in:
	LDR r0, =BLUE
	LDR r0, [r0]
	BL digitalRead
	
	//see if button is being pressed
	CMP r0, #high
	MOVEQ r6, r0 //not pressed, set last value as such, do nothing else
	BEQ Green_read_in
	
	//button was pressed, see if being held
	CMP r6, #low
	BEQ Green_read_in
	
	//new button press, user wants a large coffee
	MOV r6, r0
	B Large_cup
/*-----------------------------------------------------------------------------*/	
Green_read_in:
	LDR r0, =Green
	LDR r0, [r0]
	BL digitalRead
	
	//see if button is being pressed
	CMP r0, #high
	MOVEQ r7, r0 //not pressed, set last value as such, do nothing else
	BEQ Yellow_read_in
	
	//button was pressed, see if being held
	CMP r7, #low
	BEQ Yellow_read_in
	
	//new button press, user wants a medium coffee
	MOV r7, r0
	B Med_cup
/*-----------------------------------------------------------------------------*/	
Yellow_read_in:
	LDR r0, =YELLOW
	LDR r0, [r0]
	BL digitalRead
	
	//see if button is being pressed
	CMP r0, #high
	MOVEQ r8, r0 //not pressed, set last value as such, do nothing else
	BEQ Red_read_in
	
	//button was pressed, see if being held
	CMP r8, #low
	BEQ Red_read_in
	
	//new button press, user wants a small coffee
	MOV r8, r0
	B Small_cup
/*-----------------------------------------------------------------------------*/	
Red_read_in:
	LDR r0, =RED
	LDR r0, [r0]
	BL digitalRead
	
	//see if button is being pressed
	CMP r0, #high
	MOVEQ r5, r0 //not pressed, set last value as such, do nothing else
	BEQ menu_loop
	
	//button was pressed, see if being held
	CMP r5, #low
	BEQ menu_loop
	
	//new button press, user wants to exit
	MOV r5, r0
	B exitMenu
/*-----------------------------------------------------------------------------*/	
Small_cup:
	//if they were able to choose a small cup, must have enough water, otherwise would have exited after last cup
	LDR r0, =good_to_continue
	BL printf
	
	//user wants to start brewing
	//all input has been acquired, get the important values off the stack
	LDMFD sp!, {r0, r1, r2, r3}
	SUB r0, r0, #small //remove the needed water from the reservoir
	ADD r1, r1, #1
	
	//store values again to prep for the next cycle
	STMFD sp!, {r0, r1, r2, r3}
	
	//turn on the yellow led on pin4 for 6 seconds
	LDR r0, =pin4
	LDR r0, [r0]
	MOV r1, #1 //1 tells the led to turn on
	BL digitalWrite
	
	//delay for 6 seconds
	LDR r0, =small_delay
	LDR r0, [r0]
	BL delay
	
	//turn the led off
	LDR r0, =pin4
	LDR r0, [r0]
	MOV r1, #0 //0 turns the led off
	BL digitalWrite

	LDMFD sp!, {r0} //only need r0 to check if there is enough water
	CMP r0, #small
	BLT outOfWaterMenu //check if there is not enough water remaining
	STMFD sp!, {r0} //put r0 back in place on the stack to get ready for next cycle
	
	LDR r0, =Completion
	BL printf
	B sizeMenu
/*-----------------------------------------------------------------------------*/	
Med_cup:
	//check if there is enough remaining water
	LDMFD sp!, {r0, r1, r2, r3}
	CMP r0, #medium
	STMFD sp!, {r0, r1, r2, r3}
	BLT Need_refill_prompt
	
	LDR r0, =good_to_continue
	BL printf
	
	//user wants to start brewing
	//all input has been acquired, get the important values off the stack
	LDMFD sp!, {r0, r1, r2, r3}
	SUB r0, r0, #medium //remove the needed water from the reservoir
	ADD r2, r2, #1
	
	//store values again to prep for the next cycle
	STMFD sp!, {r0, r1, r2, r3}
	
	//turn on the green led on pin3 for 8 seconds
	LDR r0, =pin3
	LDR r0, [r0]
	MOV r1, #1 //1 tells the led to turn on
	BL digitalWrite
	
	//delay for 8 seconds
	LDR r0, =med_delay
	LDR r0, [r0]
	BL delay
	
	//turn the led off
	LDR r0, =pin3
	LDR r0, [r0]
	MOV r1, #0 //0 turns the led off
	BL digitalWrite

	LDMFD sp!, {r0} //only need r0 to check if there is enough water
	CMP r0, #small
	BLT outOfWaterMenu //check if there is not enough water remaining
	STMFD sp!, {r0} //put r0 back in place on the stack to get ready for next cycle
	
	LDR r0, =Completion
	BL printf
	B sizeMenu
/*-----------------------------------------------------------------------------*/	
Large_cup:
	//check if there is enough remaining water
	LDMFD sp!, {r0, r1, r2, r3}
	CMP r0, #large
	STMFD sp!, {r0, r1, r2, r3}
	BLT Need_refill_prompt
	
	LDR r0, =good_to_continue
	BL printf
	
	//user wants to start brewing
	//all input has been acquired, get the important values off the stack
	LDMFD sp!, {r0, r1, r2, r3}
	SUB r0, r0, #large //remove the needed water from the reservoir
	ADD r3, r3, #1
	
	//store values again to prep for the next cycle
	STMFD sp!, {r0, r1, r2, r3}
	
	//turn on the blue led on pin2 for 6 seconds
	LDR r0, =pin2
	LDR r0, [r0]
	MOV r1, #1 //1 tells the led to turn on
	BL digitalWrite
	
	//delay for 10 seconds
	LDR r0, =large_delay
	LDR r0, [r0]
	BL delay
	
	//turn the led off
	LDR r0, =pin2
	LDR r0, [r0]
	MOV r1, #0 //0 turns the led off
	BL digitalWrite

	LDMFD sp!, {r0} //only need r0 to check if there is enough water
	CMP r0, #small
	BLT outOfWaterMenu //check if there is not enough water remaining
	STMFD sp!, {r0} //put r0 back in place on the stack to get ready for next cycle
	
	LDR r0, =Completion
	BL printf
	B sizeMenu
/*-----------------------------------------------------------------------------*/	
Need_refill_prompt:
	LDR r0, =No_water
	BL printf
	B sizeMenu
/*-----------------------------------------------------------------------------*/	
outOfWaterMenu:
	LDR r0, =refillMessage
	BL printf
	
	//set up to blink the led 3 times
	MOV r4, #0
/*-----------------------------------------------------------------------------*/	
LED_loop:
	//led started on, turn it off
	LDR r0, =pin5
	LDR r0, [r0]
	MOV r1, #0 //0 tells led to turn off
	BL digitalWrite
	
	//wait 5 seconds
	LDR r0, =min_delay
	LDR r0, [r0]
	BL delay
	
	//turn led back on
	LDR r0, =pin5
	LDR r0, [r0]
	MOV r1, #1 //1 turns led on
	BL digitalWrite
	
	//wait 5 seconds
	LDR r0, =min_delay
	LDR r0, [r0]
	BL delay
	
	ADD r4, r4, #1
	CMP r4, #3
	BNE LED_loop //only blink 3 times
/*-----------------------------------------------------------------------------*/
exitMenu:
	//turn off red led at pin5
	LDR r0, =pin5
	LDR r0, [r0]
	MOV r1, #0 //0 tells led to turn off
	BL digitalWrite

	LDR r0, =shutdownMessage
	BL printf
	B exit
/*-----------------------------------------------------------------------------*/	
ledProbMenu:
	LDR r0, =ledProb
	BL printf
/*-----------------------------------------------------------------------------*/	
exit:
	MOV r7, #0x01 //SVC call to exit
	SVC 0         //Make the system call.
	
.data
// Allocate stack space
.balign 4
topOfStack: .space 4000
.balign 4
bottomOfStack: .word 0

// system messages
.balign 4
Intro_message: .asciz "-*-*-*-*-*Welcome to the Coffee Maker-*-*-*-*-*\nPress the red button to begin making coffee.\nPress the red button twice to turn machine off.\n"
.balign 4
menu: .asciz "Press the button for the size you want:\nYellow --> Small: 6 oz\nGreen --> Medium: 8 oz\nBlue --> Large: 10 oz\n"
.balign 4
good_to_continue: .asciz "Your coffee is being brewed now.\n"
.balign 4
Completion: .asciz "Coffee has been made.\n"
.balign 4
refillMessage: .asciz "Reserve empty. Needs water refil.\n"
.balign 4
shutdownMessage: .asciz "Coffee Maker is powering off now...\n"
.balign 4
No_water: .asciz "Error: Not enough water remaining in reserve, please choose a smaller size.\n"
.balign 4
ledProb: .asciz "There was a problem with board. \n"

// Define the values for the pins
.balign 4
pin2: .word 2
.balign 4
pin3: .word 3
.balign 4
pin4: .word 4
.balign 4
pin5: .word 5

//define values for buttons
.balign 4
BLUE:   .word 7 //Blue button
.balign 4
Green:  .word 0 //Green button
.balign 4
YELLOW: .word 6 //Yellow button
.balign 4
RED:    .word 1 //Red button
clear
//define values for delays
.balign 4
min_delay: .word 5000
.balign 4
small_delay: .word 6000
.balign 4
med_delay: .word 8000
.balign 4
large_delay: .word 10000
.balign 4
Delay_Buttons: .word 250

.global printf

//  The following are defined in wiringPi.h
.extern wiringPiSetup 
.extern delay
.extern digitalWrite
.extern pinMode
