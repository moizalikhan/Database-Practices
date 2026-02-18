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
SELECT CONCAT(YEAR(shipment_date), '-', MONTH(shipment_date)) AS year_month, COUNT(*) AS shipment_count
FROM amazon_shipment
GROUP BY YEAR(shipment_date), MONTH(shipment_date)
ORDER BY YEAR(shipment_date), MONTH(shipment_date);

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
Select worker_title from title T
join worker W
on
T.worker_ref_id = W.worker_id
where salary = (Select max(salary) from worker)

-----------------------------------------------------------------------------------
-- ID 9845
-- Find the number of employees working in the Admin department that joined in April or later, in any year.
-- Table
-- worker
select count(worker_id)
from worker
where department = 'Admin' and joining_date > CONVERT(DATETIME, '2014-04-01');

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
select id, first_name, last_name,department_id, max(salary) from ms_employee_salary
group by id, first_name, last_name, department_id
order by
id asc;

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