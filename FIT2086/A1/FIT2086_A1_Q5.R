###############################################################
# Question 5 Question 1
###############################################################
# Fit a Poisson distribution to the COVID recovery data using maximum likelihood
poisson_mle <- function(X) {
  n <- length(X)
  
  retval <- list()
  
  # Calculate the sample mean
  retval$lambda_ml <- sum(X) / n
  
  return(retval)
}

# Load the data from the provided covid CSV file
data <- read.csv("covid.2023.csv")
days_until_recovery <- data$Days

# Estimate value
estimates <- poisson_mle(days_until_recovery)
print(estimates$lambda_ml)

###############################################################
# Question 5 Question 2
###############################################################
# Estimated value
lambda_hat <- estimates$lambda_ml

# (a) Probability of a patient recovering in 10 or less days
result_a <- ppois(10, lambda_hat)
print(result_a)

# (b) Three most likely number of days to recover
order(table(days_until_recovery), decreasing = TRUE)[1:3]

# (c) Probability of combined total of 60 to 80 days for five individuals
individuals <- estimates$lambda_ml*5
result_c <- ppois(80,individuals) - ppois(59,individuals)
print(result_c)

# (d) Probability that three or more patients recover on or after day 14
result_d <- 1 - ppois(13, lambda_hat)
1 - pbinom(2, 5, result_d)

###############################################################
# Question 5 Question 3
###############################################################
# Calculate observed proportions for each number of days
observed_proportions <- table(days_until_recovery) / length(days_until_recovery)

# Calculate predicted probabilities using lambda_hat
predicted_probs <- dpois(0:40, lambda_hat)

# Plot the observed proportions and predicted probabilities
plot(0:40, predicted_probs, type = "l", col = "blue", xlab = "Days to Recovery", ylab = "Proportion / Probability")
lines(observed_proportions, col = "red")
legend("topright", c("Observed Proportions", "Predicted Probabilities"), col = c("blue", "red"), lty=1, cex=0.5)

# Add a title
title(main = "Observed Proportions vs. Predicted Probabilities for Days to Recovery")




