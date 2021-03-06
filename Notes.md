# Assumptions and considerations:

#### Schema
Schema for tables is created based on values from files and business meaning. Primary keys were created based on the information from the task and absence of duplicates in the data. Everything is not final and requires additional elaboration with business owners (for example, the task says that calendar has dateId column, but the file has not-mentioned datekey and datecalendarday, and dateId is missing).

#### Files
Data in all files is expected to contain only those values that are allowed by their types in staging tables.
Files are separated by comma, sales.csv has Linux line endings, the rest - Windows.

#### Platform
MS SQL Server was selected as the target DBMS due to the deep knowledge of the subject platform and limited time to complete the task.
Azure was chosed as a cloud provider due to existing subscription and the ability to quickly create cheap MS SQL Server.

#### Ingest process
Data ingestion is performed using bcp utility for files in the local folder due to small development effort. It should be replaced if cloud native services are required to be supported.

#### Job execution
The desciption of job execution requires clarification.
The current implementation assumes loading a separate set of files for each job execution.
Consider another scenario where jobs are executed with different parameters on the same set of files. While the proposed solution is still usable, it lacks some optimizations.

#### Things to be improved
Add error handling, much better logging, additional tests, comments to the code, more automation.
StoredProceduresSlow folder has a "usually quick but not optimal" solution that suffers from performance issues as the data grows. However, in some conditions it can work better than the proposed solution (when there is no year/week as an input filter and when the same product is not sold in the same store within one day).
