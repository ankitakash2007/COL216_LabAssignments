
	.equ SWI_Exit, 0x11
	.text
	# ldr r0, =ZERO
	# ldr r1, =ONE
	# mov r2, #0
	# ldr r3, =X
	# ldr r4, =S
	# ldr r5, =Y

	# # input le rhe hai 
	# mov r7, #0
	# str r7, [r1]
	# str r7, [r1, #1]
	# str r7, [r1, #2]
	# str r7, [r1, #3]
	# str r7, [r2, #1]
	# str r7, [r2, #2]
	# str r7, [r2, #3]
	# str r7, [r4, #1]
	# str r7, [r4, #2]
	# str r7, [r4, #3]
	# mov r7, #1
	# str r7, [r2]
	# str r7, [r4]
	

	#now r7 will frunction as i of main function
#main
	ldr r0, =X
	ldr r1, =ONE

# copy_BCD(x, one):
	ldr r2, [r1]
	str r2, [r0]
	ldr r2, [r1, #1]
	str r2, [r0, #1]
	ldr r2, [r1, #2]
	str r2, [r0, #2]
	ldr r2, [r1, #3]
	str r2, [r0, #3]

for_main:
	mov r3, #1
	ldr r0, =Y
	ldr r1, =X
# copy_BCD(y, x)
	ldr r2, [r1]
	str r2, [r0]
	ldr r2, [r1, #1]
	str r2, [r0, #1]
	ldr r2, [r1, #2]
	str r2, [r0, #2]
	ldr r2, [r1, #3]
	str r2, [r0, #3]
# check_gt_1(y)
	ldr r4, [r0, #1]
	ldr r5, [r0, #2]
	ldr r6, [r0, #3]
	cmp r4 orr r5 orr r6, 0
	ble skip_while_main
while_main:
# sum_square(s, y)
	ldr r4, =S
	ldr r5, =Y
	ldr r0, =S
	ldr r1, =ZERO
# copy_BCD(s, zero)
	ldr r2, [r1]
	str r2, [r0]
	ldr r2, [r1, #1]
	str r2, [r0, #1]
	ldr r2, [r1, #2]
	str r2, [r0, #2]
	ldr r2, [r1, #3]
	str r2, [r0, #3]
for_sum_square:
	mov r6, #0
#square_digit(dd, x[i])
	ldr r0, =DD
	ldr r1, =ZERO
	# copy_BCD(dd, zero)
	ldr r2, [r1]
	str r2, [r0]
	ldr r2, [r1, #1]
	str r2, [r0, #1]
	ldr r2, [r1, #2]
	str r2, [r0, #2]
	ldr r2, [r1, #3]
	str r2, [r0, #3]
	ldr r2, [r5, r6]
	mul r2, r2, r2
	str r2, [r0]
	cmp r2, #9
	ble skip_while_square_digit

while_square_digit:
	sub r2, r2, #10
	str r2, [r0]
	ldr r7, [r0, #1]
	add r7, r7, #1
	str r7, [r0, #1]
	cmp r2, #9
	bgt while_square_digit
#add_BCD(s,s,dd)
skip_while_square_digit:
	mov r7, #0
	mov r8, #0
	for_add_BCD:
		ldr r0, =DD
		ldr r1, [r4, r8]
		ldr r2, [r0, r8]
		add r0, r1, r2
		add r0, r0, r7
		str r0, [r4, r8]
		mov r7, #0
		cmp r0, #9
		bgt ok
	ok:
		sub r0, r0, #10
		str r0, [r4, r8]
		mov r7, #1
	add r8, r8, #1
	cmp r8, #4
	blt for_add_BCD

	ldr r0, =Y
	ldr r1, =S
	# copy_BCD(y, s)
	ldr r2, [r1]
	str r2, [r0]
	ldr r2, [r1, #1]
	str r2, [r0, #1]
	ldr r2, [r1, #2]
	str r2, [r0, #2]
	ldr r2, [r1, #3]
	str r2, [r0, #3]
 cmp r4 orr r5 orr r6, 0
	bgt while_main

	skip_while_main:
	ldr r4, =Y
	ldr r5, [r4]  #check_happy
	cmp r5, #1
	beq 


	swi SWI_Exit
	.data
ZERO:	.space 4
ONE: .space 4
X: .space 4
S: .space 4
Y: .space 4
DD: .space 4
J: .space 1
	.end