-- Number of Shipments Per Month
-- Write a query that will calculate the number of shipments per month. The unique key for one shipment is a combination of shipment_id and sub_id. Output the year_month in format YYYY-MM and the number of shipments in that month.
-- Table: amazon_shipment
-- shipment_id: int 
-- sub_id: int 
-- weight: int
-- shipment_date: datetime
SELECT CONCAT(YEAR(shipment_date), '-', MONTH(shipment_date)) AS year_month, COUNT(*) AS shipment_count
FROM amazon_shipment
GROUP BY YEAR(shipment_date), MONTH(shipment_date)
ORDER BY YEAR(shipment_date), MONTH(shipment_date);


-- Find the most profitable company from the financial sector. Output the result along with the continent.
-- Table: forbes_global_2010_2014
-- forbes_global_2010_2014
-- company: varchar
-- sector: varchar
-- industry: varchar
-- continent: varchar
-- country: varchar
-- marketvalue: float
-- sales: float
-- profits: float
-- assets: float
-- rank: int
-- forbeswebpage: varchar
SELECT company, continent FROM forbes_global_2010_2014 WHERE sector ='Financials' 
AND profits = (SELECT MAX(profits) FROM forbes_global_2010_2014)


-- Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. Output just the absolute difference in salaries.
-- Tables: db_employee, db_dept
-- db_employee:
-- id: int
-- first_name: varchar
-- last_name: varchar
-- salary: int
-- department_id:int
-- db_dept
-- id: int
-- department: varchar 
WITH engineering_salary AS (
    SELECT MAX(db_employee.salary) AS max_salary
    FROM db_employee
    LEFT JOIN db_dept ON db_employee.department_id = db_dept.id
    WHERE db_dept.id = 1
),
marketing_salary AS (
    SELECT MAX(db_employee.salary) AS max_salary
    FROM db_employee
    LEFT JOIN db_dept ON db_employee.department_id = db_dept.id
    WHERE db_dept.id = 4
)
SELECT ABS(marketing_salary.max_salary - engineering_salary.max_salary) AS salary_difference
FROM marketing_salary, engineering_salary;


-- We have a table with employees and their salaries, however,
--  some of the records are old and contain outdated salary information. Find the current salary of
--  each employee assuming that salaries increase each year.
--  Output their id, first name, last name, department ID, and current salary.
--  Order your list by employee ID in ascending order.

select id, first_name, last_name,department_id, max(salary) from ms_employee_salary
group by id, first_name, last_name, department_id
order by
id asc;


-- Find the last time
--  each bike was in use.
--   Output both the bike number
--    and the date-timestamp of the bike's last use
--     (i.e., the date-time the bike was returned).
--      Order the results by bikes that were most recently used.
select
bike_number, max(end_time) as last_used
from dc_bikeshare_q1_2012 
group by bike_number
order by last_used desc;


-- Find the number of rows for each review score earned by 'Hotel Arena'. Output the hotel name (which should be 'Hotel Arena'), review score along with the corresponding number of rows with that score for the specified hotel.
SELECT hotel_name, reviewer_score, COUNT(reviewer_score)
FROM hotel_reviews
WHERE hotel_name = 'Hotel Arena'
GROUP BY hotel_name, reviewer_score;

-- ID 10087
select Distinct P.* from facebook_posts P
Inner join facebook_reactions R
on P.post_id = R.post_id
where R.reaction = 'heart';

-- ID 10128
-- Count the number of movies that Abigail Breslin was nominated for an oscar.
select count(movie) as n_movies_by_abi from oscar_nominees where nominee = 'Abigail Breslin';


-- ID 10061
select location, ROUND(AVG(CAST(popularity AS FLOAT)), 2)
from facebook_employees E
inner join facebook_hack_survey S
on E.id = S.employee_id
group by location;

-- ID 10003
select * from lyft_drivers 
where yearly_salary <= 30000
OR
yearly_salary >= 70000;

-- ID 9992
select artist, count(artist) as occurrences from 
spotify_worldwide_daily_song_ranking 
group by artist
Order by occurrences Desc;

-- ID 9972
select employeename, basepay from
sf_public_salaries
where jobtitle like 'CAPTAIN III (POLICE DEPARTMENT)';

-- ID 9622
select city, property_type, avg(cast(bathrooms  as float)), 
avg(cast(bedrooms  as float)) 
from 
airbnb_search_details
group by city, property_type;

-- ID 9845
select count(worker_id)
from worker
where department = 'Admin' and joining_date > CONVERT(DATETIME, '2014-04-01');

-- ID 9891
select C.first_name, C.last_name, C.city, O.order_details
from customers C
full join orders O
on C.id = O.cust_id
order by C.first_name, O.order_details;

-- ID 9847
select department, count(worker_id) as 
num_workers from worker 
where month(joining_date) >= 4
group by
department order by num_workers desc;

-- ID 9913
select C.first_name, O.order_date,
O.order_details, O.total_order_cost
from customers C
join orders O
on C.id = O.cust_id
where C.first_name in ('Jill','Eva')
order by C.id;

-- ID 9688
select activity_date,pe_description from 
los_angeles_restaurant_health_inspections
where facility_name = 'STREET CHURROS' and score < 95;

-- ID 9924
select Distinct home_library_code from library_usage
where circulation_active_year = '2016' and 
notice_preference_definition = 'email' and
provided_email_address = 'FALSE';

-- ID 2119
select top 5 product_id, sum(cost_in_dollars* units_sold) as revenue
from online_orders
where month('2022-01-01')>=1 and month('2022-06-30')<=6
group by product_id
order by revenue DESC;

-- ID 2024
SELECT client_id, MONTH(time_id) AS MonthOF, COUNT(Distinct user_id) AS CountOF
FROM fact_events
GROUP BY client_id, MONTH(time_id)
ORDER BY MonthOF;

-- Forgot the code to write down
SELECT department, first_name, salary, AVG(salary) OVER (PARTITION BY department) AS dept_avg_sal
FROM employee;

-- Meta/Facebook has developed a new programing language called Hack.To measure the popularity of Hack they ran a survey with their employees. The survey included data on previous programing familiarity as well as the number of years of experience, age, gender and most importantly satisfaction with Hack. Due to an error location data was not collected, but your supervisor demands a report showing average popularity of Hack by office location. Luckily the user IDs of employees completing the surveys were stored.
-- Based on the above, find the average popularity of the Hack per office location.
-- Output the location along with the average popularity.
--
-- Tables
-- facebook_employees
-- facebook_hack_survey
select location, ROUND(AVG(CAST(popularity AS FLOAT)), 2)
from facebook_employees E
inner join facebook_hack_survey S
on E.id = S.employee_id
group by location;

------------------------------------------------------------------------
-- ID 2056
-- Write a query that will calculate the number of shipments per month. The unique key for one shipment is a combination of shipment_id and sub_id. Output the year_month in format YYYY-MM and the number of shipments in that month.
-- Table
-- amazon_shipment
SELECT
    TO_CHAR(shipment_date, 'YYYY-MM') AS year_month,
    COUNT(*) AS shipment_count
FROM amazon_shipment
GROUP BY year_month
ORDER BY year_month;

----------------------------------------------------------------------------
-- ID 9653
-- Count the number of user events performed by MacBookPro users.
-- Output the result along with the event name.
-- Sort the result based on the event count in the descending order.
-- Table
-- playbook_events
select event_name, count(event_name) as CountOfEvent
from playbook_events
where device = 'macbook pro'
GROUP BY event_name
order by CountOfEvent desc;

---------------------------------------------------------------------------
-- ID 9663
-- Find the most profitable company from the financial sector. Output the result along with the continent.
-- Table
-- forbes_global_2010_2014
SELECT company, continent FROM forbes_global_2010_2014 WHERE sector ='Financials'
AND profits = (SELECT MAX(profits) FROM forbes_global_2010_2014)

-------------------------------------------------------------------------------
-- ID 9688
-- Find the inspection date and risk category (pe_description) of facilities named 'STREET CHURROS' that received a score below 95.
-- Table
-- los_angeles_restaurant_health_inspections
select activity_date,pe_description
from los_angeles_restaurant_health_inspections
where facility_name='STREET CHURROS' and score<95;

--------------------------------------------------------------------------------
-- ID 9728
-- You are given a dataset of health inspections that includes details about violations. Each row represents an inspection, and if an inspection resulted in a violation, the violation_id column will contain a value.
-- Count the total number of violations that occurred at 'Roxanne Cafe' for each year, based on the inspection date. Output the year and the corresponding number of violations in ascending order of the year.
-- Table
-- sf_restaurant_health_violations
select
extract(year from inspection_date) as inspection_year,
count(*) as n_violations
from sf_restaurant_health_violations
where
violation_id is not null and
business_name='Roxanne Cafe'
group by inspection_year
order by inspection_year asc;

--------------------------------------------------------------------------------
-- ID 10003
-- Find all Lyft drivers who earn either equal to or less than 30k USD or equal to or more than 70k USD.
-- Output all details related to retrieved records.
-- Table
-- lyft_drivers
select * from lyft_drivers
where yearly_salary <= 30000
OR
yearly_salary >= 70000;

----------------------------------------------------------------------------------
-- ID 9992
-- Find how many times each artist appeared on the Spotify ranking list.
-- Output the artist name along with the corresponding number of occurrences.
-- Order records by the number of occurrences in descending order.
-- Table
-- spotify_worldwide_daily_song_ranking
select artist, count(artist) as occurrences from
spotify_worldwide_daily_song_ranking
group by artist
Order by occurrences Desc;

---------------------------------------------------------------------------------
-- ID 9891
-- Find the details of each customer regardless of whether the customer made an order. Output the customer's first name, last name, and the city along with the order details.
-- Sort records based on the customer's first name and the order details in ascending order.
-- Tables
-- customers
-- orders
select C.first_name, C.last_name, C.city, O.order_details
from customers C
full join orders O
on C.id = O.cust_id
order by C.first_name, O.order_details;

-----------------------------------------------------------------------------------
-- ID 10353
-- Management wants to analyze only employees with official job titles. Find the job titles of the employees with the highest salary. If multiple employees have the same highest salary, include all their job titles.
-- Tables
-- worker
-- title
SELECT T.worker_title
FROM worker W
JOIN title T ON W.worker_id = T.worker_ref_id
ORDER BY W.salary DESC
LIMIT 2;

-----------------------------------------------------------------------------------
-- ID 9845
-- Find the number of employees working in the Admin department that joined in April or later, in any year.
-- Table
-- worker
SELECT COUNT(worker_id)
FROM worker
WHERE department = 'Admin'
  AND joining_date > DATE '2014-04-01';

------------------------------------------------------------------------------------
-- ID 9847
-- Find the number of workers by department who joined on or after April 1, 2014.
-- Output the department name along with the corresponding number of workers.
-- Sort the results based on the number of workers in descending order.
-- Table
-- worker
select department, count(worker_id) as
num_workers from worker
where month(joining_date) >= 4
group by
department order by num_workers desc;

--------------------------------------------------------------------------------------
-- ID 10308
-- Calculates the difference between the highest salaries in the marketing and engineering departments. Output just the absolute difference in salaries.
-- Tables
-- db_employee
-- db_dept
WITH engineering_salary AS (
    SELECT MAX(db_employee.salary) AS max_salary
    FROM db_employee
    LEFT JOIN db_dept ON db_employee.department_id = db_dept.id
    WHERE db_dept.id = 1
),
marketing_salary AS (
    SELECT MAX(db_employee.salary) AS max_salary
    FROM db_employee
    LEFT JOIN db_dept ON db_employee.department_id = db_dept.id
    WHERE db_dept.id = 4
)
SELECT ABS(marketing_salary.max_salary - engineering_salary.max_salary) AS salary_difference
FROM marketing_salary, engineering_salary;

-----------------------------------------------------------------------------------
-- ID 2024
-- Write a query that returns the number of unique users per client for each month. Assume all events occur within the same year, so only month needs to be be in the output as a number from 1 to 12.
-- Table
-- fact_events
SELECT client_id, MONTH(time_id) AS MonthOF, COUNT(Distinct user_id) AS CountOF
FROM fact_events
GROUP BY client_id, MONTH(time_id)
ORDER BY MonthOF;

------------------------------------------------------
-- ID 9991
-- Find songs that have ranked in the top position. Output the track name and the number of times it ranked at the top. Sort your records by the number of times the song was in the top position in descending order.
-- Table
-- spotify_worldwide_daily_song_ranking
select trackname,
count(*) as times_top1
from
spotify_worldwide_daily_song_ranking
where position='1'
Group by trackname
order by times_top1
DESC;

----------------------------------------------------
-- ID 10299
-- We have a table with employees and their salaries, however, some of the records are old and contain outdated salary information. Find the current salary of each employee assuming that salaries increase each year. Output their id, first name, last name, department ID, and current salary. Order your list by employee ID in ascending order.
-- Table
-- ms_employee_salary
-- select * from ms_employee_salary
with ID_Based_Max_Salary as (
select id,first_name,last_name,department_id,salary,
Row_number() over (partition by id order by salary desc) as Ranked_Rows
from ms_employee_salary
)
select id,first_name,last_name,department_id,salary from ID_Based_Max_Salary where
ID_Based_Max_Salary.Ranked_Rows=1

----------------------------------------------------
-- ID 9917
-- Compare each employee salary with the average salary of the corresponding department.
-- Output the department, first name, and salary of employees along with the average salary of that department.
-- Table
-- employee
SELECT department, first_name, salary, AVG(salary) OVER (PARTITION BY department) AS dept_avg_sal
FROM employee;

----------------------------------------------------
-- ID 9913
-- Find order details made by Jill and Eva.
-- Consider the Jill and Eva as first names of customers.
-- Output the order date, details and cost along with the first name.
-- Order records based on the customer id in ascending order.
-- Tables
-- customers
-- orders
select C.first_name, O.order_date,
O.order_details, O.total_order_cost
from customers C
join orders O
on C.id = O.cust_id
where C.first_name in ('Jill','Eva')
order by C.id;

----------------------------------------------------------
-- ID 10176
-- Find the last time each bike was in use. Output both the bike number and the date-timestamp of the bikes last use (i.e., the date-time the bike was returned). Order the results by bikes that were most recently used.
-- Table
-- dc_bikeshare_q1_2012
select
bike_number, max(end_time) as last_used
from dc_bikeshare_q1_2012
group by bike_number
order by last_used desc;

----------------------------------------------------------
-- ID 9622
-- Find the average number of bathrooms and bedrooms for each city’s property types. Output the result along with the city name and the property type.
-- Table
-- airbnb_search_details
select city, property_type, avg(cast(bathrooms  as float)),
avg(cast(bedrooms  as float))
from
airbnb_search_details
group by city, property_type;

-----------------------------------------------------------
-- ID 10060
-- Find the review_text that received the highest number of  cool votes.
-- Output the business name along with the review text with the highest number of cool votes.
-- Table
-- yelp_reviews
select business_name, review_text
from yelp_reviews
where
cool = (select max(cool) from yelp_reviews)

-------------------------------------------------------------
-- ID 2005
-- Calculate the percentage of users who are both from the US and have an 'open' status, as indicated in the fb_active_users table.
-- Table
-- fb_active_users
with total_empl as
( select count(*)::numeric as total_users from fb_active_users
),
fb_active_users_with_open_status as
( select count(*)::numeric as active_users from fb_active_users where country='USA' and status='open'
)
select (active_users / total_users) * 100 as us_active_share from total_empl, fb_active_users_with_open_status

----------------------------------------------------------------
-- ID 2097
-- You have a dataset that records daily active users for each premium account. A premium account appears in the data every day as long as it remains premium. However, some premium accounts may be temporarily discounted, meaning they are not actively paying — this is indicated by a final_price of 0.
-- For each date, count the number of premium accounts that were actively paying on that day. Then, track how many of those same accounts are still premium and actively paying exactly 7 days later, if that later date exists in the dataset. Return results for the first 7 dates in the dataset.
-- Output three columns:
-- •   The date of initial calculation.
-- •   The number of premium accounts that were actively paying on that day.
-- •   The number of those accounts that remain premium and are still paying after 7 days.
-- Table
-- premium_accounts_by_day
with Intial_count_of_users as (
select
COUNT(distinct account_id) as countofusrs,
entry_date
from premium_accounts_by_day
where final_price > 0
group by entry_date
order by entry_date asc
limit 7
),
After_Interval_Day_of_users as
(
select
    f1.account_id,
    f1.entry_date as INTIAL_DATE,
    f2.entry_date as INTERVAL_DATE
from
    premium_accounts_by_day as f1
join
    premium_accounts_by_day as f2
on f1.account_id=f2.account_id
and f2.entry_date= f1.entry_date + interval '7 day'
where
    f1.final_price > 0 and f2.final_price > 0
)
select
    t1.entry_date,
    t1.countofusrs as premium_paid_accounts,
    COUNT(DISTINCT t2.account_id) AS premium_paid_accounts_after_7d
from Intial_count_of_users t1
join After_Interval_Day_of_users t2
on t1.entry_date=t2.INTIAL_DATE
group by t1.entry_date, countofusrs
order by t1.entry_date

------------------------------------------
-- -- ID 2102
-- For each video, find how many unique users flagged it.
-- A unique user can be identified using the combination of their first name and last name.
-- Do not consider rows in which there is no flag ID.
---count
select video_id,
count( DISTINCT (user_firstname, user_lastname )) as Unique_Users
from user_flags
where
-- user_firstname <> '' and user_lastname <> ''
flag_id <> ''
-- and video_id='dQw4w9WgXcQ'
group by video_id
order by video_id

-----------------------------------------
-- ID 2104
-- Which user flagged the most distinct videos that ended up approved by YouTube? Output,
-- in one column, their full name or names in case of a tie.
-- In the user's full name, include a space between the first and the last name.
-- Tables
-- user_flags
-- flag_review
SELECT
    CONCAT(UF.user_firstname,' ',UF.user_lastname) AS username
FROM user_flags UF
RIGHT JOIN flag_review FR
    ON UF.flag_id = FR.flag_id
WHERE
    UF.video_id <> ''
    AND UF.flag_id <> ''
    AND FR.reviewed_outcome = 'APPROVED'
GROUP BY UF.user_firstname, UF.user_lastname
HAVING COUNT(DISTINCT UF.video_id) = (
    SELECT MAX(Records)
    FROM (
SELECT COUNT(DISTINCT UF.video_id) AS Records
FROM user_flags UF
RIGHT JOIN flag_review FR
ON UF.flag_id = FR.flag_id
WHERE
UF.video_id <> ''
AND UF.flag_id <> ''
AND FR.reviewed_outcome = 'APPROVED'
GROUP BY UF.user_firstname, UF.user_lastname
)
)
order by UF.user_firstname,UF.user_lastname

----------------------------
-- ID 10318
-- Calculate the net change in the number of products launched by companies in 2020 compared to 2019. Your output should include the company names and the net difference.
-- (Net difference = Number of products launched in 2020 - The number launched in 2019.)
--
-- Table
-- car_launches
WITH ProductCounts AS (
    SELECT
        company_name,
        COUNT(DISTINCT CASE WHEN year = 2020 THEN product_name END) AS products_2020,
        COUNT(DISTINCT CASE WHEN year = 2019 THEN product_name END) AS products_2019
    FROM
        car_launches
    WHERE
        year IN (2019, 2020)
    GROUP BY
        company_name
)
SELECT
    company_name,
    products_2020 - products_2019 AS net_products
FROM
    ProductCounts;

---------------------------------
-- Calculate the total revenue from each customer in March 2019.
-- Include only customers who were active in March 2019.
-- An active user is a customer who made at least one transaction in March 2019.
-- Output the revenue along with the customer id
-- and sort the results based on the revenue in descending order.
-- Table
-- orders

select cust_id,sum(total_order_cost) as total_revenue from orders
where extract(month from order_date) = 3
group by cust_id
order by cust_id;

---------------------------------------
-- ID 10049
-- Calculate number of reviews for every business category.
-- Output the category along with the total number of reviews.
-- Order by total reviews in descending order.
-- Table
-- yelp_business
with categories_after_transformation as (
select
trim(unnest(string_to_array(categories,';'))) as categories,
review_count
from yelp_business
)
select categories,sum(review_count) as Count_of_reviews
from categories_after_transformation
group by categories order by Count_of_reviews DESC

---------------------------------------
-- ID 10352
-- Calculate each user's average session time,
-- where a session is defined as the time difference
-- between a page_load and a page_exit.
-- Assume each user has only one session per day.
-- If there are multiple page_load or page_exit events on the same day,
-- use only the latest page_load and the earliest page_exit.
-- Only consider sessions where the page_load occurs before
-- the page_exit on the same day.
-- Output the user_id and their average session time.
-- Table
-- facebook_web_log
with Session_start as(
select
user_id,max(timestamp) as sessionstart_timestamp
from facebook_web_log
where
action='page_load'
group by timestamp::date,user_id
order by user_id
),
Session_end as (
select
user_id,min(timestamp) as sessionend_timestamp
from facebook_web_log
where
action='page_exit'
group by timestamp::date,user_id
order by user_id
)
select S.user_id,AVG(E.sessionend_timestamp-S.sessionstart_timestamp)
as avg_session_duration from Session_start S
inner Join Session_end E
on S.user_id=E.user_id and
S.sessionstart_timestamp::date = E.sessionend_timestamp::date
where S.sessionstart_timestamp<=E.sessionend_timestamp
group by S.user_id

-------------------------------
-- ID 10300
-- Find the total number of downloads for paying and non-paying users by date.
-- Include only records where non-paying customers have more downloads than paying customers.
-- The output should be sorted by earliest date first and contain 3 columns date,
-- non-paying downloads, paying downloads.
-- Hint: In Oracle you should use "date" when referring to date column (reserved keyword).
-- Tables
-- ms_user_dimension
-- ms_acc_dimension
-- ms_download_facts

With All_Records as (
select D.date, D.downloads, D.user_id, U.acc_id, A.paying_customer
from ms_download_facts D
inner join ms_user_dimension U
on D.user_id = U.user_id
inner join ms_acc_dimension A
on A.acc_id = U.acc_id
order by D.date
),
Paying_Cus as (
select date,sum(downloads) as paying
from All_Records where paying_customer='yes'
group by date
order by date
),
Non_Paying_Cus as (
select date,sum(downloads) as non_paying
from All_Records where paying_customer='no'
group by date
order by date
)
select
PC.date as download_date,
NP.non_paying,
PC.paying
from Paying_Cus PC
inner join Non_Paying_Cus NP
on PC.date = NP.date
where NP.non_paying > PC.paying


----------------------------
-- ID 9915
-- Find the customers with the highest daily total order cost between 2019-02-01 and 2019-05-01.
-- If a customer had more than one order on a certain day, sum the order costs on a daily basis.
-- Output each customers first name, total cost of their items, and the date.
-- If multiple customers tie for the highest daily total on the same date, return all of them.
-- For simplicity, you can assume that every first name in the dataset is unique.
-- Tables
-- customers
-- orders
with daily_cost as
(
select C.first_name,O.order_date,sum(O.total_order_cost) as cost_of_orders
from customers C
inner join orders O
on C.id = O.cust_id
where O.order_date between '2019-02-01' and '2019-05-01'
group by O.order_date, C.first_name
),
daily_max as
(
select order_date, max(cost_of_orders) as daily_maxcost from daily_cost
group by order_date
)
select DC.first_name,DC.order_date,DC.cost_of_orders  from daily_cost DC
inner join daily_max DM
on DC.order_date = DM.order_date
and DC.cost_of_orders = DM.daily_maxcost

------------------
-- ID 10183
-- Find the total cost of each customer's orders.'
-- Output customer's id, first name, and the total order cost. Order records by customer's first name alphabetically.
-- Tables: customers, orders
--
select O.cust_id, C.first_name, sum(total_order_cost) from customers C
inner join orders O
on C.id = O.cust_id
group by O.cust_id, C.first_name
order by C.first_name

---------------------
-- ID 10127
-- What is the total sales revenue of Samantha and Lisa?
-- Table: sales_performance
SELECT
SUM(sales_revenue) AS "sales revenue"
FROM sales_performance
WHERE salesperson IN ('Samantha','Lisa')

-----------------------
-- ID 10130
-- Find the number of inspections that resulted in each risk category per each inspection type.
-- Consider the records with no risk category value belongs to a separate category.
-- Output the result along with the corresponding inspection type and the corresponding total number of inspections per that type. The output should be pivoted, meaning that each risk category + total number should be a separate column.
-- Order the result based on the number of inspections per inspection type in descending order.
-- Table
-- sf_restaurant_health_violations
with inspections_summary as (
select inspection_type,
sum(CASE when risk_category IS NULL Then 1 ELSE 0 END) as no_risk_results,
sum(CASE when risk_category='Low Risk' Then 1 ELSE 0 END) as low_risk_results,
sum(CASE when risk_category='Moderate Risk' Then 1 ELSE 0 END) as medium_risk_results,
sum(CASE when risk_category='High Risk' Then 1 ELSE 0 END) as high_risk_results,
count(*) as total_inspections
From sf_restaurant_health_violations
Group by inspection_type
)
select * from inspections_summary order by total_inspections DESC

------------------------------
-- ID 9881
-- Make a report showing the number of survivors and non-survivors by passenger class. Classes are categorized based on the pclass value as:
-- •	First class: pclass = 1
-- •	Second class: pclass = 2
-- •	Third class: pclass = 3
-- Output the number of survivors and non-survivors by each class.
--
-- Table
-- titanic
-- with Survivors as (
-- select pclass,count(*) as Survivors_Count from titanic where survived=1 group by pclass),
-- Non_Survivors as (
-- select pclass,count(*) as Non_Survivors_Count from titanic where survived=0 group by pclass)
-- select
select survived,
Count (*) Filter (where pclass=1 ) as first_class,
Count (*) Filter (where pclass=2 ) as second_class,
Count (*) Filter (where pclass=3 ) as third_class
from titanic
group by survived

---------------------------
-- ID 9894
-- Find employees who are earning more than their managers. Output the employee's first name along with the corresponding salary.
-- Table
-- employee
select E.first_name,E.salary
from employee E
inner join employee M
on E.manager_id = M.id
where E.salary > M.salary

-------------------------------
-- ID 9897
-- Find the employee with the highest salary per department.
-- Output the department name, employee's first name along with the corresponding salary.
-- Table
-- employee
WITH salaries_based_on_departments AS (
    SELECT department, MAX(salary) AS max_salary
    FROM employee
    GROUP BY department
)
SELECT S.department, E.first_name, S.max_salary
FROM salaries_based_on_departments S
JOIN employee E
  ON S.department = E.department
 AND S.max_salary = E.salary
ORDER BY S.department;

-----------------------
-- ID 9905
-- Identify the employee(s) working under manager manager_id=13 who have achieved the highest target. Return each such employee’s first name alongside the target value. The goal is to display the maximum target among all employees under manager_id=13 and show which employee(s) reached that top value.
-- Table
-- salesforce_employees
with Max_salaries as (
select manager_id, max(target) as Max_salary from salesforce_employees
where manager_id=13
group by manager_id
)
select S.first_name,M.Max_salary from Max_salaries M
join salesforce_employees S
on M.manager_id = S.manager_id and
M.Max_salary = S.target

----------------------------
-- ID 10078
-- Find matching hosts and guests pairs in a way that they are both of the same gender and nationality.
-- Output the host id and the guest id of matched pair.
-- Tables
-- airbnb_hosts
-- airbnb_guests
with airbnb_hosts_id as (
select distinct host_id, nationality, gender from airbnb_hosts
),
airbnb_guests_id as (
select distinct guest_id, nationality, gender from airbnb_guests)
select H.host_id, G.guest_id from airbnb_hosts_id H
inner join airbnb_guests_id G
on H.nationality = G.nationality and
H.gender = G.gender
order by H.host_id ASC

-------------------------------
-- ID 10085
-- Find matching pairs of Meta/Facebook employees such that they are both of the same nation, different age, same gender, and at different seniority levels.
-- Output ids of paired employees.
-- Table
-- facebook_employees
select
E1.id as employee_1, E2.id as employee_2
-- ,E1.location, E1.age
from facebook_employees E1
inner join facebook_employees E2
on E1.location = E2.location and
E1.gender = E2.gender
where E1.is_senior != E2.is_senior
order by E1.location ASC;

----------------------------------
-- ID 9856
-- Find employees who earn the same salary.
-- Output the worker id along with the first name and the salary in descending order.
-- Table
-- worker
select W1.worker_id,W1.first_name,W1.salary
from worker W1
inner join worker W2
on W1.salary = W2.salary
where W1.worker_id != W2.worker_id
order by W1.salary DESC;

------------------------------------
-- ID 9858
-- Generate a list of employees who work in the HR department, including only their first names and department in the output. Each employee should appear twice in the list, meaning their first name and department should be duplicated in the output.
-- Table
-- worker
select first_name, department from worker
where department='HR'
Union All
select first_name, department from worker
where department='HR';

------------------------------------
-- ID 9892
-- Find the second highest salary of employees.
-- Table
-- employee
select salary from employee
where salary < (select max(salary) from employee)
order by salary DESC
limit 1 ;

--------------------------------------
-- ID 10090
-- Find the percentage of shipable orders.
-- Consider an order is shipable if the customer's address is known.
-- Tables
-- orders
-- customers
with Total_order as (
select count(*) as Total_order_count
from orders O
inner join customers C
on O.cust_id = C.id
),
shipable_ones as (
select count(*) as shipable_order_count
from orders O
inner join customers C
on O.cust_id = C.id
where C.address is Not NULL
)
select (shipable_ones.shipable_order_count::float/Total_order.Total_order_count::float)*100 as percent_shipable from shipable_ones, Total_order

--------------------------------------
-- ID 10322
-- Identify returning active users by finding users who made a second purchase within 1 to 7 days after their first purchase. Ignore same-day purchases. Output a list of these user_ids.
--
-- Table
-- amazon_transactions
with Customers_Based_Date as (
    select *,
           row_number() over (partition by user_id order by created_at) as rn
    from amazon_transactions
)
select distinct c1.user_id
from Customers_Based_Date c1
join Customers_Based_Date c2
  on c1.user_id = c2.user_id
where c1.rn = 1
  and c2.rn = 2
  and (c2.created_at - c1.created_at) > 0
  and (c2.created_at - c1.created_at) <=7

--------------------------------------
-- ID 10156
-- Write a query that returns how many different apartment-type units (counted by distinct unit_id) are owned by people under 30, grouped by their nationality. Sort the results by the number of apartments in descending order.
-- Tables
-- airbnb_hosts
-- airbnb_units
select nationality,count (distinct unit_id) as apartment_count
from airbnb_hosts H
inner join airbnb_units U
on H.host_id = U.host_id
where H.age<30 and unit_type='Apartment'
group by nationality
order by apartment_count DESC

--------------------------------------
-- ID 10285
-- Calculate the friend acceptance rate for each date when friend requests were sent. A request is sent if action = sent and accepted if action = accepted. If a request is not accepted, there is no record of it being accepted in the table.
-- The output will only include dates where requests were sent and at least one of them was accepted (acceptance can occur on any date after the request is sent).
-- Table
-- fb_friend_requests
with Send_CTE as (
select date as send_date, user_id_receiver, user_id_sender from fb_friend_requests
where action='sent'
),
Accp_CTE as (
select date as acceptance_date, user_id_receiver, user_id_sender from fb_friend_requests
where action='accepted'
)
select S.send_date, Count(A.user_id_receiver)/Cast(Count(S.user_id_receiver) as decimal) as percentage_acceptance
from Send_CTE S
Left Join Accp_CTE A
on S.user_id_receiver= A.user_id_receiver
Group By S.send_date

--------------------------------------
