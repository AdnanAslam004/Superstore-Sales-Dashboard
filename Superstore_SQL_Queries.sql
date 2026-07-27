/*
============================================================
Project : Superstore Sales Analytics Dashboard
Author  : Adnan Aslam
Tools   : Microsoft SQL Server, SSMS, Grafana
Purpose : Data quality validation and business analysis
============================================================
*/

/*============================================================
SECTION 1: DATA QUALITY CHECKS
============================================================*/

-- 1. Verify total number of records
SELECT COUNT(*) AS Total_Records
FROM Superstore;

-- 2. Check missing postal codes
SELECT COUNT(*) AS Missing_Postal_Codes
FROM Superstore
WHERE Postal_Code IS NULL;

-- 3. Check duplicate Row IDs
SELECT
    Row_ID,
    COUNT(*) AS Duplicate_Count
FROM Superstore
GROUP BY Row_ID
HAVING COUNT(*) > 1;

-- 4. Check blank customer names
SELECT *
FROM Superstore
WHERE LTRIM(RTRIM(Customer_Name)) = '';

-- 5. Check blank product names
SELECT *
FROM Superstore
WHERE LTRIM(RTRIM(Product_Name)) = '';

-- 6. Check invalid shipping dates
SELECT *
FROM Superstore
WHERE Ship_Date < Order_Date;

-- 7. Check negative sales values
SELECT *
FROM Superstore
WHERE Sales < 0;


/*============================================================
SECTION 2: BUSINESS QUESTIONS
============================================================*/

-- Q1. What is the total sales revenue?
SELECT
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM Superstore;

-- Q2. Which categories generate the highest sales?
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM Superstore
GROUP BY Category
ORDER BY Total_Sales DESC;

-- Q3. What are the top 10 sub-categories by sales?
SELECT TOP 10
    Sub_Category,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM Superstore
GROUP BY Sub_Category
ORDER BY Total_Sales DESC;

-- Q4. Which regions generate the highest sales?
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM Superstore
GROUP BY Region
ORDER BY Total_Sales DESC;

-- Q5. What are the top 10 states by sales?
SELECT TOP 10
    State,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM Superstore
GROUP BY State
ORDER BY Total_Sales DESC;

-- Q6. Who are the top 10 customers by sales?
SELECT TOP 10
    Customer_ID,
    Customer_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM Superstore
GROUP BY
    Customer_ID,
    Customer_Name
ORDER BY Total_Sales DESC;

-- Q7. What are the top 10 products by sales?
SELECT TOP 10
    Product_ID,
    Product_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM Superstore
GROUP BY
    Product_ID,
    Product_Name
ORDER BY Total_Sales DESC;

-- Q8. What is the monthly sales trend?
SELECT
    DATEFROMPARTS(
        YEAR(Order_Date),
        MONTH(Order_Date),
        1
    ) AS [Time],
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM Superstore
GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date)
ORDER BY [Time];

-- Q9. Which customer segment generates the highest sales?
SELECT
    Segment,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM Superstore
GROUP BY Segment
ORDER BY Total_Sales DESC;

-- Q10. Which shipping mode receives the most orders?
SELECT
    Ship_Mode,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM Superstore
GROUP BY Ship_Mode
ORDER BY Total_Orders DESC;
