# ALY6010V4B-M3-Project3
# Probability Theory and Introduction to Statistics
# ALY 6010 - 71709 (CRN Number)
# Project 1
# 11/15/2020
# Sunil Raj Thota
# NUID: 001099670

install.packages("dplyr")
install.packages("ggplot2")
install.packages("sm")
# Installed Necessary Libraries to work on them further
library(ggplot2)
library(dplyr)
library(sm)
# Loaded the above libraries into the work space
data("mtcars")
str(mtcars)
summary(mtcars)
# Executed the mtcars data set and gone through the str and summary of the data set



# Plot 1
hist(
  mtcars$mpg,
  breaks = 12,
  xlab = "Miles Per Gallon",
  ylab = "Density",
  main = "Frequency Distribution of MPG",
  col = rainbow(12),
  freq = FALSE,
  border = FALSE
)
rug(jitter(mtcars$mpg))
lines(density(mtcars$mpg), col = "brown", lwd = 2)
# Plotted the histogram for Frequency Distribution of MPG. Also, plotted the rug and density curve plots. The density curve is a kernel density estimate. It provides a smoother description of the distribution of scores. Finally, a rug plot is a one-dimensional representation of the actual data values



# Plot 2
par(lwd = 2)
attach(mtcars)

cyl.f <- factor(
  cyl,
  levels = c(4, 6, 8),
  labels = c("4 cylinder", "6 cylinder", "8 cylinder")
)

sm.density.compare(mpg, cyl, xlab = "Miles Per Gallon", lwd = 2)
title(main = "MPG Distribution by Car Cylinders")
colfill <- c(2:(1 + length(levels(cyl.f))))

legend(
  "right",
  fill = colfill,
  levels(cyl.f),
  inset = c(0, 0.95),
  cex = 0.8,
  xpd = TRUE
)

detach(mtcars)
# Plotted the MPG Distribution by car Cylinders on an Overlapping kernel density plots and these can be a powerful way to compare groups of observations on an outcome variable. Here we can see both the shapes of the distribution of scores for each group and the amount of overlap between groups.



# Plot 3
x <- mtcars[order(mtcars$mpg),]
x$cyl <- factor(x$cyl)
x$color[x$cyl == 4] <- "red"
x$color[x$cyl == 6] <- "blue"
x$color[x$cyl == 8] <- "brown"
dotchart(
  x$mpg,
  labels = row.names(x),
  cex = .7,
  groups = x$cyl,
  gcolor = "black",
  color = x$color,
  pch = 16,
  main = "Gas Mileage for Car Models\ngrouped by cylinder",
  xlab = "Miles Per Gallon"
)
# Plotted a dot chart for Gas Mileage for Car Models grouped by Cylinders. Dot plots provide a method of plotting a large number of labeled values on a simple horizontal scale. We can see that the increase in gas mileage as the number of cylinders decrease. It's also clear that the Toyota Corolla gets the best gas mileage by far, whereas the Lincoln Continental and Cadillac Fleetwood are outliers on the low end. 



# Plot 4
mtcars$cyl.f <- factor(mtcars$cyl,
                       levels = c(4, 6, 8),
                       labels = c("4", "6", "8"))
mtcars$am.f <- factor(mtcars$am,
                      levels = c(0, 1),
                      labels = c("auto", "standard"))
boxplot(
  mpg ~ am.f * cyl.f,
  data = mtcars,
  varwidth = TRUE,
  col = c(
    "darkorchid1",
    "deeppink3",
    "coral2",
    "brown2",
    "orchid",
    "lightpink"
  ),
  main = "MPG Distribution by Auto Type",
  xlab = "Auto Type",
  ylab = "MPG",
  outline = TRUE,
  boxwex = 0.7,
  las = 1
)
# Plotted a Box plot for MPG Distribution by Auto Type and it's clear that median mileage decreases with cylinder number. For four- and six-cylinder cars, mileage is higher for standard transmissions. But for eight-cylinder cars there does not appear to be a difference. We can also see from the widths of the box plots that standard four-cylinder and automatic eight cylinder cars are the most common in this data set.
