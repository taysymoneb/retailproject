SELECT * FROM total_sales;

--How do daily sales compare to monthly sales?
SELECT
	DATE_TRUNC('MONTH', orderdate) AS sale_month,
    SUM(unitprice) AS total_amount
	FROM total_sales
	GROUP BY sale_month
	ORDER BY sale_month;

--January
SELECT
	DATE_TRUNC('DAY', orderdate) AS sale_day,
    SUM(unitprice) AS total_amount
	FROM total_sales
	WHERE orderdate >= '2022-01-01' AND orderdate < '2022-02-01'
	GROUP BY sale_day
	ORDER BY sale_day;

--February
SELECT
	DATE_TRUNC('DAY', orderdate) AS sale_day,
    SUM(unitprice) AS total_amount
	FROM total_sales
	WHERE orderdate >= '2022-02-01' AND orderdate < '2022-03-01'
	GROUP BY sale_day
	ORDER BY sale_day;

--March
SELECT
	DATE_TRUNC('DAY', orderdate) AS sale_day,
    SUM(unitprice) AS total_amount
	FROM total_sales
	WHERE orderdate >= '2022-03-01' AND orderdate < '2022-04-01'
	GROUP BY sale_day
	ORDER BY sale_day;

--April
SELECT
	DATE_TRUNC('DAY', orderdate) AS sale_day,
    SUM(unitprice) AS total_amount
	FROM total_sales
	WHERE orderdate >= '2022-04-01' AND orderdate < '2022-05-01'
	GROUP BY sale_day
	ORDER BY sale_day;

--May
SELECT
	DATE_TRUNC('DAY', orderdate) AS sale_day,
    SUM(unitprice) AS total_amount
	FROM total_sales
	WHERE orderdate >= '2022-05-01' AND orderdate < '2022-06-01'
	GROUP BY sale_day
	ORDER BY sale_day;

--June
SELECT
	DATE_TRUNC('DAY', orderdate) AS sale_day,
    SUM(unitprice) AS total_amount
	FROM total_sales
	WHERE orderdate >= '2022-06-01' AND orderdate < '2022-07-01'
	GROUP BY sale_day
	ORDER BY sale_day;

--July
SELECT
	DATE_TRUNC('DAY', orderdate) AS sale_day,
    SUM(unitprice) AS total_amount
	FROM total_sales
	WHERE orderdate >= '2022-07-01' AND orderdate < '2022-08-01'
	GROUP BY sale_day
	ORDER BY sale_day;

--August
SELECT
	DATE_TRUNC('DAY', orderdate) AS sale_day,
    SUM(unitprice) AS total_amount
	FROM total_sales
	WHERE orderdate >= '2022-08-01' AND orderdate < '2022-09-01'
	GROUP BY sale_day
	ORDER BY sale_day;

--September
SELECT
	DATE_TRUNC('DAY', orderdate) AS sale_day,
    SUM(unitprice) AS total_amount
	FROM total_sales
	WHERE orderdate >= '2022-09-01' AND orderdate < '2022-10-01'
	GROUP BY sale_day
	ORDER BY sale_day;

--October
SELECT
	DATE_TRUNC('DAY', orderdate) AS sale_day,
    SUM(unitprice) AS total_amount
	FROM total_sales
	WHERE orderdate >= '2022-10-01' AND orderdate < '2022-11-01'
	GROUP BY sale_day
	ORDER BY sale_day;

--November
SELECT
	DATE_TRUNC('DAY', orderdate) AS sale_day,
    SUM(unitprice) AS total_amount
	FROM total_sales
	WHERE orderdate >= '2022-11-01' AND orderdate < '2022-12-01'
	GROUP BY sale_day
	ORDER BY sale_day;

--December
SELECT
	DATE_TRUNC('DAY', orderdate) AS sale_day,
    SUM(unitprice) AS total_amount
	FROM total_sales
	WHERE orderdate >= '2022-12-01' AND orderdate < '2023-01-01'
	GROUP BY sale_day
	ORDER BY sale_day;

SELECT * FROM item_catalog

--Are there specific products that perform better during certain times of the year?
WITH monthly_total AS (
	SELECT 
	i.itemid AS item_id,
	i.itemsold AS name_item,
	DATE_TRUNC('Month', s.orderdate) AS month_of_order,
	SUM(s.unitprice) AS amount_total
	FROM item_catalog i
	JOIN 
	total_sales s ON i.itemid = s.itemid
	GROUP BY i.itemid, i.itemsold, DATE_TRUNC('Month', s.orderdate)
	)
	SELECT
	mt.item_id,
	mt.name_item,
	mt.month_of_order,
	mt.amount_total
	FROM monthly_total mt
	JOIN
	(
	  SELECT 
		month_of_order,
		MAX(amount_total) AS top_sales
		FROM monthly_total
		GROUP BY month_of_order
	) top_sales_per_month
	ON mt.month_of_order= top_sales_per_month.month_of_order
	AND mt.amount_total = top_sales_per_month.top_sales
	ORDER BY mt.month_of_order, mt.amount_total DESC; --Rum Cake sells the most for each month

--For in person orders
WITH monthly_total AS (
	SELECT 
	i.itemid AS item_id,
	i.itemsold AS name_item,
	DATE_TRUNC('Month', s.orderdate) AS month_of_order,
	SUM(s.unitprice) AS amount_total
	FROM item_catalog i
	JOIN 
	total_sales s ON i.itemid = s.itemid
	WHERE s.onlineorder = 'False'
	GROUP BY i.itemid, i.itemsold, DATE_TRUNC('Month', s.orderdate)
	)
	SELECT
	mt.item_id,
	mt.name_item,
	mt.month_of_order,
	mt.amount_total
	FROM monthly_total mt
	JOIN
	(
	  SELECT 
		month_of_order,
		MAX(amount_total) AS top_sales
		FROM monthly_total
		GROUP BY month_of_order
	) top_sales_per_month
	ON mt.month_of_order= top_sales_per_month.month_of_order
	AND mt.amount_total = top_sales_per_month.top_sales
	ORDER BY mt.month_of_order, mt.amount_total DESC; --Rum Cake and The Banana Pudding Pound Cake sell the most for in person orders

--Online orders
WITH monthly_total AS (
	SELECT 
	i.itemid AS item_id,
	i.itemsold AS name_item,
	DATE_TRUNC('Month', s.orderdate) AS month_of_order,
	SUM(s.unitprice) AS amount_total
	FROM item_catalog i
	JOIN 
	total_sales s ON i.itemid = s.itemid
	WHERE s.onlineorder = 'true'
	GROUP BY i.itemid, i.itemsold, DATE_TRUNC('Month', s.orderdate)
	)
	SELECT
	mt.item_id,
	mt.name_item,
	mt.month_of_order,
	mt.amount_total
	FROM monthly_total mt
	JOIN
	(
	  SELECT 
		month_of_order,
		MAX(amount_total) AS top_sales
		FROM monthly_total
		GROUP BY month_of_order
	) top_sales_per_month
	ON mt.month_of_order= top_sales_per_month.month_of_order
	AND mt.amount_total = top_sales_per_month.top_sales
	ORDER BY mt.month_of_order, mt.amount_total DESC; --Rum Cake sells the most for each month for online orders

--Monthly Net Change
WITH monthly_net AS (
	SELECT 
	DATE_TRUNC('Month', orderdate) AS month_name,
	SUM(unitprice) AS total_amount
	FROM total_sales
	GROUP BY DATE_TRUNC('Month', orderdate)
	)
SELECT
	month_name,
	total_amount,
	total_amount - LAG(total_amount) OVER(ORDER BY month_name) AS net_change,
	(total_amount - LAG(total_amount)OVER(ORDER BY month_name))/ NULLIF(LAG(total_amount) OVER (ORDER BY month_name),0) * 100 AS percent_change
	FROM monthly_net;

--Overall Profit Margin
WITH totalsales AS (
    SELECT SUM(unitprice) AS totalprofit
    FROM total_sales
),
operationexpense AS (
    SELECT SUM(totalamount) AS totaloperationcost
    FROM operations_info
)
	SELECT
    totalsales.totalprofit,
    operationexpense.totaloperationcost,
    (totalsales.totalprofit - operationexpense.totaloperationcost) AS income,
    ((totalsales.totalprofit - operationexpense.totaloperationcost) / totalsales.totalprofit) * 100 AS overallprofitmargin
	FROM
    totalsales, 
    operationexpense; --13% profit margin