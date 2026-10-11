# Solutions for K. Erciyes 2021:  Algebraic Graph Algorithms: A Practical Guide Using Python
# chapter 3.12

import numpy as np

A = np.array([[1,2,3],[4,5,6],[2,4,6]])
print("A:", A)
print("Rank of A:", np.linalg.matrix_rank(A))

# iterative matrix power
def Pow_Iter(A, k):
    P = A
    for i in range(1, k):
        P = np.dot(P, A)
    return P
B = np.array([[1,2,3],[1,1,1],[2,2,2]])
print(Pow_Iter(B, 4))

# recursive matrix power
def Pow_Rec(A, k):
    if k == 1:
        return A
    if k % 2 == 0:
        return np.dot(Pow_Rec(A, k/2), Pow_Rec(A, k/2))
    else:
        return np.dot(A, np.dot(Pow_Rec(A, (k-1)/2), Pow_Rec(A, (k-1)/2)))
print(Pow_Rec(B, 4))
