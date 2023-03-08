/* -- LDR.s */

/* ================================ DATA ================================= */
.data

.balign 4
var1:
	.word 3

.balign 4
var2:
	.word 4


/* ================================ CODE ================================= */
.text

.balign 4
.global main
main:
	ldr r0, adr_var1				@ r0 = &var1
	ldr r1, adr_var2				@ r1 = &var2
	ldr r2, [r0]						@ r2 = *r0 = var1
	str r2, [r1, #2]				@ *(r1+2) = r2; address mode: offset; the value of base register is unchanged
	str r2, [r1, #4]!				@ r1 = r1 + 4, *(r1+4) = r2; address mode: pre-indexed; the value of base register is changed before the memory access
	ldr r3, [r1], #4				@ r3 = *(r1), r1 = r1 + 4; address mode: post-indexed; the value of base register is changed after the memory access
	bx lr

/* ================================ RELOCATIONS ================================= */
.balign 4
adr_var1:
	.word var1

.balign 4
adr_var2:
	.word var2