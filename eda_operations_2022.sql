SELECT * FROM operations_info;

--total sum for operations
SELECT 
	SUM(totalamount) AS sum_total_operations
	FROM operations_info --total sum was $6,748,027.88

--how many operations were done for the year?
SELECT
	COUNT(operationid) AS number_of_operations
	FROM operations_info; -133

--What operation cost the most?
SELECT 
	SUM(totalamount) AS max_operation,
	operationdescription AS operation_desc
 	FROM operations_info
	GROUP BY operation_desc
	ORDER BY max_operation DESC
	LIMIT 1; --the investment and contingency fund

--Full View of each operation expense
SELECT 
	SUM(totalamount) AS max_operation,
	operationdescription AS operation_desc
 	FROM operations_info
	GROUP BY operation_desc
	ORDER BY max_operation DESC;

--descriptive statistics
SELECT 
	operationdescription AS operation_name,
	ROUND(AVG(totalamount),2) AS avg_amount,
	MIN(totalamount) AS min_amount,
	MAX(totalamount) AS max_amount
	FROM operations_info
	GROUP BY operationdescription
	ORDER BY operationdescription DESC;

--Trend analysis 
SELECT 
    DATE_TRUNC('month', operationdate) AS trend_month, 
    SUM(totalamount) AS monthly_expenses
	FROM operations_info
	GROUP BY trend_month
	ORDER BY trend_month;