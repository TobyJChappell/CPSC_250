#author: Toby Chappell
#date: 10/2/19
#assignment: Lab 2 - Larger.asm
#description: Reads two numbers from the user, and prints out the larger of the two to the console (“The larger number is: “)

.text 										#text section
.globl main 							#call main by SPIM

			#Read 2 inputs
main:	li	$v0,4						# print_string syscall code = 4
			la	$a0, in					# load the address of in
			syscall

			li $v0, 5						#read_int syscall code = 5
			syscall
			move $s0, $v0				#syscall results returned in $s0

			li	$v0,4						# print_string syscall code = 4
			la	$a0, newline
			syscall

			li	$v0,4						# print_string syscall code = 4
			la	$a0, in					# load the address of in
			syscall

			li $v0, 5						#read_int syscall code = 5
			syscall
			move $s1, $v0				#syscall results returned in $s1

			li	$v0,4						# print_string syscall code = 4
			la	$a0, newline
			syscall

			#Choose larger
			slt $t0, $s0, $s1		#if first input is < second input
			beq $t0, 1, Sec			#if first is < than second then jump to Sec
			move $s2, $s0				#first is larger so move to $s2
			j Out

Sec:	move $s2, $s1				#second is larger so move to $s2

			# Print out
Out:	li	$v0,4						# print_string syscall code = 4
			la	$a0, out				# load the address of out
			syscall

			#Print larger int
			li $v0, 1						#print_int syscall code = 1
			move $a0, $s2				#int to print must be loaded into $a0
			syscall

			li	$v0,4						# print_string syscall code = 4
			la	$a0, newline
			syscall

			li $v0, 10 					#exit
			syscall

.data 																	#data section
in:	.asciiz	"Input a Value: "						#input message
out:	.asciiz	"The larger number is: "	#output message
newline:	.asciiz "\n"									#new line
