# Define the PDF function
pdf <- function(x, s) {
  if (x > 0 && x < s) {
    return(2 * (s - x) / (s^2))
  } else {
    return(0)
  }
}

# Generate x values
x_vals <- seq(0, 3, length.out = 1000)

# Compute PDF values for s = 1 and s = 2
pdf_vals_s1 <- sapply(x_vals, function(x) pdf(x, s = 1))
pdf_vals_s2 <- sapply(x_vals, function(x) pdf(x, s = 2))

# Plot the PDF for s = 1
plot(x_vals, pdf_vals_s1, type = "l", col = "blue", xlim = c(0, 3),
     xlab = "x", ylab = "Probability Density",
     main = "Probability Density Function for s = 1")
grid()

# Create a new plot for s = 2
plot(x_vals, pdf_vals_s2, type = "l", col = "blue", xlim = c(0, 3),
     xlab = "x", ylab = "Probability Density",
     main = "Probability Density Function for s = 2")
grid()
