library("BoolNet")
library("ggplot2")
library("ggpubr")
source("TruthTable.R")
#net <- loadNetwork("funktionen.txt", symbolic = TRUE)
perturbieren <- function() {
  for (i in 1:10) {
    r <- perturbTrajectories(net, measure="sensitivity", numSamples=200000, flipBits = 1, gene=paste("F",toString(i),sep=""))
    print(r$value)
  }
}

randFlip <- function(x, used) {
  i <- sample(unique(used), 1)
  x[i] <- !x[i]
  return(x)
}

evalNode <- function(node, binvec) {
  if (node$type == "atom") {
    glob_IndicesVector <<- c(glob_IndicesVector, node$index) #does not work without global variable from evalRobustness
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
    glob_IndicesVector <<- c() #global variable for the occurring node indices => generate only relevant bitflips
    randvec <- sample(0:1, vecLength, replace=TRUE)
    output <- evalNode(boolfn, randvec)
    output.flip <- evalNode(boolfn, randFlip(randvec, glob_IndicesVector))
    if (output == output.flip) {
      notchanged <- notchanged +1
    } else {
      changed <- changed +1
    }
  }
  rm(glob_IndicesVector) #garbage collection
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
  rnet <- generateRandomNKNetwork(n=nGenes, k=nVar, topology = "fixed", functionGeneration = generateBalancedBinvec)
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


main.program2 <- function(n) {
  # generateRNet(filename = "rnet-400.txt", nGenes=n, nVar=4)
  rnet <<- loadNetwork("rnet-400.txt", symbolic = TRUE)
  rules <- read.csv("rnet-400.txt", stringsAsFactors = FALSE)
  ergebnisse <<- data.frame()
  for (i in 1:n) {
    geneName <- paste("Gene",toString(i),sep="")
    ergebnisse[i, "CHANGING_FLIPS"] <<- evalRobustness(rnet$interactions[[geneName]], vecLength=n, numSamples=1000)
    # ergebnisse[i, "HOPS"] <<- evalGray4_TruthTable(rules[["factors"]][which(rules[["targets"]] == geneName)])
    ergebnisse[i, "HOPS"] <<- evalHops.total(rules[["factors"]][which(rules[["targets"]] == geneName)])
    ergebnisse[i, "TYPE"] <<- "BalancedBinvec"
  }
  ggplot(data = ergebnisse) + geom_boxplot(mapping = aes(x = 1, y = CHANGING_FLIPS)) + geom_point(mapping = aes(x = 1, y = CHANGING_FLIPS))
  ggsave("Boxplots.png", device = "png")
  ggplot(data = ergebnisse, mapping = aes(x=HOPS, y=CHANGING_FLIPS)) + geom_point() + geom_smooth(method = "lm", se=FALSE) + stat_regline_equation(label.y = 75, aes(label = ..rr.label..))
  ggsave("Scatterplot-totalhops.png", device = "png")
  # print(cluster::pam(ergebnisse, 2))
}

main.canal <- function(n) {
  # canalnet <- generateRandomNKNetwork(n=n, k=4, topology = "fixed", functionGeneration = generateCanalyzing)
  # saveNetwork(canalnet, "canalnet.txt")
  canalnet <- loadNetwork("canalnet.txt", symbolic = TRUE)
  rules <- read.csv("canalnet.txt", stringsAsFactors = FALSE)
  ergebnisse.canal <<- data.frame()
  for (i in 1:n) {
    geneName <- paste("Gene",toString(i),sep="")
    ergebnisse.canal[i, "CHANGING_FLIPS"] <<- evalRobustness(canalnet$interactions[[geneName]], vecLength=n, numSamples=1000)
    # ergebnisse.canal[i, "HOPS"] <<- evalGray4_TruthTable(rules[["factors"]][which(rules[["targets"]] == geneName)])
    ergebnisse.canal[i, "HOPS"] <<- evalHops.total(rules[["factors"]][which(rules[["targets"]] == geneName)])
    ergebnisse.canal[i, "TYPE"] <<- "Canalyzing"
  }
  ggplot(data = ergebnisse.canal) + geom_boxplot(mapping = aes(x = 1, y = CHANGING_FLIPS)) + geom_point(mapping = aes(x = 1, y = CHANGING_FLIPS))
  ggsave("Canalyzing-Boxplot.png", device = "png")
  ggplot(data = ergebnisse.canal, mapping = aes(x=HOPS, y=CHANGING_FLIPS)) + geom_point() + geom_smooth(method = "lm", se=FALSE) + stat_regline_equation(label.y = 75, aes(label = ..rr.label..))
  ggsave("Canalyzing-Scatterplot-totalhops.png", device = "png")
}

main.nestcanal <- function(n) {
  # nestcanalnet <- generateRandomNKNetwork(n=n, k=4, topology = "fixed", functionGeneration = generateNestedCanalyzing)
  # saveNetwork(nestcanalnet, "nestcanalnet.txt")
  nestcanalnet <- loadNetwork("nestcanalnet.txt", symbolic = TRUE)
  rules <- read.csv("nestcanalnet.txt", stringsAsFactors = FALSE)
  ergebnisse.nestcanal <<- data.frame()
  for (i in 1:n) {
    geneName <- paste("Gene",toString(i),sep="")
    ergebnisse.nestcanal[i, "CHANGING_FLIPS"] <<- evalRobustness(nestcanalnet$interactions[[geneName]], vecLength=n, numSamples=1000)
    # ergebnisse.nestcanal[i, "HOPS"] <<- evalGray4_TruthTable(rules[["factors"]][which(rules[["targets"]] == geneName)])
    ergebnisse.nestcanal[i, "HOPS"] <<- evalHops.total(rules[["factors"]][which(rules[["targets"]] == geneName)])
    ergebnisse.nestcanal[i, "TYPE"] <<- "NestedCanalyzing"
  }
  ggplot(data = ergebnisse.nestcanal) + geom_boxplot(mapping = aes(x = 1, y = CHANGING_FLIPS)) + geom_point(mapping = aes(x = 1, y = CHANGING_FLIPS))
  ggsave("NestedCanalyzing-Boxplot.png", device = "png")
  ggplot(data = ergebnisse.nestcanal, mapping = aes(x=HOPS, y=CHANGING_FLIPS)) + geom_point() + geom_smooth(method = "lm", se=FALSE) + stat_regline_equation(label.y = 75, aes(label = ..rr.label..))
  ggsave("NestedCanalyzing-Scatterplot-totalhops.png", device = "png")
}