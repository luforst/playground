#!/usr/bin/env python3
import sympy as sym

global x
global f

def ableitg123(f):
	global f1 = sym.diff(f, x, 1)
	global f2 = sym.diff(f, x, 2)
	global f3 = sym.diff(f, x, 3)


def nullst(f):
	nullstellen = sym.solveset(f, x)
	return nullstellen


def extremst(f):
	# Bestimme mögliche Extremstellen anhand notwendiger Bedingung f'(x) == 0
	extremstellen_mögl = list(sym.solveset(f1, x))
	# Bestimme tatsächliche Extremstellen anhand hinreichender Bedingung f''(x) != 0
	extremstellen = {x0 for x0 in extremstellen_mögl if x0 not in sym.solveset(f2, x)}
	return extremstellen


def wendest(f):
	# Bestimme mögliche Wendestellen anhand notwendiger Bedingung f''(x)=0
	wendestellen_mögl = list(sym.solveset(f2, x))
	# Bestimme tatsächliche Wendestellen anhand hinreichender Bedingung f'''(x) != 0
	wendestellen = {x0 for x0 in wendestellen_mögl if x0 not in sym.solveset(f3, x)}
	return wendestellen


def main():
	funktion_str = input("Funktion eingeben: f(x)=")
	x = sym.Symbol('x')
	f = eval(funktion_str)
