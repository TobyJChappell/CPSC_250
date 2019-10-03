#author: Toby Chappell
#date: 10/14/19
#assignment: Lab 3 - Sum2.asm
#description: Modifies the MIPS program Sum.asm from Lab2 to have a function perform the addition operation: int add2 (int num1, int num2). (Don’t have to use the stack for this problem)

.text 										#text section
.globl main 							#call main by SPIM

			#Print in
main: li	$v0,4						# print_string syscall code = 4
			la	$a0, in					# load the address of in
			syscall

			#Get input
			li $v0, 5						#read_int syscall code = 5
			syscall
			move $s0, $v0				#syscall results returned in $s0

			li	$v0,4						# print_string syscall code = 4
			la	$a0, newline
			syscall

			#Reset Registers
			move $t0, $0				#clears counter
			move $s1, $0				#clears sum

			#Calculate Sum
Loop:	slt $t1, $t0, $s0		#if count is less than n
			beq $t1, 0, Out			#if count = n then go to output sum code
			addi $t0, $t0, 1		#counter for loop
			add $s1, $s1, $t0		#adds to sum
			j Loop 							#starts loop again

			# Print out
Out:	li	$v0,4						# print_string syscall code = 4
			la	$a0, out				# load the address of out
			syscall

			#Print sum
			li $v0, 1						#print_int syscall code = 1
			move $a0, $s1				#int to print must be loaded into $a0
			syscall

			li	$v0,4						# print_string syscall code = 4
			la	$a0, newline
			syscall

			li $v0, 10 					#exit
			syscall

.data 																			#data section
in:	.asciiz	"Input the Value N: "						#input message
out:	.asciiz	"The Sum of N integers is: "	#output message
newline:	.asciiz "\n"											#new line
