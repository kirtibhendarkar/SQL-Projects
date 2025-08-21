# SQL-Projects
## 1. Atliq Business SQL Analysis

This project contains a collection of SQL scripts used to analyze sales, revenue, customers, products, and market performance for Atliq Business. The analysis covers everything from sales transactions to gross/net sales reports, stored procedures, views, and advanced SQL functions such as window functions and ranking.

### Purpose

The purpose of this project is to demonstrate SQL-based business analysis by answering critical questions for Atliq’s stakeholders. It highlights how SQL can be used to generate insights for sales trends, customer performance, market segmentation, and profitability.

### Key Features

- Customer & Sales Analysis

-- Extracted sales data for key customers like Croma India.

-- Generated monthly sales reports with gross sales values.

-- Analyzed year-over-year (YoY) and month-over-month (MoM) growth.

- Gross & Net Sales Reports

-- Created detailed reports using product and pricing tables.

-- Included pre-invoice and post-invoice deductions to calculate net sales.

-- Developed database views for reusable reporting queries.

- Stored Procedures

-- get_monthly_gross_sales_for_customer → Returns monthly gross sales for any customer(s).

-- get_market_badge → Assigns a Gold/Silver badge to markets based on total sales.

- Advanced SQL Techniques

-- Used window functions (ROW_NUMBER, RANK, DENSE_RANK) for ranking products and expenses.

-- Calculated customer-wise net sales contribution.

-- Analyzed regional sales distribution with partitioned window functions.

- Top Markets & Customers

-- Identified top 5 markets by net sales for FY 2021.

-- Found top-performing products and customers based on sales data.

### Modules Covered

- Customer & Sales Transactions

- Gross Sales Reporting

- Net Sales Calculation (Pre & Post Invoice Deductions)

- Stored Procedures (Dynamic reporting and business logic)

- Database Views (Reusable reporting layers)

- Top Markets & Customers

- Window Functions Applications

- Sales contribution

- Distribution by region

- Ranking products & expenses


### Insights Generated

- Identified Croma India’s performance in FY 2021.

- Generated a monthly sales trend and revenue growth reports.

- Highlighted market segmentation (Gold vs Silver markets).

- Created dynamic SQL solutions for scalable business reporting.

# 2. COVID-19 SQL Analysis

This project demonstrates SQL-based exploratory analysis of the COVID-19 pandemic, inspired by Atliq Business case studies. Using real-world COVID datasets, the project analyzes infection rates, deaths, testing, vaccinations, and population impact across countries and continents.

### Purpose

The purpose of this project is to showcase how SQL can be used to answer critical business and public health questions. It highlights skills in data modeling, query writing, aggregations, and analytics, while providing insights into how COVID-19 impacted populations globally.

### Key Features

- Database & Table Creation – Designed an optimized schema for COVID-19 data.

- Data Loading & Cleaning – Used LOAD DATA INFILE and applied correct data types for accurate analysis.

- Global & Country-Level Analysis – Generated insights at both global and granular levels.

- Advanced SQL Functions – Applied CASE, ROUND, NULLIF, IFNULL, window-style aggregations, and percentage calculations.

- Real-World Business Relevance – Structured queries similar to how analysts support executive decision-making in industries like healthcare, consulting, and business intelligence.

### Queries & Analysis Performed
#### 1. Total COVID Cases Per Country

- Aggregated total cases and formatted results in Millions (M) and Billions (B).

- Excluded aggregate regions (e.g., World, Europe, Asia) for clean results.

#### 2. Global Totals

- Computed worldwide total cases, deaths, and Case Fatality Rate (CFR %).

#### 3. Top 10 Countries by Cases

- Ranked countries based on maximum total cases.

#### 4. Countries with Highest Death Rate

- Identified top countries by death rate (%) relative to total cases.

#### 5. Daily New Cases (Example: India)

- Extracted daily infection trends for a specific country.

#### 6. Cases vs Population

- Measured % of population infected.

- Found countries with the highest infection rates compared to population.

#### 7. Deaths Analysis

- Ranked countries with the highest total deaths.

- Compared death counts across continents.

#### 8. Global Numbers by Continent & Country

- Analyzed new cases and deaths per day.

- Computed death percentage by location and date.

#### 9. Vaccination Analysis

- Compared population vs vaccinations.

- Ranked countries by total vaccinations administered.

### Insights Generated

- The US and India rank among the top countries with the highest COVID-19 cases.

- Countries with smaller populations but high infection rates (e.g., some European nations) showed significant impact.

- The global CFR % (Case Fatality Rate) highlighted varying pandemic severity across regions.

- Vaccination campaigns differed drastically across continents, with developed nations achieving higher coverage faster.
