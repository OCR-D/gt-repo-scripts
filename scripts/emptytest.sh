#!/usr/bin/bash
 
FILENAME=pathtest.md
 
# Check if the file is empty
if [ ! -s "${FILENAME}" ]; then
    echo "empty"
else
    echo "full"
fi