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
SELECT sender_id,count(*) as  SUM_OF_MESSAGES
FROM messages
WHERE sent_date BETWEEN '2022-08-01' AND '2022-08-31'
GROUP BY sender_id
ORDER BY count(*) DESC
LIMIT 2

--------------------------------------
with DUPLICATE_JOB_COUNT as
(
SELECT company_id, count(job_id) from job_listings
GROUP BY company_id
HAVING count(job_id) > 1
)
SELECT count(company_id) as Company_count from DUPLICATE_JOB_COUNT

--------------------------------------
SELECT
U.city,
count(*) as Order_count
FROM trades T
inner join users U
on T.user_id = U.user_id
where T.status = 'Completed'
GROUP by U.city
order by count(*) DESC
LIMIT 3

--------------------------------------
SELECT
EXTRACT(MONTH from submit_date) as mth,
product_id,
ROUND(AVG(stars),2) as avg_stars
FROM reviews
GROUP BY EXTRACT(MONTH from submit_date), product_id
ORDER BY EXTRACT(MONTH from submit_date), product_id

--------------------------------------
SELECT E.employee_id, E.name from employee E
inner join employee M
on E.manager_id = M.employee_id
where E.salary > M.salary

--------------------------------------
SELECT account_id,
SUM(
CASE
WHEN transaction_type = 'Deposit' THEN amount
WHEN transaction_type = 'Withdrawal' THEN -1*amount
END) AS final_balance
FROM transactions
GROUP BY account_id

--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------