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

