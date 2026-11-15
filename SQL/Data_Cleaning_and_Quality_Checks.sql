-- MySQL 8.0+ | Data quality checks
USE ecommerce_business_analysis;
SELECT COUNT(*) AS row_count FROM superstore;
SELECT SUM(Order_ID IS NULL) AS missing_order_id,
       SUM(Order_Date IS NULL) AS missing_order_date,
       SUM(Product_ID IS NULL) AS missing_product_id,
       SUM(Sales IS NULL) AS missing_sales,
       SUM(Profit IS NULL) AS missing_profit
FROM superstore;
SELECT Row_ID, COUNT(*) AS occurrences FROM superstore GROUP BY Row_ID HAVING COUNT(*) > 1;
SELECT COUNT(*) AS invalid_shipping_dates FROM superstore WHERE Ship_Date < Order_Date;
SELECT SUM(Sales < 0) AS negative_sales_rows,
       SUM(Quantity <= 0) AS nonpositive_quantity_rows,
       SUM(Discount < 0 OR Discount > 1) AS invalid_discount_rows
FROM superstore;
CREATE OR REPLACE VIEW vw_superstore_analysis AS
SELECT *, CASE WHEN Profit < 0 THEN 'Loss' ELSE 'Profit' END AS Profit_Status
FROM superstore;
