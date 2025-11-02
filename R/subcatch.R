#' Identify a hydrological catchment based on a single direction flow algorithm
#'
#' Identify a hydrological catchment based on a single direction flow algorithm
#'
#' @param DEM A matrix representing a digital elevation model [m] with equally sized pixels and equal x and y resolution
#' @param outlet A vector containing the row and column indices of the pixel
#'   representing the catchment outlet.
#'
#' @return A binary matrix of the same size as \code{DEM}.
#'
#' @references See \url{https://github.com/ICHydro/topmodel} for examples.
#'
#' @author Wouter Buytaert, Imperial College London, based on an implementation from the
#' Hydrology Group of Lancaster University
#'
#' @seealso \code{\link{topmodel}}
#'
#' @export
subcatch <- function(DEM, outlet) {
  ## data preparation

  stopifnot(is(DEM, "matrix"))

  if (min(as.vector(DEM[!is.na(DEM)])) > 999998) {
    stop("DEM contains unrealistic values (> 999999)")
  }

  DEM[is.na(DEM)] <- 999999

  nrow <- dim(DEM)[1]
  ncol <- dim(DEM)[2]

  if (
    (outlet[1] > nrow) ||
      (outlet[1] < 1) ||
      (outlet[2] > ncol) ||
      (outlet[2] < 1)
  ) {
    stop("Outlet should represent coordinates c(row, column) in the DEM")
  }

  ## calling the function

  result <- .C(
    "c_subcatch",
    PACKAGE = "topmodel",
    as.double(DEM),
    result = integer(nrow * ncol),
    as.integer(nrow),
    as.integer(ncol),
    as.integer(outlet[1]),
    as.integer(outlet[2])
  )$result

  ## formatting of the results

  return(matrix(result, nrow = nrow))
}
