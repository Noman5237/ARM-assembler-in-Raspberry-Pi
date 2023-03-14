/*-- L01T01.s */

@ ================================ DATA ================================
.data

.balign 4
num_1:
	.skip 8

.balign 4
num_2:
	.skip 8

.balign 4
numeric_chars:
	.asciz "0123456789ABCDEF"

.balign 4
out_buffer:
	.skip 32

@ ================================ CODE ================================
.text


/**
	* @brief read user input from stdin
	* @param r0 - buffer
	* @param r1 - no of bytes to read
	* @return r0 - no of bytes read
	*/
.balign 4
read_user_input:
	push {lr}
	push {r4-r11} 

	@ syscall read
	mov r2, r1						@ no of bytes to read
	mov r1, r0						@ buffer
	mov r0, #0						@ fd = stdin
	mov r7, #3						@ syscall = read
	swi 0

	pop {r4-r11}
	pop {pc}


/**
  * @brief get the numeric value of a character (up to base 16)
	* @param r0 - character
	* @return r0 - numeric value
	*/
numeric_value:
	push {lr}
	push {r4-r11}

	@ no need to add 10 to r0
	mov r2, #0

	@ store r0 in r2 for later use
	mov r1, r0

	@ subtract '0' from character
	sub r0, r0, #48
	@ check if result is less than or equal to 9
	cmp r0, #9
	@ if less than 9, return result
	ble numeric_value__return

	@ add 10 to r0 to get the correct value
	mov r2, #10

	@ reset r0
	mov r0, r1
	@ subtract 'A' from character
	sub r0, r0, #65
	@ check if result is less than or equal to 5
	cmp r0, #5
	@ if less than 5, return result
	ble numeric_value__return

	@ reset r0
	mov r0, r1
	@ subtract 'a' from character
	sub r0, r0, #97
	@ check if result is less than or equal to 5
	cmp r0, #5
	@ if less than 5, return result
	ble numeric_value__return

	@ invalid character
	mov r0, #-16

		numeric_value__return:
			@ add carry value to r0
			add r0, r0, r2

			pop {r4-r11}
			pop {pc}

/**
	* @brief string to integer (only positive numbers)
	* @param r0 - buffer
	* @param r1 - size of buffer
	* @param r2 - base
	* @return r0 - integer
	*/
.balign 4
atoi:
	push {lr}
	push {r4-r11}

	@ store r0 in r3 for later use
	mov r4, r0
	mov r5, r1
	mov r6, r2

	@ numeric part of string length
	mov r3, #0

	@ -- get the length of the numeric part of the string --

	@ read until there is a non-digit character
	b atoi__get_length_check

		atoi__get_length:
			@ increment length
			add r3, r3, #1
			@ store numeric value in stack
			push {r0}
		atoi__get_length_check:
			@ read a single character
			ldrb r0, [r4, r3]
			@ check if character is a digit
			bl numeric_value

			@ if we have reached the size of the buffer, exit
			cmp r3, r5
			@ if not equal, continue
			beq atoi__get_length__end

			@ check if result is less than 0
			cmp r0, #0
			@ if not less than 0, continue
			bge atoi__get_length
		
		atoi__get_length__end:


	@ -- calculate the integer value --

	@ store the value of base^length in r8
	mov r8, #1
	@ pop the first value from the stack
	pop {r0}
	@ subtract 1 from length
	sub r3, r3, #1

	b atoi__count_check

		atoi__count:
			@ multiply r8 by base
			mul r8, r8, r6

			@ pop the next value from the stack
			pop {r9}
			@ multiply r9 by r8
			mul r9, r9, r8
			@ add r9 to r0
			add r0, r0, r9

			@ decrement length
			sub r3, r3, #1
		atoi__count_check:
			@ check if length is 0
			cmp r3, #0
			@ if greater than 0, continue
			bgt atoi__count
		atoi__count__end:

	pop {r4-r11}
	pop {pc}


/**
	* @brief integer to string buffer
	* @param r0 - buffer
	* @param r1 - size of buffer
	* @param r2 - integer
	* @param r3 - base
	*/
.balign 4
itoa:
	push {lr}
	push {r4-r11}

	@ store r0 in r3 for later use
	mov r4, r0
	mov r5, r1
	mov r6, r2
	mov r8, r3

	b itoa__check
		itoa__loop:
			@ divide r2 by base
			mov r7, r2
			udiv r2, r7, r8
			@ get the remainder into r7
			mul r10, r2, r8
			sub r7, r7, r10

			@ get the character for the remainder
			ldr r0, =numeric_chars
			ldrb r0, [r0, r7]

			@ decrement buffer size
			sub r1, r1, #1

			@ store character in buffer
			strb r0, [r4, r1]
		itoa__check:
			@ check if buffer size is 0
			cmp r1, #0
			@ if equal, exit
			beq itoa__end
			@ check if r2 is 0
			cmp r2, #0
			@ if not equal, continue
			bne itoa__loop
		
		itoa__end:

	pop {r4-r11}
	pop {pc}


.balign 4
.global _start
_start:
	@ read num_1
	ldr r0, =num_1
	mov r1, #8
	bl read_user_input

	@ convert num_1 to integer
	ldr r0, =num_1
	mov r1, #8
	mov r2, #10
	bl atoi

	@ convert num_1 to string base 2
	mov r2, r0
	ldr r0, =out_buffer
	mov r1, #32
	mov r3, #2
	bl itoa

	@ write out_buffer with syscalls
	mov r0, #1
	ldr r1, =out_buffer
	mov r2, #32
	mov r7, #4
	swi 0

	@ @ read num_2
	@ ldr r0, =num_2
	@ mov r1, #8
	@ bl read_user_input

	mov r0, #0

	@ exit
	mov r7, #1
	swi 0
