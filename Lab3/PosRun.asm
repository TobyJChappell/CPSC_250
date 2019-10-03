#author: Toby Chappell
#date: 10/2/19
#assignment: Lab 2 - PosRun.asm
#description: Converts the file posrun.cpp into a MIPS assembly program.

.text 										#text section
.globl main 							#call main by SPIM

main:

			li $v0, 10 					#exit
			syscall

.data 																			#data section
