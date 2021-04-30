list.of.packages <- c("tidycensus", "tidyverse", "readxl")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library(tidyverse)
library(tidycensus)
library(readxl)

source("variables.R")
source("helper_functions.R")

#load census data api and set latest year
load_data()

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
ages_with_names <- add_vars(texas_population)
age_labels <- ages_with_names[2:19,]$label

texas_ages_cleaned <- clean_data(texas_ages_raw, age_labels)
harrison_ages_cleaned <- clean_data(harrison_ages_raw, age_labels)
houston_ages_cleaned <- clean_data(houston_ages_raw, age_labels)

#load poverty
texas_poverty_raw = call_tidycensus("state", "S1701")
harrison_poverty_raw = call_tidycensus("county", "S1701")
houston_poverty_raw = call_tidycensus("city", "S1701")

texas_poverty_cleaned <- clean_data(texas_poverty_raw, poverty_labels)
harrison_poverty_cleaned <- clean_data(harrison_poverty_raw, poverty_labels)
houston_poverty_cleaned <- clean_data(houston_poverty_raw, poverty_labels)


#load languages
texas_languages_raw = call_tidycensus("state", "S1601")
harrison_languages_raw = call_tidycensus("county", "S1601")
houston_languages_raw = call_tidycensus("city", "S1601")

texas_languages_cleaned <- clean_data(texas_languages_raw, language_labels)
harrison_languages_cleaned <- clean_data(harrison_languages_raw, language_labels)
houston_languages_cleaned <- clean_data(houston_languages_raw, language_labels)

#load opportunity youth
texas_opp_youth_raw = call_tidycensus("state", "S2301")
harrison_opp_youth_raw = call_tidycensus("county", "S2301")
houston_opp_youth_raw = call_tidycensus("city", "S2301")

texas_opp_youth_cleaned <- clean_data(texas_opp_youth_raw, opp_youth_labels)
harrison_opp_youth_cleaned <- clean_data(harrison_opp_youth_raw, opp_youth_labels)
houston_opp_youth_cleaned <- clean_data(houston_opp_youth_raw, opp_youth_labels)

#load non-traditional households
texas_household_type_raw = call_tidycensus("state", "DP02")
harrison_household_type_raw = call_tidycensus("county", "S2301")
houston_household_type_raw = call_tidycensus("city", "S2301")

view(add_vars(texas_household_type_raw, T))

texas_household_type_cleaned <- clean_data(texas_household_type_raw, household_type_labels, T)
harrison_household_type_cleaned <- clean_data(harrison_household_type_raw, household_type_labels, T)
houston_household_type_cleaned <- clean_data(houston_household_type_raw, household_type_labels, T)