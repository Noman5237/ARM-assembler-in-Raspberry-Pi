/*-- Array01.s */

@ ================================ DATA ====================================
.data

@ Array of 100 integers
.balign 4
a:
	@ Skip 100 integers before emitting the next datum
	.skip 400

@ A structure with two members char and int
.balign 4
b:
	@ There is a padding of 3 bytes before the int member
	.skip 8

@ ================================ CODE====================================
.text

.balign 4
.global _start
_start:
	@ i = 0
	mov r1, #0
	@ a = address of array a
	ldr r2, =a

	@ while
	b check_while
	while:
		@ a[i] = i
		str r1, [r2], #4
		@ i++
		add r1, r1, #1
	check_while:
		@ i < 100
		cmp r1, #100
		blt while
	end_while:
	mov r7, #1
	swi 0
