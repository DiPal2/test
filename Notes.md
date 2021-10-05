# Assumptions and considerations:

#### Schema
Shema for tables is created based on values from files and business meaning. Primary keys were created based on the information from the task and absence of duplicates in the data. Everything is not final and requires additional elaboration with business owners.

#### Files
Data in all files is expected to contain only those values that are allowed by their types in staging tables.
Files are separated by comma, but can have Linux or Windows line endings.

#### Platform
MS SQL Server was selected as the target DBMS due to the deep knowledge of the subject platform and limited time to complete the task.
Azure was chosed as a cloud provider due to existing subscription and the ability to quickly create cheap MS SQL Server.

#### Ingest process
Data ingestion is performed using bcp utility for files in the local folder due to small development effort. It should be replaced if cloud native services are required to be supported.
