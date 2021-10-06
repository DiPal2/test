@IF "%~1"=="" ECHO Server name is required! & EXIT/B 1
@IF "%~2"=="" ECHO User name is required! & EXIT/B 2
@IF "%~3"=="" ECHO Password is required! & EXIT/B 3
@IF "%~4"=="" ECHO Database name is required! & EXIT/B 4
@SET BCP_CONN_STR=-S %1 -U%2 -P%3 -d %4

@CALL :extract_file dbo.StagingSales sales.csv
@EXIT /B 0

:extract_file
@ECHO %TIME% Saving %1 to file %2
@bcp %1 OUT %2 -c -t, -r 0x0a -m0 %BCP_CONN_STR%
@EXIT /B
