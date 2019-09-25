#author: Toby Chappell
#date: 9/25/19
#assignment: Lab 1 - swap.asm
#description: Swaps the contents of the two consecutive memory locations with the two other consecutive locations.

.text 										#text section
.globl main 							#call main by SPIM

main: la $s0, first_loc 			#load address first_loc into $s0
			la $s1, second_loc			#load address second_loc into $s1

			lw $t0, 0($s0)					#loads words into $t0 - $t3
			lw $t1, 4($s0)
			lw $t2, 0($s1)
			lw $t3, 4($s1)

			sw $t0, 0($s1)					#performs swapping by overwriting addresses with swapped values
			sw $t1, 4($s1)
			sw $t2, 0($s0)
			sw $t3, 4($s0)

			li $v0, 10 							#exit
			syscall

.data 												#data section
first_loc:  .word 45, 67			#data for first memory address
second_loc:	.word 78, 90			#data for second memory address
