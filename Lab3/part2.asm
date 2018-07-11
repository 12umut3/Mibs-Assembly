.data 
	prompt:  .asciiz "Enter the an integer: "
	prompt2: .asciiz "\n\n\n"
.text
	
	li $v0,4
	la $a0,prompt
	syscall
	
	#Reading the number
	li $v0,5
	syscall
	
	addi $t0,$0,23
	addi $t1,$0,8
	addi $t6,$0,127

	move $s0,$v0 #number of N is keep in $t0
	move $s1,$s0 # keep the number
	move $s2,$s0
	#srlv $s0,$s0,$t2   #shifting first operand by 31 bits stored in $t2 (SIGN OF NUMBER1)    
#	sll $t2,$t1,23

loop1: 
	bne $s0,1,continue1
	beq $s0,1,continue2
	
continue1:
	srl $s0,$s0,1
	addi $t2,$t2,1
	j loop1       
continue2:
	sllv $s0,$s0,$t2
findSig:
	sub $s1,$s1,$s0
	sub $t3,$t0,$t2		#23bit - remain part
	sllv $s1,$s1,$t3	# we find to significant part
findExponent:
	add $t4,$t2,$t6 	#127+remain part
	sll  $t4,$t4,23
combineExpAndSig:
	add $t5,$t4,$s1  	#find exponent and signficant
	sll $t7,$s2,31
	srl $t7,$t7,31
	add $t5,$t5,$t7
print:
	mtc1   $t5,$f12 # $f.. are floating point registers
	#cvt.s.w  $f12, $f0
	li 	$v0, 2
	syscall   # Prints 10.0
	
		
	li $v0,4
	la $a0,prompt2
	syscall
	
	mtc1   $s2,$f0 # $f.. are floating point registers
	#cvt.s.w  $f12, $f0
	li 	$v0, 2
	syscall   # Prints 10.0      
	

