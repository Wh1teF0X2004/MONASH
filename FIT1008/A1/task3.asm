# Your job to fill in! :)

    .data
hulk_power_less: .asciiz "Hulk SMASH! >:("
hulk_power_more: .asciiz "Hulk Sad :("
hulk_output_1: .asciiz "Hulk smashed "
hulk_output_2: .asciiz "people"
newline: .asciiz "\n"


    .text
    .globl smash_or_sad
    # Jump to main so main runs first
    # Call main Function
jal main

    # Exit the program
addi $v0, $0, 10
syscall

    # Function 1 (callee)
smash_or_sad:
    # old fp at 0($fp)
    # old ra at 4($fp)
    # list at 8($fp)
    # hulk_power at 12($fp)
    # save $ra and $fp on the stack 
addi $sp, $sp, -8  
    # Saves value of $ra on stack
sw $ra, 4($sp)
    # Saves value of $fp on stack
sw $fp, 0($sp)
    # Copy $sp to $fp
addi $fp, $sp, 0 
    # Allocate space for local variables (smash_count, i)
    # smash_count is at -4($fp)
    # i is at -8($fp)
addi $sp, $sp, -8 # 2*8 bytes
addi $t0, $0, 0 
sw $t0, -4($fp) # smash_count = 0
addi $t0, $0, 0
sw $t1, -8($fp) # i = 0
    # For loop
lw $t0, -8($fp) # i is at -8($fp)
lw $t1, 8($fp) # list at 8($fp)
slt $t2, $t0, $t1
beq $t2, $0, if
# bne $t1, $t0, if
j return_func
    # Nested if-else
    # If
if:
lw $t2, 8($fp) # Load the_list
lw $t3, -8($fp) # Load i
addi $t3, $0, 1 # i + 1
sll $t3, $t3, 2 # i*4
add $t2, $t2, $t3 
# sw $t4, 4($t2) # $t4, the_list[i]
lw $t4, ($t2) # load the_list[i]
lw $t5, 12($fp) # load hulk_power
slt $t6, $t5, $t4 # hulk_power < the_list[i] 
bne $t6, $0, else # if NOT hulk_power < the_list[i], go else
la $a0, hulk_power_less # print("Hulk SMASH! >:(")
addi $v0, $0, 4
syscall
la $a0, newline # print newline
addi $v0, $0, 4
syscall
lw $t7, -4($fp) # load smash_count
addi $t7, $0, 1 
sw $t7, -4($fp) # smash_count += 1
j return_func # jump to return function
    # else
else:
la $a0, hulk_power_more # print("Hulk Sad :(")
addi $v0, $0, 4
syscall
la $a0, newline # print newline
addi $v0, $0, 4
syscall
j return_func # jumpt to return function
    # Return smash_count
return_func:
lw $t0, -4($fp) # Load smash_count
addi $v0, $t0, 0 # save to $v0
    # Clears local variables off stack
addi $sp, $sp, 8
    # Restores saved $fp off stack
lw $fp, 0($sp)
    # Restores saved $ra off stack
lw $ra, 4($sp)
    # End Function
jr $ra

    # Function 2 (caller)
main:
    # save $ra and $fp on stack
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
    # Copy $sp to $fp
addi $fp, $sp, 0 
    # Allocate space for local variables (my_list, hulk_power)
    # hulk_power is at -8($fp)
    # my_list is at -4($fp)
addi $sp, $sp, -8 # Allocate 8 bytes of space for 2 local variables
    # my_list = [10, 14, 16]
addi $v0, $0, 9 # Allocate space for array
addi $a0, $0, 16 # (3*4)+4
syscall
sw $v0, -4($fp)
addi $t0, $0, 3 # Total length 3
sw $t0, ($v0)
lw $t0, -4($fp)
addi $t1, $0, 10
sw $t1, 4($t0) # my_list [0] = 10
addi $t2, $0, 14
sw $t2, 8($t0) # my_list [1] = 14
addi $t3, $0, 16
sw $t3, 12($t0) # my_list [2] = 16
    # hulk_power = 15
addi $t4, $0, 15
sw $t4, -8($fp)
    # print(f"Hulk smashed {smash_or_sad(my_list, hulk_power)} people")
    # print hulk_output_1
la $a0, hulk_output_1
addi $v0, $0, 4
syscall
    # Passes arguments on stack :
    # Pass my_list into arg my_list
addi $sp, $sp, -4
lw $t0, -4($fp)
sw $t0, 0($sp)
    # Pass hulk_power into arg hulk_power
addi $sp, $sp, -4
lw $t0, -8($fp)
sw $t0, 0($sp)
    # Calls function using jal fnlabel
jal smash_or_sad
    # Clears arguments off stack
addi $sp, $sp, 8
    # Uses return value in $v0
add $a0, $v0, $0
    # Print $a0 
addi $v0, $0, 1
syscall
    # print hulk_output_2
la $a0, hulk_output_2
addi $v0, $0, 4
syscall
    # print newline
la $a0, newline
addi $v0, $0, 4
syscall
    # Deallocate space for local variables (my_list, hulk_power)
addi $sp, $sp, 8
    # Restore $fp and $ra 
lw $fp, 0($sp)
lw $ra, 4($sp)
    # Deallocate space for $fp and $ra
addi $sp, $sp, 8
    # End Function
jr $ra
