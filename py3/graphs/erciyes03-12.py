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

A = np.array([[2,2,-3],[0,2,-2],[0,-1,3]])
print(len(A))
vals, V = np.linalg.eig(A)
print("Eigenwerte:",vals)
print("Eigenvektoren:\n",V)
print("Determinante von A:", round(np.linalg.det(A)))
print("Spur von A:", np.trace(A))
x = 1
for i in vals:
    x *= i
print("Produkt der Eigenwerte:", x)
x = 0
for i in vals:
    x += i
print("Summe der Eigenwerte:", x)
print(V[:,1])

###
#2. Find the determinant of the matrix given below both by using calculation and Python numpy library.
B = np.array([[2,1,5],[1,4,3],[5,3,7]])
print("Determinante:", round(np.linalg.det(B)))
print("von der Matrix:\n", B)

#3. Write a Python function which inputs an integer matrix and returns it in
# upper triangular form and run this function for the following matrix
A = np.array([[3,2,4,0], [6,1,5,2], [5,3,7,8], [1,6,4,2]])
def triu(M):
    n = len(M)
    for i in range(n):
        if i == 0:
            continue
        for k in range(i+1):
            M[i,k] = 0
    return(M)
print(triu(A))
print(np.triu(A))

#4. Write a Python function that inputs two compatible matrices, computes their product
# and returns this product.

def matrixprod(A, B):
    C = np.empty(shape = (A.shape[0], B.shape[1]))
    for arow in range(A.shape[0]):
        for bcol in range(B.shape[1]):
            C[arow, bcol] = sum(A[arow,:] * B[:,bcol])
    return C

#5. Find the product of the two matrices given below using the numpy method dot.
A = np.array([[3,1,4],[2,0,5]])
B = np.array([[2,1],[1,3],[7,2]])
print(A, "\n    ·\n", B, " =\n", np.dot(A,B))

print(matrixprod(A, B))

#6. Find the eigenvalues and the eigenvectors of the following matrix by calculation
# and also using the numpy method eig.
A = np.array([[0, 1], [-2, 3]])
vals, V = np.linalg.eig(A)
print("6) A=\n", A)
print("Eigenwerte:", vals)
print("Eigenvektoren:\n", V)
