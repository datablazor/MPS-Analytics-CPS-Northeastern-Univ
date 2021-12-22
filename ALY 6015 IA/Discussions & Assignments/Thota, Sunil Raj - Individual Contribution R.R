# Intermediate Analytics
# ALY 6015
# Preliminary Analysis R File
# 02/24/2021
# Team: Sunil Raj Thota

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

# Previous Distribution and Analysis
ggplot(x, aes(previous)) + geom_bar(aes(fill = y))

table(bankDataMain$poutcome, bankDataMain$y)
table(bankDataMain$contact, bankDataMain$y)
table(bankDataMain$education)
table(bankDataMain$default)
table(bankDataMain$housing)
table(bankDataMain$month)

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

# Age ~ Marital Status Box plot
plot2 <- ggPlot + geom_boxplot(aes(y = age)) +
  ggtitle('Age Boxplot') +
  ylab('Age')

grid.arrange(plot1, plot2, ncol = 2, nrow = 1)

# Age ~ Marital Status Histogram plot
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

# Age ~ Duration Status Scatter plot
ggplot(data = bankDataCleaned, aes(age, duration)) +
  geom_point() +
  facet_grid(cols = vars(y)) +
  scale_x_continuous(breaks = seq(0, 100, 20)) +
  ggtitle("Scatterplot of Duration vs Age")

# Campaign ~ Duration Status Scatter plot
bankDataCleaned %>% filter(campaign < 63) %>%
  ggplot(aes(campaign, duration)) +
  geom_point() +
  facet_grid(cols = vars(y)) +
  ggtitle("Scatterplot of Duration vs Campaign")

# Correlation test of Age to the 'y' variable
ageTermDeposit <-
  cor.test(as.numeric(as.factor(bankDataMain$y)),
           as.numeric(as.factor(bankDataMain$age)),
           method = "pearson")
ageTermDeposit

# Correlation test of Job to the 'y' variable
jobTermDeposit <-
  cor.test(as.numeric(as.factor(bankDataMain$y)),
           as.numeric(as.factor(bankDataMain$job)),
           method = "pearson")
jobTermDeposit

# Correlation test of Marital to the 'y' variable
maritalTermDeposit <-
  cor.test(as.numeric(as.factor(bankDataMain$y)),
           as.numeric(as.factor(bankDataMain$marital)),
           method = "pearson")
maritalTermDeposit

eduTermDeposit <-
  cor.test(as.numeric(as.factor(bankDataMain$y)),
           as.numeric(as.factor(bankDataMain$education)),
           method = "pearson")
eduTermDeposit

# Correlation test of Housing to the 'y' variable
housingTermDeposit <-
  cor.test(as.numeric(as.factor(bankDataMain$y)),
           as.numeric(as.factor(bankDataMain$housing)),
           method = "pearson")
housingTermDeposit

# Correlation test of Loan to the 'y' variable
loanTermDeposit <-
  cor.test(as.numeric(as.factor(bankDataMain$y)),
           as.numeric(as.factor(bankDataMain$loan)),
           method = "pearson")
loanTermDeposit

# Correlation test of Housing and Loan to the 'y' variable
housingLoanTermDeposit <-
  cor.test(as.numeric(as.factor(bankDataMain$y)),
           as.numeric(as.factor(bankDataMain$housing)) +
             as.numeric(as.factor(bankDataMain$loan)),
           method = "pearson")
housingLoanTermDeposit

# Training and Testing the data set
set.seed(12345)
sampleData <-
  sample(
    x = 1:nrow(bankDataMain),
    size = 0.8 * nrow(bankDataMain),
    replace = F
  )

trainData <- bankDataMain[sampleData, ]
head(trainData)
testData <- bankDataMain[-sampleData, ]
head(testData)

sapply(bankDataMain, class)

# CART
bankCART <- rpart(y ~ ., trainData , method = 'class')

par(mfrow = c(1, 1))
fancyRpartPlot(bankCART ,
               digits = 2 ,
               palettes = c("Purples", "Oranges"))

cartPred <- predict(bankCART , testData , type = "class")
cartProb <- predict(bankCART , testData , type = "prob")

confusionMatrix(as.factor(testData$y), as.factor(cartPred))

CrossTable(
  testData$y,
  cartPred,
  prop.chisq = FALSE,
  prop.c = FALSE,
  prop.r = FALSE,
  dnn = c('actual default', 'predicted default')
)

# KNN
bank.knn <- train(
  y ~ .,
  data = trainData,
  method = "knn",
  maximize = TRUE,
  trControl = trainControl(method = "cv", number = 10),
  preProcess = c("center", "scale")
)

predictedkNN <- predict(bank.knn , newdata = testData)
confusionMatrix(as.factor(predictedkNN) , as.factor(testData$y))

# Cross Table - KNN
CrossTable(
  testData$y,
  predictedkNN,
  prop.chisq = FALSE,
  prop.c = FALSE,
  prop.r = FALSE,
  dnn = c('actual default', 'predicted default')
)

# Decision Tree Classification
decisionTree <-
  rpart(formula = y ~ .,
        data = trainData,
        method = "class")

# Decision Tree Plot
prp(
  decisionTree,
  type = 2,
  extra = 104,
  fallen.leaves = TRUE,
  main = "Decision Tree"
)

# Predict the Test data by Probability
pred.DT <-
  predict(decisionTree, newdata = testData[-21], type = 'prob')
pred.DT

# Prediction - Decision Tree
predDT <- data.frame(y = testData$y, pred = NA)
predDT$pred <- pred.DT[, 2]
predDT

rocr.pred <-
  prediction(predictions = pred.DT[, 2], labels = testData$y)
rocr.perf <-
  performance(rocr.pred, measure = "tpr", x.measure = "fpr")
rocr.auc <- as.numeric(performance(rocr.pred, "auc")@y.values)

# ROC AUC
rocr.auc

# Plot ROC Curve
plot(
  rocr.perf,
  lwd = 3,
  colorize = TRUE,
  print.cutoffs.at = seq(0, 1, by = 0.1),
  text.adj = c(-0.2, 1.7),
  main = 'ROC Curve'
)
mtext(paste('Decision Tree - auc : ', round(rocr.auc, 5)))
abline(0, 1, col = "tomato", lty = 2)

rpart.plot(decisionTree)
pred <- predict(decisionTree, testData[-21], type = "class")
confusionMatrix(as.factor(testData$y), as.factor(pred))

# Random Forest
rfModel <- train(y ~ .,
                 data = trainData,
                 method = "rf",
                 ntree = 20)

refPred <- predict(rfModel, testData)
confusionMatrix(as.factor(testData$y), as.factor(refPred))

#------------------------------------------------------------------------------