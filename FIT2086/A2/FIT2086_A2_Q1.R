# Set working directory
setwd("C:/Monash/FIT2086")

##################################################################
# Assignment 2 Question 1.1
##################################################################
# Load the given data
covid_data <- read.csv("covid.19.ass2.2023.csv")

# Calculate the sample mean
mean_recovery_time <- mean(covid_data$Recovery.Time)
mean_recovery_time

# Calculate the sample variance
variance_recovery_time <- var(covid_data$Recovery.Time)
variance_recovery_time

# Calculate the standard deviation
sd_recovery_time <- sqrt(variance_recovery_time)
sd_recovery_time

# Obtain the sample size of the data
sample_size <- length(covid_data$Recovery.Time)
sample_size

# Calculate the standard error
standard_error <- sd_recovery_time/sqrt(sample_size)
standard_error

# Calculate t = qt(1 - a/2, df)
df <- sample_size - 1
a <- 1 - 0.95
t <- qt(1 - (1-0.95)/2, (sample_size-1))
t

# Calculate the Margin of Error
margin_of_error <- t*standard_error
margin_of_error

# Calculate 95% Confidence interval limits
# (mean - t(sd/sqrt(n)), (mean + t(sd/sqrt(n))
# Lower-bound
lower_bound <- mean_recovery_time - margin_of_error
lower_bound
# Upper-bound
upper_bound <- mean_recovery_time + margin_of_error
upper_bound

##################################################################
# Assignment 2 Question 1.2
##################################################################
# Load the given data
israeli_covid_data <- read.csv("israeli.covid.19.ass2.2023.csv")

# Calculate the sample mean
israeli_mean_recovery_time <- mean(israeli_covid_data$Recovery.Time)
israeli_mean_recovery_time

# Calculate the sample variance
israeli_variance_recovery_time <- var(israeli_covid_data$Recovery.Time)
israeli_variance_recovery_time

# Calculate the standard deviation
israeli_sd_recovery_time <- sqrt(israeli_variance_recovery_time)
israeli_sd_recovery_time

# Obtain the sample size of the data
israeli_sample_size <- length(israeli_covid_data$Recovery.Time)
israeli_sample_size

# Calculate the standard error
israeli_standard_error <- israeli_variance_recovery_time/sqrt(israeli_sample_size)
israeli_standard_error

# Degrees of freedom for t-distribution for israeli covid dataset
israeli_df <- length(israeli_covid_data$Recovery.Time) - 1
israeli_df

# Estimated mean difference
estimated_mean_difference <- mean_recovery_time - israeli_mean_recovery_time
estimated_mean_difference

# Calculate the standard error of the difference between the two means
standard_error_difference <- sqrt((variance_recovery_time / sample_size) + (israeli_variance_recovery_time / israeli_sample_size))
standard_error_difference

# Calculate the degrees of freedom for the t-distribution
total_df <- df + israeli_df
total_df

# Calculate t = qt(1 - a/2, df)
t_score <- qt(1 - (1-0.95)/2, total_df)
t_score

# Calculate the Margin of Error
new_margin_of_error <- t_score * standard_error_difference
new_margin_of_error

# Calculate 95% Confidence interval limits
# Lower-bound
new_lower_bound <- estimated_mean_difference - new_margin_of_error
new_lower_bound
# Upper-bound
new_upper_bound <- estimated_mean_difference + new_margin_of_error
new_upper_bound

##################################################################
# Assignment 2 Question 1.3
##################################################################
# Defining the Hypothesis
# H0 (Null hypothesis): µ = µ0
# The population average recovery time for the NSW cohort is equal to the population average recovery time for the Israeli cohort
# VS
# HA (Alternative hypothesis): µ != µ0
# The population average recovery time for the NSW cohort is not equal to the population average recovery time for the Israeli cohort

# Calculate the z-score
z_score <- estimated_mean_difference / standard_error_difference
z_score

# Calculate the p-value
p_value <- 2 * pnorm(-abs(z_score))
p_value

# The null hypothesis (H0) states that there is no difference in mean recovery time between the Israeli and NSW cohorts
# The alternative hypothesis (HA) suggests that there is a difference in mean recovery time between the two cohorts
# The calculated p-value will indicate the strength of evidence against the null hypothesis

# If the p-value is very small (typically less than 0.05), 
# you can conclude that there is strong evidence to reject the null hypothesis, 
# indicating a significant difference in mean recovery times between the two cohorts, 
# regardless of the order of subtraction.