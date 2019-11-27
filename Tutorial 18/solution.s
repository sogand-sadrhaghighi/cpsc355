		.text
fmt:	.string	"Total: %d\n"

		.balign	4
		.global main
main:	stp		x29, x30, [sp, -16]!
		mov		x29, sp

		mov		w21, w0 				// argc
		mov		x22, x1 				// argv
		mov		w20, 0 					// sum

		mov		w19, 1 					// i = 1 (first argument is name of the program)
		b 		test					// branch to test

top: 	ldr		x0, [x22, w19, sxtw 3]	// load the address of the string entered
		bl 		atoi					// call atoi()
		add		w20, w20, w0 			// add to sum
		add 	w19, w19, 1				// increment i

test:	cmp		w19, w21				// i < argc
		b.lt	top						// if True, branch to top

		adrp 	x0, fmt 				// print sum
		add 	x0, x0, :lo12:fmt
		mov 	w1, w20
		bl 		printf

		mov		w0, 0
		ldp 	x29, x30, [sp], 16
		ret