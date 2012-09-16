#!/bin/bash
wget -q -O - https://mail.google.com/a/gmail.com/feed/atom --http-user="$1" --http-password="$2" --no-check-certificate | grep fullcount | sed 's,.*<fullcount>\(.*\)</fullcount>.*,\1,g' 
