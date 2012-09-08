#!/bin/bash
# zeigt die eigene, öffentliche IP an

wget http://wieistmeineip.org/ -q -O - |
grep -Eo '\<[[:digit:]]{1,3}(\.[[:digit:]]{1,3}){3}\>'
