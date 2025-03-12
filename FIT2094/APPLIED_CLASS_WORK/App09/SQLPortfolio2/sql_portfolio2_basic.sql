--Comment out SET ECHO and SPOOL commands before submitting your portfolio
--SET ECHO ON
--SPOOL sql_portfolio2_basic_output.txt

--****PLEASE ENTER YOUR DETAILS BELOW****
--sql_portfolio2_basic.sql

--Student ID: 33085625
--Student Name: Foo Kai Yan
--Unit Code: FIT2094
--Tutorial Class No: Tutorial #1 (Monday) 11:00 - 13:00

-- Retrive data from PROPERTY table under RENT user with:
-- select * from rent.property

/*1*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer 
SELECT maint_cost, maint_id, TO_CHAR(maint_datetime, 'dd-Mon-yyyy') AS datetime, prop_address, owner_givname || ' ' || owner_famname AS ownername 
FROM rent.maintenance NATURAL JOIN rent.owner NATURAL JOIN rent.property
WHERE maint_cost BETWEEN 1000 AND 3000 AND UPPER(maint_assigned) = UPPER('Y')
ORDER BY maint_cost DESC, maint_datetime DESC;

/*2*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer 
SELECT rent_agreement_no, tenant_no, tenant_title || '. ' || tenant_givname || ' ' || tenant_famname AS tenantname, 
rent_weekly_rate, rent_lease_start, prop_address, owner_givname || ' ' || owner_famname AS ownername, 
rent_lease_period || ' months' AS rent_lease_period
FROM rent.rent NATURAL JOIN rent.tenant NATURAL JOIN rent.property NATURAL JOIN rent.owner 
WHERE rent_weekly_rate < 425 AND TO_CHAR(rent_lease_start, 'yyyy') = 2022 AND rent_lease_period >= 6
ORDER BY rent_lease_period DESC, tenant_no DESC;

--Comment out SET ECHO and SPOOL commands before submitting your portfolio
--SPOOL OFF
--SET ECHO OFF