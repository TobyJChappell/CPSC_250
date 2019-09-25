#author: Toby Chappell
#date: 9/25/19
#assignment: Lab 1 - oddeven.asm
#description: Writes a ‘1’ to register 15 ($t7) if a value is odd, else writes a '0' if the value is even

.text 										#text section
.globl main 							#call main by SPIM

main: la $t0, value 			#load address value into $s0
			lw $s0, 0($t0)			#load word 0(value) into $s1
			andi $t7, $s0, 1		#$t7 = 1 if odd and $t7 = 0 if even

			li $v0, 10 					#exit
			syscall

.data 										#data section
value: .word 13 					#data
