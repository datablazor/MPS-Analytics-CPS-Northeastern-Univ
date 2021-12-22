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
install.packages("readxl")

# Loaded the below libraries into the workspace
library(plyr)
library(dplyr)
library(tidyr)
library(tidyverse)
library(ggplot2)
library(e1071)
library(MASS)
library(readxl)
library(ggcorrplot)
library(GGally)
require(grDevices)
require(datasets)
#-----------------------------------------------------------------------------
# Part A
#-----------------------------------------------------------------------------
dataCSV <- read_excel("students.xls")
dataCSV
View(dataCSV) # To View the Trees Data set
str(dataCSV) # To observe the structure of the Data set
head(dataCSV) # It shows first few rows in the Data set
summary(dataCSV) # Provides the Descriptive Stats of the Trees Data set


popSD <-
  sd(dataCSV$SAT) * sqrt((length(dataCSV$SAT) - 1) / (length(dataCSV$SAT)))
popSD

popMean <- mean(dataCSV$SAT)
popMean

zScore <- (dataCSV$SAT - popMean) / popSD
zScore

zScoreData <- cbind(dataCSV, zScore)
zScoreData

write_excel_csv(zScoreData, "student.xls")

lessthan70 <- pnorm(1680, popMean, popSD) * 100
lessthan70

morethan70 <- 100 - lessthan70
morethan70


meanHt <- mean(dataCSV$`Height (in)`)
meanHt

varHt <- var(dataCSV$`Height (in)`)
varHt

z.test = function(a, meanHt, varHt) {
  zeta = (mean(a) - meanHt) / (sqrt(var / length(a)))
  return(zeta)
}

a <- dataCSV$`Height (in)`
a
z <- z.test(a, 66.43333, 21.7023)
z
