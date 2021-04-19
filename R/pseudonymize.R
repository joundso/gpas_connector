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


#' @title Get a pseudonym for a value
#' @description Get a pseudonym for a value
#' @param GPAS_BASE_URL (Optional, String)
#'   The URL to your gPAS API.
#'   E.g. 'https://ml.hospital.de'.
#' @param GPAS_API_KEY (Optional, String)
#'   The API key which is allowed to access the gPAS.
#' @param GPAS_FIELDNAME (Optional, String) The name of
#'   the field to use for the gPAS. Specified in the ML-config.
#' @param gpas_fieldvalue (String) The actual value to pseudonymized.
#' @param from_env (Optional, Boolean, Default = `FALSE`) If true, the
#'   connection parameters `GPAS_BASE_URL`, `GPAS_API_KEY` and
#'   `GPAS_FIELDNAME` are read from the environment
#'   and can therefore be left empty when calling this function.
#'
#' @return (vector) All pseudonyms for the input values.
#' @export
#'
pseudonymize <-
  function(GPAS_BASE_URL = NULL,
           GPAS_API_KEY = NULL,
           GPAS_FIELDNAME = NULL,
           gpas_fieldvalue,
           from_env = FALSE) {

  }
