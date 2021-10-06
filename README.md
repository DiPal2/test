# Prerequisites
A MS SQL Server database (2017+) that can be used for the task.
A machine with installed bcp according to https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-ver15

# Database preparation
1. Execute each sql script from Schema folder for creating tables.
2. Execute each sql script from StoredProcedures folder for creating stored procedures.
3. (Optional) Execute each sql script from StoredProceduresSlow folder for a "usually quick but not optimal" solution that suffers from performance issues as the data grows.

# Data processing
1. Call load_all.cmd from Scripts folder with appropriate parameters:
```
load_all.cmd path_to_csv_files server_name user_name password database_name
```
2. Execute the following command on the database if you want to prepare output data filtered by year and week:
```
EXEC dbo.ProcessData @pYear=2020, @pWeek=3
```
or execute another command if you do not want to filter output data:
```
EXEC dbo.ProcessData
```
3. Call extract.cmd from Scripts folder with appropriate parameters for saving weekly.csv with required results:
```
extract.cmd path_to_weekly_csv_file server_name user_name password database_name
```

# Testing end-to-end results
1. Complete steps in Data processing section by specifying the path to the local version of Tests folder.
2. Make sure that the sorted content of weekly.csv file is the same as expected.csv file.
