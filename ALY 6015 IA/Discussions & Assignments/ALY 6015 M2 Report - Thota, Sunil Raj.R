# Intermediate Analytics
# ALY 6015
# Module 1 - Hypothesis Testing with R
# 01/30/2021
# Sunil Raj Thota
# NUID: 001099670

#-----------------------------------------------------------------------------
# Get and set the working directories
getwd()
setwd('G:/NEU/Coursework/2021 Q1 Winter/ALY 6015 IA/Discussions & Assignments')
getwd()

# Installed the above packages into the work space

install.packages("datasets")
install.packages("plyr")
install.packages("dplyr")
install.packages("tidyr")
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("ggcorrplot")

# Loaded the below libraries into the workspace
library(plyr)
library(dplyr)
library(tidyr)
library(tidyverse)
library(ggplot2)
library(ggcorrplot)
require(grDevices)
require(datasets)

data(mtcars) # Load the mtcars Data set into the Environment
View(mtcars) # To View the mtcars Data set
head(mtcars) # It shows first few rows in the Data set
tail(mtcars) # It shows last few rows in the Data set
summary(mtcars) # Provides the Descriptive Stats of the mtcars Data set

mtcars$am <- factor(mtcars$am)
mtcars$am

str(mtcars) # To observe the structure of the Data set
#-----------------------------------------------------------------------------
hist(
  mtcars$mpg,
  ylab = "Frequency",
  xlab = "MPG",
  breaks = 10,
  xlim = c(min(mtcars$mpg), 35),
  main = "MPG Histogram",
  ylim = c(0, 8),
  col = "brown1",
  border = FALSE
) # Histogram of mpg
#-----------------------------------------------------------------------------

plot(
  density(mtcars$mpg),
  main = "Density Plot - MPG",
  xlab = "MPG",
  ylab = "Probability",
  col = "purple"
) # Density Plot of mpg
#-----------------------------------------------------------------------------

hist(
  mtcars$disp,
  ylab = "Frequency",
  xlab = "DISP",
  breaks = 9,
  xlim = c(min(mtcars$mpg), 500),
  main = "DISP Histogram",
  ylim = c(0, 8),
  col = "darkorchid",
  border = FALSE
) # Histogram of disp
#-----------------------------------------------------------------------------

plot(
  density(mtcars$disp),
  main = "Density Plot - DISP",
  xlab = "DISP",
  ylab = "Probability",
  col = "purple"
) # Density Plot of disp
#-----------------------------------------------------------------------------

plot(
  x = mtcars$mpg,
  y = mtcars$am,
  xlab = "MPG",
  ylab = "AM",
  main = "Relationship between mpg and am",
  col = "purple",
  pch = 20,
  xlim = c(min(mtcars$mpg), max(mtcars$mpg))
) # Scatter Plot is used to depict the relationship between the MPG and AM

#-----------------------------------------------------------------------------
boxPltMPGandAM <-
  data.frame(mtcars$mpg, mtcars$am) # Boxplot of mpg and am
ggplot(boxPltMPGandAM,
       aes(
         x = mtcars$am,
         y = mtcars$mpg,
         fill = mtcars$am
       )) + geom_boxplot(color = "brown",
                         alpha = 0.3,
                         fill = "purple") + ggtitle("am ~ mpg Boxplot") + ylab("mpg") + xlab("am") + theme_bw() # GGplot is used to plot the Boxplot

#-----------------------------------------------------------------------------
lmFit <- lm(mpg ~ am, data = mtcars)
lmFit # Linear Model relationship between mpg and am in mtcars dataset
summary(lmFit) # Summary Stats of the linear model
rSquared <- summary(lmFit)$r.squared
rSquared # r squared value

lmFitAll <- lm(mpg ~ wt + am + wt:am + qsec, data = mtcars)
lmFitAll # Linear Model relationship between mpg and all other parameters in mtcars dataset
summary(lmFitAll) # Summary Stats of the linear model
rSquaredAll <- summary(lmFitAll)$r.squared
rSquaredAll # r squared value

confint(lmFitAll) # confidence interval of the Linear Model

par(mfrow = c(2, 2)) # To form the Plots in a 2X2 matrix
plot(lmFitAll, which = 1:4)# Plotted the residuals vs fitted, normal QQ, Scale-location, and Cooks distance plots

#-----------------------------------------------------------------------------
tTestMPG <- t.test(mtcars$mpg, mu = 20)
tTestMPG # Performed One-sample T Test

#-----------------------------------------------------------------------------
twoSampleTTest <-
  t.test(
    mpg ~ am,
    data = mtcars,
    var.equal = FALSE,
    paired = FALSE ,
    conf.level = .95
  )
twoSampleTTest # Performed Two-sample T Test

#-----------------------------------------------------------------------------
tTestPaired <-
  t.test(mtcars$mpg,
         mtcars$disp,
         paired = TRUE,
         alternative = "less")
tTestPaired # Performed Paired T Test

#-----------------------------------------------------------------------------
tableDataSet <- table(mtcars$mpg, mtcars$am)
propTestMtcars <- prop.test(tableDataSet,
                            conf.level = 0.95,
                            alternative = "two.sided")
propTestMtcars # Performed Prop Test

#-----------------------------------------------------------------------------

varTestMtcars <-
  var.test(mtcars$mpg, mtcars$disp)
varTestMtcars # Performed Var Test

#-----------------------------------------------------------------------------