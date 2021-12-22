# Intermediate Analytics
# ALY 6015
# Module 1 - Hypothesis Testing with R
# 01/30/2021
# Sunil Raj Thota
# NUID: 001099670

#-----------------------------------------------------------------------------
# Get and set the working directories
getwd()
setwd('G:/NEU/Coursework/2021 Q1 Winter/ALY 6015 IA/Discussions & Assignments')
getwd()

# Installed the above packages into the workspace
install.packages("datasets")
install.packages("plyr")
install.packages("dplyr")
install.packages("tidyr")
install.packages("MASS")

# Loaded the below libraries into the workspace
library(plyr)
library(dplyr)
library(tidyr)
library(MASS)
require(datasets)
#-----------------------------------------------------------------------------
# Part A
#-----------------------------------------------------------------------------
data(chem) # Load the Chem Data set into the Environment
View(chem) # To View the Chem Data set
str(chem) # To observe the structure of the Data set
head(chem) # It shows first few rows in the Data set
tail(chem) # It shows last few rows in the Data set
summary(chem) # Provides the Descriptive Stats of the Chem Data set

#-----------------------------------------------------------------------------
# Part B
#-----------------------------------------------------------------------------
tTest <- t.test(chem,
                alternative = "greater",
                mu = 1)
tTest # T Test

#-----------------------------------------------------------------------------
# Part C
#-----------------------------------------------------------------------------
data(cats) # Load the Cats Data set into the Environment
View(cats) # To View the Cats Data set
str(cats) # To observe the structure of the Data set
head(cats) # It shows first few rows in the Data set
tail(cats) # It shows last few rows in the Data set
summary(cats) # Provides the Descriptive Stats of the Cats Data set

maleData <- subset(cats,
                   subset = (cats$Sex == "M"))
View(maleData)
str(maleData)
summary(maleData)

femaleData <- subset(cats,
                     subset = (cats$Sex == "F"))
View(femaleData)
str(femaleData)
summary(femaleData)

tTestCats <- t.test(maleData$Bwt,
                    femaleData$Bwt,
                    var.equal = FALSE)
tTestCats # T Test

#-----------------------------------------------------------------------------
# Part D
#-----------------------------------------------------------------------------
data(shoes) # Load the Shoes Data set into the Environment
View(shoes) # To View the Shoes Data set
str(shoes) # To observe the structure of the Data set
head(shoes) # It shows first few rows in the Data set
tail(shoes) # It shows last few rows in the Data set
summary(shoes) # Provides the Descriptive Stats of the Shoes Data set

tTestShoes <-
  t.test(shoes$A,
         shoes$B,
         paired = TRUE,
         alternative = "less")
tTestShoes # T Test

#-----------------------------------------------------------------------------
# Part E
#-----------------------------------------------------------------------------
data(bacteria) # Load the Bacteria Data set into the Environment
View(bacteria) # To View the Bacteria Data set
str(bacteria) # To observe the structure of the Data set
head(bacteria) # It shows first few rows in the Data set
tail(bacteria) # It shows last few rows in the Data set
summary(bacteria) # Provides the Descriptive Stats of the Bacteria Data set

tableData <- table(bacteria$y, bacteria$ap)
propTestBacteria <- prop.test(table(bacteria$y, bacteria$ap),
                              conf.level = 0.95,
                              alternative = "two.sided")
propTestBacteria # Prop Test

#-----------------------------------------------------------------------------
# Part F
#-----------------------------------------------------------------------------
data(cats) # Load the Cats Data set into the Environment
View(cats) # To View the Cats Data set

varTestCats <- var.test(maleData$Bwt, femaleData$Bwt)
varTestCats # Var Test

#-----------------------------------------------------------------------------