# Your job to fill in! :)

    .data
space_end: .asciiz " "
newline: .asciiz "\n"

    .text
    # Jump to main so main runs first
    # Call main Function
jal main

    # Exit the program
addi $v0, $0, 10
syscall

insertion_sort:
    # old fp at 0($fp)
    # old ra at 4($fp)
    
    ####### MEMORY DIAGRAM #######
    #      j ---> -16($fp)       #
    #     key ---> -12($fp)      #
    #      i ---> -8($fp)        #
    #    length ---> -4($fp)     #
    #     old fp ---> 0($fp)     #
    #     old ra ---> 4($fp)     #
    #   the_list ---> 8($fp)     #
    #      i ---> 10($fp)        #
    ##############################
    
    # saves value of $ra & $fp on stack
addi $sp, $sp, -8
    # Saves value of $ra on stack
sw $ra, 4($sp)
    # Saves value of $fp on stack
sw $fp, 0($sp)
    # Copy $sp to $fp
addi $fp, $sp, 0 
    # allocates local variables on stack
addi $sp, $sp, -16
    # Initialise value of i and j
sw $0, -8($fp) # i
sw $0, -16($fp) # j
    # Initialise value of length
lw $t0, 8($fp) # load address of the_list
lw $t1, ($t0) # load len(the_list)
sw $t1, -4($fp) # save len(the_list) to length
    # For loop:
for: 
addi $t0, $0, 1 # $t0 = 1
sw $t0, -8($fp) # store i as 1
lw $t1, -4($fp) # load len(the_list) = length
    # check if i < length
slt $t2, $t0, $t1
beq $t2, $0, end_for # jump to delocate space because there's no return
    # Continue within for loop
lw $t0, -8($fp) # Load i
lw $t1, 8($fp) # Load start of list
sll $t0, $t0, 2 # i*4
add $t0, $t0, $t1 # add + (i*4)
addi $t0, $0, 4 # add 4 to $t0
sw $t0, -12($fp) # save the_list[i] to key
lw $t2, -16($fp) # Load j
lw $t0, -8($fp) # Load i
addi $t3, $0, 1 # $t3 = 1
sub $t4, $t0, $t3 # i - 1
sw $t4, -16($fp) # j = i - 1

    # While loop:
while: 
lw $t2, -16($fp) # Load j
slt $t3, $t2, $0 # if j < 0 (TRUE = j < 0; FALSE = j > 0 OR j = 0)
beq $t3, $0, check_cond_2
j end_while # Jump to end of while loop because while loop condition not fulfilled

check_cond_2:
lw $t0, -12($fp) # Load key
lw $t1, -16($fp) # Load j
lw $t2, 8($fp) # Load start of the_list
sll $t1, $t1, 2 # j*4
add $t1, $t1, $t2 # add + (j*4)
addi $t1, $0, 4 # add 4 to $t1
# $t1 = the_list[j]
slt $t2, $t0, $t1 # if key < the_list[j] (TRUE = key < the_list[j]; FALSE = key > the_list[j] OR key = the_list[j])
beq $t2, $0, end_while # go to the_list[j+1] = key if FALSE
    # In while loop:
lw $t3, -16($fp) # Load j
addi $t3, $0, 1 # $t2 = j + 1
lw $t4, 8($fp) # Load start of list
sll $t3, $t3, 2 # (j+1)*4
add $t3, $t3, $t4 # add + [(j+1)*4]
addi $t3, $0, 4 # add 4 to $t3
# $t3 = the_list[j+1]
sw $t1, ($t3) # Load value in $t1 to $t3
    # Decrement j by 1
lw $t2, -16($fp) # Load j
addi $t2, $t2, -1 # j -= 1
sw $t2, -16($fp) 

end_while:
lw $t3, -16($fp) # Load j
addi $t3, $0, 1 # j+1
lw $t4, 8($fp) # Load start of list
sll $t3, $t3, 2 # (j+1)*4
add $t3, $t3, $t4 # add + [(j+1)*4]
addi $t3, $0, 4 # add 4 to $t3
lw $t0, -12($fp) # Load key
sw $t0, ($t3) # Load $t0 to $t3
    # Increment (for loop) i by 1
lw $t0, -8($fp) # Load i
addi $t0, $0, 1 # $t0 = 1
sw $t0, -8($fp) # store i as 1
j for 

end_for:
    # Clears local variables off stack
addi $sp, $sp, 8
    # Restores saved $fp off stack
lw $fp, 0($sp)
    # Restores saved $ra off stack
lw $ra, 4($sp)
    # End Function
jr $ra

main:
    # save $ra and $fp on stack
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
    # copy $sp into $fp
addi $fp, $sp, 0
    # allocate 8 bytes for 2 local variables (arr, i)
addi $sp, $sp, -8
    # i is at -8($fp)
    # arr is at -4($fp)
    # arr = [6, -2, 7, 4, -10]
addi $v0, $0, 9 # Allocate space for array
addi $a0, $0, 24 # (5*4)+4
syscall
sw $v0, -4($fp)
addi $t0, $0, 5 # Total length 5
sw $t0, ($v0) # store the length as the first element
lw $t0, -4($fp)
addi $t1, $0, 6
sw $t1, 4($t0) # arr[0] = 6
addi $t2, $0, -2
sw $t2, 8($t0) # arr[1] = -2
addi $t3, $0, 7
sw $t3, 12($t0) # arr[2] = 7
addi $t4, $0, 4
sw $t4, 12($t0) # arr[3] = 4
addi $t5, $0, -10
sw $t5, 12($t0) # arr[4] = -10
    # i = 0
addi $t6, $0, 0
sw $t6, -8($fp)
    # Passes arguments on stack : (insertion_sort(arr))
addi $sp, $sp, -4
lw $t0, -4($fp)
sw $t0, 0($sp)
    # calls function using jal fn label
jal insertion_sort

for_loop:
    # for i in range(len(arr)): print (arr[i], end=" ")
lw $t0, -4($fp)        # load the address of arr
lw $t1, ($t0)          # load the length of arr
lw $t0, -8($fp)        # load the current value of i
slt $t0, $t0, $t1       # check if i < len(arr)
beq $t0, $0, end_for_loop
    # load and print arr[i]
lw $t0, -8($fp)         # load the value of i
lw $t1, -4($fp)         # load the starting address of arr
sll $t0, $t0, 2         # i * 4
add $t0, $t0, $t1       # add + (i * 4)
lw $a0, 4($t0)          # load arr[i]
addi $v0, $0, 1
syscall
    # print(end=" ")
la $a0, space_end
addi $v0, $0, 4
syscall
j for_loop

end_for_loop: # go to print()
    # clears arguments off stack
addi $sp, $sp, 4

    # store return value
addi $a0, $v0, 0
    # print return value
addi $v0, $0, 1
syscall
    # print newline
la $a0, newline
addi $v0, $0, 4
syscall

    # Deallocate space for local variables (arr, i)
addi $sp, $sp, 8

    # restore $fp and $ra 
lw $fp, 0($sp)
lw $ra, 4($sp)

    # Deallocate space used for $fp and $ra
addi $sp, $sp, 8

    # End Function
jr $ra

