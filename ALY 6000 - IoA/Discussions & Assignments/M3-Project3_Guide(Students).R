# Introduction to Analytics
# Instructor Dr. Dee Chiluiza, PhD
# Module 3 Project 3 

# Create the following vector
Student = "Sunil Raj Thota"
Student

# Print the phrase: "My name is" using the combination of print and paste codes.

print(paste("My name is", Student))

# Be sure to change the name of the file using M3-Project-Your last name

# Packages and Libraries

install.packages("FSA")
install.packages(FSAdata)

library(plyr)
library(magrittr)
library(dplyr)
library(tidyr)
library(FSA)
library(tidyverse)

library(DT) # To create interactive tables


################################################################

## ----- ATTENTION: Here is the beginning of your tasks -------
## Enter all your codes below each task.

#1
# Import the data set InchBio.csv as indicated by your instructor
# Then call the data set with its name



#2
# Change the name of the data set to "bio"


#3
# Create an INTERACTIVE table of the whole data set
# Review the file in CANVAS provided by your instructor 
# Add a top filter to every column
# Remove the numbers given to each row
# Make sure table display all values without page breaks



#4
# DISPLAY the first and last 5 records of the head and tail of the table < bio >



#5
# Using the code bio$species, display the levels of the species variable
# This will display the 8 categories contained in Species



#6
# Use that code to create an object named  < tmp > that displays the different species 
# and the number of records for each species 



#7
# Create a subset named < tmp2 > of just the species variable from the bio data
# and display the first five and last five records



#8
# Use the code bio$species alone and observe the results
bio$species
# It shows you all the observations based on the species names 
# You want to know how many observations there are per species 
# Use that code to create a TABLE named < Frequencies > 
# Print values.
# This should display the Species in the data set and their frequencies




#9
# That table is not easy to observe
# Convert the < Frequencies > table to a data frame named < Frequencies_df > 
# Display the results using an interactive table
# It should display Var1 and Freq (names given automatically)



#10
# CREATE a table named  < SpecPct > that display the species and their percentages 
# Make sure the values are rounded to 3 decimals only
# Print the results



#11
# That table is not easy to observe
# Convert the table < SpecPct > to a data frame named < SpecPct_df >
# Column heads are again named Var1 and Freq, we will fix it



#12
# RENAME the two columns in SpecPct_df as follows: Var1 to Species, Freq to Percentage 
# Use the "rename" code
# Print the results



#13
# Rearrange the SpecPct_df data frame in descending order of percentages




      # NOW let's go back to Frequencies_df

#14
# RENAME the two columns in Frequencies_df as follows: Var1 to Species, Freq to Frequencies 
# Use the "rename" code
# Print the results



#15
# Rearrange the Frequencies_df data frame in descending order of Frequencies



#16
# ADD NEW VARIABLES to the < Frequencies_df > data frame using the "mutate" code
# Create an object with the name FinalTable
# Add (1) cumulative frequency as CumFrequencies, 
# Add (2) Percentages as Percentage, make sure values are rounded to 4 decimals
# Add (3) cumulative Percentage as CumPercentage
# Print results
# Create an interactive table 






#17
# PLOT a BARPLOT of Frequencies data 
# Title "Fish Counts per species"
# Subtitle: "Data set InchBio"
# y-axis label: "COUNTS",
# y axis values: rotated to horizontal,  
# x axis font magnification: at 60% of nominal
# Increase y-axis limits to include column heights
# Each bar with a different color
# las for x-labels horizontal (1) or vertical (2).
# cex.names is for x-axis font size, enter numerical value
# cex.axis is for the size of the y-labels, enter numerical value








# 18
# CREATE a BARPLOT named < pc > with the following specifications:
# Use data set: FinalTable$Frequencies
# Width: 1, space:0.15, border: NA, axes:F, 
# y-axis limits from 0 to 3.05*max(FinalTable$Frequencies, na.rm = TRUE)
# Scale x-axis fonts to 70%, 
# names.arg: FinalTable$Species,
# Title: "Individual observations per fish species" 
# For las, try 1 and 2, use the number that works best for you






# 19
# Check in the following page, section Axes: https://www.statmethods.net/advgraphs/axes.html
# Create a custom LEFT axis label using the axis( ) function, with the following specifications
# Side = 2, thick marks at = c(0, 300) 
# color: grey62,  color of axis: grey62, axis font (cex.axis) scaled to 80% of nominal





# 20
# Create a custom RIGHT axis label using the axis( ) function, with the following specifications
# Side = 2, thick marks at = c(0, FinalTable$CumFrequencies) 
# color: #D930DF,  color of axis: #D930DF, axis font (cex.axis) scaled to 80% of nominal





# 21
# Add custom titles to the right and left axes using the code: mtex()
# Check page https://www.statmethods.net/advgraphs/axes.html
# Left title "Counts", right title "Cumulative Frequencies
# Other characteristics (color, angle, size, etc) are your choice.




# 22
# ADD a Cumulative counts line to the < pc > plot with the following specifications:
# Use data FinalTable$Cumfrequencies
# line type: b, scale plotting text at .7, data values: solid circles, color: cyan4
# Since we are not at this level yet, here is the code, observe the line

lines(pc, FinalTable$CumFrequencies, type = "b", cex = 0.7, pch = 19, col="cyan4")



#23
# Create a box plot to compare the total length (tl variable) among all 8 species 
# For this box plot, you choose all the characteristics of the graph
# Use your knowledge and imagination




