#' Make topographic index classes from a topographic index map
#'
#' This function splits a dataset in n evenly distributed classes and calculates the number of elements of each class. It is very similar to \code{hist()}, but \code{hist()} does not always keep the number of breaks requested
#'
#' @param array A numeric vector or matrix
#' @param n Number of breaks
#'
#' @return The function returns a data matrix with 2 columns. Column \code{breaks} contains the upper limits of each class, while \code{counts} contains the number of elements
#'
#' @author Wouter Buytaert, Imperial College London
#'
#' @seealso \code{\link{topidx}}, \code{\link{topmodel}}
#'
#' @export
make.classes <- function(array, n) {
  array <- array[!is.na(array)]
  breaks <- seq(min(array), max(array), len = n)
  interval <- findInterval(array, breaks, rightmost.closed = T)
  counts <- tabulate(interval)
  counts <- counts[order(breaks[2:n], decreasing = T)]
  breaks <- breaks[order(breaks, decreasing = T)]
  counts <- counts / sum(counts)
  return(data.matrix(cbind(breaks, c(0, counts))))
}
