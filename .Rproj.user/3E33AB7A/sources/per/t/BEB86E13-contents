call_tidycensus <- function(geo, table) {
  filter_zip = F
  if(geo == "Texas" || geo == "state") {
    state <- texas_acs_code
    geography <- "state"
    county <- NULL
    zcta <- NULL
  } else if(geo == "Harris County" || geo == "county" ) {
    state <- texas_acs_code
    geography <- "county"
    county <- harris_county_acs_code
    zcta <- NULL
  } else if(geo == "Houston" || geo == "city") {
    filter_zip <- T
    state <- texas_acs_code
    geography <- "zcta"
    county <- NULL
    zcta <- houston_zip_codes
  }

  results <- tidycensus::get_acs(
    geography = geography,
    zcta = zcta,
    state = state,
    county = county,
    survey = "acs5",  
    table = table
    )
  if (filter_zip) {
    return(results %>% 
    filter(GEOID %in% houston_zip_codes))
  }
  else {
    return(results)
  }
  
}

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

add_variable_names <- function(data) {
  left_join(data, variable_names, by = c("variable" = "name")) %>%
    # select(-moe, -NAME, -GEOID) %>%
    group_by(variable) %>%
    mutate(estimate = sum(estimate)) %>%
    distinct()
}

# harris_z_2 <- tidycensus::get_acs(
#    geography = "tract",
#    survey="acs5",
#    table="S0101",
#    state="TX",
#    geometry = TRUE)
