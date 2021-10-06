IF NOT EXISTS (SELECT *
               FROM INFORMATION_SCHEMA.TABLES
               WHERE TABLE_SCHEMA = N'dbo'
                 AND TABLE_NAME = N'StagingCalendar')
BEGIN
  CREATE TABLE dbo.StagingCalendar(
    DateKey INT NOT NULL
   ,DateCalendarDay TINYINT NOT NULL
   ,DateCalendarYear SMALLINT NOT NULL
   ,WeekNumberOfSeason TINYINT NOT NULL
   ,CONSTRAINT PK_StagingCalendar PRIMARY KEY CLUSTERED (DateKey)
  );
END;

IF NOT EXISTS (SELECT *
               FROM sys.indexes
               WHERE name = N'IX_StagingCalendar_DateCalendarYear_WeekNumberOfSeason')
BEGIN
  CREATE NONCLUSTERED INDEX IX_StagingCalendar_DateCalendarYear_WeekNumberOfSeason
    ON dbo.StagingCalendar (DateCalendarYear, WeekNumberOfSeason);
END;
GO
