# Introduction to Enterprise Analytics
# ALY 6050
# Week 2 Project 2
# 03/15/2021
# Sunil Raj Thota

#-----------------------------------------------------------------------------
# Get and set the working directories
getwd()
setwd('G:/NEU/Coursework/2021 Q1 Winter/ALY 6050 IEA/Discussions & Assignments')
getwd()

# Installed the above packages into the work space
install.packages("plyr")
install.packages("dplyr")
install.packages("tidyr")
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("Rmisc")
install.packages("MASS")
install.packages("triangle")
install.packages("Hmisc")
install.packages("PASWR2")

# Loaded the below libraries into the work space
library(plyr)
library(dplyr)
library(tidyr)
library(tidyverse)
library(ggplot2)
library(MASS)
library(Rmisc)
library(triangle)
library(Hmisc)
library(PASWR2)

#------------------------------------------------------------------------------
# Problem 1

minVal <- 20
maxVal <- 300
peakVal <- 80

analysisSim <- runif(5000)

rv1 <-
  minVal + sqrt((maxVal - minVal) * (peakVal - minVal) * analysisSim)
rv2 <-
  maxVal - sqrt((1 - analysisSim) * (maxVal - minVal) * (maxVal - peakVal))
rv3 <- (peakVal - minVal) / (maxVal - minVal)

xRandomVals <- ifelse(analysisSim < rv3, rv1, rv2)
hospNames <-
  c(
    "Beth Israel Medical",
    "Tufts Medical",
    "Massachusetts General",
    "Boston Medical",
    "Brigham and Women's"
  )

avgTransTimeMins <- c(7, 10, 15, 15, 20)
tranTimeHours <- avgTransTimeMins / 60
hospAllocDisasterVictims <- c(0.3, 0.15, 0.2, 0.25, 0.1)
hospitalAll <-
  data.frame(hospNames,
             hospAllocDisasterVictims,
             avgTransTimeMins,
             tranTimeHours)
hospitalAll

# Problem 1(i)

bethIsraelMed <- hospAllocDisasterVictims[1] * xRandomVals
tuftsMed <- hospAllocDisasterVictims[2] * xRandomVals
massGenMed <- hospAllocDisasterVictims[3] * xRandomVals
bostonMed <- hospAllocDisasterVictims[4] * xRandomVals
brighamAndWomensMed <- hospAllocDisasterVictims[5] * xRandomVals

avgNumOfVictimsAtHosp <-
  data.frame(
    "Hospital" = hospNames,
    "Avg_No_of_Victims_at_Hospitals" = c(
      mean(bethIsraelMed),
      mean(tuftsMed),
      mean(massGenMed),
      mean(bostonMed),
      mean(brighamAndWomensMed)
    )
  )
avgNumOfVictimsAtHosp

# Problem 1(ii)

avgTimeHours <-
  avgNumOfVictimsAtHosp$Avg_No_of_Victims_at_Hospitals * hospitalAll$tranTimeHours

avgTimeAll <-
  data.frame("Hospital" = hospNames, "Avg_Time_hours" = avgTimeHours)
avgTimeAll

# Problem 1(iii)

bethIsraelMedMean <- mean(bethIsraelMed)
bethIsraelMedMean

maxSampleSize <- 5000
meanVals <- rep(0, maxSampleSize)

for (i in 1:maxSampleSize) {
  s <- sample(bethIsraelMed, i)
  meanVals[i] <- mean(s)
}

lowOfLargeNums <-
  data.frame("No_of_Samples" = seq(1, maxSampleSize),
             "Mean_Values" = meanVals)

lowOfLargeNumsPlot <- ggplot(lowOfLargeNums,
                             aes(seq(1, maxSampleSize), meanVals)) +
  geom_point() +
  geom_hline(yintercept = mean(bethIsraelMed),
             color = "tomato")

lowOfLargeNumsFinal <-
  lowOfLargeNumsPlot +
  labs(title = "Law of Large Numbers - Beth Israel Medical Hospital",
       x = "Sample Size",
       y = "Sample Mean")
lowOfLargeNumsFinal

# Problem 1(iv)

bethIsraelMedTotalTransTime <- bethIsraelMed * tranTimeHours[1]
bethIsraelMedTotalTransTime

summary(bethIsraelMedTotalTransTime)
eda(bethIsraelMedTotalTransTime)
describe(bethIsraelMedTotalTransTime)

confidenceInterval <- CI(bethIsraelMedTotalTransTime, ci = 0.95)
confidenceInterval

tDist <- fitdistr(bethIsraelMedTotalTransTime, 't')$loglik
tDist

normalDist <-
  fitdistr(bethIsraelMedTotalTransTime, 'normal', lower = 0.01)$loglik
normalDist

logisticDist <-
  fitdistr(bethIsraelMedTotalTransTime, 'logistic', lower = 0.01)$loglik
logisticDist

weiBullDist <-
  fitdistr(bethIsraelMedTotalTransTime, 'weibull', lower = 0.01)$loglik
weiBullDist

gammaDist <-
  fitdistr(bethIsraelMedTotalTransTime, 'gamma', lower = 0.01)$loglik
gammaDist

logNormDist <-
  fitdistr(bethIsraelMedTotalTransTime, 'lognormal', lower = 0.01)$loglik
logNormDist

expDist <-
  fitdistr(bethIsraelMedTotalTransTime, 'exponential', lower = 0.01)$loglik
expDist

gammaDistVal <-
  pgamma(bethIsraelMedTotalTransTime,
         shape = 4.726886,
         rate = 1)
chisq.test(gammaDistVal)

# Problem 1(v)

summary(bethIsraelMedTotalTransTime)
hist(
  bethIsraelMedTotalTransTime,
  main = "Histogram of Beth Israel Medical - Total Transport Time",
  ylab = "Frequency",
  col = "orchid",
  ylim = c(0, 600),
  xlab = "Average Transport Time (in mins)",
  xlim = c(0, 12)
)
boxplot(bethIsraelMedTotalTransTime)

#------------------------------------------------------------------------------

# Problem 2

set.seed(5000)
normalDist <- rnorm(n = 5000, mean = 150, sd = 50)
normalDist

bethIsraelMedVictims <- c()
tuftsMedVictims <- c()
massGenMedVictims <- c()
bostonMedVictims <- c()
brighamAndWomensMedVictims <- c()

for (j in normalDist) {
  bethIsraelMedVictims <- c(bethIsraelMedVictims, j * 0.3)
  tuftsMedVictims <- c(tuftsMedVictims, j * 0.15)
  massGenMedVictims <- c(massGenMedVictims, j * 0.2)
  bostonMedVictims <- c(bostonMedVictims, j * 0.25)
  brighamAndWomensMedVictims <-
    c(brighamAndWomensMedVictims, j * 0.1)
}

# Problem 2(i)

summary(bethIsraelMedVictims)
summary(tuftsMedVictims)
summary(massGenMedVictims)
summary(bostonMedVictims)
summary(brighamAndWomensMedVictims)

bethDistTime <- rnorm(5000, mean = 7, sd = 2)
tuftsDistTime <- rnorm(5000, mean = 10, sd = 4)
massGenDistTime <- rnorm(5000, mean = 15, sd = 3)
bostonDistTime <- rnorm(5000, mean = 15, sd = 5)
brighamDistTime <- rnorm(5000, mean = 20, sd = 3)

# Problem 2(ii)

bethAvgTime <- c()
tuftsAvgTime <- c()
massGenAvgTime <- c()
bostonAvgTime <- c()
brighamAvgTime <- c()

for (k in 1:5000) {
  bethAvgTime[k] <- bethIsraelMedVictims[k] * bethDistTime[k]
  tuftsAvgTime[k] <- tuftsMedVictims[k] * tuftsDistTime[k]
  massGenAvgTime[k] <- massGenMedVictims[k] * massGenDistTime[k]
  bostonAvgTime[k] <- bostonMedVictims[k] * bostonDistTime[k]
  brighamAvgTime[k] <-
    brighamAndWomensMedVictims[k] * brighamDistTime[k]
}

summary(bethAvgTime)
summary(tuftsAvgTime)
summary(massGenAvgTime)
summary(bostonAvgTime)
summary(brighamAvgTime)

# Problem 2(iii)

totSum <- c()
for (x in 1:5000) {
  totSum[x] <- sum(bethIsraelMedVictims[1:x]) / x
}
plot(totSum,
     type = "l",
     lwd = 2,
     main = "Law of Large Numbers for Beth Israel Medical Hospital")
abline(h = mean(bethIsraelMedVictims), col = "yellow")

# Problem 2(iv)

describe(bethDistTime)
boxplot(bethDistTime)

describe(bethAvgTime)
boxplot(bethAvgTime)
summary(bethAvgTime)
eda(bethAvgTime)

confidenceInterval1 <- CI(bethAvgTime, ci = 0.95)
confidenceInterval1

y <- qnorm(0.95) * (sd(bethAvgTime) / sqrt(5000))
y

normalDist1 <-
  fitdistr(bethDistTime, 'normal', lower = 0.01)$loglik
normalDist1

# Problem 2(v)

tVal <- c()
for (c in 1:5000) {
  tVal[c] <- bethDistTime[c] * 60 / bethIsraelMedVictims[c]
}
describe(tVal)
eda(tVal)
boxplot(tVal)

outliers <- c()
outliers <- boxplot(bethAvgTime)$out
outliers




#------------------------------------------------------------------------------

