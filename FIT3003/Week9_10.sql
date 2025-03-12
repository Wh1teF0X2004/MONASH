--Topic: Multifact, OLAP
--Week 9: Level of Aggregation
--Week 10: OLAP

-- CUBE ROLLUP is encouraged to be used for Final Assignment Data Analytics Section

--Questions:
-- What is the total fuel used from Oct to Dec 1995 by commercial pilots and airplane model C-90A. Sort the results by the month. How many rows of records do you get?
-- Using cube, what is the total fuel used from Oct to Dec 1995 by commercial pilots and airplane model C-90A. Sort the results by the month. How many rows of records do you get?
-- Redo question C.2 using Grouping. Notes that �1� and �0� in the TIME, PILOT, and MODEL indicate that they are aggregate values and real values respectively.
-- As like question C.3 above, but instead of using �0� and �1�, it displays �All Periods�, �All Pilots� and �All Models� instead. (Hints: Use DECODE).
-- Following the results in question C.4, since there is only one aircraft model in the query results (e.g. C-90A), it seems that the �All Models� are redundant. Now, we want to remove them from the report, as there is no point displaying �All Models� when there is only one model (Hints: Use Partial CUBE).
-- Using rollup with decode, what is the total fuel used from Oct to Dec 1995 by commercial pilots and airplane model C-90A. Sort the results by the month. How many rows of records do you get?
-- Compare the results in C.2 and C.6. What is the difference?
-- Modify C.6 to use Partial Roll up (exclude �All Models� from the rollup).

--Tables that will be used:
SELECT * FROM DW.Model;
SELECT * FROM DW.Pilot;
SELECT * FROM DW.Time;
SELECT * FROM DW.Charter_FACT;

--Section A
--Question 1
SELECT F.Time_ID AS Period, F.Emp_Num As Pilot, F.Mod_Code AS Model, SUM(F.Tot_Fuel)
FROM DW.Charter_FACT F, DW.Pilot P
WHERE F.Emp_Num = P.Emp_Num
AND Time_ID LIKE '19951%'
AND Mod_Code = 'C-90A'
AND P.PIL_License = 'COM'
GROUP BY F.Time_ID, F.Emp_Num, F.Mod_Code
ORDER BY Time_ID;

--Question 2
SELECT F.Time_ID AS Period, F.Emp_Num As Pilot, F.Mod_Code AS Model, SUM(F.Tot_Fuel)
FROM DW.Charter_FACT F, DW.Pilot P
WHERE F.Emp_Num = P.Emp_Num
AND Time_ID LIKE '19951%'
AND Mod_Code = 'C-90A'
AND P.PIL_License = 'COM'
GROUP BY CUBE(F.Time_ID, F.Emp_Num, F.Mod_Code)
ORDER BY Time_ID;

--Question 3
SELECT F.Time_ID AS Period, F.Emp_Num As Pilot, F.Mod_Code AS Model, SUM(F.Tot_Fuel),
GROUPING (Time_ID) AS Period_Group,
GROUPING (F.Emp_Num) AS Pilot_Group,
GROUPING (Mod_Code) AS Model_Group
FROM DW.Charter_FACT F, DW.Pilot P
WHERE F.Emp_Num = P.Emp_Num
AND Time_ID LIKE '19951%'
AND Mod_Code = 'C-90A'
AND P.PIL_License = 'COM'
GROUP BY CUBE(F.Time_ID, F.Emp_Num, F.Mod_Code)
ORDER BY Time_ID;

--Question 4
SELECT DECODE(GROUPING (Time_ID), 1, 'All Periods', F.Time_ID) AS Period,
    DECODE(GROUPING (F.Emp_Num), 1, 'All Pilots', F.Emp_Num) AS Pilot,
    DECODE(GROUPING (Mod_Code), 1, 'All Models', F.Mod_Code) AS Model,
    SUM(F.Tot_Fuel)
FROM DW.Charter_FACT F, DW.Pilot P
WHERE F.Emp_Num = P.Emp_Num
AND Time_ID LIKE '19951%'
AND Mod_Code = 'C-90A'
AND P.PIL_License = 'COM'
GROUP BY CUBE(F.Time_ID, F.Emp_Num, F.Mod_Code)
ORDER BY Time_ID;
-- Decode take in 4 parameters: Grouping Param1, If Param1 is this, Then put this, Else put this

--Question 5
SELECT DECODE(GROUPING (Time_ID), 1, 'All Periods', F.Time_ID) AS Period,
    DECODE(GROUPING (F.Emp_Num), 1, 'All Pilots', F.Emp_Num) AS Pilot,
    DECODE(GROUPING (Mod_Code), 1, 'All Models', F.Mod_Code) AS Model,
    SUM(F.Tot_Fuel)
FROM DW.Charter_FACT F, DW.Pilot P
WHERE F.Emp_Num = P.Emp_Num
AND Time_ID LIKE '19951%'
AND Mod_Code = 'C-90A'
AND P.PIL_License = 'COM'
GROUP BY CUBE(F.Time_ID, F.Emp_Num), F.Mod_Code
ORDER BY Time_ID;

--Question 6
SELECT DECODE(GROUPING (Time_ID), 1, 'All Periods', F.Time_ID) AS Period,
    DECODE(GROUPING (F.Emp_Num), 1, 'All Pilots', F.Emp_Num) AS Pilot,
    DECODE(GROUPING (Mod_Code), 1, 'All Models', F.Mod_Code) AS Model,
    SUM(F.Tot_Fuel)
FROM DW.Charter_FACT F, DW.Pilot P
WHERE F.Emp_Num = P.Emp_Num
AND Time_ID LIKE '19951%'
AND Mod_Code = 'C-90A'
AND P.PIL_License = 'COM'
GROUP BY ROLLUP(F.Time_ID, F.Emp_Num, F.Mod_Code)
ORDER BY Time_ID;

--Question 7: Compare

--Question 8
SELECT DECODE(GROUPING (Time_ID), 1, 'All Periods', F.Time_ID) AS Period,
    DECODE(GROUPING (F.Emp_Num), 1, 'All Pilots', F.Emp_Num) AS Pilot,
    DECODE(GROUPING (Mod_Code), 1, 'All Models', F.Mod_Code) AS Model,
    SUM(F.Tot_Fuel)
FROM DW.Charter_FACT F, DW.Pilot P
WHERE F.Emp_Num = P.Emp_Num
AND Time_ID LIKE '19951%'
AND Mod_Code = 'C-90A'
AND P.PIL_License = 'COM'
GROUP BY ROLLUP(F.Time_ID, F.Emp_Num), F.Mod_Code
ORDER BY Time_ID;

--Section B
--Question 1
-- The rank function displays the rank of a record. Its usage is as follow. To find the rank of the records in the time table is as follow:
SELECT time_year, time_month,
    RANK() OVER (ORDER BY time_year, time_month) AS time_rank
FROM DW.Time;

--Question 2
-- Display the row number of total charter hours used by each aircraft model in year 1996 (Hints: Use ROW_NUMBER() Over) The results should look like as follows.
SELECT Mod_Code, Time_ID, SUM(Tot_Char_Hours),
    ROW_NUMBER() OVER (ORDER BY SUM(Tot_Char_Hours)) AS Row_Num
FROM DW.Charter_FACT
WHERE Time_ID LIKE '1996%'
GROUP BY Mod_Code, Time_ID;

--Question 3
-- Display the ranking of total charter hours used by each aircraft model in year 1996 (Hints: Use Dense_Rank() Over) The results should look like as follows.
SELECT Mod_Code, Time_ID, SUM(Tot_Char_Hours),
    DENSE_RANK() OVER (ORDER BY SUM(Tot_Char_Hours)) AS DenseRank
FROM DW.Charter_FACT
WHERE Time_ID LIKE '1996%'
GROUP BY Mod_Code, Time_ID;
-- No gap use dense rank

--Question 4
-- Display the ranking of total charter hours used by each aircraft model in year 1996 (Hints: Use Rank() Over) The results should look like as follows.
SELECT Mod_Code, Time_ID, SUM(Tot_Char_Hours),
    RANK() OVER (ORDER BY SUM(Tot_Char_Hours)) AS Rank
FROM DW.Charter_FACT
WHERE Time_ID LIKE '1996%'
GROUP BY Mod_Code, Time_ID;

--Question 5
-- Using the Percent_Rank() function (nested within a sub query), display the time periods which had revenue in the top 10% of the months.
-- You want to find which month is actually contributing to the top 10%
-- PERCENT_RANK() DECS means ASC where it starts from 0 and build up to 100 but we dont want that, we want top 10%
SELECT Time_ID, Total, PercentRank
FROM (
    SELECT Time_ID, SUM(Revenue) AS Total,
        ROUND(PERCENT_RANK() OVER (ORDER BY SUM(Revenue)), 2) AS PercentRank
    FROM DW.Charter_FACT
    GROUP BY Time_ID)
WHERE PercentRank >= 0.9
ORDER BY PercentRank DESC;

--Question 6: Cumulative & Moving Aggregation Questions
SELECT Time_ID, SUM(Revenue) AS Revenue, 
    TO_CHAR(SUM(SUM(Revenue)) OVER (ORDER BY Time_ID ROWS UNBOUNDED PRECEDING), '999,999,999.99') AS Cumulative_Revenue
FROM DW.Charter_FACT
WHERE Time_ID LIKE '1995%'
GROUP BY Time_ID;

--Question 7
SELECT Time_ID, SUM(Revenue) AS Revenue, 
    TO_CHAR(AVG(SUM(Revenue)) OVER (ORDER BY Time_ID ROWS 2 PRECEDING), '999,999,999.99') AS Moving_3_months_AVG
FROM DW.Charter_FACT
WHERE Time_ID LIKE '1995%'
GROUP BY Time_ID;

--Question 8
SELECT Time_Year, Mod_Code, SUM(Tot_Fuel) AS Total, 
    TO_CHAR(AVG(SUM(Tot_Fuel)) OVER (PARTITION BY Time_Year ORDER BY Time_Year ROWS UNBOUNDED PRECEDING), '999,999,999.99') AS CUM_FUEL_Year,
    TO_CHAR(AVG(SUM(Tot_Fuel)) OVER (PARTITION BY Mod_Code ORDER BY Mod_Code ROWS UNBOUNDED PRECEDING), '999,999,999.99') AS CUM_FUEL_Model
FROM DW.Charter_FACT, DW.Time
WHERE DW.Charter_FACT.Time_ID = DW.Time.Time_ID
GROUP BY Time_Year, Mod_Code
ORDER BY Time_Year;

-- 