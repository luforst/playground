#!/bin/bash
# documents-backup.sh: automatische Archivierung des Dokumentenordners
tar -czf - ~/Dokumente/ | (pv -n > backup.tgz) 2>&1 | dialog --gauge "Progress" 10 70

