n <- 3 # Anzahl Farben
m <- 3 # Anzahl Symbole

K <- expand.grid(1:n, 1:m) # Kartenspiel (cartesisches Produkt 1...n x 1...m)

x <- 3
choose(n*m,x)
K[sample(9, 3),]

n <- 2
m <- 3
x <- 4
choose(n*m, x)
K <- expand.grid(1:n, 1:m)
K[sample(6, 4),]
