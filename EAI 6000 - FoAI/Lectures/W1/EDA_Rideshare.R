library(ggplot2)
library(dplyr)
library(gridExtra)

library(data.table)

## Data can be downloaded from here:
## https://www.kaggle.com/ravi72munde/uber-lyft-cab-prices#cab_rides.csv

rideDF <- read.csv("~/Downloads/Northeastern/ALY6040-DataMingingApplications_Spring_B_2020_Thu_82141/Coursework/Week1/Datafiles_Rcode/cab_rides.csv")
ride = fread("~/Downloads/Northeastern/ALY6040-DataMingingApplications_Spring_B_2020_Thu_82141/Coursework/Week1/Datafiles_Rcode/cab_rides.csv")

summary(ride)
str(ride)
head(ride)

# taxi ride in data, remove because of no price
table(is.na(ride$price))
table(ride$name == "Taxi")
ride <- filter(ride, name != "Taxi")

# rename last column to make it more meaningful
names(ride)[10] <- "product_name"

table(ride$surge_multiplier)

# convert epoch time into normal time
library(anytime)
ride <- mutate(ride, time = anytime(ride$time_stamp / 1000),
               date = anydate(ride$time_stamp / 1000))
str(ride)

# extract hour from time
library(lubridate)
ride <- mutate(ride, hour = hour(ride$time))

# add day of week to data
ride <- mutate(ride, day = weekdays(ride$date))
ride$day <- as.factor(ride$day)
str(ride)

# add weekend or not binary variable
ride <- mutate(ride, is_weekend = (day %in% c("Sunday", "Saturday")))
# make sure number matches
table(ride$day)
table(ride$is_weekend)

# convert price of transactions with surge multiplier to base price
ride <- mutate(ride, base_price = price / surge_multiplier)

# sort order of days of week
ride$day <- factor(ride$day, levels(ride$day)[c(4,2,6,7,5,1,3)])

# grouping services
ride <- mutate(ride, level = 1)
ride$level[which(ride$product_name %in% c("UberX", "Lyft"))] <- 2
ride$level[which(ride$product_name %in% c("UberXL", "WAV", "Lyft XL"))] <- 3
ride$level[which(ride$product_name %in% c("Black", "Lux", "Lux Black"))] <- 4
ride$level[which(ride$product_name %in% c("Black SUV","Lux Black XL"))] <- 5
ride$level <- as.factor(ride$level)


######
# EDA
######

# break dataset to uber and lyft
uber <- filter(ride, cab_type == "Uber")
lyft <- filter(ride, cab_type == "Lyft")
class(uber)

# percentage of market share
table(ride$cab_type) / length(ride$cab_type) * 100

ggplot(ride, aes(x = base_price, fill = cab_type)) + geom_histogram(bins = 24) +
  ggtitle("Histogram of Price by Company") + xlab("Price") + labs(fill = "Company")
# almost no uber falls in the first category, that is, very few uber below $5
# right-skewed, 

g1 <- ggplot(ride, aes(x = cab_type, y = price)) + geom_boxplot() + ylim(0, 100) +
  ggtitle("With Surge Multipiers") + xlab("Company") + ylab("Price")
g2 <- ggplot(ride, aes(x = cab_type, y = base_price)) + geom_boxplot() + ylim(0, 100) +
  ggtitle("Without Surge Multipiers") + xlab("Company") + ylab("Price")
grid.arrange(g1, g2, ncol = 2)

ggplot(ride, aes(x = day, y = base_price, colour = cab_type)) + geom_boxplot() + 
  labs(colour= "Company") + xlab("Day of Week") + ylab("Price") +
  ggtitle("Price for Each Day of Week, by Company")

ggplot(ride, aes(x = as.factor(hour), y = base_price, colour = cab_type)) + geom_boxplot() +
  labs(colour= "Company") + xlab("Hour") + ylab("Price") +
  ggtitle("Price for Each Hour, by Company")

ggplot(ride, aes(x = distance, y = base_price, colour = cab_type)) + geom_point() +
  ggtitle("Price VS. Distance by Company") + xlab("Distance") + ylab("Price") +
  labs(colour = "Company")

ggplot(ride, aes(x = source, y = base_price, colour = cab_type)) + geom_boxplot() +
  ggtitle("Price of Different Area, Source, by Company") + xlab("Source") +
  ylab("Price") + theme(axis.text.x = element_text(angle = -45)) + labs(colour = "Company")

ggplot(ride, aes(x = destination, y = base_price, colour = cab_type)) + geom_boxplot() +
  ggtitle("Price of Different Area, Destination, by Company") + xlab("Source") +
  ylab("Price") + theme(axis.text.x = element_text(angle = -45)) + labs(colour = "Company")

ggplot(ride, aes(x = level, y = base_price, colour = cab_type)) + geom_boxplot() +
  ggtitle("Price by Service Level, by Company") + xlab("Service Level") + ylab("Price") +
  labs(colour = "Company")







