--Create Tables
CREATE TABLE WAREHOUSE (
    WarehouseID     VARCHAR2(10) NOT NULL,
    Location        VARCHAR2(10) NOT NULL,
    Primary Key (WarehouseID)
);

CREATE TABLE TRUCK (
    TruckID         VARCHAR2(10) NOT NULL,
    VolCapacity     NUMBER(5,2),
    WeightCategory  VARCHAR2(10),
    CostPerKm       NUMBER(5,2),
    Primary Key (TruckID)
);

CREATE TABLE TRIP (
    TripID         VARCHAR2(10) NOT NULL,
    TripDate       DATE,
    TotalKm        NUMBER(5),
    TruckID        VARCHAR2(10) NOT NULL,
    Primary Key (TripID),
    Foreign Key (TruckID) References Truck(TruckID)
);

CREATE TABLE TRIPFORM (
    TripID          VARCHAR2(10) NOT NULL,
    WarehouseID     VARCHAR2(10) NOT NULL,
    Primary Key (TripID, WarehouseID),
    Foreign Key (TripID) References Trip(TripID),
    Foreign Key (WarehouseID) References Warehouse(WarehouseID)
);

CREATE TABLE STORE (
    StoreID         VARCHAR2(10) NOT NULL,
    StoreName       VARCHAR2(20),
    StoreAddress    VARCHAR2(20),
    Primary Key (StoreID)
);

CREATE TABLE DESTINATION (
    TripID          VARCHAR2(10) NOT NULL,
    StoreID         VARCHAR2(10) NOT NULL,
    Primary Key (TripID, StoreID),
    Foreign Key (TripID) References Trip(TripID),
    Foreign Key (StoreID) References Store(StoreID)
);

--Insert Records to Operational Database
INSERT INTO WAREHOUSE VALUES ('W1','Warehouse1');
INSERT INTO WAREHOUSE VALUES ('W2','Warehouse2');
INSERT INTO WAREHOUSE VALUES ('W3','Warehouse3');
INSERT INTO WAREHOUSE VALUES ('W4','Warehouse4');
INSERT INTO WAREHOUSE VALUES ('W5','Warehouse5');

INSERT INTO TRUCK VALUES ('Truck1', 250, 'Medium', 1.2);
INSERT INTO TRUCK VALUES ('Truck2', 300, 'Medium', 1.5);
INSERT INTO TRUCK VALUES ('Truck3', 100, 'Small', 0.8);
INSERT INTO TRUCK VALUES ('Truck4', 550, 'Large', 2.3);
INSERT INTO TRUCK VALUES ('Truck5', 650, 'Large', 2.5);

INSERT INTO TRIP VALUES ('Trip1', to_date('14-Apr-2013', 'DD-MON-YYYY'), 370, 'Truck1');
INSERT INTO TRIP VALUES ('Trip2', to_date('14-Apr-2013', 'DD-MON-YYYY'), 570, 'Truck2');
INSERT INTO TRIP VALUES ('Trip3', to_date('14-Apr-2013', 'DD-MON-YYYY'), 250, 'Truck3');
INSERT INTO TRIP VALUES ('Trip4', to_date('15-Jul-2013', 'DD-MON-YYYY'), 450, 'Truck1');
INSERT INTO TRIP VALUES ('Trip5', to_date('15-Jul-2013', 'DD-MON-YYYY'), 175, 'Truck2');

INSERT INTO TRIPFORM VALUES ('Trip1', 'W1');
INSERT INTO TRIPFORM VALUES ('Trip1', 'W4');
INSERT INTO TRIPFORM VALUES ('Trip1', 'W5');
INSERT INTO TRIPFORM VALUES ('Trip2', 'W1');
INSERT INTO TRIPFORM VALUES ('Trip2', 'W2');
INSERT INTO TRIPFORM VALUES ('Trip3', 'W1');
INSERT INTO TRIPFORM VALUES ('Trip3', 'W5');
INSERT INTO TRIPFORM VALUES ('Trip4', 'W1');
INSERT INTO TRIPFORM VALUES ('Trip5', 'W4');
INSERT INTO TRIPFORM VALUES ('Trip5', 'W5');

INSERT INTO STORE VALUES ('M1', 'Myer City', 'Melbourne');
INSERT INTO STORE VALUES ('M2', 'Myer Chaddy', 'Chadstone');
INSERT INTO STORE VALUES ('M3', 'Myer HiPoint', 'High Point');
INSERT INTO STORE VALUES ('M4', 'Myer West', 'Doncaster');
INSERT INTO STORE VALUES ('M5', 'Myer North', 'Northland');
INSERT INTO STORE VALUES ('M6', 'Myer South', 'Southland');
INSERT INTO STORE VALUES ('M7', 'Myer East', 'Eastland');
INSERT INTO STORE VALUES ('M8', 'Myer Knox', 'Knox');

INSERT INTO DESTINATION VALUES ('Trip1', 'M1');
INSERT INTO DESTINATION VALUES ('Trip1', 'M2');
INSERT INTO DESTINATION VALUES ('Trip1', 'M4');
INSERT INTO DESTINATION VALUES ('Trip1', 'M3');
INSERT INTO DESTINATION VALUES ('Trip1', 'M8');
INSERT INTO DESTINATION VALUES ('Trip2', 'M4');
INSERT INTO DESTINATION VALUES ('Trip2', 'M1');
INSERT INTO DESTINATION VALUES ('Trip2', 'M2');

--a. Create a dimension table called TruckDim1
CREATE TABLE TRUCKDIM1 AS
SELECT * FROM TRUCK;
SELECT * FROM TRUCKDIM1;

--b. Create a dimension table called TRIPSEASON1
CREATE TABLE TRIPSEASON1 (
    SeasonID        VARCHAR2(8),
    SeasonPeriod    VARCHAR2(30)
);
INSERT INTO TRIPSEASON1 VALUES ('Spring', 'September to November');
INSERT INTO TRIPSEASON1 VALUES ('Summer', 'December to February');
INSERT INTO TRIPSEASON1 VALUES ('Autumn', 'March to May');
INSERT INTO TRIPSEASON1 VALUES ('Winter', 'June to August');

--c. Create a dimension table called TRIPDIM1
CREATE TABLE TRIPDIM1 AS 
SELECT TripID, TripDate, TotalKM FROM TRIP;
SELECT * FROM TRIPDIM1;

--d. Create a bridge table called BRIDGETABLEDIM1
CREATE TABLE BRIDGETABLEDIM1 AS
SELECT * FROM DESTINATION;
SELECT * FROM BRIDGETABLEDIM1;

--e. Create a dimension table called STOREDIM1
CREATE TABLE STOREDIM1 AS
SELECT * FROM STORE;
SELECT * FROM STOREDIM1;

--f. Create a TEMPFACT and then create the final fact table called it TRUCKFACT1
CREATE TABLE TRUCKTEMPFACT AS 
SELECT T.TruckID, T.TripDate, T.TripID, T.TotalKM * TR.CostPerKM AS Total_Delivery_Cost
FROM TRIP T JOIN TRUCK TR ON T.TruckID = TR.TruckID;

SELECT * FROM TRUCKTEMPFACT ORDER BY TripID;

ALTER TABLE TRUCKTEMPFACT ADD SeasonID VARCHAR(8);

UPDATE TRUCKTEMPFACT
SET SeasonID = 'Spring'
WHERE TO_CHAR(TripDate, 'MM') BETWEEN 9 AND 11;

UPDATE TRUCKTEMPFACT
SET SeasonID = 'Summer'
WHERE TO_CHAR(TripDate, 'MM') = 12 OR TO_CHAR(TripDate, 'MM') <=2;

UPDATE TRUCKTEMPFACT
SET SeasonID = 'Autumn'
WHERE TO_CHAR(TripDate, 'MM') BETWEEN 3 AND 5;

UPDATE TRUCKTEMPFACT
SET SeasonID = 'Winter'
WHERE TO_CHAR(TripDate, 'MM') BETWEEN 6 AND 8;

SELECT * FROM TRUCKTEMPFACT;

CREATE TABLE TRUCKFACT AS 
SELECT TripID, SeasonID, TruckID, SUM(Total_Delivery_Cost) AS Total_Delivery_Cost
FROM TRUCKTEMPFACT
GROUP BY TripID, SeasonID, TruckID;
SELECT * FROM TRUCKFACT;

--g. Display and observe the contents of the fact table (TRUCKFACT1)
--ADD IN WEIGHT FACTOR
--iii, iv.
SELECT TripID, COUNT(StoreID) FROM DESTINATION GROUP BY TripID;
-- Can you find ta trip that does not have any in the operational database?
SELECT * FROM TRIP WHERE TripID NOT IN (SELECT DISTINCT TripID FROM DESTINATION);
-- Is this trip included in the query result? If not, why not?
-- Revise the above select statement so that the number of stores is not displayed as an int but as percentage
SELECT TripID, ROUND(1/COUNT(StoreID), 2)
FROM DESTINATION
GROUP BY TripID;
--v. Create TRIPDIM2
CREATE TABLE TRIPDIM2 AS 
SELECT T.TripID, T.TripDate, T.TotalKM, 1/COUNT(*) AS WeightFactor
FROM TRIP T, DESTINATION D
WHERE T.TripID = D.TripID
GROUP BY T.TripID, T.TripDate, T.TotalKM;
SELECT * FROM TRIPDIM2;

SELECT * FROM TRUCKFACT;
SELECT * FROM BRIDGETABLEDIM1;

-- What is the total delivery cots for each store?
SELECT S.StoreID, S.StoreName, SUM(F.Total_Delivery_Cost * T.WeightFactor) AS Total_Cost_Store
FROM TRUCKFACT F, TRIPDIM2 T, STOREDIM1 S, BRIDGETABLEDIM1 B
WHERE F.TripID = T.TripID
AND T.TripID = B.TripID
AND B.StoreID = S.StoreID
GROUP BY S.StoreID, S.StoreName
ORDER BY S.StoreID, S.StoreName;

--Create a dimension table called TRIPDIM3
CREATE TABLE TRIPDIM3 AS 
SELECT T.TripID, T.TripDate, T.TotalKM, ROUND(1/COUNT(*),2) AS WeightFactor,
LISTAGG(D.StoreID, '_') WITHIN GROUP (ORDER BY D.StoreID) AS StoreGroupList
FROM TRIP T, DESTINATION D
WHERE T.TripID = D.TripID
GROUP BY T.TripID, T.TripDate, T.TotalKM;
SELECT * FROM TRIPDIM3;

-- List the store name of the stored visited by trip 2
SELECT StoreName
FROM STOREDIM1 S, TRIPDIM3 T
WHERE T.StoreGroupList LIKE '%'||S.StoreID||'%'
AND TripID = 'Trip2';

SELECT StoreName
FROM STOREDIM1 NATURAL JOIN TRIPDIM3 NATURAL JOIN BRIDGETABLEDIM1
WHERE TripID = 'Trip2';
