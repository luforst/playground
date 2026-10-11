# Solutions for K. Erciyes 2021:  Algebraic Graph Algorithms: A Practical Guide Using Python
# chapter 2.6

#1. Write a single Python statement that finds the count of integers greater than 2
# in a given list using list comprehension.
x = [1, 2, 5, 6, 4, 2, 9, 8, 2, 10, 2, 3, 3, 2, 0, 2]
countgt2 = len([i for i in x if i > 2])
print(countgt2)

#2. A list L containing integers between 0 and 50 is given. Write a single statement
# that finds the frequencies of integers in this list and stores these values in another
# list using list comprehension.
L = [2, 5, 8, 10, 2, 49, 5, 49, 49, 49, 49, 50, 11, 23, 42, 47, 17, 1]
histL = [len([i for i in L if i == n]) for n in range(51)]
print(histL)


#3. Write a Python program that generates random numbers between 0 and 1 for 10
# times and appends each generated number to a list which is initialized as empty.
from random import random

x = []
for i in range(10):
    x.append(random())
print(x)

#4. Write a Python program that inputs integers until a 0 is encountered and then
# prints the maximum value entered up to that point.
x = 0
i = 1
while i != 0:
    i = input("integer:")
    i = int(i)
    if i > x:  # noqa: PLR1730
        x = i
print(x)

#5. Write a Python function that inputs an array of integers and returns the maximum
# value in this array. Do not use the max method on array class.
def maxarray(array):
    maxn = array[0]
    for i in array:
        if i > maxn:  # noqa: PLR1730
            maxn = i
    return(maxn)
print(maxarray([1, 4, 2, 5, 9, 10, 2, 3, 12, 1701, 1]))

#6. Write a Python program that inputs a sentence string by the user
# and counts the number of words in the sentence.
print(len(input("sentence: ").split(sep = " ")))

#7. Write a Python program that inputs a large integer and outputs this integer with
# commas inserted at every 3 digits. For example, when 5231908126 is entered,
# the output is 5,231,908,126.
intstring = 1209281442
intstring = str(intstring)
intstring_format = ""
for i in range(1, len(intstring)+1):
    if i % 3 == 0:
        intstring_format = ',' + intstring[-i] + intstring_format
        continue
    else:
        intstring_format = intstring[-i] + intstring_format
print(intstring_format)
