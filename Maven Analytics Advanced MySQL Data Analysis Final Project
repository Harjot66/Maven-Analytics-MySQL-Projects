SELECT YEAR(website_sessions.created_at) AS Year,
		QUARTER(website_sessions.created_at) AS Quarter,
		COUNT(DISTINCT(website_sessions.website_session_id)) AS Sessions,
		COUNT(DISTINCT(orders.order_id)) AS Orders
FROM orders
		RIGHT JOIN website_sessions ON orders.website_session_id = website_sessions.website_session_id
GROUP BY Year, Quarter
ORDER BY Year, Quarter;



SELECT YEAR(website_sessions.created_at) AS Year,
		QUARTER(website_sessions.created_at) AS Quarter,
		COUNT(DISTINCT(orders.order_id))/COUNT(DISTINCT(website_sessions.website_session_id)) AS session_to_order_conversion_rate,
        SUM(orders.price_usd)/COUNT(DISTINCT(orders.order_id)) AS revenue_per_order,
        SUM(orders.price_usd)/COUNT(DISTINCT(orders.website_session_id)) AS revenue_per_session
FROM orders
		RIGHT JOIN website_sessions ON orders.website_session_id = website_sessions.website_session_id
GROUP BY Year, Quarter
ORDER BY Year, Quarter;



SELECT YEAR(website_sessions.created_at) AS Year,
		QUARTER(website_sessions.created_at) AS Quarter,
        COUNT(DISTINCT(CASE WHEN website_sessions.utm_source = 'gsearch' AND website_sessions.utm_campaign = 'nonbrand' THEN orders.order_id ELSE NULL END)) AS gsearch_and_nonbrand_orders,
        COUNT(DISTINCT(CASE WHEN website_sessions.utm_source = 'bsearch' AND website_sessions.utm_campaign = 'nonbrand' THEN orders.order_id ELSE NULL END)) AS bsearch_and_nonbrand_orders,
        COUNT(DISTINCT(CASE WHEN website_sessions.utm_campaign = 'brand' THEN orders.order_id ELSE NULL END)) AS brand_orders,
        COUNT(DISTINCT(CASE WHEN website_sessions.utm_source IS NULL AND website_sessions.http_referer IS NOT NULL THEN orders.order_id ELSE NULL END)) AS organic_orders,
        COUNT(DISTINCT(CASE WHEN website_sessions.utm_source IS NULL AND website_sessions.http_referer IS NULL THEN orders.order_id ELSE NULL END)) AS direct_type_in_orders
FROM orders
		RIGHT JOIN website_sessions ON orders.website_session_id = website_sessions.website_session_id
GROUP BY Year, Quarter
ORDER BY Year, Quarter;



SELECT YEAR(website_sessions.created_at) AS Year,
		QUARTER(website_sessions.created_at) AS Quarter,
        COUNT(DISTINCT(CASE WHEN website_sessions.utm_source = 'gsearch' AND website_sessions.utm_campaign = 'nonbrand' THEN orders.order_id ELSE NULL END))/COUNT(DISTINCT(CASE WHEN website_sessions.utm_source = 'gsearch' AND website_sessions.utm_campaign = 'nonbrand' THEN website_sessions.website_session_id ELSE NULL END)) AS gsearch_and_nonbrand_orders_conversion_rate,
        COUNT(DISTINCT(CASE WHEN website_sessions.utm_source = 'bsearch' AND website_sessions.utm_campaign = 'nonbrand' THEN orders.order_id ELSE NULL END))/COUNT(DISTINCT(CASE WHEN website_sessions.utm_source = 'bsearch' AND website_sessions.utm_campaign = 'nonbrand' THEN website_sessions.website_session_id ELSE NULL END)) AS bsearch_and_nonbrand_orders_conversion_rate,
        COUNT(DISTINCT(CASE WHEN website_sessions.utm_campaign = 'brand' THEN orders.order_id ELSE NULL END))/COUNT(DISTINCT(CASE WHEN website_sessions.utm_campaign = 'brand' THEN website_sessions.website_session_id ELSE NULL END)) AS brand_orders_conversion_rates,
        COUNT(DISTINCT(CASE WHEN website_sessions.utm_source IS NULL AND website_sessions.http_referer IS NOT NULL THEN orders.order_id ELSE NULL END))/COUNT(DISTINCT(CASE WHEN website_sessions.utm_source IS NULL AND website_sessions.http_referer IS NOT NULL THEN website_sessions.website_session_id ELSE NULL END)) AS organic_orders_conversion_rate,
        COUNT(DISTINCT(CASE WHEN website_sessions.utm_source IS NULL AND website_sessions.http_referer IS NULL THEN orders.order_id ELSE NULL END))/COUNT(DISTINCT(CASE WHEN website_sessions.utm_source IS NULL AND website_sessions.http_referer IS NULL THEN website_sessions.website_session_id ELSE NULL END)) AS direct_type_in_orders_conversion_rate
FROM orders
		RIGHT JOIN website_sessions ON orders.website_session_id = website_sessions.website_session_id
GROUP BY Year, Quarter
ORDER BY Year, Quarter;



SELECT YEAR(order_items.created_at) AS years,
		MONTH(order_items.created_at) AS months,
        SUM(CASE WHEN product_id = 1 THEN price_usd ELSE NULL END) AS mrfuzzy_rev,
        SUM(CASE WHEN product_id = 1 THEN price_usd - cogs_usd ELSE NULL END) AS mrfuzzy_marg,
        SUM(CASE WHEN product_id = 2 THEN price_usd ELSE NULL END) AS lovebear_rev,
        SUM(CASE WHEN product_id = 2 THEN price_usd - cogs_usd ELSE NULL END) AS lovebear_marg,
        SUM(CASE WHEN product_id = 3 THEN price_usd ELSE NULL END) AS birthdaybear_rev,
        SUM(CASE WHEN product_id = 3 THEN price_usd - cogs_usd ELSE NULL END) AS birthdaybear_marg,
        SUM(CASE WHEN product_id = 4 THEN price_usd ELSE NULL END) AS minibear_rev,
        SUM(CASE WHEN product_id = 4 THEN price_usd - cogs_usd ELSE NULL END) AS minibear_marg,
        SUM(price_usd) AS total_revenue,
        SUM(price_usd - cogs_usd) AS total_margin
FROM order_items
GROUP BY years, months;



CREATE TEMPORARY TABLE products_pageviews
SELECT website_session_id,
		website_pageview_id,
        created_at AS viewed_at
FROM website_pageviews
WHERE pageview_url = '/products';

SELECT YEAR(products_pageviews.viewed_at) AS years,
		MONTH(products_pageviews.viewed_at) AS months,
        COUNT(DISTINCT(website_pageviews.website_session_id))/COUNT(DISTINCT(products_pageviews.website_session_id)) AS percentage_of_sessions_clicking_through_another_page,
        COUNT(DISTINCT(orders.order_id))/COUNT(DISTINCT(products_pageviews.website_session_id)) AS conversion_from_products_to_placing_an_order
FROM products_pageviews
		LEFT JOIN website_pageviews ON website_pageviews.website_session_id = products_pageviews.website_session_id
			AND website_pageviews.website_pageview_id > products_pageviews.website_pageview_id
        LEFT JOIN orders ON orders.website_session_id = products_pageviews.website_session_id
GROUP BY years, months;



CREATE TEMPORARY TABLE primary_products
SELECT order_id, primary_product_id, created_at
FROM orders
WHERE created_at >= '2014-12-05';

SELECT primary_product_id,
        COUNT(DISTINCT(CASE WHEN cross_sell_product_id = 1 THEN order_id ELSE NULL END)) AS number_sold_product1,
        COUNT(DISTINCT(CASE WHEN cross_sell_product_id = 2 THEN order_id ELSE NULL END)) AS number_sold_product2,
        COUNT(DISTINCT(CASE WHEN cross_sell_product_id = 3 THEN order_id ELSE NULL END)) AS number_sold_product3,
        COUNT(DISTINCT(CASE WHEN cross_sell_product_id = 4 THEN order_id ELSE NULL END)) AS number_sold_product4
FROM (SELECT primary_products.order_id, primary_products.primary_product_id, primary_products.created_at, order_items.product_id AS cross_sell_product_id
			FROM primary_products LEFT JOIN order_items ON order_items.order_id = primary_products.order_id AND order_items.is_primary_item = 0) AS primary_w_cross_sell
GROUP BY primary_product_id
