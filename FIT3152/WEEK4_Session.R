setwd("C:/Monash/FIT3152")

library(ggplot2)

colnames(mpg)

# Fit linear model to predict cty
cty_fit = lm(cty ~ manufacturer+model+displ+year+cyl+trans+drv+fl+class)
hwy_fit = lm(hwy ~ manufacturer+model+displ+year+cyl+trans+drv+fl+class)

summary(cty_fit)
# Based on the output, the model has 93% coefficient of determinatopm
# and very low p-value for significance in the overall regression model
summary(hwy_fit)

# 4a
set.seed(9999)
dsmall <- diamonds[sample(nrow(diamonds), 1000), ] 
# 4b
str(dsmall)
attach(dsmall)
# Contrast matrix
contrasts(cut) = contr.treatment(5)
contrasts(cut)
# First row is baseline in contrasts
contrasts(clarity) = contr.treatment(8)
contrasts(clarity)
contrasts(color) = contr.treatment(7)
contrasts(color)
#linear model
d_fit = lm(log(price) ~ log(carat) + color + cut + clarity)
summary(d_fit)

#Q5
body = read.csv("body.dat.csv")
#а)
t.test(body$Height[body$Gender == "Male"], body$Height[body$Gender == "Female"], "greater", conf.level= 0.95)
# or
attach(body) #you can call the column directly
t.test(Height[Gender == "Male"], Height[Gender == "Female"], "greater", conf.level= 0.95)

t.test(body$Weight[body$Gender == "Male"], body$Weight[body$Gender == "Female"], "greater", conf.level= 0.99)

attach(body)
t.test(Weight[Gender == "Male"], Weight[Gender == "Female"], "greater", conf.level= 0.99)

#c)
colnames(body) #there is no BMI column, there is no BMI data #add BMI column and calculate BMI values
body$BMI = body$Weight / (body$Height*body$Height)
attach(body) #you can call the column directly 
t.test( BMI[Gender == "Male"], BMI[Gender == "Female"], "greater", conf.level=0.99)

#d)
body = read.csv("body.dat.csv")
#create dataframe for males only
male = body[which(body$Gender=="Male"), ]
#remove the gender column
male$Gender = NULL
#create Im
male_fit = lm(Height ~ . , data=male)
#summary
summary(male_fit)
