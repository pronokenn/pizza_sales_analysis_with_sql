select * from pizza_sales_excel_file

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value from pizza_sales_excel_file
-- Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizza_Sold from pizza_sales_excel_file

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders from pizza_sales_excel_file
-- Average Pizzas per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order
from pizza_sales_excel_file

-- Daily Trend for Total orders
SELECT DATENAME(DW, order_date) AS Order_day, COUNT(DISTINCT order_id) AS Total_Orders
from pizza_sales_excel_file
GROUP BY DATENAME(DW, order_date)

-- Monthly trend for total orders
SELECT DATENAME(MONTH, order_date) AS Month_name, COUNT(DISTINCT order_id) AS Total_Orders
from pizza_sales_excel_file
GROUP BY DATENAME(Month, order_date)
ORDER BY Total_Orders DESC

-- Percentage of sales by Pizza Category
SELECT pizza_category, SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales_excel_file) AS PCT
from pizza_sales_excel_file 
GROUP BY pizza_category

-- To filter for lets say Januart PCT
SELECT pizza_category, SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales_excel_file WHERE MONTH(order_date) = 1) AS PCT
from pizza_sales_excel_file 
WHERE MONTH(order_date) = 1
GROUP BY pizza_category
-- Percentage of sales by Pizza Size
SELECT pizza_size, SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales_excel_file) AS PCT
from pizza_sales_excel_file 
GROUP BY pizza_size
ORDER BY PCT DESC
-- % OF SALES BY Pizza Size for say 1st quarter
SELECT pizza_size, SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales_excel_file WHERE DATEPART(Quarter, order_date) = 1) AS PCT
from pizza_sales_excel_file 
WHERE DATEPART(Quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC

-- TOP 5 Pizzas By Revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue from pizza_sales_excel_file
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
-- Bottom 5 Pizzas By Revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue from pizza_sales_excel_file
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
-- Top 5 Pizzas by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity from pizza_sales_excel_file
GROUP BY pizza_name
ORDER BY Total_Quantity DESC
-- Bottom 5 Pizzas By Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity from pizza_sales_excel_file
GROUP BY pizza_name
ORDER BY Total_Quantity ASC