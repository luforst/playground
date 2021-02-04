#!/usr/bin/env python3

"""Lösungsentwurf für das Josephus-Problem"""

n = 10
personen = [i for i in range(1, n+1)]


def josephus(n):
    index = 0
    while len(personen) > 1:
        temp = personen.pop(index+1)
        print(temp)
        if index == (len(personen)-1):
            index = 0
            continue
        index += 1
    print(personen)

josephus(n)
