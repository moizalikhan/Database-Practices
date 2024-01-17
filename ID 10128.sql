-- Count the number of movies that Abigail Breslin was nominated for an oscar.



select count(movie) as n_movies_by_abi from oscar_nominees where nominee = 'Abigail Breslin';