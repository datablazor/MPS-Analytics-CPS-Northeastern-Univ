-- Creating a Schema called brfss
CREATE SCHEMA brfss;

-- Using brfss as our current database
USE brfss;

-- Select responses count from the brfss_ok-1 table
-- Used Where Clause to get only Age Groups between 18-24
SELECT 
    COUNT(response)
FROM
    `brfss_ok-1`
WHERE
    Break_Out = '18-24'
        AND Break_Out_Category = 'Age Group';

-- Select Break_Out, Break_Out_Category, Sample_Size, Data_value, ZipCode  from the brfss_ok-1 table
-- Used Where Clause to get only Age Groups between 18-24
SELECT 
    Break_Out,
    Break_Out_Category,
    Sample_Size,
    Data_value,
    ZipCode
FROM
    `brfss_ok-1`
WHERE
    Break_Out = '18-24'
        AND Break_Out_Category = 'Age Group';

-- Select Break_Out, Break_Out_Category, Sample_Size, Data_value, ZipCode, city  from the brfss_ok-1 table
-- INNER JOIN is used to only get the records which have a same column in both the tables
-- Used Where Clause to get only Age Groups between 18-24
-- Group By City
SELECT 
    b.Break_Out,
    b.Break_Out_Category,
    b.Sample_Size,
    b.Data_Value,
    d.ZipCode,
    d.City
FROM
    `brfss_ok-1` AS b
        INNER JOIN
    `demographics_ok-1` AS d ON b.ZipCode = d.ZipCode
WHERE
    Break_Out = '18-24'
        AND Break_Out_Category = 'Age Group'
GROUP BY d.City;

-- Select Break_Out, Break_Out_Category, Sample_Size, Data_value, ZipCode, city  from the brfss_ok-1 table
-- INNER JOIN is used to only get the records which have a same column in both the tables
-- Used Where Clause to get only Age Groups between 18-24
-- Group By County
SELECT 
    b.Break_Out,
    b.Break_Out_Category,
    b.Sample_Size,
    b.Data_Value,
    d.ZipCode,
    d.County
FROM
    `brfss_ok-1` AS b
        INNER JOIN
    `demographics_ok-1` AS d ON b.ZipCode = d.ZipCode
WHERE
    Break_Out = '18-24'
        AND Break_Out_Category = 'Age Group'
GROUP BY d.County;

-- Select county records from the demographics_ok-1 table
SELECT 
    county
FROM
    `demographics_ok-1`;

-- Select city records from the demographics_ok-1 table
SELECT 
    city
FROM
    `demographics_ok-1`;

-- Select Break_Out, Break_Out_Category, Sample_Size, Data_value, ZipCode, city  from the brfss_ok-1 table
-- Used Where Clause to get only Age Groups between 18-24 with Response as Yes
-- Group By City
SELECT 
    Break_Out,
    Break_Out_Category,
    Sample_Size,
    Data_value,
    ZipCode,
    Response
FROM
    `brfss_ok-1`
WHERE
    Break_Out = '18-24'
        AND Break_Out_Category = 'Age Group'
        AND Response = 'Yes';