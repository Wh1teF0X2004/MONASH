-- Lab 4 Bridge Table
-- Truck Delivery Case Study

-- Part 1 
-- create dimension tables 
Create Table Warehouse
(WarehouseID Varchar2(10) Not Null,
Location Varchar2(10) Not Null,
Primary Key (WarehouseID)
);
Create Table Truck
(TruckID Varchar2(10) Not Null,
VolCapacity Number(5,2),
WeightCategory Varchar2(10),
CostPerKm Number(5,2),
Primary Key (TruckID)
);
Create Table Trip
(TripID Varchar2(10) Not Null,
TripDate Date,
TotalKm Number(5),
TruckID Varchar2(10),
Primary Key (TripID),
Foreign Key (TruckID) References Truck(TruckID)
);
Create Table TripFrom
(TripID Varchar2(10) Not Null,
WarehouseID Varchar2(10) Not Null,
Primary Key (TripID, WarehouseID),
Foreign Key (TripID) References Trip(TripID),
Foreign Key (WarehouseID) References Warehouse(WarehouseID)
);
Create Table Store
(StoreID Varchar2(10) Not Null,
StoreName Varchar2(20),
StoreAddress Varchar2(20),
Primary Key (StoreID)
);
Create Table Destination -- bridge table 
(TripID Varchar2(10) Not Null,
StoreID Varchar2(10) Not Null,
Primary Key (TripID, StoreID),
Foreign Key (TripID) References Trip(TripID),
Foreign Key (StoreID) References Store(StoreID)
);

-- insert records to operational database
Insert Into Warehouse Values ('W1','Warehouse1');
Insert Into Warehouse Values ('W2','Warehouse2');
Insert Into Warehouse Values ('W3','Warehouse3');
Insert Into Warehouse Values ('W4','Warehouse4');
Insert Into Warehouse Values ('W5','Warehouse5');

Insert Into Truck Values ('Truck1', 250, 'Medium', 1.2);
Insert Into Truck Values ('Truck2', 300, 'Medium', 1.5);
Insert Into Truck Values ('Truck3', 100, 'Small', 0.8);
Insert Into Truck Values ('Truck4', 550, 'Large', 2.3);
Insert Into Truck Values ('Truck5', 650, 'Large', 2.5);

Insert Into Trip Values ('Trip1', to_date('14-Apr-2013', 'DD-MON-YYYY'), 370, 'Truck1');
Insert Into Trip Values ('Trip2', to_date('14-Apr-2013', 'DD-MON-YYYY'), 570, 'Truck2');
Insert Into Trip Values ('Trip3', to_date('14-Apr-2013', 'DD-MON-YYYY'), 250, 'Truck3');
Insert Into Trip Values ('Trip4', to_date('15-Jul-2013', 'DD-MON-YYYY'), 450, 'Truck1');
Insert Into Trip Values ('Trip5', to_date('15-Jul-2013', 'DD-MON-YYYY'), 175, 'Truck2');

Insert Into TripFrom Values ('Trip1', 'W1');
Insert Into TripFrom Values ('Trip1', 'W4');
Insert Into TripFrom Values ('Trip1', 'W5');
Insert Into TripFrom Values ('Trip2', 'W1');
Insert Into TripFrom Values ('Trip2', 'W2');
Insert Into TripFrom Values ('Trip3', 'W1');
Insert Into TripFrom Values ('Trip3', 'W5');
Insert Into TripFrom Values ('Trip4', 'W1');
Insert Into TripFrom Values ('Trip5', 'W4');
Insert Into TripFrom Values ('Trip5', 'W5');

Insert Into Store Values ('M1', 'Myer City', 'Melbourne');
Insert Into Store Values ('M2', 'Myer Chaddy', 'Chadstone');
Insert Into Store Values ('M3', 'Myer HiPoint', 'High Point');
Insert Into Store Values ('M4', 'Myer West', 'Doncaster');
Insert Into Store Values ('M5', 'Myer North', 'Northland');
Insert Into Store Values ('M6', 'Myer South', 'Southland');
Insert Into Store Values ('M7', 'Myer East', 'Eastland');
Insert Into Store Values ('M8', 'Myer Knox', 'Knox');

Insert Into Destination Values ('Trip1', 'M1');
Insert Into Destination Values ('Trip1', 'M2');
Insert Into Destination Values ('Trip1', 'M4');
Insert Into Destination Values ('Trip1', 'M3');
Insert Into Destination Values ('Trip1', 'M8');
Insert Into Destination Values ('Trip2', 'M4');
Insert Into Destination Values ('Trip2', 'M1');
Insert Into Destination Values ('Trip2', 'M2');

-- Question 1
SELECT * FROM TRIP;
SELECT * FROM DESTINATION;
SELECT * FROM STORE;
Insert into Destination Values ('Trip3', 'M1');
Insert into Destination Values ('Trip3', 'M5');
Insert into Destination Values ('Trip3', 'M6');

-- Part 2
--a. Create a dimension table called TruckDim1.
CREATE TABLE TruckDIM1 AS SELECT * FROM Truck;
SELECT * FROM TruckDIM1;

--b. Create a dimension table called TripSeason1. This table will have 4 records
--(Summer, Autumn, Winter, and Spring).
-- DROP TABLE TripSeasonDIM1;
CREATE TABLE TripSeasonDIM1 
(SeasonID VARCHAR2(8), 
Seasnperiod VARCHAR2(30)
);

INSERT INTO TripSeasonDIM1 VALUES ('Spring', 'September to November');
INSERT INTO TripSeasonDIM1 VALUES ('Summer', 'December to February');
INSERT INTO TripSeasonDIM1 VALUES ('Autumn', 'March to May');
INSERT INTO TripSeasonDIM1 VALUES ('Winter', 'June to August');

SELECT * FROM TripSeasonDIM1;

--c. Create a dimension table called TripDim1.
CREATE TABLE TripDIM1 AS 
SELECT TripID, TripDATE, TotalKM FROM TRIP;

SELECT * FROM TripDIM1;

--d. Create a bridge table called BridgeTableDim1.
CREATE TABLE BridgeTableDIM1 AS 
SELECT * FROM Destination;

SELECT * FROM BridgeTableDIM1;

--e. Create a dimension table called StoreDim1.
CREATE TABLE StoreDIM1 AS 
SELECT * FROM Store;

SELECT * FROM StoreDIM1;

--f. Create a tempfact (and perform the necessary alter and update), 
--and then create the final fact table (called it TruckFact1).
CREATE TABLE TruckTempFact AS 
SELECT T.TruckID, T.TripDate, T.TripID, T.TotalKM * TR.CostPerKM AS Total_Delivery_Cost
FROM Trip T JOIN Truck TR ON T.TruckID = TR.TruckID;

SELECT * FROM TruckTempFact;

ALTER TABLE TruckTempfact 
ADD SeasonID VARCHAR2(8);

UPDATE TruckTempFact
SET SeasonID = 'Spring'
WHERE TO_CHAR(TripDate, 'MM') BETWEEN 09 AND 11;

UPDATE TruckTempFact
SET SeasonID = 'Summer'
WHERE TO_CHAR(TripDate, 'MM') = 12 OR TO_CHAR(TripDate, 'MM') <= 2;

UPDATE TruckTempFact
SET SeasonID = 'Winter'
WHERE TO_CHAR(TripDate, 'MM') BETWEEN 06 AND 08;

UPDATE TruckTempFact
SET SeasonID = 'Autumn'
WHERE TO_CHAR(TripDate, 'MM') BETWEEN 03 AND 05;

SELECT * FROM TruckTempFact;

-- create final fact table
CREATE TABLE TruckFACT AS 
SELECT TripID, SeasonID, TruckID, SUM(Total_Delivery_Cost) AS Total_Delivery_Cost
FROM TruckTempFact
GROUP BY TripID, SeasonID, TruckID; -- TRIP is used to link to STORE, even though it is not mentioned in the requirement to use TRIP dimension

SELECT * FROM TruckFACT;

--g. Display (and observe) the contents of the fact table (TruckFact1).

-- Part 3
--(iii) Now, do another select statement to display the TripID, Date, TotalKm,
--together with Number of Stores (you need to use an aggregate function to
--count number of stores per trip). 
SELECT TripID, COUNT(StoreID)
FROM Destination
GROUP BY TripID;

-- Can you find a trip that does not have any store in the operational database? 
SELECT * 
FROM Trip
WHERE TripID NOT IN (SELECT DISTINCT TripID FROM Destination);

-- Is this trip included in the query result? If not, why not?


--(iv) Revise the above select statement, so that the number of stores is not
--displayed as an integer number, but as a percentage. For example, if the
--number of stores is 5, then it should show 0.2 (20%), instead of 5.
SELECT TripID, ROUND(1/COUNT(StoreID), 2) -- will be the same 1/COUNT(*), becasue there is no NULL value for StoreID
FROM Destination
GROUP BY TripID;

--(v) Now, you are ready to create table TripDim2. Don't forget that the column
--that stores the weight must be named
-- DROP TABLE TripDIM2;
CREATE TABLE TripDIM2 AS 
SELECT T.TripID, T.TripDate, T.TotalKM, ROUND(1/COUNT(*), 2) AS WeightFactor
FROM Trip T, Destination D
WHERE T.TripID = D.TripID
GROUP BY T.TripID, T.TripDate, T.TotalKM;

SELECT * FROM TripDIM2;

-- h. What is the total delivery cost for each store?
SELECT S.StoreID, S.StoreName, ROUND(SUM(Total_Delivery_Cost * T.WeightFactor), 2) AS Total_Delivery_Cost
FROM TruckFACT TR, TripDIM2 T, BridgeTableDIM1 B, StoreDIM1 S
WHERE T.TripID = TR.TripID AND T.TripID = B.TripID AND B.StoreID = S.StoreID
GROUP BY S.StoreID, S.StoreName;

-- Part 4
--e. Create a dimension table called TripDim3 (Note that TripDim3 is different from
--TripDim1 and TripDim2).
CREATE TABLE TripDIM3 AS 
SELECT T.TripID, T.TripDate, T.TotalKM, ROUND(1/COUNT(*), 2) AS WeightFactor, 
LISTAGG(D.StoreID, '_') WITHIN GROUP (ORDER BY D.StoreID) AS StoreGroupList
FROM Trip T, Destination D
WHERE T.TripID = D.TripID
GROUP BY T.TripID, T.TripDate, T.TotalKM;

SELECT * FROM TripDIM3;



