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


#' @title Convert a pseudonym back to its input value.
#' @description Convert a pseudonym back to its input value.
#' @inheritParams pseudonymize
#' @param gpas_fieldvalue (String) The actual value to de-pseudonymized.
#'
#' @return (vector) All pseudonyms for the input values.
#' @export
#'
depseudonymize <-
  function(GPAS_BASE_URL = NULL,
           GPAS_API_KEY = NULL,
           GPAS_FIELDNAME = NULL,
           gpas_fieldvalue,
           from_env = FALSE) {
  }
