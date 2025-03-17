# Install necessary package
#install.packages("tidygeocoder")

# Load the required library
library(tidygeocoder)

# Load necessary libraries
library(dplyr)

# Set working directory
setwd("C:/Users/Nicol Foo/Downloads")

# Load the dataset 
df <- read.csv("arrivals_soe.csv")

# Display the first few rows to understand the dataset structure
head(df)

# Extract the unique states in the dataset
unique_states <- unique(df$soe)

# Print the list of unique states
print(unique_states)

# Create a dataframe of Malaysian states with their latitudes and longitudes
state_coordinates <- data.frame(
  soe = c("Kedah", "Pulau Pinang", "Johor", "Perlis", "Sarawak", "Selangor", 
            "Sabah", "Perak", "Kelantan", "Melaka", "W.P. Labuan", "Negeri Sembilan", 
            "Pahang", "Terengganu"),
  lat = c(6.1184, 5.4164, 1.4927, 6.4448, 1.5533, 3.0738, 5.9788, 4.5921, 
          5.2853, 2.1896, 5.2831, 2.7258, 3.8126, 5.3117),
  long = c(100.3685, 100.3327, 103.7414, 100.2048, 110.3592, 101.5183, 116.0753, 
           101.0901, 102.0594, 102.2501, 115.2308, 101.9424, 103.3256, 103.1324)
)

# Merge the coordinates with your dataset based on the 'soe' column
df_with_coords <- df %>%
  left_join(state_coordinates, by = "soe")

# Save the updated dataframe with coordinates to a new CSV file
write.csv(df_with_coords, "arrivals_with_coords.csv", row.names = FALSE)

# Display the first few rows of the updated dataframe
head(df_with_coords)