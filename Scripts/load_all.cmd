@IF "%~1"=="" ECHO Path to local folder is required! & EXIT/B 1
@IF "%~2"=="" ECHO Server name is required! & EXIT/B 2
@IF "%~3"=="" ECHO User name is required! & EXIT/B 3
@IF "%~4"=="" ECHO Password is required! & EXIT/B 4
@IF "%~5"=="" ECHO Database name is required! & EXIT/B 5
@SET BCP_CONN_STR=-S %2 -U%3 -P%4 -d %5

@CALL :call_proc dbo.PrepareStagingIngest "%1\empty.log"

@CALL :load_file dbo.StagingCalendar "%1\calendar.csv"
@CALL :load_file dbo.StagingProduct "%1\product.csv"
@CALL :load_file dbo.StagingSales "%1\sales.csv" Linux
@CALL :load_file dbo.StagingStore "%1\store.csv"

@CALL :call_proc dbo.DataCleansing "%1\empty.log"

@EXIT /B 0

:load_file
@ECHO %TIME% Loading %2 into table %1
@SET LineSeparator=0x0d0a
@IF "%3"=="Linux" SET LineSeparator=0x0a
@bcp %1 IN %2 -F2 -c -t, -r %LineSeparator% -m0 %BCP_CONN_STR%
@EXIT /B

:call_proc
@ECHO %TIME% Calling SP %1
@bcp "EXEC %1;SELECT 'ok';" queryout %2 -c %BCP_CONN_STR%
@EXIT /B
