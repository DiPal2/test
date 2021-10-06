message() {
  echo "$(date --rfc-3339=ns) $1"
}

extract_file() {
  message "Saving $1 to file $2"
  bcp $1 OUT $2 -c -t, -r 0x0d0a -m0 $BCP_CONN_STR

}

extract() {
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

extract_file dbo.OutputSalesWeekly "$1/weekly.csv"

return 0
}

extract "$@"
