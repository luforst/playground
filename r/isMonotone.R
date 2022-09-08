# isMonotone <- function(input, func) #legacy
# {
# 	for (i in seq_len(ncol(input)))
# 	# check each input gene
# 	{
# 		groupResults <- split(func, input[,i])
# 		if (any(groupResults[[1]] < groupResults[[2]]) &&
# 			any(groupResults[[1]] > groupResults[[2]]))
# 		{	# the function is not monotone
# 			return(FALSE)
# 		}
# 	}
# 	return(TRUE)
# }


isMonotone.incr <- function(func) {
  perm <- expand.grid(rep(list(c(FALSE, TRUE)), log2(length(func))))
  for (i in 1:length(func)) {
    for (k in 1:log2(length(func))) {
      vec <- perm[i,]
      vec[k] <- TRUE
      for (n in 1:length(func)) {
        if (all(perm[n,] == vec) & func[n] < func[i]) {
            return(FALSE)
        }
      }
    }
  }
  return(TRUE)
}

isMonotone.decr <- function(func) {
  perm <- expand.grid(rep(list(c(FALSE, TRUE)), log2(length(func))))
  for (i in 1:length(func)) {
    for (k in 1:log2(length(func))) {
      vec <- perm[i,]
      vec[k] <- TRUE
      for (n in 1:length(func)) {
        if (all(perm[n,] == vec) & func[n] > func[i]) { #comparison inverted for monotonically decreasing
          return(FALSE)
        }
      }
    }
  }
  return(TRUE)
}

isMonotone <- function(func) {
  return(isMonotone.incr(func) | isMonotone.decr(func))
}