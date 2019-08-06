// Scott Holley
// 413 Lab 2
// as -o Scott.o Scott.s
// gcc -o Scott Scott.o
//./Scott 

.global main
/*-----------------------------------------------------------*/
main:
Begin:
        /*
        Give an introductory message to the user
        */

        ldr r0, =prompt
        bl printf

input:
        /*
        Take the user's two numbers, and then branch to another
        function to verify if they are valid, if they are valid, 
        then the program continues
        */

        ldr r0, =Num_input
        bl printf

        bl give_number
        mov r4, r1

        bl give_number
        mov r5, r1              
        bl valid_check          

/*-----------------------------------------------------------*/
choice:
        /*
        Get and store the user choice and compare to decide which operation
        to branch to. At the end is the check for a valid choice input.
        If the user does not input one of the four operation choices, then restart
        */
        ldr r0, =choose_op
        bl printf

        bl give_number         

        cmp r1, #1
        beq addition_start
        cmp r1, #2
        beq subtraction_start
        cmp r1, #3
        beq multiply_start
        cmp r1, #4
        beq divide_start
        b error_input              

/*-----------------------------------------------------------*/
quit:
        /*
        Exit given choice is not 1. r1 holds this choice 
        */
        ldr r0, =cont_prompt
        bl printf

        bl give_number         

        cmp r1, #1
        beq input

my_exit:
        mov r7, #0x01
        svc 0
 /*-----------------------------------------------------------*/
addition_start:
        /*
        Use the stack to push the operands, then branch to the add function
        Here, overflow conditions are also checked and appropriate outputs are loaded
        */
        push {r4}                       
        push {r5}                       
        bl do_add                          
        
        bvs overflow

        ldr r0, =Add_output
        bl printf

        ldr r0, =num_output
        mov r1, r8
        bl printf

        b quit

 /*-----------------------------------------------------------*/
subtraction_start:
        /*
        Push to the stack for the subtraction operation to take place
        Like in the others, check for the overflow condition and load appropriate
        messages to be printed
        */

        push {r4}
        push {r5}
        bl do_sub

        bvs overflow

        ldr r0, =Sub_output
        bl printf

        ldr r0, =num_output
        mov r1, r8
        bl printf

        b quit

 /*-----------------------------------------------------------*/
multiply_start:
        /*
        Push to the stack for the multiplication operation to take place
        Like in the others, check for the overflow condition and load appropriate
        messages to be printed
        */

        push {r4}
        push {r5}
        bl do_mul

        cmp r9, #0
        bne overflow

        ldr r0, =mul_output
        bl printf

        ldr r0, =num_output
        mov r1, r8
        bl printf

        b quit

 /*-----------------------------------------------------------*/
divide_start:
        /*
        Push to the stack for the division operation to take place
        Like in the others, check for the overflow condition and load appropriate
        messages to be printed
        */

        bl verify_div                       
        push {r4}
        push {r5}
        bl do_div                                  

        ldr r0, =div_out
        bl printf

        ldr r0, =num_output
        mov r1, r8
        bl printf

        ldr r0, =rem_out
        bl printf

        ldr r0, =num_output
        mov r1, r9
        bl printf

        b quit              

 /*-----------------------------------------------------------*/
error_input:
        /*
        Check to make sure the input is valid
        */
        ldr r0, =input_error
        bl printf
        b input
 /*-----------------------------------------------------------*/
give_number:
        /*
        Get the input from the scan and store it in r1
        */
        push {lr}
        ldr r0, =number_input_pattern                
        sub sp, sp, #4
        mov r1, sp
        bl scanf
        ldr r1, [sp, #0]
        add sp, sp, #4                         

        pop {lr}
        bx lr

 /*-----------------------------------------------------------*/
valid_check:
        /*
        Check for bad input based on in from user, branch accordingly
        based on said check
        */
        cmp r4, #0
        bmi error_input
        cmp r5, #0
        bmi error_input
        bx lr
 /*-----------------------------------------------------------*/
verify_div:
        /*
        Division by 0 check
        */
        cmp r5, #0
        beq zero_error
        bx lr
 /*-----------------------------------------------------------*/
zero_error:
        /*
        Division by 0 check and kick
        */
        ldr r0, =zero_input_error
        bl printf
        b input
 /*-----------------------------------------------------------*/
overflow:
        /*
        Check for overflow condition
        */
        ldr r0, =overflow_output
        bl printf
        b input
 /*-----------------------------------------------------------*/
do_add:
        /*
        Do the addition with flag checked
        */
        pop {r11}                       
        pop {r10}                       
        adds r8, r10, r11               
        bx lr   

 /*-----------------------------------------------------------*/
do_sub:
        /*
        Do the subtraction with flags checked
        */
        pop {r11}
        pop {r10}

        subs r8, r10, r11               
        bx lr

 /*-----------------------------------------------------------*/
do_mul:
        /*
        Do the multiplication with flags checked
        */
        pop {r11}
        pop {r10}
        
        umull r8, r9, r10, r11          
        bx lr

 /*-----------------------------------------------------------*/
do_div:
        /*
        Do the division and and branch to the divide_loop until remainder is 0
        */

        pop {r11}
        pop {r10}                       
        mov r6, r11
        mov r7, r10
        mov r8, #0
        b div_loop_check                  

/*-----------------------------------------------------------*/
division_loop:
        /*
        Run Loop on division function
        */
        add r8, r8, #1
        sub r7, r7, r6

/*-----------------------------------------------------------*/
div_loop_check:
        /*
        Loop Checker
        */
        cmp r7, r6
        bhs division_loop
        mov r9, r7

        bx lr

 /*-----------------------------------------------------------*/


.data
.balign 4
prompt: .asciz "This is the beginning of the Stack Calculator.\n"
.balign 4
Num_input: .asciz "Give me two positive integers:\n"
.balign 4
choose_op: .asciz "Please choose an operation:\n1. Add\n2. Subtract\n3. Multiply\n4. Divide\n"
.balign 4
input_error: .asciz "That input will not work.\n"
.balign 4
zero_input_error: .asciz "You can't divide by 0.\n"
.balign 4
Add_output: .asciz "Result of the addition:\n"
.balign 4
Sub_output: .asciz "Result of the subtraction:\n"
.balign 4
mul_output: .asciz "Result of the multiplication:\n"
.balign 4
div_out: .asciz "Quotient:\n"
.balign 4
rem_out: .asciz "Remainder:\n"
.balign 4
cont_prompt: .asciz "Choose:\n1. a new operation \nElse: Quit\n"
.balign 4
number_input_pattern: .asciz "%d"
.balign 4
num_output: .asciz "%d\n"
.balign 4
overflow_output: .asciz "Overflow Noticed.\n"

.global printf
.global scanf

@end code
