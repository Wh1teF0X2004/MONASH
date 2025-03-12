--Comment out SET ECHO and SPOOL commands before submitting your portfolio
--SET ECHO ON
--SPOOL sql_portfolio1_output.txt

--****PLEASE ENTER YOUR DETAILS BELOW****
--sql_portfolio1.sql

--Student ID: 33085625
--Student Name: Foo Kai Yan
--Unit Code: FIT2094
--Tutorial Class No: 


/*Task 1: CREATE table POLICY and non FK constraints*/
DROP TABLE policy CASCADE CONSTRAINTS PURGE;

CREATE TABLE policy (
    policy_id NUMBER(4) NOT NULL,
    policy_startdate DATE NOT NULL,
    policy_length NUMBER(4) NOT NULL,
    prop_no NUMBER(4) NOT NULL,
    policy_type_code CHAR(1) NOT NULL,
    insurer_code CHAR(3) NOT NULL
);

COMMENT ON COLUMN policy.policy_id IS
    'Policy unique identifier';

COMMENT ON COLUMN policy.policy_startdate IS
    'Policy start date';
    
COMMENT ON COLUMN policy.policy_length IS
    'Length of the policy in months';

ALTER TABLE policy ADD CONSTRAINT uq_pol_id UNIQUE (policy_id);

ALTER TABLE policy ADD CONSTRAINT ck_pol_len CHECK (policy_length >= 6);

/*Task 1: Add FK constraints*/
ALTER TABLE policy ADD CONSTRAINT prop_pol_fk FOREIGN KEY (prop_no) REFERENCES property (prop_no); 

ALTER TABLE policy ADD CONSTRAINT poltype_pol_fk FOREIGN KEY (policy_type_code) REFERENCES policy_type (policy_type_code);

ALTER TABLE policy ADD CONSTRAINT inscode_pol_fk FOREIGN KEY (insurer_code) REFERENCES insurer (insurer_code); 

/*Task 2*/
INSERT INTO policy VALUES 
(0001, to_date('21-Apr-2023','dd-Mon-yyyy'), 12, 7145, upper('B'), upper('LAS'));

INSERT INTO policy VALUES 
(0002, to_date('21-Apr-2023','dd-Mon-yyyy'), 12, 9346, upper('B'), upper('LAS'));

commit;

/*Task 3*/
INSERT INTO policy VALUES 
(0003, to_date('1-May-2023','dd-Mon-yyyy'), 6, 7145, upper('B'), upper('LAS'));

INSERT INTO policy VALUES 
(0004, to_date('1-May-2023','dd-Mon-yyyy'), 12, 7145, upper('C'), upper('LAS'));

commit;

/*Task 4*/
DELETE FROM policy WHERE policy_startdate = to_date('1-May-2023','dd-Mon-yyyy') and prop_no = 7145;

commit;

--Comment out SET ECHO and SPOOL commands before submitting your portfolio
--SPOOL OFF
--SET ECHO OFF