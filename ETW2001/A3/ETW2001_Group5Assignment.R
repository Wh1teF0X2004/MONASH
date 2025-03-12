################################################################################
#                         ETW2001_Group Assignment                             #
#------------------------------------------------------------------------------#
#                         Unit Code    : ETW2001                               #
#                         Group Number : Group 5                               #
#                         Group Members: Foo Kai Yan, Alicia Quek,             #
#                                        Lau Li Shan, Eunice Lee               #
################################################################################
# Set Working Directory
setwd("C:/Users/User/OneDrive - Monash University/Desktop/ETW2001/Assignment/A3")

# Remove/Clean the environment
rm(list=ls()) 

# Load required libraries
library(tidyverse)
library(ggplot2)
library(tidyr)
library(dplyr)

# Load the provided datasets
amazon_sales <- read.csv("Amazon Sale Report.csv")
sale_report <- read.csv("Sale Report.csv")
may_2022 <- read.csv("May-2022.csv")
pl_march_2021 <- read.csv("P  L March 2021.csv")
international_sales <- read.csv("International sale Report.csv")

################################################################################
#                            Inspect datasets                                  #
#------------------------------------------------------------------------------#
################################################################################
# Understand the dimensions of the datasets (rows, columns)
dim(amazon_sales)
dim(sale_report)
dim(may_2022)
dim(pl_march_2021)
dim(international_sales)

# Understand the datatypes of the datasets
str(amazon_sales)
str(sale_report)
str(may_2022)
str(pl_march_2021)
str(international_sales)

# View the datasets to visually inspect the datasets
View(amazon_sales) 
View(sale_report)
View(may_2022)
View(pl_march_2021)
View(international_sales)

# Get Column Names
names(amazon_sales)
names(sale_report)
names(pl_march_2021)
names(may_2022)
names(international_sales)

# Get Summary Statistics of each datasets
summary(amazon_sales)
summary(sale_report)
summary(pl_march_2021)
summary(may_2022)
summary(international_sales)

# 1. Explain the size, structure, and distribution of the dataset.
# 2. summary() function provides a statistical summary of the datasets
# ^^^ minimum, maximum, median, mean, and quartiles for numerical data, and frequency counts for factors
# 3. Can assess the quality of the data: 
# identify missing values, and detect possible outliers or anomalies that may require data cleaning
# 4. By knowing the data types and structures I have information on I have to handle date-time data before any plotting or analysis
# 5. By reviewing the column names and the data types, I can know which columns might be relevant for the plotting or analysis 
# 6. I wanted to plot boxplot to look at the distribution of numerical attributes but 
# from str() it is known that most attributes are of chr datatype so I didn't plot

################################################################################
#                              Data cleaning                                   #
#------------------------------------------------------------------------------#
################################################################################
# Check for missing values for each datasets
# amazon_sales
amazon_sales_missing_values <- colSums(is.na(amazon_sales))
amazon_sales_missing_values
# sale_report
sale_report_missing_values <- colSums(is.na(sale_report))
sale_report_missing_values
# pl_march_2021
pl_march_2021_missing_values <- colSums(is.na(pl_march_2021))
pl_march_2021_missing_values
# may_2022
may_2022_missing_values <- colSums(is.na(may_2022))
may_2022_missing_values
# international_sales
international_sales_missing_values <- colSums(is.na(international_sales))
international_sales_missing_values

# From the code above we know that only amazon_sales and sale_report contain NA values
# Get names of columns that have missing values from amazon_sales
paste("The columns with missing values in amazon_sales are:", paste(names(amazon_sales)[amazon_sales_missing_values > 0], collapse=", "))
# Get names of columns that have missing values from sale_report
paste("Columns with missing values from sale_report is", names(sale_report)[sale_report_missing_values > 0])

# Remove rows with missing values for each datasets
amazon_sales_cleaned <- na.omit(amazon_sales)
sale_report_cleaned <- na.omit(sale_report)

# Confirm again on the presence of NA values
colSums(is.na(amazon_sales_cleaned))
colSums(is.na(sale_report_cleaned))

# Check for duplicates for each datasets
# Count the number of duplicate rows
# sale_report_cleaned
if (sum(duplicated(sale_report_cleaned)) == 0) {
  paste("There are no duplicate values in sale_report_cleaned")
} else {
  paste("Number of duplicate values in sale_report_cleaned:", sum(duplicated(sale_report_cleaned)))
}
# amazon_sales_cleaned
if (sum(duplicated(amazon_sales_cleaned)) == 0) {
  paste("There are no duplicate values in amazon_sales_cleaned")
} else {
  paste("Number of duplicate values in amazon_sales_cleaned:", sum(duplicated(amazon_sales_cleaned)))
}
# pl_march_2021
if (sum(duplicated(pl_march_2021)) == 0) {
  paste("There are no duplicate values in pl_march_2021")
} else {
  paste("Number of duplicate values in pl_march_2021:", sum(duplicated(pl_march_2021)))
}
# may_2022
if (sum(duplicated(may_2022)) == 0) {
  paste("There are no duplicate values in may_2022")
} else {
  paste("Number of duplicate values in may_2022:", sum(duplicated(may_2022)))
}
# international_sales
if (sum(duplicated(international_sales)) == 0) {
  paste("There are no duplicate values in international_sales")
} else {
  paste("Number of duplicate values in international_sales:", sum(duplicated(international_sales)))
}

# NO duplicates row so no 'remove duplicate row' action is done

################################################################################
#                               Visualizations                                 #
#------------------------------------------------------------------------------#
################################################################################
#----------------------------- Time Series ------------------------------------#
# Data manipulation
# Remove unnecessary columns
amazon_sales_ts <- amazon_sales_cleaned %>%
  select(-c(`Unnamed..22`, `promotion.ids`, `ship.city`, `ship.state`, `ship.postal.code`, `ship.country`))

# Convert columns to appropriate data types
amazon_sales_ts <- amazon_sales_ts %>%
  mutate(Date = as.Date(Date, format = "%m-%d-%Y"),
         Qty = as.numeric(Qty))

# Remove NAs introduced by coercion
amazon_sales_ts <- na.omit(amazon_sales_ts)

# Summarise the sales by date
amazon_sales_summary <- amazon_sales_ts %>%
  group_by(Date) %>%
  summarise(Sales_Count = n())
amazon_sales_summary
# Get max and min point value
max_point <- amazon_sales_summary %>% filter(Sales_Count == max(Sales_Count))
min_point <- amazon_sales_summary %>% filter(Sales_Count == min(Sales_Count))
max_point
min_point
# Plotting the Time Series for Monthly Sales Trend with max and min labelled
ggplot(amazon_sales_summary, aes(x = Date, y = Sales_Count, group = 1)) +
  geom_line(color = "midnightblue") +
  geom_point() +
  geom_text(data = max_point, aes(label = Sales_Count), vjust = -0.45) +
  geom_text(data = min_point, aes(label = Sales_Count), vjust = 1.45) +
  labs(title = "Monthly Sales Trend",
       x = "Month",
       y = "Sales Volume") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        plot.margin = margin(t = 20, r = 20, b = 20, l = 20))

#----------------------------- Line Graph -------------------------------------#
# Data manipulation
# Line Graph 1: Quantity Sold by Category Over Time
# Convert columns to appropriate data types
amazon_sales <- amazon_sales_cleaned %>%
  mutate(Date = as.Date(Date, format = "%m-%d-%Y"),
         Qty = as.numeric(Qty))

# Remove NAs introduced by coercion
amazon_sales <- na.omit(amazon_sales)

# Group the sales by category and date
sales_by_category <- amazon_sales %>%
  group_by(Date, Category) %>%
  summarise(Total_Qty = sum(Qty, na.rm = TRUE))

# Convert to all uppercase so it shows nicely in the legend as originally it is a combination of uppercase and lowercase characters
sales_by_category$Category <- toupper(sales_by_category$Category)
sales_by_category

# Plot Line graph for Quantity Sold by Category
ggplot(sales_by_category, aes(x = Date, y = Total_Qty, color = Category, group = Category)) +
  geom_line() +
  geom_point() +
  scale_color_manual(values = c("darkslateblue", "royalblue", "slategray2", "aquamarine4", "darkseagreen3", "thistle", "rosybrown1", "coral1", "palegoldenrod")) +
  labs(title = "Quantity Sold by Category Over Time",
       x = "Date",
       y = "Quantity Sold") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#---------------------------- Scatter Plot ------------------------------------#
# Data manipulation
# Scatter Plot 1: Relationship Between Sales Volume and Inventory Levels
# Ensure 'SKU' columns in both datasets are of the same type and can be matched
amazon_sales_cleaned$SKU <- as.character(amazon_sales_cleaned$SKU)
sale_report_cleaned$SKU.Code <- as.character(sale_report_cleaned$SKU.Code)

# Summarize the sales data to get total sales quantity per SKU
total_sales_per_sku <- amazon_sales_cleaned %>%
  group_by(SKU) %>%
  summarise(Total_Sales_Qty = sum(Qty, na.rm = TRUE))

# Left Join the sales data with the inventory data
sales_inventory_data <- total_sales_per_sku %>%
  left_join(sale_report_cleaned, by = c("SKU" = "SKU.Code"))
sales_inventory_data

# Check Missing value (missing data cols : index,stock)
summary(sales_inventory_data)

# Delete Rows with Missing values
sales_inventory_data = na.omit(sales_inventory_data)
summary(sales_inventory_data)

# Plot the scatter plot
ggplot(sales_inventory_data, aes(x = Stock, y = Total_Sales_Qty)) +
  geom_point(color = "skyblue3") +
  labs(title = "Relationship Between Sales Volume and Inventory Levels",
       x = "Inventory Level (Stock)",
       y = "Sales Volume (Total Sales Quantity)") +
  theme_minimal()

#------------------------------ Bar Chart -------------------------------------#
# Data manipulation
# Aggregate data to get counts for product categories
category_counts <- sale_report_cleaned %>%
  count(Category) %>%
  arrange(desc(n))

# Rename the column name n to Counts
names(category_counts)[names(category_counts) == "n"] <- "Counts"
# Delete row category with empty string in category
# Delete row for duplicate category Kurta Set
category_counts = category_counts %>% 
  filter(Category != "" & Category != "KURTA SET")
category_counts

# Bar Chart 1: Category Distribution
ggplot(category_counts, aes(x = reorder(Category, -Counts), y = Counts)) +
  geom_bar(stat = "identity", fill = "steelblue2") +
  labs(title = "Frequency of Product Categories",
       x = "Category",
       y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Bar Chart 2: Color Preference by Size
# Find if there is any trends in color preferences for different sizes
# Convert all strings in the 'Color' column to uppercase
sale_report_cleaned$Color <- toupper(sale_report_cleaned$Color)
sale_report_cleaned <- sale_report_cleaned %>% filter(Color != "" & Color != "NO REFERENCE" & Color != "MULTICOLOR")

# Grouping specific colors under a general color category
sale_report_cleaned <- sale_report_cleaned %>%
  mutate(Color_Group = case_when(
    Color %in% c("RED", "MAROON", "RUST", "WINE", "BURGUNDY") ~ "RED",
    Color %in% c("PINK", "PEACH", "LIGHT PINK", "CORAL PINK", "CORAL ", "CORAL") ~ "PINK",
    Color %in% c("ORANGE", "BROWN", "KHAKI", "TAUPE", "CORAL ORANGE", "LIGHT BROWN") ~ "ORANGE",
    Color %in% c("YELLOW", "BEIGE", "GOLD", "CHIKU", "MUSTARD", "CREAM", "LEMON YELLOW", "LEMON ", "LEMON", "LIGHT YELLOW") ~ "YELLOW",
    Color %in% c("GREEN", "OLIVE", "DARK GREEN", "TEAL", "OLIVE GREEN", "LIGHT GREEN", "SEA GREEN", "TEAL GREEN", "LIME GREEN", "AQUA GREEN", "MINT", "TEAL GREEN ", "MINT GREEN") ~ "GREEN",
    Color %in% c("BLUE", "NAVY BLUE", "TURQUOISE BLUE", "TEAL BLUE ", "SKY BLUE", "LIGHT BLUE", "DARK BLUE", "POWDER BLUE", "NAVY", "TURQUOISE GREEN", "TURQUOISE") ~ "BLUE",
    Color %in% c("PURPLE", "TEAL GREEN","INDIGO", "MAUVE", "MAGENTA") ~ "PURPLE",
    Color %in% c("BLACK", "WHITE", "GREY", "OFF WHITE", "CHARCOAL") ~ "GREYSCALE",
    TRUE ~ as.character(Color) # Keeps the original color if it doesn't match the above (JIC I missed some but hope not)
  ))
View(sale_report_cleaned)

# Custom color palette that matches the color names 
custom_colors <- c(
  "BLUE" = "blue",
  "GREEN" = "darkgreen",
  "GREYSCALE" = "grey",
  "ORANGE" = "orange",
  "PINK" = "pink",
  "PURPLE" = "purple",
  "RED" = "red",
  "YELLOW" = "palegoldenrod"# darker shade of yellow as yellow is too bright
)

# Updated bar plot with custom color 
ggplot(sale_report_cleaned, aes(x = Color_Group, fill = Color_Group)) +
  geom_bar(position = "dodge") +
  facet_wrap(~ Size, scales = "free_y") +  # Adjusting the layout
  scale_fill_manual(values = custom_colors) +  # Apply custom color palette
  labs(title = "Color Preference by Size",
       x = "Color Group",
       y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1))  

#------------------------------ Pie Chart -------------------------------------#
# Pie Chart 1: Orders Fulfilment Type Distribution
# Data manipulation
fulfilment_distribution <- table(amazon_sales_cleaned$Fulfilment)

# Plot the pie chart on Orders Fulfilment Type Distribution
pie(fulfilment_distribution,
    main = "Fulfilment Type Distribution",
    col = c("lightblue", "pink1"),
    labels = names(fulfilment_distribution))

#------------------------------ Histogram -------------------------------------#
# Data manipulation
# Ensure MRP columns are numeric and gather them into a single column
mrp_columns <- c("Ajio.MRP", "Amazon.MRP", "Amazon.FBA.MRP", "Flipkart.MRP", 
                 "Limeroad.MRP", "Myntra.MRP", "Paytm.MRP", "Snapdeal.MRP")

# Histogram 1: Inventory Distribution of MRPs Across Different Platforms throughout May 2022 and March 2021
# Get Column Names (to decide on which attributes to perform join on)
names(amazon_sales_cleaned)
names(sale_report_cleaned)
names(pl_march_2021)
names(may_2022)
names(international_sales)

# pl_march_2021 and may_2022 is chosen to perform full outer join
may_2022$year <- 2022
pl_march_2021$year <- 2021
names(pl_march_2021)
names(may_2022)

# Add a new column 'TP' which is the average of 'TP.1' and 'TP.2'
pl_march_2021$TP.1 <- as.numeric(as.character(pl_march_2021$TP.1))
pl_march_2021$TP.2 <- as.numeric(as.character(pl_march_2021$TP.2))
pl_march_2021_new <- pl_march_2021
pl_march_2021_new$TP <- (pl_march_2021$TP.1 + pl_march_2021$TP.2) / 2
# Remove the 'TP.1' and 'TP.2' columns
pl_march_2021_new <- pl_march_2021_new[, !(names(pl_march_2021_new) %in% c("TP.1", "TP.2"))]
may_2022$TP <- as.numeric(as.character(may_2022$TP))

# Remove NAs introduced by coercion 
pl_march_2021_cleaned <- na.omit(pl_march_2021_new)
may_2022_cleaned <- na.omit(may_2022)

# Perform full outer join
full_out_dataset <- full_join(pl_march_2021_cleaned, may_2022_cleaned)

# Inspect dataset after data joining
names(full_out_dataset)
head(full_out_dataset[full_out_dataset$year == 2021, ]) # Confirm 2021 data is included
head(full_out_dataset[full_out_dataset$year == 2022, ]) # Confirm 2022 data is included

# Reshaping the MRP columns into a long format
histogram_dataset <- full_out_dataset %>%
  mutate(across(all_of(mrp_columns), as.numeric)) %>%
  pivot_longer(                       # Transform data from wide format to long format
    cols = all_of(mrp_columns),       # Select all MRP columns to pivot
    names_to = "Platform_MRP",        # New column for the MRP platform names
    values_to = "MRP_Value"           # New column for the MRP values
  ) %>%
  filter(!is.na(MRP_Value))           # Filter to select rows where the MRP_Value is not missing values

# Plotting the histogram of MRPs
ggplot(histogram_dataset, aes(x = MRP_Value)) +
  geom_histogram(binwidth = 70, fill = "royalblue", color = "black") +
  facet_wrap(~ Platform_MRP, scales = "free_y") +
  labs(title = "Inventory Distribution of MRPs Across Different Platforms",
       x = "MRP Value",
       y = "Frequency") +
  theme_minimal()
