##Import data set wine, make sure to enter numeric on each corresponding variable, for wine type use character
# Data sets used Wine, USMigration

ncol(wine)
names(wine)
head(wine)

table(wine$Wine_type)
class(wine$Wine_type)

class(wine$Alcohol)
table(wine$Alcohol)
mean(wine$Alcohol)
sd(wine$Alcohol)

class(wine$Malic_acid)
table(wine$Malic_acid)
mean(wine$Malic_acid)
sd(wine$Malic_acid)

##boxplot of alcohol
boxplot(wine$Alcohol)

##but we want to see alcohol on each wine type
boxplot(wine$Alcohol)
boxplot(wine$Alcohol ~ wine$Wine_type)
boxplot(wine$Malic_acid~wine$Wine_type)
boxplot(wine$Alcohol, wine$Malic_acid)

##Add labels. add y limits, change direction of numbers on y axis
boxplot(wine$Alcohol~wine$Wine_type,
        main="Box plot alcohol content per wine type",
        xlab="Wine Type",
        ylab="Alcohol content",
        ylim=c(10,16),
        las=1)

##Add color, remove border, change box width
boxplot(wine$Alcohol~wine$Wine_type,
        main="Box plot alcohol content per wine type",
        xlab="Wine Type",
        ylab="Alcohol content",
        ylim=c(10,16),
        las=1,
        col=c("blue","red", "yellow"),
        frame.plot=FALSE,
        boxwex=.4
        )

#Another data example in class
box2 = c(2, 3, 5, 6, 7, 7, 8, 9, 10, 10, 11, 11, 11, 11, 12, 12, 13, 14, 15, 16, 16, 16, 17, 19, 20, 21, 21, 22, 23, 27, 30, 32, 32, 33, 37, 37, 38)
boxplot(box2, horizontal = TRUE,
        main="Box plot Example",
        xlab="Data",
        ylab="Data values",
        ylim=c(0,50),
        las=1,
        col=c("lightblue"),
        frame.plot=FALSE,
        boxwex=0.6,
        staplewex = 1,
        plot=TRUE)
text(x = boxplot.stats(box2)$stats, labels = boxplot.stats(box2)$stats, y = 1.25)
?boxplot

