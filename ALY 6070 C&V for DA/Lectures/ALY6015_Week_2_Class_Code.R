# ALY6015 Week 2 R Exercises

require(datasets)

# Converting a factor variable to a numeric
# Let's make a factor vector x
x <- factor(c(4, 6, 9, 3))
class(x)
# And a numeric vector y
y <- c(1, 2, 3, 4)
# We as humans know that x is a series of numbers, but R doesn't understand that
# Trying to do addition, for example, returns an error
x+y

# If we try to just use the as.numeric() function, this messes up x!
z <- as.numeric(x)
print(z)

# This is because factors are ORDINAL and have an associated order of levels
# When we do as.numeric() on a factor, R thinks we want to see what LEVEL each element is
# Use this code instead:
z <- as.numeric(levels(x))[x]
z

#Find a critical value for a t-distribution
#For a two-tailed test, with alpha=0.05, alpha/2=0.025
qt(c(.025, .975), df=25) #Where df = n-1

# One-tailed t-test
# Let's take the Company X call time example
# H0: mean resolution time ≥ 25 minutes
# H1: mean resolution time < 25 minutes
# We're going to construct a fake dataset just to run the t-test
# Check the help section for t.test() - what are the defaults we might want to modify?
# How do we interpret this p-value?
y <- c(15, 18, 28, 26, 24, 27, 30, 10, 22, 45, 40, 11, 36)
t.test(y, mu=25, alternative = c("less")) #where mu is the assumed population mean, included in our H0

# Two-tailed t-test
# Let's take the Company X call time example
# H0: mean resolution time = 25 minutes
# H1: mean resolution time != 25 minutes
t.test(y, mu=25, alternative = c("two.sided")) #where mu is the assumed population mean, included in our H0

# Independent 2-group t-test
t.test(y ~ x) # where y is numeric (like height) and x is a binary factor like male and female

# Independent 2-group t-test
t.test(y1, y2) # where y1 and y2 are numeric

# Paired t-test
t.test(y1, y2, paired=TRUE) # where y1 and y2 are numeric

# F test
# Use when you want to perform a two samples t-test to check the equality of the variances of the two samples
# or you want to compare the variability of a new measurement method to an old one. 
var.test(y ~ x, data, alternative = "two.sided") # where y is numeric and x is a binary factor like male and female
var.test(y1, y2, alternative = "two.sided") # where y1 and y2 are numeric

# Linear regression (Y ~ X, data=data_name)
# Height = 62.0313 + 1.0544(Girth)
lm1 <- lm(Height ~ Girth, data=trees)
summary(lm1)
#This will produce assessment plots for lm1
#Residuals vs Fitted - graph of distance between predicated and actual values
#Normal QQ - Is the distribution normal? A normal distribution follows the straight line
#Scale-Location - This plot shows if residuals are spread equally along the ranges of predictors. This is how you can check the assumption of equal variance (homoscedasticity). It’s good if you see a horizontal line with equally (randomly) spread points.
#Residuals vs Leverage - Shows which points are affecting the final fit line most strongly
plot(lm1)
plot(lm1)[2]


#Correlation
install.packages("ggcorrplot")
require(ggcorrplot)
ggcorrplot(mtcars)


