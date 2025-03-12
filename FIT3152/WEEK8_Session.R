D = diamonds
summary(D)
str(D)
colnames(D)

price_level = ifelse(D$price >= median(D$price), "High", "Low")
price_level

D = cbind(D, as.factor(price_level))
str(D)
colnames(D)[11] = "price_level"

## Q2
# 1. Split the data into 70% training and 30% testing data sets. 
# 2. Fit a decision tree  model to predict the price_level of diamonds and
# 3. check accuracy using a  confusion matrix.

#! 1. partition 70% of the rows for training and 30% of the rows for testing data sets.
set.seed(9999)

# randomly sample 70% of D
train.row = sample(1:nrow(D),0.7*nrow(D)) 
train.row # number appear is the number of the row

D.train = D[train.row,] # create train data 
D.test = D[-train.row,] # create testing data 

#! 2. Fit a decision tree  model to predict the price_level of diamonds
library(tree) # predicting base on everything except for price
D.fit = tree(price_level ~ . -price, data=D.train)
summary(D.fit)
plot(D.fit)
text(D.fit, pretty = 0) # pretty = 0 means that the text tables will not be formatted

#! 3. check accuracy using a confusion matrix with test data.
# (correct + correct) / total from matrix
D.predict = predict(D.fit,D.test, type="class") 
# type = class indicates it returns the predicted class labels
table(actual = D.test$price_level, predict = D.predict)

## Q3
#! 1. partition 70% of the rows for training and 30% of the rows for testing data sets.
#set.seed(9999)

# randomly sample 70% of D
#train.row = sample(1:nrow(D),0.7*nrow(D)) 
#train.row # number appear is the number of the row

#D.train = D[train.row,] # create train data 
#D.test = D[-train.row,] # create testing data 

#! 2. Fit a decision tree  model to predict the price_level of diamonds
library(tree) # predicting base on everything except for price
D.fit = tree(price_level ~ carat+cut+color+ clarity, data=D.train)
summary(D.fit)
plot(D.fit)
text(D.fit, pretty = 0) # pretty = 0 means that the text tables will not be formatted

#! 3. check accuracy using a confusion matrix with test data.
# (correct + correct) / total from matrix
D.predict = predict(D.fit,D.test, type="class") 
# type = class indicates it returns the predicted class labels
table(actual = D.test$price_level, predict = D.predict)

# In a decision tree, a pure branch refers to a branch (or subtree) that contains only one class or label. 
# In other words, all the instances (data points) within that branch belong to the same category.
# Slide 4 pure branch: color is red and green, size is big
# SO colour is the root node
# Hence, color is on top top of decision tree