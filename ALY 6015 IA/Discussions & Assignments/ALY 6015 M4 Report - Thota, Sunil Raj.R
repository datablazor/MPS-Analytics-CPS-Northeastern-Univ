# Intermediate Analytics
# ALY 6015
# Module 3 - Regularization Assignment
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

# Loaded the below libraries into the work space
library(plyr)
library(dplyr)
library(tidyr)
require(datasets)
library(biglasso)
library(bigmemory)
library(ncvreg)

#------------------------------------------------------------------------------
data(mtcars)
attach(mtcars)

View(mtcars)
head(mtcars)
tail(mtcars)
str(mtcars)
summary(mtcars)

# Let's perform some Regularization analysis and techniques using "mtcars" data set. This data set is readily available in the R Studio and can be loaded to the work space in R Studio. Or we can also install the packages by using install.packages("packagename") command. Once it is loaded we can use it in the code for further analysis and calculations.

# Loaded the "mtcars" data into the work space. To reduce the repetitive usage of "mtcars" data set, "attach" is used to set it once throughout the work space. To View the diabetes Data set we use View() command, To observe the structure of the Data set we use str() command, and head () and tail() shows first and last few rows in the Data set. Summary() Provides the Descriptive Stats of the x variable in diabetes Data set.

#------------------------------------------------------------------------------

y <- mtcars$hp
y

x <- data.matrix(mtcars[, c('mpg', 'wt', 'drat', 'qsec')])
x

linReglOLS <- lm(y ~ x)
linReglOLS
summary(linReglOLS)

# Here "y" variable is taken as the response variable. Here "x" is assigned with a matrix of predictor variables

# In this, we need to regress "y" on the predictors in "x" using Ordinary Least Squares(OLS). The regression model was taken between "y" and "x"

# Summary() gives us the descriptive stats and hypothesis testing values like Standard Error, p-Value, t-Value, r-squared value, f-Statistic, Degrees of Freedom, and etc.,

# This model is used as a baseline model to collate with the next upcoming models

#------------------------------------------------------------------------------
library(glmnet)

lambdaSeq <- 10 ^ seq(2, -2, by = -.1)
lambdaSeq

ridgeFit <- glmnet(x, y, alpha = 0, lambda  = lambdaSeq)
ridgeFit
summary(ridgeFit)

# Setting the range of lambda values and Using glmnet() method to build the ridge regression in R. Checking the model using the Summary()

#------------------------------------------------------------------------------
modelLASSO <- glmnet(x, y, alpha = 1)
modelLASSO
plot(modelLASSO,
     xvar = "norm",
     label = TRUE)

# LASSO regression is performed and for that to happen we use "glmnet" package from the packages tab to install or simply use install.packages("glmnet") command

# Now, let's load the "glmnet" in our work space to regularize the model using LASSO and plot it using plot(). This plot indicates at which stage each coefficients shrinks to 0. and the lines depicts the values used by various other coefficients

#------------------------------------------------------------------------------

cvModel <- cv.glmnet(x, y, alpha = 1)
cvModel

bestLambda <- cvModel$lambda.min
bestLambda

plot(cvModel)

# Here, Cross Validation is used to get the best value of lambda and plot the curve using plot(). It is possible with cv.glmnet() method. nlambda signifies the number of lambda values in sequence. In general, nlambda values must be above 100.

# Let's find optimal lambda value that minimizes test MSE and perform K-Fold Cross validation to find optimal lambda value. At last, let's produce the plot of test MSE by lambda value.

# From the plot we can depict that the value of lambda increased when the number of selected variables narrows down. This tells that higher the value of lambda, more shrink the selection is. Now, we find the min. value of lambda to get the best fit

#------------------------------------------------------------------------------

lambdaWithOneSE <- cvModel$lambda.1se
lambdaWithOneSE

latestFit <- glmnet(
  x = x,
  y = y,
  alpha = 1,
  lambda = lambdaWithOneSE
)

latestFit$beta

# Here, we use the minimum lambda value again in glmnet() function to get the best latest fit. Now we use a higher value of lambda that is within one standard error of the minimum to check its effect on shrinkage.

# There are 1 coefficients namely "drat" whose values have become 0. It's clear that this variable is not so necessary to determine the value of "y". LASSO tells that only 3 variables are necessary on which y depends. Thus the shrinkage increases.

#------------------------------------------------------------------------------

bestModel <- glmnet(x, y, alpha = 1, lambda = bestLambda)
coef(bestModel)

newObs <- matrix(c(21, 2.1, 3.6, 18.0), nrow = 1, ncol = 4)
newObs

predict(bestModel, s = bestLambda, newx = newObs)

yPred <- predict(bestModel, s = bestLambda, newx = x)

sstValue <- sum((y - mean(y)) ^ 2)
sseValue <- sum((yPred - y) ^ 2)

rSquaredVal <- 1 - sseValue / sstValue
rSquaredVal

# To find the coefficients of best model, let's define a new observation and use LASSO regression model to predict response value. Use fitted best model to make predictions. Let's find SST, SSE, and R-Squared values for the new observation

# -----------------------------------------------------------------------------