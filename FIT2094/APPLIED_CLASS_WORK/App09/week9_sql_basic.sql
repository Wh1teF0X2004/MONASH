/*
Databases Week 9 Tutorial Class
week9_sql_basic.sql

student id: 33085625
student name: FOO KAI YAN
applied class number: T01
last modified date:

*/

/* Part A - Retrieving data from a single table */

-- A1
select unitcode, unitname, unitdesc from uni.unit order by unitcode;

-- A2
select stuid, stulname, stufname, to_char(studob, 'dd-Mon-yyyy') as studob, stuaddress, stuphone, stuemail 
from uni.student where upper(stuaddress) like upper('%Caulfield') order by stuid;

-- A3
select stuid, stufname, stulname, to_char(studob, 'dd-Mon-yyyy') as studob, stuaddress, stuphone, stuemail 
from uni.student
where upper(stulname) like upper('M%')
order by stuid;

-- A4
select stuid, stufname, stulname, to_char(studob, 'dd-Mon-yyyy') as studob, stuaddress, stuphone, stuemail 
from uni.student
where upper(stulname) like upper('S%') and upper(stufname) like upper('%i%')
order by stuid;

-- A5
select unitcode, unitname, unitdesc 
from uni.unit
where unitcode like upper('FIT1%')
order by unitcode;

-- A6
select unitcode, ofsemester
from uni.offering
where to_char(ofyear, 'yyyy') = 2021
order by unitcode;

-- A7
select unitcode, ofsemester, to_char(ofyear, 'yyyy') as ofyear
from uni.offering
where to_char(ofyear, 'yyyy') in (2020, 2019) and ofsemester = 2
order by ofyear, ofsemester, unitcode;

-- A8
select stuid, to_char(ofyear, 'yyyy') as ofyear, ofsemester, enrolgrade
from uni.enrolment
where to_char(ofyear, 'yyyy') in (2021) and ofsemester = 2 and upper(enrolgrade) = upper('N')
order by stuid, unitcode;

-- A9
select stuid, to_char(ofyear, 'yyyy') as ofyear, ofsemester, enrolgrade, unitcode, enrolmark
from uni.enrolment
where to_char(ofyear, 'yyyy') in (2020) and ofsemester = 1 and upper(enrolgrade) is null and upper(unitcode) = upper('FIT3176') and upper(enrolmark) is null
order by stuid;

/* Part B - Retrieving data from multiple tables */

-- B1
select unitcode, ofsemester, stafffname || ' ' || stafflname as "chief examiner"
from uni.staff join uni.offering using(staffid)
where to_char(ofyear, 'yyyy') = 2021
order by ofsemester, unicode;

-- B2


-- B3


-- B4


-- B5


-- B6


-- B7


-- B8


-- B9


-- B10
