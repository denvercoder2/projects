// Filename: Lab2.s
// Scott Holley
// CS413-01 Spring 2019


// as -o Lab2.o Lab2.s
// gcc -o Lab2 Lab2.o
// ./Lab2 

.global main

main:
Welcome:
        /*
        Give an introductory message to the user
        */

        ldr r0, =Welcome_Message
        bl printf

usr_in:
        /*
        Take the user's two numbers, and then branch to another
        function to verify if they are valid, if they are valid, 
        then the program continues
        */
        ldr r0, =get_two_ints
        bl printf

        bl give_num
        mov r4, r1

        bl give_num
        mov r5, r1              

        bl verifyinput          


/*------------------------------------------------------------*/
usr_choice:
        /*
        Get and store the user choice and compare to decide which operation
        to branch to. At the end is the check for a valid choice input.
        If the user does not input one of the four operation choices, then restart
        */

        ldr r0, =user_in_prompt
        bl printf

        bl give_num         

        cmp r1, #1
        beq addition
        cmp r1, #2
        beq subtraction
        cmp r1, #3
        beq multiplication
        cmp r1, #4
        beq division
        b check_bad_input       


/*------------------------------------------------------------*/
program_exit:
        /*
        Exit given choice is not 1. r1 holds this choice 
        */

        ldr r0, =usr_cont
        bl printf

        bl give_num         

        cmp r1, #1
        beq input

myexit:
        mov r7, #0x01
        svc 0

/*------------------------------------------------------------*/
addition:
        /*
        Use the stack to push the operands, then branch to the add function
        Here, overflow conditions are also checked and appropriate outputs are loaded
        */

        push {r4}                       @push operand 1
        push {r5}                       @push operand 2
        bl add                          @r8 = output
        
        bvs overflow

        ldr r0, =addition_out
        bl printf

        ldr r0, =out_num
        mov r1, r8
        bl printf

        b program_exit


/*------------------------------------------------------------*/
subtraction:
        /*
        Push to the stack for the subtraction operation to take place
        Like in the others, check for the overflow condition and load appropriate
        messages to be printed
        */

        push {r4}
        push {r5}
        bl sub

        bvs overflow

        ldr r0, =sub_out
        bl printf

        ldr r0, =out_num
        mov r1, r8
        bl printf

        b program_exit


/*------------------------------------------------------------*/
multiplication:
        /*
        Push to the stack for the multiplication operation to take place
        Like in the others, check for the overflow condition and load appropriate
        messages to be printed
        */

        push {r4}
        push {r5}
        bl mul

        cmp r9, #0
        bne overflow

        ldr r0, =multiplication_out
        bl printf

        ldr r0, =out_num
        mov r1, r8
        bl printf

        b program_exit


/*------------------------------------------------------------*/
division:
        /*
        Push to the stack for the division operation to take place
        Like in the others, check for the overflow condition and load appropriate
        messages to be printed
        */

        bl div_check                       

        push {r4}
        push {r5}
        bl div                                  

        ldr r0, =div_return
        bl printf

        ldr r0, =out_num
        mov r1, r8
        bl printf

        ldr r0, =division_out
        bl printf

        ldr r0, =out_num
        mov r1, r9
        bl printf

        b program_exit              

/*------------------------------------------------------------*/
check_bad_input:
        /*
        Check to make sure the input is valid
        */
        ldr r0, =input_err
        bl printf
        b input

/*------------------------------------------------------------*/
give_num:
        /*
        Get the input from the scan and store it in r1
        */
        push {lr}
        ldr r0, =num_input_scan                
        sub sp, sp, #4
        mov r1, sp
        bl scanf
        ldr r1, [sp, #0]
        add sp, sp, #4                          
        pop {lr}
        bx lr

/*------------------------------------------------------------*/
verifyinput:
        /*
        Check for bad input based on in from user, branch accordingly
        based on said check
        */
        cmp r4, #0
        bmi check_bad_input
        cmp r5, #0
        bmi check_bad_input
        bx lr

/*------------------------------------------------------------*/
div_check:
        /*
        Division by 0 check
        */
        cmp r5, #0
        beq zero_div_check
        bx lr
 /*------------------------------------------------------------*/
zero_div_check:
        /*
        Division by 0 check and kick
        */
        ldr r0, =zero_in
        bl printf
        b input
 /*------------------------------------------------------------*/
overflow:
        /*
        Check for overflow condition
        */
        ldr r0, =Overflow_check
        bl printf
        b input
 /*------------------------------------------------------------*/
do_addition:
        /*
        Do the addition with flag checked
        */
        pop {r11}                       
        pop {r10}                      
        adds r8, r10, r11               
        bx lr   

 /*------------------------------------------------------------*/
do_subtraction
        /*
        Do the subtraction with flags checked
        */
        pop {r11}
        pop {r10}
        subs r8, r10, r11               
        bx lr

 /*------------------------------------------------------------*/
do_multiply
        /*
        Do the multiplication with flags checked
        */

        pop {r11}
        pop {r10}
        umull r8, r9, r10, r11          
        bx lr

 /*------------------------------------------------------------*/
do_divide
        /*
        Do the division and and branch to the divide_loop until remainder is 0
        */

        pop {r11}
        pop {r10}                       
        mov r6, r11
        mov r7, r10
        mov r8, #0
        b divide_loop_checker                  

/*------------------------------------------------------------*/
divide_loop:
        add r8, r8, #1
        sub r7, r7, r6

/*------------------------------------------------------------*/
divide_loop_checker:
        /*
        Check devide loop
        */

        cmp r7, r6
        bhs divide_loop
        mov r9, r7
        bx lr

/*------------------------------------------------------------*/

/*
Output statements
*/

.data
.balign 4
Welcome_Message: .asciz "Beginning of the Stack Calculator.\n"
.balign 4
get_two_ints: .asciz "Give me two positive integers to do operation on:\n"
.balign 4
user_in_prompt: .asciz "Choose an operation: \n1. Addition\n2.Subtraction\n3. Multiplication\n4. Division\n"
.balign 4
input_err: .asciz "You didn't choose any available option.\n"
.balign 4
zero_in: .asciz "Division by 0 is not possible.\n"
.balign 4
addition_out: .asciz "Addition Result: \n"
.balign 4
sub_out: .asciz "Subtracton Result: \n"
.balign 4
multiplication_out: .asciz "Multiplication Result: \n"
.balign 4
div_return: .asciz "Devision Result: \n"
.balign 4
division_out: .asciz "Remainder from Division:\n"
.balign 4
usr_cont: .asciz "Please choose:\n1. Choose new operation\n or: Quit\n"
.balign 4
num_input_scan: .asciz "%"
.balign 4
out_num: .asciz "%d\n"
.balign 4
Overflow_check: .asciz "Overflow detected.\n"
