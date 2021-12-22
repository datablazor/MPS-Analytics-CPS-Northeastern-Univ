# Intermediate Analytics
# ALY 6015
# Module 5 - Time Series in R
# 02/015/2021
# Sunil Raj Thota
# NUID: 001099670

#-----------------------------------------------------------------------------
# Get and set the working directories
getwd()
setwd('G:/NEU/Coursework/2021 Q1 Winter/ALY 6015 IA/Discussions & Assignments')
getwd()

# Installed the above packages into the work space
install.packages("plyr")
install.packages("dplyr")
install.packages("tidyr")
install.packages("TTR")
install.packages("forecast")

# Loaded the below libraries into the work space
library(plyr)
library(dplyr)
library(tidyr)
library(TTR)
library(forecast)

# -----------------------------------------------------------------------------
# PART A
# Problem 1

tsData <- scan("http://robjhyndman.com/tsdldata/data/fancy.dat")
tsData
View(tsData)
str(tsData)
head(tsData)
tail(tsData)
summary(tsData)

# Let's perform some Exploratory Data Analysis and Time series analysis using "sales" data set. To get this data set we need to search on Google as Monthly Sales for a Souvenir Shop in Australia from Jan 1987 - Dec 1993. After that, i have loaded the data set using scan() function. I also installed all the necessary package from the packages tab which is right side to the work space in R Studio.

# Or we can also install the packages by using install.packages("package name") command. Once it is loaded we can use it in the code for further analysis and calculations. Loaded the necessary library into the work space. Loaded the sales Data set into the Environment.

# I have also installed TTR package enables us to use SMA function which is required to smooth time data series by using Simple Moving Average. I have also installed 'TTR', 'SMA', to perform Smooth Time Data series by simply moving the averages. Let's install all the above packages.

# To View the diabetes Data set we use View() command, To observe the structure of the Data set we use str() command, and head () and tail() shows first and last few rows in the Data set. Summary() Provides the Descriptive Stats of the sales columns. We noticed 5 variables from the statistics given in the summary.

# -----------------------------------------------------------------------------
# Problem 2

tsTime <- ts(tsData, frequency = 12, start = c(1987, 1))
tsTime

ts.plot(
  tsTime,
  xlab = "Time Line",
  ylab = "Sales of Souvenir",
  main = "Sales of Souvenir from 1987 - 1994",
  col = "tomato"
)

tsToLog <- log(tsTime)
tsToLog

ts.plot(
  tsToLog,
  xlab = "Time Line",
  ylab = "Sales of Souvenir",
  main = "Sales of Souvenir from 1987 - 1994",
  col = "orange"
)

# I have utilized the "ts" function to time series data. I took frequency as 12 to format the data into 12 levels as the months are 12 from 1987 - 1993. I used "ts.plot" function to plot the time series data. In this plot, X Axis depicts the time line and Y Axis plots the number of sales of souvenir. The plot is of Additive type which is not applicable to utilize it for the time series analysis.

# Because the the difference between consecutive time series data is same. To analyze time series data, I need to convert it to multiplicative types by taking "Log" natural for the above dataset. Let's plot the data as shown above. I had used 'plot.ts' but it did not provide any differentiation and produced the same result.

# -----------------------------------------------------------------------------
# Problem 3

tsTimeSMAPlot1 <- plot(
  SMA(tsTime, n = 2),
  main = "Smooth the timeseries data (n=2)",
  col = "green",
  xlab = "Time Line",
  ylab = "Smoothen with (n=2)"
)
tsTimeSMAPlot2 <- plot(
  SMA(tsTime, n = 3),
  main = "Smooth the timeseries data (n=3)",
  col = "blue",
  xlab = "Time Line",
  ylab = "Smoothen with (n=3)"
)
tsTimeSMAPlot3 <- plot(
  SMA(tsToLog, n = 2),
  main = "Smooth the timeseries data - Log values (n=2)",
  col = "green",
  xlab = "Time Line",
  ylab = "Smoothen with Log Values (n=2)"
)
tsTimeSMAPlot4 <- plot(
  SMA(tsToLog, n = 3),
  main = "Smooth the timeseries data - Log values (n=3)",
  col = "blue",
  xlab = "Time Line",
  ylab = "Smoothen with Log Values (n=3)"
)

tsTimeDec <- decompose(tsTime)
tsTimeDec
plot(tsTimeDec,
     col = "brown",
     xlab = "Time Line")

tsTimeSeaOmit <- tsTime - tsTimeDec$seasonal
tsTimeSeaOmit
plot(tsTimeSeaOmit,
     main = "Time series data with no seasonality",
     col = "yellow",
     xlab = "Time Line")

# Let's smoothen the above four plots by using simple moving averages "SMA()" function. This function usually requires 2, 3 consecutive numbers and avg. them and take the next consecutive by averaging the data set. Let's use various values of "n" to alter the smoothing level. The peaks in the time series analysis is determined by SMA. Let's now analyze the components of a time series by using the "decompose()" function to segregate various components.

# After that, I have plotted the graph to analyze these components. In this, we already saw that there are four various components in this time series analysis as observed, trend, random, and seasonal. The seasonal attribute is recurring over the time line and is capable. To get a sure shot on this data we need to eradicate the seasonal aspect which does not give exact analysis of the trends

# Once that component is eradicated from the analysis we can see more precise information on the time series data behavior to observe the rise and fall of the data. From the plot we can depict that the unseasoned hike in the end

# -----------------------------------------------------------------------------
# PART B
# Problem 1

volcanoData <-
  scan("http://robjhyndman.com/tsdldata/annual/dvi.dat", skip = 1)
volcanoData
View(volcanoData)
str(volcanoData)
head(volcanoData)
tail(volcanoData)
summary(volcanoData)

# Let's perform some Exploratory Data Analysis and Time series analysis using "volcano" data set. After that, i have loaded the data set using scan() function. I also installed all the necessary package from the packages tab which is right side to the work space in R Studio.

# Or we can also install the packages by using install.packages("package name") command. Once it is loaded we can use it in the code for further analysis and calculations. Loaded the necessary library into the work space. Loaded the sales Data set into the Environment. I have also installed forecast package enables us to forecast. Let's install all the above packages.

# To View the diabetes Data set we use View() command, To observe the structure of the Data set we use str() command, and head () and tail() shows first and last few rows in the Data set. Summary() Provides the Descriptive Stats of the volcano columns. We noticed 5 variables from the statistics given in the summary. Let's use the ARIMA to discover the correlations and its problems

#------------------------------------------------------------------------------
# Problem 2

tsVolcanoData <- ts(volcanoData, start = c(1500), frequency = 12)
tsVolcanoData

volcanoDataDec <- decompose(tsVolcanoData)
plot(volcanoDataDec,
     col = "green",
     xlab = "Time Line")

volcanoDataSeaOmit <- tsVolcanoData - volcanoDataDec$seasonal
plot(volcanoDataSeaOmit,
     main = "Volcanic Eruptions with no Seasonality",
     xlab = "Time Line",
     col = "orchid")

acf(tsVolcanoData, lag.max = 40, main = "ACF")
pacf(tsVolcanoData, lag.max = 30, main = "PACF")

acf(tsVolcanoData, lag.max = 40, plot = FALSE)
pacf(tsVolcanoData, lag.max = 30, plot = FALSE)

tsVolcanoData1 <- ts(volcanoData, start = c(1500))
tsVolcanoData1

volcanoDataARIMA <- auto.arima(tsVolcanoData1)
volcanoDataARIMA

volcanoDataForecast <- forecast(volcanoDataARIMA)
volcanoDataForecast

plot(
  volcanoDataForecast,
  xlim = c(1500, 2000),
  col = "seagreen",
  xlab = "Timeline",
  ylab = "Volacnic Eruptions Count"
)

# Let's check the time series data for Volcano and took frequency as 12 because it has 12 levels for 12 months. To check for seasonality let's use decompose() and eradicate this component from the data and observe the volcanic eruptions trends

# The plot depicts the total number of volcanic eruptions from 1500 - 1540. And, also let's use acf() and pacf() functions to check correlation. Where acf() is auto correlation and pacf() is partial correlation. acf() performs auto-correlation on the time series data with lagged attributes. Where pacf() is partial auto-correlation function that is used to observe the residuals correlation

# Let's create time series with ARIMA function for the volcanoes data set. auto.arima() function checks the best value of q, p, and automatically. forecast() function is used to predict the volcanic eruptions trends. We can see that a prediction at the timeline end.
#-----------------------------------------------------------------------------