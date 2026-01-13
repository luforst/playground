library(schoolmath)

antworten <- c(148,151,152,157,164,166,173,179,181,184)

for (i in antworten) {
  cat("Anzahl Primzahlen kleiner als ", i, ": ", length(primes(1, i)), "\n")
}

test_jubel <-function(x) {
  # x := Elfengesamtzahl
  anzahl.jubeln <- 0
  for (k in 1:x) {
    # k-te Runde des Ballspiels
    beteiligte <- c(1)
    while (beteiligte[length(beteiligte)] != 1 | length(beteiligte) == 1) {
      beteiligte <- c(beteiligte, (beteiligte[length(beteiligte)] + k) %% x)
 #     print(beteiligte)
    }
 #   if (sort(unique(beteiligte)) == 1:x) {
 #   if (all(1:x %in% beteiligte)) {
    if (all(sort(unique(beteiligte)) == 0:(x-1))) {
      anzahl.jubeln <- anzahl.jubeln + 1
    }
  }
  return(anzahl.jubeln)
}

for (i in antworten) {
  cat("Bei ", i, " Elfen wird ", test_jubel(i), " mal gejubelt.\n")
}

# => Bei 163 Elfen wird 80-mal gejubelt!
