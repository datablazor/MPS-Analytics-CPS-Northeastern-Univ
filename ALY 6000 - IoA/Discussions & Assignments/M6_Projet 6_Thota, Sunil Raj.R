# Introduction to Analytics
# ALY 6000 - 71618 (CRN Number)
# Module 6 Project 6 - Final Project
# 10/20/2020
# Sunil Raj Thota
# NUID: 001099670

StudentName <- "Sunil Raj Thota"
StudentName # Created the vector

print(paste("My name is", StudentName))

install.packages("plyr")
install.packages("magrittr")
install.packages("dplyr")
install.packages("tidyr")
install.packages("tidyverse")
install.packages("DT")
install.packages("ggplot2")
# Installed the above packages into the workspace

library(plyr)
library(magrittr)
library(dplyr)
library(tidyr)
library(tidyverse)
library(DT) # To create interactive tables
library(ggplot2)
require(grDevices)
library(readr)
# Loaded the above libraries into the workspace

M6Set1 <-
  read_csv(
    "M6Set1.csv",
    col_types = cols(
      RowID = col_skip(),
      OrderID = col_skip(),
      ShipDate = col_skip(),
      CustomerID = col_skip(),
      CustomerName = col_skip(),
      PostalCode = col_skip(),
      ProductID = col_skip(),
      ProductName = col_skip(),
      Sales = col_number(),
      Quantity = col_number(),
      Discount = col_number(),
      Profit = col_number(),
      ShippingCost = col_number()
    )
  )
M6Set1 # Imported the dataset M6Set1.csv
View(M6Set1) # View the dataset M6Set1.csv

dataSet <- M6Set1
dataSet # Changed the data set name to dataSet
View(dataSet) # View dataSet data set

str(dataSet) # Structure of the data set
summary(dataSet) # To know the Descriptive Summary of the Data set

# The below data set will be used throughout the code from here
uniqueData <-
  subset(
    dataSet,
    select = c(
      "Sales",
      "Quantity",
      "Discount",
      "Profit",
      "ShippingCost",
      "Region",
      "Segment",
      "Category",
      "SubCategory",
      "ShipMode"
    )
  )
uniqueData # Using 5 Numerical and 5 Categorical Variables of my choice
str(uniqueData) # To know know the structure of the data set
View(uniqueData) # To view the data
summary(uniqueData) # To get know the stats of the data

sales <- data.matrix(summary(uniqueData$Sales))
sales # Sales Summary
quantity <- data.matrix(summary(uniqueData$Quantity))
quantity # Quantity Summary
discount <- data.matrix(summary(uniqueData$Discount))
discount # Discount Summary
profit <- data.matrix(summary(uniqueData$Profit))
profit # Profit Summary
shipcost <- data.matrix(summary(uniqueData$ShippingCost))
shipcost # Shipping Cost Summary

numSummaryData <-
  rename(
    data.frame(sales, quantity, discount, profit, shipcost),
    `Sales in $ (dollars)` = "sales",
    Quantity = "quantity",
    Discount = "discount",
    `Profit in $ (dollars)` = "profit",
    `Shipping Cost in $ (dollars)` = "shipcost"
  ) # Renamed all the numerical Summary data

str(numSummaryData) # Structure of the Numerical Summary Data
write.table(numSummaryData,
            file = "Numerical Summary Data.csv",
            row.names = F,
            sep = ",") # To save the table as a CSV File
View(numSummaryData) # To view the data

DT::datatable(
  numSummaryData,
  options = list(autoWidth = TRUE, paging = FALSE),
  class = "cell-border stripe",
  callback = JS("return table;"),
  filter = c("top"),
  escape = TRUE,
  style = "default",
  fillContainer = getOption("DT.fillContainer", NULL),
  autoHideNavigation = getOption("DT.autoHideNavigation", NULL),
  selection = c("multiple", "single", "none"),
  extensions = list(),
  plugins = NULL,
  editable = "cell",
  rownames = TRUE
)# Created an interactive Table, added the top filter for each column, removed the default numbers of each row and displayed the table without page breaks. Also, added few other data table features

levels(factor(dataSet$Country))
levels(factor(dataSet$Market))
levels(factor(dataSet$OrderPriority)) # To know the levels of the Country, Market, and Order Priority

levels(factor(uniqueData$Region))
levels(factor(uniqueData$Segment))
levels(factor(uniqueData$Category))
levels(factor(uniqueData$SubCategory))
levels(factor(uniqueData$ShipMode))
# To know the levels of the Region, Segment, category, Sub Category and Ship Mode

# Plots

#1 To Calculate Overall Sales By Region and plotted it in a Pie Chart
OverallSalesUS <- uniqueData %>%
  group_by(Region) %>%
  summarize(OverallSales =
              sum(Sales, na.rm = TRUE))
OverallSalesUS # Overall Sales by Region

pct <-
  round(OverallSalesUS$OverallSales / sum(OverallSalesUS$OverallSales) *
          100,
        2)
pct # Overall Sales by Region in Percentages

mutate(OverallSalesUS, pct) # Combined the pct data to Overall Sales data
lbls <- OverallSalesUS$Region
lbls <- paste(lbls, pct) # added percents to labels
lbls <- paste(lbls, "%", sep = "")
lbls # labels

pie(
  pct,
  col = rainbow(22),
  clockwise = TRUE,
  main = "Sales By Region",
  border = TRUE,
  density = 108
) # Plotted a pie chart to showcase the sales by region
legend(
  "right",
  legend = lbls,
  cex = 0.65,
  bty = "n",
  fill = rainbow(22),
  xpd = TRUE,
  inset = c(-0.1, 0.95),
  border = TRUE,
  density = 540
) # To indicate the legend


#2 To Calculate Quantity's Sold By Segment and plot it in a Bar Plot
segOverview <- uniqueData %>%
  group_by(Segment) %>% summarize(totalQuantity = sum(Quantity, na.rm = TRUE))
segOverview # Quantity's sold ny the segment

barplot(
  height = as.matrix(segOverview$totalQuantity),
  ylim = c(0, 3),
  xlim = c(0, 3000),
  ylab = "Segments",
  xlab = "Total Quantities Sold",
  main = "Quantity's Sold By Segment - Overview",
  col = c("pink", "violet", "purple"),
  names.arg = segOverview$Segment,
  legend = TRUE,
  beside = TRUE,
  width = 0.75,
  space = 0.0005,
  border = NA,
  las = 1,
  cex.names = 0.65,
  cex.lab = 1,
  horiz = TRUE,
  cex.axis = 0.8
) # Plotted a bar plot to showcase the segment overiew
legend(
  "topright",
  c(segOverview$Segment),
  fill = c("pink", "violet", "purple"),
  cex = 1,
  xpd = TRUE
) # To indicate the legend


#3 To Calculate Top 5 Sub Category's By Sales & Profits and plotted it in a GG Plot - Bar Plot
topSalesAndProfits <- uniqueData %>%
  group_by(SubCategory) %>%
  summarize(OverallSales = round(sum(Sales, na.rm = TRUE) / 1000, 2),
            OverallProfits = round(sum(Profit, na.rm = TRUE) / 1000, 2)) %>% arrange(desc(OverallSales)) # To know the top Sales and Profits
topSalesAndProfits <- head(topSalesAndProfits, 5) # Top 5
topSalesAndProfits

subc <- c(topSalesAndProfits$SubCategory)
plot <-
  c(
    "Sales",
    "Sales",
    "Sales",
    "Sales",
    "Sales",
    "Profits",
    "Profits",
    "Profits",
    "Profits",
    "Profits"
  )
value <-
  abs(c(
    topSalesAndProfits$OverallSales,
    topSalesAndProfits$OverallProfits
  ))
dataf <- data.frame(subc, plot, value)
dataf

ggplot(dataf, aes(fill = plot, y = value, x = subc)) +
  geom_bar(position = "dodge", stat = "identity") +
  ggtitle("Top 5 Sub categories By Sales & Profits") +
  xlab("Sub Categories") +
  ylab("Sales & Profits in Thousand $ (dollars)") +
  labs(fill = "Indicators") # Plotted a GG Plot to showcase the top 5 Sub categories by sales and profits


#4 To Calculate Popular Shipping Mode By Count and plotted it in a Bar Plot
popularShipMode <- table(uniqueData$ShipMode)
popularShipMode
barplot(
  popularShipMode[order(popularShipMode, decreasing = TRUE)],
  ylim = c(0, 400),
  xlab = "Shipping Mode",
  ylab = "Total Count",
  main = "Popular Shipping Mode",
  beside = TRUE,
  las = 1,
  cex.names = 1,
  col = c("darkorchid1", "deeppink3", "coral2", "brown2"),
  border = NA,
  width = 0.25,
  space = 0.15,
  cex.axis = 1,
  cex.lab = 1.2,
  legend = TRUE
)
legend(
  "right",
  c(popularShipMode),
  fill = c("darkorchid1", "deeppink3", "coral2", "brown2"),
  inset = c(-0.0005, 0.95),
  cex = 1.2,
  xpd = TRUE
) # Plotted a bar plot to showcase the popular shipping mode and added the legend to indicate the values


#5 To Calculate Overall Quantity Sold By Sub Category and plotted it in a Bar Plot
salesBySubCat <- uniqueData %>%
  group_by(SubCategory) %>%
  summarize(quantityAll =
              sum(Quantity, na.rm = TRUE))
salesBySubCat # Sales by Sub category

barplot(
  height = as.matrix(salesBySubCat$quantityAll),
  col = rainbow(17),
  main = "Sales By Sub Category",
  xlab = "Sub Category",
  ylab = "Quantity",
  beside = TRUE,
  width = 0.3,
  border = NA,
  ylim = c(0, 1000),
  las = 2,
  cex.axis = 1,
  cex.names = 0.7,
  cex.lab = 1.1,
  names.arg = salesBySubCat$SubCategory
) # Plotted a bar plot to showcase the sales by sub category


#6 To Calculate Shipping Cost in Dollars and plotted it in a Histogram Plot
hist(
  uniqueData$ShippingCost,
  xlab = "Shipping Cost in $ (dollars)",
  ylab = "Frequency",
  main = "Frequency Distribution of Shipping Cost",
  xlim = c(0, 1000),
  ylim = c(0, 500),
  col = rainbow(7),
  border = F,
  labels = TRUE,
  density = 1000
) # Plotted a histogram to showcase the Shipping Cost Distribution


#7 To Calculate Total Discounts among all Categories and plotted it in a Box Plot
boxplot(
  Discount ~ Category,
  data = uniqueData,
  ylab = "Discounts",
  xlab = "Category",
  main = "Total Discounts among all Categories",
  col = c("pink",
          "darkorchid",
          "brown1"),
  boxwex = 0.3,
  outline = TRUE,
  outpch = 16,
  outcol = "seagreen3",
  las = 1,
  notch = FALSE,
  staplewex = 1
) # Plotted a box plot to showcase the Discounts and Category


#8 To Calculate Profits, Sales, & Shipping Costs in % Share and plotted it in a Pie Chart
totalSums <-
  c(sum(uniqueData$Sales),
    sum(uniqueData$Profit),
    sum(uniqueData$ShippingCost))

totalSumsPct <- c(
  round(totalSums[1] / sum(totalSums) * 100, 2),
  round(totalSums[2] / sum(totalSums) * 100, 2),
  round(totalSums[3] / sum(totalSums) * 100, 2)
)
text <- c("Sales", "Profits", "Shipping Costs")
dtable <- data.frame(totalSumsPct, text)

lbls <- dtable$text
lbls <- paste(lbls, dtable$totalSumsPct) # add percents to labels
lbls <- paste(lbls, "%", sep = "")
pie(
  totalSumsPct,
  col = c("slateblue1", "tomato", "violetred"),
  clockwise = TRUE,
  main = "Profits, Sales, & Shipping Costs in % Share",
  labels = lbls,
  density = 100,
  border = TRUE
)
legend(
  "right",
  legend = lbls,
  bty = "n",
  fill = c("slateblue1", "tomato", "violetred"),
  cex = 0.75,
  xpd = TRUE,
  inset = c(-0.1, 0.95),
  border = TRUE,
  density = 180,
  text.font = 16,
  text.width = 2
) # Calculated Profits, Sales, & Shipping Costs in % Share and plotted it in a Pie Chart and added the legend to indicate the values
