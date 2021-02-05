#!/bin/bash
# update-license-date.sh
# Updates the LICENSE file's date to the current year

if [ ! -s "LICENSE" ]; then # -s is test's operator for "Does the file ... exist and is it non-empty?"
    echo No LICENSE file found!
    echo Abort.
    exit 1
fi

# search for line with "(c) 20xy ..."

# change 20xy -> current year

if [ -d "./.git" ]; then
    git add LICENSE
    git commit -m"Update LICENSE to current year"
fi
