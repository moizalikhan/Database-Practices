select * from city
where CountryCode = 'USA' And population > 100000;

select name from city where CountryCode = 'USA'
and population > 120000;

Select * from City;

select id, name, countrycode, district, 
population from city where id = '1661';

select id, name, countrycode, district, 
population from city where countrycode = 'JPN' 

select name from city where countrycode = 'JPN'

select city, state from station;

select distinct city from station where id % 2 = 0;


select top 1 city, min(len(city)) from station group by
city order by min(len(city))
select top 1 city, max(len(city)) from station group by
city order by max(len(city)) desc

select distinct city from station where (city like 'a%'
                                         or city like 'e%'
                                         or city like 'i%'
                                         or city like 'o%'
                                         or city like 'u%');

select distinct city from station where city
like '%a' or city like '%e' or city like
'%i' or city like '%o' or city like '%u';

select distinct city from station where
(city like 'a%' or city like 'e%' or city like 'i%' or city like 'o%' 
or city like 'u%') and (city like '%a' or city like '%e' or city like '%i'
or city like '%o' or city like '%u') order by city

select distinct city from station where
 city not like 'a%' and city not like 'e%' and
  city not like 'i%' and city not like 'o%' and
   city not like 'u%'; 

select distinct city from station where
 city not like '%a' and city not like '%e' and
  city not like '%i' and city not like
   '%o' and city not like '%u';

select distinct city from station where
 (city not like 'a%' and city not like 'e%' and
  city not like 'i%' and city not like 'o%' and city not like 'u%')
   or (city not like '%a' and city not like '%e' and city not like '%i'
    and city not like '%o' and city not like '%u');

select distinct city from station where
 (city not like 'a%' and city not like 'e%' and
  city not like 'i%' and city not like 'o%' and city not like 'u%')
and (city not like '%a' and city not like
 '%e' and city not like '%i' and city not like
  '%o' and city not like '%u');

select name from students
where marks>75 
order by
 Right(name,3), id asc

select name from employee order by name;

select  name from employee where salary>2000 and months <10;

SELECT CASE
WHEN (A + B <= C) OR (B+C <= A) OR (A+C <= B) THEN "Not A Triangle" 
WHEN (A=B) AND (B=C) THEN "Equilateral"
WHEN (A=B) OR (C=A) OR (B=C) THEN "Isosceles" 
ELSE "Scalene" 
END 
FROM TRIANGLES

select Concat(name,'(',SUBSTRING (occupation, 1 , 1 ),')')
from occupations order by name asc
select "There are a total of",count(*),concat(lower(occupation),'s','.')
from occupations group by occupation order by count(*) asc


WITH DOCTOR AS (
    SELECT name,
    ROW_NUMBER() OVER(order by name) as rownum
    FROM occupations
    WHERE occupation LIKE 'Doctor')
, Professor AS (
    SELECT name,
    ROW_NUMBER() OVER(order by name) as rownum
    FROM occupations
    WHERE occupation LIKE 'Professor')
, Singer AS (
    SELECT name,
    ROW_NUMBER() OVER(order by name) as rownum
    FROM occupations
    WHERE occupation LIKE 'Singer')
, Actor AS (
    SELECT name,
    ROW_NUMBER() OVER(order by name) as rownum
    FROM occupations
    WHERE occupation LIKE 'Actor')
select Doctor.name,Professor.name,Singer.name,Actor.name
from professor
left join Doctor on doctor.rownum = professor.rownum
left join Singer on Singer.rownum = professor.rownum
left join Actor on Actor.rownum = professor.rownum

select count(id) from city where population > 100000;

select sum(population) from city where district = 'California';

select avg(population) from city where district = 'california'

select round(avg(population),1) from city;

select sum(population) from city where countrycode = 'JPN'

-- Subquery
select max(population)- (select min(population) from city) from city

select cast(
    ceiling(
        avg(cast(salary as float)) - avg(cast(replace(salary, '0', '')
         as float))
        )
        as int) 
from employees

select max(months*salary), count(*)from
employee group by months*salary desc limit 1

select cast(round(sum(lat_n),2)AS DECIMAL(10,2)),
cast(round(sum(long_w),2)AS DECIMAL(10,2))from station

select Cast(Sum(lat_n) as Decimal(10,4)) from
station where lat_n between 38.7880 and 137.2345

select cast(max(lat_n)as Decimal(10,4)) from
station where lat_n <137.2345

select cast(max(long_w)as decimal(10,4)) from
 station where lat_n =(select max(lat_n) from station where lat_n<137.2345)

select cast(min(lat_n) as decimal(10,4)) from station where lat_n>38.7780

select cast(long_w as decimal(10,4)) from
 station where lat_n = (select min(lat_n) from station where lat_n>38.7780)

select cast(
--  sqrt(
--      power(
            max(lat_n)-min(lat_n)
--          ,2)
        + 
--      power(
            max(long_w)-min(long_w)
--          ,2)
--     )
        as decimal(10,4))
        from station

select cast(
      sqrt(
        power(
            max(lat_n)-min(lat_n)
           ,2)
        + 
        power(
            max(long_w)-min(long_w)
            ,2)
       )
        as decimal(10,4))
        from station

 SELECT ROUND(S1.LAT_N, 4) 
    FROM STATION AS S1 
    WHERE (SELECT ROUND(COUNT(S1.ID)/2) - 1 
           FROM STATION) = 
          (SELECT COUNT(S2.ID) 
           FROM STATION AS S2 
           WHERE S2.LAT_N > S1.LAT_N);

select sum(city.population) from city
inner join country
on CITY.CountryCode = Country.Code
where country.continent = 'Asia';

select city.name from city
left join country
on city.countrycode = country.code
where country.continent = 'africa'

select (country.continent), floor(avg(city.population)) from city
inner join country
on city.countrycode = country.code
group by country.continent

select name,grade,marks from students
join grades
on marks between min_mark and max_mark
where grade>7
order by grade desc,name 
-- 
select replace(name,name,"NULL"),grade,marks from students
join grades
on marks between min_mark and max_mark
where grade between 1 and 7
order by grade desc,marks

-- select hacker_id, name from hackers
-- inner join submissions
-- on hackers.hacker_id = submissions.hacker_id 
-- having max(score)
-- GROUP BY hackers.name , submissions.hacker_id
-- group by submissions.hacker_id

-- = (SELECT MAX(score) FROM submissions)

-- SELECT submissions.hacker_id, hackers.name
-- FROM hackers
-- INNER JOIN submissions
-- ON hackers.hacker_id = submissions.hacker_id
-- GROUP BY submissions.hacker_id,hackers.name
-- order by score =(
--     select score from submissions group by hacker_id order by score desc)

-- SELECT hackers.hacker_id, hackers.name
-- FROM hackers
-- INNER JOIN (
--     SELECT hacker_id, MAX(score) as max_score
--     FROM submissions
--     GROUP BY hacker_id
-- ) AS max_scores
-- ON hackers.hacker_id = max_scores.hacker_id
-- ORDER BY max_scores.max_score DESC

SELECT h.hacker_id , h.name
FROM submissions s
INNER JOIN hackers h on h.hacker_id = s.hacker_id
INNER JOIN challenges c on c.challenge_id = s.challenge_id
INNER JOIN difficulty d on d.difficulty_level = c.difficulty_level

WHERE s.score = d.score
AND c.difficulty_level = d.difficulty_level
        
                
GROUP BY h.hacker_id ,h.name
HAVING COUNT(s.submission_id) > 1
ORDER BY COUNT(s.submission_id) DESC, h.hacker_id ASC


-- Subquery
select count(city) - (select count(distinct city) from station)
from station;
-- Subquery
select max(population)- (select min(population) from city) from city


-- Generate the following two result sets:
-- Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
-- Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:
-- There are a total of [occupation_count] [occupation]s.
-- where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.
-- Note: There will be at least two entries in the table for each type of occupation.
-- Input Format
-- The OCCUPATIONS table is described as follows:


select Concat(name,'(',SUBSTRING (occupation, 1 , 1 ),')') 
from occupations order by name asc
select "There are a total of",count(*),concat(lower(occupation),'s','.') 
from occupations group by occupation order by count(*) asc


-- Consider  and  to be two points on a 2D plane.
--  happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
--  happens to equal the minimum value in Western Longitude (LONG_W in STATION).
--  happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
--  happens to equal the maximum value in Western Longitude (LONG_W in STATION).
-- Query the Manhattan Distance between points  and  and round it to a scale of  decimal places.
-- Input Format
-- The STATION table is described as follows:


select cast(
            max(lat_n)-min(lat_n)
        + 
            max(long_w)-min(long_w)

        as decimal(10,4))
        from station


-- Consider  and  to be two points on a 2D plane where  are the respective minimum and maximum values of Northern Latitude (LAT_N) and  are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.
-- Query the Euclidean Distance between points  and  and format your answer to display  decimal digits.
-- Input Format
-- The STATION table is described as follows:.


select cast(
      sqrt(
        power(
            max(lat_n)-min(lat_n)
           ,2)
        + 
        power(
            max(long_w)-min(long_w)
            ,2)
       )
        as decimal(10,4))
        from station


-- You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks.
-- Grades contains the following data:
-- Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.
-- Write a query to help Eve.
-- Sample Input
-- Sample Output
-- Maria 10 99
-- Jane 9 81
-- Julia 9 88 
-- Scarlet 8 78
-- NULL 7 63
-- NULL 7 68
-- Note
-- Print "NULL"  as the name if the grade is less than 8.
-- Explanation
-- Consider the following table with the grades assigned to the students:
-- So, the following students got 8, 9 or 10 grades:
-- Maria (grade 10)
-- Jane (grade 9)
-- Julia (grade 9)
-- Scarlet (grade 8)

select name,grade,marks from students
join grades
on marks between min_mark and max_mark
where grade>7
order by grade desc,name 
-- 
select replace(name,name,"NULL"),grade,marks from students
join grades
on marks between min_mark and max_mark
where grade between 1 and 7
order by grade desc,marks


-- Julia just finished conducting a coding contest,
--  and she needs your help assembling the leaderboard! Write a query to print 
--  the respective hacker_id and name of hackers who achieved full scores for more 
--  than one challenge. Order your output in descending order by the total number of
--   challenges in which the hacker earned a full score.
--    If more than one hacker received full scores in same number 
--    of challenges, then sort them by ascending hacker_id.


SELECT h.hacker_id , h.name
FROM submissions s
INNER JOIN hackers h on h.hacker_id = s.hacker_id
INNER JOIN challenges c on c.challenge_id = s.challenge_id
INNER JOIN difficulty d on d.difficulty_level = c.difficulty_level
WHERE s.score = d.score
AND c.difficulty_level = d.difficulty_level  
GROUP BY h.hacker_id ,h.name
HAVING COUNT(s.submission_id) > 1
ORDER BY COUNT(s.submission_id) DESC, h.hacker_id ASC