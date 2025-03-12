/*
Databases Week 12 Tutorial Class
week12_bigdata.sql

student id: 33085625
student name: Foo Kai Yan
last modified date: 22052023

*/
SET PAGESIZE 200
SELECT
    JSON_OBJECT ( '_id' VALUE stuid, 'name' VALUE stufname
    || ' '
    || stulname,
        'contactInfo' VALUE JSON_OBJECT (
        'address' VALUE stuaddress,
        'phone' VALUE rtrim(stuphone),
        'email' VALUE stuemail
    ),
    'enrolmentInfo' VALUE JSON_ARRAYAGG(
        JSON_OBJECT(
            'unitcode' VALUE unitcode,
            'unitname' VALUE unitname,
            'year' VALUE to_char(ofyear, 'yyyy'),
            'semester' VALUE ofsemester,
            'mark' VALUE enrolmark,
            'grade' VALUE enrolgrade
        )
    ) FORMAT JSON )
    || ','
FROM
    uni.student
    NATURAL JOIN uni.enrolment
    NATURAL JOIN uni.unit
GROUP BY
    stuid,
    stufname,
    stulname,
    stuaddress,
    stuphone,
    stuemail
ORDER BY
    stuid;
    
/*
12.1.2 MongoDB Create Update and Delete
1. Use an SQL select statement to generate a collection of documents 
using the following structure/format from the UNI database.
*/