CREATE OR ALTER PROCEDURE dbo.DataCleansing
AS
BEGIN
  UPDATE dbo.StagingStore
  SET Country = LTRIM(RTRIM(Country));

  UPDATE dbo.StagingProduct
  SET Category = LTRIM(RTRIM(Category));
END;
