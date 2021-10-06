WITH product AS (
   SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS Id
         ,*
   FROM dbo.StagingProduct)
,store AS (
   SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS Id
         ,*
   FROM dbo.StagingStore)
,calendar AS (
   SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS Id
         ,*
   FROM dbo.StagingCalendar)
INSERT INTO dbo.StagingSales(
       SaleId
      ,NetSales
      ,SalesUnits
      ,StoreId
      ,DateId
      ,ProductId)
SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1))
      ,(p.Id + s.Id) * c.Id * CAST(100.01 AS NUMERIC(20,2))
	  ,c.Id * (p.Id + s.Id)
	  ,s.StoreId
	  ,c.DateKey
	  ,p.ProductId
FROM product p
CROSS JOIN store s
CROSS JOIN calendar c