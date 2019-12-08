#author: Toby Chappell
#date: 11/9/19
#assignment: Lab 5 - PrintString.asm
#description: Using memory-mapped I/O, write a function that will perform the same task as the “Print String” System function.  Write a main program to test this function. Make sure you activate the memory-mapped I/O feature of SPIM in the settings window before you load your program.

.text 										#text section
.globl main 							#call main by SPIM

			#Load in
main: la $s0, in

			#Print string using memory-mapping
Loop:	lb $a0, ($s0)				#load character from string
			beqz $a0, Exit			#exit if reaches null
			li $t0, 0xffff0008
Poll:	lw $v0, 0($t0)
			andi $v0, $v0, 1
			beqz $v0, Poll			#poll if nothing to display
			sw $a0, 4($t0)			#store character to display
			addi $s0, $s0, 1		#advance pointer
			j Loop

Exit:	li	$v0,4						#print_string syscall code = 4
			la	$a0, endl
			syscall

			li $v0, 10 					#exit
			syscall

.data 																													#data section
in:	.asciiz	"I am a string printed using memory-mapped I/O!"		#output message
endl:	.asciiz "\n"																							#new line
