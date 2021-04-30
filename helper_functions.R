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
    state <- "tx"
    geography <- "zcta"
    county <- NULL
    zcta <- houston_zip_codes
  }

  results <- tidycensus::get_acs(
    # geometry = load_geometry,
    geography = geography,
    zcta = zcta,
    state = state,
    county = county,
    survey = "acs5",  
    table = table,
    cache_table=T
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

add_vars <- function(data, use_profile_table = F) {
  ifelse(profile_table, vars = subject_variable_names, vars=profile_variable_names)
  left_join(data, variable_names, by = c("variable" = "name"))
}

clean_data <- function(data, labels, use_profile_table = F) {
  add_vars(data, use_profile_table) %>%
    filter(label %in% labels) %>%
    group_by(label) %>%
    mutate(estimate = sum(estimate)) %>%
    ungroup() %>%
    select(estimate, label) %>%
    distinct()
}

