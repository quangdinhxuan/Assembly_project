.data
welcome:.asciiz " !!!!!!!!!!!!            WELCOME TO CONNECT 4 GAME         !!!!!!!!!!!!! \n"
player1:.asciiz " player1 go first\n"
player2:.asciiz " player2 go first\n"
player1win:.asciiz "!!!!!!!!!!!!!!!player X win!!!!!!!!!!"
player2win:.asciiz "!!!!!!!!!!!!!!!player O win!!!!!!!!!!"
choosecol:.asciiz"Player X Choose the column(0-6):"
choosecol1:.asciiz "Player O choose the column(0-6):"
draw:.asciiz "!!!!!!!!!!!!!!!!!!!!!DRAW!!no one win!!!!!!!!!!!!!!!!!!!!"
return:.asciiz "do you want to undo(1-yes and 0-no)"
error:.asciiz"violate the rule, go again\n"
line0:.asciiz" 0 | 1 | 2 | 3 | 4 | 5 | 6 \n - | - | - | - | - | - | - \n - | - | - | - | - | - | - \n - | - | - | - | - | - | - \n - | - | - | - | - | - | - \n - | - | - | - | - | - | - \n - | - | - | - | - | - | - \n" 
fullcol:.asciiz " the column is full please choose another column\n"
chose:.asciiz "choose X or O(O for O and other number for X):"
c:.asciiz "\nchoose the column to delete(0-6):"
b1:.asciiz "\n choose the height to delete (0-5):"
a:.asciiz" do you wanh to undo? the number of turn to undo is: "
b2:.asciiz"\n 0 for no and other number for yes:"
X:.asciiz "X"
O:.asciiz"0"
delete:.asciiz " "
d:.asciiz " your undo turn is not true please go to your turn again \n"
line:"-"
.text
#a1 X t3
#a2 O t5
#a3 undo
addi $s0,$zero,3# count the turn to undo x
addi $s6,$zero,3#count to the turn to undo y
la $t2,X
lb $t3,0($t2) #X
la $t2,O
lb $t5,0($t2)#O
la $t2,line
lb $t8,0($t2)# -
addi $t4,$zero,0 # dem so error cua X
addi $t9,$zero,0 # dem so error cua Y
addi $k1,$zero,1
addi $a2,$zero,0# dem so X
addi $a3,$zero,0#DEM SO O
addi $s7,$zero,0#dem DO CAO
li $v0,4
la  $a0,welcome
syscall

printtheboard:
li $v0,4
la $a0,line0
syscall

random:
li $a1, 1  #Here you set $a1 to the max bound.
li $v0, 42  #generates the random number.
syscall
  #Here you add the lowest bound
li $v0, 1   #1 print integer
syscall

addi $a1,$zero,1
beq  $a0,$a1,player11
j player22

player11:
li $v0,4
la $a0,player1
syscall
li $v0,4
la  $a0,chose
syscall
li $v0,5
syscall
add $a0,$0,$v0
beqz $a0,turnO
j turnX

player22:
li $v0,4
la $a0,player2
syscall
li $v0,4
la  $a0,chose
syscall
li $v0,5
syscall
add $a0,$0,$v0
beqz $a0,turnO
j turnX


turnX:
beqz $a2,printX1
addi $k1,$zero,0
undoX:
li $v0,4
la $a0,a
syscall
add $a0,$s0,$zero
li $v0,1
syscall
beqz $s0,printX1
li $v0,4
la $a0,b2
syscall


li $v0,5
syscall
beqz $v0,printX1

li $v0,4
la $a0,c
syscall
li $v0,5
syscall
addi $t0,$v0,0
li $v0,4
la $a0,b1
syscall
li $v0,5
syscall
addi $s7,$v0,0
#find the address of the undo varaiable
addi $t1,$zero,169
beqz $t0,conti
mulo $t2,$t0,4
add $t1,$t1,$t2
conti:
mulo $t2,$s7,28
sub $t1,$t1,$t2
lb $s4,line0($t1)
bne $s4,$t3,undox1
addi $k0,$t1,0
conti1:
sb $t8,line0($k0)
addi $t6,$k0,-28
slti $t7,$t6,28
bnez $t7,conti2
lb $s3,line0($t6)
beq $s3,$t8,conti2
sb $s3,line0($k0)
addi $k0,$k0,-28


j conti1
#29  33  37  41  45  49  53
#57  61  65  69  73  77  81
#85  89  93  97  101 105 109
#113 117 121 125 129 133 137
#141 145 149 153 157 161 165
#169 173 177 181 185 189 193
conti2:
li $v0,4
la $a0,line0
syscall
addi $a2,$a2,-1

addi $s0,$s0,-1
j checkwinXandY





printX1:
li $v0,4
la $a0,choosecol
syscall

li $v0,5
syscall
addi $t0,$v0,0
printX:
addi $t1,$zero,169 #address
addi $t6,$zero,0 #dem column
addi $s7,$zero,0 #dem do cao
loop:
slt $t7,$t6,$t0
beqz $t7,next
addi $t6,$t6,1
addi $t1,$t1,4
j loop

next:
lb $s1,line0($t1)
bne $t8,$s1,nextt

sb $t3,line0($t1)
li $v0,4
la $a0,line0
syscall
addi $a2,$a2,1
j checkwinX
nextt:
slti $t2,$t1,28
bnez $t2,fullX
addi $t1,$t1,-28
addi $s7,$s7,1
j next

turnO:
beqz $a3,printO
addi $k1,$zero,1
undoXO:
li $v0,4
la $a0,a
syscall
add $a0,$s6,$zero
li $v0,1
syscall
beqz $s0,printO
li $v0,4
la $a0,b2
syscall


li $v0,5
syscall
beqz $v0,printO

li $v0,4
la $a0,c
syscall
li $v0,5
syscall
addi $t0,$v0,0
li $v0,4
la $a0,b1
syscall
li $v0,5
syscall
addi $s7,$v0,0
#find the address of the undo varaiable
addi $t1,$zero,169
beqz $t0,contiO
mulo $t2,$t0,4
add $t1,$t1,$t2
contiO:
mulo $t2,$s7,28
sub $t1,$t1,$t2
lb $s4,line0($t1)
bne $s4,$t5,undox2
addi $k0,$t1,0
conti1O:
sb $t8,line0($k0)
addi $t6,$k0,-28
slti $t7,$t6,28
bnez $t7,conti2O
lb $s3,line0($t6)
beq $s3,$t8,conti2O
sb $s3,line0($k0)
addi $k0,$k0,-28


j conti1O

conti2O:
li $v0,4
la $a0,line0
syscall
addi $a3,$a3,-1

addi $s6,$s6,-1
j checkwinXandY
printO:
li $v0,4
la $a0,choosecol1
syscall

li $v0,5
syscall
addi $t0,$v0,0
printO1:
addi $t1,$zero,169
addi $t6,$zero,0
addi $s7,$zero,0
loop1:
slt $t7,$t6,$t0
beqz $t7,next1
addi $t6,$t6,1
addi $t1,$t1,4
j loop1

next1:
lb $s1,line0($t1)
bne $t8,$s1,nextt1

sb $t5,line0($t1)
li $v0,4
la $a0,line0
syscall
addi $a3,$a3,1
j checkwinO
nextt1:
slti $t2,$t1,28
bnez $t2,fullO
addi $t1,$t1,-28
addi $s7,$s7,1
j next1



fullX:
addi $t9,$t9,1
addi $t2,$zero,3
beq $t2,$t9,player2win1
li $v0,4
la $a0,fullcol
syscall
j turnX

fullO:
addi $t4,$t4,1
addi $t2,$zero,3
beq $t2,$t4,player1win1
li $v0,4
la $a0,fullcol
syscall
j turnO

checkwinX:
addi $s5,$zero,4
checkcolX:
slti $s3,$t1,112
beqz $s3,checklineX
addi $t2,$t1,0
addi $s2,$zero,1
checkcolX1:

beq $s2,$s5,player1win1
addi $t2,$t2,28
lb $s4,line0($t2)
bne $t3,$s4,checklineX
addi $s2,$s2,1
j checkcolX1


checklineX:
checkleftX:
addi $t2,$t1,0
addi $t6,$t0,0
addi $s2,$zero,1
checkleftX1:
beq $s2,$s5,player1win1
beqz $t6,checkrightX
addi $t2,$t2,-4
lb $s4,line0($t2)
bne $t3,$s4,checkrightX
addi $s2,$s2,1
addi $t6,$t6,-1
j checkleftX1

checkrightX:
addi $t6,$t0,1
addi $t2,$t1,4
checkrightX1:
slti $s3,$t6,7
beqz $s3,checkdiaX
lb $s4,line0($t2)
bne $t3,$s4,checkdiaX
addi $s2,$s2,1
addi $t6,$t6,1
addi $t2,$t2,4
beq $s2,$s5,player1win1
j checkrightX1

checkdiaX:
addi $t6,$t0,0 #column
addi $t2,$t1,0 #address
addi $s2,$zero,1#count
addi $s3,$s7,1# do cao
addi $t7,$zero,6
CheckleftupX:
beqz $t6,checkrightdowX
beq $s3,$t7,checkrightdowX
addi $s3,$s3,1
addi $t6,$t6,-1
addi $t2,$t2,-32
lb $s4,line0($t2)
bne $t3,$s4,checkrightdowX
addi $s2,$s2,1
beq $s2,$s5,player1win1
j CheckleftupX
checkrightdowX:
addi $t6,$t0,0
addi $t2,$t1,0
addi $s3,$s7,1
checkrightdow1X:
beqz $s3,checkdia1X
beq $t6,$t7,checkdia1X
addi $s3,$s3,-1
addi $t6,$t6,1
addi $t2,$t2,32
lb $s4,line0($t2)
bne $t3,$s4,checkdia1X
addi $s2,$s2,1
beq $s2,$s5,player1win1
j checkrightdow1X

checkdia1X:
addi $t6,$t0,0 #column
addi $t2,$t1,0 #address
addi $s2,$zero,1#count
addi $s3,$s7,1# do cao
addi $t7,$zero,6
checkleftdowX:
beqz $t6,checkrightupX
beqz $s3,checkrightupX
addi $s3,$s3,-1
addi $t6,$t6,-1
addi $t2,$t2,24
lb $s4,line0($t2)
bne $t3,$s4,checkrightupX
addi $s2,$s2,1
beq $s2,$s5,player1win1
j checkleftdowX

checkrightupX:
addi $t6,$t0,0
addi $t2,$t1,0
addi $s3,$s7,1
checkrightup1X:
beq $t6,$t7,checkdraw
beq $s3,$t7,checkdraw
addi $s3,$s3,1
addi $t6,$t6,1
addi $t2,$t2,-24
lb $s4,line0($t2)
bne $t3,$s4,checkdraw
addi $s2,$s2,1
beq $s2,$s5,player1win1
j checkrightup1X

checkdraw:
addi $a1,$zero,42
add $s2,$a2,$a3
beq $s2,$a1,draw1

j turnO

checkwinO:
addi $s5,$zero,4
checkcolO:
slti $s3,$t1,112
beqz $s3,checklineO
addi $t2,$t1,0
addi $s2,$zero,1
checkcolO1:
beq $s2,$s5,player2win1
addi $t2,$t2,28
lb $s4,line0($t2)
bne $t5,$s4,checklineO
addi $s2,$s2,1
j checkcolO1


checklineO:
checkleft:
addi $t2,$t1,0
addi $t6,$t0,0
addi $s2,$zero,1
checkleft1:
beq $s2,$s5,player2win1
beqz $t6,checkright
addi $t2,$t2,-4
lb $s4,line0($t2)
bne $t5,$s4,checkright
addi $s2,$s2,1
addi $t6,$t6,-1
j checkleft1

checkright:
addi $t6,$t0,1
addi $t2,$t1,4
Checkright1:
slti $s3,$t6,7
beqz $s3,checkdia
lb $s4,line0($t2)
bne $t5,$s4,checkdia
addi $s2,$s2,1
addi $t6,$t6,1
addi $t2,$t2,4
beq $s2,$s5,player2win1
j Checkright1

checkdia:
addi $t6,$t0,0 #column
addi $t2,$t1,0 #address
addi $s2,$zero,1#count
addi $s3,$s7,1# do cao
addi $t7,$zero,6
Checkleftup:
beqz $t6,checkrightdow
beq $s3,$t7,checkrightdow
addi $s3,$s3,1
addi $t6,$t6,-1
addi $t2,$t2,-32
lb $s4,line0($t2)
bne $t5,$s4,checkrightdow
addi $s2,$s2,1
beq $s2,$s5,player2win1
j Checkleftup
checkrightdow:
addi $t6,$t0,0
addi $t2,$t1,0
addi $s3,$s7,1
checkrightdow1:
beqz $s3,checkdia1
beq $t6,$t7,checkdia1
addi $s3,$s3,-1
addi $t6,$t6,1
addi $t2,$t2,32
lb $s4,line0($t2)
bne $t5,$s4,checkdia1
addi $s2,$s2,1
beq $s2,$s5,player2win1
j checkrightdow1

checkdia1:
addi $t6,$t0,0 #column
addi $t2,$t1,0 #address
addi $s2,$zero,1#count
addi $s3,$s7,1# do cao
addi $t7,$zero,6
checkleftdow:
beqz $t6,checkrightup
beqz $s3,checkrightup
addi $s3,$s3,-1
addi $t6,$t6,-1
addi $t2,$t2,24
lb $s4,line0($t2)
bne $t5,$s4,checkrightup
addi $s2,$s2,1
beq $s2,$s5,player2win1
j checkleftdow

checkrightup:
addi $t6,$t0,0
addi $t2,$t1,0
addi $s3,$s7,1
checkrightup1:
beq $t6,$t7,checkdraw1
beq $s3,$t7,checkdraw1
addi $s3,$s3,1
addi $t6,$t6,1
addi $t2,$t2,-24
lb $s4,line0($t2)
bne $t5,$s4,checkdraw1
addi $s2,$s2,1
beq $s2,$s5,player2win1
j checkrightup1

checkdraw1:
addi $a1,$zero,42
add $s2,$a3,$a2
beq $s2,$a1,draw1

j turnX

undox1:
li $v0,4
la $a0,d
syscall
addi $t4,$t4,1
addi $t2,$zero,3
beq $t4,$t2,player2win1
j turnX

undox2:
li $v0,4
la $a0,d
syscall
addi $t9,$t9,1
addi $t2,$zero,3
beq $t9,$t2,player1win1
j turnO
player1win1:
li $v0,4
la $a0,player1win
syscall
li $v0,10
syscall

player2win1:
li $v0,4
la $a0,player2win
syscall
li $v0,10
syscall

draw1:
li $v0,4
la $a0,draw
syscall
li $v0,10
syscall

checkwinXandY:
addi $k0,$t1,0

checkwinXandY1:
lb $s4,line0($t1)
beq $s4,$t3,checkwinXo
beq $s4,$t5,checkwinOo
j checknext

checknext:
beqz $k1,turnO
j turnX
checkwinXo:
addi $s5,$zero,4
checkcolXo:
slti $s3,$t1,112
beqz $s3,checklineXo
addi $t2,$t1,0
addi $s2,$zero,1
checkcolX1o:

beq $s2,$s5,player1win1
addi $t2,$t2,28
lb $s4,line0($t2)
bne $t3,$s4,checklineXo
addi $s2,$s2,1
j checkcolX1o


checklineXo:
checkleftXo:
addi $t2,$t1,0
addi $t6,$t0,0
addi $s2,$zero,1
checkleftX1o:
beq $s2,$s5,player1win1
beqz $t6,checkrightXo
addi $t2,$t2,-4
lb $s4,line0($t2)
bne $t3,$s4,checkrightXo
addi $s2,$s2,1
addi $t6,$t6,-1
j checkleftX1o

checkrightXo:
addi $t6,$t0,1
addi $t2,$t1,4
checkrightX1o:
slti $s3,$t6,7
beqz $s3,checkdiaXo
lb $s4,line0($t2)
bne $t3,$s4,checkdiaXo
addi $s2,$s2,1
addi $t6,$t6,1
addi $t2,$t2,4
beq $s2,$s5,player1win1
j checkrightX1o

checkdiaXo:
addi $t6,$t0,0 #column
addi $t2,$t1,0 #address
addi $s2,$zero,1#count
addi $s3,$s7,1# do cao
addi $t7,$zero,6
CheckleftupXo:
beqz $t6,checkrightdowXo
beq $s3,$t7,checkrightdowXo
addi $s3,$s3,1
addi $t6,$t6,-1
addi $t2,$t2,-32
lb $s4,line0($t2)
bne $t3,$s4,checkrightdowXo
addi $s2,$s2,1
beq $s2,$s5,player1win1
j CheckleftupXo
checkrightdowXo:
addi $t6,$t0,0
addi $t2,$t1,0
addi $s3,$s7,1
checkrightdow1Xo:
beqz $s3,checkdia1Xo
beq $t6,$t7,checkdia1Xo
addi $s3,$s3,-1
addi $t6,$t6,1
addi $t2,$t2,32
lb $s4,line0($t2)
bne $t3,$s4,checkdia1Xo
addi $s2,$s2,1
beq $s2,$s5,player1win1
j checkrightdow1Xo

checkdia1Xo:
addi $t6,$t0,0 #column
addi $t2,$t1,0 #address
addi $s2,$zero,1#count
addi $s3,$s7,1# do cao
addi $t7,$zero,6
checkleftdowXo:
beqz $t6,checkrightupXo
beqz $s3,checkrightupXo
addi $s3,$s3,-1
addi $t6,$t6,-1
addi $t2,$t2,24
lb $s4,line0($t2)
bne $t3,$s4,checkrightupXo
addi $s2,$s2,1
beq $s2,$s5,player1win1
j checkleftdowXo

checkrightupXo:
addi $t6,$t0,0
addi $t2,$t1,0
addi $s3,$s7,1
checkrightup1Xo:
beq $t6,$t7,checkdrawo
beq $s3,$t7,checkdrawo
addi $s3,$s3,1
addi $t6,$t6,1
addi $t2,$t2,-24
lb $s4,line0($t2)
bne $t3,$s4,checkdrawo
addi $s2,$s2,1
beq $s2,$s5,player1win1
j checkrightup1Xo

checkdrawo:
addi $t1,$t1,-28
j checkwinXandY1

checkwinOo:
addi $s5,$zero,4
checkcolOo:
slti $s3,$t1,112
beqz $s3,checklineOo
addi $t2,$t1,0
addi $s2,$zero,1
checkcolO1o:
beq $s2,$s5,player2win1
addi $t2,$t2,28
lb $s4,line0($t2)
bne $t5,$s4,checklineOo
addi $s2,$s2,1
j checkcolO1o


checklineOo:
checklefto:
addi $t2,$t1,0
addi $t6,$t0,0
addi $s2,$zero,1
checkleft1o:
beq $s2,$s5,player2win1
beqz $t6,checkrighto
addi $t2,$t2,-4
lb $s4,line0($t2)
bne $t5,$s4,checkrighto
addi $s2,$s2,1
addi $t6,$t6,-1
j checkleft1o

checkrighto:
addi $t6,$t0,1
addi $t2,$t1,4
Checkright1o:
slti $s3,$t6,7
beqz $s3,checkdiao
lb $s4,line0($t2)
bne $t5,$s4,checkdiao
addi $s2,$s2,1
addi $t6,$t6,1
addi $t2,$t2,4
beq $s2,$s5,player2win1
j Checkright1o

checkdiao:
addi $t6,$t0,0 #column
addi $t2,$t1,0 #address
addi $s2,$zero,1#count
addi $s3,$s7,1# do cao
addi $t7,$zero,6
Checkleftupo:
beqz $t6,checkrightdowo
beq $s3,$t7,checkrightdowo
addi $s3,$s3,1
addi $t6,$t6,-1
addi $t2,$t2,-32
lb $s4,line0($t2)
bne $t5,$s4,checkrightdowo
addi $s2,$s2,1
beq $s2,$s5,player2win1
j Checkleftupo
checkrightdowo:
addi $t6,$t0,0
addi $t2,$t1,0
addi $s3,$s7,1
checkrightdow1o:
beqz $s3,checkdia1o
beq $t6,$t7,checkdia1o
addi $s3,$s3,-1
addi $t6,$t6,1
addi $t2,$t2,32
lb $s4,line0($t2)
bne $t5,$s4,checkdia1o
addi $s2,$s2,1
beq $s2,$s5,player2win1
j checkrightdow1o

checkdia1o:
addi $t6,$t0,0 #column
addi $t2,$t1,0 #address
addi $s2,$zero,1#count
addi $s3,$s7,1# do cao
addi $t7,$zero,6
checkleftdowo:
beqz $t6,checkrightupo
beqz $s3,checkrightupo
addi $s3,$s3,-1
addi $t6,$t6,-1
addi $t2,$t2,24
lb $s4,line0($t2)
bne $t5,$s4,checkrightupo
addi $s2,$s2,1
beq $s2,$s5,player2win1
j checkleftdowo

checkrightupo:
addi $t6,$t0,0
addi $t2,$t1,0
addi $s3,$s7,1
checkrightup1o:
beq $t6,$t7,checkdraw1o
beq $s3,$t7,checkdraw1o
addi $s3,$s3,1
addi $t6,$t6,1
addi $t2,$t2,-24
lb $s4,line0($t2)
bne $t5,$s4,checkdraw1o
addi $s2,$s2,1
beq $s2,$s5,player2win1
j checkrightup1o

checkdraw1o:
addi $t1,$t1,-28
j checkwinXandY1

#29  33  37  41  45  49  53
#57  61  65  69  73  77  81
#85  89  93  97  101 105 109
#113 117 121 125 129 133 137
#141 145 149 153 157 161 165
#169 173 177 181 185 189 193


#t1,t3,t5,t4,t9,t0,s5,t8
