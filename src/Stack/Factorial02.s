/*-- Factorial02.s */


@ ================================ DATA ====================================
.data

.balign 4
prompt:
	.asciz "Type a number: "

.balign 4
format:
	.asciz "%d"

.balign 4
output:
	.asciz "Factorial of %d: %d\n"


@ ================================ CODE ====================================
.text

/**
 * main
 * 
 * parameters: none
 * returns:
 * 	r0 -> exit code
 */
.balign 4
.global main 
main:
	@ push lr on the stack
	str lr, [sp, #-4]!

	@ printf("Type a number: ")
	ldr r0, =prompt
	bl printf

	@ int n -> &sp
	@ int result -> &sp + 4
	sub sp, sp, #8

	@ scanf("%d", &n)
	ldr r0, =format
	mov r1, sp
	bl scanf

	@ call factorial
	ldr r0, [sp]
	bl _factorial

	@ store the result in result
	str r0, [sp, #4]

	@ printf("Factorial of %d: %d", n, factorial(n))
	ldr r0, =output
	ldr r1, [sp]
	ldr r2, [sp, #+4]
	bl printf

	@ discard n and result from the stack
	add sp, sp, #8
	@ restore lr from the stack and restore the stack pointer
	ldr lr, [sp], #4

	@ return 0
	mov r0, #0
	bx lr

/**
 * factorial
 *
 * parameters:
 * 	r0 -> n
 * returns:
 * 	r0 -> factorial(n)
 */
.balign 4
_factorial:
	@ push lr on the stack
	str lr, [sp, #-4]!
	@ push r0 on the stack
	str r0, [sp, #-4]!

	@ if n == 0
	cmp r0, #0
	bne _factorial__recursive
	mov r0, #1
	b _factorial__end

	_factorial__recursive:
		@ call factorial(n - 1)
		sub r0, r0, #1
		bl _factorial

		@ multiply the result by n
		ldr r1, [sp]
		mul r0, r0, r1

	_factorial__end:
		@ pop lr from the stack
		ldr lr, [sp, #4]!
		@ discard r0 from the stack
		add sp, sp, #4

		@ return
		bx lr
