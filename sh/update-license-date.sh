#!/bin/bash
# update-license-date.sh
# Updates the LICENSE file's date to the current year

# search for line with "(c) 20xy ..."

# change 20xy -> current year

if [ -d "./.git" ]; then
    git add LICENSE
    git commit -m"Update LICENSE to current year"
fi
