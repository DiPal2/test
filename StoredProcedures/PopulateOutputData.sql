CREATE OR ALTER PROCEDURE dbo.PopulateOutputData
AS
BEGIN
  TRUNCATE TABLE dbo.OutputSalesWeekly;

  INSERT INTO dbo.OutputSalesWeekly(
         DateCalendarYear
        ,WeekNumberOfSeason
        ,StoreId
        ,Channel
        ,Country
        ,ProductId
        ,Division
        ,Gender
        ,Category
        ,NetSales
        ,SalesUnits)
  SELECT w.DateCalendarYear
        ,w.WeekNumberOfSeason
        ,w.StoreId
        ,s.Channel
        ,s.Country
        ,w.ProductId
        ,p.Division
        ,p.Gender
        ,p.Category
        ,w.AggNetSales
        ,w.AggSalesUnits
  FROM dbo.AggSalesWeekly w
  LEFT OUTER JOIN dbo.StagingStore s
          ON s.StoreId = w.StoreId
  LEFT OUTER JOIN dbo.StagingProduct p
          ON p.ProductId = w.ProductId;
END;
