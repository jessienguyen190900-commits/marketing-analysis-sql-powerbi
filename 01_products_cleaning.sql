-- Check category values
SELECT DISTINCT Category
FROM dbo.products;
-- Result: only 'Sports', Category column has no analytical value
-- Remove category column
ALTER TABLE dbo.products
DROP COLUMN Category;
-- Find product names with excessive spaces
SELECT ProductName
FROM dbo.products
WHERE ProductName LIKE ' %'
   OR ProductName LIKE '% ';
-- Result: no rows returned → product names are clean
-- Check data type of all columns
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'products';
-- Result: All columns have appropriate data types
-- Clasify Price for Analysis 
-- Add Price Segment column
ALTER TABLE dbo.products
ADD PriceSegment NVARCHAR(20);
-- Categorize products based on price
SELECT 
    ProductID,
    ProductName,
    Price,

    CASE
        WHEN Price < 50 THEN 'Low'
        WHEN Price BETWEEN 50 AND 200 THEN 'Medium'
        ELSE 'High'
    END AS PriceCategory

FROM dbo.products;

