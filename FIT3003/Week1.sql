SELECT * FROM TAB;

CREATE TABLE LECTURER
    (StaffNO NUMBER(6) NOT NULL,
    Title VARCHAR2(3),
    FName VARCHAR2(30),
    LName VARCHAR2(30),
    StreetAddress VARCHAR2(70),
    Suburb VARCHAR2(40),
    City VARCHAR2(40),
    PostCode VARCHAR2(4),
    Country VARCHAR2(30),
    LecturerLevel CHAR(2),
    BankNO CHAR(20),
    BankName VARCHAR2(40),
    Salary NUMBER(8,2),
    WorkLoad NUMBER(2,1) NOT NULL,
    ResearchArea VARCHAR2(40),
    PRIMARY KEY(StaffNo));

SELECT * FROM TAB;

INSERT INTO LECTURER (StaffNO, Title, FName, LName, StreetAddress, Suburb,City, PostCode, Country, LecturerLevel, BankNO, BankName, Salary, WorkLoad, ResearchArea)
VALUES (1000,'Dr','David','Taniar','3 Robinson Av', 'Kew', 'Melbourne', '3080', 'Australia', '5', '1000567237', 'CommBank', 89000.00, 2.0, 'O-R DB');

INSERT INTO LECTURER (StaffNO, Title, FName, LName, StreetAddress, Suburb,City, PostCode, Country, LecturerLevel, BankNO, BankName, Salary, WorkLoad, ResearchArea)
VALUES (2000,'Dr','David','Taniar','3 Robinson Av', 'Kew', 'Melbourne', '3080', 'Australia', '5', '1000567237', 'CommBank', 89000.00, 2.0, 'O-R DB');

INSERT INTO LECTURER VALUES (3000, 'Mr', 'Daniel', 'Wright', '22 Crystal Cres', 'Alphington', 'Melbourne', '3790', 'Australia', '5', '1000654321', 'CommBank', 89000.00, 2.0, 'DB');
INSERT INTO LECTURER (StaffNO, Title, FName, LName, StreetAddress, Suburb, PostCode, Country, ResearchArea, Workload)
VALUES (4000, 'Mr', 'RaiHong', 'Lam', '12 Oracle Dr', 'Fitzroy', '3424', 'Australia', 'Data Mining', 1);

SELECT * FROM LECTURER;

-- Demolish the whole table
drop table STUDENT;

-- Remove records from within the table
DELETE FROM STUDENT;

CREATE TABLE STUDENT
    (StudentNO			NUMBER(6)	NOT NULL, 
    DOB				DATE, 
    FName 			VARCHAR2(30),
    LName			VARCHAR2(30),
    -- city spelt CiTTy
    CiTTy			VARCHAR2(40),
    PostCode			VARCHAR2(4), 
    Country			VARCHAR2(30),
    FeePaid			NUMBER(8,2), 
    LastFeeDate		DATE,
    PRIMARY KEY(StudentNo));
 
INSERT INTO student VALUES (
    30001, 
    TO_DATE('12-MAR-2001 16:15', 'DD-MON-YYYY HH24:MI'), 
    'JRR', 
    'Tolkien', 
    'Petaling Jaya', 
    '4780', 
    'Mars', 
    30000,
    TO_DATE('12-MAR-2001 16:15', 'DD-MON-YYYY HH24:MI'));

ALTER TABLE STUDENT ADD 
    (StreetAddress		VARCHAR2(70), 
    Suburb				VARCHAR2(40));
 
DESC STUDENT; 

ALTER TABLE STUDENT
DROP(CiTTy);

ALTER TABLE STUDENT
    ADD (CITY	VARCHAR2(40));

UPDATE STUDENT
    SET StreetAddress = '12 New St'
    WHERE StudentNo = 30001;

COMMIT;

-- View the STUDENT table
SELECT * FROM STUDENT;

-- Exercise starts here
-- Create all the required tables
Create Table SUBJECT 
    As Select * 
    From dtaniar.SUBJECT;

Create Table LECTURE 
    As Select * 
    From dtaniar.LECTURE;

Create Table TUTOR 
    As Select * 
    From dtaniar.TUTOR;

Create Table LAB 
    As Select * 
    From dtaniar.LAB;

Create Table STUDENT_ENROLMENT 
    As Select * 
    From dtaniar.STUDENT_ENROLMENT;

Create Table LAB_SIGNUP 
    As Select * 
    From dtaniar.LAB_SIGNUP;

-- Question 17
SELECT 
    lr.staffNo,
    lr.fname,
    l.lectday,
    l.lecttime
FROM 
    lecturer lr
JOIN 
    lecture l ON lr.staffNo = l.staffNo;
-- Answer:
SELECT FName, LName, lectday, TO_CHAR(lecttime, 'HH24:MI')
FROM LECTURER
NATURAL JOIN LECTURE;

-- Question 18
SELECT FName, LName
FROM Lecturer
WHERE StaffNo NOT IN (
    SELECT StaffNo
    FROM Lecture
);

-- Question 19
SELECT *
FROM Subject
WHERE Semester = 1;

-- Question 20
SELECT FName, LName, DOB, FeePaid
FROM Student
WHERE DOB BETWEEN to_date('01-JAN-1991','DD-MON-YYYY')
AND to_date('31-DEC-1994','DD-MON-YYYY');
-- Answer:
SELECT FName, LName, DOB, FeePaid
FROM STUDENT
WHERE TO_CHAR(DOB, 'YYYY')
BETWEEN '1991' AND '1994';

-- Question 21
SELECT DISTINCT S.StudentNo, FName, LName
FROM Student S, Student_Enrolment SE
WHERE (SubjectCode = 'CSE21DB'
OR SubjectCode = 'CSE31DB'
OR SubjectCode = 'CSE41FDB')
AND S.StudentNo = SE.StudentNo;

-- Question 22
SELECT T.TutorNo, T.StudentNo, FName, LName
FROM Student S, Tutor T
WHERE S.StudentNo = T.StudentNo;

-- Question 23
SELECT StaffNo, FName, LName
FROM Lecturer
WHERE ResearchArea = 'Network Management';

-- Question 24
SELECT AVG(Salary) AS "Average Salary"
FROM Lecturer;

-- Question 25
SELECT MIN(Salary) AS "Min Salary", MAX(Salary) AS "Max Salary"
FROM Lecturer;

-- Question 26
SELECT SJ.Name as SubjectName, SJ.Semester, COUNT(TT.TutorNo)
FROM Subject SJ, Lab LB, Tutor TT
WHERE SJ.SubjectCode = LB.SubjectCode
AND TT.TutorNo = LB.TutorNo
GROUP BY SJ.Name, SJ.Semester;

-- Question 27
SELECT SJ.Name as SubjectName, LB.LabNo, ST.LName as Tutor, COUNT(LS.StudentNo) as NumberOfStudent
FROM Subject SJ, Lab LB, Lab_SignUp LS, Tutor TT, Student ST
WHERE SJ.SubjectCode = LB.SubjectCode
AND LB.LabNo = LS.LabNo
AND TT.TutorNo = LB.TutorNo
AND TT.StudentNo = ST.StudentNo
GROUP BY SJ.Name, LB.LabNo, ST.LName;

-- Question 28
SELECT SUM(TT.SalaryPerHour * LB.Duration) as "Database Labs Cost Per Week"
FROM Lab LB, Tutor TT, Subject SJ
WHERE LB.SubjectCode = SJ.SubjectCode
AND LB.TutorNo = TT.TutorNo
AND SJ.SubjectCode LIKE '%DB%';

COMMIT;