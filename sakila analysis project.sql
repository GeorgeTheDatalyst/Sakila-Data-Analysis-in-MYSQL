-- 1. All films with PG-13 films with rental rate of 2.99 or lower
use sakila;
select film_id,title,rating
from film
where rental_rate <= 2.99 and rating = 'PG-13'
order by film_id;


--  2. All films that have deleted scenes
select film_id,title,special_features
from film
where special_features regexp('Deleted Scenes')
group by film_id;

-- 3. All active customers
select customer_id, concat(first_name,'   ',last_name) as customer_name, active
from customer
where active=1
group by customer_id;

-- 4. Names of customers who rented a movie on 26th July 2005
select customer_id, rental_id, concat(first_name,'   ',last_name) as customer_name
from customer cs
join rental rl using(customer_id)
where rental_date regexp('2005-07-26')
order by rental_id asc;

-- 5. How many rentals we do on each day?
select inventory_id, count(*) as rentals_total
from rental
group by inventory_id
order by count(*);


-- 6. All SciFix films in catalogue
use sakila;
select fc.category_id,
		fm.title,
		ct.name
from film fm
join film_category fc using(film_id)
join category ct on ct.category_id=fc.category_id
where ct.name='Sci-Fi';


-- 7. Customers and how many movies they rented from us so far?
use sakila;
select customer_id,
		first_name,
		count(rl.inventory_id) as number_of_movies
from customer cs 
join rental rl using (customer_id)
group by customer_id;


-- 8.  Which movies should we discontinue from our catalogue (less than 2 lifetime rentals)
select count(inventory_id) as number_of_rentals
from inventory i
join filSm fl using(film_id)
-- group by film_id
where count(inventory_id) < 2 ;


-- 9. Which movies are not returned yet?
select*
from rental
where rental_date != null and return_date = null;


-- 10. How many distinct last names we have in the data?
select last_name,count(last_name) as distint_last_name
from customer
where last_name in
					(
					select distinct(last_name) as name
					from customer
					)
group by last_name
order by last_name;

-- 11.  How much money and rentals we make for Store 1 by day?  
select amount, sum(store_id) as total,
		sf.store_id
from payment
join staff sf using(staff_id)
join store s on s.store_id = sf.store_id
group by amount;


-- 12. What are the three top earning days so far?
select customer_id,
		amount
from payment
order by amount desc
limit 3;


-- 13. Countries with highest number of customers (top 3 )
select cr.country, count(*) as top_countries
from customer cs
join address ad using(address_id)
join city cy on cy.city_id = ad.city_id
join country cr on cr.country_id = cy.country_id
group by cr.country
order by count(*) desc
limit 3;


-- 14. number of movies acted by each actor
select actor_id,title, count(*) as total_movies
from film
join film_actor fa using(film_id)
join actor ac using(actor_id)
group by 1,2
order by count(*) desc







