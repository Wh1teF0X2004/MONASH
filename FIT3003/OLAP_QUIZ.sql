DROP TABLE BakeryFACT;
DROP TABLE FeedbackFACT;
DROP TABLE BranchDIM;
DROP TABLE TimeDIM;
DROP TABLE RatingDIM;
DROP TABLE ProductDIM;
DROP TABLE ChannelDIM;

CREATE TABLE BakeryFACT (
    ProductType VARCHAR(30),
    Branch VARCHAR(30),
    MonthYear VARCHAR(6),
    Channel VARCHAR(30),
    Total_Sales NUMBER
);

CREATE TABLE FeedbackFACT (
    ProductType VARCHAR(30),
    MonthYear VARCHAR(6),
    RatingID NUMBER,
    No_Of_Feedback NUMBER
);

CREATE TABLE BranchDIM (
    Branch VARCHAR(30)
);

CREATE TABLE TimeDIM (
    MonthYear VARCHAR(6),
    Month VARCHAR(30),
    Year NUMBER
);

CREATE TABLE RatingDIM (
    RatingID NUMBER,
    Description VARCHAR(30)
);

CREATE TABLE ProductDIM (
    ProductType VARCHAR(30)
);

CREATE TABLE ChannelDIM (
    Channel VARCHAR(30)
);


INSERT INTO BakeryFACT VALUES ('Croissants','Carlton','202101','Take-away',20000);
INSERT INTO BakeryFACT VALUES ('Croissants','Carlton','202101','Dine-in',30000);
INSERT INTO BakeryFACT VALUES ('Croissants','East Melbourne','202101','Dine-in',35000);
INSERT INTO BakeryFACT VALUES ('Croissants','East Melbourne','202101','Take-away',35000);
INSERT INTO BakeryFACT VALUES ('Croissants','North Melbourne','202101','Dine-in',15000);
INSERT INTO BakeryFACT VALUES ('Pastry','North Melbourne','202101','Dine-in',25000);

INSERT INTO BakeryFACT VALUES ('Croissants','Richmond','202101','Take-away',39000);
INSERT INTO BakeryFACT VALUES ('Pastry','Richmond','202101','Take-away',45000);
INSERT INTO BakeryFACT VALUES ('Croissants','Carlton','202102','Dine-in',15000);
INSERT INTO BakeryFACT VALUES ('Pastry','Carlton','202102','Take-away',10000);
INSERT INTO BakeryFACT VALUES ('Pastry','East Melbourne','202102','Take-away',20000);
INSERT INTO BakeryFACT VALUES ('Croissants','North Melbourne','202102','Dine-in',10000);

INSERT INTO BakeryFACT VALUES ('Croissants','Richmond','202102','Take-away',45000);
INSERT INTO BakeryFACT VALUES ('Croissants','Carlton','202103','Take-away',25000);
INSERT INTO BakeryFACT VALUES ('Pastry','Carlton','202103','Take-away',20000);
INSERT INTO BakeryFACT VALUES ('Croissants','East Melbourne','202103','Dine-in',25000);
INSERT INTO BakeryFACT VALUES ('Croissants','North Melbourne','202103','Dine-in',40000);
INSERT INTO BakeryFACT VALUES ('Pastry','North Melbourne','202103','Take-away',25000);

INSERT INTO BakeryFACT VALUES ('Pastry','Richmond','202103','Dine-in',25000);
INSERT INTO BakeryFACT VALUES ('Pastry','Richmond','202103','Take-away',50000);
INSERT INTO BakeryFACT VALUES ('Croissants','East Melbourne','202104','Dine-in',25000);
INSERT INTO BakeryFACT VALUES ('Pastry','East Melbourne','202104','Dine-in',30000);
INSERT INTO BakeryFACT VALUES ('Pastry','North Melbourne','202104','Take-away',50000);
INSERT INTO BakeryFACT VALUES ('Croissants','Richmond','202104','Take-away',35000);

INSERT INTO FeedbackFACT VALUES ('Croissants', '202101', 1, 100);
INSERT INTO FeedbackFACT VALUES ('Croissants', '202101', 2, 100);
INSERT INTO FeedbackFACT VALUES ('Croissants', '202101', 3, 250);
INSERT INTO FeedbackFACT VALUES ('Croissants', '202101', 4, 200);
INSERT INTO FeedbackFACT VALUES ('Croissants', '202102', 1, 50);

INSERT INTO FeedbackFACT VALUES ('Croissants', '202102', 2, 50);
INSERT INTO FeedbackFACT VALUES ('Croissants', '202102', 3, 100);
INSERT INTO FeedbackFACT VALUES ('Croissants', '202102', 4, 200);
INSERT INTO FeedbackFACT VALUES ('Croissants', '202102', 5, 300);
INSERT INTO FeedbackFACT VALUES ('Pastry', '202101', 2, 100);

INSERT INTO FeedbackFACT VALUES ('Pastry', '202101', 3, 150);
INSERT INTO FeedbackFACT VALUES ('Pastry', '202101', 4, 200);
INSERT INTO FeedbackFACT VALUES ('Pastry', '202101', 5, 100);
INSERT INTO FeedbackFACT VALUES ('Pastry', '202102', 3, 150);
INSERT INTO FeedbackFACT VALUES ('Pastry', '202102', 4, 100);

INSERT INTO FeedbackFACT VALUES ('Pastry', '202102', 4, 200);
INSERT INTO FeedbackFACT VALUES ('Pastry', '202102', 5, 300);
INSERT INTO FeedbackFACT VALUES ('Croissants', '202103', 2, 150);
INSERT INTO FeedbackFACT VALUES ('Croissants', '202103', 3, 200);
INSERT INTO FeedbackFACT VALUES ('Croissants', '202103', 4, 300);

INSERT INTO FeedbackFACT VALUES ('Croissants', '202103', 5, 400);
INSERT INTO FeedbackFACT VALUES ('Pastry', '202103', 2, 150);
INSERT INTO FeedbackFACT VALUES ('Pastry', '202103', 3, 250);
INSERT INTO FeedbackFACT VALUES ('Pastry', '202103', 4, 200);
INSERT INTO FeedbackFACT VALUES ('Pastry', '202103', 5, 300);

INSERT INTO BranchDIM VALUES('North Melbourne');
INSERT INTO BranchDIM VALUES('East Melbourne');
INSERT INTO BranchDIM VALUES('Carlton');
INSERT INTO BranchDIM VALUES('Richmond');

INSERT INTO TimeDIM VALUES('202101','January',2021);
INSERT INTO TimeDIM VALUES('202102','February',2021);
INSERT INTO TimeDIM VALUES('202103','March',2021);

INSERT INTO RatingDIM VALUES(1,'Poor');
INSERT INTO RatingDIM VALUES(2,'Fair');
INSERT INTO RatingDIM VALUES(3,'Good');
INSERT INTO RatingDIM VALUES(4,'Very Good');
INSERT INTO RatingDIM VALUES(5,'Excellent');

INSERT INTO ProductDIM VALUES('Croissants');
INSERT INTO ProductDIM VALUES('Pastry');

INSERT INTO ChannelDIM VALUES('Take-away');
INSERT INTO ChannelDIM VALUES('Dine-in');

-- sample question answer
SELECT
DECODE(GROUPING(ProductType), 1, 'All Products', ProductType) As ProductType,
DECODE(GROUPING(Channel), 1, 'All Channels', Channel) As Channel,
SUM(Total_Sales)
FROM BakeryFACT
GROUP BY CUBE(ProductType),Channel
Order By ProductType, Channel;

--a.
SELECT Description, ProductType, SUM(No_of_Feedback) AS Total_Feedback,
RANK() OVER(PARTITION BY ProductType ORDER BY SUM(No_Of_Feedback) DESC) AS Rank
FROM FeedbackFACT NATURAL JOIN RatingDIM
GROUP BY Description, ProductType;
--b.
SELECT Description, ProductType, SUM(No_of_Feedback) AS Total_Feedback,
RANK() OVER(PARTITION BY Description ORDER BY SUM(No_Of_Feedback) DESC) AS Rank
FROM FeedbackFACT NATURAL JOIN RatingDIM
GROUP BY Description, ProductType;
--c.
SELECT Description, ProductType, SUM(No_of_Feedback) AS Total_Feedback,
RANK() OVER(ORDER BY SUM(No_Of_Feedback) DESC) AS Rank
FROM FeedbackFACT NATURAL JOIN RatingDIM
GROUP BY Description, ProductType;
--d.
SELECT Description, ProductType, SUM(No_of_Feedback) AS Total_Feedback,
RANK() OVER(PARTITION BY Description ORDER BY SUM(No_Of_Feedback)) AS Rank
FROM FeedbackFACT NATURAL JOIN RatingDIM
GROUP BY Description, ProductType;