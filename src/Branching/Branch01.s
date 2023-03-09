/*-- Branch01.s */

/* ================================ CODE ================================ */
.text

.balign 4
.global main
main:
	mov r0, #2								@ r0 = 2
	b end											@ branch to end
	mov r0, #3								@ r0 = 3

.balign 4
end:
	bx lr											@ return to caller
