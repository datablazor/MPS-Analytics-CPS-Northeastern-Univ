## GBM ##

## Courtesy: http://uc-r.github.io/gbm_regression
install.packages("AmesHousing")
library(AmesHousing)
library(rsample)      # data splitting 
library(gbm)          # basic implementation
library(xgboost)      # a faster implementation of gbm
library(caret)        # an aggregator package for performing many machine learning models
library(h2o)          # a java-based platform
library(pdp)          # model visualization
library(ggplot2)      # model visualization
library(lime)         # model visualization
library(dplyr)
# Create training (70%) and test (30%) sets for the AmesHousing::make_ames() data.
# Use set.seed for reproducibility

set.seed(2020)
ames = read.csv("~/Downloads/EAI6000-FundamentalsOfAI_FallB_2020_Mon_72170/Coursework/Week3/Ames_Housing_Data/ames iowa housing.csv")
ames_split <- initial_split(ames, prop = .7)

#ames_split <- initial_split(AmesHousing::make_ames(), prop = .7)

ames_train <- training(ames_split)
ames_test  <- testing(ames_split)

# for reproducibility
set.seed(2020)

# train GBM model
gbm.fit <- gbm(
  formula = SalePrice ~ .,
  distribution = "gaussian",
  data = ames_train,
  n.trees = 5000,
  interaction.depth = 1,
  shrinkage = 0.001,
  cv.folds = 5,
  n.cores = NULL, # will use all cores by default
  verbose = FALSE
)  

# print results
print(gbm.fit)
## gbm(formula = Sale_Price ~ ., distribution = "gaussian", data = ames_train, 
##     n.trees = 10000, interaction.depth = 1, shrinkage = 0.001, 
##     cv.folds = 5, verbose = FALSE, n.cores = NULL)
## A gradient boosted model with gaussian loss function.
## 10000 iterations were performed.
## The best cross-validation iteration was 10000.
## There were 80 predictors of which 45 had non-zero influence.

quantile(ames$SalePrice, probs = seq(0,1,0.1))

# get MSE and compute RMSE
cv.error = sqrt(min(gbm.fit$cv.error)); cv.error
##  on average our model is about cv.error off from the actual sales price

# plot loss function as a result of n trees added to the ensemble
gbm.perf(gbm.fit, method = "cv")


### Tuning ###

# Number of trees: The total number of trees to fit. GBMs often require many trees; however, unlike random forests GBMs can overfit so the goal is to find the optimal number of trees 
# that minimize the loss function of interest with cross validation.

# Depth of trees: The number d of splits in each tree, which controls the complexity of the boosted ensemble. Often d=1 # works well, in which case each tree is a 
# stump consisting of a single split. More commonly, d is greater than 1 but it is unlikely d>10 will be required

# Learning rate/ Shrinkage: Controls how quickly the algorithm proceeds down the gradient descent. Smaller values reduce the chance of overfitting but also increases the time to
# find the optimal fit. 

# Subsampling: Controls whether or not you use a fraction of the available training observations. Using less than 100% of the training observations means you are
# implementing stochastic gradient descent. This can help to minimize overfitting and keep from getting stuck in a local minimum or plateau of the loss function gradient.

## n.minobsinnode is the minimum allowed observations for a leaf; if it's 1 - it's a singleton and the tree is with 0 bias but high variance
## default is 10

# for reproducibility
set.seed(2020)

# train GBM model
gbm.fit2 <- gbm(
  formula = SalePrice ~ .,
  distribution = "gaussian",
  data = ames_train,
  n.trees = 500,
  interaction.depth = 3,
  shrinkage = 0.1,
  cv.folds = 5,
  n.cores = NULL, # will use all cores by default
  verbose = FALSE
)  

# find index for n trees with minimum CV error
min_MSE <- which.min(gbm.fit2$cv.error); min_MSE

# get MSE and compute RMSE
sqrt(gbm.fit2$cv.error[min_MSE])

# plot loss function as a result of n trees added to the ensemble
gbm.perf(gbm.fit2, method = "cv")
## Green line is the test error and black line is the training error

# create hyperparameter grid
hyper_grid <- expand.grid(
  shrinkage = c(.01, .1, .3),
  interaction.depth = c(3, 4, 5),
  n.minobsinnode = c(5, 10, 15),
  bag.fraction = c(.65, .8, 1), 
  optimal_trees = 0,               
  min_RMSE = 0                   
)

# total number of combinations
nrow(hyper_grid)

# randomize data
random_index <- sample(1:nrow(ames_train), nrow(ames_train))
random_ames_train <- ames_train[random_index, ]

# grid search 
for(i in 1:nrow(hyper_grid)) {
  
  # reproducibility
  set.seed(123)
  
  # train model
  gbm.tune <- gbm(
    formula = SalePrice ~ .,
    distribution = "gaussian",
    data = random_ames_train,
    n.trees = 10,
    interaction.depth = hyper_grid$interaction.depth[i],
    shrinkage = hyper_grid$shrinkage[i],
    n.minobsinnode = hyper_grid$n.minobsinnode[i],
    bag.fraction = hyper_grid$bag.fraction[i],
    train.fraction = .75,
    n.cores = NULL, # will use all cores by default
    verbose = FALSE
  )
  
  # add min training error and trees to grid
  hyper_grid$optimal_trees[i] <- which.min(gbm.tune$valid.error)
  hyper_grid$min_RMSE[i] <- sqrt(min(gbm.tune$valid.error))
}

hyper_grid %>% 
  dplyr::arrange(min_RMSE) %>%
  head(10)


# modify hyperparameter grid
hyper_grid <- expand.grid(
  shrinkage = c(.01, .05, .1),
  interaction.depth = c(3, 5, 7),
  n.minobsinnode = c(5, 7, 10),
  bag.fraction = c(.65, .8, 1), 
  optimal_trees = 0,               # a place to dump results
  min_RMSE = 0                     # a place to dump results
)

# total number of combinations
nrow(hyper_grid)

# grid search 
for(i in 1:nrow(hyper_grid)) {
  
  # reproducibility
  set.seed(123)
  
  # train model
  gbm.tune <- gbm(
    formula = Sale_Price ~ .,
    distribution = "gaussian",
    data = random_ames_train,
    n.trees = 6000,
    interaction.depth = hyper_grid$interaction.depth[i],
    shrinkage = hyper_grid$shrinkage[i],
    n.minobsinnode = hyper_grid$n.minobsinnode[i],
    bag.fraction = hyper_grid$bag.fraction[i],
    train.fraction = .75,
    n.cores = NULL, # will use all cores by default
    verbose = FALSE
  )
  
  # add min training error and trees to grid
  hyper_grid$optimal_trees[i] <- which.min(gbm.tune$valid.error)
  hyper_grid$min_RMSE[i] <- sqrt(min(gbm.tune$valid.error))
}

hyper_grid %>% 
  dplyr::arrange(min_RMSE) %>%
  head(10)

# for reproducibility
set.seed(123)

# train GBM model
gbm.fit.final <- gbm(
  formula = Sale_Price ~ .,
  distribution = "gaussian",
  data = ames_train,
  n.trees = 483,
  interaction.depth = 5,
  shrinkage = 0.1,
  n.minobsinnode = 5,
  bag.fraction = .65, 
  train.fraction = 1,
  n.cores = NULL, # will use all cores by default
  verbose = FALSE
)  

## Visualizing - Variable Importance
par(mar = c(5, 8, 1, 1))
summary(
  gbm.fit2, 
  cBars = 10,
  method = relative.influence, # also can use permutation.test.gbm
  las = 2
)

par(mar = c(5, 8, 1, 1))
summary(
  gbm.fit.final, 
  cBars = 10,
  method = relative.influence, # also can use permutation.test.gbm
  las = 2
)

## Predicting

# predict values for test data
pred <- predict(gbm.fit2, n.trees = gbm.fit2$n.trees, ames_test)
pred <- predict(gbm.fit.final, n.trees = gbm.fit.final$n.trees, ames_test)

# results
caret::RMSE(pred, ames_test$Sale_Price)






