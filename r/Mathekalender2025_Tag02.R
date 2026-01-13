alle.kekse <- expand.grid(ausstecher = c("W", "E"),
                         teigzutat = c("V", "S"),
                         glasur = c("V", "S", "L"),
                         streusel = c("H", "P", "G"))
# kartesisches Produkt von {W, E} x {V, S} x {V, S, L} x {H, P, G}
alle.kekse <- data.frame(alle.kekse)
kekse.strings <- apply(alle.kekse, MARGIN = 1, function(x) paste(x, collapse = ""))

is.set <- function(a, b, c) {
  a <- strsplit(a, split="")[[1]]
  b <- strsplit(b, split="")[[1]]
  c <- strsplit(c, split="")[[1]]
  if (all(a[1] == b[1], a[1] == c[1], a[2] == b[2], a[2] == c[2])) {
    if ((a[3] == b[3] & a[3]==c[3]) | all(a[3] != b[3], a[3] != c[3], b[3] != c[3])) {
      if ((a[4] == b[4] & a[4]==c[4]) | all(a[4] != b[4], a[4] != c[4], b[4] != c[4])) {
        return(TRUE)
      }
    }
  }
  return(FALSE)
}

f <- function() {
  x <- kekse.strings[sample(1:36, 3)]
  print(is.set(x[1], x[2], x[3]))
}

library(utils) # für Funktion combn
experiment <- function(n) {
  x <- kekse.strings[sample(1:36, n)]
  setcount <- 0
  for (i in combn(x, m=3, simplify=F)) { # combn listet alle möglichen Untermengen mit m=3 Elementen auf
    if(is.set(i[1], i[2], i[3]))
      setcount <- setcount + 1
  }
  return(setcount)
}
ergebnis <- replicate(10000, experiment(10))
ergebnis <- replicate(10000, experiment(14))
ergebnis <- replicate(10000, experiment(15))
sum(ergebnis == 0)

sum(replicate(10000, experiment(20)) == 0) # = 0
sum(replicate(10000, experiment(16)) == 0) # mein Ergebnis war 7
sum(replicate(10000, experiment(17)) == 0) # = 0

sum(replicate(100000, experiment(17)) == 0) # = 0
