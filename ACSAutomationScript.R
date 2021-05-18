list.of.packages <- c("tidycensus", "tidyverse", "readxl")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# Prevents scientific notation
options(scipen=999)

library(tidyverse)
library(tidycensus)
library(readxl)

source("variables.R")
source("helper_functions.R")

#load census data api and set latest year
load_data()

#*******************************************#
#**Change this to add or remove geo values**#
#*******************************************#
load_geometry <- F

#load ages
print("Loading Ages...")
texas_ages_raw = call_tidycensus("state", "S0101")
harris_ages_raw = call_tidycensus("county", "S0101")
houston_ages_raw = call_tidycensus("city", "S0101")

#get total populations
texas_population <- texas_ages_raw[1,]$estimate
harris_population <- harris_ages_raw[1,]$estimate
houston_population <- houston_ages_raw %>%
  filter(variable == "S0101_C01_001") %>%
  summarize(sum(estimate)) %>%
  first()

texas_ages_cleaned <- clean_data(texas_ages_raw, age_labels)
harris_ages_cleaned <- clean_data(harris_ages_raw, age_labels)
houston_ages_cleaned <- clean_data(houston_ages_raw, age_labels)

#load poverty
print("Loading Poverty...")
texas_poverty_raw = call_tidycensus("state", "S1701")
harris_poverty_raw = call_tidycensus("county", "S1701")
houston_poverty_raw = call_tidycensus("city", "S1701")

texas_poverty_cleaned <- clean_data(texas_poverty_raw, poverty_labels)
harris_poverty_cleaned <- clean_data(harris_poverty_raw, poverty_labels)
houston_poverty_cleaned <- clean_data(houston_poverty_raw, poverty_labels)

texas_data = rbind(texas_ages_cleaned, texas_poverty_cleaned)
houston_data = rbind(houston_ages_cleaned, houston_poverty_cleaned)
harris_data = rbind(harris_ages_cleaned, harris_poverty_cleaned)

texas_data <- texas_data %>% add_row(Estimate = texas_population, Display_Label = "Total Population")
houston_data <- houston_data %>% add_row(Estimate = houston_population, Display_Label = "Total Population")
harris_data <- harris_data %>% add_row(Estimate = harris_population, Display_Label = "Total Population")

#load languages
print("Loading Languages...")
texas_languages_raw = call_tidycensus("state", "S1601")
harris_languages_raw = call_tidycensus("county", "S1601")
houston_languages_raw = call_tidycensus("city", "S1601")

texas_languages_cleaned <- clean_data(texas_languages_raw, language_labels)
harris_languages_cleaned <- clean_data(harris_languages_raw, language_labels)
houston_languages_cleaned <- clean_data(houston_languages_raw, language_labels)

texas_data = rbind(texas_data, texas_languages_cleaned)
houston_data = rbind(houston_data, harris_languages_cleaned)
harris_data = rbind(harris_data, houston_languages_cleaned)

print("Loading Opportunity Youth...")
texas_opp_youth_raw = call_tidycensus("state", "S2301")
harris_opp_youth_raw = call_tidycensus("county", "S2301")
houston_opp_youth_raw = call_tidycensus("city", "S2301")

texas_opp_youth_cleaned <- clean_data(texas_opp_youth_raw, opp_youth_labels)
harris_opp_youth_cleaned <- clean_data(harris_opp_youth_raw, opp_youth_labels)
houston_opp_youth_cleaned <- clean_data(houston_opp_youth_raw, opp_youth_labels)

texas_data = rbind(texas_data, texas_opp_youth_cleaned)
houston_data = rbind(houston_data, harris_opp_youth_cleaned)
harris_data = rbind(harris_data, houston_opp_youth_cleaned)

print("Loading  household types...")
texas_household_data_raw = call_tidycensus("state", "DP02")
harris_household_data_raw = call_tidycensus("county", "DP02")
houston_household_data_raw = call_tidycensus("city", "DP02")

# The T in these calls is to specify that it is a data profile, not a data subject set.
print("Formatting  household types...")
texas_household_type_cleaned <- clean_data(texas_household_data_raw, household_type_labels, "profile")
harris_household_type_cleaned <- clean_data(harris_household_data_raw, household_type_labels, "profile")
houston_household_type_cleaned <- clean_data(houston_household_data_raw, household_type_labels, "profile")

texas_data = rbind(texas_data, texas_household_type_cleaned)
houston_data = rbind(houston_data, harris_household_type_cleaned)
harris_data = rbind(harris_data, houston_household_type_cleaned)

print("Loading Health Care Coverage...")
texas_health_care_coverage_raw = call_tidycensus("state", "S2701")
harris_health_care_coverage_raw = call_tidycensus("county", "S2701")
houston_health_care_coverage_raw = call_tidycensus("city", "S2701")

print("Formatting Health Care Coverage...")
texas_health_care_coverage_cleaned <- clean_data(texas_health_care_coverage_raw, health_care_coverage_labels)
harris_health_care_coverage_cleaned <- clean_data(harris_health_care_coverage_raw, health_care_coverage_labels)
houston_health_care_coverage_cleaned <- clean_data(houston_health_care_coverage_raw, health_care_coverage_labels)

texas_data = rbind(texas_data, texas_health_care_coverage_cleaned)
houston_data = rbind(houston_data, harris_health_care_coverage_cleaned)
harris_data = rbind(harris_data, houston_health_care_coverage_cleaned)

texas_new_american_children_raw = call_tidycensus("state", "B05009")
harris_new_american_children_raw = call_tidycensus("county", "B05009") 
houston_new_american_children_raw = call_tidycensus("city", "B05009")

texas_new_american_children_cleaned = combine_values(texas_new_american_children_raw, new_american_children_element_variables, "New American Children")
harris_new_american_children_cleaned = combine_values(harris_new_american_children_raw, new_american_children_element_variables, "New American Children")
houston_new_american_children_cleaned = combine_values(houston_new_american_children_raw, new_american_children_element_variables, "New American Children")

texas_data = rbind(texas_data, texas_new_american_children_cleaned)
houston_data = rbind(houston_data, harris_new_american_children_cleaned)
harris_data = rbind(harris_data, houston_new_american_children_cleaned)

texas_display_data = texas_data %>%
  select(Estimate, Display_Label)
houston_display_data = houston_data %>%
  select(Estimate, Display_Label)
harris_display_data = harris_data %>%
  select(Estimate, Display_Label)

write_excel_csv2(texas_display_data, "./texas_acs5_data.csv", delim=",")
write_excel_csv2(harris_display_data, "./harris_county_acs5_data.csv", delim=",")
write_excel_csv2(houston_display_data, "./houston_acs5_data.csv", delim=",")
