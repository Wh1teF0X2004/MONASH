--Topic: Multifact
--Week 8: Granularity and Levels of Aggregation

--Tables that will be used:
--DTANIAR.AUTHOR5           (authorid, lastname, firstname, phone, state, country)
--DTANIAR.BOOK5             (ISBN, title, description, publishedyear, categoryid, publisherid)
--DTANIAR.TITLEAUTHOR5      (authorid, ISBN)
--DTANIAR.CATEGORY5         (categoryid, categorydescription)
--DTANIAR.PUBLISHER5        (publisherid, publishername, website, address, suburb, state, postcode, country)
--DTANIAR.REVIEW5           (reviewnum, reviewtext, stars, ISBN)
--DTANIAR.STORE5            (storied, address, suburb, postcode, state, country)
--DTANIAR.SALES5            (salesid, salesdate, totalprice, storied)
--DTANIAR.SALESDETAILS5     (salesid, ISBN, quantity, unitprice, totalprice)

--Questions:
--What are the total sales for each bookstore in a month?
--What is the number of books sold for each category?
--What is the book category that has the highest total sales?
--What is the number of reviews for each category?
--How many 5-star reviews for each category?

--Fact Measures: Total sales, Number of books sold, and Number of reviews

--Drop tables
DROP TABLE TimeDIM;
DROP TABLE StoreDIM;
DROP TABLE CategoryDIM;
DROP TABLE StarRatingDIM;
DROP TABLE ReviewFACT;
DROP TABLE TEMP_BookWithStar;
DROP TABLE TEMP_BookWithAvgStar;
DROP TABLE BookSalesFACT;

--a
CREATE TABLE TimeDIM AS
SELECT DISTINCT TO_CHAR(salesdate, 'YYYYMM') AS TimeID, TO_CHAR(salesdate,'MM') AS Month, TO_CHAR(salesdate,'YYYY') AS Year
FROM DTANIAR.SALES5;
SELECT * FROM TimeDIM;

--b
CREATE TABLE StoreDIM AS
SELECT * FROM DTANIAR.STORE5;
SELECT * FROM StoreDIM;

--c
CREATE TABLE CategoryDIM AS
SELECT * FROM DTANIAR.CATEGORY5;
SELECT * FROM CategoryDIM;

--d
CREATE TABLE StarRatingDIM ( 
    StarID          Number(1),
    StarDescription Varchar2(20)
);

INSERT INTO StarRatingDIM VALUES (0, 'Unknown');
INSERT INTO StarRatingDIM VALUES (1, 'Poor');
INSERT INTO StarRatingDIM VALUES (2, 'Not Good');
INSERT INTO StarRatingDIM VALUES (3, 'Average');
INSERT INTO StarRatingDIM VALUES (4, 'Good');
INSERT INTO StarRatingDIM VALUES (5, 'Excellent');
SELECT * FROM StarRatingDIM;

--e
CREATE TABLE ReviewFACT AS
SELECT b.CATEGORYID, r.STARS AS StarID, COUNT(*) AS Num_of_Review
FROM DTANIAR.BOOK5 b, DTANIAR.REVIEW5 r
WHERE b.ISBN = r.ISBN
GROUP BY b.CATEGORYID, r.STARS;
SELECT * FROM ReviewFACT;
--Teacher's version:
CREATE TABLE ReviewFACT_new AS
SELECT B.CATEGORYID, R.STARS AS StarID, COUNT(*) AS Number_of_Review
FROM DTANIAR.BOOK5 B NATURAL JOIN DTANIAR.REVIEW5 R
GROUP BY B.CATEGORYID, R.Stars;
SELECT * FROM ReviewFACT_new;

--f
CREATE TABLE TEMP_BookWithStar AS
SELECT B.ISBN, B.CategoryID, NVL(R.Stars, 0) AS Star
FROM DTANIAR.BOOK5 B, DTANIAR.REVIEW5 R
WHERE B.ISBN = R.ISBN(+);
--Teacher's version:
CREATE TABLE TEMPBOOKWITHSTAR AS
SELECT B.ISBN, B.CATEGORYID, NVL(R.Stars, 0) AS Star
FROM DTANIAR.BOOK5 B LEFT OUTER JOIN DTANIAR.REVIEW5 R
ON B.ISBN = R.ISBN;

SELECT * FROM TEMP_BookWithStar
WHERE ISBN = '0316465186';
--NOTE: Book 0316465186 is the one that does not have any reviews, and the star is 0

--g
CREATE TABLE TEMP_BookWithAvgStar AS
SELECT ISBN, CategoryID, ROUND(AVG(Star)) AS Avg_Star
FROM TEMP_BookWithStar
GROUP BY ISBN, CategoryID;

--h
CREATE TABLE BookSalesFACT AS
SELECT T.CategoryID, TO_CHAR(S.SalesDate, 'YYYYMM') AS TimeID, S.StoreID, T.Avg_star AS StarID, SUM(SD.quantity) AS Num_of_Books, SUM(SD.TotalPrice) AS Total_Sales
FROM TEMP_BookWithAvgStar T, DTANIAR.SALES5 S, DTANIAR.SALESDETAILS5 SD
WHERE T.ISBN = SD.ISBN 
AND SD.SALESID = S.SALESID
GROUP BY T.CategoryID, TO_CHAR(S.SalesDate, 'YYYYMM'), S.StoreID, T.Avg_star;

--What are the total sales for each bookstore in a month?
--Sample Answer:
SELECT s.STOREID, t.Month,
SUM(f.total_sales) AS Total_Sales
FROM StoreDIM s, TimeDIM t, BookSalesFACT f
WHERE s.STOREID = f.STOREID
AND f.TimeID = t.TimeID
GROUP BY s.STOREID, t.Month
ORDER BY s.STOREID, t.Month;
--Teacher's Answer: TODO

--What is the number of books sold for each category?
--Sample Answer:
SELECT c.CATEGORYID, c.CATEGORYDESCRIPTION, SUM(f.Num_of_Books) as Total_Num_Books
FROM BookSalesFACT f, CategoryDIM c
WHERE f.CATEGORYID = c.CATEGORYID
GROUP BY c.CATEGORYID, c.CATEGORYDESCRIPTION
ORDER BY c.CATEGORYID, c.CATEGORYDESCRIPTION;
--Teacher's Answer: TODO

--What is the book category that has the highest total sales?
--Sample Answer:
SELECT * FROM (
    SELECT c.CATEGORYID, c.CATEGORYDESCRIPTION, SUM(f.Num_of_Books) AS Total_Num_Books
    FROM BookSalesFACT f, CategoryDIM c
    WHERE f.CATEGORYID = c.CATEGORYID
    GROUP BY c.CATEGORYID, c.CATEGORYDESCRIPTION
    ORDER BY Total_Num_Books DESC)
WHERE ROWNUM = 1;
--Teacher's Answer: TODO

--What is the number of reviews for each category?
--Sample Answer:
SELECT c.CATEGORYID, c.CATEGORYDESCRIPTION, SUM(f.num_of_review) AS Number_of_Reviews
FROM ReviewFACT f, CategoryDIM c
WHERE f.CATEGORYID = c.CATEGORYID
GROUP BY c.CATEGORYID, c.CATEGORYDESCRIPTION
ORDER BY c.CATEGORYID, c.CATEGORYDESCRIPTION;
--Teacher's Answer: TODO

--How many 5-star reviews for each category?
--Sample Answer:
SELECT c.CATEGORYID, c.CATEGORYDESCRIPTION, SUM(f.NUM_OF_REVIEW) AS Number_of_5star_Reviews
FROM ReviewFACT f, CategoryDIM c, StarRatingDIM s
WHERE f.CATEGORYID = c.CATEGORYID
AND s.StarID = f.StarID
AND s.StarID = 5
GROUP BY c.CATEGORYID, c.CATEGORYDESCRIPTION
ORDER BY c.CATEGORYID, c.CATEGORYDESCRIPTION;
--Teacher's Answer: TODO
