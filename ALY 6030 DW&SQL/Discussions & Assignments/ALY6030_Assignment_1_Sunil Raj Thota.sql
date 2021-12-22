-- Create a Schema called "airports_data"
CREATE SCHEMA `airports_data`;

-- Create a Table called "airports" and define the datatypes of the attributes
CREATE TABLE `airports_data`.`airports` (
    `iata` TEXT(255) NOT NULL,
    `airport` TEXT(255) NOT NULL,
    `city` TEXT(255) NOT NULL,
    `state` TEXT(255) NOT NULL,
    `country` TEXT(255) NOT NULL,
    `lat` DOUBLE NOT NULL,
    `long` DOUBLE NOT NULL,
    `cnt` INT NOT NULL
)  ENGINE=CSV DEFAULT CHARACTER SET=UTF8MB4;

-- Select all columns from the airports table in airports_data database
SELECT * FROM airports_data.airports;

-- Select airport, state, and low performing airports count as lpaCount which are in between 0 and 100 only from the airports table
SELECT 
    airport, state, cnt AS lpaCount
FROM
    airports_data.airports
WHERE
    cnt BETWEEN 0 AND 100;

-- Select state, min, average, and maximum count of  flights in a month in a particular state in the USA from the airports table. Here, we have grouped the results with the state and displayed the maximum count first in a descending order
SELECT 
    state, MIN(cnt), AVG(cnt), MAX(cnt)
FROM
    airports_data.airports
GROUP BY state
ORDER BY MAX(cnt) DESC;

-- Select state, airport, counts having more than or equal to 15000  flights and ordered by count in a descending order
SELECT 
    state, airport, cnt
FROM
    airports_data.airports
HAVING cnt >= 15000
ORDER BY cnt DESC;