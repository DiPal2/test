IF NOT EXISTS (SELECT *
               FROM INFORMATION_SCHEMA.TABLES
               WHERE TABLE_SCHEMA = N'dbo'
                 AND TABLE_NAME = N'StagingSales')
BEGIN
  CREATE TABLE dbo.StagingSales(
    SaleId INT NOT NULL
   ,NetSales NUMERIC(10,2) NOT NULL
   ,SalesUnits INT NOT NULL
   ,StoreId SMALLINT NOT NULL
   ,DateId INT NOT NULL
   ,ProductId VARCHAR(20) NOT NULL
   ,CONSTRAINT PK_StagingSales PRIMARY KEY NONCLUSTERED (SaleId)
   ,CONSTRAINT AK_StagingSales_DateId UNIQUE CLUSTERED (DateId, SaleId)
  );
END;
