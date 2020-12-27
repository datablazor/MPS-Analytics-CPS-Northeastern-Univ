# Add your name and last name
#Sunil Raj Thota

# LOAD the following libraries (control + enter)
library(magrittr)
library(plyr)
library(dplyr)
library(tidyr)
library(FSA)
library(tidyverse)
library(DT)
# Loaded the above libraries into the workspace

# 1. Copy and paste the file car_sale_RTest1.CSV into your computer folder. No codes are needed

# 2. Import the file into this R script file. Use the strategy the instructor recommended (no codes needed), or any other strategy of your preference (present the codes).
library(readr)
cars <- read_csv(
  "car_sale_RTest1.csv",
  col_types = cols(
    Km = col_number(),
    Efficiency = col_number(),
    Price = col_number()
  )
)
cars
View(cars) # To view the imported cars Data set

# 3. Change the name of the data set to "cars" and print the 5 first and 5 last observations from head and tail.

headtail(cars, 5) # Fist and last 5 records of cars data set

# 4. Select only Location and Km, use [ ] for this. Create an object named A
# use dataset name with [], inside [] add the columns of interest.
# Print A

A <- cars[c("Location", "Km")]
A #Location and Km in a separate object called A

# 5. Create an object B and calculate the mean Km for ALL locations, use only one decimal
#  Use round(mean()) code
# Print B

B <- round(mean(A$Km), 1)
B # Mean of Km and rounded to 1 Decimal

# 6. Using the code: print(paste("Text", value)), print the following text: The mean kilometers of cars in all locations is <value>

print(paste("The mean kilometers of cars in all locations is", 47106.8))
# The mean Km of cars in all locations is 47106.8

# 7. Using the code:
# round(tapply(numerical-variable, INDEX = categorical-variable, FUN = mean), digits = 2)
# Create an object C and calculate the mean price per location, use 2 digit decimals.
# Print C

C <-
  round(tapply(cars$Price, INDEX = cars$Location, FUN = mean), digits = 2)
C 
# Calculated the mean price per location and rounded to 2 decimal digits


# Control enter on this code, I'll explain later

par(mai = c(1, 2, 1, 1))

# 8. Create an horizontal (horiz =) bar plot to show the results of C.
# The list of cities go on the left (y-axis), prices on the bottom (x-axis)
# Use las  = 1 to adjust your Y-labels
# Provide different colors to each bar
# Enter "color" names or use this page to obtain #000000 codes:
# https://www.rapidtables.com/web/color/RGB_Color.html
# Increase xlim to 5000
# Add xlab label "Price (In US$)"
# Add a title (main =) for "Car average sale price per location"

barplot(
  C,
  horiz = TRUE,
  las = 1,
  col = c("Red", "Blue", "Yellow", "Green", "Gray", "Cyan"),
  xlim = c(0, 5000),
  xlab = "Prices (In US$)",
  main = "Car average sale price per location"
) # Plotted a Barplot

# 9. Create a Box plot to analyze location versus efficiency
# Efficiency should be on the Y-axis, location on the x-axis
# Add x- and y-axis labels based on the name of the variables
# Add a title to the graph
# Add color to the boxes
# Remember, dataset is cars

boxplot(
  cars$Efficiency ~ cars$Location,
  xlab = "Location",
  ylab = "Efficiency",
  main = "Boxplot for Location vs Efficiency",
  col = "gray",
  outcol = "slategray3",
  las = 1
) # Plotted a Boxplot

# 10. That's it. End of the test.
# Re-name this R-file with your lastname and name
# Submit the R file in the Discussion section M4 Class Test