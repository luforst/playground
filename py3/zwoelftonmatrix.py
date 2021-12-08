#!/usr/bin/env python3

w, h = 12, 4
matrix = [[0 for iw in range(w)] for ih in range(h)]

base_row = []
print("Grund-Zwölftonreihe eingeben")
for i in range(12):
    base_row.append(int(input("\n {0}: ".format(i))))
print(base_row)

for i in range(12):
    matrix[i][0] = 12 - matrix[0][i]
print(matrix)
