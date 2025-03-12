setwd("C:/Monash/FIT3152")

rm(list = ls())
set.seed(33085625) #random seed
J <- read.csv("PhishingData.csv")

library(tree)
library(rpart)
library(ROCR)
library(e1071)
library(ipred)
library(adabag)
library(corrplot)
library(factoextra)
library(randomForest)

L = as.data.frame(c(1:50))
L = L[sample(nrow(L), 10, replace = FALSE), ]

J = J[(J$A01 %in% L), ]
PD = J[sample(nrow(J), 2000, replace = FALSE), ]

# delete rows with missing values
PD = PD[complete.cases(PD),]
str(PD)
PD$Class = as.factor(PD$Class)
str(PD)

train.row = sample(1:nrow(PD), 0.7*nrow(PD))
PD.train = PD[train.row,]
PD.test = PD[-train.row,]

# Calculate a decision tree
PD.tree = tree(Class ~., data = PD.train)
print(summary(PD.tree))
plot(PD.tree)
text(PD.tree, pretty = 0)

# do predictions as classes and draw a table
PD.predtree = predict(PD.tree, PD.test, type = "class")
t1=table(Predicted_Class = PD.predtree, Actual_Class = PD.test$Class)
cat("\n#Decision Tree Confusion\n")
print(t1)

# do predictions as probabilities and draw ROC
PD.pred.tree = predict(PD.tree, PD.test, type = "vector")
# computing a simple ROC curve (x-axis: fpr, y-axis: tpr)
# labels are actual values, predictors are probability of class
PDpred <- prediction( PD.pred.tree[,2], PD.test$Class)
PDperf <- performance(PDpred,"tpr","fpr")
plot(PDperf)
abline(0,1)
