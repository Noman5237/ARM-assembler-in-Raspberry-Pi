/*-- Compare01.s */

/* ================================ CODE ================================ */
.text

.balign 4
.global _start
_start:
	mov r1, #2								@ r1 = 2
	mov r2, #2								@ r2 = 2
	cmp r1, r2								@ update cpsr condition codes with the value of r1-r2
	beq case_equals
case_different:
	mov r0, #1								@ r0 = 1
	b end
case_equals:
	mov r0, #0								@ r0 = 0
end:
	mov r7, #1								@ r7 = 1
	swi 0x00000000						@ exit syscall
