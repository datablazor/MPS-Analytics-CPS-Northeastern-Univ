# Integrated Experiential Learning
# ALY 6080
# Exploratory Data Analysis using R
# 04/28/2021
# Team: Sunil Raj Thota

#-----------------------------------------------------------------------------
# Get and set the working directories
getwd()
setwd('G:/NEU/Coursework/2021 Q2 Spring/ALY 6080 IEL/Discussions & Assignments')
getwd()

# Installed the above packages into the work space
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
install.packages("gmodels")
install.packages("GGally")
install.packages("gridExtra")

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
library(gmodels)
require(grDevices)
require(datasets)
library(gridExtra)

airData <- read.csv("annual_conc_by_monitor_2020.csv")
airData
str(airData)
summary(airData)
View(airData)
nrow(airData)
ncol(airData)
head(airData)
tail(airData)

boxplot(
  airData$Valid.Day.Count,
  col = "antiquewhite3",
  main = "Valid Day Count",
  outcol = "Blue",
  outpch = 19,
  boxwex = 0.7
)

plot(
  airData$Primary.Exceedance.Count,
  airData$X75th.Percentile,
  main = "Primary Exceedance Count vs 75th Percentile",
  xlab = "Primary Exceedance Count",
  ylab = "75th Percentile",
  pch = 19,
  ylim = c(0, 160),
  col = "blue"
)

