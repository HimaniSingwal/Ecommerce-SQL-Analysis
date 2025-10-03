#Customer Analysis
USE ecommerce_analysis;

	-- CUSTOMER ANALYSIS: Show sample customer orders
	-- This query joins orders with customers and lists
	-- order ID, status, city, and state for the first 7 records.

SELECT o.order_id, o.order_status, c.customer_city, c.customer_state
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
limit 7;

	-- This query counts how many orders come from each state
	-- and sorts them in descending order.
	-- Helps identify top-performing regions.

SELECT c.customer_state, COUNT(*) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;

    -- SALES ANALYSIS: Total revenue
	-- Calculates the overall revenue generated from products
	-- including both price and freight (shipping) charges.

SELECT ROUND(SUM(price + freight_value),2) AS total_revenue
FROM order_items;

	-- SALES ANALYSIS: Top 10 products by revenue
	-- Groups products by category, sums their revenue,
	-- and shows the top 10 categories.
	-- Useful for identifying best-selling product types.

SELECT p.product_category_name, ROUND(SUM(oi.price),2) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY revenue DESC
LIMIT 10;

	-- DELIVERY ANALYSIS: Average delivery time
	-- Calculates the average number of days it takes
	-- for an order to be delivered to the customer

SELECT AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)) AS avg_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

	-- REVIEW ANALYSIS: Average review score
	-- Finds the overall average customer review rating.
	-- Helps in understanding customer satisfaction.

SELECT AVG(review_score) FROM reviews;
