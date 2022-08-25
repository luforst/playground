library("BoolNet")
net <- loadNetwork("funktionen.txt", symbolic = TRUE)
perturbieren <- function() {
  for (i in 1:10) {
    r <- perturbTrajectories(net, measure="sensitivity", numSamples=200000, flipBits = 1, gene=paste("F",toString(i),sep=""))
    print(r$value)
  }
}

randFlip <- function(x) {
  i <- sample(1:length(x),1)
  if (x[i]) {
    x[i] <- FALSE
  } else {
    x[i] <- TRUE
  }
  return(x)
}

and <- function(x,y) {
  return(x&y)
}

or <- function(x,y) {
  return(x|y)
}

evalNode <- function(node, binvec) {
  if (node$type == "atom") {
    if (node$negated) {
      return(!binvec[node$index])
    } else {
      return(binvec[node$index])
    }
  } else if (node$type == "operator") {
    if (node$operator == "&") {
      if (node$negated) {
        return(! Reduce(and, evalNode(node$operands, binvec)))
      } else {
        return(Reduce(and, evalNode(node$operands, binvec)))
      }
    } else if (node$operator == "|") {
      if (node$negated) {
        return(! Reduce(or, evalNode(node$operands, binvec)))
      } else {
        return(Reduce(or, evalNode(node$operands, binvec)))
      }
    }
  }
}

tree <- net$interactions

evalRobustness <- function(func, numSamples=100) {
  changed <- notchanged <- 0
  for (i in 1:numSamples) {
    randvec <- sample(0:1, 5, replace=TRUE)
    output <- func(randvec)
    output.flip <- func(randFlip(randvec))
    if (output == output.flip) {
      notchanged <- notchanged +1
    } else {
      changed <- changed +1
    }
  }
  return(c(changed, notchanged))
}

spam <- function(x){
  return(x[1]&x[2]&x[3]&x[4]&x[5])
}