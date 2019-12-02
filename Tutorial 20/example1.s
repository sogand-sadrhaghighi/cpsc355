		.data

x_m: 	.double 0r10.5
y_m: 	.double 0r2.5
z_m: 	.double 0r0.0

		.text
		.balign 4
		.global main

main: 	stp x29, x30, [sp, -16]!
		mov x29, sp
		
		adrp x19, x_m				// get address of x_m
		add x19, x19, :lo12:x_m
		ldr d0, [x19]				// load x_m into d0

		adrp x19, y_m				// get address of y_m
		add x19, x19, :lo12:y_m
		ldr s1, [x19]				// load y_m into d1

		fdiv d2, d0, d1				// x_m / y_m

		adrp x19, z_m				// get address of z_m
		add x19, x19, :lo12:z_m	
		str d2, [x19]				// store result in z

end: 	ldp x29, x30, [sp], 16
		ret


		