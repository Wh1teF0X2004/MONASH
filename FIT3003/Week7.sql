--Lab-06-PTE.docx
SELECT * FROM TAB;
DROP TABLE CountryVenueDIM;
DROP TABLE CitizenshipDIM;
DROP TABLE YearDIM;
DROP TABLE GradeDIM;
DROP TABLE TestComponentDIM;
DROP TABLE PTETempFACT;
DROP TABLE OverallFACT;
DROP TABLE ReadingFACT;
DROP TABLE SpeakingFACT;
DROP TABLE WritingFACT;
DROP TABLE ListeningFACT;
DROP TABLE FinalFACT;

-- How many students received a competent grade in their overall score?
-- How many students took the test in 2017?
-- How many Korean citizen students took the test?
-- How many students took the test in Australia?
-- How many Chinese students received a Proficient Grade in the Listening part in 2017?

-- Write the SQL statements for the implementation of the star schema
CREATE TABLE CountryVenueDIM AS 
SELECT DISTINCT CountryCode, C.CountryName, T.TestPrice
FROM PTETEST.Test_Venue T NATURAL JOIN PTETEST.Country C;

CREATE TABLE CitizenshipDIM AS 
SELECT DISTINCT CountryCode AS Citizenship, CountryName
FROM PTETEST.Student NATURAL JOIN PTETEST.Country;

CREATE TABLE YearDIM AS
SELECT DISTINCT TO_CHAR(TestDate, 'YYYY') AS Year 
FROM PTETEST.Test;

CREATE TABLE GradeDIM (
    Grade       VARCHAR2(5),
    Description VARCHAR2(20),
    MinScore    NUMBER,
    MaxScore    NUMBER);
    
INSERT INTO GradeDIM VALUES('4.5', 'Functional', 30, 35);
INSERT INTO GradeDIM VALUES('5', 'Vocational', 36, 49);
INSERT INTO GradeDIM VALUES('6', 'Competent', 50, 64);
INSERT INTO GradeDIM VALUES('7', 'Proficient', 65, 78);
INSERT INTO GradeDIM VALUES('8-9', 'Superior', 78, 90);

CREATE TABLE TestComponentDIM(
    TestComponent VARCHAR2(20)
    );

INSERT INTO TestComponentDIM VALUES('Overall');
INSERT INTO TestComponentDIM VALUES('Listening');
INSERT INTO TestComponentDIM VALUES('Reading');
INSERT INTO TestComponentDIM VALUES('Writing');
INSERT INTO TestComponentDIM VALUES('Speaking');

-- Run the code below and you'll see repetitive RegistrationID
SELECT * FROM PTETEST.Test_Result ORDER BY RegistrationID;

-- Create Temporary FACT Table
CREATE TABLE PTETempFACT AS
SELECT TV.CountryCode, S.Citizenship, TO_CHAR(T.TestDate, 'YYYY') AS Year,
TR.ListeningScore, TR.ReadingScore, TR.SpeakingScore, TR.WritingScore, TR.OverallScore, TR.RegistrationID
FROM PTETEST.Test_Venue TV, PTETEST.Student S, PTETEST.Test T, PTETEST.Test_Result TR
WHERE T.TestNo = TR.TestNo
AND S.RegistrationID = TR.RegistrationID
AND T.VenueID = TV.VenueID;

SELECT * FROM PTETempFACT;

ALTER TABLE PTETempFACT
ADD ( GradeOverall VARCHAR2(5),
    GradeListening VARCHAR2(5),
    GradeReading VARCHAR2(5),
    GradeSpeaking VARCHAR2(5),
    GradeWriting VARCHAR2(5)
    );
    
UPDATE PTETempFACT SET GradeOverall = 
 (CASE WHEN OverallScore >= 30 AND OverallScore <= 35 THEN '4.5'  
 WHEN OverallScore >= 36 AND OverallScore <= 49 THEN '5'  
 WHEN OverallScore >= 50 AND OverallScore <= 64 THEN '6'  
 WHEN OverallScore >= 65 AND OverallScore <= 78 THEN '7'  
 WHEN OverallScore >= 79 AND OverallScore <= 90 THEN '8-9'  END); 
 
UPDATE PTETempFACT SET GradeListening = 
 (CASE WHEN ListeningScore >= 30 AND ListeningScore <= 35 THEN '4.5'  
 WHEN ListeningScore >= 36 AND ListeningScore <= 49 THEN '5'  
 WHEN ListeningScore >= 50 AND ListeningScore <= 64 THEN '6'  
 WHEN ListeningScore >= 65 AND ListeningScore <= 78 THEN '7'  
 WHEN ListeningScore >= 79 AND ListeningScore <= 90 THEN '8-9'  END); 

UPDATE PTETempFACT SET GradeReading = 
 (CASE WHEN ReadingScore >= 30 AND ReadingScore <= 35 THEN '4.5'  
 WHEN ReadingScore >= 36 AND ReadingScore <= 49 THEN '5'  
 WHEN ReadingScore >= 50 AND ReadingScore <= 64 THEN '6'  
 WHEN ReadingScore >= 65 AND ReadingScore <= 78 THEN '7'  
 WHEN ReadingScore >= 79 AND ReadingScore <= 90 THEN '8-9'  END); 
 
UPDATE PTETempFACT SET GradeSpeaking = 
 (CASE WHEN SpeakingScore >= 30 AND SpeakingScore <= 35 THEN '4.5'  
 WHEN SpeakingScore >= 36 AND SpeakingScore <= 49 THEN '5'  
 WHEN SpeakingScore >= 50 AND SpeakingScore <= 64 THEN '6'  
 WHEN SpeakingScore >= 65 AND SpeakingScore <= 78 THEN '7'  
 WHEN SpeakingScore >= 79 AND SpeakingScore <= 90 THEN '8-9'  END); 
 
UPDATE PTETempFACT SET GradeWriting = 
 (CASE WHEN WritingScore >= 30 AND WritingScore <= 35 THEN '4.5'  
 WHEN WritingScore >= 36 AND WritingScore <= 49 THEN '5'  
 WHEN WritingScore >= 50 AND WritingScore <= 64 THEN '6'  
 WHEN WritingScore >= 65 AND WritingScore <= 78 THEN '7'  
 WHEN WritingScore >= 79 AND WritingScore <= 90 THEN '8-9'  END); 

CREATE TABLE OverallFACT AS
SELECT CountryCode, Citizenship, Year, GradeOverall AS Grade, 
'Overall' TestComponent, 
COUNT(RegistrationID) AS Total_Students_Overall
FROM PTETempFACT
GROUP BY CountryCode, Citizenship, Year, GradeOverall, 'Overall';

CREATE TABLE ReadingFACT AS
SELECT CountryCode, Citizenship, Year, GradeReading AS Grade, 
'Reading' TestComponent, 
COUNT(RegistrationID) AS Total_Students_Overall
FROM PTETempFACT
GROUP BY CountryCode, Citizenship, Year, GradeReading, 'Reading';

CREATE TABLE SpeakingFACT AS
SELECT CountryCode, Citizenship, Year, GradeSpeaking AS Grade, 
'Speaking' TestComponent, 
COUNT(RegistrationID) AS Total_Students_Overall
FROM PTETempFACT
GROUP BY CountryCode, Citizenship, Year, GradeSpeaking, 'Speaking';

CREATE TABLE ListeningFACT AS
SELECT CountryCode, Citizenship, Year, GradeListening AS Grade, 
'Listening' TestComponent, 
COUNT(RegistrationID) AS Total_Students_Overall
FROM PTETempFACT
GROUP BY CountryCode, Citizenship, Year, GradeListening, 'Listening';

CREATE TABLE WritingFACT AS
SELECT CountryCode, Citizenship, Year, GradeWriting AS Grade, 
'Writing' TestComponent, 
COUNT(RegistrationID) AS Total_Students_Overall
FROM PTETempFACT
GROUP BY CountryCode, Citizenship, Year, GradeWriting, 'Writing';

CREATE TABLE FinalFACT AS
SELECT * FROM OverallFACT UNION 
SELECT * FROM ReadingFACT UNION
SELECT * FROM ListeningFACT UNION
SELECT * FROM SpeakingFACT UNION
SELECT * FROM WritingFACT;

SELECT * FROM FinalFACT;

ALTER TABLE FinalFACT 
RENAME COLUMN Total_Students_Overall to Total_Students;

-- How many students received a competent grade in their overall score?
SELECT F.Grade, G.Description, F.TestComponent, SUM(F.Total_Students) AS Number_of_Students
FROM GradeDIM G, FinalFACT F
WHERE G.Grade = F.Grade
AND TestComponent = 'Overall'
AND Description = 'Competent'
GROUP BY F.Grade, G.Description, F.TestComponent;

-- How many students took the test in 2017?
SELECT F.Year, F.TestComponent, SUM(F.Total_Students) AS Number_of_Students
FROM FinalFACT F
WHERE F.Year = 2017
GROUP BY F.Year, F.TestComponent;

-- How many Korean citizen students took the test?
SELECT C.CountryName, F.TestComponent, SUM(F.Total_Students) AS Number_of_Students
FROM FinalFACT F, CitizenshipDIM C
WHERE C.CountryName = 'Korea'
AND F.Citizenship = C.Citizenship
GROUP BY C.CountryName, F.TestComponent;

-- How many students took the test in Australia?
SELECT C.CountryName, F.TestComponent, SUM(F.Total_Students) AS Number_of_Students
FROM FinalFACT F, CountryVenueDIM C
WHERE C.CountryName = 'Australia'
AND F.CountryCode = C.CountryCode
GROUP BY C.CountryName, F.TestComponent;

-- How many Chinese students received a Proficient Grade in the Listening part in 2017?
SELECT F.Year, C.CountryName, F.Grade, G.Description, F.TestComponent, SUM(F.Total_Students) AS Number_of_Students
FROM GradeDIM G, CitizenshipDIM C, FinalFACT F
WHERE G.Grade = F.Grade
AND F.Citizenship = C.Citizenship
AND F.TestComponent = 'Listening'
AND Description = 'Proficient'
AND CountryName = 'China'
AND F.Year = 2017
GROUP BY F.Year, C.CountryName, F.Grade, G.Description, F.TestComponent;