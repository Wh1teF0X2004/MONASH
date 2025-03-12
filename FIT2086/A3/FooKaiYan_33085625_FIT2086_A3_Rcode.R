################################################################################
#       Student Name: Foo Kai Yan
#       Student ID: 33085625
#       Student Email: kfoo0012@student.monash.edu
################################################################################

##################################################################
# Assignment 3 Question 1.1
##################################################################
# Load the given data
housing_data <- read.csv("housing.2023.csv")

# summary() used to examine the data set
summary(housing_data)

# Fit a multiple linear model
housing_multiple_linear_model <- lm(medv ~ ., data = housing_data)

# Summary of the linear model
summary(housing_multiple_linear_model)

# Extract coefficients and p-values
coefficients_summary <- summary(housing_multiple_linear_model)$coefficients

# Find significant predictors (p-value < 0.05)
significant_predictors <- coefficients_summary[coefficients_summary[, "Pr(>|t|)"] < 0.05, ]

# Sort predictors by absolute coefficient magnitude (significant)
strongest_predictors <- significant_predictors[order(abs(significant_predictors[, "Pr(>|t|)"]), decreasing = FALSE), ]

# Display the significant predictors (those with *)
significant_predictors
# Display the three highest/strongest predictors (those with ***)
strongest_predictors[1:3, ]

##################################################################
# Assignment 3 Question 1.2
##################################################################
# Define the significant level (α) and the number of predictors (p)
alpha <- 0.05
num_predictors <- length(coefficients_summary[, "Pr(>|t|)"])

# Calculate the Bonferroni-corrected significance level
alpha_bonferroni <- alpha / num_predictors

# Identify significant predictors using Bonferroni correction
significant_predictors_bonferroni <- coefficients_summary[coefficients_summary[, "Pr(>|t|)"] <= alpha_bonferroni, ]

# Display the significant predictors with Bonferroni correction
significant_predictors_bonferroni

##################################################################
# Assignment 3 Question 1.3
##################################################################
# Find the coefficient for 'crim'
coefficient_crim <- coefficients_summary["crim", "Estimate"]
coefficient_crim
# An increase in the per-capita crime rate is associated with a decrease in median house price.

# Find the coefficient for 'chas'
coefficient_chas <- coefficients_summary["chas", "Estimate"]
coefficient_chas
# Having frontage on the Charles River is associated with an increase in median house price.

##################################################################
# Assignment 3 Question 1.4
##################################################################
# Perform stepwise selection with BIC
stepwise_selection_model <- step(housing_multiple_linear_model, k = log(nrow(housing_data)), direction = "both")
stepwise_selection_model
# Display the final model summary
summary(stepwise_selection_model)

##################################################################
# Assignment 3 Question 1.5
##################################################################
# No Code

##################################################################
# Assignment 3 Question 1.6
##################################################################
new_suburb_data <- data.frame(
  crim = 0.04741,
  zn = 0,
  indus = 11.93,
  chas = 0,
  nox = 0.573,
  rm = 6.03,
  age = 80.8,
  dis = 2.505,
  rad = 1,
  tax = 273,
  ptratio = 21,
  lstat = 7.88
)

# Predict the median house price for the new suburb using the stepwise selection model
predicted_price <- predict(stepwise_selection_model, newdata = new_suburb_data)

# Calculate the confidence interval
confidence_interval <- predict(stepwise_selection_model, newdata = new_suburb_data, interval = "confidence")

# Extract the lower and upper bounds of the confidence interval
lower_bound <- confidence_interval[, "lwr"]
lower_bound
upper_bound <- confidence_interval[, "upr"]
upper_bound

##################################################################
# Assignment 3 Question 1.7
##################################################################
# Fit a linear model with an interaction term
interaction_model <- lm(medv ~ rm * dis, data = housing_data)

# Summary of the interaction model
summary(interaction_model)

################################################################################
################################################################################
################################################################################

##################################################################
# Assignment 3 Question 2.1
##################################################################
# Classification problem; Presence of heart disease (HD)
# Load the rpart package used in Studio 9
library(rpart)
library(pROC)

# Load the given data
heart_train_data <- read.csv("heart.train.2023.csv")

# Load wrapper which is used to make some function usage easier
source("wrappers.R")

# summary() used to examine the data set
summary(heart_train_data)

# Load the required libraries
library(rpart)

# Fit a decision tree to the heart training data
heart_train_data_decision_tree <- rpart(HD ~ ., data = heart_train_data)
heart_train_data_decision_tree

# Visualize the decision tree
plot(heart_train_data_decision_tree)
text(heart_train_data_decision_tree, digits = 3)

# Show the importance of each Variable
Variable_importance_scores <- heart_train_data_decision_tree$variable.importance / max(heart_train_data_decision_tree$variable.importance)
Variable_importance_scores

# Cross validation
heart_train_data_cross_validation <- learn.tree.cv(HD ~ ., data = heart_train_data, nfolds = 10, m = 5000)
heart_train_data_cross_validation
plot.tree.cv(heart_train_data_cross_validation)

# Get the best tree
best_tree <- heart_train_data_cross_validation$best.tree
best_tree

# The asterisk (*) denotes terminal nodes, which are also known as leaf nodes.

##################################################################
# Assignment 3 Question 2.2
##################################################################
# Plot the tree found by cross validation
# Cross validation done in 2.1 is stored in the variable heart_train_data_cross_validation
plot(best_tree, margin=0.2,uniform=T)
text(heart_train_data_cross_validation$best.tree,pretty=12)

##################################################################
# Assignment 3 Question 2.3
##################################################################
# Obtain the blank tree to be annotated
plot(best_tree, margin=0.2,uniform=T)

##################################################################
# Assignment 3 Question 2.4
##################################################################
best_tree
# Leaf node 7 has the highest Y value 
# Y is the probability of having heart-disease

##################################################################
# Assignment 3 Question 2.5
##################################################################
# HD is not in binary data as shown with this code
unique(heart_train_data$HD)

# Re-code "N" to 0 and "Y" to 1 in the 'HD' column
# This is because we want to use family = binomial in glm
heart_train_data$HD <- ifelse(heart_train_data$HD == "N", 0, 1)

# Check if it is all modified to only 0 and 1
unique(heart_train_data$HD)

# Fit the logistic regression model
heart_train_logistiC_regression_model <- glm(HD ~ ., data = heart_train_data, family = binomial)
heart_train_logistiC_regression_model

# Use stepwise selection with the BIC score to prune the logistic regression model
stepwise_selection_model_BIC <- step(heart_train_logistiC_regression_model, k = log(length(heart_train_data$HD)), direction="both")
stepwise_selection_model_BIC

##################################################################
# Assignment 3 Question 2.6
##################################################################
# Written 
glm(formula = HD ~ CP + THALACH + OLDPEAK + CA + THAL, family = binomial, 
    data = heart_train_data)

##################################################################
# Assignment 3 Question 2.7
##################################################################
# Load the given data
heart_test_data <- read.csv("heart.test.2023.csv", stringsAsFactors = T)

# Load my.prediction.stats.R to use my.pred.stats() function
source("my.prediction.stats.R")

# Compute the prediction statistics for both tree and step-wise logistic regression model on heart_test_data
stepwise_selection_model_BIC
best_tree

# Fit a logistic regression model to the training data
heart_train_logistiC_regression_model_q2_7 <- glm(HD ~ ., data = heart_train_data, family = binomial)
heart_train_logistiC_regression_model_q2_7

# Make predictions on the test data
heart_test_data_predictions <- predict(heart_train_logistiC_regression_model_q2_7, newdata = heart_test_data, type = "response")
heart_test_data_predictions_tree <- predict(best_tree, newdata = heart_test_data)

# Calculate prediction statistics using the provided function
heart_test_data_prediction_stats <- my.pred.stats(heart_test_data_predictions, heart_test_data$HD)
heart_test_data_prediction_stats_tree <- my.pred.stats(heart_test_data_predictions_tree[,2], heart_test_data$HD)

##################################################################
# Assignment 3 Question 2.8a
##################################################################
# Cross validation (test data)
heart_test_data_cross_validation <- learn.tree.cv(HD ~ ., data = heart_test_data, nfolds = 10, m = 5000)
heart_test_data_cross_validation
plot.tree.cv(heart_test_data_cross_validation)

# Get the decision tree (test data)
heart_test_data_decision_tree_odds <- predict(best_tree, newdata = heart_test_data, type = "prob")[,2]
heart_test_data_decision_tree_odds

# 69th patient in the test dataset odds
heart_test_data_decision_tree_odds_69 <- heart_test_data_decision_tree_odds[69]
heart_test_data_decision_tree_odds_69

##################################################################
# Assignment 3 Question 2.8b
##################################################################
# Logistic regression model
stepwise_selection_model_BIC_2_8b <- step(heart_train_logistiC_regression_model, k = log(nrow(heart_train_data)), direction = "both")
stepwise_selection_model_BIC_2_8b

# Get the predicted probability of having heart disease ("Y") for the 69th patient in the test dataset
prob_logistic_regression <- predict(stepwise_selection_model_BIC_2_8b, newdata = heart_test_data, type = "response")
prob_logistic_regression

prob_logistic_regression_69 <- prob_logistic_regression[69]
prob_logistic_regression_69

##################################################################
# Assignment 3 Question 2.9
##################################################################
# Load the Bootstrap package
library(boot)

# Define the modified boot.auc function from Studio10
boot_prob_heart_disease <- function(formula, heart_test_data, indices) {
  # Create a bootstrapped version of heart_test_data
  booted = heart_test_data[indices, ]
  # Fit a logistic regression to the bootstrapped data
  booted_logistic_regresion = glm(formula, booted, family = binomial)
  # Calculate the predicted probabilities for the 69th patient
  predicted_probability = predict(booted_logistic_regresion, newdata = heart_test_data[69, ], type = "response")
  
  return(predicted_probability)
}

bootstrap <- boot(data = heart_test_data, statistic = boot_prob_heart_disease, R = 5000, formula = HD ~ .)
bootstrap

boot.ci(bootstrap, conf = 0.95, type = "bca")

################################################################################
################################################################################
################################################################################

##################################################################
# Assignment 3 Question 3.1
##################################################################
# Load the kknn package
library(kknn)
# Load the Bootstrap package
library(boot)

# Load the given data
ms_measured <- read.csv("ms.measured.2023.csv")
ms_truth <- read.csv("ms.truth.2023.csv")
mean_square_error <- numeric(length = 25)

# Loop through k from 1 to 25
for (k in 1:25) {
  # Fit k-NN model
  knn_model <- fitted(kknn(intensity ~ ., ms_measured, ms_truth, k = k, kernel = "optimal"))
  # Compute the mean-squared error
  mse <- mean((knn_model - ms_truth$intensity)^2)
  # Store the MSE value for this value of k
  mean_square_error[k] <- mse
}

# Create a plot of MSE values against k
plot(1:25, mean_square_error, type = "b", xlab = "k", ylab = "Mean-Squared Error", main = "MSE vs. k in k-NN Smoothing")

##################################################################
# Assignment 3 Question 3.2
##################################################################
# (i) the training data points (ms_measured$intensity)
# (ii) the true spectrum (ms_truth$intensity)
# (iii) the estimated spectrum (predicted intensity values for the MZ values 
# in ms_truth) produced by the k-NN method for different k values
k_value = 2
knn_model <- fitted(kknn(intensity ~ ., ms_measured, ms_truth, k = k_value, kernel = "optimal"))
plot(ms_measured$MZ, ms_measured$intensity, type = "l", col = "blue", xlab = "MZ values", ylab = "Intensity", main = paste("k-NN Smoothing (k =", k_value, ")"))
lines(ms_truth$MZ, ms_truth$intensity, col = "green", lwd = 2)
lines(ms_truth$MZ, knn_model, col = "red", lwd = 2)
legend("topright", legend = c("True Spectrum", "Estimated Spectrum", "Training Data"),
       col = c("green", "red", "blue"), lty = c(1, 1, -1), pch = c(-1, -1, 16))

k_value = 5
knn_model <- fitted(kknn(intensity ~ ., ms_measured, ms_truth, k = k_value, kernel = "optimal"))
plot(ms_measured$MZ, ms_measured$intensity, type = "l", col = "blue", xlab = "MZ values", ylab = "Intensity", main = paste("k-NN Smoothing (k =", k_value, ")"))
lines(ms_truth$MZ, ms_truth$intensity, col = "green", lwd = 2)
lines(ms_truth$MZ, knn_model, col = "red", lwd = 2)
legend("topright", legend = c("True Spectrum", "Estimated Spectrum", "Training Data"),
       col = c("green", "red", "blue"), lty = c(1, 1, -1), pch = c(-1, -1, 16))

k_value = 10
knn_model <- fitted(kknn(intensity ~ ., ms_measured, ms_truth, k = k_value, kernel = "optimal"))
plot(ms_measured$MZ, ms_measured$intensity, type = "l", col = "blue", xlab = "MZ values", ylab = "Intensity", main = paste("k-NN Smoothing (k =", k_value, ")"))
lines(ms_truth$MZ, ms_truth$intensity, col = "green", lwd = 2)
lines(ms_truth$MZ, knn_model, col = "red", lwd = 2)
legend("topright", legend = c("True Spectrum", "Estimated Spectrum", "Training Data"),
       col = c("green", "red", "blue"), lty = c(1, 1, -1), pch = c(-1, -1, 16))

k_value = 25
knn_model <- fitted(kknn(intensity ~ ., ms_measured, ms_truth, k = k_value, kernel = "optimal"))
plot(ms_measured$MZ, ms_measured$intensity, type = "l", col = "blue", xlab = "MZ values", ylab = "Intensity", main = paste("k-NN Smoothing (k =", k_value, ")"))
lines(ms_truth$MZ, ms_truth$intensity, col = "green", lwd = 2)
lines(ms_truth$MZ, knn_model, col = "red", lwd = 2)
legend("topright", legend = c("True Spectrum", "Estimated Spectrum", "Training Data"),
       col = c("green", "red", "blue"), lty = c(1, 1, -1), pch = c(-1, -1, 16))

##################################################################
# Assignment 3 Question 3.3
##################################################################
k_value = 2
sqrt(mean((fitted(kknn(intensity ~ ., ms_measured, ms_truth, k = k_value, kernel = "optimal"))-ms_truth$intensity)^2))

k_value = 5
sqrt(mean((fitted(kknn(intensity ~ ., ms_measured, ms_truth, k = k_value, kernel = "optimal"))-ms_truth$intensity)^2))

k_value = 10
sqrt(mean((fitted(kknn(intensity ~ ., ms_measured, ms_truth, k = k_value, kernel = "optimal"))-ms_truth$intensity)^2))

k_value = 25
sqrt(mean((fitted(kknn(intensity ~ ., ms_measured, ms_truth, k = k_value, kernel = "optimal"))-ms_truth$intensity)^2))

##################################################################
# Assignment 3 Question 3.4
##################################################################
# No code

##################################################################
# Assignment 3 Question 3.5
##################################################################
# Perform cross-validation to find the best k
knn_cross_validate <- train.kknn(intensity ~ ., ms_measured, kmax = 25, kernel = "optimal")
best_k <- knn_cross_validate$best.parameters$k
best_k

mean_square_error

##################################################################
# Assignment 3 Question 3.6
##################################################################
knn_model_best <- fitted(kknn(intensity ~ MZ, ms_measured, ms_truth, k = best_k, kernel = "optimal"))
knn_model_best_noise <- ms_truth - knn_model_best 

sqrt(var(knn_model_best_noise))

##################################################################
# Assignment 3 Question 3.7
##################################################################
# Find the index of the maximum estimated abundance
index_of_max_abundance <- which.max(knn_model_best)  
index_of_max_abundance

# Find the MZ value corresponding to the maximum estimated abundance
MZ_of_max_abundance <- ms_truth$MZ[index_of_max_abundance]
MZ_of_max_abundance

##################################################################
# Assignment 3 Question 3.8
##################################################################
# Load the Bootstrap package
library(boot)

# 3.5 best_k
best_k_neighbours <- fitted(kknn(intensity~., ms_measured, ms_truth, kernel = 'optimal', k = best_k))
boot_max_best_k = function(formula, ms_truth, indices){
  # Create a bootstrapped version of ms_truth
  booted = ms_truth[indices, ]
  # Target = best_k
  target = ms_truth[which.max(best_k_neighbours),]
  mz = fitted(kknn(formula, booted, target, kernel = 'optimal', k = best_k))
  return(mz)
}

# best_k bootstrap
bootstrap_best_k <- boot(data = ms_truth, statistic = boot_max_best_k, R = 5000, formula = intensity ~ .)
bootstrap_best_k

# best_k confidence interval
boot.ci(bootstrap_best_k, conf = 0.95, type = "bca")

# k = 3 neighbours
k_three <- 3
three_k_neighbours <- fitted(kknn(intensity~., ms_measured, ms_truth, kernel = 'optimal', k = k_three))
boot_max_k_three = function(formula, ms_truth, indices){
  # Create a bootstrapped version of ms_truth
  booted = ms_truth[indices, ]
  # Target = k_three
  target = ms_truth[which.max(three_k_neighbours),]
  mz = fitted(kknn(formula, booted, target, kernel = 'optimal', k = k_three))
  return(mz)
}

# k_three bootstrap
bootstrap_k_three <- boot(data = ms_truth, statistic = boot_max_k_three, R = 5000, formula = intensity ~ .)
bootstrap_k_three

# k_three confidence interval
boot.ci(bootstrap_k_three, conf = 0.95, type = "bca")

# k = 20 neighbours
k_twenty <- 20
twenty_k_neighbours <- fitted(kknn(intensity~., ms_measured, ms_truth, kernel = 'optimal', k = k_twenty))
boot_max_k_twenty = function(formula, ms_truth, indices){
  # Create a bootstrapped version of ms_truth
  booted = ms_truth[indices, ]
  # Target = k_twenty
  target = ms_truth[which.max(twenty_k_neighbours),]
  mz = fitted(kknn(formula, booted, target, kernel = 'optimal', k = k_twenty))
  return(mz)
}

# best_k bootstrap
bootstrap_k_twenty <- boot(data = ms_truth, statistic = boot_max_k_twenty, R = 5000, formula = intensity ~ .)
bootstrap_k_twenty

# best_k confidence interval
boot.ci(bootstrap_k_twenty, conf = 0.95, type = "bca")