SELECT TOP (1000) [CustomerID]
      ,[CustomerName]
      ,[Email]
      ,[Gender]
      ,[Age]
      ,[GeographyID]
  FROM [PortfolioProject_MarketingAnalytics].[dbo].[customers]
-- Check for duplicate CustomerID
SELECT CustomerID, COUNT(*)
FROM dbo.customers
GROUP BY CustomerID
HAVING COUNT(*) > 1;
-- Result: no duplicated CustomerID
-- Check for missing values 
SELECT *
FROM dbo.customers
WHERE CustomerName IS NULL
   OR Email IS NULL
   OR Gender IS NULL
   OR Age IS NULL
   OR GeographyID IS NULL;
-- Result: no NULL value
-- Check unrealistic ages
SELECT *
FROM dbo.customers
WHERE Age < 0 OR Age > 100;
-- Result: all valid
-- Add in geography in customer table
SELECT
    c.CustomerID,
    c.CustomerName,
    c.Email,
    c.Gender,
    c.Age,
    c.GeographyID,
    g.Country,
    g.City
FROM dbo.customers c
LEFT JOIN dbo.geography g
    ON c.GeographyID = g.GeographyID;
