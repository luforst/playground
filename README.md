# playground
Repository for any experimental/nonsense/fun(?) stuff of mine

The files are sorted into subfolders by their respective programming language.

## Python 3
- caesarcode.py: simple implementation of the Caesar cipher
- collatz.py: check a number for compliance with the Collatz conjecture
- helloworld\_boxes\_pack.py: I tried a hello-world example of Gtk using the gi module
- josephus.py: a script to solve the Josephus problem, I don't know if it's actually working...
- simple\_example.py: Hello-world of Gtk (gi module) with a button changing its label
- stalinsort.py: implementation of the Stalin sorting algorithm: any dissident element rejecting the Party's official order of elements is eliminated
- størmer\_numbers.py: well it prints Størmer numbers
- wxpython-beispiel.py: a German hello-world of wxpython

## Shellscript
All of these shellscripts are bash scripts.
- update-license-date.sh: doesn't work yet, but for the future it is supposed to update the year in LICENSE files
- fork-bomb.sh: Now for the fun part! A fork bomb consisting of nothing but punctuation marks
### dialog
These scripts use the dialog command to show a progress bar
- dialog9.sh: does nothing, but pretends to show a progress bar of a backup into the cloud
- documents-backup.sh: compresses the files of Documents folder and shows a progress bar of compression.
  Maybe I'm going to use it in an automatic backup script in the future.
- dvdcopy-gaugedemo.sh: actually it doesn't copy DVDs but pretends to, showing a sample progress bar

## R
- myFirstRScript.R: draws a histogram of Gaussian-distributed random numbers
- boolfuncheur.R: heuristic examination of Boolean functions' noise sensitivity, using the BoolNet package. Berufspraktikum project.
  - funktionen.txt: its BoolNet rules file
  - TruthTable.R: examine Boolean functions' truth tables and balancedness
  - isMonotone.R: check if a Boolean function is monotone

## Lisp
- guess-my-number.lisp: guess-my-number, the first example program from Land of Lisp

## Fortran
- hello.f90: Hello world
- cylinder.f90: self-educational program calculating stuff about a cylinder when given height and base radius
- efunktion-taylor.f90: supposed to calculate e^x using a Taylor series; does't work yet

## Haskell
- caesarcode.hs: to-be implementation of Caesar cipher / especially ROT13

## NodeJS JavaScript
- helloworld.js: hello world example from nodejs.org, sets up a most basic http server greeting on port 3000
