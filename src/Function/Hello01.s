/*-- Hello01.s */

@ ================================ DATA ===================================
.data

greeting:
	.asciz "Hello, world!"

.balign
return:
	.word 0

@ ================================ CODE ===================================
.text

.balign 4
.global main
main:
	@ store lr in return
	ldr r5, =return
	str lr, [r5]

	@ get the address of greeting
	ldr r0, =greeting

	@ call the puts function
	bl puts

	@ store the return address in lr
	ldr lr, [r5]

	@ return
	bx lr
