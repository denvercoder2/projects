// Scott Holley
// Rewritten Code to make it easier to read

//    as -o coffeeLight.o coffeeLight.s
//    gcc -o coffeeLight coffeeLight.o	-lwiringPi

// Have to use C compiler to link because of C library uses. 
// Set the output as high

OUTPUT = 1 // Used to set the selected GPIO pins to output only. 



.global main // Have to use main because of C library uses. 
/*-------------------------------------------------------------------*/
main:
@ Setup and read all the buttons. 
@ Set the buttons for pull-up and it is 0 when pressed. 
@    pullUpDnControl(buttonPin, PUD_UP)
@    digitalRead(buttonPin) == LOW button pressed
@
    ldr  r0, =buttonBlue
    ldr  r0, [r0]
    mov  r1, #PUD_UP
    BL   pullUpDnControl 

    ldr  r0, =buttonGreen
    ldr  r0, [r0]
    mov  r1, #PUD_UP
    BL   pullUpDnControl 

    ldr  r0, =buttonYellow
    ldr  r0, [r0]
    mov  r1, #PUD_UP
    BL   pullUpDnControl 

    ldr  r0, =buttonRed
    ldr  r0, [r0]
    mov  r1, #PUD_UP
    BL   pullUpDnControl 

@
@  Set the registers to debounce switches and handle buttons 
@  held down,.
@
    mov r8,  #0xff 
    mov r9,  #0xff
    mov r10, #0xff    
    mov r11, #0xff 


@ Start the loop to read all the buttons. 

ButtonLoop:

@ Delay a few miliseconds to help debounce the switches. 
@
    ldr  r0, =delayMs
    ldr  r0, [r0]
    BL   delay

ReadBLUE:
@ Read the value of the blue button. If it is HIGH (i.e., not
@ pressed) read the next button and set the previous reading
@ value to HIGH. 
@ Otherwise the current value is LOW (pressed). If it was LOW
@ that last time the button is still pressed down. Do not record
@ this as a new pressing.
@ If it was HIGH the last time and LOW now then record the 
@ button has been pressed.
@
    ldr    r0,  =buttonBlue
    ldr    r0,  [r0]
    BL     digitalRead 
    cmp    r0, #HIGH   @ Button is HIGH read next button
    moveq  r9, r0      @ Set last time read value to HIGH 
    beq    ReadGREEN

    @ The button value is LOW.
    @ If it was LOW the last time it is still down. 
    cmp    r9, #LOW    @ was the last time it was called also
                       @ down?
    beq    ReadGREEN   @ button is still down read next button
                       @ value. 
     
    mov    r9, r0  @ This is a new button press. 
    b      PedBLUE @ Branch to print the blue button was pressed. 

ReadGREEN:
@ See comments on BLUE button on how this code works. 
@
    ldr    r0,  =buttonGreen
    ldr    r0,  [r0]
    BL     digitalRead  
    cmp    r0, #HIGH
    moveq  r10, r0
    beq    ReadYELLOW   

    cmp    r10, #LOW
    beq    ReadYELLOW  

    mov    r10, r0
    b      PedGREEN 

ReadYELLOW:
@ See comments on BLUE button on how this code works. 
@
    ldr    r0,  =buttonYellow
    ldr    r0,  [r0]
    BL     digitalRead 
    cmp    r0, #HIGH
    moveq  r11, r0
    beq    ReadRED 
 
    cmp    r11, #LOW
    beq    ReadRED

    mov    r11, r0
    b      PedYELLOW 

ReadRED:
@ See comments on BLUE button on how this code works. 
@
    ldr    r0,  =buttonRed
    ldr    r0,  [r0]
    BL     digitalRead 
    cmp    r0, #HIGH
    moveq  r8, r0
    beq    ButtonLoop
 
    cmp    r8, #LOW
    beq    ButtonLoop
 
    mov    r8, r0
    b      PedRED

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Print out which button was pressed.
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

PedBLUE:
    LDR  r0, =PressedBLUE @ Put address of string in r0
    BL   printf           @ Make the call to printf
    B    ButtonLoop       @ Go read more buttons


PedGREEN:
    LDR  r0, =PressedGREEN @ Put address of string in r0
    BL   printf            @ Make the call to printf
    B    ButtonLoop        @ Go read more buttons

PedYELLOW:
    LDR  r0, =PressedYELLOW @ Put address of string in r0
    BL   printf             @ Make the call to printf
    B    ButtonLoop         @ Go read more buttons

PedRED:
    LDR  r0, =PressedRED  @ Put address of string in r0
    BL   printf           @ Make the call to printf
    B    ButtonLoop       @ Go read more buttons

done:

@ Use the C library to print the goodbye string. 
    LDR  r0, =string2 @ Put address of string in r0
    BL   printf       @ Make the call to printf

@ Force the exit of this program and return command to OS

mov r0, r8
    MOV  r7, #0X01
    SVC  0

.data
.balign 4

buttonBlue:   .word 7 @Blue button
buttonGreen:  .word 0 @Green button
buttonYellow: .word 6 @Yellow button
buttonRed:    .word 1 @Red button
preLoad:
//initialize the variables
//r4 - user cup size
//r5 - remaining water
//r6 - small cup count
//r7 - medium cup count
//r8 - large cup count

//load water resourveir in
ldr r5, =water
ldr r5, [r5]

ldr r6, =Small
ldr r6, [r6]
ldr r7, =Medium
ldr r7, [r7]
ldr r8, =Large
ldr r8, [r8]


//Welcome the user and ask for their cup size

// check the setup of the GPIO to make sure it is working right. 

// To use the wiringPiSetup function just call it. On return:

// r0 - contains the pass/fail code

bl      wiringPiSetup
mov     r1,#-1
cmp     r0, r1
bne     init  // Everything is OK so continue with code.
ldr     r0, =ErrMsg
bl      printf
b       Error  // There is a problem with the GPIO exit code.



/*
Part of Mr.Prestons code but modified a bit 
*/

/*-------------------------------------------------------------------*/

// Set the initializer for the pins


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



// Run the delay otherwise it blinks so fast you never see it!
// To use the delay function:
// r0 - must contains the number of miliseconds to delay.
       ldr     r0, =delayMs
       ldr     r0, [r0]
       bl      delay

/*-------------------------------------------------------------------*/
prompt:	
//welcome the user and prompt them to enter their cup size

 ldr r0, =pin5
 ldr r0, [r0]
 mov r1, #1
 bl digitalWrite
/*-------------------------------------------------------------------*/
ldr r0, =introduction
bl printf
ldr r0, =cupSize
bl printf
/*-------------------------------------------------------------------*/
get_input:	
													
// Set up r0 with the address of input pattern
   ldr r0, =scan 		// Setup to read in one number.
   sub sp, sp, #4            	// Update stack pointer to new loc.
   mov r1, sp               	// Put address into r1 for read.
   bl scanf                 	// scan the keyboard.
   ldrb r1, [sp, #0]         	// The character is on the stack.
   add sp, sp, #4           	// Reset the stack. 
   mov r4, r1
   b Cup_size_assign

/*-------------------------------------------------------------------*/
//checking the input is valid
Cup_size_assign: 
cmp r4, #0
beq off
cmp r4, #-9
beq secretCode
cmp r4, #116
beq off
cmp r4, #1
beq small
cmp r4, #2
beq medium
cmp r4, #3
beq large
/*-------------------------------------------------------------------*/
end:
   ldr r0, =endMachine
   bl printf
   ldr     r0, =pin2
   ldr     r0, [r0]
   mov     r1, #0
   
/*-------------------------------------------------------------------*/
small: 
mov r9, #1
mov r4, #6
ldr r0, =smallMessage
bl printf
add r6, #1
b checkOne
/*-------------------------------------------------------------------*/
medium: 
mov r10, #1
mov r4, #8
ldr r0, =mediumMessage
bl printf
add r7, #1
b checkOne
/*-------------------------------------------------------------------*/
large: 
mov r11, #1
mov r4, #10
ldr r0, =largeMessage
bl printf
add r8, #1
b checkOne
/*-------------------------------------------------------------------*/
checkOne:
	cmp r5, r4			//compare the user input with the value of the water resourveir
	blt invalidInput			
/*-------------------------------------------------------------------*/
reduceRemaining:			//subtract the input from the water resourveir to keep track of how much water is left
sub r5, r5, r4				
/*-------------------------------------------------------------------*/
startBrewing:
ldr r0, =readyToBrew
bl printf
/*-------------------------------------------------------------------*/
userIsReady:													
   ldr r0, =scan 	
   sub sp, sp, #4       
   mov r1, sp           
   bl scanf             
   ldrb r1, [sp, #0]    
   add sp, sp, #4       
/*-------------------------------------------------------------------*/
checks: 
   cmp r1, #-9
   beq secretCode
   cmp r1, #116
   beq off
   cmp r1, #1
   bne BadInput
   cmp r4, #6
   beq SmallCupBrew
   cmp r4, #8
   beq MediumCupBrew
   cmp r4, #10
   beq LargeCupBrew
 

/*-------------------------------------------------------------------*/
SmallCupBrew:
// Write a logic one to turn pin4 to on.
        ldr     r0, =pin4
        ldr     r0, [r0]
        mov     r1, #1
        bl      digitalWrite
	ldr     r0, =sixSeconds
        ldr     r0, [r0]
        bl      delay
	// Write a logic 0 to turn pin4 off.
        ldr     r0, =pin4
        ldr     r0, [r0]
        mov     r1, #0
        bl      digitalWrite

	b success
/*-------------------------------------------------------------------*/
MediumCupBrew: 
// Write a logic one to turn pin3 to on.
        ldr     r0, =pin3
        ldr     r0, [r0]
        mov     r1, #1
        bl      digitalWrite
	ldr     r0, =eightSeconds
        ldr     r0, [r0]
        bl      delay
	// Write a logic 0 to turn pin3 off.
        ldr     r0, =pin3
        ldr     r0, [r0]
        mov     r1, #0
        bl      digitalWrite
	b success
/*-------------------------------------------------------------------*/
LargeCupBrew: 
// Write a logic one to turn pin2 to on.
        ldr     r0, =pin2
        ldr     r0, [r0]
        mov     r1, #1
        bl      digitalWrite
	ldr     r0, =tenSeconds
        ldr     r0, [r0]
        bl      delay
// Write a logic 0 to turn pin2 off.
        ldr     r0, =pin2
        ldr     r0, [r0]
        mov     r1, #0
        bl      digitalWrite
	b success
/*-------------------------------------------------------------------*/
success: 
	ldr r0, =successMessage
	bl printf
/*-------------------------------------------------------------------*/
checkWaterAgain: 
cmp r5, #6
blt refillMessage
b prompt

/*-------------------------------------------------------------------*/
refillMessage: 
	ldr r0, =refillMessagePrompt
	bl printf
	
ldr r9, =i
	ldr r9, [r9]
	b forLoop
/*-------------------------------------------------------------------*/
forLoop:
        cmp     r9, #3
        beq 	off
 	ldr     r0, =pin5
        ldr     r0, [r0]
        mov     r1, #0
        bl      digitalWrite

	ldr     r0, =twoSeconds
        ldr     r0, [r0]
        bl      delay
// Write a logic 0 to turn pin5 on.
        ldr     r0, =pin5
        ldr     r0, [r0]
        mov     r1, #1
        bl      digitalWrite

 	ldr     r0, =twoSeconds
        ldr     r0, [r0]
        bl      delay

	add r9, #1
	b forLoop
/*-------------------------------------------------------------------*/
invalidInput: 		//prints invalid input if the input is not between 0-200 and divisible by 20
ldr r0, =invalid
bl printf
b prompt

/*-------------------------------------------------------------------*/
BadInput: 
	ldr r0, =invalidButtonPressed
	bl printf
	b userIsReady

/*-------------------------------------------------------------------*/
//if the secret code, -9 is entered, data is displayed
secretCode:

 ldr r0, =secretMessage
 bl printf

 
 ldr r0, =cupStats
 mov r1, r6
 mov r2, r7
 mov r3, r8
 bl printf
 
 ldr r0, =WaterResult
 mov r1, r5
 bl printf

b prompt
 
/*-------------------------------------------------------------------*/

/*-------------------------------------------------------------------*/
off: 

  ldr r0, =pin5
  ldr     r0, [r0]
  mov     r1, #0
  bl      digitalWrite

ldr r0, =powerOffOutput
bl printf 

/*-------------------------------------------------------------------*/

// Force the exit of this program and return command to OS

Error:  // Label only need if there is an error on board init.
    

//myexit

myexit:
   mov r7, #0x01 //SVC call to exit
   svc 0         //Make the system call. 

/*-------------------------------------------------------------------*/   

.data
.balign 4

// Define the values for the pins
pin2: .word 2 

pin3: .word 3

pin4: .word 4

pin5: .word 5


i:    .word 0    // counter for for loop. 


delayMs: .word 250  // Set delay for one second. 

ErrMsg: .asciz "Setup didn't work... Aborting...\n"
twoSeconds: .word 2000		// Turn the light on for 4 seconds
sixSeconds: .word 6000		// Turn the light on for 6 seconds
eightSeconds: .word 8000	// Turn the light on for 8 seconds
tenSeconds: .word 10000		// Turn the light on for 10 seconds

introduction: .ascii "Welcome to the Coffee Maker\nInsert K-cup and press 1 to begin making coffee\nPress 0 to turn off the machine\n\0"  

cupSize: .ascii "Enter 1 for a small cup of coffee (6 oz)\nEnter 2 for a medium cup of coffee (8 oz)\nEnter 3 for a large cup of coffee (10 oz)\n\0"

WaterResult: .ascii "Water left in the keurig is:\n ----------------------\n %d ounces \n\0"

readyToBrew: .ascii "Ready to brew.\nInsert a cup in the tray and press 1 to begin brewing\n\0"

invalid: .ascii "Please select a smaller cup size\n\n\0"

secretMessage: .ascii "This is the secret message\n\0"

cupStats: .ascii "Cups Distributed\n -----------------\n 6 ounces: %d\n 8 ounces: %d\n 10 ounces %d\n\0"

smallMessage: .ascii "User entered a small cup size\n\0"

mediumMessage: .ascii "User entered a medium cup size\n\0"

largeMessage: .ascii "User entered a large cup size\n\0"

successMessage: .ascii "Your cup of coffee is ready!\n\0"

invalidButtonPressed: .ascii "Invalid Button was pressed. Press 1 to begin brewing.\n\0" 

refillMessagePrompt: .ascii "The water is below 6 ounces! Please refill\n\0"

powerOffOutput: .ascii "Powering off...\n\0"

endMachine: .ascii "Turning off Machine \n"

scan: .asciz "%d"
water: .word 48
Small: .word 0
Medium: .word 0
Large: .word 0



// Let the assembler know these are the C library functions. 

.global printf

.global scanf


//  The following are defined in wiringPi.h
.extern wiringPiSetup 
.extern delay
.extern digitalWrite
.extern pinMode

//end of code. 
