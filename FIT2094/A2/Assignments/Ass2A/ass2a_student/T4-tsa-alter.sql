--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-tsa-alter.sql

--Student ID: 33085625
--Student Name: Foo Kai Yan
--Unit Code: FIT2094
--Applied Class No: Tutorial #1 (Monday) 11:00 - 13:00

/* Comments for your marker:
4(c) cleaning_start_time and cleaning_end_time is expected to be recorded as 24-hour clock format 
     (eg. 0000 for 12:00am, 2359 for 11:59pm)


*/

--4(a)
--Add a new attribute which will record the total number of booking for each cabin
ALTER TABLE cabin ADD total_bookings NUMBER(4) DEFAULT 0;

--Update the new attribute
UPDATE cabin 
SET total_bookings = (
    SELECT COUNT(*) FROM booking 
    WHERE booking.cabin_no = cabin.cabin_no
    AND booking.resort_id = cabin.resort_id);

--Show changes made by arranging and showing the cabin table in cabin number ascending order
SELECT * FROM cabin ORDER BY cabin_no;

COMMIT;


--4(b)
--To answer the question, a table named staff_role_responsibility was created to record the role and responsibility of a staff
--DROP statement was added for table staff_role_responsibility
DROP TABLE staff_role_responsibility CASCADE CONSTRAINTS PURGE;

--staff_role_responsibility
CREATE TABLE staff_role_responsibility (
    role_id                    CHAR(1)       NOT NULL,
    role_name                  VARCHAR2(50)  NOT NULL,
    job_description            VARCHAR2(250) NOT NULL
);

COMMENT ON COLUMN staff_role_responsibility.role_id IS
    'Character to identify the role of the staff';
    
COMMENT ON COLUMN staff_role_responsibility.role_name IS
    'Staff''s role name';
    
COMMENT ON COLUMN staff_role_responsibility.job_description IS
    'Basic description on the staff''s job scope';

ALTER TABLE staff_role_responsibility ADD CONSTRAINT staff_role_responsibility_pk PRIMARY KEY (role_id);

--Insert the current roles present for the staff
INSERT INTO staff_role_responsibility VALUES ('A', 'Admin', 'Take bookings and reply to customer inquiries');
INSERT INTO staff_role_responsibility VALUES ('C', 'Cleaning', 'Clean cabins and maintain resort''s public area');
INSERT INTO staff_role_responsibility VALUES ('M', 'Marketing', 'Prepare and present marketing ideas and deliverables');

--Show changes made by arranging and showing staff_role_responsibility table in ascending order
SELECT * FROM staff_role_responsibility ORDER BY role_id;

--New column named role_id was added to staff table to link each staff with a role
--The role of all the present staff is set to 'A' which is Admin
ALTER TABLE staff ADD role_id CHAR(1);
UPDATE staff SET role_id = 'A';

--Show changes made by arranging and showing staff table in staff id ascending order
SELECT * FROM staff ORDER BY staff_id;

COMMIT;


--4(c)
--To answer the question, a table named staff_cleaning_schedule was created to record the staff's cleaning schedule
--DROP statement was added for table staff_cleaning_schedule
DROP TABLE staff_cleaning_schedule CASCADE CONSTRAINTS PURGE;
CREATE TABLE staff_cleaning_schedule (
    staff_id                   NUMBER(5) NOT NULL,
    role_id                    CHAR(1)   DEFAULT 'C',
    cabin_no                   NUMBER(3) NOT NULL,
    cleaning_date              DATE      NOT NULL,
    cleaning_start_time        NUMBER(4),
    cleaning_end_time          NUMBER(4)
);

COMMENT ON COLUMN staff_cleaning_schedule.staff_id IS
    'Staff identifier of staff member who cleaned';
    
COMMENT ON COLUMN staff_cleaning_schedule.role_id IS
    'Character to identify the role of the staff';
    
COMMENT ON COLUMN staff_cleaning_schedule.cabin_no IS
    'Cabin identifier of which cabin was cleaned';
    
COMMENT ON COLUMN staff_cleaning_schedule.cleaning_date IS
    'The date when the cabin was cleaned';
    
COMMENT ON COLUMN staff_cleaning_schedule.cleaning_start_time IS
    'The starting time when the cabin was cleaned';
    
COMMENT ON COLUMN staff_cleaning_schedule.cleaning_end_time IS
    'The ending time when the cabin was cleaned';
    
ALTER TABLE staff_cleaning_schedule ADD CONSTRAINT staff_cleaning_schedule_pk PRIMARY KEY (cabin_no, staff_id, role_id);
ALTER TABLE staff_cleaning_schedule ADD CONSTRAINT cabin_cleaning_schedule_fk FOREIGN KEY (cabin_no) REFERENCES cabin (cabin_no);
ALTER TABLE staff_cleaning_schedule ADD CONSTRAINT staff_cleaning_schedule_fk FOREIGN KEY (staff_id) REFERENCES staff (staff_id);
ALTER TABLE staff_cleaning_schedule ADD CONSTRAINT role_cleaning_schedule_fk FOREIGN KEY (role_id) REFERENCES staff_role_responsibility (role_id);
-- Line 100 and 102 error due to missing primary key

--Show changes made by arranging and showing staff table in staff id ascending order
SELECT * FROM staff_cleaning_schedule ORDER BY staff_id;

COMMIT;