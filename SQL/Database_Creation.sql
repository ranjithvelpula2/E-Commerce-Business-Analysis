-- MySQL 8.0+ | Sample Superstore
CREATE DATABASE IF NOT EXISTS ecommerce_business_analysis;
USE ecommerce_business_analysis;
DROP TABLE IF EXISTS superstore;
CREATE TABLE superstore (
 Row_ID INT, Order_ID VARCHAR(20), Order_Date DATE, Ship_Date DATE,
 Ship_Mode VARCHAR(30), Customer_ID VARCHAR(20), Customer_Name VARCHAR(100),
 Segment VARCHAR(30), Country VARCHAR(60), City VARCHAR(80), State VARCHAR(80),
 Postal_Code INT NULL, Region VARCHAR(20), Product_ID VARCHAR(30), Category VARCHAR(40),
 Sub_Category VARCHAR(50), Product_Name VARCHAR(255), Sales DECIMAL(12,4),
 Quantity INT, Discount DECIMAL(6,4), Profit DECIMAL(12,4), Shipping_Days INT,
 Order_Year INT, Order_Month INT, Order_Month_Name VARCHAR(10),
 Order_Year_Month CHAR(7), Profit_Margin DECIMAL(12,6)
);
-- Import Dataset/Processed_Data/Cleaned_Superstore.csv using MySQL Workbench
-- Table Data Import Wizard into table superstore.
