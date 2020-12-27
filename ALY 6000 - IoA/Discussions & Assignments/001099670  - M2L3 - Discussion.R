

install.packages("readxl")
library(readxl)

data <-
  read_excel("C:/Users/hp/Desktop/R Files/USMigration2017.xlsx",
             sheet = "US Popupation Data")
data
str(data)
View(data)
head(data)

boxPlotData <- data$`Domestic Migration Rate`

boxplot(
  `Domestic Migration Rate` ~ State, data = data,
  horizontal = TRUE, 
  xlab = "Domestic Migration Rate", 
  main = "Box Plot of \nDomestic Migration Rate",
  col = "gray",
  boxwex = 1.2, 
  staplewex = 0.5, 
  notch = TRUE,
  outline = TRUE,
  outpch = 16,
  outcol = "slategray3",
  las = 1
  )