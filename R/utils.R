# gPASconnectoR
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


#' @title Helper function to perform the (de)pseudonymization
#' @description Helper function to perform the (de)pseudonymization
#' @param GPAS_BASE_URL (Optional, String)
#'   The URL to your gPAS API.
#'   E.g. 'https://gpas.hospital.org'.
#' @param GPAS_PSEUDONYM_DOMAIN (Optional, String) The name of
#'   the pseudonym domain configured in gPAS.
#' @param depseudonymize (boolean, default = FALSE).
#'   Do you want to depseudonymize the values? If false, the values will be
#'   pseudonymized.
#' @param allow_create (boolean, default = TRUE). Do you want to create
#'   new pseudonyms if there is no pseudonym for some of your values yet?
#'   The value of this parameter has no effect, if `depseudonymize == TRUE`.
#' @param gpas_fieldvalue (String) The actual value(s) to pseudonymized.
#' @param from_env (Optional, Boolean, Default = `TRUE`) If true, the
#'   connection parameters `GPAS_BASE_URL`, `GPAS_PSEUDONYM_DOMAIN`
#'   are read from the environment
#'   and can therefore be left empty when calling this function.
#'
#' @return (vector) All pseudonyms for the input values.
#'
gpas <-
  function(GPAS_BASE_URL = NULL,
           GPAS_PSEUDONYM_DOMAIN = NULL,
           depseudonymize = FALSE,
           allow_create = TRUE,
           gpas_fieldvalue,
           from_env = FALSE) {
    if (from_env) {
      GPAS_BASE_URL <- Sys.getenv("GPAS_BASE_URL")
      GPAS_PSEUDONYM_DOMAIN <- Sys.getenv("GPAS_PSEUDONYM_DOMAIN")
    }

    if (rapportools::is.empty(GPAS_BASE_URL) ||
        rapportools::is.empty(GPAS_PSEUDONYM_DOMAIN)) {
      DIZutils::feedback(
        print_this = paste0(
          "One of the connection parameters for gPAS is empty.",
          " Please fix."
        ),
        type = "Error",
        findme = "fbda9e74e3"
      )
      stop("See error above")
    }

    input <- ifelse(test = depseudonymize,
                    yes = "pseudonym",
                    no = "original")
    output <- ifelse(test = depseudonymize,
                     yes = "original",
                     no = "pseudonym")


    ## Make sure the base URL ends with a tailing slash:
    GPAS_BASE_URL <-
      DIZutils::clean_path_name(pathname = GPAS_BASE_URL,
                                remove.slash = FALSE)

    data <- list("resourceType" = "Parameters",
                 "parameter" =       c(list(
                   list("name" = "target",
                        "valueString" = GPAS_PSEUDONYM_DOMAIN)
                 ), lapply(
                   X = gpas_fieldvalue,
                   FUN = function(x) {
                     list("name" = input, "valueString" = x)
                   }
                 )))
    body <- jsonlite::toJSON(data
                             # , pretty = T
                             , auto_unbox = T)

    ## Default:
    GPAS_ACTION = "$pseudonymize-allow-create"
    if (depseudonymize) {
      GPAS_ACTION = "$de-pseudonymize"
    } else {
      if (allow_create) {
        GPAS_ACTION = "$pseudonymize-allow-create"
      } else {
        GPAS_ACTION = "$pseudonymize"
      }
    }

    res_json <-
      httr::POST(
        url = paste0(GPAS_BASE_URL, GPAS_ACTION),
        body = body,
        encode = "json",
        httr::add_headers("Content-Type" = "application/json")
      )
    res <-
      jsonlite::fromJSON(httr::content(x = res_json, as = "text"))


    return(sapply(res$parameter$part, function(x) {
      res_apply <- list()
      if (any(grepl(
        pattern = "error",
        x = x$name,
        ignore.case = TRUE
      ))) {
        if (allow_create) {
          DIZutils::feedback(
            print_this = paste0(
              "Value '",
              x[x$name == input, "valueString"],
              "' couldn't be ",
              ifelse(depseudonymize, "de", ""),
              "pseudonymized",
              ifelse(
                test = depseudonymize,
                yes = ".",
                no = " although creating new pseudonyms was enabled."
              ),
              " This is the error message: '",
              x[grepl(pattern = "error",
                      x = x$name,
                      ignore.case = TRUE), "valueCoding"][["display"]]
              ,
              "'."
            ),
            type = "Error",
            findme = "4729883bfe"
          )
          stop("See error above")
        }
        res_apply[x[x$name == input, "valueString"]] <- NA
      } else {
        res_apply[x[x$name == input, "valueString"]] <-
          x[x$name == output, "valueString"]
      }

      return(res_apply)
    }))
  }
