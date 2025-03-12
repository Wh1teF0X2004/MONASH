################################################################################
#            Student Name: Foo Kai Yan                                         #
#            Student ID: 33085625                                              #
#            Student Email: kfoo0012@student.monash.edu                        #
################################################################################
# Set Working Directory
setwd("C:/Monash/ETW2001")

# Load required libraries
library(tidyverse)
library(tidyr)
library(dplyr)

################################################################################
#                                  SECTION A                                   #
################################################################################
# Remove/Clean the environment
rm(list=ls()) 

## Question 1
# Load the provided datasets
sales_dataset = read.csv("sales.csv", header = TRUE)
products_dataset = read.csv("products.csv", header = TRUE)
inventory_dataset = read.csv("inventory.csv", header = TRUE)
# Look into the dimensions of each datasets
dim(sales_dataset) # There is 200000 rows and 6 columns
dim(products_dataset) # There is 1001 rows and 4 columns
dim(inventory_dataset) # There is 1000 rows and 6 columns
# Column names of each datasets
names(sales_dataset)
names(products_dataset)
names(inventory_dataset)
# Filter to include transactions occurred in year 2020
typeof(sales_dataset$Date) 
# From here we know that data in Date column is 'character', not a Datetime format
# So here, we convert the data in Date column to Datetime format
sales_dataset$Date <- as.Date(sales_dataset$Date, format="%Y-%m-%d")
year2020_transactions <- sales_dataset %>% filter(format(Date, "%Y") == "2020")
head(year2020_transactions)
# 'count' was used to count the total number of sales transactions happening in 2020
count(year2020_transactions) 


## Question 2
# First, we group sales data by their Product Id because there might be repeated transactions for each products
product_sales <- group_by(sales_dataset, ProductId)
product_sales
# Then calculate the total revenue for each product after grouping
product_revenue <- summarize(product_sales, TotalRevenue = sum(UnitPrice * Quantity))
product_revenue
# Arrange the products by total revenue in descending order so highest sales is at the top
desc_total_revenue <- arrange(product_revenue, desc(TotalRevenue))
desc_total_revenue
# Get the Product Id of the product with the highest total revenue
top_revenue_product_id <- desc_total_revenue[1, ]$ProductId
top_revenue_product_id
# Filter to find the Product Name of that Product Id from products data
top_revenue_product_name <- products_dataset %>%
  filter(ProductId == top_revenue_product_id) %>%
  select(ProductName)
top_revenue_product_name
# Filter to find the the Store Id of the product with the highest total revenue
top_revenue_product_store_id <- inventory_dataset %>%
  filter(ProductId == top_revenue_product_id) %>%
  select(StoreId)
top_revenue_product_store_id
# Filter to find the Store name of the product with the highest total revenue
top_revenue_store_name <- inventory_dataset %>%
  filter(StoreId == top_revenue_product_store_id[1, ]) %>%
  select(StoreName)
unique(top_revenue_store_name)


## Question 3
# Group inventory data by Store Id
inventory_by_store_id <- group_by(inventory_dataset, StoreId)
inventory_by_store_id
# Summarize the average Quantity Available for each Store Id whilst removing any NA or empty data
average_quantity_available <- summarize(inventory_by_store_id, AverageQuantity = mean(QuantityAvailable, na.rm = TRUE))
average_quantity_available
# Arrange the Store Id by average Quantity Available in ascending order to find the lowest average Quantity Available
sorted_average_quantity <- arrange(average_quantity_available, AverageQuantity)
sorted_average_quantity
# Get the Store Id with the lowest average quantity available
lowest_average_quantity_store_id <- sorted_average_quantity[1, ]$StoreId
lowest_average_quantity_store_id


## Question 4
# Insert new column named 'SaleStatus' and temporarily put NA for all the rows
sales_dataset$SaleStatus <- NA
names(sales_dataset)
# Mutate to add data into the new column
sales_dataset <- sales_dataset %>%
  mutate(SaleStatus = case_when(
    Quantity >= 50 ~ 'High',
    Quantity >= 20 & Quantity < 50 ~ 'Medium',
    TRUE ~ 'Low'
  ))
# Count of 'High' category sales
high_count <- sum(sales_dataset$SaleStatus == 'High')
high_count


## Question 5
# Arrange in descending order of Product Cost
products_dataset <- products_dataset %>% arrange(desc(ProductCost))
head(products_dataset)
# Separate Product Name into Product - Brand
products_dataset <- products_dataset %>% separate(ProductName, into = c("Product", "Brand"), sep = " - ")
head(products_dataset)
# List with 3rd index to find the 3rd most expensive brand
third_most_expensive_brand <- products_dataset$Brand[3]
third_most_expensive_brand


## Question 6 
# Calculate the average price and quantity sold for each product present in the dataset
head(sales_dataset)
average_price_quantity <- sales_dataset %>% 
  group_by(ProductId) %>%
  summarise(AveragePrice = mean(UnitPrice),
         AverageQuantity = mean(Quantity))
head(average_price_quantity)
# Calculate the percentage change in quantity sold and unit price
# Then, the percentage change within each Product Id group is calculated
average_price_quantity <- average_price_quantity %>%
  mutate(PercentChangeQuantity = (AverageQuantity - lag(AverageQuantity)) / lag(AverageQuantity) * 100,
         PercentChangePrice = (AveragePrice - lag(AveragePrice)) / lag(AveragePrice) * 100)
head(average_price_quantity)
# Calculate the price elasticity of demand
# Now, we can summarize the percentage changes to calculate elasticity
elasticity <- average_price_quantity %>%
  group_by(ProductId) %>%
  mutate(PriceElasticity = abs(PercentChangeQuantity / PercentChangePrice))
elasticity
# Product most sensitive to price changes
most_sensitive <- elasticity[order(-elasticity$PriceElasticity), ]
most_sensitive
most_sensitive_product <- products_dataset %>%
  filter(ProductId == most_sensitive$ProductId[2])
most_sensitive_product
# Product least sensitive to price changes 
least_sensitive <- elasticity[order(elasticity$PriceElasticity), ]
least_sensitive
least_sensitive_product <- products_dataset %>%
  filter(ProductId == least_sensitive$ProductId[1])
least_sensitive_product


################################################################################
#                                  SECTION B                                   #
################################################################################
## Question 1
# Video timestamps:
# 0:22 --> over 100million transactions per week
# 1:20 --> 30,000 stores worldwide & process almost 100million transactions per week
x_number_of_stores <- 30000
y_total_transactions <- 100000000
average_transactions_per_store <- y_total_transactions / x_number_of_stores

average_transaction_category <- ifelse(average_transactions_per_store > 3500, "High",
                               ifelse(average_transactions_per_store >= 2500 & average_transactions_per_store <= 3500, "Medium", "Low"))
paste("The average Starbucks stores transaction category level is", average_transaction_category)

## Question 2
# Video timestamps:
# 2:55 --> population, income level, traffic, competitor presence, proximity to other Starbucks locations
population <- 77777      # Total population in the area
income_level <- 27000    # Average income level of the population
traffic <- 'Medium'         # Average daily traffic in the area
competitor_presence <- 7 # Number of competitors in the area
proximity_to_other_starbucks_locations <- 17 # Distance in km to the nearest Starbucks

location_category_level <- ifelse(population > 58333 & income_level > 20250 & traffic == 'Very High' & competitor_presence < 2 & proximity_to_other_starbucks_locations > 12, "Ideal location",
                            ifelse(population > 38888 & income_level > 13500 & traffic == 'High' & competitor_presence < 7 & proximity_to_other_starbucks_locations > 7, "Good location",
                                   ifelse(population > 19444 & income_level > 6750 & traffic == 'Medium' & competitor_presence < 9 & proximity_to_other_starbucks_locations > 4, "Average location",
                                          "Poor location")))
paste("This is a", location_category_level, "for opening a new Starbucks store")

## Question 3
# Video timestamps:
# 5:33 --> collect data based on weather patterns and their relationship with customer order pattern
#      --> provide personalised experiences & promotions 
#      --> eg. delivering cold drinks on hot weathers
# 6:55 --> promote specific products based on local factors such as weather or time of the day
weather <- "rainy"
time_of_day <- "mid-night" 

if (time_of_day == "mid-night") {
  promotion <- "No promotion"
} else if (weather == "cold" || weather == "rainy") {
  promotion <- "Promote hot beverages"
} else if (weather == "hot" && time_of_day == "afternoon") {
  promotion <- "Promote cold beverages"
} else if (time_of_day == "morning" || time_of_day == "evening") {
  promotion <- "Promote pastries"
} else {
  promotion <- "No promotion"
}
paste("Today's promotion is", promotion)
