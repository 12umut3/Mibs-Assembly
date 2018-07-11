.data 
	prompt:  .asciiz "Enter the number of N: "
.text
	li $v0,4
	la $a0,prompt #to take the N number from the user
	syscall
	
	li $v0,5
	syscall
	
	move $t0,$v0 #number of N is keep in $t0
	
	addi $t1,$0,0
	addi $t2,$0,0

recursive1:
	bne $t0,0,continue #this is N-- and until N will be 0 (N time)
	j printResult
continue:
	addi $t1,$t1,1	# t1 is like 1,2,3,4,....
	add $t2,$t2,$t1 # sum of $t1 like 1 + 2, 1 + 2 + 3
	addi $t0,$t0,-1
	j recursive1
printResult:
	li $v0,1  #print result
	move $a0,$t2
	syscall
