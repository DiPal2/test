@IF "%~1"=="" ECHO Path to local folder is required! & EXIT/B 1
@IF "%~2"=="" ECHO Server name is required! & EXIT/B 2
@IF "%~3"=="" ECHO User name is required! & EXIT/B 3
@IF "%~4"=="" ECHO Password is required! & EXIT/B 4
@IF "%~5"=="" ECHO Database name is required! & EXIT/B 5
@SET DATABASE=%5
@SET BCP_CONN_STR=-S %2 -U%3 -P%4

@CALL :load_file StagingCalendar "%1\calendar.csv"
@CALL :load_file StagingProduct "%1\product.csv"
@CALL :load_file StagingSales "%1\sales.csv" Linux
@CALL :load_file StagingStore "%1\store.csv"
@EXIT /B 0

:load_file
@ECHO %TIME% Loading %2 into table %1
@CALL "%~dp0bcp_load.cmd" %DATABASE%.dbo.%1 %2 %3
@EXIT /B
