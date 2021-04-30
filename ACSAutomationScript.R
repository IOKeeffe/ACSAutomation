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
census_data <- retrieve_census_data(current_year)
variable_names <- tidycensus::load_variables(latest_year, "acs5/subject", cache = T)

#load ages
texas_ages_raw = call_tidycensus("state", "S0101")
harrison_ages_raw = call_tidycensus("county", "S0101")
houston_ages_raw = call_tidycensus("city", "S0101")

#get total populations
texas_population <- texas_ages_raw[1,]$estimate
harrison_population <- harrison_ages_raw[1,]$estimate
houston_population <- houston_ages_raw %>%
  filter(variable == "S0101_C01_001") %>%
  summarize(sum(estimate)) %>%
  first()

# pull required age variables, combine with data, and return estimates
ages_with_names <- left_join(texas_ages_raw, variable_names, by = c("variable" = "name"))
age_labels <- ages_with_names[2:19,]$label

texas_ages_cleaned <- clean_data(texas_ages_raw, age_labels)
harrison_ages_cleaned <- clean_data(harrison_ages_raw, age_labels)
houston_ages_cleaned <- clean_data(houston_ages_raw, age_labels)


#load languages
#load ages
texas_languages_raw = call_tidycensus("state", "S1601")
harrison_languages_raw = call_tidycensus("county", "S1601")
houston_languages_raw = call_tidycensus("city", "S1601")

texas_languages_cleaned <- clean_data(texas_languages_raw, language_labels)
harrison_languages_cleaned <- clean_data(harrison_languages_raw, language_labels)
houston_languages_cleaned <- clean_data(houston_languages_raw, language_labels)

#load opportunity youth
languages <- call_tidycensus("state", "C14005")
languages <- add_variable_names(languages)
languages <- languages %>%
  filter(label %in% language_labels)