/*
Databases Week 10 Tutorial Class
week10_sql_intermediate.sql

student id: 33085625
student name: Foo Kai Yan
last modified date: 08052023

*/

--1
SELECT to_char(MAX(enrolmark), '990.00') AS "max_mark" FROM uni.enrolment 
WHERE UPPER(unitcode) = 'FIT9136' AND ofsemester = 2 AND to_char(ofyear, 'yyyy') = 2019;

--2
SELECT to_char(AVG(enrolmark), '990.00') AS "avg_mark" FROM uni.enrolment 
WHERE UPPER(unitcode) = 'FIT2094' AND ofsemester = 2 AND to_char(ofyear, 'yyyy') = 2020;

--3
SELECT to_char(ofyear, 'yyyy') AS year, ofsemester, to_char(AVG(enrolmark), '990.00') AS "avg mark"
FROM uni.enrolment WHERE UPPER(unitcode) = 'FIT9136' 
group by to_char(ofyear, 'yyyy'), ofsemester
ORDER BY year, ofsemester;

--4
-- a. 
SELECT COUNT(*) AS "num_stud"
FROM uni.enrolment
WHERE UPPER(unitcode) = 'FIT1045' AND to_char(ofyear, 'yyyy') = 2019;

-- b. Repeat students are only counted once across 2019
SELECT COUNT(DISTINCT stuid) AS "num_students"
FROM uni.enrolment
WHERE UPPER(unitcode) = 'FIT1045' AND to_char(ofyear, 'yyyy') = 2019;

--5
SELECT COUNT(DISTINCT prerequnitcode) AS "total prerequisites"
FROM uni.prereq
WHERE UPPER(unitcode) = 'FIT5145';

--6
SELECT unitcode, ofsemester, COUNT(*) AS "total enrolment"
FROM uni.enrolment
WHERE to_char(ofyear, 'yyyy') = 2019
GROUP BY unitcode, ofsemester
ORDER BY unitcode, ofsemester;

--7
SELECT unitcode, COUNT(prerequnitcode) as "total number of prerequisite" 
FROM uni.prereq GROUP BY unitcode ORDER BY unitcode;

--8
SELECT unitcode, COUNT(*) AS "total WH students"
FROM uni.enrolment
WHERE ofsemester = 2 AND to_char(ofyear, 'yyyy') = 2020 AND UPPER(enrolgrade) = 'WH'
GROUP BY unitcode
ORDER BY unitcode DESC;

--9
SELECT prerequnitcode, unitname, COUNT(prerequnitcode) AS "total times used"
FROM uni.prereq p JOIN uni.unit u ON prerequnitcode = u.unitcode
GROUP BY prerequnitcode, unitname
ORDER BY prerequnitcode;

--10 
/* Ajoint statement */
/*
SELECT unitcode, unitname FROM uni.unit NATURAL JOIN uni.enrolment WHERE UPPER(enrolgrade) = 'DEF';
SELECT unitcode, unitname FROM uni.unit NATURAL JOIN uni.enrolment USING(unitcode) WHERE UPPER(enrolgrade) = 'DEF';
SELECT unitcode, unitname FROM uni.unit NATURAL JOIN uni.enrolment ON uni.unit.unitcode = uni.enrolment.unitcode WHERE UPPER(enrolgrade) = 'DEF';
*/
SELECT unitcode, unitname 
FROM uni.unit NATURAL JOIN uni.enrolment 
WHERE UPPER(enrolgrade) = 'DEF' 
AND ofsemester = 2 
AND to_char(ofyear, 'yyyy') = 2021
GROUP BY unitcode, unitname HAVING COUNT(stuid) >= 2 ORDER BY unitcode;

--11
/* CONCATINATION */
SELECT stuid,
stufname || ' ' || stulname as fullname,
to_char(studob, 'dd-Mon-yyyy') as "date of birth"
FROM uni.student 
WHERE studob = (select MIN(studob) FROM uni.student NATURAL JOIN uni.enrolment WHERE UPPER(unitcode) = 'FIT9132')
ORDER BY stuid;

--12
SELECT unitcode, ofsemester, COUNT(stuid) as "no of stud" 
FROM uni.enrolment 
WHERE to_char(ofyear, 'yyyy') = 2019 
GROUP BY unitcode, ofsemester HAVING COUNT(stuid) = 
(
SELECT MAX(COUNT(stuid)) FROM uni.enrolment
WHERE to_char(ofyear, 'yyyy') = 2019
GROUP BY unitcode, ofsemester
)
ORDER BY ofsemester, unitcode;

--13
SELECT stufname || ' ' || stulname as fullname, enrolmark
FROM uni.enrolment NATURAL JOIN uni.student
WHERE UPPER(unitcode) = 'FIT3157'
AND ofsemester = 1
AND to_char(ofyear, 'yyyy') = 2020 
AND enrolmark > 
(
SELECT AVG(enrolmark)
FROM uni.enrolment
WHERE UPPER(unitcode) = 'FIT3157'
AND ofsemester = 1
AND to_char(ofyear, 'yyyy') = 2020
)
ORDER BY enrolmark DESC, fullname






