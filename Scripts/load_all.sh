message() {
  echo "$(date --rfc-3339=ns) $1"
}

load_file() {
  message "Loading $2 into table $1"
  local LineSeparator=0x0d0a
  if [ "$3" == "Linux" ]; then LineSeparator=0x0a; fi
  bcp $1 IN $2 -F2 -c -t, -r $LineSeparator -m0 $BCP_CONN_STR
}

call_proc() {
  message "Calling SP $1"
  bcp "EXEC $1;SELECT 'ok';" queryout $2 -c $BCP_CONN_STR

}

load_all() {
if [[ -z "$1" ]]; then
  >&2 echo "Path to local folder is required!"
  return 1
fi

if [[ -z "$2" ]]; then
  >&2 echo "Server name is required!"
  return 2
fi

if [[ -z "$3" ]]; then
  >&2 echo "User name is required!"
  return 3
fi

if [[ -z "$4" ]]; then
  >&2 echo "Password is required!"
  return 4
fi

if [[ -z "$5" ]]; then
  >&2 echo "Database name is required!"
  return 5
fi

local BCP_CONN_STR="-S $2 -U"$3" -P"$4" -d $5"

call_proc dbo.PrepareStagingIngest "$1/empty.log"

load_file dbo.StagingCalendar "$1/calendar.csv"
load_file dbo.StagingProduct "$1/product.csv"
load_file dbo.StagingSales "$1/sales.csv" Linux
load_file dbo.StagingStore "$1/store.csv"

call_proc dbo.DataCleansing "$1/empty.log"

return 0
}

load_all "$@"
