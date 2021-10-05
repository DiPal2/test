CREATE OR ALTER PROCEDURE dbo.PrepareStagingIngest
AS
BEGIN
  TRUNCATE TABLE dbo.StagingCalendar;
  TRUNCATE TABLE dbo.StagingProduct;
  TRUNCATE TABLE dbo.StagingSales;
  TRUNCATE TABLE dbo.StagingStore;
END;
