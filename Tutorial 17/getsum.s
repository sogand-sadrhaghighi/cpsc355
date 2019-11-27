	.balign 4
	.global getsum
	
getsum:
	stp x29, x30, [sp, -16]!
	mov x29, sp

	mov x20, xzr			// initialize the sum to 0

	bl getchar			// branch and link to getchar

	sub x0, x0, 48			// convert char to integer
	add x20, x20, x0		// add to sum

	bl getchar			// branch and link to getchar

	sub x0, x0, 48			// convert char to integer
	add x20, x20, x0		// add to sum

	bl getchar			// branch and link to getchar

	sub x0, x0, 48			// convert char to integer
	add x0, x20, x0			// add to sum and return sum in x0

	ldp x29, x30, [sp], 16
	ret
