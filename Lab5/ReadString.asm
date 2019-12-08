#author: Toby Chappell
#date: 11/9/19
#assignment: Lab 5 - ReadString.asm
#description: Using memory-mapped I/O, write a function that will perform the same task as the “Read String” System function. This function will get characters from the keyboard and send them to the terminal as well as placing them in a buffer pointed to by register $a0. The contents of register $a1 specifies the length “n” of the buffer. It reads up to n–1 characters into the buffer and terminates the string with a null byte. If fewer than n-1 characters are on the current line, it reads up to and including the newline (Enter Key) and again null-terminates the string.  Write a main program to test this function.

.text 										#text section
.globl main 							#call main by SPIM

			#Print prompt
main: move $a0, $0				#string
			addi $t1, $0, 1			#counter
			addi $a1, $0, 12		#size

			li $v0, 4						#print_string syscall code = 4
			la $a0, prompt			#load the address of prompt
			syscall

			#Read string using memory-mapping
Loop:	beq $t1, $a1, Null	#if input reaches n without null character, null terminate
			li $t0, 0xffff0000
Poll:	lw $v0, 0($t0)
			andi $v0, $v0, 1
			beqz $v0, Poll			#poll if no character to read
			lw $v0, 4($t0)			#loads character from console
			sw $v0, ($a0)				#stores character in string
			addi $a0, $a0, 4		#advance pointer
			addi $t1, $t1, 1		#increment counter
			beq $v0, $0, Out		#if reaches null character, exit
			beq $v0, 10, Null		#if reaches newline character, null terminate
			j Loop

Null: sw $0, ($a0)				#if input reached n - 1, null terminate string

Out:	li $v0, 10 					#exit
			syscall

.data 																			#data section
prompt:	.asciiz	"Input a string: "					#input message
endl:	.asciiz "\n"													#new line
