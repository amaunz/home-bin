#!/bin/bash
# Functions to emit year or month of mod date
#
# Andreas Maunz 2010

function year
{
  if ls $1>/dev/null 2>&1; then
    MOD_DATE=`ls -lart "$1" | cut -f6 -d" "`
    MOD_YEAR=`echo $MOD_DATE | sed 's/-.*//g'`
    MOD_MONT=`echo $MOD_DATE | sed 's/....-//g' | sed 's/-.*//g'`
    echo "$MOD_YEAR"
  fi
}

function month
{
  if ls $1>/dev/null 2>&1; then
    MOD_DATE=`ls -lart "$1" | cut -f6 -d" "`
    MOD_YEAR=`echo $MOD_DATE | sed 's/-.*//g'`
    MOD_MONT=`echo $MOD_DATE | sed 's/....-//g' | sed 's/-.*//g'`
    echo "$MOD_MONT"
  fi
}
