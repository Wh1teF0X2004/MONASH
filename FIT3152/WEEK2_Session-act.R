# Set working directory
setwd("C:/Monash/FIT3152")

library(lattice)
install.packages("ggplot2")

library(ggplot2)

head(iris)
tail(iris)
dim(iris)
names(iris)
str(iris)
?iris
summary(iris)

xyplot(Sepal.Length ~ Petal.Length | Species, 
       group = Species,
       data = iris,
       type = c("p", "smooth"),
       scales = "free")

################################################################################
################################################################################

? mpg

# Summary of the dataset
summary(mpg)

# Basic R graphics, ggplot not used
# (a) Scatterplot for relationship between city and highway fuel consumption
plot(mpg$cty, mpg$hwy, xlab = "City MPG", ylab = "Highway MPG", main = "City vs Highway Fuel Consumption")
# (b) Boxplot for fuel consumption by manufacturer
boxplot(cty ~ manufacturer, data = mpg, main = "Fuel Consumption by Manufacturer", xlab = "Manufacturer", ylab = "City MPG")
# (c) Scatterplot for fuel consumption vs. number of cylinders
plot(mpg$cyl, mpg$cty, xlab = "Number of Cylinders", ylab = "City MPG", main = "City MPG vs Number of Cylinders")
# (d) Scatterplot for fuel consumption vs. engine displacement
plot(mpg$displ, mpg$cty, xlab = "Engine Displacement", ylab = "City MPG", main = "City MPG vs Engine Displacement")
# (e) Non-graphical justification for fuel efficiency over time
# Calculate average city MPG by year
avg_mpg_by_year <- tapply(mpg$cty, mpg$year, mean)
plot(names(avg_mpg_by_year), avg_mpg_by_year, type = "l", xlab = "Year", ylab = "Average City MPG", main = "Average City MPG Over Time")

unique(avg_mpg_by_year)
a = as.data.frame(mpg[avg_mpg_by_year==1999, "hwy"])
b = as.data.frame(mpg[avg_mpg_by_year==2008, "hwy"])
t.test(a,b, "two.sided")

# ggplot used:
# (a) Scatterplot for relationship between city and highway fuel consumption
ggplot(mpg, aes(x = cty, y = hwy)) + 
  geom_point(color = "blue") + 
  labs(x = "City MPG", y = "Highway MPG", title = "City vs Highway Fuel Consumption")
# (b) Boxplot for fuel consumption by manufacturer
ggplot(mpg, aes(x = manufacturer, y = cty)) + 
  geom_boxplot(color = "blue") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = "Manufacturer", y = "City MPG", title = "Fuel Consumption by Manufacturer")
# (c) Scatterplot for fuel consumption vs. number of cylinders
ggplot(mpg, aes(x = cyl, y = cty)) +
  geom_point(color = "blue") +
  labs(x = "Number of Cylinders", y = "City MPG", title = "City MPG vs Number of Cylinders")
# (d) Scatterplot for fuel consumption vs. engine displacement
ggplot(mpg, aes(x = displ, y = cty)) +
  geom_point(color = "blue") +
  labs(x = "Engine Displacement", y = "City MPG", title = "City MPG vs Engine Displacement")
# (e) Non-graphical justification for fuel efficiency over time
ggplot(data = NULL, aes(x = as.numeric(names(avg_mpg_by_year)), y = avg_mpg_by_year)) +
  geom_line(color = "blue") +
  labs(x = "Year", y = "Average City MPG", title = "Average City MPG Over Time")
