# ALY6010V4B-M1-Project1
# Probability Theory and Introduction to Statistics
# ALY 6010 - 71709 (CRN Number)
# Project 1
# 10/30/2020
# Sunil Raj Thota
# NUID: 001099670

install.packages("dplyr")
install.packages("ggplot2")
# Installed Necessary Libraries to work on them further
library(ggplot2)
library(dplyr)
# Loaded the above libraries into the workspace



#A0 ACCESSING YOUR DATASET: execute the following line of code
source("http://www.openintro.org/stat/data/cdc.R")
# Executed the cdc dataset from the above URL



#A-1: Explore the cdc dataset: Provide names of variables, the number of records
##Verify you have the cdc dataset: Display the first few records of cdc
#Summarize statistics on all variables.
names(cdc)
nrow(cdc)
View(cdc) # To View the cdc Datas0et
str(cdc)
# The names of variables are genhlth, exerany, hlthplan, smoke100, height, weight, wtdesire, age, and gender
# There are 20000 observations with 9 variables
head(cdc) # This shows the first few records of the dataset
summary(cdc) # Summarized  Descriptive Statistics on all the varaibles



#A-2 Display a scatter plot of height versus weight...
cdcScatterPlot <- ggplot(cdc, aes(height, weight)) +
  ggtitle("Scatterplot of Height versus Weight") +
  xlab("Height") +
  ylab("Weight") +
  geom_point(shape = 1,
             color = "black",
             size = 2) +
  theme(
    plot.title = element_text(color = "darkorchid4",
                              size = 14,
                              face = "bold.italic"),
    axis.title.x = element_text(color = "coral",
                                size = 14,
                                face = "bold"),
    axis.title.y = element_text(color = "deeppink2",
                                size = 14,
                                face = "bold")
  )
cdcScatterPlot # Scatter Plot of Height vs Weight



#A3 Create an temp object < cdcP1 > # Randomly Select and display 3 rows from cdcP1
cdcP1 <- cdc[sample(nrow(cdc), 3), ]
cdcP1 # Randomly selected and didplayed 3 rows from the cdcP1 temporary object



#A4 Create a  < subsetCDC > which includes only  attribute height, weight gender
#Display the first 3 records of < subsetCDC >
subsetCDC <- subset(cdc, select = c("height", "weight", "gender"))
head(subsetCDC, 3) # Created a subset which included only height, weight, and gender attributes and displayed the first 3 records of it



#A5 Create an object < snapShot > which includes a random subset of 100 records from
snapShot <- subset(cdc[sample(100), ])
snapShot # Created an object snapShot which includes a random subset of 100 records



#A6 Display 100 records (weight and gender only) of snapShot's
subSnapShot <- subset(snapShot, select = c("weight", "gender"))
subSnapShot # Displayed 100 records of weight and gender only of snapShot



#A7 Create a < tmp > file of the first 50 records from < snapShot >
tmp <- tempfile()
tmp # Created a tmp file

write.csv(cdc, file = tmp)
list.files(tempdir())

file.snapShot <- read.csv(tmp)
str(file.snapShot) # Structure of the file

file.snapShot <- head(file.snapShot, 50)
file.snapShot # First 50 records from snapShot



#A8 DISPLAY the "gender" column of the tmp object
View(file.snapShot)
file.snapShot$gender # Displayed the gender column of the tmp object



#A9 CREATE an object < cols > with the two elements: "red" and "gray60"
#and an object < pchs > object with integers 3 and 4
cols <- c("red", "gray60")
cols # Created an object called cols with two elements red and gray60
pchs <- c(3, 4)
pchs # Created an object called pchs with two integers 3 and 4



#A10 CONVERT the tmp$gender to numeric
file.snapShot$gender <- factor(c("m", "f"))
genderNumeric <- as.numeric(file.snapShot$gender)
genderNumeric # Converted the tmp$gender to numeric



#A11 Associate the cols object with tmp era gender values
plot(genderNumeric, col = cols) # Associate the cols object with tmp era gender values in a scatter plot



#A12 Plot a scatter plot of the less cluttered < snapShot > title="50 Records,
#label the X and Y axis as Weight and Height, change the data symbol to < + > and color red
snapShotScatterPlot <- ggplot(file.snapShot, aes(weight, height)) +
  ggtitle("50 Records") +
  xlab("Weight") +
  ylab("Height") +
  geom_point(shape = 3,
             color = "red",
             size = 3) +
  theme(
    plot.title = element_text(color = "darkorchid4",
                              size = 14,
                              face = "bold.italic"),
    axis.title.x = element_text(color = "coral",
                                size = 14,
                                face = "bold"),
    axis.title.y = element_text(color = "deeppink2",
                                size = 14,
                                face = "bold")
  )
snapShotScatterPlot # Plotted a sactterplot of the less cluttered snapshot with 50 Records



#A13 Let's unclutter some more: Reduce the snapShot records to only those for females. Display
snapShotFemales <- filter(snapShot, gender == "f")
snapShotFemales # Reduced the snapshot records to only those for females and displayed



#A14 plot the female only version of  snapShot..label appropriately. Change col to blue
snapShotScatterPlotOfFemaleOnly <-
  ggplot(snapShotFemales, aes(weight, height)) +
  ggtitle("Female Only Version of SnapShot") +
  xlab("Weight") +
  ylab("Height") +
  geom_point(shape = 2,
             color = "blue",
             size = 3) +
  theme(
    plot.title = element_text(color = "darkorchid4",
                              size = 14,
                              face = "bold.italic"),
    axis.title.x = element_text(color = "coral",
                                size = 14,
                                face = "bold"),
    axis.title.y = element_text(color = "deeppink2",
                                size = 14,
                                face = "bold")
  )
snapShotScatterPlotOfFemaleOnly # Plotted a sactterplot of the Female only version of snapshot



#A15 Add regression line to the Female snapshot plot with dashed color < cadetblue > regression
bestFit <- lm(weight ~ height,
              data = snapShotFemales)
summary(bestFit)
fitted(bestFit)
residuals(bestFit)

with(
  snapShotFemales,
  plot(
    height,
    weight,
    xlab = "Height",
    ylab = "Weight",
    main = "Female Snapshot Plot with Regression Line",
    col.lab = "blue",
    pch = 3
  )
)
abline(lm(snapShotFemales$weight ~ snapShotFemales$height),
       col = "cadetblue") # Plotted a sactterplot of the Female only version of snapshot with Regression line