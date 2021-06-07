# Cleanup the backend in RStudio:
cat("\014") # Clears the console (imitates CTR + L)
rm(list = ls(all.names = TRUE)) # Clears the Global Environment/variables/data
invisible(gc()) # Garbage collector/Clear unused RAM

## Start to code here:

## Load some variables to the environment:
Sys.setenv("GPAS_BASE_URL" = "https://your-organization.org")
Sys.setenv("GPAS_PSEUDONYM_DOMAIN" = "https://fhir.your.organization.org/identifiers/person-id")

## Load the variables from a file:
DIZutils::set_env_vars(env_file = "./data-raw/demo.env")
DIZutils::set_env_vars(env_file = "../gpas_connector.env")

## Convert the real ids to pseudonyms:
res <- gPASconnectoR::pseudonymize(
  gpas_fieldvalue = c(123, 456, "abc"),
  from_env = TRUE
)

## Convert the pseudonyms back to real ids:
gPASconnectoR::depseudonymize(
  gpas_fieldvalue = as.character(res),
  from_env = TRUE
)

