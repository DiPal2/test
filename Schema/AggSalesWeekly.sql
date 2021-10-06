IF NOT EXISTS (SELECT *
               FROM INFORMATION_SCHEMA.TABLES
               WHERE TABLE_SCHEMA = N'dbo'
                 AND TABLE_NAME = N'AggSalesWeekly')
BEGIN
  CREATE TABLE dbo.AggSalesWeekly(
    DateCalendarYear SMALLINT NOT NULL
   ,WeekNumberOfSeason TINYINT NOT NULL
   ,StoreId SMALLINT NOT NULL
   ,ProductId VARCHAR(20) NOT NULL
   ,AggNetSales NUMERIC(20,2) NOT NULL
   ,AggSalesUnits INT NOT NULL
   ,CONSTRAINT PK_AggSalesWeekly PRIMARY KEY CLUSTERED (DateCalendarYear, WeekNumberOfSeason, StoreId, ProductId)
  );
END;
