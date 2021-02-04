#!/usr/bin/env python3
# https://www.geeksforgeeks.org/stormer-numbers/

# Python program to print Stormer numbers 
  
from __future__ import print_function 
  
# Function to find largest prime factor 
  
def maxPrimeFactors(n): 
    # Initialize the maximum prime factor 
    # variable with the lowest one 
    maxPrime = -1
  
    # Print the number of 2's that divide n 
    while n % 2 == 0: 
        maxPrime = 2
        n /= 2
  
    # n must be odd at this point, thus skip 
    # the even numbers and iterate only for 
    # odd integers 
    for i in range(3, int(n**0.5)+1, 2): 
        while n % i == 0: 
            maxPrime = i 
            n /= i 
  
    # This condition is to handle the case when 
    # n is a prime number greater than 2 
    if n > 2: 
        maxPrime = n 
  
    return int(maxPrime) 
  
# Function to generate Stormer Numbers 
  
def stormer(n): 
    i = 1
    # Stores the number of Stormer numbers found 
    count = 0
    while(count < n): 
        t = i * i + 1
        if maxPrimeFactors(t) >= 2 * i: 
            print(i, end =' ') 
            count += 1
        i += 1
  
# Driver Method 
  
if __name__=='__main__': 
    n = 10
    stormer(n) 

