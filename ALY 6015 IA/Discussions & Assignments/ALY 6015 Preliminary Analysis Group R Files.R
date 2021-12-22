# Intermediate Analytics
# ALY 6015
# Preliminary Analysis Group R Files
# 02/12/2021
# Team: Sunil Raj Thota, Nalini Macharla

#-----------------------------------------------------------------------------
# Get and set the working directories
getwd()
setwd('G:/NEU/Coursework/2021 Q1 Winter/ALY 6015 IA/Discussions & Assignments')
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

bankDataCleaned <- bankDataMain.clean
bankDataCleaned

# Conditionally formatting all "y" to 0, and 1
bankDataCleaned$y <- ifelse(bankDataCleaned$y == "y", 1, 0)
bankDataCleaned

str(bankDataCleaned)

nrow(bankDataCleaned)
ncol(bankDataCleaned)
head(bankDataCleaned)
summary(bankDataCleaned)

x <- filter(bankDataMain, y == "yes")

# Age Distribution and Analysis
ggplot(bankDataMain, aes(job)) + geom_bar(aes(fill = y))

# Job Distribution and Analysis
ggplot(x, aes(job)) + geom_bar(aes(fill = contact))

# previous Distribution and Analysis
ggplot(x, aes(previous)) + geom_bar(aes(fill = y))

table(bankDataMain$poutcome, bankDataMain$y)
table(bankDataMain$contact, bankDataMain$y)
table(bankDataMain$education)
table(bankDataMain$default)
table(bankDataMain$housing)
table(bankDataMain$month)

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

# Age ~ Marital Status Histogram
ggPlot <- ggplot (bankDataCleaned)
plot1 <- ggPlot + geom_histogram(aes(x = age),
                                 color = "black",
                                 fill = "white",
                                 binwidth = 3) +
  ggtitle('Age Distribution') +
  ylab('Count') +
  xlab('Age') +
  geom_vline(aes(xintercept = mean(age), color = "tomato")) +
  scale_x_continuous(breaks = seq(0, 100, 10)) +
  theme(legend.position = "none")

# Age ~ Marital Status Boxplot
plot2 <- ggPlot + geom_boxplot(aes(y = age)) +
  ggtitle('Age Boxplot') +
  ylab('Age')

grid.arrange(plot1, plot2, ncol = 2, nrow = 1)

p3 <- ggplot(bankDataCleaned, aes(x = age, fill = marital)) +
  geom_histogram(binwidth = 2, alpha = 0.7) +
  facet_grid(cols = vars(y)) +
  expand_limits(x = c(0, 100)) +
  scale_x_continuous(breaks = seq(0, 100, 20)) +
  ggtitle("Age vs Marital Status")

p3

meanAge <-
  bankDataCleaned %>% group_by(y) %>% summarize(grp.mean = mean(age))

# Age ~ Subscription Status Histogram
ggplot (bankDataCleaned, aes(x = age)) +
  geom_histogram(color = "black",
                 fill = "orange",
                 binwidth = 3) +
  facet_grid(cols = vars(y)) +
  ggtitle('Age vs Subscription') + ylab('Count') + xlab('Age') +
  scale_x_continuous(breaks = seq(0, 100, 15)) +
  geom_vline(
    data = meanAge,
    aes(xintercept = grp.mean),
    color = "red",
    linetype = "dashed"
  )

# Education ~ Subscription Status Barplot
ggplot(data = bankDataMain.clean, aes(x = education, fill = y)) +
  geom_bar() +
  ggtitle("Term Deposit Subscription - Education Level") +
  xlab(" Education Level") +
  guides(fill = guide_legend(title = "Subscription"))

bankDataMain.clean %>%
  group_by(education) %>%
  summarize(pct.yes = mean(y == "yes") * 100) %>%
  arrange(desc(pct.yes))

# Campaign ~ Subscription Status Histogram
ggplot(data = bankDataMain.clean, aes(x = campaign, fill = y)) +
  geom_histogram() +
  ggtitle("Subscription - Number of Contact during the Campaign") +
  xlab("Number of Contact during the Campaign") +
  xlim(c(min = 1, max = 30)) +
  guides(fill = guide_legend(title = "Subscription"))

bankDataMain.clean %>%
  group_by(campaign) %>%
  summarize(contact.cnt = n(),
            pct.con.yes = mean(y == "yes") * 100) %>%
  arrange(desc(contact.cnt)) %>%
  head()

range(bankDataCleaned$duration)
summary(bankDataCleaned$duration)

# Age ~ Duration Status Scatterplot
ggplot(data = bankDataCleaned, aes(age, duration)) +
  geom_point() +
  facet_grid(cols = vars(y)) +
  scale_x_continuous(breaks = seq(0, 100, 20)) +
  ggtitle("Scatterplot of Duration vs Age")

# Campaign ~ Duration Status Scatterplot
bankDataCleaned %>% filter(campaign < 63) %>%
  ggplot(aes(campaign, duration)) +
  geom_point() +
  facet_grid(cols = vars(y)) +
  ggtitle("Scatterplot of Duration vs Campaign")

# Loan Status Histogram
hist(
  bankDataMain$loan,
  main = "Histogram Plot - Age",
  xlab = "Age",
  ylab = "Frequency ",
  border = "black",
  xlim = c(0, 100),
  ylim = c(0, 10000),
  col = "orchid"
)

# Logistic Regression Model
logRegModel <-
  glm(y ~ 1,
      family = binomial(link = "logit"),
      data = bankData,
      maxit = 4)
logRegModel
summary(logRegModel)

# Probability
prob <-
  (exp(logRegModel$coefficients[1])) / (1 + exp(logRegModel$coefficients[1]))
prob

# Training and Testing the dataset
set.seed(12345)
sampleData <-
  sample(x = 1:nrow(bankDataMain),
         size = 0.8 * nrow(bankDataMain))
sampleData

trainData <- bankDataMain[sampleData,]
trainData
head(trainData)
testData <- bankDataMain[-sampleData,]
testData
head(testData)