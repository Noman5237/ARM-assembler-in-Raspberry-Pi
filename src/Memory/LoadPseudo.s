/* -- LoadPseudo.s */

/* ================================ DATA ================================ */
.data

.balign 4 								@ ensure the data is aligned to 4 bytes
myvar1:										@ define a storage for myvar1
	.word 3									@ store the value 3 in myvar1

.balign 4 								@ ensure the data is aligned to 4 bytes
myvar2:										@ define a storage for myvar2
	.word 4									@ store the value 4 in myvar2

/* ================================ CODE ================================ */
.text

.balign 4 								@ ensure the code is aligned to 4 bytes
.global main							@ define main as a global symbol
main:											@ define main
	ldr r1, =myvar1					@ r1 = &myvar1
	ldr r3, [r1]						@ r3 = *r1 = myvar1 -> register as the addressing mode

	ldr r2, =myvar2 				@ r2 = &myvar2
	ldr r4, [r2]						@ r4 = *r2 = myvar2

	add r0, r3, r4					@ r0 = r3 + r4 

	@ mov r1, #0x06010000 
	@ mov r1, #0x06000000
	@ ldr r1, =#0x06010000

	@ print the whole value in 64 bits
	bx lr										@ return from main
