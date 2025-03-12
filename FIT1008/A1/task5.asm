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

print_combination:
    # old fp at 0($fp)
    # old ra at 4($fp)
    
    ####### MEMORY DIAGRAM #######
    #     data ---> -4($fp)      #
    #     old fp ---> 0($fp)     #
    #     old ra ---> 4($fp)     #
    #     arr ---> 8($fp)        #
    #     n ---> 12($fp)         #
    #     r ---> 16($fp)         #
    ##############################

    # saves value of $ra & $fp on stack
addi $sp, $sp, -8
    # Saves value of $ra on stack
sw $ra, 4($sp)
    # Saves value of $fp on stack
sw $fp, 0($sp)
    # Copy $sp to $fp
addi $fp, $sp, 0 
    # allocates local variables on stack (data, index, i)
addi $sp, $sp, -12
    # Initialise value of data
    # data = [0] * r
addi $v0, $0, 9 # Allocate space for array
lw $t0, 16($fp) # Load r, which is size of array
addi $t1, $0, 4 # $t1 = 4
mult $t0, $t1 # r*4
mflo $t1 # $t1 =  r*4
addi $a0, $t1, 4 # (r*4)+4
syscall
sw $v0, -4($fp) # save to data which is at -4($fp)
sw $t0, ($v0) # store the length as the first element
    # Passes arguments on stack
    # combination_aux(arr, n, r, 0, data, 0)
    # arr
addi $sp, $sp, -4 # make space for one local variable
lw $t0, 8($fp)
sw $t0, 0($sp)
    # n
addi $sp, $sp, -4 # make space for one local variable
lw $t0, 12($fp)
sw $t0, 0($sp)
    # r
addi $sp, $sp, -4 # make space for one local variable
lw $t0, 16($fp)
sw $t0, 0($sp)
    # index (0)
addi $sp, $sp, -4 # make space for one local variable
lw $t0, -8($fp)
addi $t0, $0, 0 # Initialise to 0
sw $t0, 0($sp)
    # data
addi $sp, $sp, -4 # make space for one local variable
lw $t0, -4($fp)
sw $t0, 0($sp)
    # i (0)
addi $sp, $sp, -4 # make space for one local variable
lw $t0, -12($fp)
addi $t0, $0, 0 # Initialise to 0
sw $t0, 0($sp)
    # calls function using jal fn label
jal combination_aux
    # No return
    # clears arguments off stack
addi $sp, $sp, 24
    # Deallocate space for local variables
addi $sp, $sp, 12
    # Restores saved $fp off stack
lw $fp, 0($sp)
    # Restores saved $ra off stack
lw $ra, 4($sp)
    # Deallocate space used for $fp and $ra
addi $sp, $sp, 8
    # returns to caller with jr $ra
    # End Function
jr $ra

combination_aux:
    # old fp at 0($fp)
    # old ra at 4($fp)
    
    ####### MEMORY DIAGRAM #######
    #     j ---> -4($fp)         #
    #     old fp ---> 0($fp)     #
    #     old ra ---> 4($fp)     #
    #     arr ---> 8($fp)        #
    #     n ---> 12($fp)         #
    #     r ---> 16($fp)         #
    #     index ---> 20($fp)     #
    #     data ---> 24($fp)      #
    #     i ---> 28($fp)         #
    ##############################

    # saves value of $ra & $fp on stack
addi $sp, $sp, -8
    # Saves value of $ra on stack
sw $ra, 4($sp)
    # Saves value of $fp on stack
sw $fp, 0($sp)
    # Copy $sp to $fp
addi $fp, $sp, 0 
    # allocates local variables on stack (j)
addi $sp, $sp, -4
    # Initialise value of j
lw $t0, -4($fp) # Load j
addi $t0, $0, 0 # j = 0
sw $t0, -4($fp) # Save j = 0
    # First_if
first_if:
lw $t0, 20($fp) # Load index
lw $t1, 16($fp) # Load r
bne $t0, $t1, second_if # Jump to second_if if index != r, if equal, continue on to next line
# If index==r
# while j < r, print(data[j], end = " ") 
while:
lw $0, -4($fp) # Load j
lw $t1, 16($fp) # Load r
slt $t2, $t0, $t1 # if j < r (TRUE = j < r; FALSE = j > r OR j = r)
beq $t2, $0, out_while
    # Get data[j]
lw $t0, -4($fp) # Load j
lw $t2, 24($fp) # Load data
sll $t0, $t0, 2 # j*4
add $t0, $t0, $t2 # add + (j * 4)
lw $a0, 4($t0) # Load data[j]
addi $v0, $0, 1
syscall
    # print(end=" ")
la $a0, space_end
addi $v0, $0, 4
syscall
    # Increment j by 1
lw $t0, -4($fp) # Load j
addi $t0, $0, 1 # $t0 = 1
sw $t0, -4($fp) # store j as 1
j while 
out_while:
    # print newline
la $a0, newline
addi $v0, $0, 4
syscall
j call_2

    # Second_if
second_if:
lw $t0, 28($fp) # Load i
lw $t1, 12($fp) # Load n
slt $t2, $t0, $t1 # if i < n (TRUE = i < n; FALSE = i > n OR i = n)
bne $t2, $0, data_equal_index
j call_2

    # data[index] = arr[i]
data_equal_index:
    # Get data[j]
lw $t0, 20($fp) # Load index
lw $t2, 24($fp) # Load data
sll $t0, $t0, 2 # index*4
add $t0, $t0, $t2 # add + (index * 4)
lw $t6, 4($t0) # $t6 = data[index]
    # Get arr[i]
lw $1, 28($fp) # Load i
lw $t3, 8($fp) # Load arr
sll $t1, $t1, 2 # index*4
add $t1, $t1, $t3 # add + (i * 4)
lw $t5, 4($t1) # $t5 = arr[i]
    # Load value in $t5 to $t6
sw $t5, ($t6)
j call_1

    # Call_1 
    # combination_aux(arr, n, r, index + 1, data, i + 1)
call_1:
    # Passes arguments on stack
    # arr 
addi $sp, $sp, -4 # make space for one local variable
lw $t0, 8($fp)
sw $t0, 0($sp)
    # n 
addi $sp, $sp, -4 # make space for one local variable
lw $t0, 12($fp)
sw $t0, 0($sp)
    # r 
addi $sp, $sp, -4 # make space for one local variable
lw $t0, 16($fp)
sw $t0, 0($sp)
    # index + 1
addi $sp, $sp, -4 # make space for one local variable
lw $t0, 20($fp)
addi $t0, $0, 1 # index + 1
sw $t0, 0($sp)
    # data
addi $sp, $sp, -4 # make space for one local variable
lw $t0, 24($fp)
sw $t0, 0($sp)
    # i + 1
addi $sp, $sp, -4 # make space for one local variable
lw $t0, 28($fp)
addi $t0, $0, 1 # i + 1
sw $t0, 0($sp)
    # clears arguments off stack
addi $sp, $sp, 24
    # calls function using jal fn label
jal combination_aux
    # Deallocate space for local variables
addi $sp, $sp, 4
    # Restores saved $fp off stack
lw $fp, 0($sp)
    # Restores saved $ra off stack
lw $ra, 4($sp)
    # Deallocate space used for $fp and $ra
addi $sp, $sp, 8
    # returns to caller with jr $ra
    # End Function
jr $ra

    # Call_2 
    # combination_aux(arr, n, r, index, data, i + 1)
call_2:
    # Passes arguments on stack
    # arr 
addi $sp, $sp, -4 # make space for one local variable
lw $t0, 8($fp)
sw $t0, 0($sp)
    # n 
addi $sp, $sp, -4 # make space for one local variable
lw $t0, 12($fp)
sw $t0, 0($sp)
    # r 
addi $sp, $sp, -4 # make space for one local variable
lw $t0, 16($fp)
sw $t0, 0($sp)
    # index 
addi $sp, $sp, -4 # make space for one local variable
lw $t0, 20($fp)
sw $t0, 0($sp)
    # data
addi $sp, $sp, -4 # make space for one local variable
lw $t0, 24($fp)
sw $t0, 0($sp)
    # i + 1
addi $sp, $sp, -4 # make space for one local variable
lw $t0, 28($fp)
addi $t0, $0, 1 # i + 1
sw $t0, 0($sp)
    # clears arguments off stack
addi $sp, $sp, 24
    # calls function using jal fn label
jal combination_aux
    # Deallocate space for local variables
addi $sp, $sp, 4
    # Restores saved $fp off stack
lw $fp, 0($sp)
    # Restores saved $ra off stack
lw $ra, 4($sp)
    # Deallocate space used for $fp and $ra
addi $sp, $sp, 8
    # returns to caller with jr $ra
    # End Function
jr $ra

    # clears local variables off stack
addi $sp, $sp, 4
    # Restores saved $fp off stack
lw $fp, 0($sp)
    # Restores saved $ra off stack
lw $ra, 4($sp)
    # Deallocate space used for $fp and $ra
addi $sp, $sp, 8
    # returns to caller with jr $ra
    # End Function
jr $ra

main:
    ####### MEMORY DIAGRAM #######
    #     arr --->  -4($fp)      #
    #       n --->  -8($fp)      #
    #       r ---> -12($fp)      #
    ##############################

    # save $ra and $fp on stack
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
    # copy $sp into $fp
addi $fp, $sp, 0
    # allocate 12 bytes for 3 local variables (arr, n, r)
    # arr is at -4($fp)
    # n is at -8($fp)
    # r is at -12($fp)
    # arr = [1, 2, 3, 4, 5]
addi $v0, $0, 9 # Allocate space for array
addi $a0, $0, 24 # (5*4)+4
syscall
sw $v0, -4($fp)
addi $t0, $0, 5 # Total length 5
sw $t0, ($v0) # store the length as the first element
lw $t0, -4($fp)
addi $t1, $0, 1
sw $t1, 4($t0) # arr[0] = 1
addi $t2, $0, 2
sw $t2, 8($t0) # arr[1] = 2
addi $t3, $0, 3
sw $t3, 12($t0) # arr[2] = 3
addi $t4, $0, 4
sw $t4, 12($t0) # arr[3] = 4
addi $t5, $0, 5
sw $t5, 12($t0) # arr[4] = 5
    # n = len(arr)
lw $t7, -4($fp) # load address of arr
lw $t8, ($t7) # load len(arr)
    # r = 3
addi $t6, $0, 3 # $t6 = 3
sw $t6, -12($fp)
    # Passes arguments on stack
    # arr as arg arr
addi $sp, $sp, -4 # make space for one local variable
lw $t0, -4($fp)
sw $t0, 0($sp)
    # n as arg n
addi $sp, $sp, -4 # make space for one local variable
lw $t0, -8($fp)
sw $t0, 0($sp)
    # r as arg r
addi $sp, $sp, -4 # make space for one local variable
lw $t0, -12($fp)
sw $t0, 0($sp)
    # calls function using jal fn label
jal print_combination
    # clears arguments off stack
addi $sp, $sp, 12
    # Deallocate space for local variables (arr, r ,n)
addi $sp, $sp, 12
    # restore $fp and $ra 
lw $fp, 0($sp)
lw $ra, 4($sp)
    # Deallocate space for $fp and $ra
addi $sp, $sp, 8
    # End Function
jr $ra
