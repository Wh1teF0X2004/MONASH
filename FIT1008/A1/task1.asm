# Your job to fill in! :)

    .data
tier_one_price: .word 9
tier_two_price: .word 11
tier_three_price: .word 14
discount_flag: .word 0
age_prompt: .asciiz "Enter your age: "
age: .word 0
total_cost: .word 0
gst: .word 0
total_bill: .word 0
welcome_msg: .asciiz "Welcome to the Thor Electrical Company!"
consumption_msg: .asciiz "Enter your total consumption in kWh: "
consumption: .word 0
loki_prompt: .asciiz "Mr Loki Laufeyson, your electricity bill is $"
dot_prompt: .asciiz "."
newline: .asciiz "\n"

    .text
    # Print welcome message
la $a0, welcome_msg
addi $v0, $0, 4
syscall

    # print newline
la $a0, newline
addi $v0, $0, 4
syscall

    # Print age prompt and input age
la $a0, age_prompt
addi $v0, $0, 4
syscall
addi $v0, $0, 5
syscall
sw $v0, age

    # If-else to check age
    # Check < 18
lw $t0, age
addi $t1, $0, 18 # $t1 = 18
slt $t3, $t0, $t1 # Check if age < 18
bne $t3, $0, equal_18 # If age >= 18, check to see if it's equal to 18
lw $t1, discount_flag
addi $t2, $0, 1 
sw $t2, discount_flag # discount_flag == 1
j consumption_input # jump to next part

    # Check = 18
equal_18:
lw $t0, age
addi $t1, $0, 18 # $t1 = 18
bne $t1, $t0, check_65
lw $t1, discount_flag
addi $t2, $0, 1
sw $t2, discount_flag
j consumption_input # jump to next part

    # Check > 65
check_65:
lw $t0, age
addi $t1, $0, 65 # $t1 = 65
slt $t3, $t0, $t1
beq $t3, $0, equal_65 # check to see if it's equal to 65
j discount_zero

    # Check = 65
equal_65:
lw $t0, age
addi $t1, $0, 65
bne $t1, $t0, discount_zero
lw $t1, discount_flag
addi $t2, $0, 1
sw $t2, discount_flag
j consumption_input # Need jump to next part

discount_zero:
lw $t1, discount_flag
addi $t3, $0, 0
sw $t3, discount_flag # discount_flag == 0
j consumption_input # Need jump to next part

    # Consumption input
consumption_input:
la $a0, consumption_msg
addi $v0, $0, 4
syscall
addi $v0, $0, 5
syscall
sw $v0, consumption

    # If-elif-if on consumption
    # consumption > 1000 and discount_flag == 0
lw $t0, consumption
addi $t1, $0, 1000 # $t1 = 1000
slt $t2, $t0, $t1
bne $t2, $0, discount_check # Consumption more than 1000, go to check discount_flag
# Less than 1000, go check consumption > 600
j consumption_600

discount_check: # If part, check == 0
lw $t5, discount_flag
beq $t5, $0, consumption_1000_0 # Discount_flag = 0, go to consumption_1000_0 calculation
j consumption_1000 # If discount_flag not 0, go to consumption_1000 calculation

consumption_1000_0:
lw $t6, total_cost
addi $t1, $0, 1000
lw $t0, consumption
sub $t3, $t0, $t1 # (consumption-1000)
lw $t4, tier_three_price
mult $t3, $t4
mflo $t5 # ((consumption-1000)*tier_three_price)
add $t2, $t6, $t5 # total_cost + ((consumption-1000)*tier_three_price)
sw $t2, total_cost # total_cost = total_cost + ((consumption-1000)*tier_three_price)
sw $t1, consumption # consumption = 1000
j consumption_600

    # consumption > 1000
consumption_1000:
lw $t0, consumption
addi $t1, $0, 1000 # $t1 = 1000
slt $t2, $t0, $t1
bne $t2, $0, consumption_600 # Consumption less than 1000, go to check consumption > 600 calculation
# If more than 1000, go check consumption > 1000 calculation then jump to check consumption > 600 calculation
lw $t6, total_cost
addi $t1, $0, 1000
lw $t0, consumption
sub $t3, $t0, $t1 # (consumption-1000)
lw $t4, tier_three_price
addi $t5, $0, 2 
sub $t7, $t4, $t5 # (tier_three_price - 2)
mult $t3, $t7 
mflo $t8 # ((consumption-1000) * (tier_three_price - 2))
add $t9, $t8, $t6 # total_cost + ((consumption-1000) * (tier_three_price - 2))
sw $t9, total_cost # total_cost = total_cost + ((consumption-1000) * (tier_three_price - 2))
sw $t1, consumption # consumption = 1000
j consumption_600

    # consumption > 600
consumption_600:
lw $t0, consumption
addi $t3, $0, 600 # $t3 = 600
slt $t4, $t0, $t3 
beq $t4, $0, gst_count # Consumption less than 600, go count total price then gst
# Consumption > 600 calculation
lw $t0, consumption
lw $t1, total_cost
lw $t2, tier_two_price
addi $t3, $0, 600
sub $t4, $t0, $t3 # (consumption-600)
mult $t4, $t2
mflo $t5 # ((consumption-600)*tier_two_price)
add $t6, $t5, $t1 # total_cost + ((consumption-600)*tier_two_price)
sw $t6, total_cost # total_cost = total_cost + ((consumption-600)*tier_two_price)
sw $t3, consumption # consumption = 600
# Need jump to next part (gst)
j gst_count

    # Gst & total_cost
gst_count:
# Total_cost calculation
lw $t0, consumption
lw $t1, total_cost
lw $t2, tier_one_price
mult $t0, $t2
mflo $t3 # (consumption*tier_one_price)
add $t4, $t3, $t1 # total_cost + (consumption*tier_one_price)
sw $t4, total_cost # total_cost = total_cost + (consumption*tier_one_price)
# GST Calculation
lw $t0, gst
lw $t1, total_cost
addi $t3, $0, 10 # $t3 = 10
div $t1, $t3 # total_cost/10
mflo $t4 # get quotient
sw $t4, gst

    # Total bill
lw $t2, gst
lw $t1, total_cost
add $t3, $t1, $t2 # total_cost + gst
sw $t3, total_bill

    # Print electricity bill
    # Print Loki
la $a0, loki_prompt
addi $v0, $0, 4
syscall    

    # Print quotient + calculation
lw $t0, total_bill
addi $t1, $0, 100 # $t1 =  100
div $t0, $t1 # total_bill // 100
mflo $t2 # get quotient

la $a0, ($t2)
addi $v0, $0, 1
syscall

    # Print dot
la $a0, dot_prompt
addi $v0, $0, 4
syscall

    # Print remainder + calculation
lw $t0, total_bill
addi $t1, $0, 100 # $t1 = 100
div $t0, $t1 # total_bill % 100
mfhi $t2 # get remainder

la $a0, ($t2)
addi $v0, $0, 1
syscall

    # Exit the code
addi $v0, $0, 10
syscall
