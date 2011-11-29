#!/bin/bash
# kill R instances that work for more than 8s

for p in `pgrep R 2>/dev/null`; do 
  secs=`ps ef $p | grep 'slave' 2>/dev/null | grep -v "grep" 2>/dev/null | awk '{print $4}' | sed 's/.*://g'`
  if [ -n "$secs" ]; then 
    if [ "$secs" -gt 8 ]; then 
      kill -9 $p
    fi
  fi
done
