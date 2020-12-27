# Print your name:
print("Thota, Sunil Raj")

# IMPORT data set

library(readr)
library(plyr)

inClass_RTest3a_Data <- read_csv(
        "inClass-RTest3a-Data.csv",
        col_types = cols(
                Sales = col_number(),
                Quantity = col_integer(),
                Discount = col_number(),
                Profit = col_number(),
                ShippingCost = col_number()
        )
)
inClass_RTest3a_Data
View(inClass_RTest3a_Data)

# Rename data set to companydata

companydata <- inClass_RTest3a_Data
companydata
View(companydata)
# Create an object named A to calculate the sum of profits for ALL observations
# Use code: round(sum(), digits = 1)
# Digits = 1 means using only one decimal
# Print A. For this class, always print your results using the print() code.

A <- round(sum(companydata$Profit), digits = 1)
print(A)
print(paste("The sum of all profits is", 38291.4))


# Create an object named B to calculate the mean profits for all observations
# Use code: round(mean(), digits = 1)
# Print B. For this class, always print your results using the print() code.

B <- round(mean(companydata$Profit), digits = 1)
print(B)

# Using the code:
# round(tapply(numerical-variable, INDEX = categorical-variable, FUN = mean), digits = 2)
# Create an object named C to calculate the mean sale per region, use 2 digit decimals.
# For numerical-variable you need to use: companydata$Sales
# For categorical-variable you need to use: companydata$Region
# Print C. For this class, always print your results using the print() code.

C <-
        round(tapply(companydata$Sales,
                     INDEX = companydata$Region,
                     FUN = mean),
              digits = 2)

print(C)


# IF your R codes are well done, you should be able to active the codes below.
# In the first code, you will see an horizontal bar plot for C.
# C is not sorted
# In the codes below, C is then sorted into C2 and then ploted.
# Compare the two bar plots

par(mai = c(1, 1.6, 0.6, 0.5))

barplot(
        C,
        horiz = T,
        las = 1,
        cex.names = 0.6,
        space = 0.6,
        col = rainbow(23),
        xlab = "Mean Sale (in US$)",
        main = "Bar plot of average sales per Region"
)

C2 = sort(C, decreasing = T)
print(C2)

barplot(
        C2,
        horiz = T,
        las = 1,
        cex.names = 0.6,
        space = 0.6,
        col = rainbow(23),
        xlab = "Mean Sale (in US$)",
        main = "Bar plot of average sales per Region"
)

# Create an object D to transform C into a data table, this way it is easier to see the data.
# Use code: as.table()
# Print D.

D <- as.table(C)
print(D)

# Create an object E to transform table D into a data frame.
# Use code: as.data.frame()
# Print E

E <- as.data.frame(D)
print(E)


# On E, the two variables appear as Var1 and Freq.
# Create an object F to rename Var1 to Region, and Freq to "Mean Sale"

F <- rename(E, "Region" = Var1, "Mean Sale" = Freq)
print(F)


# Export F as a CSV file into your project folder.
# This time I will provide the code.
# After activating this code, check the new CSV file on your computer folder.
# the new file can also be seen on the File windows of your R Studio.

write.table(F,
            file = "TableF.csv",
            row.names = FALSE,
            sep = ",")





# NEW ANALYSIS

# Create a new subset of your data (name it set1) using only the variables Country, price and quantity.
# Use code: companydata[c("Country","Sales", "Quantity")]
# Print set1

set1 <- companydata[c("Country", "Sales", "Quantity")]
print(set1)

# Create a new object set2 to enter a new calculated field by multiplying Sales by Quantity
# Name the new variable (calculated field) as TotalSales, this is (Sales*Quantity)
# Use code: mutate().
# Print set2

TotalSales <- set1$Sales * set1$Quantity
TotalSales
set2 <- mutate(set1, TotalSales = TotalSales)
print(set2)


# Using the code:
# round(tapply(numerical-variable, INDEX = categorical-variable, FUN = mean), digits = 2)
# Create an object named G to calculate the sum of TotalSales per category, use 2 digit decimals.
# For numerical-variable you need to use: set2$TotalSales
# For categorical-variable you need to use: set2$Country
# Print G.

G <-
        round(tapply(set2$TotalSales,
                     INDEX = set2$Country,
                     FUN = mean),
              digits = 2)

print(G)


# Create an horizontal bar plot to display G.
# Countries go on y-axis
# Total sales go on x-axis
# Increase x-axis limit to 1.2 times the maximum value on G. Use code: xlim = c(0,max(G)*1.2)
# Add y- and x-axes labels
# Add a title to the plot
# Add different colors to each bar
# Use code: cex.names = 0.5 to make country names smaller.
# Use code" las =1 to display country names horizontally
# Use code: space = 0.6 to make bars more clear from each other.


par(mai = c(0.8, 1.2, 0.6, 0.5))

barplot(G,)
barplot(
        G,
        main = "Total Sales vs Countries",
        xlab = "Total Sales",
        ylab = "Countries",
        beside = TRUE,
        width = 1.25,
        border = NA,
        col = c(
                "black",
                "blue",
                "green",
                "darkblue",
                "orange",
                "cyan",
                "brown",
                "yellow"
        ),
        xlim = c(0, max(G) * 1.2),
        las = 1,
        space = 0.6,
        cex.names = 0.5,
        horiz = TRUE
)
