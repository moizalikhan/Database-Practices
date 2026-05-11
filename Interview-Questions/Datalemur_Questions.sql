With Tweet_data as (
SELECT
user_id,
count(*) as tweet_bucket
FROM tweets
WHERE EXTRACT(YEAR FROM tweet_date) = 2022
GROUP by user_id
)
SELECT tweet_bucket, count(user_id) from Tweet_data
GROUP by tweet_bucket

---------------------
with python_skills as
(
SELECT * FROM candidates WHERE skill='Python'
),
tableau_skills as
(
SELECT * FROM candidates WHERE skill='Tableau'
),
postgresql_skills as
(
SELECT * FROM candidates WHERE skill='PostgreSQL'
)
SELECT
PS.candidate_id
from python_skills PS
inner join tableau_skills TS
on PS.candidate_id = Ts.candidate_id
inner join postgresql_skills DS
on PS.candidate_id = DS.candidate_id

---------------------
SELECT part,assembly_step FROM parts_assembly
WHERE finish_date IS null;

---------------------
SELECT P.page_id from pages P
left join page_likes PL
on P.page_id = PL.page_id
WHERE liked_date IS null
order by P.page_id ASC

--------------------------------------
SELECT
Count(*) FILTER (where device_type='laptop') as laptop_reviews,
Count(*) FILTER (where device_type='tablet' or device_type='phone') as mobile_views
FROM viewership

--------------------------------------
SELECT
    user_id,
    EXTRACT(DAY FROM MAX(post_date) - MIN(post_date)) AS days_between
FROM posts
WHERE EXTRACT(YEAR FROM post_date) = 2021
GROUP BY user_id
HAVING COUNT(post_id) >= 2;

--------------------------------------
