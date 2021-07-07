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
    geometry = load_geometry,
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

add_vars <- function(data, variable_type = "subject") {
  if(variable_type == "subject") {
    variables = subject_variable_names
  } else if(variable_type == "profile") {
    variables = profile_variable_names
  } else if(variable_type == "other") {
    variables = other_variable_names
  }
  left_join(data, variables, by = c("variable" = "name"))
}

clean_data <- function(data, labels, variable_type = "subject") {
  add_vars(data, variable_type) %>%
  filter(label %in% labels$acs_label) %>%
  mutate(Estimate = round(estimate, digits=0)) %>%
  mutate(ACS_Label = label) %>%
  mutate(Display_Label = labels$display_label) %>%
  select(Estimate, ACS_Label, Display_Label) %>%
  distinct()
}

combine_age_and_race <- function(race) {
  return(race_by_age_labels %>%
    mutate(display_label = str_glue("{race} {display_label}")))
}

# the dplyr:collect loads the variables directly into memory, you can remove them if it slows down your machine
load_data <- function() {
  tidycensus::census_api_key("c26a4b8f1ec3d0bcee44f9e2ffd45a94a5f8c034", install = TRUE, overwrite = TRUE)
  current_year <<- as.integer(format(Sys.Date(), "%Y"))
  census_data <<- retrieve_census_data(current_year)
  other_variable_names <<- tidycensus::load_variables(latest_year, "acs5", cache = T)
  other_variable_names <<- dplyr::collect(other_variable_names)
  subject_variable_names <<- tidycensus::load_variables(latest_year, "acs5/subject", cache = T)
  subject_variable_names <<- dplyr::collect(subject_variable_names)
  profile_variable_names <<- tidycensus::load_variables(latest_year, "acs5/profile", cache = T)
  profile_variable_names <<- dplyr::collect(profile_variable_names)
}

combine_values <- function(df, variables, name) {
  total <- df[1,]$estimate
  df <- df %>%
    filter(variable %in% variables)
  values <- c(sum(df$estimate), sum(df$estimate)/total * 100)
  labels <- c("Total New American Children", "Percent New American Children")
  return(data.frame(
    Estimate = round(as.numeric(c(sum(df$estimate), sum(df$estimate)/total * 100), 1)),
    Display_Label = c(str_interp("Total ${name}"), str_interp("Percent ${name}")),
    ACS_Label = c(NA, NA)
  ))
}
