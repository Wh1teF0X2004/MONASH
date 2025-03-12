--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-tsa-dm.sql

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

--3(a)
-- Drop the booking sequence 
DROP SEQUENCE booking_seq;

-- Create the sequence for booking
CREATE SEQUENCE booking_seq START WITH 100 INCREMENT BY 10;

COMMIT;


--3(b)
INSERT INTO cabin VALUES (
    4, 
    4,
    10,
    'I', 
    220, 
    'The cabin has 4 bedroom with an inside cabin bathroom that can have a capacity of 10 people',
    (SELECT resort_id FROM resort 
        WHERE UPPER(resort_name) = UPPER('Awesome Resort') AND 
        town_id = (SELECT town_id FROM town WHERE UPPER(town_name) = UPPER('Broome'))));

COMMIT;


--3(c)
INSERT INTO booking VALUES (
    booking_seq.NEXTVAL,
    TO_DATE('26-May-2023','dd-Mon-yyyy'),
    TO_DATE('28-May-2023','dd-Mon-yyyy'),
    4,
    4,
    440,
    (SELECT resort_id FROM resort 
        WHERE UPPER(resort_name) = UPPER('Awesome Resort') AND 
        town_id = (SELECT town_id FROM town WHERE UPPER(town_name) = UPPER('Broome'))), 
    18, 
    (SELECT staff_id FROM staff WHERE staff_gname = 'Reeba' AND staff_fname = 'Wildman' AND staff_phone = 0493427245),
    4
);

COMMIT;


--3(d)
UPDATE booking
SET booking_to = TO_DATE('29-May-2023','dd-Mon-yyyy'), booking_total_points_cost = 660
WHERE member_id = 18 AND 
    cabin_no = 4 AND 
    booking_from = TO_DATE('26-May-2023','dd-Mon-yyyy') AND 
    booking_noadults = 4 AND 
    booking_nochildren = 4 AND
    resort_id = (SELECT resort_id FROM resort 
                    WHERE UPPER(resort_name) = UPPER('Awesome Resort') AND 
                    town_id = (SELECT town_id FROM town WHERE UPPER(town_name) = UPPER('Broome'))) AND
    staff_id = (SELECT staff_id FROM staff WHERE staff_gname = 'Reeba' AND staff_fname = 'Wildman' AND staff_phone = 0493427245);

COMMIT;


--3(e) 
-- Remove from booking
DELETE FROM booking 
WHERE resort_id = (SELECT resort_id FROM resort 
                        WHERE UPPER(resort_name) = UPPER('Awesome Resort') AND 
                        town_id = (SELECT town_id FROM town WHERE UPPER(town_name) = UPPER('Broome'))) AND 
    cabin_no = 4 AND 
    booking_id = (SELECT booking_id FROM booking WHERE cabin_no = 4);

-- Remove from cabin
DELETE FROM cabin 
WHERE resort_id = (SELECT resort_id FROM resort 
                        WHERE UPPER(resort_name) = UPPER('Awesome Resort') AND 
                        town_id = (SELECT town_id FROM town WHERE UPPER(town_name) = UPPER('Broome'))) AND 
    cabin_no = 4;

COMMIT;