call_tidycensus <- function(geo, table) {
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
    state <- NULL
    geography <- "zcta"
    county <- NULL
    # zcta <- houston_zip_codes
    zcta <- 12211
  }
  
  return(
    tidycensus::get_acs(
      geography = geography,
      zcta = zcta,
      state = state,
      county = county,
      survey = "acs5",  
      table = table
      )
  )
}
houston_ages = call_tidycensus("city", "S0101")
