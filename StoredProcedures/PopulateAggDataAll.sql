CREATE OR ALTER PROCEDURE dbo.PopulateAggDataAll
AS
BEGIN
  TRUNCATE TABLE dbo.AggSalesDaily;

  INSERT INTO dbo.AggSalesDaily(
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
  FROM dbo.AggSalesDaily r
  INNER JOIN dbo.StagingCalendar c
          ON c.DateKey = r.DateId
  GROUP BY c.DateCalendarYear
          ,c.WeekNumberOfSeason
          ,r.StoreId
          ,r.ProductId;
END;
