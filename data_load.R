load_data <- function() {
  tidycensus::census_api_key("c26a4b8f1ec3d0bcee44f9e2ffd45a94a5f8c034", install = TRUE, overwrite = TRUE)
  current_year <<- as.integer(format(Sys.Date(), "%Y"))
  census_data <<- retrieve_census_data(current_year)
  subject_variable_names <<- tidycensus::load_variables(latest_year, "acs5/subject", cache = T)  
  profile_variable_names <<- tidycensus::load_variables(latest_year, "acs5/profile", cache = T)  
}
