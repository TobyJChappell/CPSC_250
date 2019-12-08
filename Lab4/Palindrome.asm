#author: Toby Chappell
#date: 11/2/19
#assignment: Lab 4 - Palindrome.asm
#description: Write a MIPS program that will read a line of text and determine whether or not the text is a palindrome. A palindrome is a word or sentence that spells exactly the same thing both forward and backward. For example, the string “anna” is a palindrome, while “ann” is not.

.text 											#text section
.globl main 								#call main by SPIM

				#Reset registers
main:		move $s0, $0
				move $s1, $0
				move $t0, $0
				move $t1, $0
				move $t2, $0

				#Print prompt
				li $v0, 4						#print_string syscall code = 4
				la $a0, prompt			#load the address of prompt
				syscall

				#Get input as string
				li $v0, 8 					#take in input
	      la $a0, input 			#memory location of string
	      la $a1, size 				#space for size of string
				lw $a1, 0($a1)			#load size
				move $s0, $a0				#save string to $s0
	      syscall

				li	$v0,4						# print_string syscall code = 4
				la	$a0, endl
				syscall

				move $t2, $s0

				#Get length of string
Loop1:	lb $t0, ($t2)
				beqz $t0, Out				#if reaches null character, exit
				beq $t0, 10, Out		#if reaches new line character, exit
				addi $t1, $t1, 1		#length of string
				addi $sp, $sp, -4   #move stack pointer down by 4
				sw $t0, ($sp)      	#store $t4 onto stack
				addi $t2, $t2, 1		#to advance the address to point to the next char
				j Loop1							#continue for the next char

Out:		move $s1, $t1
				move $t0, $0
				move $t1, $0
				move $t2, $0

				#Determine if palindrome
Loop2:	bge $t0, $s1, True	#jump out of loop
				lb $t1, ($s0)
				lw $t2, ($sp)   		#Pop return value from stack
				addi $sp, $sp, 4
				bne $t1, $t2, False
				addi $s0, $s0, 1		#point to the next char
				addi $t0, $t0, 1		#increment counter by 1
				j Loop2

				#Print true
True:		li	$v0,4						#print_string syscall code = 4
				la	$a0, true				#load the address of true
				syscall

				j End

				#Print false
False:	li	$v0,4						#print_string syscall code = 4
				la	$a0, false			#load the address of false
				syscall

End:		li	$v0,4						#print_string syscall code = 4
				la	$a0, endl
				syscall

				li $v0, 10 					#exit
				syscall

.data 																			#data section
prompt:	.asciiz	"Input a word: "						#input message
true: .asciiz	"Palindrome"									#output message for true
false: .asciiz	"Not a Palindrome"					#output message for false
endl:	.asciiz "\n"													#new line
size: .word 20															#max number of characters
input: .space 20														#space to store word
