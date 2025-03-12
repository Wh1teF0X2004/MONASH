/*
Databases Week 11 Tutorial Class
week11_sql_advanced.sql

Student ID: 33085625
Student Name: Foo Kai Yan
Last modified date: 15052023

*/
--1
SELECT unitcode, unitname, TO_CHAR(ofyear, 'yyyy') AS year, ofsemester, enrolmark, 
CASE UPPER(enrolgrade)
WHEN 'N' then 'Fail'
WHEN 'P' then 'Pass'
WHEN 'C' then 'Credit'
WHEN 'D' then 'Distinction'
WHEN 'HD' then 'High Distinction'
END AS explained_grade
FROM uni.unit NATURAL JOIN uni.enrolment NATURAL JOIN uni.student
WHERE UPPER(stufname) = 'CLAUDETTE' AND UPPER(stulname) = 'SERMAN'
ORDER BY year, ofsemester, unitcode;

--2
SELECT staffid, stafffname || ' ' || stafflname AS staffname, ofyear,
CASE
WHEN COUNT(*) = 2 THEN 'Correct Load'
WHEN COUNT(*) > 2 THEN 'Overload'
WHEN COUNT(*) < 2 THEN 'Underload'
END AS load
FROM uni.staff NATURAL JOIN uni.schedclass
WHERE TO_CHAR(ofyear, 'yyyy') = 2019
GROUP BY staffid, stafffname || ' ' || stafflname, ofyear
ORDER BY COUNT(*) DESC, staffid, ofyear;

--3


--4
/* Using outer join */
SELECT unitcode, COUNT(prerequnitcode) 
FROM uni.unit NATURAL LEFT JOIN uni.prereq
GROUP BY unitcode HAVING COUNT(prerequnitcode) = 0
ORDER BY unitcode;

SELECT unitcode, unitname 
FROM uni.unit NATURAL LEFT JOIN uni.prereq 
GROUP BY unitcode, unitname HAVING COUNT(prerequnitcode) = 0 
ORDER BY unitcode;

/* Using set operator MINUS */
-- More than 1 row returned must use IN but if it's only 1 row, can use equal (=)
-- MINUS can only be used if both have the name number of columns
-- eg. unitcode & unitcode, cannot unitcode, unitname & unitcode
SELECT unitcode, unitname FROM uni.unit WHERE unitcode IN 
(
SELECT unitcode FROM uni.unit
MINUS
SELECT unitcode FROM uni.prereq
);

/* Using subquery */
SELECT unitcode, unitname
FROM uni.unit 
WHERE unitcode NOT IN (SELECT unitcode FROM uni.prereq);

--5



--6



--7



--8
SELECT staffid, stafffname || ' ' || stafflname AS staffname, 'Lecture' AS cltype, 
COUNT(unitcode) AS no_of_classes, SUM(clduration) AS total_hours, 
LPAD(TO_CHAR((SUM(clduration)*75.60), '$900.00'), 15, ' ') AS weekly_payment
FROM uni.staff NATURAL JOIN uni.schedclass
WHERE UPPER(cltype) = 'L' AND ofsemester = 1 AND TO_CHAR(ofyear, 'yyyy') = 2020
GROUP BY staffid, stafffname || ' ' || stafflname
UNION
SELECT staffid, stafffname || ' ' || stafflname AS staffname, 'Tutorial' AS cltype, 
COUNT(unitcode) AS no_of_classes, SUM(clduration) AS total_hours, 
LPAD(TO_CHAR((SUM(clduration)*42.85), '$900.00'), 15, ' ') AS weekly_payment
FROM uni.staff NATURAL JOIN uni.schedclass
WHERE UPPER(cltype) = 'L' AND ofsemester = 1 AND TO_CHAR(ofyear, 'yyyy') = 2020
GROUP BY staffid, stafffname || ' ' || stafflname
ORDER BY staffid, cltype;

--9


    
--10







