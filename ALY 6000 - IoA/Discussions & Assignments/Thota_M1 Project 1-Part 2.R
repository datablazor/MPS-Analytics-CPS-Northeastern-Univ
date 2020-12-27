# ALY 6000 - 71618 (CRN Number)
# Module 1 Project 1 - Part 2
# 09/26/2020
# Sunil Raj Thota
# NUID: 001099670

# Sales Data
sales <- c(8, 11, 15, 20, 21, 11, 18, 10, 6, 22)
sales

# Temperature Data
temp <- c(69, 80, 77, 84, 80, 77, 87, 70, 65, 90)
temp

#---------------------------------------------#

# Q1: Scatter plot of Sales versus Temperature
plot(
  sales,
  temp,
  main = "Scatterplot",
  xlab = "Sales ",
  ylab = "Temperatures",
  pch = 16
) # Scatter Plot

# Regression Line
abline(lm(temp ~ sales), col = "red")
# Lowess Line
lines(lowess(sales, temp), col = "blue")

#---------------------------------------------#

# Q2: Find the Mean Temperature
# The Temperate Data is declared on the line number 12
mean(temp) # Mean of the Temperature Data
# The mean temperature is 77.9

#---------------------------------------------#

# Q3: DELETE the 3rd element (#15) from the sales vector 
sales[-3] # Deleted the 3rd element from the Sales Vector

#---------------------------------------------#

# Q4: INSERT 16 as the 3rd element in the sales vector
sales[3] <- 16 # Inserted #16 as the 3rd element in the sales vector

#---------------------------------------------#

# Q5: CREATE a vector < names > with Tom, John, Harry
names <- c("Tom", "John", "Harry") 
names # Created names Vector

#---------------------------------------------#

# Q6: CREATE a 5 rows / 2 columns matrix of 10 integers (1 to 10)
matrix <- matrix(1:10, nrow = 5, ncol = 2)
matrix # Created a 5*2 matrix

#---------------------------------------------#

# Q7: CREATE <icSales> dataframe with sales & temp vars
icSales <- data.frame(sales, temp)
icSales # Created an icSales Dataframe

#---------------------------------------------#

# Q8: DISPLAY a summary and structure of the icSales data frame
summary(icSales) # Displayed a summary of icSales Dataframe
str(icSales) # Displayed a structure of icSales Dataframe

#---------------------------------------------#

# Q9: IMPORT the attached data set as Student.csv

studentCSV <- read.csv("C:/Users/hp/Desktop/R Files/Student.csv")
studentCSV # Imported the Student.csv Data set

#---------------------------------------------#

# Q10: Obtain the means for Math, Science and Social Studies and create a vector named All_means. Create a vector named All_labels containing Math, Science and Social Studies, and finally present this data using a data frame.

all_means <- c(mean(studentCSV$Math),
               mean(studentCSV$Science),
               mean(studentCSV$Social.Studies))
all_means # Here is the Means Data

all_labels <- c("Math", "Science", "Social Studies")
all_labels # Here is the Labels Data

data <- data.frame(all_labels, all_means)
data # Dataframe with all_labels and all_means data

#---------------------------------------------#

# Q11: Present key Summary Descriptive Statistics for the data set Student.csv
summary(studentCSV) 
# In this we can obtain all the summary of descriptive statistics of the Student.csv Data set

#---------------------------------------------#

# Q12: Present bar graphs for each student (using their last names) and their corresponding Math, Science and Social Studies scores (you can present one or three independent bar graphs)

marksData <- studentCSV[4:6]
marksData # Marks Data

namesData <- studentCSV[3]
namesData # Names Data
  
barplot(
  height = as.matrix(marksData),
  main = "Students Subject-wise Marks",
  ylab = "Marks",
  xlab = "Subjects",
  beside = TRUE,
  legend = TRUE,
  col = c("green", "red", "blue", "yellow"),
  ylim = c(0, 100),
  xlim = c(0, 20)
) # Bar Plot of the Students Subject-wise Marks

legend(
  "right",
  c("Smith", "Weary", "Thornton, III", "O'Leary"),
  bty = "n",
  cex = 1,
  fill = c("green", "red", "blue", "yellow"),
  inset = c(0, 0.95),
  xpd = TRUE
) # Legend to indicate the names of the Students in respective allocated colors 

#---------------------------------------------#

# Bibliography:
# 1.	https://stackoverflow.com/questions/27688754/bar-chart-legend-position-avoiding-operlap-in-r

# 2.	https://stackoverflow.com/questions/3932038/plot-a-legend-outside-of-the-plotting-area-in-base-graphics

# 3.	https://www.dataanalytics.org.uk/legends-on-graphs-and-charts/

# 4.	https://www.statmethods.net/graphs/bar.html

#---------------------------------------------#

library(FSA)
library(FSAdata)
library(magrittr)
library(ggplot2)
library(dplyr)
library(plotrix)
library(moments)

data(BullTroutRML2)
str(BullTroutRML2)
head(BullTroutRML2)
?data
