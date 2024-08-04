SELECT * FROM total_sales

--get a count of the total sales
SELECT 
	COUNT(DISTINCT orderid) as total_orders
	FROM total_sales; --136,698 orders were placed total

--get a count of the total online orders
SELECT 
	COUNT(DISTINCT orderid) as online_orders
	FROM total_sales
	WHERE onlineorder = 'true'; --95,740 orders were made online

--get a count of the total in person orders
SELECT 
	COUNT(DISTINCT orderid) as online_orders
	FROM total_sales
	WHERE onlineorder = 'false'; --40,958 orders were made in person

--get the total sales for 2022
SELECT
   SUM(unitprice) as total_sales_2022
   FROM total_sales; --The total sales amount for 2022 was $7,775,858.80

--total amount for online sales
SELECT
   SUM(unitprice) as total_online_2022
   FROM total_sales 
   WHERE onlineorder = 'true'; --The total sales amount for online sales for 2022 was $5,449,793.23

--total amount for in person sales
SELECT
   SUM(unitprice) as total_in_person_2022
   FROM total_sales 
   WHERE onlineorder = 'false'; --The total sales amount for in person sales for 2022 was $2,326,065.57

--total sales per month
SELECT
	DATE_TRUNC('MONTH', orderdate) AS sale_month,
    SUM(unitprice) AS total_amount
	FROM total_sales
	GROUP BY sale_month
	ORDER BY sale_month; --March had the most sales, time of mardi gras

--total sales per month for online orders
SELECT
	DATE_TRUNC('MONTH', orderdate) AS sale_month,
    SUM(unitprice) AS total_amount_online
	FROM total_sales
	WHERE onlineorder = 'true'
	GROUP BY sale_month
	ORDER BY sale_month;

--total sales per month for in person orders
SELECT
	DATE_TRUNC('MONTH', orderdate) AS sale_month,
    SUM(unitprice) AS total_amount_in_person
	FROM total_sales
	WHERE onlineorder = 'false'
	GROUP BY sale_month
	ORDER BY sale_month;

--what employee made the most sales
SELECT 
	e.employeeid,
    e.firstname,
    e.lastname,
	SUM(s.unitprice) AS total_sales_emp
	FROM employee_info e
	JOIN total_sales s
	ON e.employeeid = s.employeeid
	WHERE e.employeeid != 0
    GROUP BY e.employeeid, e.firstname, e.lastname
	ORDER BY total_sales_emp DESC
	LIMIT 1; --Anne Rause made the most sales

--What item sold the most frequently overall?
SELECT 
	i.itemID,
    i.itemsold,
    COUNT(s.itemid) AS item_sold_most
	FROM item_catalog i
    JOIN total_sales s
    ON i.itemid = s.itemid
    GROUP BY i.itemid, i.itemsold
	ORDER BY item_sold_most DESC
	LIMIT 1; --the banana pudding poundcake

--What item sold the most frequently in person?
SELECT 
	i.itemID,
    i.itemsold,
    COUNT(s.itemid) AS item_in_person
	FROM item_catalog i
    JOIN total_sales s
    ON i.itemid = s.itemid
	WHERE onlineorder = 'false'
    GROUP BY i.itemid, i.itemsold
	ORDER BY item_in_person DESC
	LIMIT 1; --the mardi gras cupcake 	

--What item sold the most frequently online?
SELECT 
	i.itemID,
    i.itemsold,
    COUNT(s.itemid) AS item_online
	FROM item_catalog i
    JOIN total_sales s
    ON i.itemid = s.itemid
	WHERE onlineorder = 'true'
    GROUP BY i.itemid, i.itemsold
	ORDER BY item_online DESC
	LIMIT 1; --the banana pudding pound cake 	
	
--What is the average price per order?
SELECT
	AVG(total_price) AS avg_price_per_order
	FROM(
	SELECT 
		orderID,
		SUM(unitprice) AS total_price
		FROM total_sales
		GROUP BY orderid
	) AS order_totals; --$56.89

--Average quantity of items in an order
SELECT 
    AVG(total_quantity) AS avg_items_per_order
FROM (
    SELECT 
        orderid,
        COUNT(itemid) AS total_quantity
    FROM 
        total_sales
    GROUP BY 
        orderid
)AS order_quantities; --The average number of items per order is four

--Hourly trend for in person orders
SELECT
	EXTRACT(HOUR FROM timeordered) AS sale_hour_in_person,
    SUM(unitprice) AS total_amount
	FROM total_sales
	WHERE onlineorder = 'false'
	GROUP BY sale_hour_in_person
	ORDER BY total_amount DESC; --10:00 AM had the most amount of sales

--Hourly trend for online orders
SELECT
	EXTRACT(HOUR FROM timeordered) AS sale_hour_online,
    SUM(unitprice) AS total_amount
	FROM total_sales
	WHERE onlineorder = 'true'
	GROUP BY sale_hour_online
	ORDER BY total_amount DESC; --8:00 AM had the most amount of sales
