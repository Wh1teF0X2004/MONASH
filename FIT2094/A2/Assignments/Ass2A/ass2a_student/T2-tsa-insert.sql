/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T2-tsa-insert.sql

--Student ID: 33085625
--Student Name: Foo Kai Yan
--Unit Code: FIT2094
--Applied Class No: Tutorial #1 (Monday) 11:00 - 13:00

/* Comments for your marker:




*/

---**This command shows the outputs of triggers**---
---**Run the command before running the insert statements.**---
---**Do not remove**---
SET SERVEROUTPUT ON
---**end**---

---- Select all the current unique members from the member table
--SELECT DISTINCT * FROM member;

---- Select all the current unique resorts from the resort table
--SELECT DISTINCT * FROM resort;

---- Select all the current unique resorts from the resort table
--SELECT DISTINCT * FROM staff;

--------------------------------------
--INSERT INTO cabin
--------------------------------------
--Resort1: 1
INSERT INTO cabin VALUES 
(11, 1, 1, 'I', 50, 'The cabin has 1 bedroom with a queen sized bed, an inside cabin bathroom, a spacious living room, an open-air balcony and an airy kitchen', 1);
--Resort1: 2
INSERT INTO cabin VALUES 
(12, 2, 2, 'C', 55, 'The cabin has 2 bedroom each with a queen sized bed, an outside common bathroom, a spacious living room, an open-air balcony and an airy kitchen', 1);
--Resort1: 3
INSERT INTO cabin VALUES 
(13, 2, 2, 'I', 60, 'The cabin has 2 bedroom each with a queen sized bed, an inside cabin bathroom, a spacious living room, an open-air balcony and an airy kitchen', 1);
--Resort1: 4
INSERT INTO cabin VALUES 
(14, 3, 3, 'C', 65, 'The cabin has 3 bedroom each with a queen sized bed, an outside common bathroom, a spacious living room, an open-air balcony and an airy kitchen', 1);
--Resort1: 5
INSERT INTO cabin VALUES 
(15, 4, 4, 'I', 80, 'The cabin has 4 bedroom each with a king sized bed, an inside cabin bathroom, a spacious living room, an open-air balcony and an airy kitchen', 1);

--Resort2: 1
INSERT INTO cabin VALUES 
(21, 1, 1, 'I', 30, 'The cabin has 1 bedroom with a single sized bed, an inside cabin bathroom, a spacious living room, an open-air balcony and a miniature kitchen', 2);
--Resort2: 2
INSERT INTO cabin VALUES 
(22, 2, 2, 'C', 30, 'The cabin has 2 bedroom each with a single sized bed, an outside common bathroom, a spacious living room, an open-air balcony and a miniature kitchen', 2);
--Resort2: 3
INSERT INTO cabin VALUES 
(23, 2, 2, 'I', 35, 'The cabin has 2 bedroom each with a super-single sized bed, an inside cabin bathroom, a spacious living room, an open-air balcony and a miniature kitchen', 2);
--Resort2: 4
INSERT INTO cabin VALUES 
(24, 3, 3, 'C', 40, 'The cabin has 3 bedroom each with a single sized bed, an outside common bathroom, a spacious living room, an open-air balcony and a miniature kitchen', 2);
--Resort2: 5
INSERT INTO cabin VALUES 
(25, 4, 4, 'I', 45, 'The cabin has 4 bedroom each with a super-single sized bed, an inside cabin bathroom, a spacious living room, an open-air balcony and a miniature kitchen', 2);

--Resort3: 1
INSERT INTO cabin VALUES 
(31, 1, 1, 'I', 45, 'The cabin has 1 bedroom with a single sized bed, an inside cabin bathroom, a spacious living room, a miniature balcony and a kitchen', 3);
--Resort3: 2
INSERT INTO cabin VALUES 
(32, 1, 1, 'C', 40, 'The cabin has 1 bedroom with a single sized bed, an outside common bathroom, a spacious living room, a miniature balcony and a kitchen', 3);
--Resort3: 3
INSERT INTO cabin VALUES 
(33, 2, 2, 'I', 50, 'The cabin has 2 bedroom each with a super-single sized bed, an inside cabin bathroom, a spacious living room, a miniature balcony and a kitchen', 3);
--Resort3: 4
INSERT INTO cabin VALUES 
(34, 3, 3, 'I', 50, 'The cabin has 3 bedroom each with a super-single sized bed, an inside cabin bathroom, a spacious living room, a miniature balcony and a kitchen', 3);
--Resort3: 5
INSERT INTO cabin VALUES 
(35, 4, 4, 'I', 60, 'The cabin has 4 bedroom each with a super-single sized bed, an inside cabin bathroom, a spacious living room, a miniature balcony and a kitchen', 3);

--Resort4: 1
INSERT INTO cabin VALUES 
(41, 2, 2, 'I', 40, 'The cabin has 2 bedroom each with a queen sized bed, an inside cabin bathroom, a spacious living room, an indoor sauna and an airy kitchen', 4);
--Resort4: 2
INSERT INTO cabin VALUES 
(42, 4, 4, 'I', 50, 'The cabin has 4 bedroom each with a queen sized bed, an inside cabin bathroom, a spacious living room, an indoor sauna and an airy kitchen', 4);

--Resort5: 1
INSERT INTO cabin VALUES 
(51, 2, 2, 'I', 40, 'The cabin has 2 bedroom each with a king sized bed, an inside cabin bathroom, a spacious living room, an indoor jacuzzi and an airy kitchen', 5);
--Resort5: 2
INSERT INTO cabin VALUES 
(52, 2, 2, 'C', 50, 'The cabin has 2 bedroom each with a king sized bed, an outside common bathroom, a spacious living room, an indoor jacuzzi and an airy kitchen', 5);

--Resort6: 1
INSERT INTO cabin VALUES 
(61, 1, 1, 'I', 60, 'The cabin has 1 bedroom with a king sized bed, an inside cabin bathroom, a spacious living room, an indoor personal gym and an airy kitchen', 6);

--Resort7: 1
INSERT INTO cabin VALUES 
(70, 1, 1, 'I', 50, 'The cabin has 1 bedroom with a single sized bed, an inside cabin bathroom, a spacious living room and a kitchen', 7);
--Resort7: 2
INSERT INTO cabin VALUES 
(71, 1, 1, 'C', 50, 'The cabin has 1 bedroom with a single sized bed, an outside common bathroom, a small living room and a kitchen', 7);
--Resort7: 3
INSERT INTO cabin VALUES 
(72, 1, 1, 'I', 50, 'The cabin has 1 bedroom with a single sized bed, an inside cabin bathroom, a small living room and a kitchen', 7);
--Resort7: 4
INSERT INTO cabin VALUES 
(73, 1, 1, 'C', 50, 'The cabin has 1 bedroom with a single sized bed, an outside common bathroom and a small living room', 7);
--Resort7: 5
INSERT INTO cabin VALUES 
(74, 1, 2, 'I', 60, 'The cabin has 1 bedroom with two single sized bed, an inside cabin bathroom, a spacious living room and a kitchen', 7);
--Resort7: 6
INSERT INTO cabin VALUES 
(75, 1, 2, 'C', 60, 'The cabin has 1 bedroom with a queen sized bed, an outside common bathroom, a spacious living room and a kitchen', 7);
--Resort7: 7
INSERT INTO cabin VALUES 
(76, 1, 2, 'I', 65, 'The cabin has 1 bedroom with a queen sized bed, an inside cabin bathroom, a small living room and a kitchen', 7);
--Resort7: 8
INSERT INTO cabin VALUES 
(77, 1, 2, 'C', 65, 'The cabin has 1 bedroom with a queen sized bed, an outside common bathroom and a spacious living room', 7);
--Resort7: 9
INSERT INTO cabin VALUES 
(78, 2, 3, 'I', 70, 'The cabin has 2 bedroom each with a queen sized bed, an inside cabin bathroom, a spacious living room and a kitchen', 7);
--Resort7: 10
INSERT INTO cabin VALUES 
(79, 2, 4, 'I', 75, 'The cabin has 2 bedroom each with a king sized bed, an inside cabin bathroom, a spacious living room and a kitchen', 7);

--Resort8: 1
INSERT INTO cabin VALUES 
(81, 2, 2, 'C', 80, 'The cabin has 2 bedroom each with a super-king sized bed, an outside common bathroom, a personal sauna, a spacious living room and a huge kitchen', 8);

--Resort9: 1
INSERT INTO cabin VALUES 
(91, 2, 2, 'C', 80, 'The cabin has 2 bedroom each with a super-queen sized bed, an outside common bathroom, a personal jacuzzi, a spacious living room and a huge kitchen', 9);

--Resort10: 1
INSERT INTO cabin VALUES 
(1, 1, 1, 'I', 65, 'The cabin has 1 bedroom with a single sized bed, an inside cabin bathroom, a spacious living room, a balcony and a kitchen', 10);
--Resort10: 2
INSERT INTO cabin VALUES 
(2, 1, 1, 'C', 60, 'The cabin has 1 bedroom with a single sized bed, an outside common bathroom, a small living room, a balcony and a kitchen', 10);
--Resort10: 3
INSERT INTO cabin VALUES 
(3, 1, 1, 'I', 65, 'The cabin has 1 bedroom with a single sized bed, an inside cabin bathroom, a small living room, a balcony and a kitchen', 10);
--Resort10: 4
INSERT INTO cabin VALUES 
(4, 1, 1, 'C', 60, 'The cabin has 1 bedroom with a single sized bed, an outside common bathroom, a small living room and a balcony', 10);
--Resort10: 5
INSERT INTO cabin VALUES 
(5, 1, 2, 'I', 75, 'The cabin has 1 bedroom with a queen sized bed, an inside cabin bathroom, a spacious living room, a balcony and a kitchen', 10);
--Resort10: 6
INSERT INTO cabin VALUES 
(6, 1, 2, 'C', 70, 'The cabin has 1 bedroom with a queen sized bed, an outside common bathroom, a spacious living room, a balcony and a kitchen', 10);
--Resort10: 7
INSERT INTO cabin VALUES 
(7, 1, 2, 'I', 75, 'The cabin has 1 bedroom with a queen sized bed, an inside cabin bathroom, a small living room and a kitchen', 10);
--Resort10: 8
INSERT INTO cabin VALUES 
(8, 1, 2, 'C', 72, 'The cabin has 1 bedroom with a queen sized bed, an outside common bathroom, a spacious living room and a balcony', 10);
--Resort10: 9
INSERT INTO cabin VALUES 
(9, 2, 3, 'I', 80, 'The cabin has 2 bedroom each with a queen sized bed, an inside cabin bathroom, a spacious living room, a balcony and a kitchen', 10);
--Resort10: 10
INSERT INTO cabin VALUES 
(10, 2, 4, 'I', 85, 'The cabin has 2 bedroom each with a king sized bed, an inside cabin bathroom, a spacious living room and a kitchen', 10);

COMMIT;
--------------------------------------
--INSERT INTO booking
--------------------------------------
-- 10 cabins in 5 different resorts (at least 3 of these cabins must be booked at least three times)
-- 10 different members (at least 3 of these members have more than one booking)

-- Cabin 204, booked 5 times
INSERT INTO booking VALUES (1, TO_DATE('1-Mar-2023','dd-Mon-yyyy'), TO_DATE('3-Mar-2023','dd-Mon-yyyy'), 2, 2, 90, 2, 7, 3, 25);
INSERT INTO booking VALUES (2, TO_DATE('4-Mar-2023','dd-Mon-yyyy'), TO_DATE('7-Mar-2023','dd-Mon-yyyy'), 2, 1, 135, 2, 4, 4, 25);
INSERT INTO booking VALUES (3, TO_DATE('8-Mar-2023','dd-Mon-yyyy'), TO_DATE('10-Mar-2023','dd-Mon-yyyy'), 2, 2, 90, 2, 7, 3, 25);
INSERT INTO booking VALUES (4, TO_DATE('15-Mar-2023','dd-Mon-yyyy'), TO_DATE('17-Mar-2023','dd-Mon-yyyy'), 2, 1, 90, 2, 4, 4, 25);
INSERT INTO booking VALUES (5, TO_DATE('18-Mar-2023','dd-Mon-yyyy'), TO_DATE('20-Mar-2023','dd-Mon-yyyy'), 2, 2, 90, 2, 7, 3, 25);

-- 10 different members from 9 different resorts
INSERT INTO booking VALUES (11, TO_DATE('10-Mar-2023','dd-Mon-yyyy'), TO_DATE('12-Mar-2023','dd-Mon-yyyy'), 1, 0, 100, 1, 2, 1, 11);
INSERT INTO booking VALUES (12, TO_DATE('11-Mar-2023','dd-Mon-yyyy'), TO_DATE('12-Mar-2023','dd-Mon-yyyy'), 1, 0, 30, 2, 7, 4, 21);
INSERT INTO booking VALUES (13, TO_DATE('12-Mar-2023','dd-Mon-yyyy'), TO_DATE('13-Mar-2023','dd-Mon-yyyy'), 1, 0, 45, 3, 10, 7, 31);
INSERT INTO booking VALUES (14, TO_DATE('15-Mar-2023','dd-Mon-yyyy'), TO_DATE('17-Mar-2023','dd-Mon-yyyy'), 1, 0, 40, 4, 3, 8, 41);
INSERT INTO booking VALUES (15, TO_DATE('16-Mar-2023','dd-Mon-yyyy'), TO_DATE('18-Mar-2023','dd-Mon-yyyy'), 1, 0, 40, 5, 13, 10, 51);
INSERT INTO booking VALUES (16, TO_DATE('19-Mar-2023','dd-Mon-yyyy'), TO_DATE('20-Mar-2023','dd-Mon-yyyy'), 1, 0, 60, 6, 21, 11, 61);
INSERT INTO booking VALUES (17, TO_DATE('21-Mar-2023','dd-Mon-yyyy'), TO_DATE('22-Mar-2023','dd-Mon-yyyy'), 1, 0, 50, 7, 1, 13, 70);
INSERT INTO booking VALUES (18, TO_DATE('22-Mar-2023','dd-Mon-yyyy'), TO_DATE('24-Mar-2023','dd-Mon-yyyy'), 1, 0, 160, 8, 15, 15, 81);
INSERT INTO booking VALUES (19, TO_DATE('25-Mar-2023','dd-Mon-yyyy'), TO_DATE('27-Mar-2023','dd-Mon-yyyy'), 1, 0, 160, 9, 23, 17, 91);
INSERT INTO booking VALUES (27, TO_DATE('27-Mar-2023','dd-Mon-yyyy'), TO_DATE('29-Mar-2023','dd-Mon-yyyy'), 1, 0, 100, 7, 5, 14, 71);

-- Cabin 707, booked 3 times
INSERT INTO booking VALUES (21, TO_DATE('1-Mar-2023','dd-Mon-yyyy'), TO_DATE('3-Mar-2023','dd-Mon-yyyy'), 1, 0, 130, 7, 1, 13, 77);
INSERT INTO booking VALUES (22, TO_DATE('4-Mar-2023','dd-Mon-yyyy'), TO_DATE('6-Mar-2023','dd-Mon-yyyy'), 1, 0, 130, 7, 5, 14, 77);
INSERT INTO booking VALUES (23, TO_DATE('8-Mar-2023','dd-Mon-yyyy'), TO_DATE('10-Mar-2023','dd-Mon-yyyy'), 1, 0, 130, 7, 6, 13, 77);

-- Cabin 501, booked 3 times
INSERT INTO booking VALUES (31, TO_DATE('1-Apr-2023','dd-Mon-yyyy'), TO_DATE('2-Apr-2023','dd-Mon-yyyy'), 2, 0, 50, 5, 13, 10, 52);
INSERT INTO booking VALUES (32, TO_DATE('4-Apr-2023','dd-Mon-yyyy'), TO_DATE('7-Apr-2023','dd-Mon-yyyy'), 2, 0, 150, 5, 24, 10, 52);
INSERT INTO booking VALUES (33, TO_DATE('18-Apr-2023','dd-Mon-yyyy'), TO_DATE('20-Apr-2023','dd-Mon-yyyy'), 2, 0, 100, 5, 13, 10, 52);

COMMIT;