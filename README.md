# gPASconnectoR

<!-- badges: start -->
[![codecov](https://codecov.io/gh/joundso/gpas_connector/branch/master/graph/badge.svg)](https://codecov.io/gh/joundso/gpas_connector)
[![pipeline status](https://git.uk-erlangen.de/mik-diz/mik-diz-tea/r-packages/gpas_connector/badges/master/pipeline.svg)](https://git.uk-erlangen.de/mik-diz/mik-diz-tea/r-packages/gpas_connector/commits/master)
[![coverage report](https://git.uk-erlangen.de/mik-diz/mik-diz-tea/r-packages/gpas_connector/badges/master/coverage.svg)](https://git.uk-erlangen.de/mik-diz/mik-diz-tea/r-packages/gpas_connector/commits/master)
[![CRAN Status Badge](https://www.r-pkg.org/badges/version-ago/gPASconnectoR)](https://cran.r-project.org/package=gPASconnectoR)
[![Cran Checks](https://cranchecks.info/badges/worst/gPASconnectoR)](https://cran.r-project.org/web/checks/check_results_gPASconnectoR.html)
<!-- badges: end -->

The R package `gPASconnectoR` provides utility functions used to access a running gPAS-Instance.

## Installation

<!---
You can install `gPASconnectoR` directly from CRAN:

```r
install.packages("gPASconnectoR")
```
-->

The development version can be installed using

```r
install.packages("devtools")
devtools::install_github("joundso/gpas_connector", ref = "development")
```

## Basic functions

### Pseudonymize a value(set)

#### Without setting the environment variables

```R
res <- gPASconnectoR::pseudonymize(
  GPAS_BASE_URL = "https://your-organization.org",
  GPAS_PSEUDONYM_DOMAIN = "https://fhir.your.organization.org/identifiers/person-id",
  gpas_fieldvalue = c(123, 456, "abc")
)

## Result (e.g.):
res
#> $`123`
#> [1] "psn-pid.217172DEACFA2C751515641C"
#> 
#> $`456`
#> [1] "psn-pid.41A7D91C53DC2A457FBAB041"
#> 
#> $abc
#> [1] "psn-pid.1FFDF5A91EA051608AC4E03A"
```

#### With setting the environment variables

Simply fill a `.env` file:

```sh
## Save this e.g. as `demo.env`:
GPAS_BASE_URL=https://your-organization.org
GPAS_PSEUDONYM_DOMAIN=https://fhir.your.organization.org/identifiers/person-id
```

Then read in the file and assign all variables to the environment:

```R
## Read in the '.env' file:
DIZutils::set_env_vars(env_file = "./demo.env")

## And use the smaller function call:
res <- gPASconnectoR::pseudonymize(c(123, 456, "abc"))

## Result (e.g.):
res
#> $`123`
#> [1] "psn-pid.217172DEACFA2C751515641C"
#> 
#> $`456`
#> [1] "psn-pid.41A7D91C53DC2A457FBAB041"
#> 
#> $abc
#> [1] "psn-pid.1FFDF5A91EA051608AC4E03A"
```

#### Accessing the result

```R
## Result (e.g.):
res
#       123        456        abc
# "000C30WP" "T4ECWT4Q" "Y2FAYH5D"

## The result is a named list and can be accessed like this:
## Access the element with the name "123" (and receive a single-item-list):
res["123"]
# Result:
#        123 
#  "000C30WP"

## Access the element with the name "123" (and receive a string):
res[["123"]]
# Result:
# "000C30WP"

## Access the first element (and receive a string):
res[[1]]
# Result:
# "000C30WP"
```

### De-Pseudonymize a value(set)

This is exactly the same like pseudonymizing, but use `gPASconnectoR::depseudonymize` instead of `gPASconnectoR::pseudonymize`.

## More Infos

* Some debugging and other examples can be found in the file [`data-raw/debugging.R`](./data-raw/debugging.R).
* About the gPAS in its [Repo](https://bitbucket.org/medicalinformatics/gPAS/src/master) or its [Wiki](https://bitbucket.org/medicalinformatics/gPAS/wiki/Home)
* About MIRACUM: <https://www.miracum.org/>
* About the Medical Informatics Initiative: <https://www.medizininformatik-initiative.de/index.php/de>
