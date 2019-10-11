#author: Toby Chappell
#date: 10/2/19
#assignment: Lab 2 - PosRun.asm
#description: Calculates the Fibonacci sequence and prompts the user for the starting sequence number.

.text 										#Text section
.globl main 							#Call main by SPIM

			#Prompt user for input
main:	la $a0, prompt
			li $v0, 4
			syscall

			li $v0, 5    		#Get input
			syscall

			move $t2, $v0   #Moves n to $t2

			# Call function to get fibonacci of n
			move $a0, $t2
			move $v0, $t2
			jal fib     		#Calculates fib(n)
			move $t3, $v0   #Moves result to $t3

			# Output result
			move $a0, $t3    #Print result
			li $v0, 1
			syscall

			la $a0, endl 		#Print newline
			li $v0, 4
			syscall

			li $v0, 10
			syscall


			# Compute and return fibonacci number
fib:	beq $a0, 0, one  	#if n=0 return 1
			beq $a0, 1, one   #if n=1 return 1

			#Calling fib(n-1)
			sub $sp, $sp, 4   #storing return address on stack
			sw $ra, 0($sp)

			sub $a0, $a0, 1   #n-1
			jal fib     			#fib(n-1)
			add $a0, $a0, 1

			lw $ra, 0($sp)   	#Restore return address from stack
			add $sp, $sp, 4

			sub $sp, $sp, 4   #Push return value to stack
			sw $v0, 0($sp)

			#Calling fib(n-2)
			sub $sp, $sp, 4   #Store return address on stack
			sw $ra, 0($sp)

			sub $a0, $a0, 2   #n-2
			jal fib     			#fib(n-2)
			add $a0, $a0, 2

			lw $ra, 0($sp)   	#Restore return address from stack
			add $sp, $sp, 4

			lw $s7, 0($sp)   	#Pop return value from stack
			add $sp, $sp, 4

			add $v0, $v0, $s7 #f(n - 2)+fib(n-1)
			jr $ra 						#Decrement/next in stack

one:	li $v0, 1
			jr $ra

.data
prompt: .asciiz		"Input the Starting Sequence Number: "	#input message
endl: .asciiz 		"\n"
