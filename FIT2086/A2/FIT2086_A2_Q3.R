##################################################################
# Assignment 2 Question 3.1
##################################################################
# Total number of kissing pairs
n_kissing_pairs <- 124  
# Number of pairs turning heads to the right
n_right_head_turners <- 80  

# Calculate the sample proportion
sample_proportion <- n_right_head_turners / n_kissing_pairs
sample_proportion

# Calculate the standard error
standard_error <- sqrt(sample_proportion * (1 - sample_proportion) / n_kissing_pairs)
standard_error

# Define the confidence level 95%
confidence_level <- 0.95

# Calculate the margin of error
z_score <- qnorm((1 + confidence_level) / 2) 
z_score
margin_error <- z_score * standard_error
margin_error

# Calculate the confidence interval
confidence_interval <- c(sample_proportion - margin_error, sample_proportion + margin_error)

# Display the results
confidence_interval  # 95% confidence interval

##################################################################
# Assignment 2 Question 3.2
##################################################################
# Null hypothesis value
p_null <- 0.5

# Calculate the z-score
# z <- (phat - p_null) / se
numerator <- (80/124)-0.5
denominator <- ((0.5)*(1-0.5))
z <- numerator / sqrt(denominator/124)
z

# Calculate p-value
p_value <- 2 * (1 - pnorm(abs(z)))
p_value

##################################################################
# Assignment 2 Question 3.3
##################################################################
# Total number of kissing pairs
n_kissing_pairs <- 124  
# Number of pairs turning heads to the right
n_right_head_turners <- 80  

# Null hypothesis value
p_null <- 0.5

binom.test(n_right_head_turners, n_kissing_pairs, p_null)

##################################################################
# Assignment 2 Question 3.4
##################################################################
# Number of right-handed people
n_right_handed <- 83  
# Number of left-handed people
n_left_handed <- 17   

# Total number of kissing pairs
n_kissing_pairs <- 124  
# Number of pairs turning heads to the right
n_right_head_turners <- 80  
# Number of pairs turning heads to the left
n_left_head_turners <- 44   

# Calculate the proportions
prop_right_handed <- n_right_handed / (n_right_handed + n_left_handed)
prop_right_head_turners <- n_right_head_turners / n_kissing_pairs

theta_x_hat <- n_right_handed/100
theta_y_hat <- n_right_head_turners/n_kissing_pairs
theta_p_hat <- (83+80)/(100+124)
denom <- sqrt(theta_p_hat*(1-theta_p_hat)*((1/100)+(1/124)))
z_score <- (theta_x_hat-theta_y_hat)/denom
z_score

# Calculate the p-value
p_value <- 2 * pnorm(-abs(z_score))
p_value