CREATE TABLE cities(
  name VARCHAR(50),
  country VARCHAR(50),
  population INTEGER,
  area INTEGER
);

INSERT INTO cities(name, country, population, area) VALUES
('TOKYO','JAPAN', 1234568, 789456123);

INSERT INTO cities(name, country, population, area) VALUES
('DELHI','INDIA',123456789,987654321),('HOUSTAN','USA',123456789,987654321),('SOAUL','KOREA',123456789,987654321);


SELECT population/area as Desnsity

SELECT name, price * unit_sold AS Revenue from phones

-- LOWER(), UPPER(), LENGTH(), ||, concat() functions
-- schema designer
-- 
