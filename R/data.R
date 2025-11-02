#' Hydrological dataset to run TOPMODEL
#'
#' This is an example dataset from a small mountainous catchment in the South American Andes and contains the following data:
#'
#' \tabular{ll}{
#'   delay      \tab Cumulative delay function of the catchment\cr
#'   ETp        \tab FAO Penman Monteith potential evapotranspiration [m / 15 min]\cr
#'   parameters \tab Values for the TOPMODEL parameters\cr
#'   Qobs       \tab Observed discharge [m / 15 min]\cr
#'   rain       \tab Observed precipitation [m / 15 min]\cr
#' }
#'
#' @format A list containing:
#' \describe{
#'   \item{delay}{Cumulative delay function of the catchment}
#'   \item{ETp}{FAO Penman Monteith potential evapotranspiration [m / 15 min]}
#'   \item{parameters}{Values for the TOPMODEL parameters}
#'   \item{Qobs}{Observed discharge [m / 15 min]}
#'   \item{rain}{Observed precipitation [m / 15 min]}
#' }
#'
#' @references
#' Buytaert, W., De Bievre, B., Wyseure, G., Deckers, J., 2005. The effect of land use changes on the hydrological
#' behaviour of Histic Andosols in south Ecuador. Hydrological Processes 19: 3985 - 3997.
#'
#' @source Example dataset from a small mountainous catchment in the South American Andes
#'
"huagrahuma"

#' DEM of the Huagrahuma catchment, Ecuador
#'
#' Matrix containing a Digital Elevation Model of the Huagrahuma microcatchment, Ecuador, at 25 m resolution.
#'
#' @format A matrix representing a digital elevation model
#'
#' @references
#' Buytaert, W., De Bievre, B., Wyseure, G., Deckers, J., 2005. The effect of land use changes on the hydrological
#' behaviour of Histic Andosols in south Ecuador. Hydrological Processes 19: 3985 - 3997.
#'
#' @source Digital Elevation Model of the Huagrahuma microcatchment, Ecuador, at 25 m resolution
#'
"huagrahuma.dem"
