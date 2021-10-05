CREATE OR ALTER PROCEDURE dbo.PopulateAggDataFiltered
  @pYear SMALLINT,
  @pWeek TINYINT
AS
BEGIN
  DECLARE @keys NVARCHAR(MAX)
         ,@code NVARCHAR(MAX);

  IF @pYear IS NULL OR @pWeek IS NULL
  BEGIN
    RAISERROR(N'Both arguments should not be null', 10, 1);
  END;

  TRUNCATE TABLE dbo.AggSalesDaily;

  TRUNCATE TABLE dbo.AggSalesWeekly;

  SELECT @keys = STRING_AGG(CONVERT(NVARCHAR(MAX),DateKey), ',')
  FROM dbo.StagingCalendar
  WHERE DateCalendarYear = @pYear
    AND WeekNumberOfSeason = @pWeek;

  IF LEN(@keys) > 0
  BEGIN
    SELECT @code = N'INSERT INTO dbo.AggSalesWeekly(
             DateCalendarYear
            ,WeekNumberOfSeason
            ,StoreId
            ,ProductId
            ,AggNetSales
            ,AggSalesUnits)
      SELECT @year
            ,@week
            ,StoreId
            ,ProductId
            ,SUM(NetSales)
            ,SUM(SalesUnits)
      FROM dbo.StagingSales
      WHERE DateId IN (' + @keys + ')
      GROUP BY StoreId
              ,ProductId;';

    EXECUTE sp_executesql @code, N'@year SMALLINT, @week TINYINT', @year = @pYear, @week = @pWeek;
  END;
END;
