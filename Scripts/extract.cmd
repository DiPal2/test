@IF "%~1"=="" ECHO Path to local folder is required! & EXIT/B 1
@IF "%~2"=="" ECHO Server name is required! & EXIT/B 2
@IF "%~3"=="" ECHO User name is required! & EXIT/B 3
@IF "%~4"=="" ECHO Password is required! & EXIT/B 4
@IF "%~5"=="" ECHO Database name is required! & EXIT/B 5
@SET BCP_CONN_STR=-S %2 -U%3 -P%4 -d %5

@CALL :extract_file dbo.OutputSalesWeekly "%1\weekly.csv"
@EXIT /B 0

:extract_file
@ECHO %TIME% Saving %1 to file %2
@bcp %1 OUT %2 -c -t, -r 0x0d0a -m0 %BCP_CONN_STR%
@EXIT /B
