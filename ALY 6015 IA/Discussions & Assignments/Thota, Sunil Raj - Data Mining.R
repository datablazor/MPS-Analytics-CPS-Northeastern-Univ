# Intermediate Analytics
# ALY 6015
# Module 4 - Data Mining
# 02/09/2021
# Sunil Raj Thota
# NUID: 001099670

#-----------------------------------------------------------------------------
# Get and set the working directories
getwd()
setwd('G:/NEU/Coursework/2021 Q1 Winter/ALY 6015 IA/Discussions & Assignments')
getwd()

# Installed the above packages into the work space
# install.packages("datasets")
# install.packages("plyr")
# install.packages("dplyr")
# install.packages("tidyr")
# install.packages("factoextra")
# install.packages("NbClust")
# install.packages("party")
# install.packages("caret")
# install.packages("fpc")

# Loaded the below libraries into the work space
library(plyr)
library(dplyr)
library(tidyr)
library(factoextra)
library(NbClust)
library(party)
require(datasets)
library(caret)
library(fpc)

# -----------------------------------------------------------------------------
# Problem 1
data(iris)
View(iris)
str(iris)
head(iris)
tail(iris)
summary(iris)

# Let's perform some Exploratory Data Analysis and Data Mining techniques using "iris" data set. To get this data set we need to install the 'data sets' package from the packages tab which is right side to the work space in R Studio.

# Or we can also install the packages by using install.packages("package name") command. Once it is loaded we can use it in the code for further analysis and calculations. Loaded the "data sets" library into the work space. Loaded the iris Data set into the Environment.

# I have also installed factoextra', 'party', 'caret', 'fpc', and 'NbClust' to perform data mining analysis in R. Let's install all the above packages

# To View the diabetes Data set we use View() command, To observe the structure of the Data set we use str() command, and head () and tail() shows first and last few rows in the Data set. Summary() Provides the Descriptive Stats of the iris columns. We noticed 5 variables from the statistics given in the summary.

# -----------------------------------------------------------------------------
# Problem 2

# split into training and test datasets
set.seed(1234)
sampleData <- sample(2, nrow(iris), replace = T, prob = c(0.7, 0.3))
sampleData
trainData <- iris[sampleData == 1, ]
trainData
testData <- iris[sampleData == 2, ]
testData

# To perform Data Mining, we are taking 'iris' data set which has 150 records and 5 variables. The columns that we are working now are Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, and Species of the iris data set.

# To generate a sequence of random numbers we use set.seed() in R. With the help of sample() method, we can split the data set into two parts i.e., training and testing data sets which will be splitted into 70: 30 ratio of the main data set ('iris').

# To store these splitted data sets we require two different variables that needs to be assigned as 'trainData' and 'testdata'.
# -----------------------------------------------------------------------------
# Problem 3
irisSepal <- Species ~ Sepal.Length + Sepal.Width
irisPetal <- Species ~ Petal.Length + Petal.Width
irisAll <-
  Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width

irisTree1 <- ctree(irisSepal, data = trainData)
irisTree2 <- ctree(irisPetal, data = trainData)
irisTree3 <- ctree(irisAll, data = trainData)

plot(irisTree1)
plot(irisTree2)
plot(irisTree3)

# To apply Decision Tree Model to our data set, we have to use "ctree()" method and include our Training Data set. Here we are performing by taking various independent variables and named as irisSepal, irisPetal, and irisAll. Let us also delve into the analysis by plotting these Decision Trees models to compare and observe the differences in each plot.

# From the plots, we can depict that there is a change in the root nodes and leaves. Primary node is called as the root and the bottom nodes are known as leaves. In this model, the decision makers are leaves. The final result is validated by a leaf node where the model terminates and has a value on the leaf

# --------------------------------------------------------------
# Problem 4
pred1 <- predict(irisTree1, testData)
pred1
table(pred1, testData$Species)
plot(pred1, main = "Tree 1 Prediction")

pred2 <- predict(irisTree2, testData)
pred2
table(pred2, testData$Species)
plot(pred2, main = "Tree 2 Prediction")

pred3 <- predict(irisTree3, testData)
pred3
table(pred3, testData$Species)
plot(pred3, main = "Tree 3 Prediction")

# Let's predict our model with the help of testing data set which was initially splitted as testData with 30% of main data set. For this, we have to use predict() method on the testing data set. In this, lets mix and match various columns to implement several various decision tree models and compare the prediction results of each.

# From the plots, we can depict that there is change in each prediction with respect to the columns. If the independent variable is tweaked then the final result will also get altered with respect to the columns

# -----------------------------------------------------------------------------
# Problem 5

set.seed(9000)
irisData2 <- iris
irisData2

irisData2$Species <- NULL
irisData2$species

irisKMeansClustering2 <- kmeans(irisData2, 2)
irisKMeansClustering2

table(irisKMeansClustering2$cluster, iris$Species)

plot(iris[c("Sepal.Length", "Sepal.Width")], col = irisKMeansClustering2$cluster)
points(
  irisKMeansClustering2$centers[, c("Sepal.Length", "Sepal.Width")],
  col = 1:3,
  pch = 8,
  cex = 1.5
)

irisKMeansClustering3 <- kmeans(irisData2, 3)
irisKMeansClustering3

table(irisKMeansClustering3$cluster, iris$Species)

plot(iris[c("Sepal.Length", "Sepal.Width")], col = irisKMeansClustering3$cluster)
points(
  irisKMeansClustering3$centers[, c("Sepal.Length", "Sepal.Width")],
  col = 1:3,
  pch = 8,
  cex = 1.5
)

irisKMeansClustering4 <- kmeans(irisData2, 4)
irisKMeansClustering4

table(irisKMeansClustering4$cluster, iris$Species)

plot(iris[c("Sepal.Length", "Sepal.Width")], col = irisKMeansClustering4$cluster)
points(
  irisKMeansClustering4$centers[, c("Sepal.Length", "Sepal.Width")],
  col = 1:3,
  pch = 8,
  cex = 1.5
)

irisKMeansClustering5 <- kmeans(irisData2, 5)
irisKMeansClustering5

table(irisKMeansClustering5$cluster, iris$Species)

plot(iris[c("Sepal.Length", "Sepal.Width")], col = irisKMeansClustering5$cluster)
points(
  irisKMeansClustering5$centers[, c("Sepal.Length", "Sepal.Width")],
  col = 1:3,
  pch = 8,
  cex = 1.5
)

# We have set the seed to 9000 and duplicated the data set with irisData2. Then removed the Species column by assigning it to the NULL. Let's perform some K-Means Clustering model also known as K-Means/ K Nearest Neighbors which segregates the the whole data set into various clusters/ groups/ partitions. After this, it further splits the data into alike clusters. groups/ partitions as nearer as available and cluster as apart as possible.

# We don't know the data sets features and parameters they show. And , also the clustering technique will use numerical data and drop non-numeric columns. After that, we will perform clustering by using the kmeans() method with 2 clusters with our normalized data set. Once it is performed, we again feed with 3 clusters, and then 4, and then 5.

# By doing like so, we can observe the change in the distances between them. The Euclidean Distances becomes lesser with increase in the clusters. Here, we can plot to see the clusters.

# -----------------------------------------------------------------------------
# Problem 6

eucledianDist <- dist(irisData2)
hierarachyCluster <- hclust(eucledianDist)
plot(hierarachyCluster)

# In this, we perform Hierarchical Clustering and it is not necessary to specify the number of clusters required to get the best result. This is known as a Dendogram and it looks like an inverted tree structure.

# -----------------------------------------------------------------------------
# Problem 7

densityCluster <- dbscan(irisData2, eps = 0.42, MinPts = 5)
table(densityCluster$cluster, iris$Species)
plotcluster(irisData2, densityCluster$cluster)

# In this, let us remove the Species ID's and use dbscan() method for clustering with the irisData2 data set. After that, let us compare with the original Species ID's in a table and plot the clusters. We can see few 0's in the graphs which are looked as outliers.

#------------------------------------------------------------------------------