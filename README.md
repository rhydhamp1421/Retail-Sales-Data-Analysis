## Retail Sales Data Analysis

### Overview
This project focuses on analyzing retail sales data to uncover patterns in sales trends, top-performing products, customer behavior, and revenue generation. By studying this data, the goal is to provide insights that can help optimize sales strategies and enhance business performance.

### Data Source
The dataset for this project is sourced from the Kaggle Walmart Sales Forecasting Competition. It includes transaction records from three retail branches in Mandalay, Yangon, and Naypyitaw.

### Objectives
- Determine the best-performing branches and product lines.
- Analyze sales patterns across different timeframes (daily, monthly).
- Understand customer purchasing behavior.
- Evaluate sales strategies and suggest improvements.

### Dataset Description
The dataset contains 1000 records with the following key attributes:

| Column                  | Description                                      |
|-------------------------|--------------------------------------------------|
| invoice_id             | Unique identifier for each transaction          |
| branch                | Store branch where the sale was recorded        |
| city                  | City where the branch is located                |
| customer_type         | Category of customer (e.g., member, non-member) |
| gender                | Customer's gender                               |
| product_line          | Product category                                |
| unit_price           | Price per unit of the product                    |
| quantity             | Number of units purchased                        |
| VAT                  | Value-added tax applied to the purchase          |
| total                | Final amount paid including VAT                  |
| date                 | Date of transaction                              |
| time                 | Time of purchase                                |
| payment_method       | Payment method used                              |
| cogs                 | Cost of Goods Sold (COGS)                        |
| gross_margin_percentage | Profit margin percentage                     |
| gross_income         | Profit generated from the transaction            |
| rating               | Customer rating of the transaction               |

### Analytical Approaches
#### Product Analysis
- Identify the best and worst-performing product lines.
- Analyze revenue contribution by each product line.
- Determine the most popular payment method.

#### Sales Analysis
- Track sales trends over different days and months.
- Identify peak sales hours and busiest days.
- Compare branch-wise sales performance.

#### Customer Analysis
- Segment customers based on purchasing patterns.
- Analyze gender distribution per branch.
- Determine the most profitable customer segment.
- Identify peak hours for customer ratings.

### Data Processing Steps
#### 1. Data Cleaning & Preprocessing
- Checked for and handled missing or inconsistent values.
- Structured the dataset into an SQL database.
- Enforced data integrity through constraints.

#### 2. Feature Engineering
- Added a `time_of_day` feature to classify transactions into Morning, Afternoon, or Evening.
- Extracted `day_name` and `month_name` for analyzing sales trends by weekdays and months.

#### 3. Exploratory Data Analysis (EDA)
- Statistical and graphical analysis were conducted to extract key business insights.

### Business Questions To Answer
#### Generic Questions
- How many unique cities does the data have?
- In which city is each branch?

#### Product
- How many unique product lines does the data have?
- What is the most common payment method?
- What is the most selling product line?
- What is the total revenue by month?
- What month had the largest COGS?
- What product line had the largest revenue?
- What is the city with the largest revenue?
- What product line had the largest VAT?
- Fetch each product line and add a column to those product lines showing "Good", "Bad". Good if it's greater than average sales.
- Which branch sold more products than the average product sold?
- What is the most common product line by gender?
- What is the average rating of each product line?

#### Sales
- Number of sales made in each time of the day per weekday.
- Which of the customer types brings the most revenue?
- Which city has the largest tax percent/ VAT (Value Added Tax)?
- Which customer type pays the most in VAT?

#### Customer
- How many unique customer types does the data have?
- How many unique payment methods does the data have?
- What is the most common customer type?
- Which customer type buys the most?
- What is the gender of most of the customers?
- What is the gender distribution per branch?
- Which time of the day do customers give the most ratings?
- Which time of the day do customers give the most ratings per branch?
- Which day of the week has the best average ratings?
- Which day of the week has the best average ratings per branch?

### Revenue & Profit Formulas
- **COGS (Cost of Goods Sold):** `unit_price * quantity`
- **VAT (5% of COGS):** `0.05 * COGS`
- **Total Revenue:** `COGS + VAT`
- **Gross Profit:** `Total Revenue - COGS`
- **Gross Margin (%):** `(Gross Profit / Total Revenue) * 100`

### Example Calculation
For a transaction with:
- **Unit Price** = $45.79
- **Quantity** = 7

Computed Values:
- **COGS** = `45.79 * 7 = 320.53`
- **VAT** = `0.05 * 320.53 = 16.03`
- **Total Revenue** = `320.53 + 16.03 = 336.56`
- **Gross Margin** = `(16.03 / 336.56) * 100 ≈ 4.76%`

### SQL Database Schema
```sql
-- Create database
CREATE DATABASE IF NOT EXISTS retailSales;

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
```

### Technologies Used
- SQL (MySQL) for database management and querying.
- Excel for data manipulation and analysis.
- Pandas & NumPy for calculations (in Excel).
- Matplotlib & Seaborn (optional for visualization if needed).

### Conclusion
This project provides valuable insights into retail sales data, helping businesses optimize sales strategies and improve customer experience. Future enhancements could involve advanced forecasting techniques or deeper machine learning-based analysis.

### How to Use This Project
1. Clone the repository.
2. Import the dataset into an SQL database.
3. Run SQL queries to extract insights.
4. Use Excel for advanced data analysis and visualization.

### Author
Rhydham Prajapati

