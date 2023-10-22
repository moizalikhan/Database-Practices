-- Some queries from sqlbolt
select title, year from movies order by year limit 5 offset 1 

SELECT * FROM movies where title like "toy%";
SELECT * FROM movies where director like "john%";
SELECT * FROM movies where director not like "john%";
SELECT * FROM movies where title like "wall%";

SELECT distinct director FROM movies order by director;
SELECT distinct title, year FROM movies order by year desc limit 4;
SELECT distinct title FROM movies order by title asc limit 5;
SELECT distinct title FROM movies order by title asc limit 5 offset 5;

SELECT city, population FROM north_american_cities where country = 'Canada';
SELECT city FROM north_american_cities where country = 'United States' order by latitude desc

SELECT * from North_american_cities where Longitude < (select Longitude from North_american_cities where 
city = "Chicago") order by longitude

select city from North_american_cities 
where country = "Mexico" order by population desc limit 2

select city from North_american_cities 
where country = "United States" order by population desc limit 2 offset 2

