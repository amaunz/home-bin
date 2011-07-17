#!/bin/bash
# Sorts files in calendaric order
# Moves to designated subdirs, if requested
#
# Andreas Maunz 2010

source $HOME/bin/get_file_date.sh
IFS="
"

if [ $# -ge 2 ]; then
  echo "Usage: $0 [m]"
  exit 1
fi

for f in `find -maxdepth 1 -type f`; do
  year=`year "$f"`
  month=`month "$f"`
  echo "$f => $year/$month"
  if [ $# -gt 0 ]; then
    if [ $1 = "m" ]; then
      mkdir -p "$year/$month"
      mv "$f" "$year/$month"
    fi
  fi
done
