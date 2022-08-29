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