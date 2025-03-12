-------------------------------------------PART A
--first create the dimensions
--create semester dimension
DROP TABLE semesterDIM;
CREATE TABLE semesterDIM
    (SemID VARCHAR2(10),
    Sem_Desc VARCHAR2(20),
    begin_date DATE,
    end_date DATE);

-- create time dimension (note do not use time as a
-- table name, it is a reserved keyword)
DROP TABLE labtimeDIM;
CREATE TABLE labtimeDIM
    (TimeID NUMBER,
    Time_Desc VARCHAR2(15),
    begin_time DATE,
    end_time DATE);

-- create major and class dimensions
DROP TABLE majorDIM;
CREATE TABLE majorDIM AS SELECT * FROM dw.major;
DROP TABLE classDIM;
CREATE TABLE classDIM AS SELECT * FROM dw.class;

-- populate semester dimension
-- (the begin and end date can be changed)
INSERT INTO semesterDIM VALUES ('S1', 'Semester1', TO_DATE('01-JAN', 'DD-MON'), TO_DATE('15-JUL', 'DD-MON'));
INSERT INTO semesterDIM VALUES ('S2', 'Semester2', TO_DATE('16-JUL', 'DD-MON'), TO_DATE('31-DEC', 'DD-MON'));

-- populate labtime dimension
--DROP TABLE labtimeDIM;
SELECT timeID, time_desc, TO_CHAR(begin_time, 'HH24:MI'), TO_CHAR(end_time, 'HH24:MI') FROM labtimeDIM;
INSERT INTO labtimeDIM VALUES (1, 'morning', TO_DATE('06:01', 'HH24:MI'), TO_DATE('12:00', 'HH24:MI'));
INSERT INTO labtimeDIM VALUES (2, 'afternoon', TO_DATE('12:01', 'HH24:MI'), TO_DATE('18:00', 'HH24:MI'));
INSERT INTO labtimeDIM VALUES (3, 'night', TO_DATE('18:01', 'HH24:MI'), TO_DATE('06:00', 'HH24:MI'));

-- secondly, create a temp table to extract from uselog table
DROP TABLE tempfact_uselog;
CREATE TABLE tempfact_uselog AS SELECT U.log_date , U.log_time, U.student_ID, S.class_id, S.major_code
FROM dw.uselog U, dw.student S WHERE U.student_id = S.student_id;

SELECT * FROM tempfact_uselog;

SELECT TO_CHAR(log_date, 'DD-MM-YYYY'), TO_CHAR(log_time, 'HH24:MI'), major_code, class_id, student_id FROM tempfact_uselog;

-- add a column in the tempfact table to store timeid
-- (cannot directly do this in the tempfact table because
-- log_time was of DATE type and timeid is of NUMBER type).
ALTER TABLE tempfact_uselog ADD (timeid number);

UPDATE tempfact_uselog SET timeid = 1
WHERE TO_CHAR(log_time, 'HH24:MI') >= '06:01'
AND TO_CHAR(log_time, 'HH24:MI') <='12:00';

UPDATE tempfact_uselog SET timeid = 2
WHERE TO_CHAR(log_time, 'HH24:MI') >= '12:01'
AND TO_CHAR(log_time, 'HH24:MI') <='18:00';

-- note that we use OR in the last update statement to
-- include the time between 18:01 and 06:00.
update tempfact_uselog
set timeid = 3
where TO_CHAR(log_time, 'HH24:MI') >= '18:01'
or TO_CHAR(log_time, 'HH24:MI') <='06:00';

-- alternatively, you may want to update timeid=3
-- for all other records where the time_id is still empty
-- update tempfact_uselog
-- set timeid = 3
-- where timeid is NULL;
-- add a column in the tempfact_uselog table to store semid
-- (cannot directly do this in the test table because
-- log_date was of DATE type and semid is of VARCHAR type.)
alter table tempfact_uselog
add (semid varchar2(10));

-- populate the new attribute semid by summarizing
-- the date(log_date)
update tempfact_uselog
set semid = 'S1'
where TO_CHAR(log_date, 'MMDD') >= '0101'
and TO_CHAR(log_date, 'MMDD') <= '0715';
update tempfact_uselog
set semid = 'S2'
where TO_CHAR(log_date, 'MMDD') >= '0716'
and TO_CHAR(log_date, 'MMDD') <= '1231';

-- Now, create the fact table,
-- make sure to include the TOTAL aggregate.
-- This is an aggregate table of the earlier tempfact table.
DROP TABLE fact_uselog CASCADE CONSTRAINTS PURGE;
create table fact_uselog as
select t.semid, t.timeid, t.class_id,
t.major_code, count(t.student_id) as total_usage
from tempfact_uselog t
group by t.semid, t.timeid, t.class_id, t.major_code;

-------------------------------------------PART B
-- How many rows in ‘dw.student’?
SELECT COUNT(*) FROM dw.student;

-- What does ‘dw.student’ look like?
SELECT * FROM dw.student;

-- How many rows in ‘dw.uselog’?
SELECT COUNT(*) FROM dw.uselog;

-- What does ‘dw.uselog’ look like?
SELECT * FROM dw.uselog;

-- How many rows in ‘dw.major’?
SELECT COUNT(*) FROM dw.major;

-- What does 'dw.major' look like?
SELECT * FROM dw.major;

-- How many rows in 'dw.class'?
SELECT COUNT(*) FROM dw.class;

-- What does 'dw.class' look like?
SELECT * FROM dw.class;

-- Compare the number of records between ‘tempfact_uselog’ and ‘fact_uselog’
SELECT COUNT(*) FROM tempfact_uselog; -- There is 170610
SELECT COUNT(*) FROM fact_uselog; -- There is 1363

-- Create tempfact_uselog joined between dw.uselog with dw.student
CREATE TABLE tempfact_uselog_new AS 
SELECT U.log_date , U.log_time, U.student_ID, S.class_id, S.major_code
FROM dw.uselog U, dw.student S WHERE U.student_id = S.student_id;
SELECT COUNT(*) FROM tempfact_uselog_new;

-- Question 10
-- Question 11

-- Question 12
-- content dw.uselog from operational database
SELECT log_date, TO_CHAR(log_time, 'HH24:MI') AS log_time, student_ID, act
FROM dw.uselog;
-- content from data warehousing
SELECT log_date, TO_CHAR(log_time, 'HH24:MI') AS log_time, student_ID
FROM tempfact_uselog;

SELECT COUNT (*)
FROM( SELECT STUDENT_ID, COUNT(*) AS count_of_student FROM dw.Student GROUP BY STUDENT_ID ) t
WHERE count_of_student >1;

-- Question 13
-- Question 14
-- Question 15

