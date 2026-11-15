-- MySQL 8.0+ | 30 business analysis queries
USE ecommerce_business_analysis;

-- 01 Dataset size
SELECT COUNT(*) AS line_items, COUNT(DISTINCT Order_ID) AS orders, COUNT(DISTINCT Customer_ID) AS customers FROM superstore;

-- 02 Overall KPIs
SELECT SUM(Sales) AS total_sales, SUM(Profit) AS total_profit, SUM(Profit)/NULLIF(SUM(Sales),0) AS profit_margin, SUM(Quantity) AS units_sold FROM superstore;

-- 03 Monthly sales
SELECT Order_Year_Month, SUM(Sales) AS monthly_sales FROM superstore GROUP BY Order_Year_Month ORDER BY Order_Year_Month;

-- 04 Monthly profit
SELECT Order_Year_Month, SUM(Profit) AS monthly_profit FROM superstore GROUP BY Order_Year_Month ORDER BY Order_Year_Month;

-- 05 Sales by category
SELECT Category, SUM(Sales) AS sales FROM superstore GROUP BY Category ORDER BY sales DESC;

-- 06 Profit by category
SELECT Category, SUM(Profit) AS profit FROM superstore GROUP BY Category ORDER BY profit DESC;

-- 07 Sub-category performance
SELECT Sub_Category, SUM(Sales) AS sales, SUM(Profit) AS profit FROM superstore GROUP BY Sub_Category ORDER BY sales DESC;

-- 08 Regional performance
SELECT Region, SUM(Sales) AS sales, SUM(Profit) AS profit FROM superstore GROUP BY Region ORDER BY sales DESC;

-- 09 State performance
SELECT State, SUM(Sales) AS sales FROM superstore GROUP BY State ORDER BY sales DESC;

-- 10 Top products
SELECT Product_ID, Product_Name, SUM(Sales) AS sales FROM superstore GROUP BY Product_ID, Product_Name ORDER BY sales DESC LIMIT 10;

-- 11 Lowest-profit products
SELECT Product_ID, Product_Name, SUM(Profit) AS profit FROM superstore GROUP BY Product_ID, Product_Name ORDER BY profit ASC LIMIT 10;

-- 12 Customer segments
SELECT Segment, COUNT(DISTINCT Customer_ID) AS customers, SUM(Sales) AS sales, SUM(Profit) AS profit FROM superstore GROUP BY Segment ORDER BY sales DESC;

-- 13 Average order value
SELECT SUM(order_sales)/COUNT(*) AS average_order_value FROM (SELECT Order_ID, SUM(Sales) AS order_sales FROM superstore GROUP BY Order_ID) x;

-- 14 Orders by year
SELECT Order_Year, COUNT(DISTINCT Order_ID) AS orders FROM superstore GROUP BY Order_Year ORDER BY Order_Year;

-- 15 Shipping mode
SELECT Ship_Mode, COUNT(DISTINCT Order_ID) AS orders, AVG(Shipping_Days) AS avg_shipping_days, SUM(Sales) AS sales FROM superstore GROUP BY Ship_Mode ORDER BY orders DESC;

-- 16 Discount bands
SELECT CASE WHEN Discount=0 THEN 'No discount' WHEN Discount<=0.2 THEN '1-20%' WHEN Discount<=0.4 THEN '21-40%' ELSE 'Above 40%' END AS discount_band, COUNT(*) AS lines, SUM(Sales) AS sales, SUM(Profit) AS profit FROM superstore GROUP BY discount_band;

-- 17 Discount profitability
SELECT Discount, COUNT(*) AS line_items, SUM(Sales) AS sales, SUM(Profit) AS profit FROM superstore GROUP BY Discount ORDER BY Discount;

-- 18 Loss-making subcategories
SELECT Sub_Category, SUM(Sales) AS sales, SUM(Profit) AS profit FROM superstore GROUP BY Sub_Category HAVING SUM(Profit)<0 ORDER BY profit;

-- 19 Top customers
SELECT Customer_ID, Customer_Name, SUM(Sales) AS sales, SUM(Profit) AS profit FROM superstore GROUP BY Customer_ID, Customer_Name ORDER BY sales DESC LIMIT 10;

-- 20 Repeat customers
SELECT COUNT(*) AS repeat_customers FROM (SELECT Customer_ID FROM superstore GROUP BY Customer_ID HAVING COUNT(DISTINCT Order_ID)>1) x;

-- 21 Customer order frequency
SELECT order_count, COUNT(*) AS customers FROM (SELECT Customer_ID, COUNT(DISTINCT Order_ID) AS order_count FROM superstore GROUP BY Customer_ID) x GROUP BY order_count ORDER BY order_count;

-- 22 Profit margin by category
SELECT Category, SUM(Profit)/NULLIF(SUM(Sales),0) AS profit_margin FROM superstore GROUP BY Category ORDER BY profit_margin DESC;

-- 23 City sales leaders
SELECT City, State, SUM(Sales) AS sales FROM superstore GROUP BY City, State ORDER BY sales DESC LIMIT 15;

-- 24 Shipping duration
SELECT Ship_Mode, ROUND(AVG(Shipping_Days),2) AS avg_days, MIN(Shipping_Days) AS min_days, MAX(Shipping_Days) AS max_days FROM superstore GROUP BY Ship_Mode;

-- 25 Year-over-year sales
WITH yearly AS (SELECT Order_Year, SUM(Sales) AS sales FROM superstore GROUP BY Order_Year) SELECT Order_Year, sales, LAG(sales) OVER(ORDER BY Order_Year) AS prior_year_sales, (sales-LAG(sales) OVER(ORDER BY Order_Year))/NULLIF(LAG(sales) OVER(ORDER BY Order_Year),0) AS yoy_growth FROM yearly;

-- 26 Rank subcategories
SELECT Sub_Category, SUM(Profit) AS profit, DENSE_RANK() OVER(ORDER BY SUM(Profit) DESC) AS profit_rank FROM superstore GROUP BY Sub_Category;

-- 27 Running monthly sales
WITH monthly AS (SELECT Order_Year_Month, SUM(Sales) AS sales FROM superstore GROUP BY Order_Year_Month) SELECT Order_Year_Month, sales, SUM(sales) OVER(ORDER BY Order_Year_Month) AS running_sales FROM monthly;

-- 28 Multi-line orders
SELECT Order_ID, COUNT(*) AS line_items, SUM(Sales) AS order_sales FROM superstore GROUP BY Order_ID HAVING COUNT(*)>1 ORDER BY line_items DESC LIMIT 20;

-- 29 Top category by region
WITH regional AS (SELECT Region, Category, SUM(Sales) AS sales, DENSE_RANK() OVER(PARTITION BY Region ORDER BY SUM(Sales) DESC) AS rnk FROM superstore GROUP BY Region, Category) SELECT Region, Category, sales FROM regional WHERE rnk=1;

-- 30 Month-over-month growth
WITH m AS (SELECT Order_Year_Month, SUM(Sales) AS sales FROM superstore GROUP BY Order_Year_Month), x AS (SELECT Order_Year_Month, sales, LAG(sales) OVER(ORDER BY Order_Year_Month) AS prev_sales FROM m) SELECT Order_Year_Month, sales, prev_sales, (sales-prev_sales)/NULLIF(prev_sales,0) AS mom_growth FROM x;

