#author: Toby Chappell
#date: 11/2/19
#assignment: Lab 4 - Atoi.asm
#description: Reads a line of text from the terminal, interprets it as an integer, and then prints it out. In effect, we'll be reimplementing the read_int system call.

.text 										#text section
.globl main 							#call main by SPIM

			#Print in
main: move $s0, $0
			move $s1, $0

			li	$v0,4						#print_string syscall code = 4
			la	$a0, prompt			#load the address of prompt
			syscall

			#Get input as string
			li $v0,8 						#take in input
      la $a0, input 			#memory location of string
      la $a1, size 				#space for size of string
			lw $a1, 0($a1)			#load size
			move $s0, $a0				#save string to $s0
      syscall

			li	$v0,4						#print_string syscall code = 4
			la	$a0, endl
			syscall

			#Convert string to int
Loop:	lb $t0, ($s0)
			beqz $t0, Out				#if reaches null character, exit
			beq $t0, 10, Out		#if reaches new line character, exit
			blt $t0, 48, Inv		#check if the current char is a valid digit (48<n<57)
			bgt $t0, 57, Inv		#if invalid, move to next character
			mul $s1, $s1, 10		#update result to $s1 = s1*10 + $t0 - 48
			addi $t0, $t0, -48
			add $s1, $s1, $t0
Inv:	addi $s0, $s0, 1		#advances address to point to the next char
			j Loop

			# Print out
Out:	li	$v0,4						#print_string syscall code = 4
			la	$a0, out				#load the address of out
			syscall

			#Print number
			li $v0, 1						#print_int syscall code = 1
			move $a0, $s1				#int to print must be loaded into $a0
			syscall

			li	$v0,4						#print_string syscall code = 4
			la	$a0, endl
			syscall

			li $v0, 10 					#exit
			syscall

.data 																			#data section
prompt:	.asciiz	"Input a number: "					#input message
size: .word 20															#max number of characters
input: .space 20														#space to store word
out:	.asciiz	"Your number is: "						#output message
endl:	.asciiz "\n"													#new line
