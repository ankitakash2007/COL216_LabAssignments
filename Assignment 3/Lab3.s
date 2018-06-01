
.equ SWI_DRAW_STRING, 0x204
.equ Stdout, 1 @ Set output target to be Stdout
.equ SWI_Exit, 0x11 @ Stop execution
.global _start

.text

mov r12,#1



@%%%%%%%%%%%%%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  ldr r3, =board
  add r1,r3, #256    
  mov r2,#0
  mov r0,r3


  INITIALIZATION_LOOP:
    str r2, [r0],#4
    cmp r0,r1
    bne INITIALIZATION_LOOP

  @ begining moves of agent 1 and 2
  mov r2,#1
  mov r0,#108
  str r2, [r3,r0]
  mov r0,#144
  str r2, [r3,r0]

  mov r2,#2
  mov r0,#112
  str r2, [r3,r0]
  mov r0,#140
  str r2, [r3,r0]

  @ begining points
  ldr r3, =points
  mov r0,#2
  mov r1,#2
  str r0,[r3,#0]
  str r1,[r3,#4]
  
  ldr r0 , =agents
  mov r1, #' 
  str r1, [r0]
  mov r1, #'o
  str r1, [r0,#4]
  mov r1, #'x
  str r1, [r0,#8]
  mov r0, #2
  mov r1, #2
  back:
 
  bl print_board
   mov r0,#3
  mov r1,#3
  @ Now we need to get the input (I assume a func get_inp which occupies most of cpu time)
  bl getinput
  mov r2, r0
  mov r3, r1

  bl play
  cmp r0, #0
  beq back
  cmp r0, #-1
  beq ended
  b back
  ended:
  ldr r5, =points
  ldr r6, [r5]
  ldr r5, =points
  ldr r7, [r5,#4]
  cmp r6, r7
  bgt scgreat
  blt scless
  b dddd
  scgreat:
  mov r0,#2
  mov r1,#11
  ldr r2,=winone 
  swi SWI_DRAW_STRING
  b gameended
  scless:
  mov r0,#2
  mov r1,#11
  ldr r2,=wintwo 
  swi SWI_DRAW_STRING
  b gameended
  dddd:
  mov r0,#2
  mov r1,#11
  ldr r2,=draw 
  swi SWI_DRAW_STRING
  gameended:
  b endgameplay


@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
print_board: 
  str r0, [r13,#-4]!
  str r1, [r13,#-4]!
  str r2, [r13,#-4]!
  str r3, [r13,#-4]!
  str r4, [r13,#-4]!
  str r5, [r13,#-4]!
  str r6, [r13,#-4]!
  str r14, [r13,#-4]!

  mov r0,#1
  mov r1,#1
  ldr r2,=hborder 
  swi SWI_DRAW_STRING
  mov r1,#2
  mov r2, #1
  swi 0x205
  mov r3,#9
  StartofLoop2:
    add r1, r1, #1
    add r2, r2, #1
    swi 0x205
    cmp r1, r3
    blt StartofLoop2
  mov r0, #26
  mov r1,#2
  mov r2, #1
  swi 0x205
  mov r3,#9
  StartofLoop3:
    add r1, r1, #1
    add r2, r2, #1
    swi 0x205
    cmp r1, r3
    blt StartofLoop3
  mov r0, #1
  mov r1,#10
  ldr r2,=hborder 
  swi SWI_DRAW_STRING
  mov r0,#2
  mov r1,#12
  ldr r2,=scone 
  swi SWI_DRAW_STRING
  mov r0,#2
  mov r1,#13
  ldr r2,=sctwo 
  swi SWI_DRAW_STRING
  mov r0,#27
  mov r1,#12
  ldr r5, =points
  ldr r2,[r5]
  swi 0x205 @ display integer
  mov r0,#27
  mov r1,#13
  ldr r2, [r5,#4]
  swi 0x205 @ display integer

  mov r0,#2
  mov r1,#11
  ldr r2,=turnstr 
  swi SWI_DRAW_STRING
  mov r0,#20
  mov r1,#11
  mov r2,r12
  swi 0x205 @ display integer
  mov r2, #0
  mov r3, #0
  

  outl:
    cmp r2, #8
    bge exit_outl
    mov r3, #0
    inl:
      cmp r3, #8
      bge exit_inl
      @  player[board[get(i,j)]]);
      mov r0, r3
      mov r1, r2
      bl get
      ldr r4, =board
      ldr r4, [r4,r0,LSL#2]
      ldr r5, =agents
      ldr r5, [r5, r4, LSL#2]
      mov r1, r3
      mov r0, #0
      add r0, r2, r2, LSL#1
      add r0,r0, #3
      add r1,r1,#2
      mov r4, r2
      mov r2, r5
      swi 0x207
      mov r2, r4
      add r3, r3, #1
      b inl
    exit_inl:
    add r2, r2, #1
    b outl
  exit_outl:
  ldr r14, [r13],#4
  ldr r6, [r13],#4
  ldr r5, [r13],#4
  ldr r4, [r13],#4
  ldr r3, [r13],#4
  ldr r2, [r13],#4
  ldr r1, [r13],#4
  ldr r0, [r13],#4
  
  mov pc, lr
@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
getinput: 
  str r5, [r13,#-4]!
  str r14, [r13,#-4]!

  mov r0,#0
  swi 0x201
  notselectedyet:
  swi 0x203
  mov r1, #1
  cmp r0, r1 , LSL#0
  beq xzero
  cmp r0, r1 , LSL#1
  beq xone
  cmp r0, r1 , LSL#2
  beq xtwo
  cmp r0, r1 , LSL#3
  beq xthree
  cmp r0, r1 , LSL#4
  beq xfour
  cmp r0, r1 , LSL#5
  beq xfive
  cmp r0, r1 , LSL#6
  beq xsix
  cmp r0, r1 , LSL#7
  beq xsev
  cmp r0, r1 , LSL#8
  beq yzero
  cmp r0, r1 , LSL#9
  beq yone
  cmp r0, r1 , LSL#10
  beq ytwo
  cmp r0, r1 , LSL#11
  beq ythree
  cmp r0, r1 , LSL#12
  beq yfour
  cmp r0, r1 , LSL#13
  beq yfive
  cmp r0, r1 , LSL#14
  beq ysix
  cmp r0, r1 , LSL#15
  beq ysev
  swi 0x202
  mov r1, #2
  cmp r0, r1
  beq doneselected
  b notselectedyet
  xzero: 
    mov r0, #0x02
    swi 0x201
    mov r3, #0
    b notselectedyet
  xone: 
    mov r0, #0x02
    swi 0x201
    mov r3, #1
    b notselectedyet
  xtwo: 
    mov r0, #0x02
    swi 0x201
    mov r3, #2
    b notselectedyet
  xthree: 
    mov r0, #0x02
    swi 0x201
    mov r3, #3
    b notselectedyet
  xfour: 
    mov r0, #0x02
    swi 0x201
    mov r3, #4
    b notselectedyet
  xfive: 
    mov r0, #0x02
    swi 0x201
    mov r3, #5
    b notselectedyet
  xsix: 
    mov r0, #0x02
    swi 0x201
    mov r3, #6
    b notselectedyet
  xsev: 
    mov r0, #0x02
    swi 0x201
    mov r3, #7
    b notselectedyet

  yzero: 
    mov r0, #0x01
    swi 0x201
    mov r5, #0
    b notselectedyet
  yone: 
    mov r0, #0x01
    swi 0x201
    mov r5, #1
    b notselectedyet
  ytwo: 
    mov r0, #0x01
    swi 0x201
    mov r5, #2
    b notselectedyet
  ythree: 
    mov r0, #0x01
    swi 0x201
    mov r5, #3

    b notselectedyet
  yfour: 
    mov r0, #0x01
    swi 0x201
    mov r5, #4
    b notselectedyet
  yfive: 
    mov r0, #0x01
    swi 0x201
    mov r5, #5
    b notselectedyet
  ysix: 
    mov r0, #0x01
    swi 0x201
    mov r5, #6
    b notselectedyet
  ysev: 
    mov r0, #0x01
    swi 0x201
    mov r5, #7
    b notselectedyet


  doneselected:
  mov r0, r3
  mov r1, r5

  ldr r14, [r13],#4
  ldr r5, [r13],#4
  mov pc,lr
@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
check_valid: 
  str r14, [r13,#-4]!
  bl get
  ldr r1, =board
  ldr r1, [r1,r0,LSL#2]

  mov r0,#0
  cmp r1,r12
  movne r0,#1
  ldr r14, [r13],#4
  mov pc, lr
@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
get:
  add r0, r0, r1, LSL#3
  mov pc, lr
@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
recurse_turn: 

  str r5, [r13,#-4]!
  str r6, [r13,#-4]!
  str r7, [r13,#-4]!
  str r8, [r13,#-4]!
  str r9, [r13,#-4]!
  str r14, [r13,#-4]!

  mov r9, r4
  mov r8, r3
  mov r7, r2
  mov r6, r1
  mov r5, r0
  

  bl get
  ldr r1, =board
  ldr r1, [r1,r0,LSL#2]

  mov r0,#0
  cmp r1,#0
  beq endloop

  mov r0,#1
  cmp r1,r12
  beq endloop

  add r0, r5,r7
  add r1, r6,r8
  mov r2, r7
  mov r3, r8
  mov r4, r9
  bl recurse_turn

  mov r1,r0
  mov r0,#0
  cmp r1,#0
  beq endloop

  mov r0,#1
  cmp r9,#0
  beq endloop

  mov r0,r5
  mov r1,r6
  bl get
  ldr r1, =board
  str r12, [r1,r0,LSL#2]
  ldr r0, =points
  
  sub r1,r12,#1
  ldr r4, [r0,r1,LSL#2]
  add r4,r4,#1
  str r4, [r0,r1,LSL#2]

  and r1,r12,#1
  ldr r4, [r0,r1,LSL#2]
  sub r4,r4,#1
  str r4, [r0,r1,LSL#2]

  mov r0,#1

  endloop:

    ldr r14, [r13],#4
    ldr r9, [r13],#4
    ldr r8, [r13],#4
    ldr r7, [r13],#4
    ldr r6, [r13],#4
    ldr r5, [r13],#4
    mov pc, lr
@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
move: 
  str r3, [r13,#-4]!
  str r4, [r13,#-4]!
  str r5, [r13,#-4]!
  str r6, [r13,#-4]!
  str r7, [r13,#-4]!
  str r8, [r13,#-4]!
  str r14, [r13,#-4]!

  mov r8, #0    
  mov r7, r2    
  mov r6, r1    
  mov r5, r0    

  sub r0, r5,#1
  bl check_valid
  cmp r0,#1
  bne skip_move1
    sub r0, r5,#1
    mov r1,r6
    mov r2, #-1
    mov r3, #0
    mov r4, r7
    bl recurse_turn
    add r8,r8,r0

  skip_move1:
  add r0, r5,#1
  mov r1,r6
  bl check_valid
  cmp r0,#1
  bne skip_move2
    add r0, r5,#1
    mov r1,r6
    mov r2, #1
    mov r3, #0
    mov r4, r7
    bl recurse_turn
    add r8,r8,r0
  
  skip_move2:
  sub r1, r6,#1
  mov r0,r5
  bl check_valid
  cmp r0,#1
  bne skip_move3
    sub r1, r6,#1
    mov r0,r5
    mov r2, #0
    mov r3, #-1
    mov r4, r7
    bl recurse_turn
    add r8,r8,r0
  
  skip_move3:
  add r1, r6,#1
  mov r0,r5
  bl check_valid
  cmp r0,#1
  bne skip_move4
    add r1, r6,#1
    mov r0,r5
    mov r2, #0
    mov r3, #1
    mov r4, r7
    bl recurse_turn
    add r8,r8,r0
  
  skip_move4:
  add r0, r5,#1
  add r1, r6,#1
  bl check_valid
  cmp r0,#1
  bne skip_move5
    add r0, r5,#1
    add r1, r6,#1
    mov r2, #1
    mov r3, #1
    mov r4, r7
    bl recurse_turn
    add r8,r8,r0

  skip_move5:
  sub r0, r5,#1
  sub r1, r6,#1
  bl check_valid
  cmp r0,#1
  bne skip_move6
    sub r0, r5,#1
    sub r1, r6,#1
    mov r2, #-1
    mov r3, #-1
    mov r4, r7
    bl recurse_turn
    add r8,r8,r0

  skip_move6:
  add r0, r5,#1
  sub r1, r6,#1
  bl check_valid
  cmp r0,#1
  bne skip_move7
    add r0, r5,#1
    sub r1, r6,#1
    mov r2, #1
    mov r3, #-1
    mov r4, r7
    bl recurse_turn
    add r8,r8,r0

  skip_move7:
  sub r0, r5,#1
  add r1, r6,#1
  bl check_valid
  cmp r0,#1
  bne skip_move8
    sub r0, r5,#1
    add r1, r6,#1
    mov r2, #-1
    mov r3, #1
    mov r4, r7
    bl recurse_turn
    add r8,r8,r0
  
  skip_move8:
    mov r0, r8
  return_move:
    ldr r14, [r13],#4
    ldr r8, [r13],#4
    ldr r7, [r13],#4
    ldr r6, [r13],#4
    ldr r5, [r13],#4
    ldr r4, [r13],#4
    ldr r3, [r13],#4

    mov pc, lr
@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
check: 

  str r1, [r13,#-4]!
  str r2, [r13,#-4]!
  str r3, [r13,#-4]!
  str r4, [r13,#-4]!
  str r5, [r13,#-4]!
  str r6, [r13,#-4]!
  str r7, [r13,#-4]!
  str r14, [r13,#-4]!

  mov r7, r12    
  mov r12, r0    

  mov r6, #0     
  mov r5, #0     
  mov r4, #0     

  Outer_Loop:
    mov r4,#0     
    Inner_Loop:
      mov r0, r4
      mov r1, r5
      bl get
      ldr r1, =board
      ldr r1, [r1,r0,LSL#2]

      @if(board[i,j] == 0)
      cmp r1,#0
      bne check_skip
        mov r0,r4
        mov r1,r5
        mov r2,#0
        bl move
        mov r6,r0

      check_skip:

      add r4,r4,#1    

      cmp r4,#8
      bge Inner_Exit
      cmp r6,#0
      bne Inner_Exit
      b Inner_Loop
    Inner_Exit:
    
    add r5,r5,#1      

    cmp r5, #8
    bge Outer_Exit
    cmp r6,#0
    bne Outer_Exit
    b Outer_Loop
  Outer_Exit:

  mov r12, r7
  mov r0,r6
  return_check:
    ldr r14, [r13],#4
    ldr r7, [r13],#4
    ldr r6, [r13],#4
    ldr r5, [r13],#4
    ldr r4, [r13],#4
    ldr r3, [r13],#4
    ldr r2, [r13],#4
    ldr r1, [r13],#4


    mov pc, lr
@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
play: 
  str r2, [r13,#-4]!
  str r3, [r13,#-4]!
  str r4, [r13,#-4]!
  str r14, [r13,#-4]!

  mov r4, r1    
  mov r3, r0    

  bl get
  ldr r1, =board
  ldr r1, [r1,r0,LSL#2]


  cmp r1,#0
  bne return_play


  mov r0,r3
  mov r1,r4
  mov r2,#1
  bl move
  cmp r0,#0
  beq return_play


  mov r0,r3
  mov r1,r4
  bl get
  ldr r1, =board
  str r12, [r1,r0,LSL#2]

  ldr r0, =points
  sub r1, r12,#1
  ldr r2, [r0,r1,LSL#2]
  add r2,r2,#1
  str r2, [r0,r1,LSL#2]

  and r2,r12,#1
  add r2,r2,#1

  mov r0,r2
  bl check
  cmp r0,#1
  bne play1
    mov r12, r2   
    mov r0,r2
    b return_play

  play1:
  mov r0,r12
  bl check
  mov r1,r0
  mov r0,#-1
  cmp r1,#1
  bne return_play
    mov r0,r12
    b return_play

  return_play:
    ldr r14, [r13],#4
    ldr r4, [r13],#4
    ldr r3, [r13],#4
    ldr r2, [r13],#4
    mov pc, lr
@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
endgameplay:
      swi SWI_Exit
@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


  .data
board:  .space 256
  .align
points: .space 12
  .align
agents: .space 12
 .align
hborder: .asciz "  1  2  3  4  5  6  7  8"
vborder: .asciz "%                        %"
scone: .asciz "points of Agent 1 is "
sctwo: .asciz "points of Agent 2 is "
winone: .asciz "Agent 1 is the winner"
wintwo: .asciz "Agent 2 is the winner"
turnstr: .asciz "Turn of Agent : "
draw: .asciz "It's a Draw.."
black: .asciz "o"
white: .asciz "x"
dash: .asciz "-"
.end


