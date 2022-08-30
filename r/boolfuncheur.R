library("BoolNet")
library("ggplot2")
#net <- loadNetwork("funktionen.txt", symbolic = TRUE)
perturbieren <- function() {
  for (i in 1:10) {
    r <- perturbTrajectories(net, measure="sensitivity", numSamples=200000, flipBits = 1, gene=paste("F",toString(i),sep=""))
    print(r$value)
  }
}

randFlip <- function(x) {
  i <- sample(1:length(x),1)
  x[i] <- !x[i]
  return(x)
}

evalNode <- function(node, binvec) {
  if (node$type == "atom") {
    if (node$negated) {
      return(!binvec[node$index])
    } else {
      return(binvec[node$index])
    }
  } else if (node$type == "operator") {
    if (node$negated) {
      return(! Reduce(node$operator, mapply(evalNode, node$operands, MoreArgs = list(binvec = binvec))))
    } else {
      return(Reduce(node$operator, mapply(evalNode, node$operands, MoreArgs = list(binvec = binvec))))
    }
  }
}

# evalRobustness <- function(func, boolfn, numSamples=100) {
#   changed <- notchanged <- 0
#   for (i in 1:numSamples) {
#     randvec <- sample(0:1, 5, replace=TRUE)
#     output <- func(boolfn, randvec)
#     output.flip <- func(boolfn, randFlip(randvec))
#     if (output == output.flip) {
#       notchanged <- notchanged +1
#     } else {
#       changed <- changed +1
#     }
#   }
#   return(c(changed, notchanged))
# }

# tree <- net$interactions
# example usage: evalRobustness(evalNode, tree$F1)

evalRobustness <- function(boolfn, vecLength=5, numSamples=100) {
  changed <- notchanged <- 0
  for (i in 1:numSamples) {
    randvec <- sample(0:1, vecLength, replace=TRUE)
    output <- evalNode(boolfn, randvec)
    output.flip <- evalNode(boolfn, randFlip(randvec))
    if (output == output.flip) {
      notchanged <- notchanged +1
    } else {
      changed <- changed +1
    }
  }
#  return(c(changed, notchanged))
  return(changed)
}

boolfuncheur.main <- function() {
  for (i in 1:10) {
    print(evalRobustness(tree[[paste("F",toString(i),sep="")]], numSamples=1000))
  }
}


# functionGeneration function for BoolNet::generateRandomKNNetwork
generateBalancedBinvec <- function(input, balance=0.5) {
  n <- 2**length(input)
  a <- rep(0, n)
  a[sample(1:n, floor(n*balance))] <- 1
  return(a)
}


generateRNet <- function(filename="rnet.txt", nGenes=10, nVar=4) {
  rnet <- generateRandomNKNetwork(nGenes, k=nVar, topology = "fixed", functionGeneration = generateBalancedBinvec)
  saveNetwork(simplifyNetwork(rnet), filename, generateDNFs = FALSE)
  rnet <<- loadNetwork(filename, symbolic = TRUE) #global assignment operator <<-
}

# boolfuncnetheur.main <- function() {
#   if (! exists("rnet")) {
#     generateRNet()
#   }
#   for (i in 1:10) {
#     print(evalRobustness(rnet$interactions[[paste("Gene",toString(i),sep="")]], vecLength=10, numSamples=5000))
#   }
# }



###
# Main program
###
main.program1 <- function() {
  ergebnisse <- c()
  generateRNet(nVar=4)
  #loadNetwork("rnet.txt")
  for (i in 1:10) {
    ergebnisse[i] <- evalRobustness(rnet$interactions[[paste("Gene",toString(i),sep="")]], vecLength=10, numSamples=1000)
  }
  ergebnisse <- data.frame(ergebnisse)
  ggplot(ergebnisse, aes(x=1, y=ergebnisse)) + geom_boxplot(outlier.size = 1.5, outlier.shape = 21) + geom_point()


  ergebnisse <- data.frame()
  for (inet in 1:3) {
    generateRNet(filename=paste("rnet",toString(inet),".txt",sep=""), nVar=2+inet)
    for (i in 1:10) {
      ergebnisse[inet,i] <- evalRobustness(rnet$interactions[[paste("Gene",toString(i),sep="")]], vecLength=10, numSamples=1000)
    }
  }
  ergebnisse <- data.frame(t(ergebnisse))
  #ggplot(ergebnisse) + geom_boxplot(outlier.size = 1.5, outlier.shape = 21) + geom_point()
  pdf(file="Rplot.pdf")
  ggplot(data=ergebnisse) + geom_boxplot(mapping=aes(x=1, y=X1)) + geom_point(mapping=aes(x=1, y=X1)) +
    geom_boxplot(mapping=aes(x=2, y=X2)) + geom_point(mapping=aes(x=2, y=X2)) +
    geom_boxplot(mapping=aes(x=3, y=X3)) + geom_point(mapping=aes(x=3, y=X2))
  dev.off()
}


main.program2 <- function() {
  library("ggpubr")
  source("TruthTable.R")
  # generateRNet(filename = "rnet-40.txt", nGenes=40, nVar=4)
  rnet <<- loadNetwork("rnet-40.txt", symbolic = TRUE)
  rules <- read.csv("rnet-40.txt", stringsAsFactors = FALSE)
  ergebnisse <- hops <- data.frame()
  for (i in 1:40) {
    geneName <- paste("Gene",toString(i),sep="")
    ergebnisse[i, "ROBUST"] <- evalRobustness(rnet$interactions[[geneName]], vecLength=40, numSamples=1000)
    ergebnisse[i, "HOPS"] <- evalGray4_TruthTable(rules[["factors"]][which(rules[["targets"]] == geneName)])
  }
  ggplot(data = ergebnisse) + geom_boxplot(mapping = aes(x = 1, y = ROBUST)) + geom_point(mapping = aes(x = 1, y = ROBUST))
  ggsave("Boxplots.png", device = "png")
  ggplot(data = ergebnisse, mapping = aes(x=HOPS, y=ROBUST)) + geom_point() + geom_smooth(method = "lm", se=FALSE) + stat_regline_equation(label.y = 75, aes(label = ..rr.label..))
  ggsave("Scatterplot.png", device = "png")
}