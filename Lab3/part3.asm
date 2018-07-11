.data
msg81:	 .asciiz "This is the current contents of the linked list: \n"
msg82:   .asciiz "No linked list is found, pointer is NULL. \n"
msg83:   .asciiz "The first node contains:  pointerToNext = "
msg84:   .asciiz ", and value = "
msg85:   .asciiz "\n"
msg86:   .asciiz "The next node contains:  pointerToNext = "
msg89:   .asciiz "The linked list has been completely displayed. \n"
msg91:	 .asciiz "This routine will help you create your linked list. \n"
msg92:   .asciiz "How many elements do you want in your linked list? Give a non-negative integer value: 0, 1, 2, etc.\n"
msg93:   .asciiz "Your list is empty, it has no elements. Also, it cannot not be displayed. \n"
msg94:   .asciiz "Input the integer value for list element #"
msg95:   .asciiz ": \n"
msg110:  .asciiz "Welcome to the Lab3 program about linked lists.\n"
msg111:  .asciiz "Here are the options you can choose: \n"
msg112:  .asciiz "1 - create a new linked list \n"
msg113:  .asciiz "2 - display the current linked list \n"
msg114:  .asciiz "3 - insert element at end of linked list \n"
msg115:  .asciiz "4 - delete element at position n from linked list \n"
msg116:  .asciiz ""
msg117:  .asciiz "6 - delete element from linked list with value x \n"
msg118:  .asciiz "7 - exit this program \n"
msg119:  .asciiz "Enter the integer for the action you choose:  "
msg120:  .asciiz "Enter the integer value of the element that you want to insert:  "
msg124:  .asciiz "Enter the position number in the linked list where you want to insert the element:  "	
msg125:  .asciiz "Enter the position number in the linked list of the element you want to delete:  "
msg126:  .asciiz "Enter the integer value of the element that you want to delete:  "
msg127:  .asciiz "Thanks for using the Lab3 program about linked lists.\n"
msg128:  .asciiz "You must enter an integer from 1 to 7. \n"
msg130:  .asciiz "The return value was invalid, so it isn't known if the requested action succeeded or failed. \n"	
msg131:  .asciiz "The requested action succeeded. \n"
msg132:  .asciiz "The requested action failed. \n"
space:	 .asciiz "  "
msg133:	 .asciiz "8 - Print reverse order of the Link List \n"
msg134:	 .asciiz "9 - Print reverse order recursively of the Link List \n"
.text
main:
	li $v0,4
	la $a0,msg85
	syscall
	li $v0,4
	la $a0,msg110
	syscall
	li $v0,4
	la $a0,msg111
	syscall
	li $v0,4
	la $a0,msg112
	syscall
	li $v0,4
	la $a0,msg113
	syscall
	li $v0,4
	la $a0,msg114
	syscall
	li $v0,4
	la $a0,msg115
	syscall
	li $v0,4
	la $a0,msg116
	syscall
	li $v0,4
	la $a0,msg117
	syscall
	li $v0,4
	la $a0,msg118
	syscall
	li $v0,4
	la $a0,msg133
	syscall
	li $v0,4
	la $a0,msg134
	syscall
	
	#user selection
	li $v0,5
	syscall
	move $t0,$v0
	
	beq $t0,1,createLL
	beq $t0,2,displayCurrentLL
	beq $t0,3,insertElementEnd
	beq $t0,4,insertElementPosition
	beq $t0,5,deleteElementPosition
	beq $t0,7,exit
	beq $t0,8,displayLLReverseIterative
	beq $t0,9,displayLLReverseRecursive
	
createLL:
target:		
	### this target ask the length of the linklist and read it ###
	li $v0,4	
	la $a0,msg92
	syscall

	li $v0,5
	syscall 
	####   t1 ==linkList length  ###
	move $t1,$v0
	move $t5,$t1
	move $t6,$t5
	### length must be positive and it checks that ###
	slt $t2,$t1,$0
	bne $t2,$0,exit
	#### t3 == 8 ####### 
	addi $t3,$0,8
	#### t2 == linklist size(t5) X 8 #######
	mult $t3,$t1
	mflo $t2
	### Allocate memory for link list ###
	addi $v0, $0, 9
	li $a0,24 #($t2 )       	# move the $t7 value to allocate the memory with linklist size
	syscall
	move $s0,$v0 		#s0 contains the address
	addi $s1,$s0, 0 	# s1 equals s0 to keep it
	addi $t4, $0, 0 	# counter t4 =0
	j create_list		#loop2 start the take numbers for linklist from the user		

create_list:	
	### Take the elements from the user for the linklist ###
	li $v0,4
	la $a0,msg94
	syscall
	li $v0,5
	syscall
	### store the number in $t0 ###
	move $t0,$v0
	### start the crating the linklist ###
	sw $t0, 4($s1) 		# it takes the number and put the 4($s1)
	addi $t1, $s1, 8
	sw $t1, 0($s1)		#it takes the adress and put the  0($s1)
	addi $s1,$s1,8		#s1 = s1+8
	addi $t4,$t4,1		#counter
	bne $t5,$t4,create_list 	#loop check by using linklist length and counter
	addi $s1,$s1,-8	
	sw $0, 0($s1)
	addi $t1,$0,0		#last element -> next == 0
	addi $s1,$s0, 0 		# s1 equals s0 to keep it
	move $t0, $s1
	j main
displayCurrentLL:
	###  this method create connections between adresses and values 
	lw $t9, 0($s1) 		# t9 is adress in the first adress of the memory  
	move $t0, $s1 		# t0 is the first adress of the memory
display_listbranch:	#### this loop print the linklist ###		
	beq $t0, $0,done
	la  $a0, 0($t0) 		# it goes the print and print the number 
	jal print
	move $t0, $t9 		# it makes t0 is the t9
	beq $t0, $0, done
	lw $t9, 0($t9) 		# it makes the t9 which t9 values has 
	j display_listbranch
done:
	li $v0,4
	la $a0,space
	syscall
	#addi $s1,$s0, 0 			# s1 equals s0 to keep it
	li $v0,4				#msg of the display the linklist
	la $a0,msg85
	syscall
	lw $t9, 0($s1) 		# t9 is adress in the first adress of the memory  
	move $t0, $s1 		# t0 is the first adress of the memory
	j main	

print:
	lw $a0, 4($a0)
	li $v0,1
	syscall
	li $v0,4	
	la $a0,space
	syscall
	jr $ra

insertElementEnd:
	#enter your integer to insert it
	li $v0,4
	la $a0,msg120
	syscall
	addi $t4,$0,0
continue1:
	beq $t5,$t4,goLast
	addi $t4,$t4,1
	addi $s1,$s1,8
	j continue1
goLast:
	li $v0,5
	syscall
	### store the number in $t0 ###
	move $t0,$v0
	### start the crating the linklist ###
	sw $t0, 4($s1) 		# it takes the number and put the 4($s1)

	sw $s1, -8($s1)		#it takes the adress and put the  0($s1)
	addi $s1,$s1,8		#s1 = s1+8
	addi $t4,$t4,1		#counter
	sw $0, 0($s1)
	addi $t1,$0,0		#last element -> next == 0
	addi $s1,$s0, 0 	# s1 equals s0 to keep it
	move $t0, $s1
	addi $t5,$t5,1
	j main
	
insertElementPosition:

deleteElementPosition:

	addi $s1,$s0,0
	addi $t3,$0,0
	addi $t4,$0,0
	li $v0,4	
	la $a0,msg125
	syscall
	#take index to delete
	li $v0,5
	syscall 
	addi $s1,$s0, 0  # s1 equals s0 to keep it
	move $t4,$v0
	#### t4 == linklist size(t5) X 8 #######
	addi $t3,$t4,-1

findIndex:

	beq $t3,$0,deleteit
	addi $s1,$s1,8
	addi $t3,$t3,-1
	j findIndex

deleteit:

	lw	$t2, 0($s1)	
	sw	$zero, 4($t2)
	sw	$zero, 0($t2)
	addi $t2,$t2,8
	sw	$t2,0($s1)
	addi $s1,$s0,0
	lw	$t2, 0($s1)
	addi $t5,$t5,-1
	j main
		
displayLLReverseIterative:
	addi $t4,$t6,0
continue2:	
	bne $t4,0,decrease
	beq $t4,0,findLast
decrease:
	addi $t4,$t4,-1
	addi $s1,$s1,8
	j continue2
findLast:
	addi $s1,$s1,-8
	la  $a0, 0($s1)
	lw $t1,4($a0)
	beq $t1,0,findLast
	move $a0, $t1
	li $v0,1
	syscall
	li $v0,4	
	la $a0,space
	syscall
	beq $s1,$s0,main
	j findLast
	
displayLLReverseRecursive:
	addi $sp, $sp,-8
	sw $ra,0($sp)
	sw $s0,4($sp)

	lw $s0,0($s0)
	beq $s0,0, restore
	jal displayLLReverseRecursive
restore:
	lw $ra,0($sp)
	lw $s0,4($sp)
	
	addi $sp,$sp,8
	lw $s0,4($s0)
	
	move $a0,$s0
	li $v0,1
	syscall
	li $v0,4	
	la $a0,space
	syscall
	li $v0,0
	addi $t6,$t6,-1
	bne $t6,0,restore
	j main

exit:
		
	
