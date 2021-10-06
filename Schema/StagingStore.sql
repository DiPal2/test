IF NOT EXISTS (SELECT *
               FROM INFORMATION_SCHEMA.TABLES
               WHERE TABLE_SCHEMA = N'dbo'
                 AND TABLE_NAME = N'StagingStore')
BEGIN
  CREATE TABLE dbo.StagingStore(
    StoreId SMALLINT NOT NULL
   ,Channel VARCHAR(20) NOT NULL
   ,Country VARCHAR(200) NOT NULL
   ,CONSTRAINT PK_StagingStore PRIMARY KEY CLUSTERED (StoreId)
  );
END;
