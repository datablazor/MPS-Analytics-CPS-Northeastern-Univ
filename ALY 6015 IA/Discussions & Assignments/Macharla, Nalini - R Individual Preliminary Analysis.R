# Intermediate Analytics
# ALY 6015
# Individual Contribution  R File
# 02/12/2021
# Nalini Macharla

#-----------------------------------------------------------------------------
# Get and set the working directories
getwd()
setwd('D:/Nalini/NEU/ALY 6015/Assignments')
getwd()

# Installed the above packages into the work space
install.packages("datasets")
install.packages("plyr")
install.packages("dplyr")
install.packages("tidyr")
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("ggcorrplot")
install.packages("e1071")
install.packages("DAAG")
install.packages("MASS")
install.packages("gmodels")
install.packages("GGally")
install.packages("gridExtra")

# Loaded the below libraries into the workspace
library(plyr)
library(dplyr)
library(tidyr)
library(tidyverse)
library(ggplot2)
library(e1071)
library(MASS)
library(DAAG)
library(ggcorrplot)
library(GGally)
library(gmodels)
require(grDevices)
require(datasets)
library(gridExtra)

bankData <- read.csv("Bank Dataset.csv")
bankData

bankDataMain <- bankData

View(bankData) # To View the bank Data set
str(bankData) # To observe the structure of the Data set
head(bankData) # It shows first few rows in the Data set
tail(bankData) # It shows last few rows in the Data set
summary(bankData) # Provides the Descriptive Stats of the bank Data set
dim(bankData) # Shows the count of rows and columns in the dataset

sum(duplicated(bankDataMain)) # Check for duplicate records
sum(!complete.cases(bankDataMain)) # Checking for Rows with missing Data

all.empty <-
  rowSums(is.na(bankDataMain)) == ncol(bankDataMain) # How many rows are completely went missing in all the cols
sum(all.empty)

sapply(bankDataMain, function(x)
  sum(is.na(x))) # Missing values by variables

bankDataMain.clean <- bankDataMain[!all.empty,]
bankDataMain.clean <- bankDataMain.clean %>% distinct
# Remove rows with clos that has missing values

nrow(bankDataMain.clean)

# Impute Missing Values - replace with average
bankDataMain.clean$missing <- !complete.cases(bankDataMain.clean)

bankDataMain.clean$age[is.na(bankDataMain.clean$age)] <-
  mean(bankDataMain$age, na.rm = T)
bankDataMain.clean$day[is.na(bankDataMain.clean$day)] <-
  mean(bankDataMain$day, na.rm = T)
bankDataMain.clean$duration[is.na(bankDataMain.clean$duration)] <-
  mean(bankDataMain$duration, na.rm = T)
bankDataMain.clean$previous[is.na(bankDataMain.clean$previous)] <-
  mean(bankDataMain$previous, na.rm = T)
bankDataMain.clean$campaign[is.na(bankDataMain.clean$campaign)] <-
  mean(bankDataMain$campaign, na.rm = T)

# Plotted histogram of pdays
hist(bankDataMain.clean$pdays)

bankDataMain.clean$pdays[is.na(bankDataMain.clean$pdays)] <-
  as.numeric(names(sort(-table(bankDataMain$pdays)))[1])

bankDataMain.clean$balance[is.na(bankDataMain.clean$balance)] <-
  as.numeric(names(sort(-table(
    bankDataMain$balance
  )))[1])

bankDataMain.clean$job <-
  fct_explicit_na(bankDataMain.clean$job, na_level = "(Missing)")
bankDataMain.clean$marital <-
  fct_explicit_na(bankDataMain.clean$marital, "missing")
bankDataMain.clean$education <-
  fct_explicit_na(bankDataMain.clean$education, "missing")
bankDataMain.clean$default <-
  fct_explicit_na(bankDataMain.clean$default, "missing")
bankDataMain.clean$loan <-
  fct_explicit_na(bankDataMain.clean$loan, "missing")
bankDataMain.clean$contact <-
  fct_explicit_na(bankDataMain.clean$contact, "missing")
bankDataMain.clean$poutcome <-
  fct_explicit_na(bankDataMain.clean$poutcome, "missing")
bankDataMain.clean$y <-
  fct_explicit_na(bankDataMain.clean$y, "missing")
bankDataMain.clean$housing <-
  fct_explicit_na(bankDataMain.clean$housing, "missing")
bankDataMain.clean$month <-
  fct_explicit_na(bankDataMain.clean$month, "missing")
fct_explicit_na()
# Treating missing values of categorical variables

bankDataMain.clean <- bankDataMain.clean %>% distinct
nrow(bankDataMain)
nrow(bankDataMain.clean)

# Remove duplicated rows and verify for deduplication
sum(duplicated(bankDataMain.clean))
sapply(bankDataMain.clean, function(x)
  sum(is.na(x)))

levels(bankDataMain.clean$job)
levels(bankDataMain.clean$marital)
levels(bankDataMain.clean$education)
levels(bankDataMain.clean$default)
levels(bankDataMain.clean$loan)
levels(bankDataMain.clean$contact)
levels(bankDataMain.clean$poutcome)
levels(bankDataMain.clean$y)
levels(bankDataMain.clean$housing)
levels(bankDataMain.clean$month)

sum(bankDataMain.clean$missing)

summary(bankDataMain.clean)
# Lets save the updated data in the below format
write.csv(bankDataMain.clean, file = "Banks Data Cleaned.csv")

# Age histogram
hist(
  bankDataMain$age,
  main = "Histogram Plot - Age",
  xlab = "Age",
  ylab = "Frequency ",
  border = "black",
  xlim = c(0, 100),
  ylim = c(0, 10000),
  col = "orchid"
)

# Age Density Plot
plot(
  density(bankDataMain$age),
  main = "Density Plot - Age",
  xlab = "Age",
  ylab = "Probability",
  col = "purple",
  lwd = 2.5,
)

duration <- summary(bankDataMain$duration)
duration