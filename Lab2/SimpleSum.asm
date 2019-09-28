#author: Toby Chappell
#date: 10/2/19
#assignment: Lab 2 - SimpleSum.asm
#description: Calculates the sum of N integers: 1 + 2 + 3 + … N, prompts the user for the value of N, and prints out the sum to the console (“The Sum of N integers is: “).

#QUESTIONS
#1) How to do $t4($s0) (line 20)
#2) Check to make sure handling I/O correctly

.text 										#text section
.globl main 							#call main by SPIM

main: la $s0, integers 		#load address value into $s0
			li $v0, 5						#read_int syscall code = 5
			syscall
			move $s1, $v0				#syscall results returned in $s1

			#Calculate Sum
Loop:	slt $t1, $t0, $s1		#if count is less than n
			beq $t1, 0, Out			#if count = n then go to output sum code
			lw $t2, 0($s0)			#loads word at offset n
			add $t3, $t3, $t2		#adds sum with a value
			addi $t0, $t0, 1		#counter for loop
			addi $t4, $t4, 4		#counter for offset
			j Loop 							#starts loop again

			# Print msg
Out:	li	$v0,4						# print_string syscall code = 4
			la	$a0, msg				# load the address of msg
			syscall

			#Print sum
			li $v0, 1						#print_int syscall code = 1
			move $a0, $t0				#int to print must be loaded into $a0
			syscall

			li $v0, 10 					#exit
			syscall

.data 																			#data section
integers: .word 1, 2, 3, 4 									#integers to be summed
msg:	.asciiz	"The Sum of N integers is: "	#output message
