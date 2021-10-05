@IF "%BCP_CONN_STR:~0,3%" NEQ "-S " ECHO BCP_CONN_STR variable is empty! & EXIT/B 1
@IF "%~1"=="" ECHO TableName is expected! & EXIT/B 2
@IF "%~2"=="" ECHO FileName is expected! & EXIT/B 3
@SET LineSeparator=-r 0x0d0a
@IF "%~3"=="Linux" SET LineSeparator=-r 0x0a

@bcp %1 IN %2 -F2 -c -t, %LineSeparator% -m0 %BCP_CONN_STR%

