# (1) Interactive tables.  

?rio
?DT
install.packages(DT)
library(DT)
library(rio)

# Using dataset wine

head(wine)

?datatable
datatable(wine)

#Click on the "Show in new window" under Viewer, it will open it in a web browser 

datatable(wine, filter = 'top')
# It add search boxes to each column, check the sliding bar you obtain.

datatable(wine, filter = 'top', rownames = F)
# It removes the numbers for each row

datatable(wine, filter = 'top', options = list(paging = F))
# It shows all entries in the data set. The option "show # entries" disappears. 

#name the table
Table1 = datatable(wine, filter = 'top', options = list(paging = F))
Table1
saveWidget(Table1, "TableFinal.html")
# Check the files section (inside R Studio), new file should be there. Now you can open the table in a browser and explore it outside R


# (2) Data.table. 
# data[i, j, by] in SQL is defined by Where, Select, Group by.
# Take data from set, subset rows using i, then calculate j grouped by by.
 
library(data.table)
cars = car_sale_india 
summary(cars) 
class(cars)
Table2 = as.data.table(cars)
Table2
barplot(table(cars$FuelType))

#Just to compare with above procedure
datatable(cars)
datatable(cars, filter = 'top', options = list(paging = F))
# Click icon "Show in new window" on top bsr of Viewer Window. 
# It will show table in a new window, html format, easier to navigate.

str(cars) # Table contains 6019 observations


# i, To select only observations of interest, e.g., gasoline cars on sale in Mumbai
# This produce a table with 458 observations
results = Table2[Location == 'Mumbai' & FuelType == 'Gasoline']
str(results)

# j, To add an additional calculation, let's use a numerical value
# Let's check the mean kilometers on those cars
results2 = Table2[Location == 'Mumbai' & FuelType == 'Gasoline', mean(Km, na.rm = T)]
results2  # The mean is 39,163 Km

# by, To aggregate by a particular variable, e.g., Year
results3 = Table2[Location == 'Mumbai' & FuelType == 'Gasoline', mean(Km, na.rm = T), 
                  by = Year]
results3
View(results3)
datatable(results3)
# This way now we can see the yearly average Km of gasoline cars in Mumbai.

#another example, cars with Km higher than 80,000, then average their horse power

results4 = Table2[Km > 80000]
str(results4) # 1123 observations
results4 = Table2[Km > 80000, mean(Power_bhp, na.rm = T)]
results4 # shows that the mean of 1123 observations is 114.6
str(results4) # shows num 115
results4 = Table2[Km > 80000,                   # i or Where
                  mean(Power_bhp, na.rm = T),   # j or Select
                  by = Year]                    # by or Group by

results4
datatable(results4, filter = 'top', options = list(paging = F))

# Select rows in the tables above
wine[4:10,]
cars[4:8,]
# If comma is omitted, then it selects columns instead
wine[4:10,1:3]
cars[4:8,1:3]
# Add only the number of a column of interest
wine[4:10,3] # Variable Malic_acid
cars[4:8,3]  # Variable Year


