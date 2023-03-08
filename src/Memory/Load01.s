/* -- Load01.s */

.data											@ data section

.balign 4 								@ ensure the data is aligned to 4 bytes
myvar1:										@ define a storage for myvar1
	.word 3									@ store the value 3 in myvar1

.balign 4 								@ ensure the data is aligned to 4 bytes
myvar2:										@ define a storage for myvar2
	.word 4									@ store the value 4 in myvar2


.text											@ text section

.balign 4 								@ ensure the code is aligned to 4 bytes
addr_of_myvar1:						@ define a storage for addr_of_myvar1
	.word myvar1						@ store the address of myvar1 in addr_of_myvar1


.balign 4 								@ ensure the code is aligned to 4 bytes
.global main							@ define main as a global symbol
main:											@ define main
	ldr r1, addr_of_myvar1	@ r1 = &myvar1 -> symbolic addressing mode
	ldr r3, [r1]						@ r3 = *r1 = myvar1 -> register as the addressing mode

	ldr r2, addr_of_myvar2	@ r2 = &myvar2
	ldr r4, [r2]						@ r4 = *r2 = myvar2

	add r0, r3, r4					@ r0 = r3 + r4 

	bx lr										@ return from main


.balign 4 								@ ensure the code is aligned to 4 bytes
addr_of_myvar2:						@ define a storage for addr_of_myvar2
	.word myvar2						@ store the address of myvar2 in addr_of_myvar2