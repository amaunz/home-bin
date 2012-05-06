#!/bin/bash

echo $(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$1")
