#' Calculates the flow distance towards the catchment outlet
#'
#' Given a digital elevation model and the coordinates of the catchment outlet,
#' this function calculates the flowlength of each gridcell to the outlet, based
#' on a single flow direction algorithm (D8).
#'
#' @param DEM A matrix representing a digital elevation model [m] with equally sized
#' pixels and equal NS and EW resolution
#' @param outlet A vector containing the row and column indices of the pixel
#'   representing the catchment outlet.
#'
#' @details
#' The function returns the flowlength in cell size units. So you have to multiply by
#' the map resolution to get the flow in meters.
#'
#' @return A matrix of the same size as \code{DEM}
#'
#' @references See \url{https://github.com/ICHydro/topmodel} for examples.
#'
#' @author Wouter Buytaert, Imperial College London, based on an implementation from the
#' Hydrology Group of Lancaster University
#'
#' @seealso sinkfill, river
#'
#' @export
flowlength <- function(DEM, outlet) {
  ## data preparation

  stopifnot(is(DEM, "matrix"))

  if (min(as.vector(DEM[!is.na(DEM)])) > 999998) {
    stop("DEM contains unrealistic values (> 999998)")
  }

  if (!is.na(outlet[1]) & !is(outlet, "numeric") & length(outlet) != 2) {
    stop("Outlet should be a vector of length 2")
  }

  DEM[is.na(DEM)] <- 999999

  nrow <- dim(DEM)[1]
  ncol <- dim(DEM)[2]

  if (is.na(outlet[1])) {
    outlet[1] <- -1
    outlet[2] <- -1
  } else {
    if (
      (outlet[1] > nrow) ||
        (outlet[1] < 1) ||
        (outlet[2] > ncol) ||
        (outlet[2] < 1)
    ) {
      stop("Outlet should represent coordinates c(row, column) in the DEM")
    }
  }

  ## calling the function

  result <- .C(
    "c_flowlength",
    PACKAGE = "topmodel",
    as.double(DEM),
    result = double(nrow * ncol),
    as.integer(nrow),
    as.integer(ncol),
    as.integer(outlet[1]),
    as.integer(outlet[2])
  )$result

  ## formatting of the results

  result[result < 0] <- NA

  return(matrix(result, nrow = nrow))
}
