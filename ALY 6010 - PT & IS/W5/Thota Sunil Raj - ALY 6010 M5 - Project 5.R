# ALY6010V4B-M5-Project5
# Probability Theory and Introduction to Statistics
# ALY 6010 - 71709 (CRN Number)
# Project 1
# 12/9/2020
# Sunil Raj Thota
# NUID: 001099670

library(ggplot2)
library(descr)

#A-1 LOAD DATA SET:   <. Album Sales 2.dat >  & display the first 6 records
albumSalesData <-
  read.delim("G:/NEU/Coursework/2020 Q4 Fall/ALY 6010 PT & IS/Album Sales 2.dat")
head(albumSalesData, 6)

#A-2 EXPLORE the DATA SET: List the names of the 4 variables then display the dimensions of the dataset. Finally display the basics quartile statistics of the 4 variables,
names(albumSalesData)
dim(albumSalesData)
summary(albumSalesData)

#A-3 CREATE the LINEAR REGRESSION MODEL of Sales vs Advertisements. Save the model as an R object named  < albumSales.3ad >
albumSales.3ad <- lm(sales ~ adverts, data = albumSalesData)
summary(albumSales.3ad)

#A-4 What is the CORRELATION COEFFICIENT between Advertisements and Album sales. Save the value as an object named  < r >
r <- cor(albumSalesData$sales, albumSalesData$adverts)
r

#A-5 Display the 3 most basic DESCRIPTIVE STATISTICS for Sales and Advertisements
descr(albumSalesData$sales)
descr(albumSalesData$adverts)

#A-6 What is the COEFFICIENT OF DETERMINATION of Advertisements vs Sales
coeffOfDetermination <- lm(sales ~ adverts, data = albumSalesData)
summary(coeffOfDetermination)$r.squared

#A-7 Compute Total Sum of Squares from a mathematics basic formula
anova(albumSales.3ad)
sum(anova(albumSales.3ad)[, 2])

#A-8 Compute the Residual Sum of Squares from a mathematical formula
sum(resid(albumSales.3ad) ^ 2)

#A-9 Display the intercept and slope of the regression line of Sales vs Advertisements
coef <- coef(coeffOfDetermination)
coef

#A10 Create the regression line equation (eg y = a + bx) and display the y coordinate at x = 500
x <- 500
y <- coef[1] + coef[2] * x
y

#A-11 Create a plot identical to that which is shown: REPLACE THIS IMAGE WITH YOUR PLOT ANNOTATED WITH YOUR NAME AND CHANGE THE REGRESSION LINE TO RED AND THE ORANGE TRIANGLE TO BLUE Replace the Professor's last name with your own.
ggplot(albumSalesData,
       aes(x = adverts, y = sales)) +
  labs(
    title = "Scatter Plot",
    subtitle = "Sales vs Advertising",
    x = "Advertising Expense ($000)",
    y = "Album Sales (000 Units)",
    caption = "Thota, Sunil Raj"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 22),
    plot.subtitle = element_text(hjust = 0.5, size = 18),
    plot.caption = element_text(color = "red", face = "italic", size = 16),
    text = element_text(size = 16)
  ) +
  geom_point(
    shape = 21,
    fill = "lightgray",
    color = "black",
    size = 2.74,
    stroke = 1.1
  ) +
  geom_smooth(
    method = lm,
    color = "red",
    fullrange = TRUE,
    formula = y ~ x
  ) +
  geom_point(
    aes(x = x, y = y),
    size = 3,
    fill = "blue",
    shape = 23,
    col = "blue",
    stroke = 1
  )
