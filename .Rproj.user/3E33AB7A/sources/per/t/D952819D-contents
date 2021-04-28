list.of.packages <- c("tidycensus", "tidyverse", "readxl")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library(tidyverse)
library(tidycensus)
library(readxl)

source("variable_translations.R")
source("variables.R")
source("helper_functions.R")

#load census data api and set latest year
tidycensus::census_api_key("c26a4b8f1ec3d0bcee44f9e2ffd45a94a5f8c034", install = TRUE, overwrite = TRUE)
current_year = as.integer(format(Sys.Date(), "%Y"))
latest_year <- current_year
census_data <- retrieve_census_data(current_year)
#load ages
houston_ages = call_tidycensus("city", "S0101")
texas_ages = call_tidycensus("state", "S0101")
harrison_ages = call_tidycensus("county", "S0101")

houston_ages <- add_variable_names(age_variables, houston_ages)
texas_ages <- add_variable_names(age_variables, texas_ages)
harrison_ages <- add_variable_names(age_variables, harrison_ages)
total_population <- texas_ages[1,]



View(acs)