.equ SWI_Exit, 0x11
.equ File_Open,0x66
.equ File_Close,0x68
.equ File_WriteInt,0x6b
.equ File_WriteStr,0x69
.text

open:
	ldr r0,=OutFileName
	mov r1,#1 @ output mode
	swi File_Open
	bcs OutFileError
	ldr r1,=OutFileHandle
	str r0,[r1]
	mov pc,lr


print:
	ldr r0,=OutFileHandle
	ldr r0,[r0]
	swi File_WriteInt	
	ldr r1,=NextLine		
	swi File_WriteStr		
	mov pc,lr


close:
	ldr r0,=OutFileHandle
	ldr r0,[r0]
	swi File_Close
	mov pc,lr

OutFileError: 
	mov r0, #1 
	ldr r1, =FileOpenInpErrMsg 
	swi File_WriteStr 
	bl Exit           
sum_square:
	mov r5, #0
	mov r1, #0
	cmp r6, #1000
	blt skip_thousand
	thousand:
		sub r6,r6,#1000
		add r1,r1,#1
		cmp r6,#1000
		bge thousand
	skip_thousand:
		mul r0,r1,r1
		add r5,r5, r0
		mov r1, #0
		cmp r6, #100
	blt skip_hundred
	hundred:
		sub r6,r6,#100
		add r1,r1,#1
		cmp r6, #100
		bge hundred
	skip_hundred:
		mul r0,r1,r1
		add r5,r5, r0
		mov r1, #0
		cmp r6, #10
		blt skip_ten
	ten:
		sub r6,r6,#10
		add r1,r1,#1
		cmp r6, #10
		bge ten
	skip_ten:
		mul r0,r1,r1
		add r5,r5,r0
		mov r1,#0
		cmp r6, #1
		blt skip_one
	one:
		sub r6,r6,#1
		add r1,r1,#1
		cmp r6, #1
		bge one
	skip_one:
		mul r0,r1,r1
		add r5,r5,r0




		mov pc, lr







main:
	mov r9,#39
	mov r8,r9,LSL #8
	add r8,r8,#15
	mov r7, #1
	bl open
	for_main:
		mov r6, r7
		while_main:
			cmp r6,#10
			blt after_while
			bl sum_square
			mov r6,r5
			b while_main

		after_while:
			cmp r6,#1
			beq happy
			cmp r6,#7
			bne skip_happy
			happy:
				mov r1, r7
				bl print
			skip_happy:
				add r7,r7,#1
			cmp r7,r8
	blt for_main
	bl close
	Exit: swi SWI_Exit

	OutFileName:
	.asciz "Outputfile.txt"
NextLine:
	.asciz "\n"
FileOpenInpErrMsg:
	.asciz "Unable to open input file\n"
	.align
OutFileHandle:
	.word 0
	.end




