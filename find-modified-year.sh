#!/bin/bash
# find()s files or directories modified in a certain year in a certain path.
#
# Andreas Maunz 2010

if [ $# -ne 2 ]; then
  echo "Supplied $# arguments instead of 3."
  echo "Usage: $0 <path> <year modified>"
  exit 1
fi

p=$1
y1=$2
y2=$(($y1 + 1))

touch --date "$y1-01-01" /tmp/otemp
touch --date "$y2-01-01" /tmp/ntemp
find $p -cnewer /tmp/otemp -and ! -cnewer /tmp/ntemp

echo "From $y1 to $y2 in $p."
