# Your job to fill in! :)

    .data
height: .word 0
space: .asciiz " "
valid_input: .word 0
height_input: .asciiz "How tall do you want the tower: "
a: .asciiz "A "
asterick: .asciiz "* "
newline: .asciiz "\n"
i: .word 0
s: .word 0
j: .word 0

    .text
while:
lw $t0, valid_input # load valid_input value into $t0
bne $t0, $0, exit_while_to_for_1 # check if valid_input = 0, if not, exit while loop to for loop
# print prompt (height_input)
la $a0, height_input
addi $v0, $0, 4
syscall
# Get input value for height 
addi $v0, $0, 5
syscall
sw $v0, height # save input value at height
# if statement to check height >= 5
lw $t1, height # Load height
addi $t2, $0, 5 # $t2 = 5
slt $t3, $t1, $t2 # If height less than 5, get input again
beq $t3, $0, change_valid # If height not less than 5, jump to make valid_input = 1
j while

change_valid:
# make valid_input = 1
lw $t0, valid_input # load valid_input
addi $t3, $0, 1 # $t3 = 1
sw $t3, valid_input
j while # jump back to while loop to quit while loop

exit_while_to_for_1:
lw $t0, height # load height
lw $t1, i # load i
slt $t2, $t1, $t0 # if i less than height, continue on to the inner first for loop
beq $t2, $0, exit_program # if i more than height, exit for loop and end the program
j inner_for_2

inner_for_2:
lw $t0, height # load height
lw $t1, i # load i
addi $t2, $0, 1 # $t2 = 1
add $t3, $t2, $t0 # $t3 = height+1
addi $t4, $0, -1 # $t4 = -1
mult $t3, $t4 # (height+1)*-1
mflo $t5 # $t5 = (height+1)*-1
mult $t1, $t4 # -1*i
mflo $t6 # $t6 = -1*i
lw $t7, s # load s
slt $t8, $t7, $t5 # if s less than (height+1)*-1, continue with the inner first for loop
beq $t9, $0, inner_for_3 # if s more than (height+1)*-1, exit the inner first for loop and got to the inner 2nd for loop
# print space
la $a0, space
addi $v0, $0, 4
syscall
# print newline
la $a0, newline
addi $v0, $0, 4
syscall
# s += 1
lw $t0, s # load s
addi $t0, $t0, 1 # increment s by 1
sw $t0, s
j inner_for_2 # jump back to start of the inner first for loop

inner_for_3:
lw $t1, i # load i
addi $t2, $0, 1 # $t2 = 1
add $t3, $t2, $t1 # $t3 = i + 1
lw $t4, j # load j
slt $t5, $t4, $t3 
# if j is less than i+1, continue on with the for loop; or else, jump to print newline and decrement i
beq $t5, $0, newline_print
lw $t6, i # load i
# if statement
bne $t6, $0, else # if i == 0, print("A ", end=""); if i != 0, jump to else to print("* ", end="") 
# print("A ", end="")
# print A
la $a0, a
addi $v0, $0, 4
syscall
# print newline
la $a0, newline
addi $v0, $0, 4
syscall
# j += 1
lw $t7, j # load j
addi $t7, $t7, 1 # Increment j by 1
sw $t7, j
j inner_for_3 # jump back to start of inner 2nd for loop

else:
# print * (asterick)
la $a0, asterick
addi $v0, $0, 4
syscall
# print newline
la $a0, newline
addi $v0, $0, 4
syscall
# j += 1
lw $t7, j # load j
addi $t7, $t7, 1 # increment j by 1
sw $t7, j
j inner_for_3 # jump back to the second inner for loop

newline_print:
# print newline
la $a0, newline
addi $v0, $0, 4
syscall
# i -= 1
lw $t1, i # load i
addi $t1, $t1, -1 # decrement i by 1
sw $t1, i
j exit_while_to_for_1 # jump back to the first for loop just right after the while loop

    # Exit the code
exit_program:
addi $v0, $0, 10
syscall
