layer1 <- function(x, y) {
  result <- c(max(0, x+1),
              max(0, -x-1),
              max(0, y-2),
              max(0, -y+2),
              max(0, -x+y-3),
              max(0, x-y+3),
              max(0, -x-y+1),
              max(0, x+y-1))
  return(result)
}

layer2 <- function(x) {
  result <- c(max(0, -sum(x[1:4])+1),
              max(0, -sum(x[5:8])+sqrt(2)))
  return(result)
}

xcoords <- c()
ycoords <- c()
zvalues <- c()
for (ix in -30:30) {
  for (iy in -30:30) {
    z <- sum(layer2(layer1(ix/10,iy/10)))
    if (z > 0) {
      xcoords <- c(xcoords, ix/10)
      ycoords <- c(ycoords, iy/10)
      zvalues <- c(zvalues, z)
    }
  }
}

plot(xcoords, ycoords)

library(ggplot2)
ggplot(NULL, aes(x=xcoords, y=ycoords)) + geom_point(colour = 'forestgreen') + coord_fixed(ratio = 1)
ggplot(NULL, aes(x=xcoords, y=ycoords)) + geom_point(aes(colour = zvalues)) + coord_fixed(ratio = 1)
