-- Week 6 tutorial, lab 5
-- The Bookshop Case Study 

--CUSTOMER
create table CUSTOMER as
select CUSTOMERID as CUSTOMER_ID, name as CUSTOMER_NAME, 
ADDRESS, SUBURB, POSTCODE, STATE
from DTANIAR.CUSTOMER4;

alter table CUSTOMER add constraint CUSTOMER_PK primary key ( CUSTOMER_ID );

--BOOK
create table BOOK
(BOOK_ID varchar2(20) not null ,
BOOK_TITLE varchar2(200),
AUTHOR varchar2(200)) ;

alter table BOOK add constraint BOOK_PK primary key ( BOOK_ID ); 
insert into BOOK values('C1', 'CSIRO Diet', 'CSIRO Team');
insert into BOOK values('H6', 'Harry Potter 6', 'Rowling');
insert into BOOK values('DV', 'Da Vinci Code', 'Dan Brown');

--BOOK PRICE HISTORY
create table BOOK_PRICE_HISTORY
(BOOK_ID varchar2(20) not null ,
START_DATE varchar2(10) null ,
END_DATE varchar2(10) not null ,
PRICE number ,
REMARKS varchar2(100)) ;

alter table BOOK_PRICE_HISTORY add constraint BOOK_PRICE_HISTORY_PK primary key ( BOOK_ID, START_DATE, END_DATE ) ;
alter table BOOK_PRICE_HISTORY add constraint
BOOK_PRICE_HISTORY_BOOK_FK foreign key ( BOOK_ID ) references BOOK ( BOOK_ID ) ;

insert into BOOK_PRICE_HISTORY values('C1', 'Jan2007', 'Jul2007', 45.95, 'Full Price');
insert into BOOK_PRICE_HISTORY values('C1', 'Aug2007', 'Oct2007', 36.75, '20% Discount');
insert into BOOK_PRICE_HISTORY values('C1', 'Nov2007', 'Jan2008', 23.00, 'Half Price');
insert into BOOK_PRICE_HISTORY values('C1', 'Feb2008', 'Now', 45.95, 'Full Price');
insert into BOOK_PRICE_HISTORY values('H6', 'Jan2007', 'Mar2007', 21.95, 'Launching');
insert into BOOK_PRICE_HISTORY values('H6', 'Apr2007', 'Feb2008', 30.95, 'Full Price');
insert into BOOK_PRICE_HISTORY values('H6', 'Jan2008', 'Now', 10.00, 'End of Product Sale');
insert into BOOK_PRICE_HISTORY values('DV', 'Jan2007', 'Now', 27.95, 'Full Price');

--BRANCH
create table BRANCH
(BRANCH_ID varchar2(100) not null ,
BRANCH_ADDRESS varchar2(200)) ;

alter table BRANCH add constraint BRANCH_PK primary key ( BRANCH_ID ); 
insert into BRANCH values('City', 'VIC3622');
insert into BRANCH values('Chadstone', 'Chadstone VIC3234');
insert into BRANCH values('Camberwell', 'Camberwell VIC2451');

--TRANSACTION
create table BOOK_TRANSACTION
(TRANSACTION_ID number not null ,
BRANCH_ID varchar2 (100) not null ,
CUSTOMER_ID varchar2 (20) not null ,
BOOK_ID varchar2 (20) not null ,
TRANSACTION_DATE date ,
QUANTITY number) ;

alter table BOOK_TRANSACTION add constraint BOOK_TRANSACTION_PK primary key ( TRANSACTION_ID ) ;
alter table BOOK_TRANSACTION add constraint TRANSACTION_BOOK_FK foreign key ( BOOK_ID ) references BOOK ( BOOK_ID ) ;
alter table BOOK_TRANSACTION add constraint TRANSACTION_BRANCH_FK foreign key ( BRANCH_ID ) references BRANCH ( BRANCH_ID ) ; 
alter table BOOK_TRANSACTION add constraint TRANSACTION_CUSTOMER_FK foreign key ( CUSTOMER_ID ) references CUSTOMER ( CUSTOMER_ID ) ; 
create sequence BOOK_TRANSACTION_TRANSACTION_I start with 1 ; 

create or replace trigger BOOK_TRANSACTION_TRANSACTION_I 
before insert on BOOK_TRANSACTION 
for each row when (new.TRANSACTION_ID is null)
begin
:new.TRANSACTION_ID := BOOK_TRANSACTION_TRANSACTION_I.NEXTVAL; 
end;
/ 

insert into BOOK_TRANSACTION values(null, 'City', 'Cus1', 'C1', to_date('Mar 2008', 'Mon YYYY'), 2);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus2', 'C1', to_date('Mar 2008', 'Mon YYYY'), 3);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus2', 'H6', to_date('Mar 2008', 'Mon YYYY'), 10);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus3', 'H6', to_date('Mar 2008', 'Mon YYYY'), 5);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus3', 'DV', to_date('Mar 2008', 'Mon YYYY'), 10);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus4', 'DV', to_date('Mar 2008', 'Mon YYYY'), 13);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus4', 'C1', to_date('Mar 2008', 'Mon YYYY'), 10);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus5', 'C1', to_date('Mar 2008', 'Mon YYYY'), 5);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus4', 'H6', to_date('Mar 2008', 'Mon YYYY'), 3);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus3', 'DV', to_date('Mar 2008', 'Mon YYYY'), 2);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus3', 'C1', to_date('Mar 2008', 'Mon YYYY'), 1);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus2', 'H6', to_date('Mar 2008', 'Mon YYYY'), 1);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus1', 'DV', to_date('Mar 2008', 'Mon YYYY'), 2);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus4', 'C1', to_date('Dec 2007', 'Mon YYYY'), 10);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus3', 'C1', to_date('Dec 2007', 'Mon YYYY'), 5);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus2', 'H6', to_date('Dec 2007', 'Mon YYYY'), 5);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus2', 'H6', to_date('Dec 2007', 'Mon YYYY'), 1);
insert into BOOK_TRANSACTION values(null, 'City', 'Cus5', 'DV', to_date('Dec 2007', 'Mon YYYY'), 6);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus4', 'C1', to_date('Dec 2007', 'Mon YYYY'), 5);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus3', 'C1', to_date('Dec 2007', 'Mon YYYY'), 5);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus2', 'H6', to_date('Dec 2007', 'Mon YYYY'), 4);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus1', 'H6', to_date('Dec 2007', 'Mon YYYY'), 4);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus4', 'DV', to_date('Dec 2007', 'Mon YYYY'), 1);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus1', 'C1', to_date('Dec 2007', 'Mon YYYY'), 9);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus3', 'C1', to_date('Dec 2007', 'Mon YYYY'), 9);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus2', 'H6', to_date('Dec 2007', 'Mon YYYY'), 3);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus1', 'DV', to_date('Dec 2007', 'Mon YYYY'), 2);
insert into BOOK_TRANSACTION values(null, 'Chadstone', 'Cus4', 'DV', to_date('Dec 2007', 'Mon YYYY'), 1);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus1', 'C1', to_date('Dec 2007', 'Mon YYYY'), 9);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus3', 'C1', to_date('Dec 2007', 'Mon YYYY'), 9);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus2', 'H6', to_date('Dec 2007', 'Mon YYYY'), 3);
insert into BOOK_TRANSACTION values(null, 'Camberwell', 'Cus1', 'DV', to_date('Dec 2007', 'Mon YYYY'), 2);
commit;

select * from BOOK_TRANSACTION;

-- Part 2: Solution Model 1 - No bridge 
-- a. Create a dimension table called BOOK_DIM.
CREATE TABLE Book_DIM AS 
SELECT * FROM BOOK;

SELECT * FROM Book_DIM;

-- b. Create a dimension table called TIME_DIM. Year and Month are extracted from
-- Transaction Date.
CREATE TABLE Time_DIM AS 
SELECT DISTINCT TO_CHAR(Transaction_Date, 'MonYYYY') AS Time_ID, 
TO_CHAR(Transaction_Date, 'Mon') AS Month, 
TO_CHAR(Transaction_Date, 'YYYY') AS Year
FROM Book_Transaction;

SELECT * FROM Time_DIM;

-- c. Create a dimension table called BRANCH_DIM.
CREATE TABLE Branch_DIM AS 
SELECT * FROM Branch;

SELECT * FROM Branch_DIM;

-- d. Create fact table (called it BOOK_SALES_FACT1).
DROP TABLE Book_Sales_FACT1;
CREATE TABLE Book_Sales_FACT1 AS 
SELECT TO_CHAR(Transaction_Date, 'MonYYYY') AS Time_ID, 
Branch_ID, Book_ID, SUM(Quantity) AS Number_Of_Books_Sold
FROM Book_Transaction
GROUP BY TO_CHAR(Transaction_Date, 'MonYYYY'), 
-- remove the AS Time_ID to avoid error, GROUP BY is done before the SUM statement
Branch_ID, Book_ID;

SELECT * FROM Book_Sales_FACT1
WHERE Book_ID = 'H6'; 

-- e. Display (and observe) the contents of the fact table (BOOK_SALES_FACT1).

-- Part 3. Sution Model 2 - add a Temporal Bridge 
-- Book_Price is a temporal attribute 
-- this is SCD 4, which shows the complete record of the temporal attribute in a separate dimension 

-- a. Create a dimension table called BOOK_PRICE_DIM.
CREATE TABLE Book_Price_DIM AS 
SELECT * FROM Book_Price_history;

SELECT * FROM Book_Price_DIM;

-- b. Challenge: Create the �Correct Book Sale� Report as shown in Lecture 4 Notes page
-- 5/page 10. Hint: Use Case When to handle END_DATE = �Now�. (Don�t waste time on
-- this, you can come back to this task after finishing Task 3).
SELECT Time_ID, Branch_ID, F.Book_ID, Book_Title, Author, BP.Price, 
Number_Of_Books_Sold
FROM Book_Sales_FACT1 F, Book_DIM B, Book_Price_DIM BP
WHERE F.Book_ID = B.Book_ID
AND F.Book_ID = BP.Book_ID
AND TO_DATE(F.Time_ID, 'MonYYYY') >= TO_DATE(BP.Start_Date, 'MonYYYY')
AND TO_DATE(F.Time_ID, 'MonYYYY') <= 
CASE BP.End_Date 
    WHEN 'Now' THEN SYSDATE 
    ELSE TO_DATE(BP.End_Date, 'MonYYYY')
END
ORDER BY F.Time_ID DESC, Branch_ID DESC, Number_Of_Books_Sold ASC;

-- Part 4: Solution Model 3 - add a new Fact: Total Sales 
--a. Create a newFact table: BOOK_SALES_FACT2 by coping BOOK_SALES_FACT1.
CREATE TABLE Book_Sales_Fact2 AS 
SELECT * FROM Book_Sales_Fact1;

SELECT * FROM Book_Sales_Fact1;

-- b. AddColumnTOTAL_SALES (NUMBER) to BOOK_SALES_FACT2.
ALTER TABLE Book_Sales_Fact2
ADD Total_Sales NUMBER;

-- c. Use the PRICE_CURSOR (by selecting all data from BOOK_PRICE_DIM) to populate data
-- for column TOTAL_SALES in BOOK_SALES_FACT2. Pay attention to the current book price
-- in BOOK_PRICE_DIM, they will have END_DATE equals to �Now� instead of a normal date
-- (MonYYYY).
DECLARE 
    CURSOR Price_Cursor IS 
        SELECT * FROM Book_Price_DIM; 
    Valid_End_Date DATE;
BEGIN 
    FOR ITEM IN Price_Cursor LOOP 
        IF Item.End_Date = 'Now' THEN 
            Valid_End_Date := SYSDATE;
        ELSE 
            Valid_End_Date := TO_DATE(Item.End_Date, 'MonYYYY');
        END IF;

        UPDATE Book_Sales_FACT2
        SET Total_Sales = Number_Of_Books_Sold * Item.Price
        WHERE Book_ID = Item.Book_ID
        AND TO_DATE(Time_ID, 'MonYYYY') >= TO_DATE(Item.Start_Date, 'MonYYYY') 
        AND TO_DATE(Time_ID, 'MonYYYY') <= Valid_End_Date;
    END LOOP;
END;
/

SELECT * FROM Book_Sales_Fact2;

-- d. Challenge: Recreate BOOK_SALES_FACT2 without using Cursor.
CREATE TABLE Book_Sales_FACT3 AS
SELECT TO_CHAR(Transaction_Date, 'MonYYYY') AS Time_ID, 
Branch_ID, T.Book_ID, SUM(Quantity) AS Number_Of_Books_Sold, 
SUM(Quantity * Price) AS Total_Price
FROM Book_Transaction T, Book_Price_History BP
WHERE T.Book_ID = BP.Book_ID
AND Transaction_Date >= TO_DATE(BP.Start_Date, 'MonYYYY')
AND Transaction_Date <=
    CASE BP.End_Date 
        WHEN 'Now' THEN SYSDATE 
        ELSE TO_DATE(BP.End_Date, 'MonYYYY')
    END
GROUP BY TO_CHAR(Transaction_Date, 'MonYYYY'), Branch_ID, T.Book_ID;


