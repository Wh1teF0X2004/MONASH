# Set working directory
setwd("C:/Monash/FIT3152")

# Load the given data
hourly_pedestrain_act_data_dec <- read.csv("Ped_Count_December_Long.csv")

################################################################################
################################################################################

# Basic summary of the data
summary(hourly_pedestrain_act_data_dec)
head(hourly_pedestrain_act_data_dec)
length(hourly_pedestrain_act_data_dec)
unique(hourly_pedestrain_act_data_dec$Sensor_Location)
# Install ggplot2 library
library(ggplot2)

# Histogram
# First, filter the data to only contain the 4 location
filtered_data <- hourly_pedestrain_act_data_dec[
  hourly_pedestrain_act_data_dec$Sensor_Location == "Melbourne.Central" |
    hourly_pedestrain_act_data_dec$Sensor_Location == "Southern.Cross.Station" |
    hourly_pedestrain_act_data_dec$Sensor_Location == "Southbank" |
    hourly_pedestrain_act_data_dec$Sensor_Location == "The.Arts.Centre", ]
filtered_data

# Plot the faceted histogram
ggplot(filtered_data, aes(x = Count)) + 
  geom_histogram(bins = 70, fill = "skyblue", color = "black") +  # Adjust the number of bins as needed
  facet_wrap(~ Sensor_Location, scales = "free_y") +  # Use scales = "free_y" to adjust y scales independently
  theme_minimal() + 
  labs(title = "Pedestrian Count Distribution by Location",
       x = "Pedestrian Count",
       y = "Frequency")

################################################################################
################################################################################

date_filtered_data <- hourly_pedestrain_act_data_dec[hourly_pedestrain_act_data_dec$Date == "31/12/2021",]

specific_locations_data <- date_filtered_data[
  date_filtered_data$Sensor_Location == "Melbourne.Central" |
    date_filtered_data$Sensor_Location == "Southern.Cross.Station" |
    date_filtered_data$Sensor_Location == "Southbank" |
    date_filtered_data$Sensor_Location == "The.Arts.Centre", ]

ggplot(specific_locations_data, aes(x = Hour, y = Count, group = Sensor_Location, color = Sensor_Location)) + 
  geom_line() + 
  geom_point() + # Adds points to the line plot for clarity
  facet_wrap(~ Sensor_Location, scales = "free_y") + # Separate plots for each location
  theme_minimal() +
  labs(title = "Hourly Pedestrian Count on 31st December 2021",
       x = "Hour of the Day",
       y = "Pedestrian Count")
