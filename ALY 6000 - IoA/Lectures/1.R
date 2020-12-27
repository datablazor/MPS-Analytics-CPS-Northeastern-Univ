data("mtcars")
head(mtcars, n=10)

plot(mtcars$wt, mtcars$mpg)
attach(mtcars)
plot(wt, mpg)

library(Hmisc)
library(RColorBrewer)

opar <- par(no.readonly = TRUE)

attach(mtcars)
plot(wt, mpg)
plot(wt, mpg, main = "Regression of MPG on Weight")

plot(wt, mpg, main = "MPG vs Weight", xlab = "Weight", ylab = "Miles Per Gallon", ylim = c(5, 35), xlim = c(1, 6))



manager <- c(1, 2, 3, 4, 5)
date <- c("10/24/08", "10/28/08", "10/1/08", "10/12/08", "5/1/09")
gender <- c("M", "F", "F", "M", "F")
age <- c(32, 45, 25, 39, 99)
q1 <- c(5, 3, 3, 3, 2)
q2 <- c(4, 5, 5, 3, 2)
q3 <- c(5, 2, 5, 4, 1)
q4 <- c(5, 5, 5, NA, 2)
q5 <- c(5, 5, 2, NA, 1)
leadership <- data.frame(manager, date, gender, age, q1, q2, q3, q4, q5, stringsAsFactors = FALSE)

class(date)
class(gender)
str(leadership)
summary(leadership)


mydata <- data.frame(x1 = c(2, 2, 6, 4), x2 = c(3, 4, 2, 8))
mydata
  
mydata2 <- mydata
mydata2

mydata$sumx <- mydata$x1 + mydata$x2
mydata

mydata$meanx <- (mydata$x1 + mydata$x2)/2
mydata

mydata <- transform(mydata, sumx = x1 + x2 + 6, meanx = (x1 + x2 + 6)/2)
mydata


leadership$agecat[leadership$age > 75] <- "Elder"


age <- c(1, 3, 5, 2, 11, 9, 3, 9, 12, 3)
age
length(age)
class(age)

weight <- c(4.4, 5.3, 7.2, 5.2, 8.5, 7.3, 6.0, 10.4, 10.2, 6.1)
weight
length(weight)
class(weight)

head(weight, n = 2)
weight[3]
weight <- weight[-3]
weight


adoles <- data.frame(age, weight)
adoles
class(adoles)
length(adoles)


patientID <- c(1, 2, 3, 4)
age <- c(25, 34, 28, 52)
diabetes <- c("Type 1", "Type 2", "Type 1", "Type 1")
status <- c("Poor", "Improved", "Excellent", "Poor")
diabetes <- factor(diabetes)
status <- factor(status, order = TRUE)
patientData <- data.frame(patientID, age, diabetes, status)
patientData
str(patientData)
summary(patientData)

class(patientData$patientID)
patientID

patientData[1: 2]
patientData[c("diabetes", "status")]

update.packages(ask=FALSE, checkBuilt=TRUE)

