-- 1.Total Revenue 
select sum(order_total) as total_revenue
from blinkit_orders;

/*
shows total sales generated
Helps measure overall business growth.
Revenue directly measures business performance and sales growth.
*/

-- 2. Total orders
select count(*) as total_orders 
from blinkit_orders;

/*
counts total transactions
shows platform activity and demand
to understand customer purchasing frequency
*/

-- 3. Average order value 
select avg(order_total) as average_revenue
from blinkit_orders;

/*
average spending per order 
higher AOV increases profitability
it helps optimize pricing and bundle strategies 
*/

-- 4. top 10 customers by revenue 
select o.customer_id,c.customer_name,sum(o.order_total) as customer_purchasing
from blinkit_customers c
join blinkit_orders o on c.customer_id = o.customer_id
group by o.customer_id
order by customer_purchasing desc
limit 10;

/*
Identifies highest spending customers
Useful for loyalty-programs and retention 
Retaining premium customers increase revenue
*/

-- 5. Monthly Revenue Trend
select date_format(order_date,'%Y-%m') as monthly,sum(order_total) as total_revenue
from blinkit_orders 
group by monthly
order by monthly desc;

/*
Shows monthly-wise revenue growth.
detects seasonality and demand spikes.
business need forecasting and planning.
*/

-- 6. Revenue by payment method 
select payment_method,sum(order_total) as total_revenue 
from blinkit_orders 
group by payment_method 
order by total_revenue desc;

/*
Revenue contribution by payment type.
helps optimize payment experience
different payment methods affect conversion rates
*/

-- 7. Most ordered products 
select o.product_id,p.product_name,sum(o.quantity) as total_quantity 
from blinkit_order_items o
join blinkit_products p
on p.product_id = o.product_id 
group by o.product_id
order by total_quantity desc ;

/*
Shows best reselling products.
Useful for inventory planning
High-demand products drive revenue
*/

-- 8. Top product category
select p.category,sum(oi.quantity) as quantity_sold
from blinkit_order_items oi
join blinkit_products p
on oi.PRODUCT_ID = p.PRODUCT_ID
group by p.CATEGORY
order by quantity_sold desc;

/*
Shows best performing category
help prioritize inventory
Categories reveal customer demand patterns
*/

-- 9. Highest revenue product 
select p.product_name,sum(oi.quantity * oi.unit_price) as revenue 
from blinkit_order_items oi
join blinkit_products p 
on p.product_id = oi.product_id
group by p.product_name 
order by revenue desc; 
 
 /*
 top products contributing to revenue 
 Support product promotion decisions 
 Business can maximize profitability 
 */
 
 -- 10. Revenue by customer segment
 
 select c.customer_segment,sum(o.order_total) as revenue 
 from blinkit_customers c 
 join blinkit_orders o
 on o.CUSTOMER_ID = c.customer_id
 group by c.customer_segment 
 order by revenue desc;
 
 /*
 revenue contribution by customer type 
 premium users may contribute most revenue 
 Segmentation improves targeted marketing 
 */
 
 -- 11. count customers by segment
select customer_segment,count(*) as total_customers
from blinkit_customers
group by customer_segment;

-- 12. repeat customers
select customer_id,count(order_id) as total_orders 
from blinkit_orders 
group by customer_id 
having count(order_id) > 1
order by total_orders desc;

-- 13. Customer with highest AOV
select customer_id,round(avg(order_total),2) as aov
from blinkit_orders 
group by customer_id 
order by aov desc;

-- 14. New customer per month 
select date_format(registration_date,"%Y-%m") as month, count(*) as total_customer 
from blinkit_customers
group by month
order by month;

-- 15. Inactive Customer 
select *
from blinkit_customers
where customer_segment = 'Inactive';

-- 16. Customer without Orders 
select c.customer_id
from blinkit_customers c
left join blinkit_orders o
on c.customer_id = o.customer_id 
where o.order_id is NULL;

-- 17. Top Area by customers
select area,count(*) as total_customers
from blinkit_customers
group by area
order by total_customers desc ;

-- 18. Customer lift-time revenue 
select customer_id,sum(order_total) as revenue 
from blinkit_orders 
group by customer_id 
order by revenue desc;

-- 19. Average order per customer
select avg(total_orders) as avg_orders
from blinkit_customers;

-- 20. Premimum customer revenue 
select sum(o.order_total) as premium_customer_revenue 
from blinkit_orders o
join blinkit_customers c 
on c.customer_id = o.CUSTOMER_ID
where c.customer_segment = 'Premium';

-- 										SALES ANALYTICS

-- 21. Daily revenue 
select order_date,sum(order_total) as revenue 
from blinkit_orders 
group by order_date
order by order_date;

-- 22. highest single order 
select max(order_total)as max_single_order 
from blinkit_orders;

-- 23. lowest single order 
select order_date,min(order_total) as min_single_order
from blinkit_orders
group by order_date
order by min_single_order
limit 1; 

-- 24. Revenue by Year
select year(order_date) as orderyear,sum(order_total) as revenue 
from blinkit_orders
group by orderyear
order by orderyear;

-- 25. Avg daily revenue 
select avg(daily_revenue) as avg_daily_revenue
from (
	select order_date,sum(order_total) as daily_revenue 
    from blinkit_orders
    group by order_date
    ) as t;
    
-- 26. orders by payment method 
select payment_method,count(*) as total_orders 
from blinkit_orders 
group by payment_method;

-- 27. Revenue by Area
select c.area,sum(o.order_total) as revenue_by_area
from blinkit_customers c
join blinkit_orders o 
on c.customer_id = o.CUSTOMER_ID
group by c.area;

-- 28. Top revenue area 
select c.area,sum(o.order_total) as revenue 
from blinkit_customers c
join blinkit_orders o
on c.customer_id = o.CUSTOMER_ID
group by c.area
order by revenue desc 
limit 10;

-- 29. Weekend sales 
select dayname(order_date) as days ,sum(order_total) as sales 
from blinkit_orders 
group by dayname(order_date);

-- 30. Running Revenue total
select order_date,
	sum(order_total) over(order by order_date) as running_total
from blinkit_orders;

--                  PRODUCT ANALYTICS

-- 31. total products 
select count(*) as total_products 
from blinkit_products;

-- 32. products by category
select category,count(*) as total_products 
from blinkit_products
group by category;

-- 33. average MRP by category
select category,avg(mrp) 
from blinkit_products 
group by category;

-- 34. highest mrp products
select product_name,mrp
from blinkit_products 
order by mrp desc 
limit 1;

-- 35. Lowest mrp products 
select product_name,mrp 
from blinkit_products 
order by mrp 
limit 1;

-- 36. products with highest margin
select product_name,margin_percentage 
from blinkit_products 
order by margin_percentage desc 
limit 1;

-- 37. category revenue 
select p.category,
	sum(oi.quantity * oi.unit_price) as revenue 
from blinkit_products p
join blinkit_order_items oi
on p.PRODUCT_ID = oi.PRODUCT_ID
group by p.category
order by revenue desc;

-- 38. Average Shelf Life
SELECT AVG(shelf_life_days)
FROM blinkit_products;

-- 39. Products Sold per Category
SELECT p.category,
SUM(oi.quantity)
FROM blinkit_order_items oi
JOIN blinkit_products p
ON oi.product_id=p.product_id
GROUP BY p.category;

-- 40. Top Brands by Products
SELECT brand,
COUNT(*)
FROM blinkit_products
GROUP BY brand
ORDER BY COUNT(*) DESC;

-- 					ADVANCED SQL QUERIES 

-- 41. Rank Customers by Revenue
SELECT customer_id,
SUM(order_total) AS revenue,
RANK() OVER(ORDER BY SUM(order_total) DESC) AS rnk
FROM blinkit_orders
GROUP BY customer_id;

-- 42. Dense Rank Products
SELECT product_id,
SUM(quantity) AS qty,
DENSE_RANK() OVER(ORDER BY SUM(quantity) DESC) AS rnk
FROM blinkit_order_items
GROUP BY product_id;

-- 43. Revenue Difference Day Wise
SELECT order_date,
SUM(order_total) AS revenue,
LAG(SUM(order_total)) OVER(ORDER BY order_date) AS prev_revenue
FROM blinkit_orders
GROUP BY order_date;

-- 44. Moving Average Revenue
SELECT order_date,
AVG(order_total) OVER(ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS moving_avg
FROM blinkit_orders;

-- 45. Top 3 Customers per Area
SELECT *
FROM (
SELECT c.area,
       o.customer_id,
       SUM(o.order_total) AS revenue,
       RANK() OVER(PARTITION BY c.area ORDER BY SUM(o.order_total) DESC) AS rnk
FROM blinkit_orders o
JOIN blinkit_customers c
ON o.customer_id=c.customer_id
GROUP BY c.area,o.customer_id
) t
WHERE rnk<=3;

-- 					MORE IMPORTANT INTERVIEW QUERIES 

-- 46. Top 5 Revenue Days
SELECT order_date,
SUM(order_total) AS revenue
FROM blinkit_orders
GROUP BY order_date
ORDER BY revenue DESC
LIMIT 5;

/*
Highest sales days. Business Insight: Helps identify peak demand periods.
Businesses optimize staffing and promotions.
*/

-- 47. Customer Churn Analysis
SELECT customer_id
FROM blinkit_customers
WHERE total_orders=0;

-- 48. Revenue Growth Percentage
SELECT DATE_FORMAT(order_date,'%Y-%m') AS month,
SUM(order_total) AS revenue
FROM blinkit_orders
GROUP BY month;

-- 49. Product Contribution Percentage
SELECT product_id,
SUM(quantity*unit_price) AS revenue
FROM blinkit_order_items
GROUP BY product_id;

-- 50. Pareto 80/20 Analysis
SELECT customer_id,
SUM(order_total) AS revenue
FROM blinkit_orders
GROUP BY customer_id
ORDER BY revenue DESC;

-- 51. Most Popular Payment Method
SELECT payment_method,
COUNT(*) AS orders_count
FROM blinkit_orders
GROUP BY payment_method
ORDER BY orders_count DESC;

-- 52. Category Wise Average Revenue
SELECT p.category,
AVG(oi.quantity*oi.unit_price) AS avg_revenue
FROM blinkit_order_items oi
JOIN blinkit_products p
ON oi.product_id=p.product_id
GROUP BY p.category;

-- 53. Highest Quantity Order
SELECT order_id,
SUM(quantity) AS total_qty
FROM blinkit_order_items
GROUP BY order_id
ORDER BY total_qty DESC;

-- 54. Average Quantity per Order
SELECT AVG(quantity)
FROM blinkit_order_items;

-- 55. Top Pincode by Orders
SELECT c.pincode,
COUNT(o.order_id) AS total_orders
FROM blinkit_orders o
JOIN blinkit_customers c
ON o.customer_id=c.customer_id
GROUP BY c.pincode
ORDER BY total_orders DESC;

-- 56. Revenue by Brand
SELECT p.brand,
SUM(oi.quantity*oi.unit_price) AS revenue
FROM blinkit_order_items oi
JOIN blinkit_products p
ON oi.product_id=p.product_id
GROUP BY p.brand;

-- 57. Orders by Segment
SELECT c.customer_segment,
COUNT(o.order_id)
FROM blinkit_orders o
JOIN blinkit_customers c
ON o.customer_id=c.customer_id
GROUP BY c.customer_segment;

-- 58. Average Margin by Category
SELECT category,
AVG(margin_percentage)
FROM blinkit_products
GROUP BY category;

-- 59. Fastest Selling Categories
SELECT p.category,
SUM(oi.quantity) AS qty
FROM blinkit_order_items oi
JOIN blinkit_products p
ON oi.product_id=p.product_id
GROUP BY p.category
ORDER BY qty DESC;

-- 60. Customer Purchase Frequency
SELECT customer_id,
COUNT(order_id) AS frequency
FROM blinkit_orders
GROUP BY customer_id;

-- 61. Revenue Contribution by Top 10 Customers
SELECT customer_id,
SUM(order_total) AS revenue
FROM blinkit_orders
GROUP BY customer_id
ORDER BY revenue DESC
LIMIT 10;

-- 62. Orders Above Average Revenue
SELECT *
FROM blinkit_orders
WHERE order_total > (SELECT AVG(order_total) FROM blinkit_orders);

-- 63. Customers with Highest Frequency
SELECT customer_id,
COUNT(order_id) AS orders_count
FROM blinkit_orders
GROUP BY customer_id
ORDER BY orders_count DESC;

-- 64. Most Expensive Product Sold
SELECT product_name,
mrp
FROM blinkit_products
ORDER BY mrp DESC
LIMIT 1;

-- 65. Top Selling Brand
SELECT p.brand,
SUM(oi.quantity) AS total_qty
FROM blinkit_order_items oi
JOIN blinkit_products p
ON oi.product_id=p.product_id
GROUP BY p.brand
ORDER BY total_qty DESC;

-- 66. Daily Order Count Trend
SELECT order_date,
COUNT(order_id)
FROM blinkit_orders
GROUP BY order_date;

-- 67. Revenue per Customer Segment
SELECT c.customer_segment,
SUM(o.order_total)
FROM blinkit_orders o
JOIN blinkit_customers c
ON o.customer_id=c.customer_id
GROUP BY c.customer_segment;

-- 68. Product Count per Brand
SELECT brand,
COUNT(*)
FROM blinkit_products
GROUP BY brand;

-- 69. Orders with Multiple Products
SELECT order_id,
COUNT(product_id)
FROM blinkit_order_items
GROUP BY order_id
HAVING COUNT(product_id)>1;

-- 70. Average Basket Size
SELECT AVG(total_products)
FROM (
SELECT order_id,
COUNT(product_id) AS total_products
FROM blinkit_order_items
GROUP BY order_id
) t;

-- 71. Product Revenue Share
SELECT product_id,
SUM(quantity*unit_price) AS revenue
FROM blinkit_order_items
GROUP BY product_id;

-- 72. Monthly Customer Growth
SELECT DATE_FORMAT(registration_date,'%Y-%m') AS month,
COUNT(*)
FROM blinkit_customers
GROUP BY month;

-- 73. Average Revenue per Area
SELECT c.area,
AVG(o.order_total)
FROM blinkit_orders o
JOIN blinkit_customers c
ON o.customer_id=c.customer_id
GROUP BY c.area;

-- 74. Most Profitable Categories
SELECT category,
AVG(margin_percentage)
FROM blinkit_products
GROUP BY category
ORDER BY AVG(margin_percentage) DESC;

-- 75. Highest Margin Products
SELECT product_name,
margin_percentage
FROM blinkit_products
ORDER BY margin_percentage DESC;

-- 76. Low Performing Categories
SELECT p.category,
SUM(oi.quantity) AS qty
FROM blinkit_order_items oi
JOIN blinkit_products p
ON oi.product_id=p.product_id
GROUP BY p.category
ORDER BY qty ASC;

-- 77. Repeat Purchase Rate
SELECT COUNT(DISTINCT customer_id)
FROM blinkit_orders
GROUP BY customer_id
HAVING COUNT(order_id)>1;

-- 78. Revenue Forecast Trend
SELECT DATE_FORMAT(order_date,'%Y-%m') AS month,
SUM(order_total)
FROM blinkit_orders
GROUP BY month;

-- 79. Top 10 Product Categories by Revenue
SELECT p.category,
SUM(oi.quantity*oi.unit_price) AS revenue
FROM blinkit_order_items oi
JOIN blinkit_products p
ON oi.product_id=p.product_id
GROUP BY p.category
ORDER BY revenue DESC
LIMIT 10;

-- 80. Maximum Revenue Month
SELECT DATE_FORMAT(order_date,'%Y-%m') AS month,
SUM(order_total) AS revenue
FROM blinkit_orders
GROUP BY month
ORDER BY revenue DESC
LIMIT 1;

-- 81. Minimum Revenue Month
SELECT DATE_FORMAT(order_date,'%Y-%m') AS month,
SUM(order_total) AS revenue
FROM blinkit_orders
GROUP BY month
ORDER BY revenue ASC
LIMIT 1;

-- 82. Top Revenue Customers by Segment
SELECT c.customer_segment,
       o.customer_id,
       SUM(o.order_total) AS revenue
FROM blinkit_orders o
JOIN blinkit_customers c
ON o.customer_id=c.customer_id
GROUP BY c.customer_segment,o.customer_id;

-- 83. Area Wise Customer Density
SELECT area,
COUNT(*) AS customers
FROM blinkit_customers
GROUP BY area;

-- 84. Revenue Distribution Analysis
SELECT order_total,
COUNT(*)
FROM blinkit_orders
GROUP BY order_total;

-- 85. Average Delivery Trend
SELECT AVG(actual_delivery_time)
FROM blinkit_orders;

-- 86. High Value Orders
SELECT *
FROM blinkit_orders
WHERE order_total>1000;

-- 87. Product Price Distribution
SELECT mrp,
COUNT(*)
FROM blinkit_products
GROUP BY mrp;

-- 88. Most Common Order Size
SELECT quantity,
COUNT(*)
FROM blinkit_order_items
GROUP BY quantity
ORDER BY COUNT(*) DESC;

-- 89. Revenue Variance
SELECT STDDEV(order_total)
FROM blinkit_orders;

-- 90. Sales Trend Analysis
SELECT order_date,
SUM(order_total)
FROM blinkit_orders
GROUP BY order_date;

-- 91. Customer Retention Analysis
SELECT customer_id,
COUNT(order_id)
FROM blinkit_orders
GROUP BY customer_id;

-- 92. Product Demand Forecasting
SELECT product_id,
SUM(quantity)
FROM blinkit_order_items
GROUP BY product_id;

-- 93. Seasonal Sales Analysis
SELECT MONTH(order_date),
SUM(order_total)
FROM blinkit_orders
GROUP BY MONTH(order_date);

-- 94. Revenue Spike Detection
SELECT order_date,
SUM(order_total) AS revenue
FROM blinkit_orders
GROUP BY order_date
ORDER BY revenue DESC;

-- 95. Executive KPI Dashboard Query
SELECT
COUNT(order_id) AS total_orders,
SUM(order_total) AS total_revenue,
AVG(order_total) AS avg_order_value
FROM blinkit_orders;
