SELECT TOP (1000) [ReviewID]
      ,[CustomerID]
      ,[ProductID]
      ,[ReviewDate]
      ,[Rating]
      ,[ReviewText]
  FROM [PortfolioProject_MarketingAnalytics].[dbo].[customer_reviews]
-- Check column data types
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customer_reviews';
-- Check duplicate ReviewID
SELECT ReviewID, COUNT(*)
FROM dbo.customer_reviews
GROUP BY ReviewID
HAVING COUNT(*) > 1;
-- Result: no duplicated
-- Check NULL values
SELECT *
FROM dbo.customer_reviews
WHERE ReviewID IS NULL
   OR CustomerID IS NULL
   OR ProductID IS NULL
   OR ReviewDate IS NULL
   OR Rating IS NULL;
-- Result: no NULL
-- Check invalid rating values
SELECT *
FROM dbo.customer_reviews
WHERE Rating < 1 OR Rating > 5;
-- Result: all valid

