#!/bin/bash
echo > /tmp/mails_full.txt
atomfeed=`wget -q -O - https://mail.google.com/a/gmail.com/feed/atom --http-user=andreas@maunz.de --http-password="oEYkET298jxn6SJS" --no-check-certificate`
count=`echo $atomfeed | sed 's,.*<fullcount>\(.*\)</fullcount>.*,\1,g'`
title=`echo $atomfeed | sed 's,.*<title>\(.*\)</title>.*,\1,g'`
name=`echo $atomfeed | sed 's,.*<name>\(.*\)</name>.*,\1,g'`
echo "$count: $name: '$title'"
