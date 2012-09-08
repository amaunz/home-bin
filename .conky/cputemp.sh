sensors | /bin/grep temp | head -1 |  awk -F " " '{print $2}' | sed 's/\..*//g' | sed 's/[+,-]//g'
