# Week 1 Quiz

height <- c(14, 21, 32, 30, 40, 59, 68, 72, 74, 39)
str(height)
summary(height)
mean(height)

weight <- c(20, 22, 30, 24, 44, 75, 120, 150, 200, 80)
mean(weight) # 76.5
str(weight)
summary(weight)

getwd()

cor(height, weight) #0.913

q()

library(vcd)

install.packages("Hmisc")
library(Hmisc)
? Hmisc.Overview

par(lty = 3,
    pch = 17,
    pin = c(2, 3))

? par

rm(list = ls())
abline(mean(age),
       0,
       col = "blue",
       lty = 2,
       lwd = 5)
? abline


attach(mtcars)
plot(disp, mpg)
detach(mtcars)

m <- matrix(1:6, nrow = 2, ncol = 3)
m
myData <- data.frame(alpha = c(2, 4, 6), beta = c(5, 5, 5))
attach(myData)
abSUM <- alpha + beta
abSUM <- myData$alpha + myData$beta
abSUM
library()

a <- c(1, 2 , 3)
a
is.vector(a)

is.character(a)


a <- c(1, 2, 3, NA)
x <- c(9, 10, 11, 19)
c <- c(4, 6, 8, 9)

dataAX <- a + x
dataAX
dataAC <- a + c
dataAC

total <- dataAX + dataAC
total






















