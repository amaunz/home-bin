#!/bin/bash

function year
{
  MOD_DATE=`ls -lart "$1" | cut -f6 -d" "`
  MOD_YEAR=`echo $MOD_DATE | sed 's/-.*//g'`
  MOD_MONT=`echo $MOD_DATE | sed 's/....-//g' | sed 's/-.*//g'`
  echo "$MOD_YEAR"
}

function month
{
  MOD_DATE=`ls -lart "$1" | cut -f6 -d" "`
  MOD_YEAR=`echo $MOD_DATE | sed 's/-.*//g'`
  MOD_MONT=`echo $MOD_DATE | sed 's/....-//g' | sed 's/-.*//g'`
  echo "$MOD_MONT"
}
