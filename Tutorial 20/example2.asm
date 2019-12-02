define(fd, w19)
define(x_r, d8)
define(sum_r, d9)

fmt0: 	.string "Error opening a file. Aborting\n"
fmt1: 	.string "Sum is: %13.10f\n"

pn: 	.string "output.bin"

		AT_FDCWD = -100
		buf_size = 8
		alloc = -(16 + buf_size) & -16
		dealloc = -alloc
		buf_s = 16

		.balign 4
		.global main

main: 	stp x29, x30, [sp, alloc]!
		mov x29, sp

		mov w0, AT_FDCWD		// 1st arg (current working directory)
		adrp x1, pn
		add x1, x1, :lo12:pn 	// 2nd arg (pathname)
		mov w2, 0				// 3rd arg (read-only)
		mov w3, 0				// 4th arg (not used)
		mov x8, 56				// openat I/O request
		svc 0					// call system function
		mov fd, w0				// record the file descriptor

		cmp fd, 0				// check if file opened normally
		b.ge openok				// if yes we go to openok

		adrp x0, fmt0
		add x0, x0, :lo12:fmt0
		bl printf
		mov w0, -1
		b exit

openok: mov w0, fd 				// 1st arg (file descriptor)
		add x1, x29, buf_s 		// 2nd erg (pointer to buf)
		mov x2, buf_size 		// 3rd arg (n bytes to read)
		mov x8, 63 				// read service request
		svc 0 					// system call

		cmp w0, buf_size 		// check that n_read > 8
		b.lt end 				// if less than end of the file

		ldr x_r, [x29, buf_s] 	// store double into the register

		fadd sum_r, sum_r, x_r 	// add the double to the sum

		b openok 				// loop back again

end: 	mov w0, fd 				// 1st arg (file descriptor)
		mov x8, 57 				// close() service request
		svc 0 					// system call

		adrp x0, fmt1
		add x0, x0, :lo12:fmt1
		fmov d0, sum_r
		bl printf

		mov w0, 0

exit: 	ldp x29, x30, [sp], dealloc
		ret

		