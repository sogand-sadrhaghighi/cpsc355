all:		exercise.o getsum.o
			gcc exercise1.o getsum.o -o myprog
exercise.o:	exercise1.c
			gcc -c exercise1.c
getsum.o:	getsum.s
			as getsum.s -o getsum.o