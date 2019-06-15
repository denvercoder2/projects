// Scott Holley
// CS413 Lab 5
// Button Lab
// Purpose: Simulate a K-Cup machine, using leds to display when processes are running and buttons to operate

.global main
/*-----------------------------------------------------------------------------*/
// from prestons program
.equ PUD_UP, 2
.equ low, 0
.equ high, 1
/*-----------------------------------------------------------------------------*/

main:
/*
set up led access
check if an error was encountered
and exit if one is present
*/
BL wiringPiSetup
CMP r0, #-1 
BEQ errMenu 

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

//set up blue 
LDR r0, =BlueButton
LDR r0, [r0]
MOV r1, #0 //0 is the code for input
BL pinMode

//set up green
LDR r0, =GreenButton
LDR r0, [r0]
MOV r1, #0
BL pinMode

//set up yellow 
LDR r0, =YellowButton
LDR r0, [r0]
MOV r1, #0
BL pinMode

//set up red 
LDR r0, =RedButton
LDR r0, [r0]
MOV r1, #0
BL pinMode

//set read method on buttons
LDR r0, =BlueButton
LDR r0, [r0]
MOV r1, #PUD_UP
BL pullUpDnControl

LDR r0, =GreenButton
LDR r0, [r0]
MOV r1, #PUD_UP
BL pullUpDnControl

LDR r0, =YellowButton
LDR r0, [r0]
MOV r1, #PUD_UP
BL pullUpDnControl

LDR r0, =RedButton
LDR r0, [r0]
MOV r1, #PUD_UP
BL pullUpDnControl

//set up registers to debounce buttons and prevent firing on hold
MOV r5, #0xff
MOV r6, #0xff
MOV r7, #0xff
MOV r8, #0xff

//set up stack and frame pointers
LDR sp, =boss
MOV fp, sp
STR fp, [sp]

//set up starting water resevoir, store it in r0
MOV r0, #beginning_water
//r1 will hold number of small cups brewed
MOV r1, #0
//r2 will hold number of medium cups brewed
MOV r2, #0
//r3 will hold number of large cups brewed
MOV r3, #0

//store values so they stay untouched during all the prints
STMFD sp!, {r0, r1, r2, r3}
/*-----------------------------------------------------------------------------*/
main_menu:
//print out main menu
LDR r0, =Intro
BL printf

//delay to debounce the buttons
Start:
LDR r0, =button_dl
LDR r0, [r0]
BL delay

//wait for user to press red button to begin
initialred_read:
LDR r0, =RedButton
LDR r0, [r0]
BL digitalRead

//see if button is being pressed
CMP r0, #high
MOVEQ r5, r0 
BEQ Start

/*
See if the button is low, and branch to start if so
*/
CMP r5, #low
BEQ Start

/*
New button press, turn on red led , #1 tells the led to turn on.
light will remain on until the program exits
*/
MOV r5, r0
LDR r0, =pin5
LDR r0, [r0]
MOV r1, #1 
BL digitalWrite
/*-----------------------------------------------------------------------------*/
Choice:
//print out choices for user
LDR r0, =menu
BL printf
/*-----------------------------------------------------------------------------*/
// Delay to debounce buttons
button_loop:
LDR r0, =button_dl
LDR r0, [r0]
BL delay
/*-----------------------------------------------------------------------------*/
//check the buttons to see which is pressed
readBlue:
LDR r0, =BlueButton
LDR r0, [r0]
BL digitalRead

//check for button being pressed
CMP r0, #high
MOVEQ r6, r0 
BEQ readGreen

//button was pressed, see if being held
CMP r6, #low
BEQ readGreen

//new button press, user wants a large coffee
MOV r6, r0
B LargeBrew
/*-----------------------------------------------------------------------------*/
readGreen:
LDR r0, =GreenButton
LDR r0, [r0]
BL digitalRead

//see if button is being pressed
CMP r0, #high
MOVEQ r7, r0 
BEQ yellow_read

//button was pressed, see if being held
CMP r7, #low
BEQ yellow_read

//new button press, user wants a medium coffee
MOV r7, r0
B MediumBrew
/*-----------------------------------------------------------------------------*/
yellow_read:
LDR r0, =YellowButton
LDR r0, [r0]
BL digitalRead

//see if button is being pressed
CMP r0, #high
MOVEQ r8, r0 
BEQ red_read

//button was pressed, see if being held
CMP r8, #low
BEQ red_read

//new button press, user wants a small coffee
MOV r8, r0
B SmallBrew
/*-----------------------------------------------------------------------------*/
red_read:
LDR r0, =RedButton
LDR r0, [r0]
BL digitalRead

//see if button is being pressed
CMP r0, #high
MOVEQ r5, r0 
BEQ button_loop

//button was pressed, see if being held
CMP r5, #low
BEQ button_loop

//new button press, user wants to exit
MOV r5, r0
B exitMenu
/*-----------------------------------------------------------------------------*/
// print good to go message considering everything is okay
SmallBrew:
LDR r0, =good_to_go
BL printf

// load stack
LDMFD sp!, {r0, r1, r2, r3}
SUB r0, r0, #small 
ADD r1, r1, #1
STMFD sp!, {r0, r1, r2, r3}

//pin4
LDR r0, =pin4
LDR r0, [r0]
MOV r1, #1
BL digitalWrite

//delay for 6 seconds for small
LDR r0, =SmallDelay
LDR r0, [r0]
BL delay

//turn the led off
LDR r0, =pin4
LDR r0, [r0]
MOV r1, #0 
BL digitalWrite

//check if enough water is still there and manipulate the stack
LDMFD sp!, {r0} 
CMP r0, #small
BLT No_H2O 
STMFD sp!, {r0} 

LDR r0, =successMessage
BL printf
B secretCode



/*-----------------------------------------------------------------------------*/
secretCode:

ldr r0, =cupStats
mov r1, r6
mov r2, r7
mov r3, r8
bl printf

ldr r0, =WaterResult
mov r1, r5
bl printf

b Choice
/*-----------------------------------------------------------------------------*/
MediumBrew:
//check if there is enough remaining water
LDMFD sp!, {r0, r1, r2, r3}
CMP r0, #medium
STMFD sp!, {r0, r1, r2, r3}
BLT low_wat

LDR r0, =good_to_go
BL printf

/*
Take the water from reserve and manipulate the stack
*/
LDMFD sp!, {r0, r1, r2, r3}
SUB r0, r0, #medium 
ADD r2, r2, #1
STMFD sp!, {r0, r1, r2, r3}

// turn on green led
LDR r0, =pin3
LDR r0, [r0]
MOV r1, #1 
BL digitalWrite

//delay for 8 seconds
LDR r0, =MediumDelay
LDR r0, [r0]
BL delay

//turn the led off
LDR r0, =pin3
LDR r0, [r0]
MOV r1, #0 
BL digitalWrite

/*
Check if there is enough water and manipulate stack if 
the process can be carried out, also show the success message
*/
LDMFD sp!, {r0} 
CMP r0, #small
BLT No_H2O 
STMFD sp!, {r0} 

LDR r0, =successMessage
BL printf
B secretCode
/*-----------------------------------------------------------------------------*/
LargeBrew:
//check if there is enough remaining water
LDMFD sp!, {r0, r1, r2, r3}
CMP r0, #large
STMFD sp!, {r0, r1, r2, r3}
BLT low_wat

LDR r0, =good_to_go
BL printf

/*
Compare and see if there is enough water, move on stack
*/
LDMFD sp!, {r0, r1, r2, r3}
SUB r0, r0, #large 
ADD r3, r3, #1


STMFD sp!, {r0, r1, r2, r3}

//turn on the blue led on pin2 for 6 seconds
LDR r0, =pin2
LDR r0, [r0]
MOV r1, #1 //1 tells the led to turn on
BL digitalWrite

//delay for 10 seconds
LDR r0, =LargeDelay
LDR r0, [r0]
BL delay

//turn the led off
LDR r0, =pin2
LDR r0, [r0]
MOV r1, #0 
BL digitalWrite

LDMFD sp!, {r0} 
CMP r0, #small
BLT No_H2O 
STMFD sp!, {r0} 

LDR r0, =successMessage
BL printf
B secretCode
/*-----------------------------------------------------------------------------*/
low_wat:
LDR r0, =outOfWaterError
BL printf
B Choice
/*-----------------------------------------------------------------------------*/
No_H2O:
LDR r0, =refillMessage
BL printf

//set up to blink the led 3 times for turning off
MOV r4, #0
/*-----------------------------------------------------------------------------*/
LED_pulse:
//led started on, turn it off
LDR r0, =pin5
LDR r0, [r0]
MOV r1, #0 
BL digitalWrite

//wait 5 seconds
LDR r0, =off_delay
LDR r0, [r0]
BL delay

//turn led back on
LDR r0, =pin5
LDR r0, [r0]
MOV r1, #1 //1 turns led on
BL digitalWrite

//wait 5 seconds
LDR r0, =off_delay
LDR r0, [r0]
BL delay

ADD r4, r4, #1
CMP r4, #3
BNE LED_pulse 
/*-----------------------------------------------------------------------------*/
exitMenu:
//turn off red led at pin5
LDR r0, =pin5
LDR r0, [r0]
MOV r1, #0 
BL digitalWrite

LDR r0, =power_down
BL printf
B exit
/*-----------------------------------------------------------------------------*/
errMenu:
LDR r0, =err
BL printf
/*-----------------------------------------------------------------------------*/
exit:
MOV r7, #0x01 //SVC call to exit
SVC 0         //Make the system call.

.data

.balign 4
topOfStack: .space 4000
.balign 4
boss: .word 0

/*

*/
.balign 4
Intro: .asciz "Welcome to the Coffee Maker\nPress the red button to begin making coffee.\nPress the red button twice to turn machine off.\n"

.balign 4
menu: .asciz "Press the button that matches the size you want:\nYellow: Small--> 6 oz.\nGreen: Medium--> 8 oz\nBlue: Large-->10 oz\n"

.balign 4
good_to_go: .asciz "Your coffee is being brewed now.\n"

.balign 4
successMessage: .asciz "Coffee is done.\n\n"

.balign 4
refillMessage: .asciz "Resere is empty. Please refill to continue.\n"

.balign 4
power_down: .asciz "Coffee Maker is powering off now...\n"

.balign 4
outOfWaterError: .asciz "Error: Not enough water remaining in reserve, please choose a smaller size.\n"

.balign 4
err: .asciz "There was a problem with board. \n"

/*
.balign 4
WaterResult: .asciz "Water left in the keurig is:\n ----------------------\n %d ounces \n\0"

.balign 4
cupStats: .asciz "Cups Distributed\n -----------------\n 6 ounces: %d\n 8 ounces: %d\n 10 ounces %d\n\0"
*/


/*
secretCode:

 ldr r0, =cupStats
 mov r1, r6
 mov r2, r7
 mov r3, r8
 bl printf
 
 ldr r0, =WaterResult
 mov r1, r5
 bl printf

b prompt
*/

/*
Define the pin values
*/
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
BlueButton:   .word 7 //Blue button
.balign 4
GreenButton:  .word 0 //Green button
.balign 4
YellowButton: .word 6 //Yellow button
.balign 4
RedButton:    .word 1 //Red button

//define values for delays, 1000 being 1 sec since the ms conversion
.balign 4
off_delay: .word 5000
.balign 4
SmallDelay: .word 6000
.balign 4
MediumDelay: .word 8000
.balign 4
LargeDelay: .word 10000
.balign 4
button_dl: .word 250

/*
Makes it easier when removing water from reserve
this is only assigning values instead of having to define it 
each time
*/
.equ small, 6
.equ medium, 8
.equ large, 10
.equ beginning_water, 48


.global printf

//  The following are defined in wiringPi.h
.extern wiringPiSetup 
.extern delay
.extern digitalWrite
.extern pinMode

.end 


