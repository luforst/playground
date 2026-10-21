library(microbenchmark)

# efficient R section 1.6.3.1
x = 1:100 # initiate vector to cumulatively sum

# Method 1: with a for loop (10 lines)
cs_for = function(x) {
  for (i in x) {
    if (i == 1) {
      xc = x[i]
    } else {
      xc = c(xc, sum(x[1:i]))
    }
  }
  xc
}

# Method 2: with apply (3 lines)
cs_apply = function(x) {
  sapply(x, function(x) sum(1:x))
}

# Method 3: cumsum (1 line, not shown)
microbenchmark(cs_for(x), cs_apply(x), cumsum(x))


x <- 1:50000
microbenchmark(cs_for(x), cs_apply(x), cumsum(x), times = 1)


df = data.frame(v = 1:4, name = letters[1:4])
microbenchmark(df[3, 2], df[3, "name"], df$name[3])


system.time(
  for (i in 1:50000) {
    df[3, 2]
  }
)
