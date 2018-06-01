.equ SWI_Exit, 0x11
	.text
	ldr r4, =AA
	mov r2, #10
	mov r8, #9
Lab1:
	str r2, [r4]
	add r4, r4, #4
	sub r2, r2, #1
	cmp r2, #0
	bne Lab1
	

	ldr r4, =AA 
	mov r7, #4
L2:
	mov r2, #0
	mov r9, #0
L:
	mul r3, r2, r7
	add r3, r3, r4
	ldr r5, [r3,#0]
	ldr r6, [r3,#4]
	cmp r5, r6
	blt skipswap
	mov r9, r5
	mov r5, r6
	mov r6, r9
skipswap:
	add r2, r2, #1

	str r5, [r3]
	str r6, [r3,#4]	
	cmp r2, r8
	blt L
	cmp r9, #0
	bgt L2

	swi SWI_Exit
	.data
AA:	.space 40
	.end
