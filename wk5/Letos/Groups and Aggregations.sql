-- Total Number of Customer Records

SELECT COUNT(*) 
FROM Customers;

-- (6)

-- Now change the title from Count* to Total Customers

SELECT COUNT(*) AS "Total Customers"
FROM Customers;

-- Count specific column 

SELECT COUNT(email) AS "Total Emails"
FROM Customers;

-- Count specific column excluding nulls

SELECT COUNT(customer_id) AS "Total Customers Not Null"
FROM Customers
WHERE customer_id IS NOT NULL

-- Distinct vs NNot Distinct

SELECT COUNT (DISTINCT city) AS "Total of Distinct Cities"
FROM Branches;

-- (5)

SELECT COUNT (city) AS "Total of Distinct Cities"
FROM Branches;

-- (8)

-- SUM

SELECT SUM(total_amount) AS "Order Total"
FROM Orders;

-- (601.5)

SELECT SUM(total_amount) AS "Order Total"
FROM Orders
WHERE total_amount != '200.00';

-- (401.5)

-- AVE 

SELECT AVG (total_amount) AS "Average Amount"
FROM Orders;

-- 120.3

SELECT AVG (total_amount) AS "Average Amount"
FROM Orders
WHERE customer_id = 1;

-- (175)

SELECT AVG (total_amount) AS "Average Amount"
FROM Orders
WHERE order_date BETWEEN 'Jan 01 2023' AND 'Jan 31 2023';

--112.75

-- MIN / MAX

SELECT MIN (total_amount) AS "Lowest Price", MAX (total_amount) AS "Highest Price"
FROM Orders;


SELECT COUNT (*) AS "Total Number of Purchases", AVG(price) AS "Average Price", MIN(price) AS "Minimum Price", MAX(price) AS "Maximum Price", SUM(price) AS "Total Purchase Amount"
FROM Purchases;

-- 40	1.145	0.99	1.49	45.8

-- GROUP BY

SELECT city, COUNT (*) AS "Number of Patrons"
FROM Patrons 
GROUP BY city;

SELECT city AS "City", COUNT (*) AS "Number of Patrons"
FROM Patrons 
GROUP BY city;

Authors by Publication Year

-- HAVING

SELECT city AS "City", COUNT (*) AS "Number of Patrons"
FROM Patrons 
GROUP BY city
HAVING COUNT(*) > 5;










