// Scott Holley
// Arm Lab 5

/*-------------------------------------------------------------------------------*/
// for the wiring setup and delay preceedings
.extern wiringPiSetup 
.extern delay
.extern digitalWrite
.extern pinMode

// Setting the inputs and outputs as well as button pushes either up or down
.text
OUTPUT = 1
INPUT  = 0  

PUD_UP   = 2  
PUD_DOWN = 1 

LOW  = 0 
HIGH = 1

@ .balign 4

.global main
/*-------------------------------------------------------------------------------*/
Remove_Water:
sub r4, r4, r5
// Move the results of the operation into r1
mov r1, r4

// Print the results of the operation
mov pc, lr
/*-------------------------------------------------------------------------------*/
// number of times the led will blink
led_blinking:
mov r7, #0 
/*-------------------------------------------------------------------------------*/
led_loop:
add r7, r7, #1
ldr r0, =led_delay
ldr r0, [r0]
bl delay

// Turn the light off
ldr r0, =pin5
ldr r0, [r0]
mov r1, #0
bl  digitalWrite
// Delay the turning on of the light
ldr r0, =led_delay
ldr r0, [r0]
bl delay
// Turn the light on
ldr r0, =pin5
ldr r0, [r0]
mov r1, #1
// write and go to exit if red
bl  digitalWrite
cmp r7, #4
bge return
b led_loop
return:
b Exit
/*-------------------------------------------------------------------------------*/
main:

bl  wiringPiSetup
mov r1,#-1
cmp r0, r1
bne init  
ldr r0, =Problem
bl  printf
b   Exit  

/*-------------------------------------------------------------------------------*/

// Initialize the buttons and lights
init:
ldr r0, =Blue
ldr r0, [r0]
mov r1, #INPUT
bl  pinMode
// set the mode to input - GREEN
ldr r0, =Green
ldr r0, [r0]
mov r1, #INPUT
bl  pinMode
// set the mode to input- YELLOW
ldr r0, =Yellow
ldr r0, [r0]
mov r1, #INPUT
bl  pinMode

// set the mode to input - RED
ldr r0, =Red
ldr r0, [r0]
mov r1, #INPUT
bl  pinMode

ldr  r0, =Blue
ldr  r0, [r0]
mov  r1, #PUD_UP
BL   pullUpDnControl 

ldr  r0, =Green
ldr  r0, [r0]
mov  r1, #PUD_UP
BL   pullUpDnControl 

ldr  r0, =Yellow
ldr  r0, [r0]
mov  r1, #PUD_UP
BL   pullUpDnControl 

ldr  r0, =Red
ldr  r0, [r0]
mov  r1, #PUD_UP
BL   pullUpDnControl 

// Setting register debounce switching
mov r8,  #0xff 
mov r9,  #0xff
mov r10, #0xff
mov r11, #0xff 


/*-------------------------------------------------------------------------------*/
Buttons:
// Delay a few miliseconds to help debounce the switches. 
//
ldr  r0, =delayMs
ldr  r0, [r0]
BL   delay
// This initializes the lights
ldr r0, =pin2
ldr r0, [r0]
mov r1, #OUTPUT
bl  pinMode
// set the pin3 mode to output
ldr r0, =pin3
ldr r0, [r0]
mov r1, #OUTPUT
bl  pinMode
// set the pin4 mode to output
ldr r0, =pin4
ldr r0, [r0]
mov r1, #OUTPUT
bl  pinMode
// set the pin5 mode to output
ldr r0, =pin5
ldr r0, [r0]
mov r1, #OUTPUT
bl  pinMode
// Turn the red light off
ldr r0, =pin5
ldr r0, [r0]
mov r1, #0
bl  digitalWrite
// Total oz remaining in the machine
mov r4, #48
/*-------------------------------------------------------------------------------*/
// User Starts
Turn_On:
ldr r0, =strTurn_On
bl printf
/*-------------------------------------------------------------------------------*/
// Delay for debounce
Buttons_Turn_On:
ldr  r0, =delayMs
ldr  r0, [r0]
BL   delay
/*-------------------------------------------------------------------------------*/
// Preston implementation
RED_Turn_On:
ldr r0,  =Red
ldr r0,  [r0]
BL digitalRead 
cmp r0, #HIGH
moveq  r8, r0
beq Buttons_Turn_On
mov r8, r0
// Turn the light on
ldr r0, =pin5
ldr r0, [r0]
mov r1, #1
bl  digitalWrite
/*-------------------------------------------------------------------------------*/
Start:
// Give the user the prompt
ldr  r0, =delayMs
ldr  r0, [r0]
BL   delay
ldr r0, =prompt
bl printf
/*-------------------------------------------------------------------------------*/
getInput:
// delay for debounces
Buttons_input:
ldr  r0, =delayMs
ldr  r0, [r0]
BL   delay
/*-------------------------------------------------------------------------------*/
Blue_in:
ldr r0,  =Blue
ldr r0,  [r0]
BL digitalRead 
cmp r0, #HIGH   
// Button is HIGH read next button
moveq  r9, r0  
beq Blue_in
cmp r9, #LOW
beq size   
mov r9, r0  
/*-------------------------------------------------------------------------------*/

Blue_in:
ldr r0,  =Green
ldr r0,  [r0]
BL digitalRead  
cmp r0, #HIGH
moveq  r10, r0
beq Yellow_read   

cmp r10, #LOW
beq size

mov r10, r0  
/*-------------------------------------------------------------------------------*/
Yellow_read:
// same as the other reads
ldr r0,  =Yellow
ldr r0,  [r0]
BL digitalRead 
cmp r0, #HIGH
moveq  r11, r0
beq RED_input 

cmp r11, #LOW
beq size

mov r11, r0 // This is a new button press
/*-------------------------------------------------------------------------------*/
// These all work the same way that red does
RED_input:
ldr r0,  =Red
ldr r0,  [r0]
BL digitalRead 
cmp r0, #HIGH
moveq  r8, r0

cmp r8, #LOW
beq size
mov r8, r0 
/*-------------------------------------------------------------------------------*/
size:
cmp r11, #LOW
beq SmallCount

cmp r10, #LOW
beq MediumCount
cmp r9, #LOW
beq LargeCount
cmp r8, #LOW
beq Exit
b getInput
/*-------------------------------------------------------------------------------*/
// Chose small cup
SmallCount:
mov r5, #6
b water_check
/*-------------------------------------------------------------------------------*/
// Chose Medium Cup
MediumCount:
mov r5, #8
b water_check
/*-------------------------------------------------------------------------------*/
// Chose Large Cup
LargeCount:
mov r5, #10

water_check:
cmp r4, r5
bge pressB

cmp r4, #0
beq empty

// If there isn't enough water for any cup, display an error
cmp r4, #6
blt empty

// If there isn't enough water for a cup size, display an error
ldr r0, =too_large
bl printf
b size
/*-------------------------------------------------------------------------------*/

// User needs to push B
pressB:
mov r1, r4
@ ldr r0, =water_left
bl printf
bleq Remove_Water
mov r1, r4
ldr r0, =water_left
bl printf

cmp r9, #LOW
beq Blue_on
cmp r10, #LOW
beq Green_on
cmp r11, #LOW
beq Yellow_on
/*-------------------------------------------------------------------------------*/

Blue_on:
// Turn the light on
ldr r0, =pin2
ldr r0, [r0]
mov r1, #1
bl  digitalWrite
// Delay while the light is on
ldr r0, =largeDelay
ldr r0, [r0]
bl delay
b sizeLightsOff
/*-------------------------------------------------------------------------------*/

Green_on:
// Turn the light on
ldr r0, =pin3
ldr r0, [r0]
mov r1, #1
bl  digitalWrite
// Delay while the light is on
ldr r0, =mediumDelay
ldr r0, [r0]
bl delay
b sizeLightsOff
/*-------------------------------------------------------------------------------*/
Yellow_on:
// Turn the light on
ldr r0, =pin4
ldr r0, [r0]
mov r1, #1
bl  digitalWrite

// Delay while the light is on
ldr r0, =smallDelay
ldr r0, [r0]
bl delay
/*-------------------------------------------------------------------------------*/

// Turn off all the lights that are associated with cup sizes
sizeLightsOff:
// Turn the coffee lights off
ldr r0, =pin2

ldr r0, [r0]
mov r1, #0
bl  digitalWrite
ldr r0, =pin3
ldr r0, [r0]
mov r1, #0
bl  digitalWrite
ldr r0, =pin4
ldr r0, [r0]
mov r1, #0
bl  digitalWrite
/*-------------------------------------------------------------------------------*/
// tell user it works
success:
ldr r0, =strSuccess
bl printf
b getInput
/*-------------------------------------------------------------------------------*/
empty:
//tell user it's empty
ldr r0, =usr_empty
bl printf
bl led_blinking
b Exit
/*-------------------------------------------------------------------------------*/
/*
empty:
ldr r0, =usr_empty
bl printf
bl led_blinking
b Exit
*/
/*-------------------------------------------------------------------------------*/
// Program exits
Exit:
// Turn the lights off
ldr r0, =pin2
ldr r0, [r0]
mov r1, #0
bl  digitalWrite
// Turn the lights off
ldr r0, =pin3
ldr r0, [r0]
mov r1, #0
bl  digitalWrite
// Turn the lights off
ldr r0, =pin4
ldr r0, [r0]
mov r1, #0
bl  digitalWrite
// Turn the lights off
ldr r0, =pin5
ldr r0, [r0]
mov r1, #0
bl  digitalWrite
mov r7, #0x01
svc 0

/*-------------------------------------------------------------------------------*/
addrOfInput: .word input
addrOfNumRead: .word numRead
.data
// String that prompts the user to wake the machine up by pressing the red button
.balign 4
strTurn_On: .asciz "Press the red button in order to turn the machine on.\n"
// Welcome string
.balign 4
prompt: .asciz "\nWelcome to the Coffee Maker. Please push a button to select your cup size.\nYellow ---> Small: 6 oz\nGreen ---> Medium: 8 oz\nBlue ---> Large: 10 oz\nPressing the red button again will turn the machine off.\n"
// Water remaining message
.balign 4
water_left: .asciz "%d oz of water remaining in the machine.\n"
// Not nough water
.balign 4
too_large: .asciz "There is not enough water in the machine for this cup size. Please pick another.\n"
// Out of water
.balign 4
usr_empty: .asciz "The reservoir is empty. Please refill it before next use.\n"
// Coffee was successfully made
.balign 4
strSuccess: .asciz "\nBrewing complete. Enjoy your coffee.\nPress another button if you wish to brew another cup.\n"
// Ready to brew
.balign 4
strReady: .asciz "Ready to brew. Press B to begin.\n"
// Error message for when there isn't enough water for any cup sizes
.balign 4
usr_empty: .asciz "There is not enough water for any cup size. Please refill the machine's reservoir.\n"
// First input number
.balign 4
input: .asciz "%s"
// Error message
.balign 4
Problem: .asciz "Setup didn't work... Aborting...\n"
// The number the program read
.balign 4
numRead: .word 0
// Define the values for the pins and delays
.balign 4
pin2: .word 2 
pin3: .word 3
pin4: .word 4
pin5: .word 5
led_delay: .word 5000  // Set delay for five seconds. 
smallDelay: .word 6000  // Set delay for six seconds. 
mediumDelay: .word 8000  // Set delay for eight seconds. 
largeDelay: .word 10000  // Set delay for 10 seconds. 
//button definitions
.balign 4

Blue:   .word 7 //Blue button
Green:  .word 0 //Green button
Yellow: .word 6 //Yellow button
Red:.word 1 //Red button

delayMs: .word 250  // Delay time in Miliseconds.

.global scanf
.global printf

.end



