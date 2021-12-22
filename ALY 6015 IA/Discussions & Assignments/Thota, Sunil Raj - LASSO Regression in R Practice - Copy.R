# Intermediate Analytics
# ALY 6015
# Module 3 - LASSO Regression in R Practice
# 02/03/2021
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
install.packages("ncvreg")
install.packages("biglasso")
install.packages("bigmemory")
install.packages("glmnet")
install.packages("lars")

# Loaded the below libraries into the work space
library(plyr)
library(dplyr)
library(tidyr)
require(datasets)
library(biglasso)
library(bigmemory)
library(ncvreg)

# -----------------------------------------------------------------------------
# Exercise 1

library(lars)
data(diabetes)
attach(diabetes)

View(diabetes)
str(diabetes)
head(diabetes)

# Let's perform some Regularization analysis and techniques using "diabetes" data set. To get this data set we need to install the 'lars' package from the packages tab which is right side to the work space in R Studio.

# Or we can also install the packages by using install.packages("package name") command. Once it is loaded we can use it in the code for further analysis and calculations.

# Loaded the "lars" library into the work space. Loaded the diabetes Data set into the Environment. To reduce the repetitive usage of "x" in "diabetes" data set, "attach" is used to set it once throughout the work space.

# To View the diabetes Data set we use View() command, To observe the structure of the Data set we use str() command, and head () and tail() shows first and last few rows in the Data set

# -----------------------------------------------------------------------------
# Exercise 2

summary(x)

par(mfcol = c(2, 3))
for (idx in 1:10)
{
  if (idx == 1) {
    xLabel = "ages"
  }
  if (idx == 2) {
    xLabel = "sex"
  }
  if (idx == 3) {
    xLabel = "bmi"
  }
  if (idx == 4) {
    xLabel = "map"
  }
  if (idx == 5) {
    xlab = "tc"
  }
  if (idx == 6) {
    xLabel = "ldl"
  }
  if (idx == 7) {
    xLabel = "hdl"
  }
  if (idx == 8) {
    xLabel = "tch"
  }
  if (idx == 9) {
    xLabel = "ltg"
  }
  if (idx == 10) {
    xLabel = "glu"
  }
  plot(x[, idx], y,  xlab = xLabel)
  abline(lm(y ~ x[, idx]), col = "tomato")
}

# Summary() Provides the Descriptive Stats of the x variable in diabetes Data set. Once this is done, let's find out the list of elements which are present in "x" using looping concept (for loop).

# We noticed 10 variables from the statistics given in the summary. Now, let's plot Scatter plots for these variables and stack them in 2 rows and 5 columns

# To generate separate Scatter Plots with the line of best fit for all the predictors in "x" as horizontal axis vs "y" as  vertical axis.

# In this for loop I used 'idx' as index value for "x" variable and increased the value of 'idx' by iterating the loop 10 times.

# I have included conditional statements to allocate individual x-labels to their respective plots. abline() is used to plot a linear regression line on these plots.

# -----------------------------------------------------------------------------
# Exercise 3

linReglOLS <- lm(y ~ x)
linReglOLS
summary(linReglOLS)

# In this, we need to regress "y" on the predictors in "x" using Ordinary Least Squares(OLS). The regression model was taken between "y" and "x"

# Summary() gives us the descriptive stats and hypothesis testing values like Standard Error, p-Value, t-Value, r-squared value, f-Statistic, Degrees of Freedom, and etc.,

# This model is used as a baseline model to collate with the next upcoming models

# -----------------------------------------------------------------------------
# Exercise 4

library(glmnet)

modelLASSO <- glmnet(x, y, alpha = 1)
plot(modelLASSO,
     xvar = "norm",
     label = TRUE)

# LASSO regression is performed and for that to happen we use "glmnet" package from the packages tab to install or simply use install.packages("glmnet") command

# Now, let's load the "glmnet" in our work space to regularize the model using LASSO and plot it using plot(). This plot indicates at which stage each coefficients shrinks to 0. and the lines depicts the values used by various other coefficients

# -----------------------------------------------------------------------------
# Exercise 5

crossValidFit <- cv.glmnet(
  x = x,
  y = y,
  alpha = 1,
  nlambda = 1000
)
plot(crossValidFit)

minLambda <- crossValidFit$lambda.min
minLambda

# Here, Cross Validation is used to get the best value of lambda and plot the curve using plot(). It is possible with cv.glmnet() method. nlambda signifies the number of lambda values in sequence. In general, nlambda values must be above 100.

# From the plot we can depict that the value of lambda increased when the number of selected variables narrows down. This tells that higher the value of lambda, more shrink the selection is. Now, we find the min. value of lambda to get the best fit

# -----------------------------------------------------------------------------
# Exercise 6

estBetaMatFit <- glmnet(
  x = x,
  y = y,
  alpha = 1,
  lambda = minLambda
)
estBetaMatFit$beta
estBetaMatFit$lambda

# Here, we use the minimum lambda value again in glmnet() function to get the best fit

# There are 3 coefficients namely age, ldl, tch whose values have become 0. It's clear that these variables are not so necessary to determine the value of "y".

# -----------------------------------------------------------------------------
# Exercise 7

# Now we use a higher value of lambda that is within one standard error of the minimum to check its effect on shrinkage.

lambdaWithOneSE <- crossValidFit$lambda.1se
lambdaWithOneSE

latestFit <- glmnet(
  x = x,
  y = y,
  alpha = 1,
  lambda = lambdaWithOneSE
)

latestFit$beta

# Here, we use the minimum lambda value again in glmnet() function to get the best latest fit

# There are 6 coefficients namely age, sx, tc, ldl, tch, and glu whose values have become 0. It's clear that these variables are not so necessary to determine the value of "y". LASSO tells that only 4 variables are necessary on which y depends. Thus the shrinkage increases

# -----------------------------------------------------------------------------
# Exercise 8

linReglOLS2 <- lm(y ~ x2)
summary(linReglOLS2)

# In this, we need to regress "y" on the predictors in "x2" using Ordinary Least Squares(OLS). The regression model was taken between "y" and "x"2

# Summary() gives us the descriptive stats and hypothesis testing values like Standard Error, p-Value, t-Value, r-squared value, f-Statistic, Degrees of Freedom, and etc., From this we can see that there are more number of predictors in x2 than x.

# -----------------------------------------------------------------------------
# Exercise 9

modelLASSO2 <- glmnet(x2, y, alpha = 1)
plot(modelLASSO2, xvar = "norm", label = TRUE)

# LASSO regression is performed and for that to happen we use "glmnet" package from the packages tab to install or simply use install.packages("glmnet") command

# Now, let's load the "glmnet" in our work space to regularize the model using LASSO and plot it using plot(). This plot are complex and the lines depicts the values used by various other coefficients

# -----------------------------------------------------------------------------
# Exercise 10

crossValidFit2 <- cv.glmnet(
  x = x2,
  y = y,
  alpha = 1,
  nlambda = 1000
)

plot(crossValidFit2)
minLambda2 <- crossValidFit2$lambda.min

estBetaMatFit2 <- glmnet(
  x = x2,
  y = y,
  alpha = 1,
  lambda = minLambda2
)
estBetaMatFit2$beta
estBetaMatFit2$lambda

# Here, Cross Validation is used to get the best value of lambda and plot the curve using plot(). It is possible with cv.glmnet() method. nlambda signifies the number of lambda values in sequence. In general, n lambda values must be above 100.

# From the plot we can depict that the value of lambda increased when the number of selected variables narrows down. This tells that higher the value of lambda, more shrink the selection is. Now, we find the min. value of lambda to get the best fit

# Here, we use the minimum lambda value again in glmnet() function to get the best fit. There are 50 coefficients whose values have become 0. It's clear that these variables are not so necessary to determine the value of "y". With this it shrinkage's the variables and it regularizes the model.

# -----------------------------------------------------------------------------