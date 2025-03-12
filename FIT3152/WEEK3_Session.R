# Set working directory
setwd("C:/Monash/FIT3152")

# Load the given data
hourly_pedestrian_act_data_dec <- read.csv("Ped_Count_December_Long.csv")

################################################################################
#                                 Pre-session                                  #
################################################################################
names(hourly_pedestrian_act_data_dec)

# Calculate average pedestrian activity by sensor location
avg_activity_by_location <- aggregate(Count ~ Sensor_Location, data = hourly_pedestrian_act_data_dec, FUN = mean)
# Find the top 5 locations
top_5_locations <- head(avg_activity_by_location[order(-avg_activity_by_location$Count), ], 5)
top_5_locations
# Find the bottom 5 locations
bottom_5_locations <- head(avg_activity_by_location[order(avg_activity_by_location$Count), ], 5)
bottom_5_locations

head(hourly_pedestrain_act_data_dec)

# Extract the hour from the timestamp
hourly_pedestrian_act_data_dec$Hour <- format(as.POSIXct(hourly_pedestrian_act_data_dec$Date), "%H")
# Calculate average pedestrian activity by hour
avg_activity_by_hour <- aggregate(Count ~ Hour, data = hourly_pedestrian_act_data_dec, FUN = mean)

# Find the top 5 hours
top_5_hours <- head(avg_activity_by_hour[order(-avg_activity_by_hour$Count), ], 5)
top_5_hours
# Find the bottom 5 hours
bottom_5_hours <- head(avg_activity_by_hour[order(avg_activity_by_hour$Count), ], 5)
bottom_5_hours

# Find the hour and location with highest average pedestrian activity
max_activity_location <- avg_activity_by_location$Sensor_Location[which.max(avg_activity_by_location$Count)]
max_activity_hour <- avg_activity_by_hour$Hour[which.max(avg_activity_by_hour$Count)]
cat("Hour and location with highest average pedestrian activity: Hour", max_activity_hour, "Location", max_activity_location)

# Find the hour and location with lowest average pedestrian activity
min_activity_location <- avg_activity_by_location$Sensor_Location[which.min(avg_activity_by_location$Count)]
min_activity_hour <- avg_activity_by_hour$Hour[which.min(avg_activity_by_hour$Count)]
cat("Hour and location with lowest average pedestrian activity: Hour", min_activity_hour, "Location", min_activity_location)

################################################################################
#                                  Session                                     #
################################################################################
# Question2 Skipped

# Question3
# Calculate the area of sepal and petal using the given approximation
iris$Sepal_Area <- iris$Sepal.Length * iris$Sepal.Width * pi / 4
iris$Sepal_Area
iris$Petal_Area <- iris$Petal.Length * iris$Petal.Width * pi / 4
iris$Petal_Area
# Scatterplot showing petal area vs sepal area, identifying each species
library(ggplot2)
ggplot(iris, aes(x = Sepal_Area, y = Petal_Area, color = Species)) +
  geom_point() +
  labs(x = "Sepal Area", y = "Petal Area", title = "Scatterplot: Petal Area vs Sepal Area")
# Find the largest petal and sepal measurements for each species
max_petal <- aggregate(Petal_Area ~ Species, data = iris, FUN = max)
max_sepal <- aggregate(Sepal_Area ~ Species, data = iris, FUN = max)
# Create a DataFrame to report the measurements
max_measurements_df <- data.frame(
  Species = max_petal$Species,
  Largest_Petal_Area = max_petal$Petal_Area,
  Largest_Sepal_Area = max_sepal$Sepal_Area
)
max_measurements_df

# Question4
body.dat = read.csv("body.dat.csv")
# By function inputs all the columns at once to the 3rd argument of by function i.e colMeans
# We can't use mean function here as it doesn't work on a dataframe.
# It will be only usefull to take means if the first argument is a vector instead of a dataframe
gender_means = by(body.dat[,-25], body.dat$Gender, colMeans)
# OR
# Alternatively if you want to use a function that accepts a column of a dataframe instead of the
# entire dataframe, you can use by function together with sapply and the funcion you want to apply
# on each column. For example;
# 4th argument i.e mean is used as argument of sapply function and
# sapply takes the dataframe and applies the mean function on each column one-by-one
gender_means = by(body.dat[,-25], body.dat$Gender, sapply, mean)
# Turn the output of by function into a dataframe
gender_means = do.call(rbind,gender_means)
gender_means = as.data.frame(gender_means)
# Take transpose to represent every point in the graph as a row
gender_means = t(gender_means)
# Transpose is a matrix operation so it returns a matrix.
# We turn it back into a data frame here.
gender_means = as.data.frame(gender_means)
# Create scatter plot with log10 of values
plot( log10(gender_means$Female), log10(gender_means$Male), main="Average
body measurements",
      xlab="Female (log10)", ylab="Male (log 10)", xlim=c(1, 2.3),
      ylim=c(1, 2.3))
# Add y=x line
abline(0,1)
# Annotate points
text(log10(gender_means$Female), log10(gender_means$Male),
     row.names(gender_means), cex=0.6, pos=4, col="red")

# Question5
DH = read.csv("Dunnhumby1-20.csv")
# Calculate the AveDelta and AveSpend
# again you can use df1 = by(DH[,c(3,4)], DH$customer_id, colMeans, na.rm=TRUE) instead
df1 = by(DH[,c(3,4)], DH$customer_id, sapply, mean, na.rm=TRUE)
df1 = do.call(rbind, df1)
df1 = as.data.frame(df1)
# Calculate the CorDeltaSpend
# Up to this point, we combined the output of by function into a dataframe using do.call(rbind,..)
# This time, we will be using as.table() function because every group in the output of by function
# only have one value -- basically number representing the correlation.
# We can't use rbind because rbind only works with dataframes or row of a dataframe. -- with 2 dimensional structures --
# But we can turn individual numbers into a table structure using as.table funciton as in this example.
df2 = by(DH, DH$customer_id, function(df) cor(df[,3], df[,4], use="complete.obs"))
df2 = as.data.frame(as.table(df2))
# Calculate N
df3 = by(DH, DH$customer_id, nrow)
df3 = as.data.frame(as.table(df3))
# Calculate RegSlope and RegInt
df4 = by(DH, DH$customer_id, function(df) lm(df$visit_spend ~
                                               df$visit_delta)$coefficients)
df4 = do.call(rbind, df4)
df4 = as.data.frame(df4)
# Combine all the columns into one dataframe
# We can do this using cbind as rows are alligned in all of the df1,df2,df3 and df4. We can see that they are all
# ordered based on customer_id. If that was not the case, we might needed to use merge() or order the dataframes
# then cbind to make sure matching rows are representing the same customer in each dataframe.
# Also, cbind the columns in the order that it is presented in the question.
final = cbind(df2[,1], df1[,1], df1[,2], df2[,2], df3[,2], df4[,2],
              df4[,1] )
# Rename the columns
colnames(final) = c("CustomerID", "AveDelta", "AveSpend", "CorDeltaSpend",
                    "N", "RegSlope", "RegInt")

# Question6
df = read.csv("govhackelectricitytimeofusedataset.csv")
# Extract Date and store as a new column
df$date = as.Date(df$End.Datetime, format = "%d/%m/%Y")
# Remove unnecassary columns
df = df[,c(1,7,3)]
# Count daily number of readings for each meter
# To group the data by 2 variables, we set the second argument as list of variables as below
daily_reading_count = by(df, list(df$CUSTOMER_KEY, df$date), nrow)
daily_reading_count = as.data.frame(as.table(daily_reading_count))
# Some days some of the meters doesn't have any reading and those returns NA.
# Hence, we can replace them with 0.
# Select the rows with nas then assign a 0 to them as follows
daily_reading_count[is.na(daily_reading_count$Freq),3] = 0
# Calculate daily total amount of daily consumption
daily_consumption = by(df$General.Supply.KWH, list(df$CUSTOMER_KEY, df$date), sum)
daily_consumption = as.data.frame(as.table(daily_consumption))
# Those 2 dataframes have identical number of rows and they are in the same order.
# Because we created them using the same dataframe and same grouping variable i.e list(df$CUSTOMER_KEY, df$date)
# Therefore, we can directly cbind their columns and rows will be matching.
final = cbind(daily_reading_count, daily_consumption[,3])
# Now we can select the daily readings that have total 48 readings as follows.
# P.S You might realise that all the NAs have 0 number of readings and this is the reason they are NAs
# and will be removed now.
final = final[final$Freq==48,]
# Print number of NAs in the total consumption
sum(is.na(final[,4]))
# Rename the columns
colnames(final) = c("meter","date","reading_count", "usage")
# Plot distribution of daily consumption for each household
boxplot(final$usage ~ final$meter)
