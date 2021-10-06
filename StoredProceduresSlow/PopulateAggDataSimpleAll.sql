CREATE OR ALTER PROCEDURE dbo.PopulateAggDataSimpleAll
AS
BEGIN
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
        ,SUM(r.NetSales)
        ,SUM(r.SalesUnits)
  FROM dbo.StagingSales r
  INNER JOIN dbo.StagingCalendar c
          ON c.DateKey = r.DateId
  GROUP BY c.DateCalendarYear
          ,c.WeekNumberOfSeason
          ,r.StoreId
          ,r.ProductId;
END;
