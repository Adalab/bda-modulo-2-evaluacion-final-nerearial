-- EVALUACIÓN FINAL MÓDULO 2 --

-- NEREA RIAL CONDE - PROMO B 

-- EJERCICIOS - BASE DE DATOS SAKILA

USE sakila;

--  1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

SELECT DISTINCT title
FROM film;

-- 2.  Muestra los nombres de todas las películas que tengan una clasificación de "PG-13"

SELECT DISTINCT title -- PREGUNTAR A SARA SI ES BUENA PRÁCTICA UTILIZAR EL DISTINCT EN ESTAS CONSULTAS TODAS.
FROM film
WHERE rating = "PG-13";

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción

SELECT title, description
FROM film
WHERE description LIKE "%amazing%";

-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos
SELECT title
FROM film
WHERE length > 120;

-- 5. Recupera los nombres de todos los actores
SELECT CONCAT(first_name," ", last_name) AS "Actor Full Name"
FROM actor;

-- 6.  Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE "Gibson"; -- Usamos LIKE porque puede ser que contenga algo más que Gibson

-- 7.  Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20
SELECT actor_id, CONCAT(first_name," ", last_name) AS ActorFullName
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación
SELECT title, rating 
FROM film
WHERE rating NOT IN ("R","PG-13");

-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.

SELECT rating, COUNT(film_id) AS TotalFilms
FROM film
GROUP BY rating;

-- 10.  Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

SELECT CONCAT(first_name," ", last_name) AS CustomerFullName, cu.customer_id, COUNT(rental_id) AS TotalRentals
FROM customer
	AS cu
INNER JOIN rental AS re
	ON cu.customer_id = re.customer_id
GROUP BY cu.customer_id;

-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

SELECT ca.name AS Category, COUNT(rental_id) AS TotalRentals
FROM rental AS re
	INNER JOIN inventory AS inv
		ON re.inventory_id = inv.inventory_id
	INNER JOIN film_category AS fc
		ON inv.film_id = fc.film_id
	INNER JOIN category AS ca
		ON fc.category_id = ca.category_id
GROUP BY ca.name;

-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

SELECT round(AVG(length),2) AS AverageLenght, rating
FROM film 
GROUP BY rating;

-- 13.  Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love"

WITH FilmsbyActor AS (
	SELECT fi.actor_id, film_id, first_name, last_name
    FROM film_actor AS fi
    INNER JOIN actor AS act
		ON fi.actor_id = act.actor_id
        )

SELECT CONCAT(first_name, " ", last_name) As "Actor Full Name"
FROM FilmsbyActor
INNER JOIN film USING (film_id)
WHERE title = "Indian Love";

-- 14.  Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción
        
SELECT title, description
FROM film
WHERE description LIKE "%dog" OR description LIKE "%cat%";

-- 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor

SELECT CONCAT(first_name, " ", last_name) AS ActorFullName
FROM actor
WHERE actor_id NOT IN (
	SELECT actor_id
    FROM film_actor);
    
-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010

SELECT title, release_year
FROM film
WHERE release_year BETWEEN 2005 AND 2010;
    
-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family"

WITH categoryNames AS (
	SELECT flm.title, ca.name
    FROM category AS ca
    INNER JOIN film_category AS fi 
		ON ca.category_id = fi.category_id
	INNER JOIN film AS flm
		ON fi.film_id = flm.film_id
	)
        
SELECT title
FROM categorynames
WHERE name = "Family";

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
	SELECT actor_id
    FROM film_actor
    GROUP BY actor_id 
    HAVING COUNT(film_id) > 10);

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film

SELECT title
FROM film
WHERE rating = "R" AND length > 120;

-- 20.  Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración


WHERE 

