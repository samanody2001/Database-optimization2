

Query 1:

 select
    film_id,
    title,
    length
from
    public.film	
where length > 160
order by
    length desc;

Query 2:
select
    category.name,
    count(category.name) category_count
from
    category
left join film_category on
    category.category_id = film_category.category_id
left join film on
    film_category.film_id = film.film_id
group by
    category.name
order by
    category_count desc;
	

Query 3:
select
    actor.first_name,
    actor.last_name,
    count(actor.first_name) featured_count
from
    actor
left join film_actor on
    actor.actor_id = film_actor.actor_id
group by
    actor.first_name,
    actor.last_name
order by
    featured_count desc;

Query 4:
SELECT t1.name, t1.standard_quartile, COUNT(t1.standard_quartile)
FROM
(SELECT f.title, c.name , f.rental_duration, NTILE(4) OVER (ORDER BY f.rental_duration) AS standard_quartile
FROM film_category fc
JOIN category c
ON c.category_id = fc.category_id
JOIN film f
ON f.film_id = fc.film_id
WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')) t1 
GROUP BY 1, 2
ORDER BY 1, 2

Query 5:
SELECT DATE_TRUNC('month', p.payment_date) pay_month, c.first_name || ' ' || c.last_name AS full_name, COUNT(p.amount) AS pay_countpermon, SUM(p.amount) AS pay_amount
FROM customer c
JOIN payment p
ON p.customer_id = c.customer_id
WHERE c.first_name || ' ' || c.last_name IN
(SELECT t1.full_name
FROM
(SELECT c.first_name || ' ' || c.last_name AS full_name, SUM(p.amount) as amount_total
FROM customer c
JOIN payment p
ON p.customer_id = c.customer_id
GROUP BY 1	
ORDER BY 2 DESC
LIMIT 10) t1) AND (p.payment_date BETWEEN '2007-01-01' AND '2008-01-01')
GROUP BY 2, 1
ORDER BY 2, 1, 3


Query 6: 

SELECT actor_id,
         first_name,
         last_name
FROM actor
WHERE first_name LIKE 'JOE';



Query 7: 

explain analyze SELECT *
FROM public.actor
WHERE last_name similar to '%[GEN]%' and last_name = 'Smith';



Query 8: 

SELECT country_id,
         country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

Query 9:

SELECT last_name,
         count(last_name)
FROM actor
GROUP BY  last_name;

Query 10: 

SELECT last_name,
         count(last_name)
FROM actor
where first_name like '%D'
GROUP BY  last_name;




Query 11: 

SELECT actor_id
FROM actor
WHERE first_name = 'HARPO'
        AND last_name = 'WILLIAMS';

Query 12: 

SELECT s.first_name,
         s.last_name,
         a.address
FROM staff s
LEFT JOIN address a
    ON s.address_id = a.address_id;

Query 13: 


SELECT p.staff_id,
         COUNT(p.amount)
FROM payment p
LEFT JOIN staff s
    ON p.staff_id = s.staff_id
GROUP BY  p.staff_id;


Query 14: 

SELECT c.last_name,
         c.first_name,
         c.email
FROM customer c
JOIN address a
    ON c.address_id = a.address_id
JOIN city ci
    ON a.city_id = ci.city_id
JOIN country co
    ON ci.country_id = co.country_id
WHERE country = 'Canada'
ORDER BY  last_name ASC;

Query 15: 

SELECT title
FROM film f
JOIN film_category fc
    ON f.film_id = fc.film_id
JOIN category c
    ON fc.category_id = c.category_id
WHERE c.category_id = 8;

Query 16: 

SELECT str.store_id,
         SUM(p.amount) AS total_sales
FROM store str
JOIN staff stf
    ON str.store_id = stf.store_id
JOIN payment p
    ON stf.staff_id = p.staff_id
GROUP BY  str.store_id;

Query 17: 

SELECT c.name,
         SUM(p.amount) AS gross_revenue
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN inventory i
    ON fc.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
JOIN payment p
    ON r.rental_id = p.rental_id
GROUP BY  c.name
ORDER BY  gross_revenue DESC limit 5;

Query 18: 

SELECT c.name,
         SUM(p.amount) AS gross_revenue
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN inventory i
    ON fc.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
JOIN payment p
    ON r.rental_id = p.rental_id
GROUP BY  c.name
ORDER BY  gross_revenue DESC;


Query 19:

SELECT f.film_id,
        initcap(f.title) AS title,
        f.release_year,
        trim(BOTH FROM l.name) AS film_language,
        f.rating,
        (SELECT array
             (SELECT c.name
              FROM public.film_category AS fc
              JOIN public.category AS c ON fc.category_id = c.category_id
              WHERE film_id = f.film_id)::text AS categories),
        (SELECT array
             (SELECT initcap(concat(a.first_name, ' ', a.last_name)) AS actors
              FROM public.film_actor AS fa
              JOIN public.actor AS a ON fa.actor_id = a.actor_id
              WHERE film_id = f.film_id)::text AS actor_array), 
        f.rental_duration,
        f.length AS length_minutes,
        f.replacement_cost,
        f.rental_rate
    FROM public.film f
        JOIN public.language l ON f.language_id = l.language_id
    GROUP BY f.film_id, (trim(BOTH FROM l.name));




 

