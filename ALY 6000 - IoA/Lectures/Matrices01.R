# Poker and roulette winnings from Monday to Friday:

poker_vector <- c(140, -50, 20, -120, 240)
roulette_vector <- c(-24, -50, 100, -350, 10)
days_vector <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")

# To link the days of the week with the values on vectors poker and roulette
names(poker_vector) <- days_vector
names(roulette_vector) <- days_vector

# Which days did you make money on poker?
poker_vector  > 0
# Provide a name
selection_vector1 <- poker_vector  > 0
selection_vector1

# Select from poker_vector these days
poker_vector[selection_vector1]
# Provide a name
poker_winning_days <- poker_vector[selection_vector1]
poker_winning_days
sum(poker_winning_days)


# Which days did you make money on roulette?
roulette_vector > 0
# Provide a name
selection_vector2 <- roulette_vector > 0
selection_vector2

# Select from roulette_vector these days
roulette_winning_days <- roulette_vector[selection_vector2]
roulette_winning_days
sum(roulette_winning_days)


# Matrix 
new_hope <- c(460.998, 314.4)
empire_strikes <- c(290.475, 247.900)
return_jedi <- c(309.306, 165.8)

# Create box_office
box_office <- c(new_hope, empire_strikes, return_jedi)

# Construct star_wars_matrix
star_wars_matrix <- matrix(box_office, nrow = 3, byrow = TRUE)
star_wars_matrix

# Naming a matrix, construct a matrix, SAME RESULT
star_wars_matrix <- matrix(c(new_hope, empire_strikes, return_jedi), nrow = 3, byrow = TRUE)
star_wars_matrix

# Vectors region and titles, used for naming
region <- c("US", "non-US")
titles <- c("A New Hope", "The Empire Strikes Back", "Return of the Jedi")

# Name the columns with region
colnames(star_wars_matrix) <- region

# Name the rows with titles
rownames(star_wars_matrix) <- titles

# Print out star_wars_matrix
star_wars_matrix

worldwide_vector <- rowSums(star_wars_matrix)

# Row counts another way. Construct star_wars_matrix
box_office <- c(460.998, 314.4, 290.475, 247.900, 309.306, 165.8)
star_wars_matrix <- matrix(box_office, nrow = 3, byrow = TRUE,
        dimnames = list(c("A New Hope", "The Empire Strikes Back", "Return of the Jedi"), 
        c("US", "non-US")))

# Calculate worldwide box office figures
worldwide_vector <- rowSums(star_wars_matrix)
worldwide_vector

#Adding the new values as a new calculated column
# cbind() function merges matrices and/or vectors together by column
all_wars_matrix <- cbind(star_wars_matrix, worldwide_vector)
all_wars_matrix

##Adding a row uses rbind() function
#Let's create a new matrix star_wars_matrix2 
phantom_menace <- c(474.5, 552.5)
attack_clones <- c(310.7, 338.7)
star_wars_matrix2 <- matrix(c(phantom_menace, attack_clones), nrow = 2, byrow = TRUE)
titles2 <- c("The Phantom Menace", "Attack of the clones")
rownames(star_wars_matrix2) <- titles2


##Add the new rows
all_wars_matrix2 <- rbind(star_wars_matrix, star_wars_matrix2)
all_wars_matrix2

##The total box office revenue for the entire saga
total_revenue_vector <- colSums(all_wars_matrix2)
total_revenue_vector

##Selection of matrix elements using [ ], use comma to indicate row and column
all_wars_matrix2[1,1]
all_wars_matrix2[1:2, 1:2]
all_wars_matrix2[1,]
all_wars_matrix2[,1]

# Select the non-US revenue for all movies
non_us_all <- all_wars_matrix[,2]

# Average non-US revenue
mean(non_us_all)

# Select the non-US revenue for first two movies
non_us_some <- all_wars_matrix[1:2,2]

# Average non-US revenue for first two movies
mean(non_us_some)

#A little arithmetic with matrices
# If price of tickets were $5, estimate the visitors
visitors <- all_wars_matrix/5

# Print the estimate to the console
visitors

# PERFORM COMPARISONS
# The linkedin and facebook vectors have already been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# Popular days
linkedin>15

# Quiet days
linkedin<=5

# LinkedIn more popular than Facebook
linkedin>facebook

#cREATE MATRIX AND USE IT FOR COMPARISONS
views <- matrix(c(linkedin, facebook), nrow = 2, byrow = TRUE)

# When does views equal 13?
views == 13

# When is views less than or equal to 14?
views <= 14

##AND &, OR |, NOT ! OPERATORS
TRUE & TRUE
TRUE & FALSE
FALSE & TRUE
FALSE & FALSE
x=12
x>5 & x<15
x>5 & x<11
c(TRUE, TRUE, FALSE) & c(TRUE, FALSE, FALSE)
c(TRUE, TRUE, FALSE) && c(TRUE, FALSE, FALSE) # && double check only the first element

TRUE | TRUE
TRUE | FALSE
FALSE | TRUE
FALSE | FALSE
y = 4
y<5 | y>10
y<2 | y>10
c(TRUE, TRUE, FALSE) | c(TRUE, FALSE, FALSE)
c(TRUE, TRUE, FALSE) || c(TRUE, FALSE, FALSE) # || double check only the first element


!TRUE
!FALSE
!!FALSE
x=6
x > 5
!(x > 5)
x < 5
!(x < 5)
is.numeric(5)
!is.numeric(5)
is.numeric("Hello")
!is.numeric("Hello")

x <- 5
y <- 7
!(x < 4)
!!!(y > 12)
!(x < 4) & !!!(y > 12)
!(!(x < 4) & !!!(y > 12))

