-- Creating a Schema called sacramento
CREATE SCHEMA hosp;

-- Using sacramento as our current database
USE hosp;

-- Creating a new Table called icu_hosp and mentioned relevant information in this
-- INNER JOIN is used to only get the records which have a same column in both the tables
-- Used Where Clause to get only ICU realted bed description records
CREATE TABLE icu_hosp SELECT a.ims_org_id,
    a.license_beds AS licence_bed_icu,
    a.census_beds AS census_bed_icu,
    a.staffed_beds AS staffed_bed_icu,
    b.bed_desc,
    a.bed_id FROM
    hosp.bed_fact a
        INNER JOIN
    hosp.bed_type b ON a.bed_id = b.bed_id
WHERE
    b.bed_desc = 'ICU';

-- Creating a new Table called sicu_hosp and mentioned relevant information in this
-- INNER JOIN is used to only get the records which have a same column in both the tables
-- Used Where Clause to get only SICU realted bed description records
CREATE TABLE sicu_hosp SELECT a.ims_org_id,
    a.license_beds AS licence_bed_sicu,
    a.census_beds AS census_bed_sicu,
    a.staffed_beds AS staffed_bed_sicu,
    b.bed_desc,
    a.bed_id FROM
    hosp.bed_fact a
        INNER JOIN
    hosp.bed_type b ON a.bed_id = b.bed_id
WHERE
    b.bed_desc = 'SICU';

-- Creating a new Table called icu_sicu_hosps and mentioned relevant information in this
-- INNER JOIN is used to only get the records which have a same column in both the tables
CREATE TABLE icu_sicu_hosps AS SELECT a.ims_org_id,
    a.licence_bed_icu + b.licence_bed_sicu AS license_bed_icu_sicu,
    a.census_bed_icu + b.census_bed_sicu AS census_bed_icu_sicu,
    a.staffed_bed_icu + b.staffed_bed_sicu AS staffed_bed_icu_sicu FROM
    icu_hosp a
        INNER JOIN
    sicu_hosp b ON a.ims_org_id = b.ims_org_id;
 
-- INNER JOIN is used to only get the records which have a same column in both the tables
-- Used Order By License Beds in both ICU and SICU in a descending order
-- Limited to 10 Records
SELECT 
    b.business_name AS hospital_name, a.license_bed_icu_sicu
FROM
    hosp.icu_sicu_hosps AS a
        INNER JOIN
    hosp.business AS b ON a.ims_org_id = b.ims_org_id
ORDER BY license_bed_icu_sicu DESC
LIMIT 10;

-- INNER JOIN is used to only get the records which have a same column in both the tables
-- Used Order By Census Beds in both ICU and SICU in a descending order
-- Limited to 10 Records
SELECT 
    b.business_name AS hospital_name, a.census_bed_icu_sicu
FROM
    hosp.icu_sicu_hosps AS a
        INNER JOIN
    hosp.business AS b ON a.ims_org_id = b.ims_org_id
ORDER BY census_bed_icu_sicu DESC
LIMIT 10;

-- INNER JOIN is used to only get the records which have a same column in both the tables
-- Used Order By Staffed Beds in both ICU and SICU in a descending order
-- Limited to 10 Records
SELECT 
    b.business_name AS hospital_name, a.staffed_bed_icu_sicu
FROM
    hosp.icu_sicu_hosps AS a
        INNER JOIN
    hosp.business AS b ON a.ims_org_id = b.ims_org_id
ORDER BY staffed_bed_icu_sicu DESC
LIMIT 10;

-- INNER JOIN is used to only get the records which have a same column in both the tables
-- Joined all the tables to display the layout output
-- Used Order By Total Beds in both ICU and SICU in a descending order
-- Limited to 10 Records
SELECT 
    d.ims_org_id,
    d.business_name AS hospital_name,
    c.staffed_bed_icu,
    e.staffed_bed_sicu,
    c.licence_bed_icu,
    e.licence_bed_sicu,
    c.census_bed_icu,
    e.census_bed_sicu,
    c.staffed_bed_icu + e.staffed_bed_sicu + c.licence_bed_icu + e.licence_bed_sicu + c.census_bed_icu + e.census_bed_sicu AS total_beds
FROM
    hosp.icu_hosp AS c
        INNER JOIN
    hosp.business AS d ON c.ims_org_id = d.ims_org_id
        INNER JOIN
    hosp.sicu_hosp AS e ON e.ims_org_id = c.ims_org_id
ORDER BY total_beds DESC
LIMIT 10;