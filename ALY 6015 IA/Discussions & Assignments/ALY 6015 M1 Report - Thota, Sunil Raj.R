# Intermediate Analytics
# ALY 6015
# Module 1 - Descriptive Statistics and Regression Analysis with R
# 01/21/2021
# Sunil Raj Thota
# NUID: 001099670

#-----------------------------------------------------------------------------
# Get and set the working directories
getwd()
setwd('G:/NEU/Coursework/2021 Q1 Winter/ALY 6015 IA/Discussions & Assignments')
getwd()

# Installed the above packages into the workspace
install.packages("datasets")
install.packages("plyr")
install.packages("dplyr")
install.packages("tidyr")
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("ggcorrplot")
install.packages("e1071")
install.packages("DAAG")
install.packages("MASS")
install.packages("GGally")

# Loaded the below libraries into the workspace
library(plyr)
library(dplyr)
library(tidyr)
library(tidyverse)
library(ggplot2)
library(e1071)
library(MASS)
library(DAAG)
library(ggcorrplot)
library(GGally)
require(grDevices)
require(datasets)
#-----------------------------------------------------------------------------
# Part A
#-----------------------------------------------------------------------------
data(trees) # Load the Trees Data set into the Environment
View(trees) # To View the Trees Data set
str(trees) # To observe the structure of the Data set
head(trees) # It shows first few rows in the Data set
summary(trees) # Provides the Descriptive Stats of the Trees Data set

cor(trees) # Shows the Correlation of the 3 variables in the Trees Data set

plot(
  x = trees$Girth,
  y = trees$Volume,
  xlab = "Girth (in.)",
  ylab = "Volume (cubic ft.)",
  main = "Relationship between Girth and Volume",
  col = "purple",
  pch = 20,
  xlim = c(min(trees$Girth), max(trees$Girth)),
  ylim = c(min(trees$Volume), max(trees$Volume))
) # Scatter Plot is used to depict the relationship between the Girth and Volume
lm(Volume ~ Girth, data = trees) # Linear Model between the Volume and Girth
abline(lm(Volume ~ Girth, data = trees), col = "tomato") # To observe the Regression Line

#-----------------------------------------------------------------------------
hist(
  trees$Girth,
  main = "Histogram Plot - Girth",
  xlab = "Girth (in. )",
  ylab = "Frequency ",
  border = "black",
  labels = TRUE,
  xlim = c(0, 25),
  ylim = c(0, 15),
  col = rainbow(7),
  density = 100
) # Histogram Plot is used to show case the Frequency Distribution of the Girth

plot(
  density(trees$Girth),
  main = "Density Plot - Girth",
  xlab = "Girth in (in. )",
  ylab = "Probability",
  col = "purple"
) # Density Plot is used to show case the Probability Distribution of the Girth

boxplot(
  trees$Girth,
  main = "Box Plot - Girth",
  ylab = "Girth in (in. )",
  xlab = "Girth",
  col = "brown1",
  boxwex = 0.3,
  outline = TRUE,
  outpch = 16,
  outcol = "seagreen3",
  las = 1,
  notch = FALSE,
  staplewex = 1
) # Box Plot is used to determine the Quartiles of the Girth

qqnorm(trees$Girth,
       main = "Normal Probability Plot - Girth",
       col = rainbow(7),
       pch = 20) # Normal Probability Plot of the Girth

skewness(trees$Girth) # Skewness measures the relative size of the Girth
kurtosis(trees$Girth) # Kurtosis measures the amount of Prob. in the Girth

#-----------------------------------------------------------------------------
hist(
  trees$Height,
  main = "Histogram Plot - Height",
  xlab = "Height (ft. )",
  ylab = "Frequency",
  border = "black",
  labels = TRUE,
  xlim = c(60, 90),
  ylim = c(0, 12),
  col = rainbow(7),
  density = 100,
) # Histogram Plot is used to show case the Frequency Distribution of the Height

plot(
  density(trees$Girth),
  main = "Density Plot - Height",
  xlab = "Height in (ft. )",
  ylab = "Probability",
  col = "tomato"
) # Density Plot is used to show case the Probability Distribution of the Height

boxplot(
  trees$Height,
  main = "Box Plot - Height",
  ylab = "Height (ft. )",
  xlab = "Height",
  col = "darkorchid",
  boxwex = 0.3,
  outline = TRUE,
  outpch = 16,
  outcol = "seagreen3",
  las = 1,
  notch = FALSE,
  staplewex = 1
) # Box Plot is used to determine the Quartiles of the Height

qqnorm(trees$Height,
       main = "Normal Probability Plot - Height",
       col = rainbow(7),
       pch = 20) # Normal Probability Plot of the Height

skewness(trees$Height) # Skewness measures the relative size of the Height
kurtosis(trees$Height) # Kurtosis measures the amount of Prob. in the Height

#-----------------------------------------------------------------------------
hist(
  trees$Volume,
  main = "Histogram Plot - Volume",
  xlab = "Volume (cubic ft. )",
  ylab = "Frequency",
  border = "black",
  labels = TRUE,
  xlim = c(10, 80),
  ylim = c(0, 12),
  col = rainbow(7),
  density = 100,
) # Histogram Plot is used to show case the Frequency Distribution of the Volume

plot(
  density(trees$Volume),
  main = "Density Plot - Volume",
  xlab = "Volume in (cubic ft. )",
  ylab = "Probability",
  col = "blue"
) # Density Plot is used to show case the Probability Distribution of the Volume

boxplot(
  trees$Volume,
  main = "Box Plot - Volume",
  ylab = "Volume (cubic ft. )",
  xlab = "Volume",
  col = "pink",
  boxwex = 0.3,
  outline = TRUE,
  outpch = 16,
  outcol = "seagreen3",
  las = 1,
  notch = FALSE,
  staplewex = 1
) # Box Plot is used to determine the Quartiles of the Volume

qqnorm(trees$Volume,
       main = "Normal Probability Plot - Volume",
       col = rainbow(7),
       pch = 20) # Normal Probability Plot of the Volume

skewness(trees$Volume) # Skewness measures the relative size of the Volume
kurtosis(trees$Volume) # Kurtosis measures the amount of Prob. in the Volume

#-----------------------------------------------------------------------------
# Part B
#-----------------------------------------------------------------------------
data(Rubber) # Load the Rubber Data set into the Environment
View(Rubber) # To View the Rubber Data set
str(Rubber) # To observe the structure of the Data set
head(Rubber) # It shows first few rows in the Data set
summary(Rubber) # Provides the Descriptive Stats of the Rubber Data set

log(Rubber) # Log computes logarithms of the Rubber Data set
regRubber <-
  lm(loss ~ hard + tens, data = Rubber) # Linear Model between the Loss and all others
regRubber
summary(regRubber) # Provides the Descriptive Stats of the Linear Model

corrRubber <-
  cor(Rubber) # Shows the Correlation of the 3 variables in the Rubber Data set

ggcorrplot(
  corrRubber,
  ggtheme = ggplot2::theme_minimal,
  title = "Correlation Plot - Rubber",
  hc.order = TRUE,
  colors = c("orchid", "white", "brown1"),
  outline.col = "white",
  lab = TRUE,
  method = "square",
  show.legend = TRUE,
  legend.title = "Corr.",
  lab_col = "black",
  lab_size = 4
) # Shows the Correlation Plot of the 3 variables in the Rubber Data set

ggpairs(
  Rubber,
  mapping = NULL,
  columns = 1:ncol(Rubber),
  title = "Correlation, Density and Scatter Plots - Rubber",
  upper = list(continuous = "cor"),
  lower = list(continuous = "points"),
  diag = list(continuous = "densityDiag"),
  axisLabels = c("show", "internal", "none"),
) # Shows the Correlation, Density, and Scatter Plots of the 3 variables in the Rubber Data set

#-----------------------------------------------------------------------------
data(oddbooks) # Load the Odd Books Data set into the Environment
View(oddbooks) # To View the Odd Books Data set
str(oddbooks) # To observe the structure of the Data set
head(oddbooks) # It shows first few rows in the Data set
summary(oddbooks) # Provides the Descriptive Stats of the Odd Books Data set

logOddBooks <-
  log(oddbooks) # Log computes logarithms of the Odd Books Data set
logOddBooks
regOddBooks <-
  lm(weight ~ thick + height + breadth, data = logOddBooks) # Linear Model between the Weight and all others
regOddBooks
summary(regOddBooks) # Provides the Descriptive Stats of the Linear Model

corrOddBooks <-
  cor(oddbooks) # Shows the Correlation of the 4 variables in the Odd Books Data set

ggcorrplot(
  corrOddBooks,
  ggtheme = ggplot2::theme_minimal,
  title = "Correlation Plot - OddBooks",
  hc.order = TRUE,
  colors = c("purple", "white", "pink"),
  outline.col = "white",
  lab = TRUE,
  method = "square",
  show.legend = TRUE,
  legend.title = "Corr.",
  lab_col = "black",
  lab_size = 4
) # Shows the Correlation Plot of the 4 variables in the Odd Books Data set

ggpairs(
  oddbooks,
  mapping = NULL,
  columns = 1:ncol(oddbooks),
  title = "Correlation, Density and Scatter Plots - OddBooks",
  upper = list(continuous = "cor"),
  lower = list(continuous = "points"),
  diag = list(continuous = "densityDiag"),
  axisLabels = c("show", "internal", "none"),
) # Shows the Correlation, Density, and Scatter Plots of the 4 variables in the Odd Books Data set
#-----------------------------------------------------------------------------