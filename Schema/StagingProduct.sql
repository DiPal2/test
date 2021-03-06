IF NOT EXISTS (SELECT *
               FROM INFORMATION_SCHEMA.TABLES
               WHERE TABLE_SCHEMA = N'dbo'
                 AND TABLE_NAME = N'StagingProduct')
BEGIN
  CREATE TABLE dbo.StagingProduct(
    ProductId VARCHAR(20) NOT NULL
   ,Division VARCHAR(20) NOT NULL
   ,Gender VARCHAR(10) NOT NULL
   ,Category VARCHAR(20) NOT NULL
   ,CONSTRAINT PK_StagingProduct PRIMARY KEY CLUSTERED (ProductId)
  );
END;
