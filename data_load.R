tidycensus::census_api_key("c26a4b8f1ec3d0bcee44f9e2ffd45a94a5f8c034", install = TRUE, overwrite= TRUE)
current_year = as.integer(format(Sys.Date(), "%Y"))
latest_year <- current_year
retrieve_census_data <- function(year) {
  data = data.frame()
  retrieved_data = FALSE
  for(i in 0:10) {
    if(retrieved_data) {break}
    tryCatch({
      data <- tidycensus::load_variables(year - i, "acs5/subject", cache = TRUE)
      print(data)
      retrieved_data = T
      latest_year <<- year-i
    }, error = function(e) {
    })
  }
  return(data)
}

census_data <- retrieve_census_data(current_year)


data2 <- tidycensus::load_variables(latest_year, "acs5", cache = TRUE)

## Load xlsx requirements
DEVO <- read_xlsx("ACSRequirements.xlsx", 1)
CNAC <- read_xlsx("ACSRequirements.xlsx", 2)
Parenting <- read_xlsx("ACSRequirements.xlsx", 3)