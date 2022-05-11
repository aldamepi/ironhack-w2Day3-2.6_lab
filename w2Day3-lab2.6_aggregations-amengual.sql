-- Lab 2.6


USE sakila;






--

-- 1. In the table actor, which are the actors whose last names are not repeated?

select last_name, count(last_name) as counter from actor
group by last_name
-- order by counter desc;
having counter = 1;



-- 2. Which last names appear more than once?

select last_name, count(last_name) as counter from actor
group by last_name
-- order by counter desc;
having counter > 1;



-- 3. Using the rental table, find out how many rentals were processed by each employee

select staff_id as employee, count(rental_id) as rentals from rental
group by staff_id
order by rentals desc;


-- 4. Using the film table, find out how many films were released each year.

select release_year, count(film_id) as films from film
group by release_year;


-- 5. Using the film table, find out for each rating how many films were there.

select rating, count(film_id) as films from film
group by rating
order by films desc;



-- 6. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places

select rating, time_format(convert(avg(length),time),'%i:%s') as mean_duration from film
group by rating
order by mean_duration desc;
-- still considers the the minutes as hours



-- 7. Which kind of movies (rating) have a mean duration of more than two hours?


select rating, avg(length) as mean_duration from film
group by rating
HAVING avg(length) > 120
order by mean_duration desc;

select rating, time_format(convert(avg(length),time),'%i:%s') as mean_duration from film
group by rating
HAVING avg(length) > 120
order by mean_duration desc;

select concat(floor(avg(length)/60),'h:',floor(avg(length)%60),'m') from film;




-- 8. Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank.
/*
select title, length, rating from film
where not isnull(length) and not (length = 0)
order by length desc;

select * from film where length is null;
select * from film where length = 0;
select * from film where length = ' ';
*/

-- SELECT *, amount-payments AS balance, AVG(amount-payments) OVER (PARTITION BY status, duration) AS 'aggregated'
-- FROM bank.loan;

select title, length, 
	rank() OVER(order by length desc) as ranking
from film
where not isnull(length) and not (length = 0)
order by length desc;


select title, length, 
	rank() OVER w as ranking
from film
window w as (order by length desc);
-- where not isnull(length) and not (length = 0)
-- order by length desc;






