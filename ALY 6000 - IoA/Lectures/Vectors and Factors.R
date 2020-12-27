#What's a factor and why would you use it? (3)
# VECTORS
# FACTORS
# DATA FRAMES
# ORDER
# CONVERT VECTORS INTO FACTORS
# CREATING LISTS
# THE IF AND ELSE STATEMENTS
# WHILE LOOP and FOR LOOP


                                  # INTERSTING CODES
#How to split a word in its letters
rquote <- "r's internals are irrefutably intriguing"
chars <- strsplit(rquote, split = "")[[1]]
chars
?count
count(chars, vars = "r")

                                 # VECTORS

# Sex vector
sex_vector <- c("Male", "Female", "Female", "Male", "Male")
sex_vector

# Convert sex_vector to a factor
factor_sex_vector <- factor(sex_vector)

# Print out factor_sex_vector
factor_sex_vector

     # How to add labels to a vector

data = c(10, 12, 14, 8, 13)
labels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
data
names
names(data) = labels
data

# Another option
data_1 = c("Monday" = 10, "Tuesday" = 13, "Wednesday" = 14, 
           "Thursday" = 8, "Friday" = 13)
data_1

is.vector(data)
is.vector(labels)
is.vector(data_1)
single = 4         #this is a vector of length 1
is.vector(single)
length(data)
length(single)

class(data)
class(labels)
class(data_1)
     
   
    # There are two types of categorical variables: nominal and ordinal.
# Animals are nominal
animals_vector <- c("Elephant", "Giraffe", "Donkey", "Horse")
factor_animals_vector <- factor(animals_vector)
animals_vector
factor_animals_vector

# Temperature is ordinal, indicate levels.
temperature_vector <- c("High", "Low", "High","Low", "Medium")
factor_temperature_vector <- factor(temperature_vector, order = TRUE, levels = c("Low", "Medium", "High"))
factor_temperature_vector


## Use levels(factor) to fix or change the levels 
# Code to build factor_survey_vector
survey_vector <- c("M", "F", "F", "M", "M")
factor_survey_vector <- factor(survey_vector)
survey_vector
factor_survey_vector

# Specify the levels of factor_survey_vector
levels(factor_survey_vector) <- c("Female", "Male")
factor_survey_vector

summary(survey_vector)          ##vector with 5 observations
summary(factor_survey_vector) ##factor with 2 levels, female male

# Male
male <- factor_survey_vector[1]
male

# Female
female <- factor_survey_vector[2]
female

# Battle of the sexes: Male 'larger' than female?
male > female  ##Not applicable to factors

# On the contrary if I measure 5 people speed
# Create speed_vector with their performance
speed_vector <- c("medium", "slow", "slow", "medium", "fast")

# Convert speed_vector to ordered factor vector
factor_speed_vector <- factor(speed_vector, order = TRUE, levels = c("slow", "medium", "fast"))
  
# Print factor_speed_vector
factor_speed_vector
summary(factor_speed_vector)

   ## To compare ordered factors
# Factor value for second data analyst

da2 <- factor_speed_vector[2]

# Factor value for fifth data analyst
da5 <- factor_speed_vector[5]

# Is data analyst 2 faster than data analyst 5?
# da2 is slow, da5 is fast
# Is da2 higher than da5?
da2 > da5  # False


# WORKING WITH DATA FRAMES
# Data sets with variables of different type, numerical, categorical, logic. e.g., a survey with multiple questions
# some codes to use head() tail () str() 
# Creating a data frame

# Definition of vectors

name <- c("Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune")
type <- c("Terrestrial planet", "Terrestrial planet", "Terrestrial planet", 
          "Terrestrial planet", "Gas giant", "Gas giant", "Gas giant", "Gas giant")
diameter <- c(0.382, 0.949, 1, 0.532, 11.209, 9.449, 4.007, 3.883)
rotation <- c(58.64, -243.02, 1, 1.03, 0.41, 0.43, -0.72, 0.67)
rings <- c(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE)

# Create a data frame from the vectors
planets_df <- data.frame(name, type, diameter, rotation, rings)
head(planets_df)
str(planets_df)
planets_df[1,3]
planets_df[4,]

library(DT)
library(rio)
datatable(planets_df)

# Only planets with rings
rings_vector = planets_df$rings

# Adapt the code to select all columns for planets with rings
planets_df[rings_vector, "name"]
planets_df[rings_vector, ]
subset(planets_df, subset = rings)
subset(planets_df, subset = diameter<1)           

# Sort 
a <- c(100, 10, 1000)
order(a)
a[order(a)]

# Use order() to create positions on planets based on diameter
positions <- order(planets_df$diameter)
positions
# Use positions to sort planets_df
planets_df[positions, ]

# LISTS
#CREATING LISTS

# Vector with numeric data from 1 up to 10
my_vector <- 1:10 
my_vector

# Matrix with numeric data from 1 up to 9
my_matrix <- matrix(1:9, ncol = 3)
my_matrix

# First 10 elements of the built-in data frame mtcars
my_df <- mtcars[1:10,]

# To create a list containing the three elements above:
my_list <- list(my_vector, my_matrix, my_df)
my_list

# To provide names to elements in the list, two options
my_list <- list(vec = my_vector, 
                mat = my_matrix, 
                df = my_df)

my_list2 <- list(my_vector, my_matrix, my_df)
names(my_list2) = c("vec", "mat", "df")
my_list2

#                                       THE IF STATEMENT AND ELSE STATEMENTS
#                                       if (condition){ exp }

x = -5
if (x<0) {print("x is a negative number")}
y = 5
if (y<0) {print("y is a negative number")}
if (y<0) {print("y is a negative number")} else {print("y is zero or a positive number")}

# Another interesting combination
# if (conditon){expr1} else if (condition2){expr2} else {exp3}
if (y<0) {print("y is a negative number")} else if(y == 0){Print("y is zero")} else {print("y is a positive number")}

x = -6
if (x %% 2 == 0){print("x is divisible by 2")} else if(x %% 3 == 0){print("x is divisible by 3")} else 
  {"x is not divisible by 2 or 3"}

medium <- "LinkedIn"
num_views <- 14

if (medium == "LinkedIn") {print("Showing LinkedIn information")
} else if (medium == "Facebook") {print("Facebook")
} else {print("Unknown medium")}

li <- 15
fb <- 9
li+fb

# Code the control-flow construct
if (li > 15 & fb > 15){sms <- 2 * (li + fb)} else if (li<10 & fb<10) {
  sms <- 0.5 * (li + fb)
} else {
  sms <- (li + fb)
}
sms

                                 # WHILE LOOP
                                 # while(condition){expr}
ctr=1
while(ctr<=7) {
  print(paste("ctr is set to", ctr)) 
  ctr<-ctr + 1}
ctr

speed <- 64
while (speed > 30 ) {print("Slow down!")
  speed <- speed-7
}
speed

                                   # A COMBINATION OF WHILE, IF, ELSE

speed=64
while(speed > 30) {print(paste("Your speed is", speed))} if (speed > 48){print("Slow down big time!") speed <- speed-11}

speed=64
if (speed > 48) {print("Slow down big time!") 
  speed <- speed-11
} else {print("Slow down!") 
  speed <- speed-6
}
speed

speed=64
if (speed > 48) {print("Slow down big time!") 
  speed <- speed-11
} else {print("Slow down!") 
  speed <- speed-6
}
speed

speed=64
while (speed > 30) {
  print(paste("Your speed is",speed))
  if (speed > 48) {
    print("Slow down big time!")
    speed <- speed - 11
  } else {print("Slow down!")
    speed <- speed - 6
  }
}

                                 # BREAK THE WHILE LOOP
                                 # Break the while loop when speed exceeds 80

speed <- 88

while (speed > 30) {
  print(paste("Your speed is", speed))
  if (speed >= 88) {break
    
  }
  
  if (speed > 48) {
    print("Slow down big time!")
    speed <- speed - 11
  } else {
    print("Slow down!")
    speed <- speed - 6
  }
}

# ANOTHER EXAMPLE

i <- 1
while (i <= 10) {
  print(3*i)
  if (i %% 8 == 0 ) {break
    
  }
  i <- i + 1
}

                  # FOR LOOP
                  # for (var in seq) { expr }
# It works for vectors, lists, matrices, data frames

cities = c("NYC", "Paris", "London", "Tokyo", "Rio", "Cape")
for(city in cities){print(city)}

city2 = list("Boston", "Paris", "London", "Tokyo", "Rio", "Cape")
for(city in cities2){print(city)}

#to break when for loop encounters a city name with 6 characthers
for(city in cities){
    if (nchar(city) == 6) {
      break
    }
  print(city)}

#To skip the city with that argument, use NEXT
for(city in cities){
  if (nchar(city) == 6) {
    next
  }
  print(city)}

# To access postion of city in the list or vector
length(cities)
for(i in 1:length(cities)){
  print(paste(cities[i], "is in position", i, "in the cities vector"))}

for(f in 1:length(cities)){
  print(paste(cities[f], "is in position", f, "in the cities vector"))}

# TWO VERSIONS OF FOR LOOP, for LISTS use [[i]] on the second version
primes <- c(2, 3, 5, 7, 11, 13)
# loop version 1
for (p in primes) {  print(p)}
# loop version 2
for (i in 1:length(primes)) {print(primes[i])}
for (i in 1:length(primes_list)) {print(primes_list[[i]])}

# LOOP OVER A MATRIX, IT NEEDS A FOR LOOP INSIDE A FOR LOOP
for (var1 in seq1) {
  for (var2 in seq2) {
    expr
  }
}

        # ANOTHER INTERESTING COMBINATION OF IF, BREAK, ELSE

linkedin <- c(16, 9, 13, 5, 2, 17, 14)

# Adapt/extend the for loop
for (li in linkedin) {
  if (li > 10) {
    print("You're popular!")
  } else {
    print("Be more visible!")
  }
  print(li)
}  

# Add if statement with break
for (li in linkedin) {
  if (li > 16) {
    print("This is ridiculous, I'm outta here!")
    break 
  } else {
    print("Be more visible!")
  }
  print(li)
}  

# Add if statement with next
for (li in linkedin) {
  if (li > 10) {
    print("You're popular!")
  }
  if (li < 5) {
    print("This is too embarrassing!")
    next 
  } else {
    print("Be more visible!")
  }
  print(li)
} 
