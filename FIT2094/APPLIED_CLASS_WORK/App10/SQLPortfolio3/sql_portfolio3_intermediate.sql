--Comment out SET ECHO and SPOOL commands before submitting your portfolio
--SET ECHO ON
--SPOOL sql_portfolio3_intermediate_output.txt

--****PLEASE ENTER YOUR DETAILS BELOW****
--sql_portfolio3_intermediate.sql

--Student ID: 33085625
--Student Name: Foo Kai Yan
--Unit Code: FIT2094
--Applied Class No: Tutorial #1 (Monday) 11:00 - 13:00


/*1*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT tenant_no, tenant_title || '. ' || tenant_givname || ' ' || tenant_famname AS tenantname, 
COUNT(dam_no), TO_CHAR(SUM(dam_cost), '$9990.99')
FROM rent.rent NATURAL JOIN rent.tenant NATURAL JOIN rent.damage 
WHERE TO_CHAR(dam_datetime, 'yyyy') = 2022
GROUP BY tenant_no, tenant_title || '. ' || tenant_givname || ' ' || tenant_famname
ORDER BY TO_CHAR(SUM(dam_cost), '$9990.99') DESC, tenant_no;

/*2*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT tenant_no, tenant_title || '. ' || tenant_givname || ' ' || tenant_famname AS tenantname, 
prop_no, prop_address, COUNT(rent_agreement_no)
FROM rent.rent NATURAL JOIN rent.tenant NATURAL JOIN rent.property
WHERE UPPER(prop_address) LIKE UPPER('%Tasmania%')
GROUP BY tenant_no, tenant_title || '. ' || tenant_givname || ' ' || tenant_famname, prop_no, prop_address HAVING COUNT(rent_agreement_no) > 1
ORDER BY tenant_no;

--Comment out SET ECHO and SPOOL commands before submitting your portfolio
--SPOOL OFF
--SET ECHO OFF