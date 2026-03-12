SELECT TOP (1000) [EngagementID]
      ,[ContentID]
      ,[ContentType]
      ,[Likes]
      ,[EngagementDate]
      ,[CampaignID]
      ,[ProductID]
      ,[ViewsClicksCombined]
  FROM [PortfolioProject_MarketingAnalytics].[dbo].[engagement_data]
-- Check duplicate EngagementID
SELECT 
    EngagementID,
    COUNT(*) AS duplicate_count
FROM dbo.engagement_data
GROUP BY EngagementID
HAVING COUNT(*) > 1;
-- Result: no duplicated
--Format data and view Clicks and Views seperately 
SELECT
    EngagementID,
    ContentID,
    CampaignID,
    ProductID,
    CASE
        WHEN UPPER(LTRIM(RTRIM(ContentType))) = 'SOCIALMEDIA' THEN 'Social Media'
        WHEN UPPER(LTRIM(RTRIM(ContentType))) = 'BLOG' THEN 'Blog'
        WHEN UPPER(LTRIM(RTRIM(ContentType))) = 'VIDEO' THEN 'Video'
        WHEN UPPER(LTRIM(RTRIM(ContentType))) = 'NEWSLETTER' THEN 'Newsletter'
        ELSE LTRIM(RTRIM(ContentType))
    END AS ContentType,
    CAST(LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) - 1) AS INT) AS Views,
    CAST(
        SUBSTRING(
            ViewsClicksCombined,
            CHARINDEX('-', ViewsClicksCombined) + 1,
            LEN(ViewsClicksCombined)
        ) AS INT
    ) AS Clicks,
    Likes,
    EngagementDate
FROM dbo.engagement_data;


