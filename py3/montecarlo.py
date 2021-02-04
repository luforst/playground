#!/usr/bin/env python3
from random import random
import sys
iterations = int(sys.argv[1])
inside = 0
total = 0
for i in range(1, iterations):
    x = random()
    y = random()
    if x**2+y**2 <= 1:
        inside += 1
    total += 1
pi_approx = 4*inside/total

print(pi_approx)
