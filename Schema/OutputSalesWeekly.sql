IF NOT EXISTS (SELECT *
               FROM INFORMATION_SCHEMA.TABLES
               WHERE TABLE_SCHEMA = N'dbo'
                 AND TABLE_NAME = N'OutputSalesWeekly')
BEGIN
  CREATE TABLE dbo.OutputSalesWeekly(
    DateCalendarYear SMALLINT NOT NULL
   ,WeekNumberOfSeason TINYINT NOT NULL
   ,StoreId SMALLINT NOT NULL
   ,Channel VARCHAR(20) NULL
   ,Country VARCHAR(200) NULL
   ,ProductId VARCHAR(20) NOT NULL
   ,Division VARCHAR(20) NULL
   ,Gender VARCHAR(10) NULL
   ,Category VARCHAR(20) NULL
   ,NetSales NUMERIC(20,2) NOT NULL
   ,SalesUnits INT NOT NULL
   ,CONSTRAINT PK_OutputSalesWeekly PRIMARY KEY CLUSTERED (DateCalendarYear, WeekNumberOfSeason, StoreId, ProductId)
  );
END;
