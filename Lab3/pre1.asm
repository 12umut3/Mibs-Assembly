.data 
	prompt:  .asciiz "Enter the first number: "
	prompt2:  .asciiz "Enter the second number: "
.text
	li $v0,4
	la $a0,prompt #print prompt to take first number from the user
	syscall
	
	li $v0,5
	syscall
	
	move $t0,$v0 #first number is keep in $t0
	addi $t2,$t0,0 # in order to keep it
	
	li $v0,4
	la $a0,prompt2	#print promt to take second number from the user
	syscall
	
	li $v0,5
	syscall
	
	move $t1,$v0	#move to the $t1
recursive1:
	bne $t1,1,continue	#if $t1 is not equal 1
	j printResult
continue:
	#this code until $t1 = 1, $t0 + $t0 like 5x4 = 5+5+5+5 
	add $t0,$t0,$t2		
	addi $t1,$t1,-1
	j recursive1
printResult:
	#print the result
	li $v0,1
	move $a0,$t0
	syscall
