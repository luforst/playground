def collatz(x):
    if x <= 0:
        raise ValueError("Collatz has become 0")
    if (x % 2) == 0:
        return x/2
    else:
        return 3*x+1

if __name__ == "__main__":
    number = 10
    print("Ausgangszahl: ", number)
    iteration = 0

    while True:
        number = collatz(number)
        iteration += 1
        print("Iteration ", iteration, ":  ", number)
        input("")
