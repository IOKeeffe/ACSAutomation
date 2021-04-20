list.of.packages <- c("tidycensus", "tidyverse", "R.oo", "readxl")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library(tidyverse)
library(tidycensus)
library(R.oo)
library(readxl)
source("variable_translations.R")
source("variables.R")
source("data_load.R")
source("helper_functions.R")

#load houston
houston_ages = call_tidycensus("city", "S0101")
# test <- merge(age_variables, houston_ages, by.x="age_demo_variable_names", by.y = "variable")
test <- left_join(age_variables, houston_ages, by = c("age_demo_variables" = "variable")) %>%
  select(-moe, -NAME, -GEOID) %>%
  group_by(age_demo_variables) %>%
  mutate(estimate = sum(estimate)) %>%
  distinct()

View(acs)