-- Using sakila database to query data
USE sakila;

-- 1a. Displaying First and Last Name of all the actors in table actor
SELECT *
FROM actor;

-- ALTER TABLE actor
-- DROP COLUMN Actor_Name;

-- 1b. Displaying First Name and Last Name into single coulmn
-- ALTER TABLE actor
-- ADD COLUMN Actor_Name varchar(100) AFTER last_name;

-- SET SQL_SAFE_UPDATES = 0;
-- UPDATE actor
SELECT CONCAT(IFNULL(first_name,''), ',' , IFNULL(last_name,'')) as Actor_Fullname FROM actor;

-- SELECT * FROM actor;	

-- 2a. Find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "Joe" AND first_name IS NOT NULL;

-- SELECT * FROM actor;
-- 2b. Find all actors whose last name contain the letters `GEN`
SELECT *
FROM actor
WHERE last_name LIKE '%GEN%';

-- 2c.Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name
SELECT *
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name,first_name;

-- 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China

SELECT country_id, country
FROM country
WHERE 
	country IN ('Afghanistan','Bangladesh','China') 
AND country IS NOT NULL;

 -- 3a. Add a `middle_name` column to the table `actor`. Position it between `first_name` and `last_name`. 
 ALTER TABLE actor
 ADD COLUMN middle_name varchar(100) AFTER first_name;
 
-- 3b. Change the data type of the `middle_name` column to `blobs`
 ALTER TABLE actor 
 CHANGE COLUMN middle_name middle_name blob; 
 
 -- 3c. Now delete the `middle_name` column
 ALTER TABLE actor
 DROP COLUMN middle_name;
 
 -- 4a. List the last names of actors, as well as how many actors have that last name
 
 SELECT last_name, COUNT(*) as count
 FROM actor
 GROUP BY last_name
 HAVING count >= 1;
 
 -- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

 SELECT last_name, COUNT(*) as count
 FROM actor
 GROUP BY last_name
 HAVING count >= 2;
 
 -- 4c. Oh, no! The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`, the name of Harpo's second cousin's husband's yoga teacher. 
 UPDATE actor
 SET first_name = 'HARPO'
 WHERE first_name = 'GROUCHO' 
 AND last_name = 'WILLIAMS';
 
 -- 4d. In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`. 
 UPDATE actor
 SET first_name = 'GROUCHO'
 WHERE first_name = 'HARPO' 
 AND last_name = 'WILLIAMS';
 
 -- 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?
 
 -- 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
 SELECT * FROM staff;
 
 SELECT s.first_name , s.last_name , a.address
 FROM staff s 
 JOIN address a ON s.address_id = a.address_id;
 
 -- 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`. 
 SELECT * FROM staff;
 SELECT * FROM payment;
 
 SELECT s.first_name , s.last_name , SUM(p.amount) as Total_Amount
 FROM payment p 
 LEFT JOIN staff s ON p.staff_id = s.staff_id
 WHERE 
 p.payment_date > '2005-08-01 00:00:00' 
 AND p.payment_date < '2005-08-31 00:00:00'
 GROUP BY s.first_name,s.last_name;
 
 -- 6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
 SELECT * FROM film;
 SELECT * FROM film_actor;
 
 SELECT f.title, count(a.actor_id) as Actors_Count
 FROM film f 
 JOIN film_actor a ON f.film_id = a.film_id
 GROUP BY title;
 
 -- 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?
 SELECT * FROM inventory;
 
 SELECT f.film_id, f.title, count(i.film_id) as copies
 FROM film f 
 JOIN inventory i ON f.film_id = i.film_id
 WHERE f.title = 'Hunchback Impossible'
 GROUP BY title;
 
 -- 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name
SELECT * FROM payment;
SELECT * FROM customer;

SELECT c.first_name, c.last_name , sum(p.amount) as Amount_Paid
FROM customer c 
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.last_name
ORDER BY c.last_name,c.first_name;

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English

  
 
 
 