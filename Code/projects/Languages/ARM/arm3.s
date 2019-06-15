// Coffee Program
// Scott Holley
// CS413
/*---------------------------------------------------------------------------------------------*/
// Used to set the selected GPIO pins to output only.
OUTPUT = 1 
/*
Beginning of Program
*/
.global main

/*---------------------------------------------------------------------------------------------*/
/*
Wiring setup
*/
bl      wiringPiSetup
mov     r1,#-1
cmp     r0, r1
bne     init  .
ldr     r0, =ErrMsg
bl      printf
b       errorout  // There is a problem with the GPIO exit code.

/*---------------------------------------------------------------------------------------------*/

// Set four of the GPIO pins to output



// set the pin2 mode to output

init:

ldr     r0, =pin2
ldr     r0, [r0]
mov     r1, #OUTPUT
bl      pinMode
// set the pin3 mode to output
ldr     r0, =pin3
ldr     r0, [r0]
mov     r1, #OUTPUT
bl      pinMode
// set the pin4 mode to output
ldr     r0, =pin4
ldr     r0, [r0]
mov     r1, #OUTPUT
bl      pinMode
// set the pin5 mode to output
ldr     r0, =pin5
ldr     r0, [r0]
mov     r1, #OUTPUT
bl      pinMode

/*---------------------------------------------------------------------------------------------*/
light_one_on:
ldr     r0, =pin2
ldr     r0, [r0]
mov     r1, #1
bl      digitalWrite
/*---------------------------------------------------------------------------------------------*/
light_two_on:
ldr     r0, =pin3
ldr     r0, [r0]
mov     r1, #1
bl      digitalWrite
/*---------------------------------------------------------------------------------------------*/
light_three_on:

ldr     r0, =pin4
ldr     r0, [r0]
mov     r1, #1
bl      digitalWrite
/*---------------------------------------------------------------------------------------------*/

light_four_on:
ldr     r0, =pin5
ldr     r0, [r0]
mov     r1, #1
bl      digitalWrite
/*---------------------------------------------------------------------------------------------*/

delay:
ldr     r0, =delayMs
ldr     r0, [r0]
bl      delay
/*---------------------------------------------------------------------------------------------*/
/*
Start the resevoir and corresponding registers at start points (total number of cups)
*/
main:

mov r5, #48  
mov r7, #0 
mov r8, #0 
mov r9, #0 

/*---------------------------------------------------------------------------------------------*/
/*
Initiate a welcome prompt and prompt the user to begin brewing
Prompt the user to turn the machine off as well as ask the user to enter 
a command in order to begin the brewing process
Based on the input from the user, the program will branch to the appropriate function
Also, makes a compare to see if user has entered secret code
*/
welcome_prompt:
ldr r0,  =strWelcome  
bl printf 
ldr r0, =strPrompt  
bl printf
ldr r0, = strOffPrompt 
bl printf

ldr r0, =strWelcomeInput 
sub sp, sp, #4
mov r1, sp
bl scanf 
ldr r1, [sp, #0]
Add sp, sp, #4 

cmp r1,#'B' 
beq cup_size_prompt 
cmp r1, #'T' 
beq off_output 
cmp r1, #'O' 
beq hidden_code


/*---------------------------------------------------------------------------------------------*/
/*
Message to the user that the program is exiting
*/
off_output:

ldr r0, =strOffOutput  
bl printf
b exit
/*---------------------------------------------------------------------------------------------*/
/*
Prints the different cup sizes that can be selected and stores the user selected
choice. Depending on the selection, the program will then branch to the correct function to
handle the given choice, as well as checking if the user has entered the secret code
*/
cup_size_prompt:

ldr r0, =strCupPrompt 
bl printf
ldr r0, =strCupInput

sub sp, sp, #4
mov r1, sp
bl scanf 
ldr r1, [sp, #0]
add sp, sp, #4

cmp r1,#1
beq small_coffee
cmp r1, #2  
beq medium_coffee
cmp r1, #3 
beq large_coffee
cmp r1, #'O' 
beq hidden_code
b exit

/*---------------------------------------------------------------------------------------------*/
/*
Checks to see if there is enough water in the resevoir to brew the coffee
If there isn't, then display the message that it needs to be refilled
If there is. then continue to brew the coffee
*/
small_coffee:

mov r6, #6
cmp r5, r6 
bge small_coffee_brew 
ldr r0, =strNoWater 
bl printf
b cup_size_prompt
b exit

/*---------------------------------------------------------------------------------------------*/ 
/*
Subtract the water from the resevoir and add to the count of small cups being brewed
After, ask the user to enter the next selection, while also checking if the user has entered the secret code
*/
small_coffee_brew:

sub r5, r5, #6 
add r7, r7, #1  
mov r1, r5
ldr r0, =strTest
bl printf
ldr r0, =strReadyToBrew
bl printf
ldr r0, =strBrewInput
 
sub sp, sp, #4
mov r1, sp
bl scanf 
ldr r1, [sp, #0]
add sp, sp, #4

cmp r1, #'B'
beq success_brew
cmp r1, #'O'  
beq hidden_code
b exit

/*---------------------------------------------------------------------------------------------*/
/*
Begin the medium cup brewing and check that there is enough water to start. 
If not, then display not enough water message
If there is enough water, then continue with the brew
*/
medium_coffee:

mov r6, #8
cmp r5, r6
bge medium_coffee_brew
ldr r0, =strNoWater
bl printf
b cup_size_prompt
b exit
 
/*---------------------------------------------------------------------------------------------*/
/*
Subtract the water from the resevoir and add to the count of medium cups being brewed
After, ask the user to enter the next selection, while also checking if the user has entered the secret code
*/
medium_coffee_brew:

sub r5, r5, #8
add r8, r8, #1
mov r1, r5
ldr r0, =strTest
bl printf
ldr r0, =strReadyToBrew
bl printf
ldr r0, =strBrewInput

sub sp, sp, #4
mov r1, sp
bl scanf 
ldr r1, [sp, #0]
add sp, sp, #4

cmp r1, #'B'
beq success_brew
cmp r1, #'O'
beq hidden_code
b exit

/*---------------------------------------------------------------------------------------------*/
/*
Begin the large cup brewing and check that there is enough water to start. 
If not, then display not enough water message
If there is enough water, then continue with the brew
*/
large_coffee:

mov r6, #10
cmp r5, r6
bge large_coffee_brew
ldr r0, =strNoWater
bl printf
b cup_size_prompt
b exit

/*---------------------------------------------------------------------------------------------*/
/*
Subtract the water from the resevoir and add to the count of large cups being brewed
After, ask the user to enter the next selection, while also checking if the user has entered the secret code
*/
large_coffee_brew:

sub r5, r5, #10
add r9, r9, #1
mov r1, r5
ldr r0, =strTest
bl printf

ldr r0, =strReadyToBrew
bl printf
ldr r0, =strBrewInput

sub sp, sp, #4
mov r1, sp
bl scanf 
ldr r1, [sp, #0]
add sp, sp, #4

cmp r1, #'B'
beq success_brew
cmp r1, #'O'
beq hidden_code
b exit

/*---------------------------------------------------------------------------------------------*/
/*
Given that the coffee did brew, show the success message and compare the water left to the smallest
possible cup size allotted. If it is less, then display the refill message
*/
success_brew:

ldr r0, =strSuccessMessage
bl printf
mov r1, r5
cmp r5, #6
ble refill_message 
b welcome_prompt
refill_message:
ldr r0, =strRefillMessage
bl printf 
/*---------------------------------------------------------------------------------------------*/
/*
Begin exit to the program
*/
exit:
mov r7, #0x01
svc 0

/*---------------------------------------------------------------------------------------------*/
/*
Implement the hidden code so that the user, at any given point,
can enter the code and see the remaining water left and the cup count
for all cups sizes selected throughout the program
*/
hidden_code:
mov r1, r5
ldr r0, =strReservoirCount
bl printf

mov r1, r7
ldr r0, =strSmallCupCount 
bl printf 
mov r1, r8
ldr r0, =strMediumCupCount 
bl printf 
mov r1, r9
ldr r0, =strLargeCupCount 
bl printf 
b welcome_prompt

/*---------------------------------------------------------------------------------------------*/
.data
/*
Begin defining the output strings
*/
.balign 4
strWelcome:.asciz "Welcome to the Coffee Maker.\n"
.balign 4
strPrompt:.asciz "Insert K-Cup and press B to begin making coffee.\n"
.balign 4
strWelcomeInput:.asciz "%s"
.balign 4
strWelcomeOutput:.asciz "Brewing coffee %c.\n"
.balign 4
strOffPrompt:.asciz "Press T to turn off the machine\n"
.balign 4
strOffInput:.asciz "%s"
.balign 4
strOffOutput:.asciz "Exiting program %c.\n"
.balign 4
strCupPrompt:.asciz "Choose a cup size:\n1. Small (6oz)\n2. Medium (8oz)\n3. Large (10oz)\n"
.balign 4
strTest:.asciz "There is %d oz of water left. \n"
.balign 4
strNoWater:.asciz "Not enough water. Select a smaller cup size.\n"
@.balign 4
strReadyToBrew:.asciz "Coffee is brewing, press B to continue to another selection\n"
.balign 4
strCupInput:.asciz "%d"
.balign 4
strSuccessMessage:.asciz "Coffee has finished brewing, back to the start \n\n"
.balign 4
strBrewInput:.asciz "%s"
.balign 4
strRefillMessage:.asciz "Coffee Maker needs to be refilled. \n Turning Off Machine. \n"
.balign 4 
strReservoirCount:.asciz "There are %d oz of water remaining in the reservoir. \n"
.balign 4
strCupCount:.asciz "You have made %d cups of coffee\n"
.balign 4
strSmallCupCount:.asciz "You have made %d small cups of coffee\n"
.balign 4
strMediumCupCount:.asciz "You have made %d medium cups of coffee\n"
.balign 4
strLargeCupCount:.asciz "You have made %d large cups of coffee\n"
// set delay for one second
delayMs: .word 1000  . 


pin2: .word 2 
pin3: .word 3
pin4: .word 4
pin5: .word 5


.global printf
.global scanf


.extern wiringPiSetup 
.extern delay
.extern digitalWrite
.extern pinMode

// end

