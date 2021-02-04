#!/usr/bin/env python3

def stalinsort(x=[]):
    if x == []:
        return x
    for i in range(len(x)-1):
        if x[i] < x[i+1]:
            continue
        else:
            x.pop(i+1)
    return x
