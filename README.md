# TOPMODEL R Package

An R implementation of the hydrological model TOPMODEL, based on the 1995 FORTRAN version by Keith Beven. This package provides a set of hydrological functions for rainfall-runoff modeling and catchment analysis.

## Installation

This package is currently not available on CRAN as it is in maintenance mode. You can install it from GitHub using:

```r
devtools::install_github("ICHydro/topmodel")
```

## Main Features

- **Rainfall-runoff modeling**: Simulate discharge from precipitation and evapotranspiration data
- **Topographical analysis**: Calculate topographic indices and flow delay functions from digital elevation models
- **Sensitivity analysis**: Explore parameter sensitivity using Monte Carlo sampling
- **Uncertainty analysis**: GLUE (Generalized Likelihood Uncertainty Estimation) framework for prediction uncertainty

## Quick Example

```r
library(topmodel)

# Load example data into global environment
data(huagrahuma)
list2env(huagrahuma, envir = .GlobalEnv)

# Run the model
Qsim <- topmodel(
  parameters,
  topidx,
  delay,
  rain,
  ETp
)

# Evaluate performance
NSeff(
  Qobs,
  Qsim
)
```

## Background

TOPMODEL is a physically-based, variable contributing area model of basin hydrology that uses topographic indices to represent the spatial variability of hydrological processes. The model was originally developed by Beven and Kirkby (1979) and has been widely used in hydrological research and applications.

## References

- Beven, K. J., Kirkby, M. J. (1979). A physically based variable contributing area model of basin hydrology. *Hydrological Sciences Bulletin*, 24, 43-69.
- Beven K, Lamb R, Quinn P, Romanowicz R, Freer J (1995). TOPMODEL. In: Singh VP (Ed), *Computer Models of Watershed Hydrology*. Water Resources Publications, Colorado. pp. 627-668.

## Documentation

For detailed examples and documentation, see the package help files. A complete example workflow is available in `inst/examples/Full Run.R`.
