.data
	hexNo: .asciiz  "35A4R"
	prompt2:    .asciiz "Decimal:  "
	prompt4:    .asciiz   "\n"
	str1:  .asciiz "0123456789abcdefABCDEF"
.text        
 main:
 	li $v0,4
	la $a0,prompt2           # print prompt for decimal version of number
    	syscall
    	la   $a0, hexNo  	################# load address to a0 #################
	la $s1,str1		#load hex numbers as a string
	move $s5,$s1		# keeping s1 hexNo on $s5
	addi $t0,$t0,0 		#counter $t0
	addi $t3,$t3,0		#second counter $t3
	jal   convertHexToDec	####### jump and link to convertToHex ##################

convertHexToDec:	
    # start counter
    	la   $s0, hexNo       # load inputNumber $s0
    	move $s4,$s0		#keep input hexNo on $s4
    	li   $a0, 0             # output number
    	j    loop2		#jump loop2 to hex is valid or not
    	
loop2:
    	j checkvalid
continue:
	lb   $s2, 0($s0)	   #load byte of the hexNo to $s2
    	ble  $s2, '9', sub48       # if $s2 less than or equal "9" 
    	addi $s2, $s2, -55         # convert from string to int
    	j    loop4
checkvalid:
	#search number to hex elements string and check if it is proper
    	lb   $t1,0($s1)		
    	lb   $t2,0($s0)		
    	lb   $t4,0($s0)
	beq  $t4,0,noproblem                  
    	bne  $t2,$t1,first
    	addi $t0,$0,0 
    	addi $s0,$s0,1
    	addi $s1,$s5,0
    	addi $t1,$0,0
    	addi $t2,$0,0
    	j checkvalid
noproblem:
    	add $s0,$s4,$0
    	j continue	
first:
	#check number integer by integer
	addi $t0,$t0,1
	beq $t0,22,exit
	addi $s1,$s1,1
	j checkvalid
    	
loop4:
    	blt  $s2, $0, finish  	# print int if $s2 < 0
    	li   $s3, 16                    # load 16 to $s3
    	mul  $a0, $a0, $s3              # $a0= $s3 x $a0
    	add  $a0, $a0, $s2              # add $s2 to a0
    	addi $s0, $s0, 1                # hexNo position++
    	j    continue
finish:
 	move $v0,$a0
        li $v0,1 		# code for print decimal value in $v0
        move $v0,$v0 		# result in $v0, does not matter hex proper or not, if it is not proper, -1 in $v0
 	syscall
 	li $v0,4
 	la $a0,prompt4
 	syscall
	li $v0,10
	syscall
sub48:
    	addi $s2, $s2, -48              # convert from string int
    	j    loop4
exit:
	addi $a0,$0,-1 		#return -1 if hex is not proper
	j finish
