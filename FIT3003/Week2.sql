-- Lab02a: Student Enrolment
-- Drop the table
DROP TABLE SUBJECT2;

CREATE TABLE SUBJECT2 (
    UCode CHAR(5) NOT NULL,
    UTitle VARCHAR2(20) NOT NULL,
    UCredit NUMBER(2),
    PRIMARY KEY (Ucode)
);

-- Insert one by one
--INSERT INTO SUBJECT2 VALUES ('IT001', 'Database', 5);
--INSERT INTO SUBJECT2 VALUES ('IT002', 'Java', 5);
--INSERT INTO SUBJECT2 VALUES ('IT003', 'SAP', 10);
--INSERT INTO SUBJECT2 VALUES ('IT004', 'Network', 5);
--INSERT INTO SUBJECT2 VALUES ('IT005', 'ASP.NET', 5);

-- Insert all oneshot
INSERT ALL
INTO SUBJECT2 VALUES ('IT001', 'Database', 5)
INTO SUBJECT2 VALUES ('IT002', 'Java', 5)
INTO SUBJECT2 VALUES ('IT003', 'SAP', 10)
INTO SUBJECT2 VALUES ('IT004', 'Network', 5)
INTO SUBJECT2 VALUES ('IT005', 'ASP.NET', 5)
SELECT * FROM DUAL; 
-- dual is the name of the system table
-- should be used together when you use insert all

-- View the insert
SELECT * FROM SUBJECT2;

-- Drop the table
DROP TABLE STUDENT2;

-- Create the table
CREATE TABLE STUDENT2
AS SELECT * FROM dtaniar.STUDENT2;

DESCRIBE STUDENT2;

SELECT * FROM STUDENT2;

-- Question(e)
INSERT INTO STUDENT2 VALUES ('10008', 'Miller', 'Larry', 'M', TO_DATE('22-07-1973', 'DD-MM-YYYY'), 211);
INSERT INTO STUDENT2 VALUES ('10009', 'Smith', 'Leonard', 'M', TO_DATE('26-05-1985', 'DD-MM-YYYY'), 211);
INSERT INTO STUDENT2 VALUES ('10010', 'Brown', 'Menson', 'M', TO_DATE('12-07-1983', 'DD-MM-YYYY'), 112);

-- Question(f)
-- Drop the tables
DROP TABLE OFFERING2;
DROP TABLE ENROLLMENT2;

CREATE TABLE OFFERING2
AS SELECT * FROM dtaniar.OFFERING2;

CREATE TABLE ENROLLMENT2
AS SELECT * FROM dtaniar.ENROLLMENT2;

-- Question(g) 1
SELECT COUNT(st.sid) AS Number_of_student
FROM Student2 st, Offering2 o, Enrollment2 e, Subject2 s
WHERE st.SID = e.SID
AND e.OID = o.OID
AND s.Ucode = o.Ucode
AND o.Ocampus = 'Main'
AND s.Utitle = 'Database';
-- Answer:
SELECT COUNT(SID) AS Number_of_student
FROM ENROLLMENT2 e, SUBJECT2 s, OFFERING2 o
WHERE s.Utitle LIKE '%Database%'
AND o.Ocampus LIKE '%Main%'
AND e.OID = o.OID
AND o.Ucode = s.Ucode;

-- Question(g) 2
SELECT SUM(e.score) as Total_score
FROM Offering2 o, Enrollment2 e, Subject2 s
WHERE e.OID = o.OID
AND s.Ucode = o.Ucode
AND o.Ocampus = 'Main'
AND s.Utitle = 'Database';
-- Answer:
SELECT SUM(e.score) AS Number_of_student
FROM ENROLLMENT2 e, SUBJECT2 s, OFFERING2 o
WHERE s.Utitle LIKE '%Database%'
AND o.Ocampus LIKE '%Main%'
AND e.OID = o.OID
AND o.Ucode = s.Ucode;

-- Question(g) 3
SELECT COUNT(*) AS Number_of_student
FROM Offering2 o, Enrollment2 e, Subject2 s
WHERE e.OID = o.OID
AND s.Ucode = o.Ucode
AND s.Utitle = 'Java'
AND o.Osem = 2
AND o.Oyear = 2009;
-- Answer:
SELECT COUNT(e.SID) AS Number_of_student
FROM ENROLLMENT2 e, SUBJECT2 s, OFFERING2 o
WHERE s.Utitle LIKE '%Java%'
AND o.Osem = 2
AND o.Oyear = 2009
AND e.OID = o.OID
AND o.Ucode = s.Ucode;

-- Question(g) 4
SELECT SUM(e.score) as Total_score
FROM Offering2 o, Enrollment2 e, Subject2 s
where e.OID = o.OID
AND s.Ucode = o.Ucode
AND s.Utitle = 'Java'
AND o.Osem = 2
AND o.Oyear = 2009;

-- Question(g) 5
SELECT COUNT(E.SID) AS Number_of_Students
FROM ENROLLMENT2 e, SUBJECT2 s, OFFERING2 o
WHERE s.Utitle LIKE '%SAP%'
AND o.OSem = 1
AND o.Oyear = 2009
AND e.Grade = 'HD'
AND e.OID = o.OID
AND o.UCode = s.Ucode;


-- Star Schema Creation
-- Dimension Creation
-- CampusDimension
CREATE TABLE CAMPUS_DIMENSION AS 
SELECT DISTINCT Ocampus
FROM OFFERING2;
SELECT * FROM CAMPUS_DIMENSION;
-- SemYearDimension
CREATE TABLE SEMYEAR_DIMENION AS 
SELECT DISTINCT Oyear || Osem as sem_id, Oyear, Osem
FROM OFFERING2;
SELECT * FROM SEMYEAR_DIMENION;
-- SubjectDimension
CREATE TABLE SUBJECT_DIMENION AS 
SELECT * FROM SUBJECT2;
SELECT * FROM SUBJECT_DIMENION;
-- GradeDimension
CREATE TABLE GRADE_DIMENION AS 
SELECT DISTINCT Grade FROM ENROLLMENT2;
SELECT * FROM GRADE_DIMENION;

-- Fact Table Creation
CREATE TABLE student_enrollment_fact AS
SELECT o.Ocampus, o.Oyear||o.Osem as sem_id, s.Ucode, e.Grade, COUNT(st.sid) AS num_of_student, SUM(e.score) AS Total_score
FROM subject2 s, enrollment2 e, offering2 o, student2 st
WHERE e.OID = o.OID
AND s.Ucode = o.Ucode
AND st.SID = e.SID
GROUP BY o.Ocampus, o.Oyear||o.Osem, s.Ucode, e.Grade;
-- Answer:
CREATE TABLE STUDENTENROLMENT_FACT AS
SELECT O.Ucode, O.Ocampus, E.Grade, O.Oyear || O.Osem AS SEM_ID, COUNT(E.SID) AS NUMBER_OF_STUDENT, SUM(E.Score) AS TOTAL_SCORE
FROM ENROLLMENT2 E, OFFERING2 O
WHERE E.OID = O.OID
GROUP BY O.Ucode, O.Ocampus, E.Grade, O.Oyear || O.Osem;
SELECT * FROM STUDENTENROLMENT_FACT;
-- Why after GROUP BY has lesser role? Duplicated dimensions are summed up into the same row

-- Question(k)
SELECT s.utitle, SUM(f.TOTAL_SCORE)/SUM(f.NUMBER_OF_STUDENT) AS Avg_score
FROM STUDENTENROLMENT_FACT f, SUBJECT_DIMENION s, SEMYEAR_DIMENION y
WHERE f.ucode = s.ucode
AND f.sem_id = y.sem_id
AND y.oyear = 2009
GROUP BY s.utitle;
-- Answer:
SELECT s.utitle, SUM(f.TOTAL_SCORE)/SUM(f.NUMBER_OF_STUDENT) AS AVERAGE_SCORE
FROM STUDENTENROLMENT_FACT f, SUBJECT_DIMENION s
WHERE f.ucode = s.ucode
AND f.sem_id LIKE '2009%'
GROUP BY s.utitle;

-- Question(l)
SELECT s.utitle, ROUND(SUM(f.TOTAL_SCORE)/SUM(f.NUMBER_OF_STUDENT), 2) AS AVERAGE_SCORE
FROM STUDENTENROLMENT_FACT f, SUBJECT_DIMENION s
WHERE f.ucode = s.ucode
AND f.sem_id LIKE '2009%'
AND UPPER(f.Ocampus) = UPPER('Main')
GROUP BY s.utitle;

-- Question(m)
SELECT s.utitle, ROUND(SUM(f.TOTAL_SCORE)/SUM(f.NUMBER_OF_STUDENT), 2) AS AVERAGE_SCORE
FROM STUDENTENROLMENT_FACT f, SUBJECT_DIMENION s
WHERE f.ucode = s.ucode
AND s.utitle = 'Database'
AND f.grade = 'N'
GROUP BY s.utitle;