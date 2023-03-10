/*-- Sum22.s
 * This program sums the numbers 1 to 22 and stores the result in r0.
 */

/* ================================ CODE ==================================== */
.text

.balign 4
.global _start
_start:
	@ accumulator = 0
	mov r0, #0
	@ counter = 1
	mov r1, #1

	@ while
loop:
	@ counter <= 22
	cmp r1, #100
	bgt end

	@ accumulator += counter
	add r0, r0, r1

	@ counter++
	add r1, r1, #1

	@ goto loop
	b loop

end:
	@ return accumulator
	mov r7, #1
	swi 0