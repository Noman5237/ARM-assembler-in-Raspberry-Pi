/* -- first-program */
@ This is a comment

/*
	We cheated a bit just to make things a bit easier.
 	We wrote a C main function in assembler which only does return 2;
	This way our program is easier since the C runtime handled initialization and termination of the program for us.
*/

.global main				@ main is our entry point and must be global

main:								@ this is main
	mov r0, #5				@ r0 = 2
	bx lr							@ branch and exchange, jump to the location of whatever is inside lr
										@ for now, this instruction just leaves the main function
