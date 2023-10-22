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

SELECT title , Domestic_sales , International_sales FROM movies
inner join Boxoffice on Movies.id = Boxoffice.Movie_id;

SELECT title , Domestic_sales , International_sales FROM movies
inner join Boxoffice on Movies.id = Boxoffice.Movie_id
where International_sales > Domestic_sales;

SELECT title, Rating FROM movies
inner join Boxoffice on Movies.id = Boxoffice.Movie_id
order by rating desc;


SELECT DISTINCT building FROM employees;
-- 
SELECT distinct Building_name from Buildings 
right join Employees on Buildings.Building_name = Employees.Building;

SELECT * FROM Buildings

SELECT DISTINCT Building_name, Role FROM Buildings
LEFT JOIN Employees ON Buildings.Building_name = Employees.Building

SELECT Building_name FROM Buildings
left join Employees on Buildings.Building_name = Employees.Building
where building ISNULL;

SELECT Title,
(Domestic_sales + International_sales) / 1000000
as Sales 
FROM Movies
inner join on
Movies.Id = Boxoffice.Movie_id

SELECT title, rating * 10 AS ratings
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id;

SELECT title, year AS even_years
FROM movies
JOIN boxoffice
ON movies.id = boxoffice.movie_id
Where even_years%2==0;

