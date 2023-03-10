/*-- CollatzConjecture.s
 * This program will count the number of steps it takes to reach 1
 */


/* ================================ CODE ==================================== */
.text

.balign 4
.global _start
_start:
	@ n = 123
	mov r1, #123
	@ count = 0
	mov r2, #0

	@ while (n != 1)
	while:
		cmp r1, #1
		beq endwhile
		@ if (n % 2 == 0)
		if:
			and r3, r1, #1
			cmp r3, #0
			bne odd
		even:
			@ n = n / 2
			mov r1, r1, asr #1
			b endif
		@ else
		odd:
			@ n = 2 * n + n
			add r1, r1, r1, asl #1
			@ n = n + 1
			add r1, r1, #1
		endif:
			@ count++
			add r2, r2, #1
	b while
	endwhile:
		@ return count
		mov r0, r2

		@ exit
		mov r7, #1
		swi 0