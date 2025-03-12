setwd("C:/Monash/FIT3152")

# Function to print Fibonacci sequence up to n terms
fibonacci <- function(n) {
  # Initialize variables to store the first two terms of the sequence
  a <- 0
  b <- 1
  
  # Print the first two terms
  cat(a, b, sep = ", ")
  
  # Generate and print the remaining terms
  for (i in 3:n) {
    c <- a + b
    cat(", ", c)
    # Update variables for the next iteration
    a <- b
    b <- c
  }
}

# Define the number of terms you want in the sequence
n <- 10
# Call the function to print Fibonacci sequence up to n terms
fibonacci(n)

plot(1:n, fibonacci(n), type="b", 
     main = "Fibonacci Series",
     xlab = "Index",
     ylab = "Value")

source('11032024_Week3_Lecture.R')

# Reusability is high when script is used


aggregate(iris[1:4], iris[5], mean)


# Anonymous function cus no name is given and its just used to get the result
# Result is displayed like a dataframe by series
by(iris, iris[5], function(df) cor(df$Sepal.Length, df$Sepal.Width))
as.table(by(iris, iris[5], function(df) cor(df[1], df[2])))

# Can just use as.data.frame without casting to a table as.table?
as.data.frame(as.table(by(iris, iris[5], function(df) cor(df[1], df[2]))))
as.data.frame(by(iris, iris[5], function(df) cor(df[1], df[2])))
# Can but the display format is different. No index and no column headers.

# Assuming 'A' is a vector containing the attribute values
# MaxA <- max(A)
# MinA <- min(A)
# Normalize the values of A
# ANormalized <- (A - MinA) / (MaxA - MinA)



# testing
setwd("C:/Monash/FIT3152")
coronaa = read.csv("PsyCoronaBaselineExtractTest.csv", header = TRUE)
coronaa$employee_status <- apply(coronaa[, 1:10], 1, function(row) {
  non_na_indices <- which(!is.na(row))
  if (length(non_na_indices) > 0) {
    paste(non_na_indices, collapse = ", ")
  } else {
    NA
  }
})
head(coronaa$employee_status)

#coronaa$corona_close_contact <- NA
close_contact_column <- c("coronaClose_1", "coronaClose_2", "coronaClose_3", "coronaClose_4", "coronaClose_5", "coronaClose_6")
coronaa$corona_close <- NA
coronaa$corona_close <- apply(coronaa[, close_contact_column], 1, function(row) {
  not_na <- which(!is.na(row))
  if (length(not_na) > 0) {
    paste(not_na, collapse = ", ")
  } else {
    NA
  }
})
coronaa$corona_close
head(coronaa[c("employment_status", "corona_close")])

# Removing the columns
coronaa = subset(coronaa, select = -c(employstatus_1, employstatus_2, employstatus_3, employstatus_4, employstatus_5, employstatus_6, employstatus_7, employstatus_8, employstatus_9, employstatus_10))
coronaa = subset(coronaa, select = -c(coronaClose_1, coronaClose_2, coronaClose_3, coronaClose_4, coronaClose_5, coronaClose_6))

library(ggplot2)
library(dplyr)
library(tidyr)

# Group 1 --> Participants from Malaysia
msia = coronaa %>% filter(coded_country == "Malaysia")
dim(msia)
# Group 2 --> Participants not from Malaysia
not_msia = coronaa %>% filter(coded_country != "Malaysia")
dim(not_msia)

prosocial <- coronaa[, c("coded_country", "c19ProSo01", "c19ProSo02", "c19ProSo03", "c19ProSo04")]
prosocial

# Filter rows where coded_country is "malaysia"
prosocial_msia <- prosocial[prosocial$coded_country == "Malaysia", ]
prosocial_msia

# Filter rows where coded_country is not "malaysia"
prosocial_not_msia <- prosocial[prosocial$coded_country != "Malaysia", ]
prosocial_not_msia

c19ProSo01_count_values <- table(prosocial_msia$c19ProSo01)
c19ProSo01_count_values

c19ProSo02_count_values <- table(prosocial_msia$c19ProSo02)
c19ProSo02_count_values

c19ProSo03_count_values <- table(prosocial_msia$c19ProSo03)
c19ProSo03_count_values

c19ProSo04_count_values <- table(prosocial_msia$c19ProSo04)
c19ProSo04_count_values

# not msia c19ProSo01
c19ProSo01_count_values <- table(prosocial_not_msia$c19ProSo01)
c19ProSo01_count_values

# not msia c19ProSo02
c19ProSo02_count_values <- table(prosocial_not_msia$c19ProSo02)
c19ProSo02_count_values

# not msia c19ProSo03
c19ProSo03_count_values <- table(prosocial_not_msia$c19ProSo03)
c19ProSo03_count_values

# not msia c19ProSo04
c19ProSo04_count_values <- table(prosocial_not_msia$c19ProSo04)
c19ProSo04_count_values

typeof(coronaa)
str(msia)
msia_q2b <- msia
msia_q2b = subset(msia_q2b, select = -c(rankOrdLife_1, rankOrdLife_2, rankOrdLife_3, rankOrdLife_4, rankOrdLife_5, rankOrdLife_6, coded_country, employee_status, corona_close))

# Fit the linear model for c19ProSo01
c19ProSo01_best <- lm(c19ProSo01 ~., data = msia_q2b)
# Extract coefficients and p-values
c19ProSo01_best_summary <- summary(c19ProSo01_best)$coefficients
# Find significant predictors (p-value < 0.05)
c19ProSo01_significant_predictors <- c19ProSo01_best_summary[c19ProSo01_best_summary[, "Pr(>|t|)"] < 0.05, ]
# Sort predictors by absolute coefficient magnitude (significant)
c19ProSo01_strongest_predictors <- c19ProSo01_significant_predictors[order(abs(c19ProSo01_significant_predictors[, "Pr(>|t|)"]), decreasing = FALSE), ]
# Display the three highest/strongest predictors (those with ***)
c19ProSo01_strongest_predictors[1:2, ]
summary(c19ProSo01_best)

c19ProSo02_best <- lm(c19ProSo02 ~., data = msia_q2b)
c19ProSo02_best_summary <- summary(c19ProSo02_best)$coefficients
c19ProSo02_significant_predictors <- c19ProSo02_best_summary[c19ProSo02_best_summary[, "Pr(>|t|)"] < 0.05, ]
c19ProSo02_strongest_predictors <- c19ProSo02_significant_predictors[order(abs(c19ProSo02_significant_predictors[, "Pr(>|t|)"]), decreasing = FALSE), ]
c19ProSo02_strongest_predictors[1:2, ]

c19ProSo03_best <- lm(c19ProSo03 ~., data = msia_q2b)
c19ProSo03_best_summary <- summary(c19ProSo03_best)$coefficients
c19ProSo03_significant_predictors <- c19ProSo03_best_summary[c19ProSo03_best_summary[, "Pr(>|t|)"] < 0.05, ]
c19ProSo03_strongest_predictors <- c19ProSo03_significant_predictors[order(abs(c19ProSo03_significant_predictors[, "Pr(>|t|)"]), decreasing = FALSE), ]
c19ProSo03_strongest_predictors[1:2, ]

c19ProSo04_best <- lm(c19ProSo04 ~., data = msia_q2b)
c19ProSo04_best_summary <- summary(c19ProSo04_best)$coefficients
c19ProSo04_significant_predictors <- c19ProSo04_best_summary[c19ProSo04_best_summary[, "Pr(>|t|)"] < 0.05, ]
c19ProSo04_strongest_predictors <- c19ProSo04_significant_predictors[order(abs(c19ProSo04_significant_predictors[, "Pr(>|t|)"]), decreasing = FALSE), ]
c19ProSo04_strongest_predictors[1:2, ]





















# Create a bar chart for Malaysia
ggplot(prosocial_msia, aes(x = prosocial_measure, y = value)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Prosocial Measures in Malaysia",
       x = "Prosocial Measure",
       y = "Value") +
  theme_minimal()

# Create a bar chart for other countries
ggplot(prosocial_not_msia, aes(x = prosocial_measure, y = value)) +
  geom_bar(stat = "identity", fill = "salmon") +
  labs(title = "Prosocial Measures in Other Countries",
       x = "Prosocial Measure",
       y = "Value") +
  theme_minimal()












for (i in 1:nrow(coronaa)){
  if(!is.na(coronaa[i, "employstatus_1"])){
    coronaa$employment_status[i] <- append(coronaa$employment_status[i], 1)
  } 
  if(!is.na(coronaa[i, "employstatus_2"])){
    coronaa$employment_status[i] <- append(coronaa$employment_status[i], 2)
  } 
  if(!is.na(coronaa[i, "employstatus_3"])){
    coronaa$employment_status[i] <- append(coronaa$employment_status[i], 3)
  } 
  if(!is.na(coronaa[i, "employstatus_4"])){
    coronaa$employment_status[i] <- append(coronaa$employment_status[i], 4)
  } 
  if(!is.na(coronaa[i, "employstatus_5"])){
    coronaa$employment_status[i] <- append(coronaa$employment_status[i], 5)
  } 
  if(!is.na(coronaa[i, "employstatus_6"])){
    coronaa$employment_status[i] <- append(coronaa$employment_status[i], 6)
  } 
  if(!is.na(coronaa[i, "employstatus_7"])){
    coronaa$employment_status[i] <- append(coronaa$employment_status[i], 7)
  } 
  if(!is.na(coronaa[i, "employstatus_8"])){
    coronaa$employment_status[i] <- append(coronaa$employment_status[i], 8)
  } 
  if(!is.na(coronaa[i, "employstatus_9"])){
    coronaa$employment_status[i] <- append(coronaa$employment_status[i], 9)
  } 
  if(!is.na(coronaa[i, "employstatus_10"])){
    coronaa$employment_status[i] <- append(coronaa$employment_status[i], 10)
  } 
}
