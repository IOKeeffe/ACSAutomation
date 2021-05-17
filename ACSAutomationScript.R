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
load_geometry <- T

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

all_populations <- data.frame(Locality = c("Texas", "Harris County", "Houston"),
                     Estimate = c(texas_population, harris_population, houston_population),
                     Label = c("Total Population", "Total Population", "Total Population"))

texas_ages_cleaned <- clean_data(texas_ages_raw, age_labels, "Texas")
harris_ages_cleaned <- clean_data(harris_ages_raw, age_labels, "Harris County")
houston_ages_cleaned <- clean_data(houston_ages_raw, age_labels, "Houston")

all_ages <- rbind(texas_ages_cleaned, harris_ages_cleaned)
all_ages <- rbind(all_ages, houston_ages_cleaned)

#load poverty
print("Loading Poverty...")
texas_poverty_raw = call_tidycensus("state", "S1701")
harris_poverty_raw = call_tidycensus("county", "S1701")
houston_poverty_raw = call_tidycensus("city", "S1701")

texas_poverty_cleaned <- clean_data(texas_poverty_raw, poverty_labels, "Texas")
harris_poverty_cleaned <- clean_data(harris_poverty_raw, poverty_labels, "Harris County")
houston_poverty_cleaned <- clean_data(houston_poverty_raw, poverty_labels, "Houston")

all_poverty <- rbind(texas_poverty_cleaned, harris_poverty_cleaned)
all_poverty <- rbind(all_poverty, houston_poverty_cleaned)

#load languages
print("Loading Languages...")
texas_languages_raw = call_tidycensus("state", "S1601")
harris_languages_raw = call_tidycensus("county", "S1601")
houston_languages_raw = call_tidycensus("city", "S1601")

texas_languages_cleaned <- clean_data(texas_languages_raw, language_labels, "Texas")
harris_languages_cleaned <- clean_data(harris_languages_raw, language_labels, "Harris County")
houston_languages_cleaned <- clean_data(houston_languages_raw, language_labels, "Houston")

all_languages <- rbind(texas_languages_cleaned, harris_languages_cleaned)
all_languages <- rbind(all_languages, houston_languages_cleaned)

print("Loading Opportunity Youth...")
texas_opp_youth_raw = call_tidycensus("state", "S2301")
harris_opp_youth_raw = call_tidycensus("county", "S2301")
houston_opp_youth_raw = call_tidycensus("city", "S2301")

texas_opp_youth_cleaned <- clean_data(texas_opp_youth_raw, opp_youth_labels, "Texas")
harris_opp_youth_cleaned <- clean_data(harris_opp_youth_raw, opp_youth_labels, "Harris County")
houston_opp_youth_cleaned <- clean_data(houston_opp_youth_raw, opp_youth_labels, "Houston")

all_opp_youth <- rbind(texas_opp_youth_cleaned, harris_opp_youth_cleaned)
all_opp_youth <- rbind(all_opp_youth, houston_opp_youth_cleaned)

print("Loading  household types...")
texas_household_data_raw = call_tidycensus("state", "DP02")
harris_household_data_raw = call_tidycensus("county", "DP02")
houston_household_data_raw = call_tidycensus("city", "DP02")

# The T in these calls is to specify that it is a data profile, not a data subject set.
print("Formatting  household types...")
texas_household_type_cleaned <- clean_data(texas_household_data_raw, household_type_labels, "Texas", "profile")
harris_household_type_cleaned <- clean_data(harris_household_data_raw, household_type_labels, "Harris County", "profile")
houston_household_type_cleaned <- clean_data(houston_household_data_raw, household_type_labels, "Houston", "profile")

all_household_type <- rbind(texas_household_type_cleaned, harris_household_type_cleaned)
all_household_type <- rbind(all_household_type, houston_household_type_cleaned)

print("Loading Health Care Coverage...")
texas_health_care_coverage_raw = call_tidycensus("state", "S2701")
harris_health_care_coverage_raw = call_tidycensus("county", "S2701")
houston_health_care_coverage_raw = call_tidycensus("city", "S2701")

print("Formatting Health Care Coverage...")
texas_health_care_coverage_cleaned <- clean_data(texas_health_care_coverage_raw, health_care_coverage_labels, "Texas")
harris_health_care_coverage_cleaned <- clean_data(harris_health_care_coverage_raw, health_care_coverage_labels, "Harris County")
houston_health_care_coverage_cleaned <- clean_data(houston_health_care_coverage_raw, health_care_coverage_labels, "Houston")

all_health_care_coverage <- rbind(texas_health_care_coverage_cleaned, harris_health_care_coverage_cleaned)
all_health_care_coverage <- rbind(all_health_care_coverage, houston_health_care_coverage_cleaned)

# first row is total, multiply percent by total and add
texas_new_american_children_raw = call_tidycensus("state", "B05009")
harris_new_american_children_raw = call_tidycensus("county", "B05009") 
houston_new_american_children_raw = call_tidycensus("city", "B05009")

texas_new_american_children_cleaned = combine_values(texas_new_american_children_raw, new_american_children_element_variables, "New American Children")
harris_new_american_children_cleaned = combine_values(harris_new_american_children_raw, new_american_children_element_variables, "New American Children")
houston_new_american_children_cleaned = combine_values(houston_new_american_children_raw, new_american_children_element_variables, "New American Children")

all_data <- rbind(all_populations, all_ages)
all_data <- rbind(all_data, all_health_care_coverage)
all_data <- rbind(all_data, all_household_type)
all_data <- rbind(all_data, all_languages)
all_data <- rbind(all_data, all_opp_youth)
all_data <- rbind(all_data, all_poverty)

write_excel_csv2(all_data, "./acs5_data.csv", delim=",")
