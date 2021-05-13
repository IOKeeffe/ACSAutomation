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
    geography <- "place"
    county <- NULL
  }

  results <- tidycensus::get_acs(
    # geometry = load_geometry,
    geography = geography,
    state = state,
    county = county,
    survey = "acs5",  
    table = table,
    cache_table=T
    )
  if (filter_zip) {
    return(results %>% 
    filter(NAME == "Houston city, Texas"))
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
  if(use_profile_table) {
    vars = profile_variable_names } 
  else { vars = subject_variable_names }
  left_join(data, vars, by = c("variable" = "name"))
}

clean_data <- function(data, labels, locality, use_profile_table = F) {
  add_vars(data, use_profile_table) %>%
    filter(label %in% labels) %>%
    group_by(label) %>%
    mutate(Estimate = sum(estimate)) %>%
    ungroup() %>%
    mutate(Locality = locality) %>%
    mutate(Label = label) %>%
    select(Estimate, Label, Locality) %>%
    distinct()
}

load_data <- function() {
  tidycensus::census_api_key("c26a4b8f1ec3d0bcee44f9e2ffd45a94a5f8c034", install = TRUE, overwrite = TRUE)
  current_year <<- as.integer(format(Sys.Date(), "%Y"))
  census_data <<- retrieve_census_data(current_year)
  subject_variable_names <<- tidycensus::load_variables(latest_year, "acs5/subject", cache = T)
  subject_variable_names <<- dplyr::collect(subject_variable_names)
  profile_variable_names <<- tidycensus::load_variables(latest_year, "acs5/profile", cache = T)
  profile_variable_names <<- dplyr::collect(profile_variable_names)
}
