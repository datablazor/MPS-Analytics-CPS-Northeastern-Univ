# Introduction to Analytics
# ALY 6000 - 71618 (CRN Number)
# Module 3 Project 3
# 10/07/2020
# Sunil Raj Thota
# NUID: 001099670

# Create the following vector
Student <- "Sunil Raj Thota"
Student # Created the vector

# Print the phrase: "My name is" using the combination of print and paste codes.

print(paste("My name is", Student))

# Be sure to change the name of the file using M3-Project-Your last name
# Packages and Libraries

install.packages("FSA")
install.packages("FSAdata")
install.packages("plyr")
install.packages("magrittr")
install.packages("dplyr")
install.packages("tidyr")
install.packages("tidyverse")
install.packages("DT")
# Installed the above packages into the workspace

library(FSA)
library(FSAdata)
library(plyr)
library(magrittr)
library(dplyr)
library(tidyr)
library(tidyverse)
library(DT) # To create interactive tables
# Loaded the above libraries into the workspace

################################################################

## ----- ATTENTION: Here is the beginning of your tasks -------
## Enter all your codes below each task.

#1
# Import the data set InchBio.csv as indicated by your instructor
# Then call the data set with its name

library(readr)
inchBio <-
  read_csv(
    "inchBio.csv",
    col_types = cols(
      netID = col_number(),
      fishID = col_number(),
      tl = col_number(),
      w = col_number()
    )
  )
inchBio # Imported the dataset InchBio.csv
View(inchBio) # View the dataset InchBio.csv

#2
# Change the name of the data set to "bio"

bio <- inchBio
bio # Changed the data set name to bio
View(bio) # View bio data set

#3
# Create an INTERACTIVE table of the whole data set
# Review the file in CANVAS provided by your instructor
# Add a top filter to every column
# Remove the numbers given to each row
# Make sure table display all values without page breaks

DT::datatable(
  bio,
  options = list(autoWidth = TRUE, paging = FALSE),
  class = "cell-border stripe",
  callback = JS("return table;"),
  filter = c("top"),
  escape = TRUE,
  style = "default",
  fillContainer = getOption("DT.fillContainer", NULL),
  autoHideNavigation = getOption("DT.autoHideNavigation", NULL),
  selection = c("multiple", "single", "none"),
  extensions = list(),
  plugins = NULL,
  editable = "cell",
  rownames = FALSE
) # Created an interactive Table, added the top filter for each column, removed the default numbers of each row and displayed the table without page breaks. Also, added few other data table features

#4
# DISPLAY the first and last 5 records of the head and tail of the table < bio >

headtail(bio, 5) # Displayed the first and last 5 records of the data set bio

#5
# Using the code bio$species, display the levels of the species variable
# This will display the 8 categories contained in Species

levelsOfSpecies <- factor(bio$species)
categories <- levels(levelsOfSpecies)
categories # Displayed the Levels of Species variable

#6
# Use that code to create an object named  < tmp > that displays the different species
# and the number of records for each species

tmp <- summary(levelsOfSpecies)
tmp # Created an object called tmp and displayed the different species and the number of records for each species

#7
# Create a subset named < tmp2 > of just the species variable from the bio data
# and display the first five and last five records

tmp2 <- headtail(subset(bio, select = "species"), 5)
tmp2 # Created a subset called tmp2 and displayed the first and last 5 records of bio data set

#8
# Use the code bio$species alone and observe the results
bio$species
# It shows you all the observations based on the species names
# You want to know how many observations there are per species
# Use that code to create a TABLE named < Frequencies >
# Print values.
# This should display the Species in the data set and their frequencies

df <- data.frame(bio$species)
attach(df)
Frequencies <- table(df)
Frequencies # Displayed the species and their frequencies in a table
#9
# That table is not easy to observe
# Convert the < Frequencies > table to a data frame named < Frequencies_df >
# Display the results using an interactive table
# It should display Var1 and Freq (names given automatically)

Frequencies_df <- data.frame(Frequencies)
Frequencies_df
DT::datatable(
  Frequencies_df,
  class = "cell-border stripe",
  escape = TRUE,
  style = "default",
  editable = "cell"
) # Displayed the results using an Interactive Table

#10
# CREATE a table named  < SpecPct > that display the species and their percentages
# Make sure the values are rounded to 3 decimals only
# Print the results

SpecPct <- round(prop.table(table(bio$species)), 3) * 100
SpecPct # Created a table named SpecPct which displays the species and their percentages and rounded the decimals to 3

#11
# That table is not easy to observe
# Convert the table < SpecPct > to a data frame named < SpecPct_df >
# Column heads are again named Var1 and Freq, we will fix it

SpecPct_df <- data.frame(SpecPct)
SpecPct_df # Converted the table into a data frame for better analysis

#12
# RENAME the two columns in SpecPct_df as follows: Var1 to Species, Freq to Percentage
# Use the "rename" code
# Print the results

SpecPct_df %>% rename("Species" = Var1,
                      "Freq to Percentage" = Freq)
# Renamed the Var1 and Freq column names using rename code

#13
# Rearrange the SpecPct_df data frame in descending order of percentages

arrange(SpecPct_df, desc(SpecPct_df$Freq)) # Rearranged the SpecPct_df data frame in descending order of percentages

# NOW let's go back to Frequencies_df
#14
# RENAME the two columns in Frequencies_df as follows: Var1 to Species, Freq to Frequencies
# Use the "rename" code
# Print the results

Frequencies_df %>% rename("Species" = df,
                          "Frequencies" = Freq) # Renamed the Var1 and Freq column names using rename code

#15
# Rearrange the Frequencies_df data frame in descending order of Frequencies

arrange(Frequencies_df, desc(Frequencies_df$Freq)) # Rearranged the Frequencies_df data frame in descending order of Frequencies

#16
# ADD NEW VARIABLES to the < Frequencies_df > data frame using the "mutate" code
# Create an object with the name FinalTable
# Add (1) cumulative frequency as CumFrequencies,
# Add (2) Percentages as Percentage, make sure values are rounded to 4 decimals
# Add (3) cumulative Percentage as CumPercentage
# Print results
# Create an interactive table

cumFrequencies <-
  cumsum(Frequencies_df$Freq) # Calculated cumulative frequencies

percentages <-
  round(prop.table(table(Frequencies_df$Freq)), 4) * 100 # Added the percentage value and rounded to 4 decimals

cumPercentages <-
  round(cumsum(Frequencies_df$Freq) / sum(Frequencies_df$Freq), 4) * 100 # Calculated cumulative percentages

FinalTable <- Frequencies_df %>%
  mutate(
    CumFrequencies = cumFrequencies,
    Percentages = percentages,
    CumPercentages = cumPercentages
  ) # FinalTable object

DT::datatable(
  FinalTable,
  class = "cell-border stripe",
  escape = TRUE,
  style = "default",
  editable = "cell"
) # Final Interactive Table

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

freqData <- barplot(
  height = as.matrix(Frequencies_df$Freq),
  main = "Fish Counts Per Species",
  sub = "Data set InchBio",
  col.sub = "blue",
  xlab = "COUNTS",
  ylab = "SPECIES",
  beside = TRUE,
  legend = TRUE,
  width = 1.25,
  space = 0.05,
  border = NA,
  col = c(
    "black",
    "blue",
    "green",
    "darkblue",
    "orange",
    "cyan",
    "brown",
    "yellow"
  ),
  xlim = c(0, 350),
  ylim = c(0, 10),
  las = 2,
  cex.axis = 1,
  cex.names = 0.6,
  cex.lab = 1.1,
  names.arg = Frequencies_df$Var1,
  horiz = TRUE
) # Barplot of Frequency Data

legend(
  "right",
  c(
    "Black Crappie",
    "Bluegill",
    "Bluntnose Minnow",
    "Iowa Darter",
    "Largemouth Bass",
    "Pumpkinseed",
    "Tadpole Madtom",
    "Yellow Perch"
  ),
  fill = c(
    "black",
    "blue",
    "green",
    "darkblue",
    "orange",
    "cyan",
    "brown",
    "yellow"
  ),
  inset = c(-0.0005, 0.95),
  cex = 0.8,
  xpd = TRUE
) # Added Legend for easy identification of species

# 18
# CREATE a BARPLOT named < pc > with the following specifications:
# Use data set: FinalTable$Frequencies
# Width: 1, space:0.15, border: NA, axes:F,
# y-axis limits from 0 to 3.05*max(FinalTable$Frequencies, na.rm = TRUE)
# Scale x-axis fonts to 70%,
# names.arg: FinalTable$Species,
# Title: "Individual observations per fish species"
# For las, try 1 and 2, use the number that works best for you

pc <- barplot(
  height = as.matrix(FinalTable$Freq)[order(FinalTable$Freq, decreasing = TRUE)],
  main = "Individual observations per fish species",
  xlab = "SPECIES",
  beside = TRUE,
  width = 1,
  space = 0.15,
  border = NA,
  axes = F,
  col = c(
    "black",
    "blue",
    "green",
    "darkblue",
    "orange",
    "cyan",
    "brown",
    "yellow"
  ),
  xlim = c(0, 10),
  ylim = c(0, 3.05 * max(FinalTable$Freq, na.rm = TRUE)),
  las = 1,
  names.arg = FinalTable$df[order(FinalTable$Freq, decreasing = TRUE)],
  cex.names = 0.7
) # Created a Barplot with the given specifications in descending order

# 19
# Check in the following page, section Axes: https://www.statmethods.net/advgraphs/axes.html
# Create a custom LEFT axis label using the axis( ) function, with the following specifications
# Side = 2, thick marks at = c(0, 300)
# color: grey62,  color of axis: grey62, axis font (cex.axis) scaled to 80% of nominal

axis(
  side = 2,
  at = c(0, 300),
  col = "grey62",
  col.axis = "grey62",
  cex.axis = 0.8,
  las = 1
) # Added Left Axes label

# 20
# Create a custom RIGHT axis label using the axis( ) function, with the following specifications
# Side = 4, thick marks at = c(0, FinalTable$CumFrequencies)
# color: #D930DF,  color of axis: #D930DF, axis font (cex.axis) scaled to 80% of nominal

axis(
  side = 4,
  at = c(0, 3.05 * max(FinalTable$Freq, na.rm = TRUE)),
  col = "#D930DF",
  col.axis = "#D930DF",
  cex.axis = 0.8,
  las = 1
) # Added Right Axes Label


# 21
# Add custom titles to the right and left axes using the code: mtext()
# Check page https://www.statmethods.net/advgraphs/axes.html
# Left title "Counts", right title "Cumulative Frequencies
# Other characteristics (color, angle, size, etc) are your choice.

mtext(
  "Counts",
  side = 2,
  cex.lab = 1,
  las = 2,
  col = "blue"
) # Added left Title

mtext(
  "Cumulative Frequencies",
  side = 4,
  col = "red",
  cex.lab = 1
) # Added Right Title

# 22
# ADD a Cumulative counts line to the < pc > plot with the following specifications:
# Use data FinalTable$Cumfrequencies
# line type: b, scale plotting text at .7, data values: solid circles, color: cyan4
# Since we are not at this level yet, here is the code, observe the line

lines(
  pc,
  FinalTable$CumFrequencies,
  type = "b",
  cex = 0.7,
  pch = 19,
  col = "cyan4"
) # Added Cumulative counts line to the pc plot

#23
# Create a box plot to compare the total length (tl variable) among all 8 species
# For this box plot, you choose all the characteristics of the graph
# Use your knowledge and imagination

boxplot(
  tl ~ species,
  data = bio,
  ylab = "Total Length",
  xlab = "Species",
  xlim = c(0, 9),
  ylim = c(0, 420),
  main = "Total Length among all 8 Species",
  col = c(
    "black",
    "blue",
    "green",
    "darkblue",
    "orange",
    "cyan",
    "brown",
    "yellow"
  ),
  boxwex = 0.7,
  outline = TRUE,
  outpch = 16,
  outcol = "slategray3",
  las = 1
) # Created a box plot to compare the Total length among all the 8 species of the bio data set
