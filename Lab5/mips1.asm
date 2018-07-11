addi $t0, $zero, 5 #addi
addi $t1, $zero, 10 #addi
add $v0,$t1,$t0 #add
move $t2,$v0 #move
subi $t4,$t2,5 #to check subi work or not
nop 		#to check nop instruction work or not (Does pc + 4?)
move $a0,$v0  #move
move $s0,$a0 #move
loop1:
addi $a3,$a3,1 #addi
addi $a2,$a2,0 #addi
mul $a1,$a3,$a2 #mul 
or $a0, $a2, $v0 #or
xor $a0, $a2, $v0 #xor
and $a0, $a3, $v0 #or
slt $a0, $v1, $a0 #slt
nop
nop
add $a3, $a0, $a1 #add
beq $a0, $zero, loop2 #beq
j loop1 # jumb
loop2:
lw $s0,0($s0) #lw 
sw $s0,0($s0) #sw
j loop2


