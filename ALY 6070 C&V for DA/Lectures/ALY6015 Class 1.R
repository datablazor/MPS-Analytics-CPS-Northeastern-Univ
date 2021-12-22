# ALY6015 Class Exercises
# Week 1

# Install the "datasets" package and call it using the require() function
install.packages("datasets")
require(datasets)

# DESCRIPTIVE STATISTICS

# a) Exploratory: head()
head(mtcars)

# b) Selecting individual fields: $
mtcars$mpg

# c) Measures of central tendency: Mean, Median, Mode
mean(mtcars$hp)
median(mtcars$hp)

# R doesn't have a function for calcuating mode so we will create 
# our own function and store it as getmode()
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# It works!
getmode(mtcars$hp)

# d) Measure of variability: Variance, Standard Deviation, Range, Quartiles

var(mtcars$hp)
sd(mtcars$hp)
range(mtcars$hp)
quantile(mtcars$hp, probs=seq(0,1,0.25))
quantile(mtcars$hp, probs=0.5)

# e) What does the summary() function do?
summary(mtcars)

# Get the total number of NA values in the hp column
sum(is.na(mtcars$hp))

# Get the total number of non-NA values in the hp column
sum(!is.na(mtcars$hp))

# Get the number of rows in the dataset
nrow(mtcars)

# Get the number of columns in the dataset
ncol(mtcars)

#Get column names
names(mtcars)
colnames(mtcars)

# Subsetting - which, tapply, indexing
which(mtcars$cyl > 4)
mtcars[which(mtcars$cyl > 4),]
mtcars[,which(colnames(mtcars)=='hp')]

# tapply - for grouping
mtcars$grouped_qsec <- tapply(mtcars$qsec, mtcars$gear)

# indexing - for selecting specific values
mtcars[1,6:8]
mtcars[5:9, 'qsec']
mtcars[5:9, c('qsec','vs')]
mtcars[!is.na('cyl'), 7]

# Object assignment - you can use '=' or '<-'
x = 7
x <- 7

# Vector Operations

# Let's create a numeric, a character, and a factor vector
w <- c(0, 2, 4, 9)
x <- c(5, 6, 2, 1)
y <- c('yellow', 'green', 'red', 'green')
z <- factor(c('banana', 'grape', 'apple', 'grape'), levels=c('grape','apple','banana'))
t <- c(0, 2, 4)

# Use the class() function to find the type of data you have
class(x)
class(y)
class(z)
class(mtcars$hp)

# Factors can be numbers or words, but they have an intrinsic ordering and grouping:
# Set the order of the fruits to be smallest to largest and compare the summaries of y and z
summary(y)
summary(z)

# Add the w and x vectors to produce a new vector with the operation aligned by indices
w + x
# Vectors should be of the same length
w*t

# Create a dataframe by combining vectors of the same length
df <- data.frame(w, x)


# VISUALIZATIONS

# a) Histogram
hist(x=mtcars$hp, breaks=6, main='Histogram of mtcars HP',
     xlab='HP', ylab='Frequency')

# b) Boxplot
boxplot(mtcars$hp ~ mtcars$cyl, main='Horsepower by Cylinders',
        xlab='cyl', ylab='HP')

# d) Adding the normal curve (see: curve)
plot(qnorm)
curve(x^3 - 3*x, from=-2, to=2)

# e) Check for normal distribution (see: qq)
qqline(mtcars$hp)

# f) Scatter plots
plot(x=mtcars$hp, y=mtcars$vs, main='HP by VS',
     xlab='HP', ylab='VS')


# Checking working directory
getwd()
setwd('..')
getwd()
setwd('/Users/mm40391/Documents/')
dataset_name <- read.csv('example_data.csv')
