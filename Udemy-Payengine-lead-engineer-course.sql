-- Database Table Creation

CREATE TABLE IF NOT EXISTS students
(
    id         varchar not null constraint students_pk primary key,
    first_name varchar,
    last_name  varchar,
    meta_data  json,
    age        integer
);

CREATE TABLE IF NOT EXISTS courses
(
    id   varchar,
    name varchar
);

CREATE TABLE IF NOT EXISTS course_registrations
(
    student_id        varchar,
    course_id         varchar,
    registration_date timestamp with time zone,
    grades            integer[]
);


CREATE TABLE IF NOT EXISTS "Instuctors"
(
    id         varchar,
    first_name varchar
);


INSERT INTO courses (id, name) VALUES ('crs_1', 'Learning Java');
INSERT INTO courses (id, name) VALUES ('crs_2', 'Learning Python');
INSERT INTO courses (id, name) VALUES ('crs_3', 'Biology');
INSERT INTO courses (id, name) VALUES ('crs_4', 'Mathematics');

INSERT INTO students (id, first_name, last_name, meta_data, age) VALUES ('st_2', 'Matt', 'Damon', '{"address": "address", "school": {"name":  "Secondary High School"} }
', 27);
INSERT INTO students (id, first_name, last_name, meta_data, age) VALUES ('st_8', 'Tom', null, null, 28);
INSERT INTO students (id, first_name, last_name, meta_data, age) VALUES ('st_3', 'Matt', 'Jane', null, 18);
INSERT INTO students (id, first_name, last_name, meta_data, age) VALUES ('st_5', 'King', 'Jane', null, 27);
INSERT INTO students (id, first_name, last_name, meta_data, age) VALUES ('st_7', 'Rachel', 'Hanna', null, 18);
INSERT INTO students (id, first_name, last_name, meta_data, age) VALUES ('st_1', 'Rafael', 'Nadal', null, 25);
INSERT INTO students (id, first_name, last_name, meta_data, age) VALUES ('st_6', 'jennifer', 'alba', null, 25);
INSERT INTO students (id, first_name, last_name, meta_data, age) VALUES ('st_4', 'Matthew', 'Johnson', '{"address": "random_address"}', 30);

INSERT INTO "Instuctors" (id, first_name) VALUES ('ins_1', 'James');
INSERT INTO "Instuctors" (id, first_name) VALUES ('ins_2', 'Rebecca');
INSERT INTO "Instuctors" (id, first_name) VALUES ('ins_3', 'Matt');
INSERT INTO "Instuctors" (id, first_name) VALUES ('ins_4', 'King');
INSERT INTO "Instuctors" (id, first_name) VALUES ('ins_5', 'Connor');


INSERT INTO course_registrations (student_id, course_id, registration_date, grades) VALUES ('st_3', 'crs_3', '2023-02-23 18:37:56.139000 +00:00', '{70,80}');
INSERT INTO course_registrations (student_id, course_id, registration_date, grades) VALUES ('st_1', 'crs_2', '2023-01-28 18:37:56.139000 +00:00', '{70,80,85}');
INSERT INTO course_registrations (student_id, course_id, registration_date, grades) VALUES ('st_2', 'crs_2', '2023-01-28 18:37:56.139000 +00:00', '{66,80}');
INSERT INTO course_registrations (student_id, course_id, registration_date, grades) VALUES ('st_2', 'crs_1', '2023-02-22 18:37:56.139000 +00:00', '{44,80}');
INSERT INTO course_registrations (student_id, course_id, registration_date, grades) VALUES ('st_1', 'crs_1', '2023-01-29 18:37:56.139000 +00:00', '{70,55}');
INSERT INTO course_registrations (student_id, course_id, registration_date, grades) VALUES ('st_3', 'crs_1', '2023-01-29 18:37:56.139000 +00:00', '{70,55}');
INSERT INTO course_registrations (student_id, course_id, registration_date, grades) VALUES ('st_4', 'crs_1', '2023-01-29 18:37:56.139000 +00:00', '{70,55}');



-- Queries & Notes:

-- is NULL and not NULL
-- NOT(condition), IS NOT NULL
-- IN() or ANY()
-- Exits() --> return true or false
-- like is case sensitive
-- Case statements with newcloumn name and select from table.
-- UPPER(),LOWER(),initcap(),CONCAT()
-- 



-- 
select first_name, last_name, 'student' as type from students;
-- 
select id from students 
where exists(
    select student_id 
    from course_registrations 
    where students.id = course_registrations.student_id)
;
-- 
select id,
CASE when age <= 21  THEN 'junior'
ELSE 'senior' END status
from students
--

