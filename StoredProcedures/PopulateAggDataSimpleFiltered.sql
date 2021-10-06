CREATE OR ALTER PROCEDURE dbo.PopulateAggDataSimpleFiltered
  @pYear SMALLINT,
  @pWeek TINYINT
AS
BEGIN
  IF @pYear IS NULL OR @pWeek IS NULL
  BEGIN
    RAISERROR(N'Both arguments should not be null', 10, 1);
  END;

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
  WHERE c.DateCalendarYear = @pYear
    AND c.WeekNumberOfSeason = @pWeek
  GROUP BY c.DateCalendarYear
          ,c.WeekNumberOfSeason
          ,r.StoreId
          ,r.ProductId;
END;
