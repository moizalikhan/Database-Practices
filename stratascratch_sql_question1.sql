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