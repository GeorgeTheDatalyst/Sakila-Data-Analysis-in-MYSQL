# Sakila Data Analysis in MYSQL
## Introdution
The Sakila sample database is one of the most widely used sample databases. The Sakila database models the DVD rental store business, which contains content such as films, actors, inventory, stores, customers and staffs.
## Database Schema
![image](https://github.com/user-attachments/assets/09c6f06b-7c20-4f1d-b104-5d95dc80a50c)

## Tools Used
- MySQL Workbench

## Exlolatory Data Analysis of Sakila
## Questions Tackled
1. All films with PG-13 films with rental rate of 2.99 or lower
```sql
   use sakila;
SELECT 
    film_id, title, rating
FROM
    film
WHERE
    rental_rate <= 2.99 AND rating = 'PG-13'
ORDER BY film_id;
```
2. All films that have deleted scenes
```sql
SELECT 
    film_id, title, special_features
FROM
    film
WHERE
    special_features REGEXP ('Deleted Scenes')
GROUP BY film_id;
```
3. All active customers
```sql
SELECT 
    customer_id,
    CONCAT(first_name, '   ', last_name) AS customer_name,
    active
FROM
    customer
WHERE
    active = 1
GROUP BY customer_id;
```
4. Names of customers who rented a movie on 26th July 2005
```sql
SELECT 
    customer_id,
    rental_id,
    CONCAT(first_name, '   ', last_name) AS customer_name
FROM
    customer cs
        JOIN
    rental rl USING (customer_id)
WHERE
    rental_date REGEXP ('2005-07-26')
ORDER BY rental_id ASC;
```
5. How many rentals we do on each day?
```sql
SELECT 
    rental_date, COUNT(inventory_id) AS rentals_total
FROM
    rental
GROUP BY rental_date
ORDER BY COUNT(inventory_id);
```
6. All SciFix films in catalogue
```sql
use sakila;
SELECT 
    fc.category_id, fm.title, ct.name
FROM
    film fm
        JOIN
    film_category fc USING (film_id)
        JOIN
    category ct ON ct.category_id = fc.category_id
WHERE
    ct.name = 'Sci-Fi';
```
7. Customers and how many movies they rented from us so far?
```sql
use sakila;
SELECT 
    customer_id,
    first_name,
    COUNT(rl.inventory_id) AS number_of_movies
FROM
    customer cs
        JOIN
    rental rl USING (customer_id)
GROUP BY customer_id;
```
8.  Which movies should we discontinue from our catalogue (less than 2 lifetime rentals)
```sql
SELECT 
    film_id, COUNT(i.inventory_id) AS number_of_rentals
FROM
    inventory i
        JOIN
    film fl USING (film_id)
GROUP BY film_id
HAVING COUNT(i.inventory_id) < 2;
```
9. Which movies are not returned yet?
```sql
SELECT 
    rental_id, f.title
FROM
    rental r
        JOIN
    inventory i USING (inventory_id)
        JOIN
    film f ON f.film_id = i.film_id
WHERE
    rental_date IS NOT NULL
        AND return_date IS NULL;
```
10. How many distinct last names we have in the data?
```sql
SELECT 
    last_name, COUNT(last_name) AS distint_last_name
FROM
    customer
WHERE
    last_name IN (SELECT DISTINCT
            (last_name) AS name
        FROM
            customer)
GROUP BY last_name
ORDER BY last_name;
```
11.  How much money and rentals we make for Store 1 by day?
```sql
SELECT 
    payment_date, store_id, SUM(amount) AS total
FROM
    store s
        JOIN
    staff st USING (store_id)
        JOIN
    payment p ON p.staff_id = st.staff_id
GROUP BY payment_date , store_id
HAVING store_id = 1;
``` 
12. What are the three top earning days so far?
```sql
SELECT 
    customer_id, amount
FROM
    payment
ORDER BY amount DESC
LIMIT 3;
```
13. Countries with highest number of customers (top 3 )
```sql
SELECT 
    cr.country, COUNT(*) AS top_countries
FROM
    customer cs
        JOIN
    address ad USING (address_id)
        JOIN
    city cy ON cy.city_id = ad.city_id
        JOIN
    country cr ON cr.country_id = cy.country_id
GROUP BY cr.country
ORDER BY COUNT(*) DESC
LIMIT 3;
```
14. number of movies acted by each actor
```sql
SELECT 
    actor_id, title, COUNT(*) AS total_movies
FROM
    film
        JOIN
    film_actor fa USING (film_id)
        JOIN
    actor ac USING (actor_id)
GROUP BY 1 , 2
ORDER BY COUNT(*) DESC
```
This query counts the number of movies each actor has acted in.
```
```
## Conclusion
The queries provided in this project demonstrate various techniques for extracting and 
analyzing data from the Sakila database. These queries can be used to generate reports, 
gain insights, and make data-driven decisions for the video rental store.
```

