#author: Toby Chappell
#date: 10/2/19
#assignment: Lab 2 - PosRun.asm
#description: Converts the file posrun.cpp into a MIPS assembly program.

.text 										#text section
.globl main 							#call main by SPIM

main:		lw $s0, size				#load size into $s0
				la $s1, list				#load address list into $s1
				li $t1, 0

Load:		lw $t4, ($s1)       #load first element of the array onto $t4
     		sub $sp, $sp, 4     #move stack pointer down by 4
     		sw $t4, ($sp)      	#store $t4 onto stack
	      add $s1, $s1, 4     #increment array pointer by 4
	      add $t1, $t1, 1     #increment counter by 1
	      blt $t1, $s0, Load

				move $a0, $s0				#moves size into $a0
				jal posrun					#jumps and links to add2
				move $s2, $v0				#moves result into $s2

				#Print out
				li	$v0,4						# print_string syscall code = 4
				la	$a0, out				# load the address of out
				syscall

				#Print sum
				li $v0, 1						#print_int syscall code = 1
				move $a0, $s2				#int to print must be loaded into $a0
				syscall

				li	$v0,4						# print_string syscall code = 4
				la	$a0, newline
				syscall

				li $v0, 10 					#exit
				syscall

				#Posrun function
posrun:	move $t0, $a0				#moves size to $t0
				move $t1, $0				#count set to 0
				move $t2, $0				#maxrun set to 0
				move $t3, $0				#counter for loop set to 0

				#Main loop
Loop:		slt $t4, $t3, $t0		#if counter is less than size
				beq $t4, 0, End			#if counter = size, jump to end
				lw $s7, ($sp)   		#Pop return value from stack
				add $sp, $sp, 4
				slt $t4, $0, $s7		#if array element is positive
				beq $t4, 1, Inc			#if array element is positive then increment
				move $t1, $0				#sets count to 0
				j Exit							#jumps to end of if statement

Inc:		addi $t1, $t1, 1		#increments count by 1
				slt $t4, $t2, $t1		#if maxrum is less than count
				beq $t4, 0, Exit		#if count is less than maxrun then jump to Exit
				move $t2, $t1				#set maxrun = to count

Exit:		addi $t3, $t3, 1		#increments counter by 1
				j Loop							#jumps to beginning of loop

				#Return value
End:		move $v0, $t2				#moves maxrun into $v0
				jr $ra

.data 																														#data section
size:	.word	10																										#array size
list:	.word 3, 0, 1, 2, 6, -2, 4, 7, 3, 7													#array elements
out:	.asciiz	"Longest consecutive run of positive values is: "		#output message
newline:	.asciiz "\n"																						#new line
