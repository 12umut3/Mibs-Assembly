.data

	prompt2:  .asciiz "array size: "
	prompt3:  .asciiz "Array size should be smaller than 400: "
	prompt4:  .asciiz "Array is: "
	prompt5: .asciiz "Array's min element: "
	prompt6: .asciiz "Array's max element: "
	prompt7: .asciiz "Unique elements of the array: "
	space:	.asciiz " "
	space2:  .asciiz "\n"
	optionNumber: .asciiz "Please Enter the option Number: "
	option1: .asciiz "\n1)Read Array\n2)Bubble Sort the Array\n3)Find the Min and Max\n4)Unique Elements\n"

.text
menu:
	# menu for the program looply
	li $v0,4
	la $a0,option1
	syscall
	li $v0,4
	la $a0,optionNumber
	syscall
	li $v0,5
	syscall
	move $s7,$v0
	#option selection
	beq $s7,1,select1
	beq $s7,2,select2
	beq $s7,3,select3
	beq $s7,4,select4
select1:
	## all Values are deleted if user select again 1 to create array
	addi $a0,$0,0
	addi $a1,$0,0
	addi $s1,$0,0
	addi $s2,$0,0
	addi $t0,$0,0
	addi $t3,$0,0
	addi $t4,$0,0
	addi $t5,$0,0
	addi $s0,$0,0
	addi $s3,$0,0
	addi $s5,$0,0
	addi $t8,$0,0
	addi $t9,$0,0
	
	jal readArray
	j menu
select2:
	move $a0,$s2
	jal bubbleSort
	j menu
select3:
	move $a0,$s2
	jal minMaxforMax
	j menu
select4:
	move $a0,$s2
	jal noOfUniqueElements
	j menu
readArray:
	#create array
	addi $v0,$0,9
	li $a0,400
	syscall
	move $a0,$v0 		#a0 contains adress of array
	addi $s1,$a0,0 		# to keep $a0
	addi $s2,$s1,0
	addi $t1,$0,0 		# counter == t1 == 0
	#give prompt to user to enter the array size
	li $v0,4
	la $a0,prompt2
	syscall
	li $v0,5 		#read integer for array size
	syscall
	move $a1,$v0 		#array size keep in $a1
	move $t5,$a1		# $a1 = $t5 to keep it
	addi $t3,$0,100
	sltu $t1,$t3,$a1
	addi $t4,$0,1 		#t4 == 1 to use beq inst
	beq  $t1,$t4,exit
	j loop

loop:
	#get the user's number
	li $v0, 42  		# 42 is system call code to generate random int
	li $a1, 101 		# $a1 is where you set the upper bound
	syscall     		# your generated number will be at $a0
	#store the number in $t0
	move $t0,$a0
	sw $t0, 0($s1)
	addi $s1,$s1,4
	addi $t1,$t1,1 
	beq $t1,$t5,exit
	j loop
exit:
	#give prompt to user to enter the array size
	move $a1,$t5
	move $a0,$s2
	move $s1,$a0
	j print
print:	lw $t8,0($s1)
	li $v0,1
	move $a0,$t8
	syscall
	addi $s1,$s1,4
	addi $t9,$t9,1
	li $v0,4
	la $a0,space
	syscall
	bne $t9,$a1,print
	li $v0,4
	la $a0,space2
	syscall
	move $a1,$t5
	move $s1,$s2
	move $a0,$s1
	jr $ra

#	li $v0,1
#	move $a0,$s1
#	syscall
#	#give prompt to user to enter the array size
#	li $v0,4
#	la $a0,space2
#	syscall
#	addi $a1,$t5,0
#	li $v0,1
#	move $a0,$a1
#	syscall
#	jr $ra
		
###################################################################################################	
bubbleSort:
	addi $t9,$0,0
	beq $a1,0,exit
	mult  $a1,$a1		# Do this n^2 to like worst case
	mflo $t3 
start:
	move $s0,$a0		#take the begining adress of the array($a0) to $s0
	addi $s1,$a1,0		#take  the array size ($a1) to $s1
	
	addi $s1,$s1,-1
	addi $t2,$s1,0
	j checkElements
checkElements:
	blt $t2,1,exit2
	lw $t0,0($s0) 		#load first value
	lw $t1,4($s0) 		#load second value
	bgt $t0,$t1,changeThem  # while first > second
	addi $s0, $s0, 4 	#increment address value
	addi $t2,$t2,-1
	j checkElements
continue:
	addi $s0,$s0,4
	addi $t2,$t2,-1
	blt $t2, 1, exit2
	j checkElements
changeThem:
	sw $t0, 4($s0) #swap the values
	sw $t1, 0($s0)
	j continue  	
exit2:	
	# exit bubble sort if array is sorted
	sub $t3,$t3,$a1
	bne $t3,0,start
	move $s1,$s2
	j printB
exitBubbleSort:
	li $v0,10
	syscall
printB:	
	#bubble sort print
	lw $t8,0($s2)
	li $v0,1
	move $a0,$t8
	syscall
	addi $s2,$s2,4
	addi $t9,$t9,1
	li $v0,4
	la $a0,space
	syscall
	bne $t9,$a1,printB
	li $v0,4
	la $a0,space2
	syscall
	move $a0,$s1
	move $s2,$a0
	jr $ra
#####################################################################################################
minMaxforMax:
	move $s0,$a0
	addi $s1,$a1,0
	addi $s1,$s1,-1
	addi $t3,$0,0 #to find biggest one
	lw $t0,0($s0)
formax:
	# to find the max element
	beq $s1,0,minMaxforMin
	lw $t1,4($s0)
	addi $s0,$s0,4
	addi $s1,$s1,-1
	bgt $t0,$t1,biggestone
	blt $t0,$t1,biggestone2
	beq $s1,0,minMaxforMin
biggestone:
	bgt $t0,$t3,go1		#max value in $t3
	j formax
go1:
	move $t3,$t0
	j formax
biggestone2:
	bgt $t1,$t3,go2		#max value in $t3
	j formax
go2:
	move $t3,$t1
	j formax
minMaxforMin:
	# to find the min element
	move $s0,$a0
	addi $s1,$a1,0
	addi $s1,$s1,-1
	addi $t4,$0,0 #to find smallest one
	lw $t0,0($s0)
	lw $t1,4($s0)	
	move $t4,$t0
formin:
	beq $s1,0,exitminmax
	lw $t1,4($s0)
	addi $s0,$s0,4
	addi $s1,$s1,-1
	blt $t0,$t1,smallestone
	bgt $t0,$t1,smallestone2
	beq $s1,0,exitminmax
smallestone:
	blt $t0,$t4,go3		#min value in $t4
	j formin
go3:
	move $t4,$t0
	j formin

smallestone2:
	blt $t1,$t4,go4
	j formin
go4:
	move $t4,$t1		#min value in $t4
	j formin
exitminmax:
	# exit min max and print prompts for min value and max value
	li $v0,4
	la $a0,prompt5
	syscall
	li $v0,1
	move $a0,$t4
	syscall
	li $v0,4
	la $a0,space2
	syscall
	li $v0,4
	la $a0,prompt6
	syscall
	li $v0,1
	move $a0,$t3
	syscall
	li $v0,4
	la $a0,space2
	syscall
	move $a0,$s2
	jr $ra
#####################################################################################
noOfUniqueElements:
	move $s0,$a0
	move $s3,$s0		#keep array adress to increase 4 by 4
	addi $s1,$a1,0
	addi $s2,$s1,-1
	addi $s4,$s1,0
	addi $s5,$s1,0
	lw $t0,0($s0)
	j scan
startscan:
	#scan all elements and if any elements are equal size--
	addi $s3,$s3,4
	move $s0,$s3
	addi $s4,$s4,-1
	addi $s2,$s5,0
	ble $s4,0,exitnoOfUniqueElements	# if all elements is scanned exit the unique elements program
	lw $t0,0($s0)
scan:
	lw $t1,4($s0)
	beq $t0,$t1,decreaseSize
	addi $s0,$s0,4
	addi $s2,$s2,-1
	ble $s2,$0,startscan
	j scan
decreaseSize:
	addi $s1,$s1,-1 ## after we substract same element from the size
	addi $s0,$s0,4
	j scan
exitnoOfUniqueElements:
	li $v0,4
	la $a0,prompt7
	syscall
	li $v0, 1
	move $a0,$s1
	syscall
	li $v0,4
	la $a0,space2
	syscall
	move $a0,$s3
	jr $ra
	li $v0,10
	syscall
#######################################################################################
	
	
	

