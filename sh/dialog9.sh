#!/bin/bash
# Demonstriert dialog --gauge
# Name : dialog9
DIALOG=dialog
(
 echo "10" ; sleep 1
 echo "XXX" ; echo "Alle Daten werden gesichert"; echo "XXX"
 echo "20" ; sleep 1
 echo "50" ; sleep 1
 echo "XXX" ; echo "Alle Daten werden archiviert"; echo "XXX"
 echo "75" ; sleep 1
 echo "XXX" ; echo "Daten werden ins Webverzeichnis hochgeladen";
 echo "XXX"
 echo "100" ; sleep 3
) |
$DIALOG --title "Fortschrittszustand" --gauge "Starte Backup-Script" 8 30
$DIALOG --clear
$DIALOG --msgbox "Arbeit erfolgreich beendet ..." 0 0
$DIALOG --clear
clear
