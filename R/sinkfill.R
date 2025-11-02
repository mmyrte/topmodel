#' Fill sinks in a digital elevation model
#'
#' Removes sinks in a digital elevation model by filling depressions
#'
#' @param DEM A matrix representing a digital elevation model [m] with equally sized pixels and equal x and y resolution
#' @param res Resolution of the digital elevation model [m]
#' @param degree Minimum slope to be kept between cells when filling [degrees]
#'
#' @details
#' For deep sinks or large maps, it may be possible that not all sinks are filled in one run. Then the function should be applied repeatedly over the same object.
#'
#' @return A matrix of the same size as the DEM.
#'
#' @references See \url{https://github.com/ICHydro/topmodel} for examples.
#'
#' @author Wouter Buytaert, Imperial College London, based on an implementation from the
#' Hydrology Group of Lancaster University
#'
#' @seealso topmodel, topidx
#'
#' @examples
#' data(huagrahuma.dem)
#' filled.dem <- sinkfill(huagrahuma.dem, 25, 0.1)
#'
#' @export
sinkfill <- function(DEM, res, degree) {
  ## data preparation

  stopifnot(is(DEM, "matrix"))

  if (min(as.vector(DEM[!is.na(DEM)])) < -9000) {
    stop("DEM contains unrealistic values (< -9000)")
  }

  DEM[is.na(DEM)] <- -9999

  nrow <- dim(DEM)[1]
  ncol <- dim(DEM)[2]

  ##  exclude an area of the DEM from the calculations
  ##  still to implement in R (using NA's)

  result <- .C(
    "c_sinkfill",
    PACKAGE = "topmodel",
    as.double(DEM),
    result = double(nrow * ncol + 2),
    as.integer(nrow),
    as.integer(ncol),
    as.double(res),
    as.double(degree)
  )$result

  ## formatting of the results
  ## the first position in result gives the number of iterations that have been performed

  result[result > 999998] <- NA

  if (result[1] == -1) {
    cat("incomplete sink removal\n")
  } else {
    if (result[1] == 100) {
      cat(
        "Maximum number of iterations reached (100).\nSink removal is probably not complete; please run again\n"
      )
    } else {
      cat("number of iterations = ", result[1], "\n")
    }
  }

  cat("number of sinks left = ", result[2], "\n")

  return(matrix(result[3:(nrow * ncol + 2)], nrow = nrow))
}
