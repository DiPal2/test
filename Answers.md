1. The coding time for tests was about 1 hour. "Things to be improved" in Notes.md contains improvments that can be added when there is no time pressure.

2. STRING_AGG was my long-awaited T-SQL feature that has been present in many SQL dialects for decades but was only added in 2017.
```sql
SELECT @keys = STRING_AGG(CONVERT(NVARCHAR(MAX),DateKey), ',')
FROM dbo.StagingCalendar
```
instead of
```sql
SELECT @keys = STUFF((SELECT ',' + CONVERT(NVARCHAR(MAX),DateKey) AS [text()]
                      FROM dbo.StagingCalendar
                      FOR XML PATH('')), 1, 1, '')
```

3. Appropriate monitoring and logging are the main keys to track down performance issues. Execution plans are very helpful, as well as knowing the distribution of the data.
I have never worked with such large volumes, but I would love to work with MPP approach.
