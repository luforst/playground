#These functions take a string containing a Boolean expression as arguments x and y
truth_table <- function(x) {
  vars <- unique(unlist(strsplit(x, "[^a-zA-Z]+")))
  vars <- vars[vars != ""]
  perm <- expand.grid(rep(list(c(FALSE, TRUE)), length(vars)))
  names(perm) <- vars
  perm[ , x] <- with(perm, eval(parse(text = x)))
  return(perm)
}

truth_table_diff <- function(x,y) {
  return(sum(truth_table(x)[,x] != truth_table(y)[,y]))
}

getBalance <- function(x) {
  tt <- truth_table(x)
  balance <- sum(tt[,x]) / nrow(tt)
  if (balance > 0.5) {
    balance <- 1-balance
  }
  return(balance)
}

balances.main <- function() {
  funcs <- c("A&B&C&D", "A&B&C&D&E", "A|B|C|D|E", "A & !B & !C & (D|E)", "!(A|B) & C & (D|E) & !(D&E)", "(A|B|C)&D&E", "(A&B) | (A&C&D)", "A&B&C | D", "A&B | C&D", "(A|B|C)&(D|E)")
  for (func in funcs) {
    print(getBalance(func))
  }
}

getBalance.Gene <- function(x) {
  tt <- getGray4_TruthTable(x)
  balance <- sum(tt[,x]) / nrow(tt)
  if (balance > 0.5) {
    balance <- 1-balance
  }
  return(balance)
}

getGray4_TruthTable <- function(x) {
  vars <- unique(unlist(strsplit(x, "[[:space:]]?[[:punct:]][[:space:]]?")))
  vars <- vars[vars != ""]
  perm <- data.frame(matrix(as.integer(unlist(strsplit("0000000100110010011001110101010011001101111111101010101110011000", ""))), 16,4, byrow=TRUE))
  names(perm) <- vars
  perm[ , x] <- with(perm, eval(parse(text = x)))
  return(perm)
}

evalGray4_TruthTable <- function(x) {
  vec <- getGray4_TruthTable(x)[,x]
  count <- 0
  for (i in 2:length(vec)) {
    if (vec[i] != vec[i-1]) {
      count <- count +1
    }
  }
  return(count)
}


#balanced Gray codes
getGray4_TruthTable.balanced <- function(x) {
  vars <- unique(unlist(strsplit(x, "[[:space:]]?[[:punct:]][[:space:]]?")))
  vars <- vars[vars != ""]
  perm <- data.frame(matrix(as.integer(unlist(strsplit("0000100011001101111111101010001001100100010101110011101110010001", ""))), 16,4, byrow=TRUE))
  names(perm) <- vars
  perm[ , x] <- with(perm, eval(parse(text = x)))
  return(perm)
}

evalGray4_TruthTable.balanced <- function(x) {
  vec <- getGray4_TruthTable.balanced(x)[,x]
  count <- 0
  for (i in 2:length(vec)) {
    if (vec[i] != vec[i-1]) {
      count <- count +1
    }
  }
  return(count)
}

evalHops.total <- function(x) {
  count <- 0
  vars <- unique(unlist(strsplit(x, "[[:space:]]?[[:punct:]][[:space:]]?")))
  vars <- vars[vars != ""]
  for (n in 0:15) {
    vec <- data.frame(t(tail(as.numeric(rev(intToBits(n))),4)))
    names(vec) <- vars
    result <- with(vec, eval(parse(text = x)))
    for (i in 1:4) {
      tmp <- vec
      tmp[,i] <- ! tmp[,i]
      if (result != with(tmp, eval(parse(text = x)))) {
        count <- count +1
      }
    }
  }
  return(count)
}