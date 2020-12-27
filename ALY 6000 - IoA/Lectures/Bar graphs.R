
                # BAR CHART
                # PIE CHART

##Bar plots are created using the bar function
##Import data set car sales India
head(car_sale_india)
ncol(car_sale_india)

##Change name of data set to something shorter
cars=car_sale_india
head(cars)
summary(cars)
ncol(cars)   # It will tell you the number of columns or variables
names (cars) # It will tel you the names of all the variables 

#Basic bar graphs
# Select the variable, I use a name related to that variable. Use the $ symbol between the data name and the variable of your interest
# Notice the use of the symbol $ to indicate the data set and the variable
# dataset$variable

fuel=table(cars$FuelType)

# main is for the tile, xlab and ylab for the labels

barplot(fuel, main="car sales in India",xlab="fuel type",ylab = "Counts")
mean(cars$FuelType) # This does not work because it is not numeric data

##To observe counts for each category
print(fuel)

##you can also call the variable directly
barplot(table(cars$Owner))
##or with pre-given name
owner=(table(cars$Owner))
owner
barplot(owner)

##add order
barplot(owner[order(owner,decreasing = TRUE)])

##add color to bars in order
barplot(owner[order(owner,decreasing = TRUE)], col = c("red","blue","yellow","green"))
barplot(fuel[order(fuel,decreasing = TRUE)], col = c("red","blue","yellow","green","purple"))

##Color can also be given using color palete codes
barplot(owner[order(owner,decreasing = TRUE)], col = c("#E75656","#CB1FD6","#0CAD6F","green"))

barplot(fuel, 
        col = c("#E75656","#CB1FD6","#0CAD6F","green"), 
        main="car sales in India\1998-2019",
        xlab="fuel type",
        ylab = "Counts",
)

##Use the help option to see other options for barplots, such as borders for the bars (border), orientation (horiz=TRUE)
barplot(fuel, 
        horiz = TRUE,
        col = c("#E75656","#CB1FD6","#0CAD6F","green"), 
        main="car sales in India\1998-2019",
        xlab="fuel type",
        ylab = "Counts",
)
?barplot

##To create clustered bar charts
table=table(cars$FuelType, cars$Transmission)
table2=prop.table(table, 1)
?prop.table

fuelTrans=table(cars$FuelType, cars$Transmission)
barplot(fuelTrans)
barplot(fuelTrans, beside = TRUE)
barplot(fuelTrans, beside = TRUE, 
        main="Transmission and Fuel Type",
        col = c("#E75656","#CB1FD6","#0CAD6F","green"),
        legend=rownames(table2),
        xlab = "Transmission",
        ylab = "Counts")

##Want to change orientation?
barplot(fuelTrans, beside = TRUE, 
        horiz = TRUE,
        main="Transmission and Fuel Type",
        col = c("#E75656","#CB1FD6","#0CAD6F","green"),
        legend=rownames(table2),
        xlab = "Transmission",
        ylab = "Counts"
)

       # PIE CHART

table(car_sale_india$Owner)          # observe the counts
pie(table(car_sale_india$Owner))

table(car_sale_india$Seats)          # observe the counts
pie(table(car_sale_india$Seats))

table(car_sale_india$FuelType)
pie(table(car_sale_india$FuelType))
