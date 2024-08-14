#!/usr/bin/env python3

import os, re

files = os.listdir()

p = re.compile(".+\.(aux|log|synctex\.gz|toc)")

for file in matched_files:
    filesize_sum += os.stat(file).st_size / 1024 # file size in kB
    os.remove(file)

print("{0} Dateien gelöscht, {1} kB Speicher freigegeben.".format(len(matched_files), filesize_sum))
