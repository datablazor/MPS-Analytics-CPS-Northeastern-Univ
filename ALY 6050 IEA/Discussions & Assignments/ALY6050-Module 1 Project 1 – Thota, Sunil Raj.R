# Introduction to Enterprise Analytics
# ALY 6050
# Week 1 Project 1
# 03/08/2021
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

# Loaded the below libraries into the work space
library(plyr)
library(dplyr)
library(tidyr)
library(tidyverse)

#------------------------------------------------------------------------------
# Problem 1

randomValues <- runif(1000)
x <- -log(randomValues, exp(1))

hist(
  x,
  main = "Relative Frequency Histogram of x",
  xlab = "Bins",
  ylab = "Frequency",
  xlim = c(0, 6.5),
  ylim = c(0, 400),
  col = "tomato",
  border = "white"
)

range <- max(x) - min(x)
range

plot(
  density(x),
  main = "Density Plot x",
  xlab = "Bins",
  ylab = "Probability",
  col = "purple",
  lwd = 2.5
)

qqplot(rexp(1000),
       x,
       main = "Q-Q Plot",
       xlab = "X",
       ylab = "Sample exponential distribution")
abline(0, 1)

normalX <- rnorm(1000)
hist(
  normalX,
  main = "Relative Frequency Histogram of x",
  xlab = "Bins",
  ylab = "Frequency",
  col = "tomato",
  border = "white"
)

plot(
  density(normalX),
  main = "Density Plot of x",
  xlab = "Bins",
  ylab = "Probability",
  col = "purple",
  lwd = 2.5
)
qqnorm(normalX)
qqline(normalX)

vectorX <- as.vector(x)
chisq.test(vectorX, p = c(rep(0.001, 1000)))

#------------------------------------------------------------------------------
# Problem 2

randomValue1 <- runif(10000, 0, 1)
randomValue2 <- runif(10000, 0, 1)
randomValue3 <- runif(10000, 0, 1)
rvX <- -log(randomValue1 * randomValue2 * randomValue3, exp(1))

secondHist <-
  hist(rvX,
       main = "Relative Frequency Histogram of rvX",
       plot = FALSE)

secondHist$counts <- secondHist$counts / sum(secondHist$counts)
secondHist$counts
plot(
  secondHist,
  freq = TRUE,
  main = "Relative Frequency Histogram of rvX",
  xlim = c(0, 15),
  ylim = c(0, 0.3),
  xlab = "Bins",
  ylab = "Frequency",
  col = "orchid",
  border = "white",
  breaks = 10
)
curve(
  dgamma(x, shape = 3, scale = 1),
  from = 0,
  to = 20,
  main = "Gamma Distribution"
)

plot(
  density(rvX),
  main = "Density Plot of rvX",
  xlab = "Bins",
  ylab = "Probability",
  col = "orange",
  lwd = 2.5
)

x1 <- rgamma(10000, shape = 3, rate = 1)
qqplot(x1,
       rvX,
       main = "QQ Plot",
       xlab = "X",
       ylab = "Gamma Distribution")
abline(0, 1)
chisq.test(x1, rvX)

#------------------------------------------------------------------------------
# Problem 3

Y <- c()

for (i in 1:1000) {
  stdUniRV1 <- runif(1)
  stdUniRV2 <- runif(1)
  rvX1 <- -log(stdUniRV1)
  rvX2 <- -log(stdUniRV2)
  k <- (stdUniRV1 - 1) ^ 2 / 2
  if (stdUniRV2 > k) {
    res <- runif(1)
    if (res > 0.5) {
      Y <- c(Y, stdUniRV1)
    }
    else{
      Y <- c(Y, -stdUniRV2)
    }
    {
      next
    }
  }
}

N <- length(Y)
N

hist(
  Y,
  breaks = 20,
  col = "purple",
  main = "Relative Frequency Histogram of Y",
  xlim = c(-1, 1),
  ylim = c(0, 80),
  xlab = "Y",
  ylab = "Frequency",
  border = "white"
)

plot(
  density(Y),
  main = "Density Plot of Y",
  xlab = "Bins",
  ylab = "Probability",
  col = "pink3",
  lwd = 2.5
)

rangeDist <- max(Y) - min(Y)
rangeDist

Y <- c(Y, x)
breaks <- c(-1, 0, 1)
YDist <- table(cut(Y, breaks = breaks))
View(YDist)

pDist <- c()

for (i in seq(-1, 1)) {
  pDist <- c(pDist, (pexp(i, 1) - pexp(i - 1, 1)) * 1000)
}

chisq.test(cbind(pDist, YDist))

#------------------------------------------------------------------------------
# Problem 4

Y <- c()
value <- 0
for (i in 1:1000) {
  stdUniRV1 <- runif(1)
  stdUniRV2 <- runif(1)
  rvX1 <- -log(stdUniRV1)
  rvX2 <- -log(stdUniRV2)
  k <- (stdUniRV1 - 1) ^ 2 / 2
  if (stdUniRV2 > k) {
    res <- runif(1)
    if (res > 0.5) {
      Y <- c(Y, stdUniRV1)
      value <- i
    } else{
      Y <- c(Y, -stdUniRV2)
      value <- i
    }
    {
      next
    }
  }
}

N <- length(Y)
N
W <- value / N
W

array <-
  c(10,
    20,
    30,
    40,
    50,
    60,
    70,
    80,
    90,
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900,
    1000)
for (i in array) {
  W <- i / N
  print(W)
}

# Table for M and W in Problem 4
# M 	W
# [10] 0.01180638
# [20] 0.02361275
# [30] 0.03541913
# [40] 0.0472255
# [50] 0.05903188
# [60] 0.07083825
# [70] 0.08264463
# [80] 0.094451
# [90] 0.1062574
# [100] 0.1180638
# [200] 0.2361275
# [300] 0.3541913
# [400] 0.472255
# [500] 0.5903188
# [600] 0.7083825
# [700] 0.8264463
# [800] 0.94451
# [900] 1.062574
# [1000] 1.180638

#------------------------------------------------------------------------------