--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T2-tsa-select.sql

--Student ID: 33085625
--Student Name: Foo Kai Yan
--Unit Code: FIT2094
--Applied Class No: Tutorial #1 (Monday) 11:00 - 13:00

/* Comments for your marker:

2(a) COUNT(*)>1 because the question requirement to only show more than 1 POI
2(b) assumed that when there's a member_id then there is a recommendation done so recommendation_count increment by 1
2(c) used NVL as followed from Tutorials
2(d) COUNT(*) FROM tsa.review to get the total reviews and multiply by 100 to get percentage
2(e) used ROUND to round mc_total because that's looks like what the sample answer wanted
2(f) If understanding not wrong, geodistance with the latitude and longitude of the 2 towns as parameters gives the distance between the towns
2(f) used JOIN because need get 2 different towns' latitude and longitude

*/

/*2(a)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT 
    town_id, town_name, poi_type_id, poi_type_descr, COUNT(*) as poi_count
FROM 
    tsa.town NATURAL JOIN tsa.point_of_interest NATURAL JOIN tsa.poi_type 
GROUP BY 
    town_id, town_name, poi_type_id,poi_type_descr
HAVING COUNT(*) > 1
ORDER BY 
    town_id, poi_type_descr;

/*2(b)*/ 
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT 
    member_id, member_gname || ' ' || member_fname AS member_name, 
    resort_id, resort_name, recommendation_count
FROM tsa.member NATURAL JOIN tsa.review NATURAL JOIN tsa.resort NATURAL JOIN (
    SELECT member_id_recby AS member_id, COUNT(*) AS recommendation_count 
    FROM tsa.member
    WHERE member_id_recby IS NOT NULL
    GROUP BY member_id_recby
    HAVING COUNT (member_id_recby) = (
        SELECT MAX(recommendation_count) 
        FROM (
            SELECT member_id_recby AS member_id, 
                COUNT(*) AS recommendation_count
            FROM tsa.member
            WHERE member_id_recby IS NOT NULL 
            GROUP BY member_id_recby)))
WHERE member_id IN (
    SELECT member_id_recby FROM tsa.member)
GROUP BY 
    member_id, member_gname || ' ' || member_fname, 
    resort_id, resort_name, recommendation_count
ORDER BY 
    resort_id, member_id;

/*2(c)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT poi_id, poi_name, 
    NVL(TO_CHAR(MAX(review_rating), '0'), 'NR') AS max_rating,
    NVL(TO_CHAR(MIN(review_rating), '0'), 'NR') AS min_rating,
    NVL(TO_CHAR(AVG(review_rating), '0'), 'NR') AS avg_rating
FROM 
    tsa.point_of_interest NATURAL JOIN tsa.review
GROUP BY 
    poi_id, poi_name
ORDER BY 
    poi_id;
  
/*2(d)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT
    poi_name,
    poi_type_descr,
    town_name,
    'Lat: ' || TO_CHAR(town_lat, '999.999000') || ' Long: ' || TO_CHAR(town_long, '999.999000') AS town_location,
    COUNT(review_rating) AS completed_reviews,
    CASE WHEN COUNT(review_rating) = 0 THEN 'No reviews completed' 
    ELSE TO_CHAR(100 * COUNT(review_id) / (SELECT COUNT(*) FROM tsa.review ), '99.99') || '%' END AS reviews_percentage
FROM
    tsa.point_of_interest 
    NATURAL JOIN tsa.poi_type 
    NATURAL JOIN tsa.town 
    NATURAL JOIN tsa.review 
GROUP BY
    poi_name, poi_type_descr, town_name, town_lat, town_long
ORDER BY
    town_name, completed_reviews DESC, poi_name;

/*2(e)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT
    resort_id, resort_name, member_no,
    member_gname || ' ' || member_fname AS member_name,
    TO_CHAR(member_date_joined, 'dd-Mon-yyyy') AS members_date_joined,
    member_gname || ' ' || member_fname AS recommending_member,
    '$' || TO_CHAR(ROUND(mc_total), '9000') AS total_charges
FROM
    tsa.member NATURAL JOIN tsa.resort NATURAL JOIN tsa.member_charge
WHERE
    member_id_recby IS NOT NULL AND resort_id NOT IN (
        SELECT resort_id FROM tsa.resort NATURAL JOIN tsa.town
        WHERE UPPER(town_name) = UPPER('Byron Bay') 
        AND UPPER(town_state) = UPPER('NSW'))
    AND member_id IS NOT NULL 
    AND mc_total < ( 
        SELECT AVG(mc_total) 
        FROM tsa.member_charge 
        WHERE member_id = member_id)
ORDER BY
    resort_id,
    member_no;

/*2(f)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT
    r.resort_id, r.resort_name,
    poi.poi_name, 
    t.town_name AS poi_town, t.town_state AS poi_state,
    CASE
        WHEN TO_CHAR(poi.poi_open_time, 'dd-Mon-yyyy') IS NULL THEN 'Not Applicable'
        ELSE TO_CHAR(poi.poi_open_time, 'dd-Mon-yyyy')
    END AS poi_open_time,
    geodistance(t.town_lat, t.town_long, t2.town_lat, t2.town_long) AS distance
FROM
    tsa.resort r
    JOIN tsa.town t ON r.town_id = t.town_id
    JOIN tsa.point_of_interest poi ON t.town_id = poi.town_id
    JOIN tsa.town t2 ON poi.town_id = t2.town_id
WHERE
    geodistance(t.town_lat, t.town_long, t2.town_lat, t2.town_long) <= 100
ORDER BY
    r.resort_name,
    distance;


COMMIT;
