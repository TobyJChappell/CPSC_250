#author: Toby Chappell
#date: 11/2/19
#assignment: Lab 4 - Atoi.asm
#description: Reads a line of text from the terminal, interprets it as an integer, and then prints it out. In effect, we'll be reimplementing the read_int system call.

.text 										#text section
.globl main 							#call main by SPIM

			#Print in
main: li	$v0,4						#print_string syscall code = 4
			la	$a0, prompt			#load the address of in
			syscall

			#Get input
			li $v0, 5						#read_int syscall code = 5
			syscall
			move $s0, $v0				#syscall results returned in $s0

			li	$v0,4						# print_string syscall code = 4
			la	$a0, endl
			syscall

			# Print out
Out:	li	$v0,4						# print_string syscall code = 4
			la	$a0, out				# load the address of out
			syscall

			#Print number
			li $v0, 1						#print_int syscall code = 1
			move $a0, $s1				#int to print must be loaded into $a0
			syscall

			li	$v0,4						# print_string syscall code = 4
			la	$a0, endl
			syscall

			li $v0, 10 					#exit
			syscall

.data 																			#data section
prompt:	.asciiz	"Input a number: "					#input message
out:	.asciiz	"Your number is: "						#output message
endl:	.asciiz "\n"													#new line
