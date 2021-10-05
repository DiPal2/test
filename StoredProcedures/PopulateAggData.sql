CREATE OR ALTER PROCEDURE dbo.PopulateAggData
  @pYear SMALLINT = NULL,
  @pWeek TINYINT = NULL
AS
BEGIN
  IF @pYear IS NULL AND @pWeek IS NULL
  BEGIN
    EXEC dbo.PopulateAggDataAll;
  END;
  ELSE
  BEGIN
    IF @pYear IS NOT NULL AND @pWeek IS NOT NULL
    BEGIN
      EXEC dbo.PopulateAggDataFiltered @pYear, @pWeek;
    END;
    ELSE
    BEGIN
      RAISERROR(N'One argument cannot be null if there is another one that is not null', 10, 1);
    END;
  END;
END;
