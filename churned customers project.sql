SELECT *
FROM  telecom

--Checking fOr duplicate entries
SELECT Customer_ID, COUNT(Customer_ID)
FROM telecom
GROUP BY Customer_ID
HAVING COUNT(Customer_ID) > 1 

--How much revenue was lost to churned customers
SELECT SUM(Total_Revenue)
FROM telecom

SELECT Customer_status, COUNT(Customer_ID) AS num_customers, ROUND(SUM(Total_Revenue), 2) AS Revenue, CONCAT(ROUND((SUM(Total_Revenue) * 100.0 / (SELECT SUM(Total_Revenue) FROM telecom)), 2),'%') AS Percentage_Revenue
FROM telecom
GROUP BY Customer_status
ORDER BY Revenue DESC;

-- What is the typical tenure for churned customers
SELECT Customer_status, (AVG(Tenure_in_Months) * 1.0) AS Average_Tenure
FROM telecom
GROUP BY Customer_status
ORDER BY Average_Tenure DESC;

--Which cities had the highest churn rate, limit to 5
SELECT City, COUNT(City) Num_city, LEFT(ROUND(COUNT(City) * 100.0 / (SELECT COUNT(City) FROM telecom), 2), 4) + '%' pct_count
FROM telecom
WHERE Customer_status = 'churned'
GROUP BY City
ORDER BY 2 DESC
OFFSET 0 rows
FETCH next 5 rows only

--What are the general reasons for churn
SELECT Churn_Category, COUNT(Churn_Category) AS Reason_count
FROM telecom
WHERE Churn_Category IS NOT NULL
GROUP BY Churn_Category
ORDER BY Reason_count DESC

--What are the specific reasons for churn
SELECT Churn_Reason, COUNT(Churn_Reason) AS Reason_count
FROM telecom
WHERE Churn_Reason IS NOT NULL
GROUP BY Churn_Reason
ORDER BY Reason_count DESC