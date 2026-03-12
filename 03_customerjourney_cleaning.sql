SELECT TOP (1000) [JourneyID]
      ,[CustomerID]
      ,[ProductID]
      ,[VisitDate]
      ,[Stage]
      ,[Action]
      ,[Duration]
  FROM [PortfolioProject_MarketingAnalytics].[dbo].[customer_journey]
-- Check column data types
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customer_journey';
-- Check unique JourneyID
SELECT JourneyID, COUNT(*)
FROM dbo.customer_journey
GROUP BY JourneyID
HAVING COUNT(*) > 1;
-- Inspect duplicated JourneyID rows
SELECT *
FROM dbo.customer_journey
WHERE JourneyID IN (
    SELECT JourneyID
    FROM dbo.customer_journey
    GROUP BY JourneyID
    HAVING COUNT(*) > 1
)
ORDER BY JourneyID;
-- Remove duplicated journey 
WITH DuplicateCTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY JourneyID, CustomerID, ProductID, VisitDate, Stage, Action, Duration
               ORDER BY JourneyID
           ) AS row_num
    FROM dbo.customer_journey
)

DELETE FROM DuplicateCTE
WHERE row_num > 1;
-- Standardize categorical values for analysis
SELECT
    JourneyID,
    CustomerID,
    ProductID,
    VisitDate,
    UPPER(Stage) AS Stage,
    UPPER(Action) AS Action,
    Duration
FROM dbo.customer_journey;
