/*-- Printf01.s */


@ ================================ DATA ===================================
.data

.balign 4
num:
	.word 0

.balign 4
prompt:
	.asciz "Hey type a number: "

.balign 4
format:
	.asciz "%d"

.balign 4
output:
	.asciz "You typed %d\n"

.balign 4
output_mult_by_5:
	.asciz "%d * 5 = %d\n"

.balign 4
return:
	.word 0


@ ================================ CODE ===================================
.text

.balign 4
.global main
main:
	@ store lr in return
	ldr r1, =return
	str lr, [r1]

	@ print "Hey type a number: "
	ldr r0, =prompt
	bl printf

	@ scanf("%d", &num);
	ldr r0, =format
	ldr r1, =num
	bl scanf

	@ printf("You typed %d\n", num);
	ldr r0, =output
	ldr r1, =num
	ldr r1, [r1]
	bl printf

	@ call mult_by_5
	ldr r0, =num
	ldr r0, [r0]
	bl mult_by_5

	@ printf("%d * 5 = %d\n", num, num * 5);
	mov r2, r0
	ldr r0, =output_mult_by_5
	ldr r1, =num
	ldr r1, [r1]															
	bl printf

	@ return
	ldr r1, =return
	ldr lr, [r1]
	mov r0, #0
	bx lr

@ ================================ USER FUNCTIONS ===================================

@ mutiply by 5
.balign 4
mult_by_5:
	@ r0 = r0 * 5
	add r0, r0, r0, lsl #2

	@ return
	bx lr
