SELECT CONCAT(staff.first_name, ' ', staff.last_name) AS full_name,
    address.address,
    address.district,
    city.city,
	country.country
FROM store LEFT JOIN staff ON store.store_id = staff.store_id
    LEFT JOIN address ON staff.address_id = address.address_id
    LEFT JOIN city ON address.city_id = city.city_id
    LEFT JOIN country ON city.country_id = country.country_id;



SELECT inventory.store_id,
	inventory.inventory_id,
	film.title, film.rating,
	film.rental_rate,
	film.replacement_cost
 FROM film
    LEFT JOIN Inventory ON film.film_id = inventory.film_id;



SELECT
    inventory.store_id,
	film.rating,
	COUNT(inventory.inventory_id)
FROM film
	LEFT JOIN Inventory ON film.film_id = inventory.film_id
GROUP BY inventory.store_id, film.rating;



SELECT inventory.store_id,
	category.category,
    COUNT(inventory.inventory_id),
    AVG(replacement_cost),
    SUM(replacement_cost)
FROM film 
	LEFT JOIN Inventory ON film.film_id = inventory.film_id
    LEFT JOIN film_category ON inventory.film_id = film_category.category_id
    LEFT JOIN category ON category.category_id = film_category.category_id
GROUP BY inventory.store_id, film_category.category_id;



SELECT CONCAT(Customer.first_name, ' ', Customer.last_name) AS Customer_name,
    Customer.store_id,
    address.address,
    city.city, country.country,
    CASE WHEN customer.active = 1 THEN 'YES'
	ELSE 'NO' END AS ActiveOrNot
FROM Customer 
    LEFT JOIN address on customer.address_id = address.address_id
    LEFT JOIN city ON city.city_id = address.city_id
    LEFT JOIN country ON country.country_id = city.country_id



SELECT CONCAT(Customer.first_name, ' ', Customer.last_name) AS Customer_name,
	COUNT(payment.rental_id) AS total_rentals,
    SUM(payment.amount) AS total_payment
FROM customer 
	LEFT JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer_name
ORDER BY (SELECT SUM(amount) FROM payment) DESC



SELECT 'advisor' AS type,
    CONCAT(advisor.first_name, ' ', advisor.last_name) AS full_name,
    NULL AS company_name
FROM advisor
UNION
SELECT 'investor' AS type,
    CONCAT(investor.first_name, ' ', investor.last_name) AS full_name,
    company_name
FROM investor



SELECT
    CASE
	    WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
		WHEN actor_award.awards IN ('Emmy, Oscar','Emmy, Tony','Oscar, Tony') THEN '2 awards'
		ELSE '1 award'
    END AS number_of_awards,
	AVG(CASE WHEN actor_award.actor_id IS NULL THEN 0 ELSE 1 END) AS percentage_of_actors
FROM actor_award
GROUP BY
    CASE
        WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
	    WHEN actor_award.awards IN ('Emmy, Oscar', 'Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
	    ELSE '1 award'
	END
