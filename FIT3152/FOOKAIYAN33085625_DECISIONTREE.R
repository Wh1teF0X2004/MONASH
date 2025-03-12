rm(list=ls()) 

setwd("C:/Monash/FIT3152")

library(tree)
library(ROCR)
library(dplyr)
library(tidyr)
library(e1071)
library(ipred)
library(adabag)
library(ggpubr)
library(ggplot2)
library(reshape)
library(corrplot)
library(neuralnet)
library(factoextra)
library(randomForest)

rm(list = ls())
Phish <- read.csv("PhishingData.csv")
set.seed(33085625) 
L <- as.data.frame(c(1:50))
L <- L[sample(nrow(L), 10, replace = FALSE),]
Phish <- Phish[(Phish$A01 %in% L),]
PD <- Phish[sample(nrow(Phish), 2000, replace = FALSE),] # sample of 2000 rows

as.data.frame(table(PD["Class"]))

str(PD)
summary(PD)

PD = data.frame(PD)
PD$Class = factor(PD$Class)
PD_na_free = PD[complete.cases(PD),]
# PD_na_free = na.omit(PD)
dim(PD_na_free)
str(PD_na_free)

set.seed(33085625) 
train.row = sample(1:nrow(PD_na_free), 0.7*nrow(PD_na_free))
PD_na_free.train = PD_na_free[train.row,]
PD_na_free.test = PD_na_free[-train.row,]
str(PD_na_free.test)

# Question 4
decision_tree_model = tree(Class ~., data = PD_na_free.train)
decision_tree_model
summary(decision_tree_model)

# Question 5 
# Predict using the testing dataset after training the model
predict_decision_tree = predict(decision_tree_model, newdata = PD_na_free.test, type = "class")
# Evaluating the model performance
# Decision Tree Confusion Matrix
result_decision_tree = table(actual = PD_na_free.test$Class, prediction = predict_decision_tree)
colnames(result_decision_tree) = c("legitimate", "phishing")
rownames(result_decision_tree) = c("legitimate", "phishing")
result_decision_tree
# Evaluating the model accuracy
decision_tree_accuracy = (result_decision_tree[2, 2] + result_decision_tree[1, 1]) / (result_decision_tree[2, 2] + result_decision_tree[1, 1] + result_decision_tree[2, 1] + result_decision_tree[1, 2])
decision_tree_accuracy

# Question 6 method 1:
confidence_decision_tree = predict(decision_tree_model, newdata = PD_na_free.test, type = "vector")
prediction_decision_tree = prediction(confidence_decision_tree[, 2], PD_na_free.test$Class) # Error here: Error in nn$covariate : $ operator is invalid for atomic vectors
performance_decision_tree = performance(prediction_decision_tree, "tpr", "fpr")

# Question 6 method 2:
confidence_decision_tree = predict(decision_tree_model, PD_na_free.test, type = "vector")
confidence_decision_tree = cbind(PD_na_free.test, confidence_decision_tree)
is.atomic(confidence_decision_tree)
is.atomic(PD_na_free.test)
is.vector(confidence_decision_tree)
is.vector(PD_na_free.test)
prediction_decision_tree = prediction(confidence_decision_tree[, ncol(confidence_decision_tree)], PD_na_free.test$Class)
prediction_decision_tree
performance_decision_tree = performance(prediction_decision_tree, "tpr", "fpr")
performance_decision_tree