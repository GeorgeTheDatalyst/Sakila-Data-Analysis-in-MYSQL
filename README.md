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
4. All active customers
5. Names of customers who rented a movie on 26th July 2005
6. How many rentals we do on each day?
7. All SciFix films in catalogue
8. Customers and how many movies they rented from us so far?
9.  Which movies should we discontinue from our catalogue (less than 2 lifetime rentals)
10. Which movies are not returned yet?
11. How many distinct last names we have in the data?
12.  How much money and rentals we make for Store 1 by day?  
13. What are the three top earning days so far?
14. Countries with highest number of customers (top 3 )
15. number of movies acted by each actor

