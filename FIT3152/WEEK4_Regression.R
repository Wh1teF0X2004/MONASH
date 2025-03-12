# Clean up the environment before starting
rm(list = ls())

# Toothbrush example
Toothbrush <- read.csv("Toothbrush.csv")
attach(Toothbrush) # note ‘attach’ function
plot(Price, Function)
fit = lm(Function ~ Price) # regression of y on x
fit
plot(Price, Function)
abline(fit)
attributes(fit)
fit$residuals
fit$coefficients[1]
fit$coefficients[2]
hist(fit$residuals)
qqnorm(fit$residuals)
qqline(fit$residuals)
plot(Price, fit$residuals)
par(mfrow =c(2,2)) # creates a 2 x 2 matrix for plots
plot(fit)
summary(fit)
predict.lm(fit, newdata = data.frame(Price=c(6,7,8)), int="conf")

# Clean up the environment again
# Concrete example
rm(list = ls())
Concrete <- read.csv("Concrete_regression.csv")
attach(Concrete)

# pairwise correlation calculations
#round(cor(Concrete[,1:8],Concrete$Strength), digits = 3)
round(cor(Concrete[,1:8],Concrete[,9]), digits = 3)

par(mfrow = c(2, 4))
for (i in 1:8) {
  plot(Concrete[,i],Concrete$Strength)  
}

pdf("Concrete Plots.pdf", width=20, height=10)
par(mfrow = c(2, 4))
for (i in 1:8) {
  plot(Concrete$Cement,Concrete$Strength)  
  plot(Concrete$Slag,Concrete$Strength)  
  plot(Concrete$Ash,Concrete$Strength)  
  plot(Concrete$Water,Concrete$Strength)  
  plot(Concrete$Plas,Concrete$Strength)  
  plot(Concrete$CA,Concrete$Strength)  
  plot(Concrete$FA,Concrete$Strength)  
  plot(Concrete$Age,Concrete$Strength)  
}
dev.off()


fit <- lm(Strength ~ Cement + Water)
fit
summary(fit)

# 3D Plot Demo
#install.packages("scatterplot3d") to do the 3D plot
# library(scatterplot3d)
# sur <-scatterplot3d(Water, Cement, Strength, pch=16)
# fit <- lm(Strength ~ Water + Cement) 
# sur$plane3d(fit)



# Now fit to all the data and build new model
fit <- lm(Strength ~ . , data = Concrete) # note “.” = all
fit
summary(fit)


# Clean up the environment again
rm(list = ls())
library(ggplot2)
set.seed(9999) # Random seed
dsmall <- diamonds[sample(nrow(diamonds), 1000), ] # sample of 1000 rows

g = ggplot(data = dsmall, aes(x = carat, y = price, colour = color, size = clarity, alpha = cut)) + geom_point()
g
ggsave("Diamonds Raw All Colour.pdf", g, width = 20, height = 20, units = "cm")

g = ggplot(data = dsmall, aes(x = log(carat), y = log(price), colour = color, size = clarity, alpha = cut)) + geom_point()
g
ggsave("Diamonds Log All Colour.pdf", g, width = 20, height = 20, units = "cm")

g = ggplot(data = dsmall, aes(x = log(carat), y = log(price), size = clarity)) + geom_point()
g
ggsave("Diamonds Log BW.pdf", g, width = 20, height = 20, units = "cm")

attach(dsmall)
contrasts(clarity) = contr.treatment(8) # 8 levels
d.fit <- lm(log(price) ~ log(carat) + clarity)
d.fit
# making the page width a bit narrower for a better fit
options(width = 50)
d.fit
# back to a wider page
options(width = 60)
summary(d.fit)
contrasts(clarity)

g = ggplot(data = dsmall, aes(x = log(carat), y = log(price), size = clarity)) + geom_point() + geom_abline(intercept = 7.8, slope = 1.8)
g
ggsave("Diamonds Fitted BW.pdf", g, width = 20, height = 20, units = "cm")

