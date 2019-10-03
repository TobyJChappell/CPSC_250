#author: Toby Chappell
#date: 10/2/19
#assignment: Lab 2 - PosRun.asm
#description: Calculates the Fibonacci sequence and prompts the user for the starting sequence number.

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

			li $v0, 10 					#exit
			syscall

.data 																							#data section
in:	.asciiz	"Input the Starting Sequence Number: "	#input message
