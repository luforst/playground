#!/usr/bin/env python3
# Skript zu Aufgabe 21 des Adventskalenders MATH+
# neuronales Netz
import matplotlib.pyplot as plt

def layer1(x, y):
	result = [max(0, x+1), max(0, -x-1), max(0, y-2), max(0,-y+2), max(0, -x+y-3), max(0, x-y+3), max(0, -x-y+1), max(0, x+y-1)]
	return(result)

def layer2(listofeight):
	return([max(0,-sum(listofeight[0:4])), max(0, -sum(listofeight[4:7]))])

print(layer2(layer1(0, 0)))

xcoords = []
ycoords = []
for i in range(-2, 2):
	for j in range(-2, 2):
		spam = layer1(i, j)
		if sum(layer2(spam)) > 0:
			xcoords.append(i)
			ycoords.append(j)

plt.plot(xcoords, ycoords, 'ro')
plt.axis([-2.5,2.5,-2.5,2.5])
plt.show()

print(layer2(layer1(-1, 2)))

