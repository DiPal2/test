CREATE OR ALTER PROCEDURE dbo.PopulateAggDataAll
AS
BEGIN
  CREATE TABLE #AggSalesDaily(
    DateId INT NOT NULL
   ,StoreId SMALLINT NOT NULL
   ,ProductId VARCHAR(20) NOT NULL
   ,AggNetSales NUMERIC(20,2) NOT NULL
   ,AggSalesUnits INT NOT NULL
  );

  INSERT INTO #AggSalesDaily(
         DateId
        ,StoreId
        ,ProductId
        ,AggNetSales
        ,AggSalesUnits)
  SELECT DateId
        ,StoreId
        ,ProductId
        ,SUM(NetSales)
        ,SUM(SalesUnits)
  FROM dbo.StagingSales
  GROUP BY DateId
          ,StoreId
          ,ProductId;

  TRUNCATE TABLE dbo.AggSalesWeekly;

  INSERT INTO dbo.AggSalesWeekly(
         DateCalendarYear
        ,WeekNumberOfSeason
        ,StoreId
        ,ProductId
        ,AggNetSales
        ,AggSalesUnits)
  SELECT c.DateCalendarYear
        ,c.WeekNumberOfSeason
        ,r.StoreId
        ,r.ProductId
        ,SUM(r.AggNetSales)
        ,SUM(r.AggSalesUnits)
  FROM #AggSalesDaily r
  INNER JOIN dbo.StagingCalendar c
          ON c.DateKey = r.DateId
  GROUP BY c.DateCalendarYear
          ,c.WeekNumberOfSeason
          ,r.StoreId
          ,r.ProductId;
END;
