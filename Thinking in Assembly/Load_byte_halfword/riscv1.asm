nop

li sp, 152					#Initate stack pointer to the last memory address
addi sp,sp, -8					#Open 2 word space for stack

li s2,73					#Load values (This values wi)
li s1,1453

sw s1, 4(sp)					#
sw s2, 0(sp)

li s0,333
li s1,444
li s2,111

add s0,s0,s1
li s1,222
add s1,s1,s2
sub s2,s0,s1

lw s1,0(sp)
lw s2,4(sp)

addi sp, sp 8

nop