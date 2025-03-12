##################################################################
# Assignment 2 Question 2.1
##################################################################
# Define the exponential pdf
exp_pdf <- function(y, v) {
  exp(-exp(-v)*y - v)
}

# Define y values
y <- seq(0, 10, length.out=1000)

# Create an empty plot with temporarily no lines 
plot(NULL, 
     xlim = c(0, 10),
     ylim = c(0, 1),
     xlab = "y", 
     ylab = "p(y|v)", 
     main = "Exponential Probability Density Function")

# Add the lines for each value of v
# Probability density function for when v = 1
lines(y, exp_pdf(y, 1), col = "purple")
# Probability density function for when v = 0.5
lines(y, exp_pdf(y, 0.5), col = "blue")
# Probability density function for when v = 2
lines(y, exp_pdf(y, 2), col = "green")

# x-axis is y values
# y-axis is the probability density p(y|v)
# Insert the legend for the graph plot
legend("topright", 
       legend = c("v = 1", "v = 0.5", "v = 2"), 
       col = c("purple", "blue", "green"), 
       lty = 1)

########################## new

# Define the exponential pdf
exp_pdf <- function(y, v) {
  exp(-exp(-v)*y - v)
}

# Define y values
y <- seq(0, 10)

# Create an empty plot with temporarily no lines 
plot(NULL, 
     xlim = c(0, 10),
     ylim = c(0, 1),
     xlab = "y", 
     ylab = "p(y|v)", 
     main = "Exponential Probability Density Function")

# Add the lines for each value of v
# Probability density function for when v = 1
lines(y, exp_pdf(y, 1), col = "purple")
# Probability density function for when v = 0.5
lines(y, exp_pdf(y, 0.5), col = "blue")
# Probability density function for when v = 2
lines(y, exp_pdf(y, 2), col = "green")

# x-axis is y values
# y-axis is the probability density p(y|v)
# Insert the legend for the graph plot
legend("topright", 
       legend = c("v = 1", "v = 0.5", "v = 2"), 
       col = c("purple", "blue", "green"), 
       lty = 1)


#################### extra
# v containing 3 values: 1, 0.5 and 2
v <- c(1, 0.5, 2)
# Sequence of y values from 0 to 10
y <- seq(0, 10, length.out=1000)

# Probability density function for when v = 1
p1 <- exp(-v[1] + y*(-exp(-v[1])))
# Probability density function for when v = 0.5
p2 <- exp(-v[2] + y*(-exp(-v[2])))
# Probability density function for when v = 2
p3 <- exp(-v[3] + y*(-exp(-v[3])))

# Plot the probability density function with using v = 1
# v = 1 is labelled with the purple line
plot(y, p1, type="l", col="purple", xlab="y", ylab="p(y | v)", main="Probability Density Function p(y|v) = exp(-e^(-v)y-v)")
# v = 0.5 is labelled with the blue line
lines(y, p2, type="l", col="blue")
# v = 2 is labelled with the green line
lines(y, p3, type="l", col="green")

# x-axis is y values
# y-axis is the probability density p(y|v)
# Insert the legend for the graph plot
legend("topright", legend=c("v = 1", "v = 0.5", "v = 2"), col=c("purple", "blue", "green"), lty=1)



