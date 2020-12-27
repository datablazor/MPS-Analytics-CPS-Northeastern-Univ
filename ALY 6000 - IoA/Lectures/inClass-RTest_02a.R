# ADD your name here:
# Sunil Raj Thota

library(plyr)
library(magrittr)
library(dplyr)
library(tidyr)
library(tidyverse)
library(DT)

# Import the data set CarSaleIndia_RTest2.CSV

library(readr)
CarSaleIndia_RTest2 <-
        read_csv(
                "CarSaleIndia_RTest2.csv",
                col_types = cols(
                        Efficiency = col_number(),
                        Engine_cc = col_number(),
                        Km = col_number(),
                        Price = col_number()
                )
        )
CarSaleIndia_RTest2
View(CarSaleIndia_RTest2)

# Very important, at the moment to import the data set, make sure the following variables are numerical:
# Km, Efficiency, Engine_cc, and Price are numerical.
# If you pasted the dataset in the same folder as your R project, then you can Use this code:




# Change the name of the data set to "carsale"

carsale <- CarSaleIndia_RTest2
carsale # Changed the data set name to carscale
View(carsale)

head(carsale)
tail(carsale)
summary(carsale)
summary(carsale$Km)

# Summary and display of numerical variables

summary(carsale$Km)
boxplot(carsale$Efficiency, ylab = "Kilometers")

summary(carsale$Engine_cc)
boxplot(carsale$Engine_cc, ylab = "Engine_cc")

summary(carsale$Efficiency)
boxplot(carsale$Efficiency, ylab = "Efficiency")

summary(carsale$Price)
boxplot(carsale$Price, ylab = "Price in US$")


################# ************  #################
# QUESTION 1
################# ************  #################


# HoW many cars were sold by location?
# 5844 Cars were sold by Location        
# A Little help: Check summary to see the counts and class of this variable

summary(carsale$Location)
class(carsale$Location)  # Enter the class you obtained:
# Character Class


# TO DO:
# Create an object named Figure1 to convert carsale$Location to table


Figure1 <- table(carsale$Location)
print(Figure1)
class(Figure1)   # Enter the class you obtained:
# Tables is the class I have obtained

# TO DO:
# Now create the bar plot with Figure1 data, complete the code below.
# Add a good title to the graph
# Add good X- and Y-axes labels
# Add a different color to each bar
# Increase y limits to 1000


barplot(
        height = as.matrix(Figure1),
        main = "Location wise Car Sales",
        sub = "Data set InchBio",
        col.sub = "blue",
        xlab = "Cities",
        ylab = "Car Sales",
        beside = TRUE,
        width = 1.25,
        space = 0.05,
        border = NA,
        ylim = c(0, 1000),
        las = 2,
        cex.axis = 1,
        cex.names = 0.6,
        cex.lab = 1.1
) # Barplot


################# ************  #################
# QUESTION 2
################# ************  #################


# What is the mean Kilometers reading per owner type?

# TO DO:
# Create an object named Figure2 using the code:
# round(tapply(y-variable, INDEX = x-variable, FUN = mean), digits = 1)
# This code is used to calculate the mean Km per owner type, use one digit
# This is exactly the same code you learn last week
# Complete the code below

Figure2 <- round(tapply())
print(Figure2)


# TO DO:
# Create a bar plot to display Figure2 data.
# Add a good title to the graph
# Add good X- and Y-axes labels
# Add a different color to each bar
# Increase x limits to 140,000


barplot()






################# ************  #################
# QUESTION 3
################# ************  #################

# What is the price distribution based on seats content?

# TO DO:
# Create a box plot to display these two variables: carsale$Price and carsale$Seats
# Divide the price by 1000 as follows: carsale$Price/1000
# Increase y limits to 250
# Use las = 1 to display y-labels in an horizontal direction
# Add a good title to the graph
# Add proper X- and Y-axes labels
# Y-axis label should mention in thousands as the value was divided by 1000.
# Add a different color to each bar

par(mai = c(1, 1.2, 1, 0.5))

boxplot(carsale$Price/1000 ~ carsale$Seats, ylim = c(0, 250))





################# ************  #################
# QUESTION 4
################# ************  #################

# What is the relationship between Efficiency and Engine_cc

# TO DO:
# Use the code plot() to display those two variables
# Engine_cc in the y-axis, Efficiency in the x-axis
# Divide Engine_cc by 1000 (as indicated above)
# Use las = 1 to display y-axis labels in an horizontal direction
# Add a good title to the graph
# Add proper X- and Y-axes labels
# Y-axis label should mention in thousands as the value was divided by 1000.

plot(Engine_cc ~ Efficiency, data = carsale, las = 1)
