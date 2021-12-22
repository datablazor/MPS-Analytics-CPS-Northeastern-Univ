-- Creating a Schema called sacramento
CREATE SCHEMA sacramento;

-- Using sacramento as our current database
USE sacramento;

-- Creating a Table called master
CREATE TABLE `master` (
    `Sale_ID` INT NOT NULL AUTO_INCREMENT,
    `Street` VARCHAR(255) NOT NULL,
    `City` VARCHAR(255) NOT NULL,
    `State` CHAR(5) NOT NULL,
    `Zip` CHAR(5) NOT NULL,
    `Beds` INT NOT NULL,
    `Baths` DECIMAL(4 , 2 ) NOT NULL,
    `Sq_ft` DECIMAL(7 , 2 ) NOT NULL,
    `Property_Type` VARCHAR(255) NOT NULL,
    `Sale_Date` VARCHAR(255) NOT NULL,
    `Price` DECIMAL(8 , 2 ) NOT NULL,
    `Latitude` DECIMAL(8 , 6 ) NOT NULL,
    `Longitude` DECIMAL(7 , 3 ) NOT NULL,
    PRIMARY KEY (`Sale_ID`)
)  ENGINE=INNODB AUTO_INCREMENT=986 DEFAULT CHARSET=UTF8MB3 SELECT COUNT(*) FROM
    sacramento.master;

-- Check for the Duplicates (If Any)
-- In this we are grouping all the houses based on its price, street, and sale DATE
-- Also checking for the duplicates by abalyzing the records with more than one record
-- In the result, we have found there are 3 duplicate records
SELECT 
    Street, Sale_Date, Price, Latitude, Longitude, COUNT(*)
FROM
    sacramento.master
GROUP BY Street , Sale_Date , Price , Latitude , Longitude
HAVING COUNT(*) > 1;

-- Setting this to not to update or delete records without specifying a key
SET SQL_SAFE_UPDATES = 0;

-- Delete the duplicates
-- Now total records are 982
DELETE a FROM sacramento.master AS a
        INNER JOIN
    sacramento.master AS b 
WHERE
    a.Sale_ID < b.Sale_ID
    AND a.Street = b.Street
    AND a.Sale_Date = b.Sale_Date
    AND a.Price = b.Price
    AND a.Latitude = b.Latitude
    AND a.Longitude = b.Longitude;
 
 -- We are creating a table called Location
CREATE TABLE Location (
    `Property_ID` INT NOT NULL AUTO_INCREMENT,
    `Street` VARCHAR(255) NOT NULL,
    `City` VARCHAR(255) NOT NULL,
    `State` CHAR(5) NOT NULL,
    `Zip` CHAR(5) NOT NULL,
    `Latitude` DECIMAL(8 , 6 ) NOT NULL,
    `Longitude` DECIMAL(7 , 3 ) NOT NULL,
    PRIMARY KEY (`Property_ID`)
);

-- Setting the Auto Increment to 100 because there is a small variation among Sale_ID and Property_ID
ALTER TABLE Location AUTO_INCREMENT = 100;

-- Inserting these variables to the Location table
INSERT INTO Location (Street, City, State, Zip, Latitude, Longitude)
SELECT Street, City, State, Zip, Latitude, Longitude
FROM sacramento.master;

-- Let's check for any duplicates that might occur
-- Found out a single record which has a 2 entries
SELECT 
    Street, City, State, Zip, Latitude, Longitude, COUNT(*)
FROM
    Location
GROUP BY Street , City , State , Zip , Latitude , Longitude
HAVING COUNT(*) > 1;

-- Delete the duplicates that are found
-- Total records are 981
DELETE x FROM Location AS x
        INNER JOIN
    Location AS y 
WHERE
    x.Property_ID < y.Property_ID
    AND x.Street = y.Street
    AND x.Latitude = y.Latitude
    AND x.Longitude = y.Longitude;

SELECT 
    COUNT(*)
FROM
    Location;

-- Creating a table called Sales to store all information related to it
-- Left Join is being used here to consider all the sales related information regardless how many times an each property has been sold
CREATE TABLE Sales AS SELECT s.Sale_ID, l.Property_ID, s.Sale_Date, AVG(s.Price) AS Price FROM
    sacramento.master AS s
        LEFT JOIN
    Location l ON s.Street = l.Street
GROUP BY s.Street , s.Sale_Date;

-- Delete duplicate records
DELETE m FROM sacramento.master AS m
        INNER JOIN
    sacramento.master n 
WHERE
    m.Sale_ID < n.Sale_ID
    AND m.Street = n.Street
    AND m.Zip = n.Zip;

-- Here we are setting the Primary Key
ALTER TABLE Sales
ADD PRIMARY KEY(Sale_ID);

-- Here we are setting the Foreign Key
ALTER TABLE Sales
ADD CONSTRAINT Property_ID FOREIGN KEY (Property_Id)
REFERENCES Location (Property_ID);

-- Creating a new Table called Prop Details and mentioned relevant information in this
-- INNER JOIN is used to only get the records which have a same column in both the tables
CREATE TABLE Prop_Details AS SELECT l.Property_ID, s.Beds, s.Baths, s.Sq_ft, s.Property_Type FROM
    sacramento.master AS s
        INNER JOIN
    Location AS l ON s.Street = l.Street;

-- Creating a new Table called Property Type and mentioned relevant information in this
CREATE TABLE Property_Type (
    Property_Type CHAR(3) PRIMARY KEY,
    Type_Desc VARCHAR(255)
);

INSERT INTO Property_Type(Property_Type, Type_Desc)
VALUES("RSD", "Residential"),
	("CND", "Condo"),
	("MTF", "Multi-Family"),
	("UNK", "Unknown");

SELECT 
    *
FROM
    Property_Type;

-- Updating the Information from "Residential" to "RSD"
-- Updating the Information from "Condo" to "CND"
-- Updating the Information from "Multi-Family" to "MTF"
-- Updating the Information from "Unknown/ Unkown" to "UNK"
UPDATE Prop_Details 
SET 
    Property_Type = 'RSD'
WHERE
    Property_Type = 'Residential';

UPDATE Prop_Details 
SET 
    Property_Type = 'CND'
WHERE
    Property_Type = 'Condo';

UPDATE Prop_Details 
SET 
    Property_Type = 'MTF'
WHERE
    Property_Type = 'Multi-Family';

UPDATE Prop_Details 
SET 
    Property_Type = 'UNK'
WHERE
    Property_Type = 'Unknown'
        OR Property_Type = 'Unkown';

-- Setting the Foreign Key
ALTER TABLE Prop_Details
ADD CONSTRAINT Prop_ID
FOREIGN KEY (Property_Id)
REFERENCES Location (Property_ID);

-- Creating a table called States which stores the information of State Abbreviation
CREATE TABLE States (
    State CHAR(3) PRIMARY KEY,
    State_Full VARCHAR(255)
);

-- Inserting the records 
INSERT INTO States VALUES ("CA", "California");

-- Setting the State as Foreign Key in the Location Table
ALTER TABLE Location
ADD CONSTRAINT State
	FOREIGN KEY (State)
	REFERENCES States (State);

SELECT 
    *
FROM
    States;

-- Let's find out the average price and average square feet of the properties in each of the zip codes?
-- Round off to 2 Decimals
-- RIGHT JOIN is used to only join the sales which have property location details
-- INNER JOIN is used to retrieve only the intersecting parts
-- In the results, we can observe the cheapest average prices by zipcode
SELECT 
    l.Zip,
    ROUND(AVG(s.Price), 2) AS Avg_Price,
    ROUND(AVG(Sq_ft), 2) AS Avg_Area
FROM
    Sales AS s
        RIGHT JOIN
    Location AS l ON l.Property_ID = s.Property_ID
        INNER JOIN
    Prop_Details AS d ON l.Property_ID = d.Property_ID
GROUP BY l.Zip
ORDER BY Avg_Price;

-- Let's find out the average price of the properties which have 3 bedrooms and more than 1 Bathrroms by each city and property type?
-- Round off to 2 Decimals
-- RIGHT JOIN is used to only join the sales which have property location details
-- INNER JOIN is used to retrieve only the intersecting parts
-- Look for Average Area in Square feet is more than 1800
SELECT 
    d.Property_Type,
    l.City,
    ROUND(AVG(s.Price), 2) AS Avg_Price,
    ROUND(AVG(d.Sq_ft), 2) AS Avg_Area_In_Sq_Ft
FROM
    Sales AS s
        RIGHT JOIN
    Location AS l ON l.Property_ID = s.Property_ID
        INNER JOIN
    Prop_Details AS d ON l.Property_ID = d.Property_ID
WHERE
    d.Baths > 1 AND d.Beds = 3
GROUP BY l.City , d.Property_Type
HAVING Avg_Area_In_Sq_Ft > 1800
ORDER BY l.City;

-- Let's find out the minimum price of  a Condo over 1100 square feet in SACRAMENTO and ROSEVILLE?
-- Round off to 2 Decimals
-- LEFT JOIN is used to only join the all attributes in the sales
-- RIGHT JOIN is used to retrieve only the properties with details
-- ILook for only Sacramento and Roseville cities which have more than 1100 Square feet
-- Ordered by the price and displays the cheapestfirst
SELECT 
    d.Property_ID,
    l.City,
    ROUND(MIN(s.Price), 2) AS Min_Price,
    d.Beds,
    d.Baths,
    d.Sq_ft
FROM
    Sales AS s
        LEFT JOIN
    Location AS l ON l.Property_ID = s.Property_ID
        RIGHT JOIN
    Prop_Details AS d ON l.Property_ID = d.Property_ID
WHERE
    l.City IN ('SACRAMENTO' , 'ROSEVILLE')
        AND d.Sq_ft > 1100
        AND d.Property_Type = 'CND'
GROUP BY l.City
ORDER BY Min_Price;

-- As our master table is divided into 5 tables. We do not require this table anymore and this causes data redundancy as this exists
DROP TABLE IF EXISTS sacramento.master;