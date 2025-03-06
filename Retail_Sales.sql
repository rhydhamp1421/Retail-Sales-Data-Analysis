CREATE DATABASE walmart_data;

USE walmart_data;

-- Create table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

---  -----------------------------------------------------------------------------------------------------------

---  ----------------------------------------------------------------------------------------------------------
---  ----------------------------------------------- Generic --------------------------------------------------


---  How many unique cities does the data have?
SELECT DISTINCT city AS no_of_cities
FROM sales;

---  In which city is each branch?
SELECT DISTINCT branch 
FROM sales;

SELECT
	DISTINCT city, branch
FROM sales;


---  ----------------------------------------------------------------------------------------------------------
---  ----------------------------------------------- Product --------------------------------------------------

---  How many unique product lines does the data have?
SELECT COUNT(DISTINCT product_line) AS cnt
FROM sales;

---  What is the most common payment method?
SELECT COUNT(payment) AS cnt, payment
FROM sales
GROUP BY payment
ORDER BY cnt DESC;
 
 ---  What is the most selling product line?
 SELECT COUNT(product_line) AS cnt_p, product_line
FROM sales
GROUP BY product_line
ORDER BY cnt_p DESC;

---  What is the total revenue by month?
SELECT SUM(total), month_name
FROM sales
GROUP BY month_name;

---  What month had the largest COGS?
SELECT SUM(cogs) AS cogs, month_name
FROM sales
GROUP BY month_name
ORDER BY cogs DESC;

---  What product line had the largest revenue?
SELECT SUM(total) AS total, product_line
FROM sales
GROUP BY product_line
ORDER BY total DESC;

---  What is the city with the largest revenue?
SELECT SUM(total) AS total, city
FROM sales
GROUP BY city
ORDER BY total DESC;

---  What product line had the largest VAT?
SELECT AVG(tax_pct) AS tax, product_line
FROM sales
GROUP BY product_line
ORDER BY tax DESC;

---  Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
SELECT product_line, 
	CASE 
		WHEN total > (SELECT AVG(total) FROM sales) THEN 'Good'
        ELSE 'Bad'
	END AS category
FROM sales;

---  Which branch sold more products than average product sold?
SELECt branch, SUM(quantity) AS qty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

---  What is the most common product line by gender?
SELECT gender, product_line, COUNT(gender) AS cnt
FROM sales
GROUP BY gender, product_line
ORDER BY cnt DESC;

---  What is the average rating of each product line?
SELECT product_line, ROUND(AVG(rating), 2) AS avg
FROM sales
GROUP BY product_line
ORDER BY avg DESC;


---  ----------------------------------------------------------------------------------------------------------
---  ----------------------------------------------- Sales --------------------------------------------------

---  Number of sales made in each time of the day per weekday
SELECT time_of_day, COUNT(*) AS total_sales
FROM sales
WHERE day_name = "Monday"
GROUP BY time_of_day
ORDER BY total_sales DESC;

---  Which of the customer types brings the most revenue?
SELECT customer_type, ROUND(SUM(total), 2) AS total
FROM sales
GROUP BY customer_type
ORDER BY total DESC;

---  Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT city, AVG(tax_pct) AS tax
FROM sales
GROUP BY city
ORDER BY tax DESC;

---  Which customer type pays the most in VAT?
SELECT customer_type, AVG(tax_pct) AS tax
FROM sales
GROUP BY customer_type
ORDER BY tax DESC;



---  ----------------------------------------------------------------------------------------------------------
---  ----------------------------------------------- Customer --------------------------------------------------

---  How many unique customer types does the data have?
SELECT COUNT(DISTINCT customer_type) as type
FROM sales;

---  How many unique payment methods does the data have?
SELECT COUNT(DISTINCT payment) as type
FROM sales;

---  What is the most common customer type?
SELECT customer_type, COUNT(customer_type) AS type
FROM sales
GROUP BY customer_type
ORDER BY type DESC;

---  Which customer type buys the most?
SELECT customer_type, COUNT(quantity) AS qty
FROM sales
GROUP BY customer_type
ORDER BY qty DESC;

---  What is the gender of most of the customers?
SELECT gender, COUNT(gender) AS qty
FROM sales
GROUP BY gender
ORDER BY qty DESC;

---  What is the gender distribution per branch?
SELECT gender, COUNT(gender) AS qty
FROM sales
WHERE branch = "C"
GROUP BY gender
ORDER BY qty DESC;

---  Which time of the day do customers give most ratings?
SELECT time_of_day, SUM(rating) AS rat
FROM sales
GROUP BY time_of_day
ORDER BY rat DESC;

---  Which time of the day do customers give most ratings per branch?
SELECT time_of_day, SUM(rating) AS rat
FROM sales
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY rat DESC;

---  Which day of the week has the best avg ratings?
SELECT day_name, AVG(rating) AS rat
FROM sales
GROUP BY day_name
ORDER BY rat DESC;

---  Which day of the week has the best average ratings per branch?
SELECT day_name, AVG(rating) AS rat
FROM sales
WHERE branch = "A"
GROUP BY day_name
ORDER BY rat DESC;




---  -------------------------------------------------------------------------------------------------------------
---  -----------------------------------  Feature Engineering ----------------------------------------------------


---  time_of_day 


SELECT 
	time,
    (CASE
		WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_date
FROM sales;

ALTER TABLE sales
ADD COLUMN time_of_day VARCHAR(20);


UPDATE sales
SET  time_of_day = (
CASE
		WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END	
);



--- day_name

SELECT
	date,
    DAYNAME(date)
FROM sales;

ALTER TABLE sales 
ADD COLUMN day_name VARCHAR(20); 

UPDATE sales
SET day_name = DAYNAME(date);


---  month_name

SELECT 
	date,
    MONTHNAME(date)
FROM sales;

ALTER TABLE sales
ADD COLUMN month_name VARCHAR(20);

UPDATE sales
SET month_name = MONTHNAME(date);
















