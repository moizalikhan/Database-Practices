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


-- #### Medium Level Questions
