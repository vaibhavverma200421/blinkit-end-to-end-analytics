CREATE TABLE blinkit_raw (
    ItemFatContent TEXT,
    ItemIdentifier TEXT,
    ItemType TEXT,
    OutletEstablishmentYear TEXT,
    OutletIdentifier TEXT,
    OutletLocationType TEXT,
    OutletSize TEXT,
    OutletType TEXT,
    ItemVisibility TEXT,
    ItemWeight TEXT,
    TotalSales TEXT,
    Rating TEXT
);

SELECT * FROM blinkit_raw;


CREATE TABLE blinkit_sales AS 
SELECT 
    ItemFatContent,
    ItemIdentifier,
    ItemType,
    OutletEstablishmentYear::INT,
    OutletIdentifier,
    OutletLocationType,
    OutletSize,
    OutletType,
    ItemVisibility::FLOAT,
    ItemWeight::FLOAT,
    TotalSales::FLOAT,
    Rating::FLOAT
FROM blinkit_raw;


-- OVERVIEW

SELECT * FROM blinkit_sales;


-- ROWS

SELECT COUNT(*) 
FROM blinkit_sales;


-- FIXING COLUMN ---->  itemfatcontent

UPDATE  blinkit_sales
SET itemfatcontent = 'Low Fat'
WHERE itemfatcontent = 'LF';

UPDATE  blinkit_sales
SET itemfatcontent = 'Low Fat'
WHERE itemfatcontent = 'low fat';

UPDATE blinkit_sales
SET itemfatcontent = 'Regular'
WHERE  itemfatcontent = 'reg';

-- CHECKING FOR ANY IRREGULARITIES


SELECT DISTINCT
               itemfatcontent
FROM blinkit_sales;


-- THE COLUMN totalsales HAS TOO MANY DECIMAL VALUES SO LET'S FIX THAT 

ALTER TABLE blinkit_sales
ALTER COLUMN totalsales TYPE INTEGER;

-- CHECKING
SELECT totalsales FROM blinkit_sales;

SELECT * FROM blinkit_sales;


-- CHECKING NULLS IN totalsales
SELECT 
        totalsales
FROM blinkit_sales
WHERE totalsales IS NULL;                 -- no nulls

-- CHECKING NULLS IN RATING
SELECT 
       rating
FROM blinkit_sales
WHERE rating IS NULL;                     -- no nulls

-- CHECKING NULLS IN itemweight
SELECT 
       itemweight
FROM blinkit_Sales
WHERE itemweight IS NULL;                 --  nulls detected

-- FIXING NULLS IN itemweight COLUMN 

-- we are applying average grouping in nulls 

UPDATE blinkit_sales b
SET itemweight =  (
        SELECT 
		AVG(itemweight)
		FROM blinkit_Sales
		WHERE itemtype = b.itemtype
        AND itemweight IS NOT NULL 			  
)
WHERE itemweight IS NULL;	

-- LET'S CHECK FOR NULLS

SELECT 
       itemweight
FROM blinkit_sales
WHERE itemweight IS NULL;
-- NO NULLS FOUND 




-- REQUIRED Busisess KPIs


-- Total sales

SELECT 
       CAST(SUM(totalsales) /1000000.0 AS DECIMAL(10,2)) AS total_Sales_millions         
FROM blinkit_sales;

---->  1.20 Millions


-- Average sales

SELECT 
       ROUND(AVG(totalsales),2) AS average_sales
FROM blinkit_sales;

--->  140.99



-- Number of items
SELECT * FROM blinkit_sales;

SELECT DISTINCT
       COUNT(itemidentifier) AS number_of_items
FROM blinkit_Sales;

----> 8523


-- Average rating

SELECT 
     CAST(AVG(rating) AS DECIMAL(10,2)) AS average_rating
FROM blinkit_sales;

--->  3.97



--                                    REQUIRED BUSINESS Granular Requirements


-- OBJECTIVE ----->  Analyze the impact of fat content on total sales.

SELECT * FROM blinkit_Sales;

SELECT  
        itemfatcontent,
	    CAST(SUM(totalsales)/ 1000000.0 AS DECIMAL(10,2)) AS toatl_Sales                      
FROM blinkit_sales
GROUP BY 1


-- Regular - 0.43 Million
-- Low Fat - 0.78 Million



-- Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.


-- AVERAGE SALES BASED ON FATS
SELECT 
       itemfatcontent,
	   ROUND(AVG(totalsales),2) AS average_Sales
FROM blinkit_sales
GROUP BY itemfatcontent;


-- Regular - 141.50
-- Low Fat - 140.71



-- NUMBER OF ITEMS BASED ON FATS
SELECT 
       itemfatcontent,
	   COUNT(*) AS Number_of_items
FROM blinkit_Sales
GROUP BY 1;
	   

-- Regular - 3006
-- Low Fat - 5517



-- AVERAGE RATING BASED ON FATS
SELECT 
       itemfatcontent,
	   CAST(AVG(rating) AS DECIMAL(10,2)) AS average_rating
FROM blinkit_Sales
GROUP BY 1;


Regular - 3.97
Low Fat - 3.97
	   


SELECT * FROM blinkit_Sales;

-- TOTAL SALES | AVERAGE SALES | NUMBER OF ITEMS | AVERAGE RATING |  BY ITEM TYPES COLUMN 

SELECT 
       itemtype,
	   SUM(totalsales) AS total_sales,
	   ROUND(AVG(totalsales),2) AS average_Sales,
	   COUNT(*) AS number_of_items,
	   CAST(AVG(rating) AS DECIMAL(10,2)) AS average_rating
FROM blinkit_Sales
-- WHERE OUTLETESTABLISHMENTYEAR = 2020           -- it is optional 
GROUP BY itemtype
ORDER BY total_Sales DESC;
	   
	   
	   



-- COMAPRE TOTAL SALES ACROSS DIFFERENT OUTLETS SEGMENTED BY FAT CONENT 
-- Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.

SELECT * FROM blinkit_sales;


SELECT 
       outletlocationtype,
	   itemfatcontent,
	   SUM(totalsales) AS total_Sales,
	   ROUND(AVG(totalsales),2) AS average_sales,
	   COUNT(*) AS Number_of_items,
	   CAST(AVG(rating) AS DECIMAL(10,2)) AS average_rating
FROM blinkit_Sales
GROUP BY 1,2
ORDER BY total_sales DESC;
	   
	   

SELECT outletlocationtype,
	   ISNULL([Low Fat], 0) AS low_fat,
	   ISNULL([Regular], 0) AS regular
FROM 
(
       SELECT 
	          outletlocationtype,
			  itemfatcontent,
			  SUM(totalsales) AS total_sales
		FROM blinkit_sales
		GROUP BY 1,2)
AS source_table
PIVOT
(
   SUM(totalsales)
   FOR itemfatcontent IN ([Low Fat],[Regular])
) AS pivot_table
ORDER BY outletlocationtype;



-- Total Sales by Outlet Establishment:
-- Objective: Evaluate how the age or type of outlet establishment influences total sales.

SELECT * FROM blinkit_sales;

SELECT 
       outletestablishmentyear,
	   SUM(totalsales) AS total_Sales,
	   ROUND(AVG(totalsales),2) AS average_Sales
FROM blinkit_Sales
GROUP BY 1
ORDER BY 1,2 DESC;




-- Percentage of Sales by Outlet Size:
--	Objective: Analyze the correlation between outlet size and total sales.

SELECT * FROM blinkit_Sales; 


SELECT 
       outletsize,
	   CAST(SUM(totalsales) AS DECIMAL(10,2)) AS total_Sales,
	   CAST(SUM(totalsales) * 100 / SUM(SUM(totalsales)) OVER() AS DECIMAL(10,2)) AS sales_percentage
FROM blinkit_Sales
GROUP BY outletsize
ORDER BY 2 DESC;
	   



-- Sales by Outlet Location:
--	Objective: Assess the geographic distribution of sales across different locations.

SELECT * FROM blinkit_sales;


SELECT 
       outletlocationtype,
	   SUM(totalsales) AS total_sales,
	   CAST(AVG(totalsales) AS DECIMAL(10,2)) AS average_sales,
	   CAST(AVG(rating) AS DECIMAL(10,2)) AS average_rating,
	   COUNT(*) AS number_of_items
FROM blinkit_sales
GROUP BY 1
ORDER BY 2 DESC;



--  All Metrics by Outlet Type:
--	Objective: Provide a comprehensive view of all key metrics (Total Sales, Average Sales, Number of 	Items, Average Rating) broken down by different outlet types.


SELECT DISTINCT outlettype
FROM blinkit_Sales;


SELECT 
       outlettype,
	   SUM(totalsales) AS total_Sales,
	   CAST(AVG(totalsales) AS DECIMAL(10,2)) AS average_Sales,
	   CAST(AVG(rating) AS DECIMAL(10,2)) AS average_rating,
	   COUNT(*) AS number_of_items
FROM blinkit_sales
GROUP BY outlettype
ORDER BY total_sales DESC;


SELECT * FROM blinkit_sales;
















































































